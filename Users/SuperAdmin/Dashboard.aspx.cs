using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TasteNet.Users.SuperAdmin
{
    public partial class Dashboard : System.Web.UI.Page
    {
        private string connStr = ConfigurationManager.ConnectionStrings["TasteNetDB"].ConnectionString;

        private string SelectedPeriod
        {
            get { return string.IsNullOrEmpty(hdnPeriod.Value) ? "Monthly" : hdnPeriod.Value; }
        }

        private DateTime SelectedDateFrom
        {
            get
            {
                DateTime d;
                return DateTime.TryParse(hdnDateFrom.Value, out d) ? d.Date : DateTime.Today.AddDays(-30);
            }
        }

        private DateTime SelectedDateTo
        {
            get
            {
                DateTime d;
                return DateTime.TryParse(hdnDateTo.Value, out d) ? d.Date : DateTime.Today;
            }
        }

        private int SelectedDays
        {
            get
            {
                switch (SelectedPeriod)
                {
                    case "Daily": return 1;
                    case "Weekly": return 7;
                    case "Custom": return (SelectedDateTo - SelectedDateFrom).Days + 1;
                    default: return 30;
                }
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                hdnPeriod.Value = "Monthly";
                LoadDashboard();
                LoadQuotaModal();
            }
        }

        protected void btnPeriod_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            hdnPeriod.Value = btn.CommandArgument;
            // Clear custom range when switching to preset periods
            hdnDateFrom.Value = "";
            hdnDateTo.Value = "";
            LoadDashboard();
        }

        protected void btnCustomRange_Click(object sender, EventArgs e)
        {
            // Only load if the JS flagged an apply (hdnApplyRange = "1")
            if (hdnApplyRange.Value != "1") return;

            hdnPeriod.Value = "Custom";
            hdnApplyRange.Value = "0";
            LoadDashboard();
        }

        // ── SAVE QUOTA ────────────────────────────────────────────────────────────────

        protected void btnSaveQuota_Click(object sender, EventArgs e)
        {
            DateTime s, en;
            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();
                GetCurrentPeriodDates("Daily", out s, out en); SaveOrUpdateQuota(con, "Daily", txtDailyQuota.Text, s, en);
                GetCurrentPeriodDates("Weekly", out s, out en); SaveOrUpdateQuota(con, "Weekly", txtWeeklyQuota.Text, s, en);
                GetCurrentPeriodDates("Monthly", out s, out en); SaveOrUpdateQuota(con, "Monthly", txtMonthlyQuota.Text, s, en);
            }
            LoadDashboard();
            LoadQuotaModal();
            hdnQuotaSaved.Value = "1";
        }

        private void SaveOrUpdateQuota(SqlConnection con, string quotaType, string amountText, DateTime start, DateTime end)
        {
            decimal amount;
            if (!decimal.TryParse(amountText, out amount)) return;

            string sql = @"
                IF EXISTS (SELECT 1 FROM Quotas WHERE QuotaType = @QuotaType)
                    UPDATE Quotas 
                       SET TargetAmount = @Amount,
                           StartDate    = @Start,
                           EndDate      = @End,
                           UpdatedAt    = GETDATE()
                     WHERE QuotaType = @QuotaType
                ELSE
                    INSERT INTO Quotas (QuotaType, TargetAmount, StartDate, EndDate)
                    VALUES (@QuotaType, @Amount, @Start, @End)";

            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                cmd.Parameters.AddWithValue("@QuotaType", quotaType);
                cmd.Parameters.AddWithValue("@Amount", amount);
                cmd.Parameters.AddWithValue("@Start", start);
                cmd.Parameters.AddWithValue("@End", end);
                cmd.ExecuteNonQuery();
            }
        }

        // ── LOAD QUOTA MODAL VALUES ───────────────────────────────────────────────────

        private void LoadQuotaModal()
        {
            string sql = "SELECT QuotaType, TargetAmount FROM Quotas WHERE QuotaType IN ('Daily','Weekly','Monthly')";
            DataTable dt = GetDataTable(sql);

            txtDailyQuota.Text = "0";
            txtWeeklyQuota.Text = "0";
            txtMonthlyQuota.Text = "0";

            foreach (DataRow row in dt.Rows)
            {
                string type = row["QuotaType"].ToString();
                string amount = Convert.ToDecimal(row["TargetAmount"]).ToString("F2");

                if (type == "Daily") txtDailyQuota.Text = amount;
                if (type == "Weekly") txtWeeklyQuota.Text = amount;
                if (type == "Monthly") txtMonthlyQuota.Text = amount;
            }
        }

        private void LoadDashboard()
        {
            LoadStatCards();
            LoadTopMeals();
            LoadRecentOrders();
            LoadRevenueChart();

            btnToday.CssClass = SelectedPeriod == "Daily" ? "chart-btn active" : "chart-btn";
            btn7Days.CssClass = SelectedPeriod == "Weekly" ? "chart-btn active" : "chart-btn";
            btn30Days.CssClass = SelectedPeriod == "Monthly" ? "chart-btn active" : "chart-btn";
            btnCustomRange.CssClass = SelectedPeriod == "Custom" ? "chart-btn custom-active" : "chart-btn";
        }

        // ── STAT CARDS ────────────────────────────────────────────────────────────────

        private void LoadStatCards()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();

                string dateFilter = GetDateFilter("WHERE");

                string sqlOrders = "SELECT COUNT(*) FROM Tickets " + dateFilter;
                lblTotalOrders.Text = ExecuteScalar(con, sqlOrders).ToString();

                lblPeriodOrders.Text = GetPeriodLabel();
                lblPeriodRevenue.Text = GetPeriodLabel();

                string sqlRevenue = "SELECT ISNULL(SUM(TotalAmount),0) FROM Tickets " + dateFilter;
                decimal revenue = Convert.ToDecimal(ExecuteScalar(con, sqlRevenue));
                lblTotalRevenue.Text = "₱" + revenue.ToString("N2");

                string sqlUsers = "SELECT COUNT(*) FROM Users WHERE UserType = 'Customer' AND IsActive = 1";
                lblActiveUsers.Text = ExecuteScalar(con, sqlUsers).ToString();

                // Quota card — use saved period dates so target matches what was set
                string statPeriod = SelectedPeriod == "Custom" ? "Daily" : SelectedPeriod;
                QuotaInfo qi = GetQuotaInfo(statPeriod);
                decimal activeTarget = qi.Amount;

                // Current sales for the same period (reuse dateFilter already set above)
                string sqlCurrentSales = "SELECT ISNULL(SUM(TotalAmount),0) FROM Tickets " + dateFilter;
                decimal currentSales = Convert.ToDecimal(ExecuteScalar(con, sqlCurrentSales));

                // Percentage
                decimal pct = activeTarget > 0 ? Math.Round((currentSales / activeTarget) * 100, 1) : 0;
                bool isOver = pct >= 100;

                lblActiveQuotaAmount.Text = "₱" + activeTarget.ToString("N2");
                lblQuotaCurrent.Text = "₱" + currentSales.ToString("N2");
                lblQuotaPct.Text = (isOver ? "✓ " : "") + pct.ToString("F1") + "%";
                lblQuotaPctSmall.Text = pct.ToString("F1") + "%";
                hdnQuotaPct.Value = Math.Min(pct, 100).ToString("F1");
                lblActiveQuotaType.Text = SelectedPeriod;

                // Color the % label green when over target
                lblQuotaPct.CssClass = isOver ? "quota-pct over" : "quota-pct";
            }
        }

        // ── TOP SELLING MEALS ─────────────────────────────────────────────────────────

        private void LoadTopMeals()
        {
            string dateFilter = GetDateFilter("AND t.");

            string sql = @"
                SELECT TOP 5
                    ti.FoodName,
                    SUM(ti.Quantity) AS TotalOrders,
                    SUM(ti.SubTotal) AS TotalSales
                FROM TicketItems ti
                INNER JOIN Tickets t ON ti.TicketID = t.TicketID
                WHERE 1=1 " + dateFilter + @"
                GROUP BY ti.FoodName
                ORDER BY TotalOrders DESC";

            DataTable dt = GetDataTable(sql);
            rptTopMeals.DataSource = dt;
            rptTopMeals.DataBind();
        }

        // ── RECENT ORDERS ─────────────────────────────────────────────────────────────

        private void LoadRecentOrders()
        {
            string dateFilter = GetDateFilter("AND t.");

            string sql = @"
                SELECT TOP 10
                    t.TicketID,
                    t.TicketNumber,
                    t.OrderType                         AS PaymentMethod,
                    ISNULL(u.FullName, 'Unknown')       AS CustomerName,
                    t.TotalAmount,
                    t.Status,
                    t.Priority,
                    t.CreatedAt,
                    (SELECT TOP 1 ti.FoodName + ' x' + CAST(ti.Quantity AS VARCHAR)
                     FROM TicketItems ti WHERE ti.TicketID = t.TicketID) AS FirstItem,
                    (SELECT COUNT(*) FROM TicketItems ti WHERE ti.TicketID = t.TicketID) AS ItemCount
                FROM Tickets t
                LEFT JOIN Users u ON u.UserID = TRY_CAST(t.CreatedBy AS INT)
                WHERE 1=1 " + dateFilter + @"
                AND t.Status = 'Completed'
                ORDER BY t.CreatedAt DESC";

            DataTable dt = GetDataTable(sql);
            rptRecentOrders.DataSource = dt;
            rptRecentOrders.DataBind();
        }

        // ── REVENUE CHART ─────────────────────────────────────────────────────────────

        private void LoadRevenueChart()
        {
            string dateFilter = GetDateFilter("WHERE");

            string sql = @"
                SELECT 
                    CONVERT(VARCHAR(10), CreatedAt, 101) AS DateLabel,
                    ISNULL(SUM(TotalAmount), 0)          AS DailyRevenue
                FROM Tickets " + dateFilter + @"
                GROUP BY CONVERT(VARCHAR(10), CreatedAt, 101)
                ORDER BY MIN(CreatedAt)";

            DataTable dt = GetDataTable(sql);
            List<string> labels = new List<string>();
            List<string> values = new List<string>();

            foreach (DataRow row in dt.Rows)
            {
                labels.Add("\"" + row["DateLabel"] + "\"");
                values.Add(row["DailyRevenue"].ToString());
            }

            hdnChartLabels.Value = "[" + string.Join(",", labels) + "]";
            hdnChartData.Value = "[" + string.Join(",", values) + "]";

            // Quota dashed line — per-day target based on actual saved period length
            string quotaPeriod = SelectedPeriod == "Custom" ? "Daily" : SelectedPeriod;
            QuotaInfo qi = GetQuotaInfo(quotaPeriod);
            decimal quotaPerDay = qi.Amount > 0 ? Math.Round(qi.Amount / qi.PeriodDays, 2) : 0;

            hdnQuotaTarget.Value = quotaPerDay.ToString("F2");
            lblQuotaPeriod.Text = quotaPeriod + " target (₱"
                                 + qi.Amount.ToString("N2") + " over "
                                 + qi.PeriodDays + " day" + (qi.PeriodDays == 1 ? "" : "s")
                                 + ", ₱" + quotaPerDay.ToString("N2") + "/day)";
        }

        // ── HELPERS ───────────────────────────────────────────────────────────────────

        private string GetPeriodLabel()
        {
            if (SelectedPeriod == "Custom")
                return SelectedDateFrom.ToString("MMM dd") + " – " + SelectedDateTo.ToString("MMM dd, yyyy");

            QuotaInfo q = GetQuotaInfo(SelectedPeriod);
            if (!q.IsSet)
            {
                switch (SelectedPeriod)
                {
                    case "Daily": return "today";
                    case "Weekly": return "last 7 days";
                    default: return "last 30 days";
                }
            }
            // Show the actual saved period dates, e.g. "May 01 – May 31, 2025"
            return q.StartDate.ToString("MMM dd") + " – " + q.EndDate.ToString("MMM dd, yyyy");
        }

        private string GetDateFilter(string prefix)
        {
            bool isWhere = prefix.Trim().ToUpper() == "WHERE";

            // Custom range — use the picker dates directly
            if (SelectedPeriod == "Custom")
            {
                string from = SelectedDateFrom.ToString("yyyy-MM-dd");
                string to = SelectedDateTo.ToString("yyyy-MM-dd");
                return isWhere
                    ? string.Format("WHERE CAST(CreatedAt AS DATE) BETWEEN '{0}' AND '{1}'", from, to)
                    : string.Format("AND CAST(t.CreatedAt AS DATE) BETWEEN '{0}' AND '{1}'", from, to);
            }

            // Preset periods — use the actual StartDate/EndDate saved in the Quotas table
            QuotaInfo q = GetQuotaInfo(SelectedPeriod);
            string qFrom = q.StartDate.ToString("yyyy-MM-dd");
            string qTo = q.EndDate.ToString("yyyy-MM-dd");

            return isWhere
                ? string.Format("WHERE CAST(CreatedAt AS DATE) BETWEEN '{0}' AND '{1}'", qFrom, qTo)
                : string.Format("AND CAST(t.CreatedAt AS DATE) BETWEEN '{0}' AND '{1}'", qFrom, qTo);
        }

        // Holds a quota row's key fields
        private class QuotaInfo
        {
            public decimal Amount { get; set; }
            public DateTime StartDate { get; set; }
            public DateTime EndDate { get; set; }
            public bool IsSet { get; set; }

            // How many days the quota spans (minimum 1)
            public int PeriodDays
            {
                get { return Math.Max(1, (EndDate.Date - StartDate.Date).Days + 1); }
            }
        }

        // Returns the correct start/end dates for a period based on TODAY — never stale
        private void GetCurrentPeriodDates(string period, out DateTime start, out DateTime end)
        {
            switch (period)
            {
                case "Daily":
                    start = DateTime.Today;
                    end = DateTime.Today;
                    break;
                case "Weekly":
                    int dow = (int)DateTime.Today.DayOfWeek; // 0=Sun … 6=Sat
                    int daysToMon = (dow == 0) ? -6 : 1 - dow;
                    start = DateTime.Today.AddDays(daysToMon);
                    end = start.AddDays(6);
                    break;
                default: // Monthly
                    start = new DateTime(DateTime.Today.Year, DateTime.Today.Month, 1);
                    end = start.AddMonths(1).AddDays(-1);
                    break;
            }
        }

        private QuotaInfo GetQuotaInfo(string period)
        {
            // Always use today's correct period dates — never trust the DB dates
            DateTime periodStart, periodEnd;
            GetCurrentPeriodDates(period, out periodStart, out periodEnd);

            string sql = "SELECT ISNULL(TargetAmount, 0) FROM Quotas WHERE QuotaType = @QuotaType";

            using (SqlConnection con = new SqlConnection(connStr))
            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                con.Open();
                cmd.Parameters.AddWithValue("@QuotaType", period);
                object result = cmd.ExecuteScalar();
                decimal amount = (result == null || result == DBNull.Value) ? 0 : Convert.ToDecimal(result);

                return new QuotaInfo
                {
                    Amount = amount,
                    StartDate = periodStart,
                    EndDate = periodEnd,
                    IsSet = amount > 0
                };
            }
        }

        // Keep old helper for callers that only need the amount
        private decimal GetQuotaTarget(string period)
        {
            return GetQuotaInfo(period).Amount;
        }

        protected string GetStatusCss(string status)
        {
            if (string.IsNullOrEmpty(status)) return "badge-pending";
            switch (status.ToUpper())
            {
                case "COMPLETED": return "badge-completed";
                case "DELIVERED": return "badge-completed";
                case "PENDING": return "badge-pending";
                case "IN PROGRESS": return "badge-progress";
                case "CANCELLED": return "badge-cancelled";
                default: return "badge-pending";
            }
        }

        private object ExecuteScalar(SqlConnection con, string sql)
        {
            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                object result = cmd.ExecuteScalar();
                return (result == null || result == DBNull.Value) ? 0 : result;
            }
        }

        private DataTable GetDataTable(string sql)
        {
            DataTable dt = new DataTable();
            using (SqlConnection con = new SqlConnection(connStr))
            using (SqlCommand cmd = new SqlCommand(sql, con))
            using (SqlDataAdapter da = new SqlDataAdapter(cmd))
            {
                da.Fill(dt);
            }
            return dt;
        }
    }
}