using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace TasteNet.Users.Rider
{
    public partial class Dashboard : System.Web.UI.Page
    {
        private readonly string _connStr =
            System.Web.Configuration.WebConfigurationManager
                  .ConnectionStrings["TasteNetDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // ── Handle complete-ticket AJAX GET ──────────────────────────────
            // JS fetches ?completeTicket=XXX — we update DB, respond "OK"
            string ticketToComplete = Request.QueryString["completeTicket"];
            if (!string.IsNullOrEmpty(ticketToComplete))
            {
                CompleteTicketInDb(ticketToComplete);

                Response.Clear();
                Response.ContentType = "text/plain";
                Response.Write("OK");
                Response.End();
                return;
            }
            // ─────────────────────────────────────────────────────────────────

            if (!IsPostBack)
            {
                LoadStats();
                LoadDeliveryTickets();
            }
        }

        // ── Mark ticket Completed ────────────────────────────────────────────────

        private void CompleteTicketInDb(string ticketNumber)
        {
            string sql = @"
                UPDATE Tickets
                SET    Status      = 'Completed',
                       CompletedAt = GETDATE(),
                       UpdatedAt   = GETDATE()
                WHERE  TicketNumber = @TicketNumber";

            using (SqlConnection con = new SqlConnection(_connStr))
            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                cmd.Parameters.AddWithValue("@TicketNumber", ticketNumber);
                con.Open();
                cmd.ExecuteNonQuery();
            }
        }

        // ── Stats ────────────────────────────────────────────────────────────────

        private void LoadStats()
        {
            string sql = @"
                -- All-time totals (used as 'today' display values)
                SELECT
                    COUNT(*)                                                      AS TotalToday,
                    ISNULL(SUM(CASE WHEN LTRIM(RTRIM(LOWER(Status))) = 'completed' THEN TotalAmount ELSE 0 END), 0)
                                                                                  AS EarningsToday,
                    COUNT(CASE WHEN LTRIM(RTRIM(LOWER(Status))) = 'completed' THEN 1 END) AS CompletedToday,
                    COUNT(CASE WHEN LTRIM(RTRIM(LOWER(Status))) = 'pending'   THEN 1 END) AS PendingToday
                FROM Tickets
                WHERE LTRIM(RTRIM(LOWER(OrderType))) = 'delivery';

                -- Yesterday for trend comparison
                SELECT
                    COUNT(*)                                                      AS TotalYest,
                    ISNULL(SUM(CASE WHEN LTRIM(RTRIM(LOWER(Status))) = 'completed' THEN TotalAmount ELSE 0 END), 0)
                                                                                  AS EarningsYest,
                    COUNT(CASE WHEN LTRIM(RTRIM(LOWER(Status))) = 'completed' THEN 1 END) AS CompletedYest,
                    COUNT(CASE WHEN LTRIM(RTRIM(LOWER(Status))) = 'pending'   THEN 1 END) AS PendingYest
                FROM Tickets
                WHERE LTRIM(RTRIM(LOWER(OrderType))) = 'delivery'
                  AND CAST(CreatedAt AS DATE) = CAST(DATEADD(DAY, -1, GETDATE()) AS DATE);";

            using (SqlConnection con = new SqlConnection(_connStr))
            using (SqlCommand cmd = new SqlCommand(sql, con))
            using (SqlDataAdapter da = new SqlDataAdapter(cmd))
            {
                DataSet ds = new DataSet();
                con.Open();
                da.Fill(ds);

                DataRow today = ds.Tables[0].Rows[0];
                int totalToday = Convert.ToInt32(today["TotalToday"]);
                decimal earningsToday = Convert.ToDecimal(today["EarningsToday"]);
                int completedToday = Convert.ToInt32(today["CompletedToday"]);
                int pendingToday = Convert.ToInt32(today["PendingToday"]);

                DataRow yest = ds.Tables[1].Rows[0];
                int totalYest = Convert.ToInt32(yest["TotalYest"]);
                decimal earningsYest = Convert.ToDecimal(yest["EarningsYest"]);
                int completedYest = Convert.ToInt32(yest["CompletedYest"]);
                int pendingYest = Convert.ToInt32(yest["PendingYest"]);

                litTotalDeliveries.Text = totalToday.ToString("N0");
                litEarningsToday.Text = earningsToday.ToString("N2");
                litCompletedToday.Text = completedToday.ToString("N0");
                litPending.Text = pendingToday.ToString("N0");

                litTrendTotalDeliveries.Text = BuildTrendHtml(totalToday, totalYest, "vs yesterday");
                litTrendEarningsToday.Text = BuildTrendHtml(earningsToday, earningsYest, "vs yesterday");
                litTrendCompletedToday.Text = BuildTrendHtml(completedToday, completedYest, "vs yesterday");
                litTrendPending.Text = BuildPendingTrendHtml(pendingToday, pendingYest);
            }
        }

        private string BuildTrendHtml(decimal today, decimal yesterday, string label)
        {
            if (yesterday == 0)
                return "<i class='fas fa-minus'></i> No data yesterday";

            decimal pct = Math.Round((today - yesterday) / yesterday * 100, 1);
            bool up = pct >= 0;
            string arrow = up ? "fa-arrow-up" : "fa-arrow-down";
            string sign = up ? "+" : "";
            return $"<i class='fas {arrow}'></i> {sign}{pct}% {label}";
        }

        private string BuildPendingTrendHtml(int today, int yesterday)
        {
            if (yesterday == 0) return "<i class='fas fa-minus'></i> No data yesterday";
            int diff = today - yesterday;
            if (diff == 0) return "<i class='fas fa-minus'></i> Same as yesterday";
            if (diff < 0) return $"<i class='fas fa-arrow-down'></i> {Math.Abs(diff)} fewer than yesterday";
            return $"<i class='fas fa-arrow-up'></i> +{diff} more than yesterday";
        }

        // ── Delivery Tickets Repeater ────────────────────────────────────────────

        private void LoadDeliveryTickets()
        {
            string sql = @"
                SELECT  TicketNumber,
                        OrderNumber,
                        OrderType,
                        DeliveryAddress,
                        Status,
                        Priority,
                        TotalAmount,
                        CreatedAt,
                        StartedAt,
                        CompletedAt,
                        CreatedBy,
                        UpdatedAt
                FROM    Tickets
                WHERE   LTRIM(RTRIM(LOWER(OrderType))) = 'delivery'
                  AND   LTRIM(RTRIM(LOWER(Status)))   <> 'completed'
                ORDER BY CreatedAt DESC";

            using (SqlConnection con = new SqlConnection(_connStr))
            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                con.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptDeliveries.DataSource = dt;
                rptDeliveries.DataBind();
            }
        }

        protected string GetStatusCss(string status)
        {
            switch ((status ?? string.Empty).ToLower())
            {
                case "pending": return "status-pending";
                case "active":
                case "started": return "status-active";
                case "completed": return "status-completed";
                default: return "status-pending";
            }
        }
    }
}
