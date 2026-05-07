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

        private int SelectedDays
        {
            get
            {
                switch (SelectedPeriod)
                {
                    case "Daily": return 1;
                    case "Weekly": return 7;
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
            LoadDashboard();
        }

        // ── SAVE QUOTA ────────────────────────────────────────────────────────────────

        protected void btnSaveQuota_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();

                SaveOrUpdateQuota(con, "Daily", txtDailyQuota.Text, DateTime.Today, DateTime.Today);
                SaveOrUpdateQuota(con, "Weekly", txtWeeklyQuota.Text, DateTime.Today, DateTime.Today.AddDays(6));
                SaveOrUpdateQuota(con, "Monthly", txtMonthlyQuota.Text, DateTime.Today, DateTime.Today.AddDays(29));
            }

            LoadDashboard();
            LoadQuotaModal();

            // Pass success flag to JS to close modal and show toast
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

                // Quota card — target amount for current period
                string sqlActiveQuota = "SELECT ISNULL(TargetAmount,0) FROM Quotas WHERE QuotaType = @QuotaType";
                decimal activeTarget = 0;
                using (SqlCommand cmd = new SqlCommand(sqlActiveQuota, con))
                {
                    cmd.Parameters.AddWithValue("@QuotaType", SelectedPeriod);
                    object res = cmd.ExecuteScalar();
                    activeTarget = (res == null || res == DBNull.Value) ? 0 : Convert.ToDecimal(res);
                }

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
                    ISNULL(u.FullName, t.CreatedBy)     AS CustomerName,
                    t.TotalAmount,
                    t.Status,
                    t.Priority,
                    t.CreatedAt,
                    (SELECT TOP 1 ti.FoodName + ' x' + CAST(ti.Quantity AS VARCHAR)
                     FROM TicketItems ti WHERE ti.TicketID = t.TicketID) AS FirstItem,
                    (SELECT COUNT(*) FROM TicketItems ti WHERE ti.TicketID = t.TicketID) AS ItemCount
                FROM Tickets t
                LEFT JOIN Users u ON CAST(u.Username AS NVARCHAR) = CAST(t.CreatedBy AS NVARCHAR)
                WHERE 1=1 " + dateFilter + @"
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

            // Quota target for dashed line on chart
            // Daily   → each day's target is the daily quota
            // Weekly  → total weekly quota spread across the 7 days shown
            // Monthly → total monthly quota spread across the 30 days shown
            decimal quotaTotal = GetQuotaTarget(SelectedPeriod);
            decimal quotaPerDay = 0;
            if (quotaTotal > 0)
            {
                switch (SelectedPeriod)
                {
                    case "Daily": quotaPerDay = quotaTotal; break;
                    case "Weekly": quotaPerDay = Math.Round(quotaTotal / 7, 2); break;
                    default: quotaPerDay = Math.Round(quotaTotal / 30, 2); break;
                }
            }
            hdnQuotaTarget.Value = quotaPerDay.ToString("F2");
            lblQuotaPeriod.Text = SelectedPeriod + " target (₱"
                                    + quotaTotal.ToString("N2") + " total, ₱"
                                    + quotaPerDay.ToString("N2") + "/day)";
        }

        // ── HELPERS ───────────────────────────────────────────────────────────────────

        private string GetPeriodLabel()
        {
            switch (SelectedPeriod)
            {
                case "Daily": return "today";
                case "Weekly": return "last 7 days";
                default: return "last 30 days";
            }
        }

        private string GetDateFilter(string prefix)
        {
            // prefix is either "WHERE" (standalone) or "AND t." (joined query)
            bool isWhere = prefix.Trim().ToUpper() == "WHERE";
            string col = isWhere ? "CreatedAt" : "CreatedAt";
            switch (SelectedPeriod)
            {
                case "Daily":
                    return isWhere
                        ? "WHERE CAST(CreatedAt AS DATE) = CAST(GETDATE() AS DATE)"
                        : "AND CAST(t.CreatedAt AS DATE) = CAST(GETDATE() AS DATE)";
                case "Weekly":
                    return isWhere
                        ? "WHERE CreatedAt >= DATEADD(DAY, -7, GETDATE())"
                        : "AND t.CreatedAt >= DATEADD(DAY, -7, GETDATE())";
                default:
                    return isWhere
                        ? "WHERE CreatedAt >= DATEADD(DAY, -30, GETDATE())"
                        : "AND t.CreatedAt >= DATEADD(DAY, -30, GETDATE())";
            }
        }

        private decimal GetQuotaTarget(string period)
        {
            string sql = "SELECT ISNULL(TargetAmount,0) FROM Quotas WHERE QuotaType = @QuotaType";
            using (SqlConnection con = new SqlConnection(connStr))
            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                con.Open();
                cmd.Parameters.AddWithValue("@QuotaType", period);
                object result = cmd.ExecuteScalar();
                return (result == null || result == DBNull.Value) ? 0 : Convert.ToDecimal(result);
            }
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
