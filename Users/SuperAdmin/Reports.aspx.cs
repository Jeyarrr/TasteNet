using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TasteNet.Users.SuperAdmin
{
    public partial class Reports : System.Web.UI.Page
    {
        // ── Connection string ────────────────────────────────────────────────────
        private static readonly string ConnStr =
            System.Configuration.ConfigurationManager.ConnectionStrings["TasteNetDB"].ConnectionString;

        // ════════════════════════════════════════════════════════════════════════
        //  PAGE LOAD
        // ════════════════════════════════════════════════════════════════════════
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                LoadAllData();
        }

        protected void ddlDateRange_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadAllData();
        }

        // ════════════════════════════════════════════════════════════════════════
        //  MASTER LOADER
        // ════════════════════════════════════════════════════════════════════════
        private void LoadAllData()
        {
            int days = int.Parse(ddlDateRange.SelectedValue);
            DateTime cutoff = DateTime.Today.AddDays(-days);

            using (SqlConnection conn = new SqlConnection(ConnStr))
            {
                conn.Open();
                LoadKpiCards(conn, cutoff);
                LoadRevenueTrend(conn, cutoff, days);       // monthly (default)
                LoadWeeklyTrend(conn, cutoff);              // weekly grouped by selected period
                LoadYearlyTrend(conn, cutoff);              // yearly grouped by selected period
                LoadOrderStatusDistribution(conn, cutoff);
                LoadOrdersByTimeOfDay(conn, cutoff);
                LoadTopSellingMeals(conn, cutoff);
                LoadPopularMenuItems(conn, cutoff);
            }
        }

        // ════════════════════════════════════════════════════════════════════════
        //  1. KPI CARDS
        // ════════════════════════════════════════════════════════════════════════
        private void LoadKpiCards(SqlConnection conn, DateTime cutoff)
        {
            using (SqlCommand cmd = new SqlCommand(
                "SELECT COUNT(*) FROM Tickets WHERE CreatedAt >= @cutoff", conn))
            {
                cmd.Parameters.AddWithValue("@cutoff", cutoff);
                lblTotalOrders.Text = ((int)cmd.ExecuteScalar()).ToString("N0");
            }

            using (SqlCommand cmd = new SqlCommand(
                "SELECT ISNULL(SUM(TotalAmount),0) FROM Tickets WHERE CreatedAt >= @cutoff", conn))
            {
                cmd.Parameters.AddWithValue("@cutoff", cutoff);
                lblTotalRevenue.Text = "₱" + FormatShort((decimal)cmd.ExecuteScalar());
            }

            using (SqlCommand cmd = new SqlCommand(
                "SELECT ISNULL(AVG(TotalAmount),0) FROM Tickets WHERE CreatedAt >= @cutoff", conn))
            {
                cmd.Parameters.AddWithValue("@cutoff", cutoff);
                lblAvgOrderValue.Text = "₱" + ((decimal)cmd.ExecuteScalar()).ToString("N2");
            }

            using (SqlCommand cmd = new SqlCommand(
                "SELECT COUNT(*) FROM Users WHERE UserType='Customer' AND CreatedAt >= @cutoff", conn))
            {
                cmd.Parameters.AddWithValue("@cutoff", cutoff);
                lblNewCustomers.Text = ((int)cmd.ExecuteScalar()).ToString("N0");
            }
        }

        // ════════════════════════════════════════════════════════════════════════
        //  2. REVENUE & ORDERS TREND
        // ════════════════════════════════════════════════════════════════════════
        private void LoadRevenueTrend(SqlConnection conn, DateTime cutoff, int days)
        {
            string groupFmt = days <= 90
                ? "CONVERT(varchar(10), CreatedAt, 23)"
                : "CONVERT(varchar(7),  CreatedAt, 120)";

            string sql = $@"
                SELECT {groupFmt} AS Period,
                       SUM(TotalAmount) AS TotalRevenue,
                       COUNT(*)         AS TotalOrders
                FROM   Tickets WHERE CreatedAt >= @cutoff
                GROUP BY {groupFmt} ORDER BY Period";

            var labels = new List<string>();
            var revList = new List<decimal>();
            var ordList = new List<int>();

            using (SqlCommand cmd = new SqlCommand(sql, conn))
            {
                cmd.Parameters.AddWithValue("@cutoff", cutoff);
                using (SqlDataReader dr = cmd.ExecuteReader())
                    while (dr.Read())
                    {
                        labels.Add(dr["Period"].ToString());
                        revList.Add(dr["TotalRevenue"] == DBNull.Value ? 0 : Convert.ToDecimal(dr["TotalRevenue"]));
                        ordList.Add(dr["TotalOrders"] == DBNull.Value ? 0 : Convert.ToInt32(dr["TotalOrders"]));
                    }
            }

            hfRevenueTrendLabels.Value = ToJson(labels.Select(l => $"\"{l}\""));
            hfRevenueTrendData.Value = ToJson(revList.Select(v => v.ToString("F2")));
            hfOrdersTrendData.Value = ToJson(ordList.Select(v => v.ToString()));
        }

        // ════════════════════════════════════════════════════════════════════════
        //  2b. WEEKLY TREND  (grouped by week, respects date filter)
        // ════════════════════════════════════════════════════════════════════════
        private void LoadWeeklyTrend(SqlConnection conn, DateTime cutoff)
        {
            string sql = @"
                SELECT
                    CAST(DATEPART(YEAR, CreatedAt) AS varchar) + '-W'
                    + RIGHT('0' + CAST(DATEPART(WEEK, CreatedAt) AS varchar), 2) AS Period,
                    SUM(TotalAmount) AS TotalRevenue,
                    COUNT(*)         AS TotalOrders
                FROM   Tickets
                WHERE  CreatedAt >= @cutoff
                GROUP BY DATEPART(YEAR, CreatedAt), DATEPART(WEEK, CreatedAt)
                ORDER BY DATEPART(YEAR, CreatedAt), DATEPART(WEEK, CreatedAt)";

            var labels = new List<string>();
            var revList = new List<decimal>();
            var ordList = new List<int>();

            using (SqlCommand cmd = new SqlCommand(sql, conn))
            {
                cmd.Parameters.AddWithValue("@cutoff", cutoff);
                using (SqlDataReader dr = cmd.ExecuteReader())
                    while (dr.Read())
                    {
                        labels.Add(dr["Period"].ToString());
                        revList.Add(dr["TotalRevenue"] == DBNull.Value ? 0 : Convert.ToDecimal(dr["TotalRevenue"]));
                        ordList.Add(dr["TotalOrders"] == DBNull.Value ? 0 : Convert.ToInt32(dr["TotalOrders"]));
                    }
            }

            hfWeeklyRevenueLabels.Value = ToJson(labels.Select(l => $"\"{l}\""));
            hfWeeklyRevenueData.Value = ToJson(revList.Select(v => v.ToString("F2")));
            hfWeeklyOrdersData.Value = ToJson(ordList.Select(v => v.ToString()));
        }

        // ════════════════════════════════════════════════════════════════════════
        //  2c. YEARLY TREND  (grouped by month, respects date filter)
        // ════════════════════════════════════════════════════════════════════════
        private void LoadYearlyTrend(SqlConnection conn, DateTime cutoff)
        {
            string sql = @"
                SELECT
                    CONVERT(varchar(7), CreatedAt, 120) AS Period,
                    SUM(TotalAmount) AS TotalRevenue,
                    COUNT(*)         AS TotalOrders
                FROM   Tickets
                WHERE  CreatedAt >= @cutoff
                GROUP BY CONVERT(varchar(7), CreatedAt, 120)
                ORDER BY Period";

            var labels = new List<string>();
            var revList = new List<decimal>();
            var ordList = new List<int>();

            using (SqlCommand cmd = new SqlCommand(sql, conn))
            {
                cmd.Parameters.AddWithValue("@cutoff", cutoff);
                using (SqlDataReader dr = cmd.ExecuteReader())
                    while (dr.Read())
                    {
                        labels.Add(dr["Period"].ToString());
                        revList.Add(dr["TotalRevenue"] == DBNull.Value ? 0 : Convert.ToDecimal(dr["TotalRevenue"]));
                        ordList.Add(dr["TotalOrders"] == DBNull.Value ? 0 : Convert.ToInt32(dr["TotalOrders"]));
                    }
            }

            hfYearlyRevenueLabels.Value = ToJson(labels.Select(l => $"\"{l}\""));
            hfYearlyRevenueData.Value = ToJson(revList.Select(v => v.ToString("F2")));
            hfYearlyOrdersData.Value = ToJson(ordList.Select(v => v.ToString()));
        }



        // ════════════════════════════════════════════════════════════════════════
        //  3. ORDER STATUS DISTRIBUTION
        // ════════════════════════════════════════════════════════════════════════
        private void LoadOrderStatusDistribution(SqlConnection conn, DateTime cutoff)
        {
            var counts = new Dictionary<string, int>(StringComparer.OrdinalIgnoreCase);
            using (SqlCommand cmd = new SqlCommand(
                "SELECT Status, COUNT(*) AS Cnt FROM Tickets WHERE CreatedAt >= @cutoff GROUP BY Status", conn))
            {
                cmd.Parameters.AddWithValue("@cutoff", cutoff);
                using (SqlDataReader dr = cmd.ExecuteReader())
                    while (dr.Read())
                        counts[dr["Status"].ToString()] = Convert.ToInt32(dr["Cnt"]);
            }

            int completed = counts.Where(k => k.Key.Equals("Completed", StringComparison.OrdinalIgnoreCase)).Sum(k => k.Value);
            int active = counts.Where(k => k.Key.Equals("Active", StringComparison.OrdinalIgnoreCase)
                                           || k.Key.Equals("Pending", StringComparison.OrdinalIgnoreCase)).Sum(k => k.Value);
            int cancelled = counts.Where(k => k.Key.Equals("Cancelled", StringComparison.OrdinalIgnoreCase)).Sum(k => k.Value);
            int total = Math.Max(completed + active + cancelled, 1);

            hfStatusCompleted.Value = Math.Round((double)completed / total * 100, 1).ToString("F1");
            hfStatusActive.Value = Math.Round((double)active / total * 100, 1).ToString("F1");
            hfStatusCancelled.Value = Math.Round((double)cancelled / total * 100, 1).ToString("F1");
            hfStatusTotal.Value = total.ToString();

            rptStatusList.DataSource = new[]
            {
                new { Status = "Completed", Count = completed, Pct = Math.Round((double)completed / total * 100, 1) },
                new { Status = "Active",    Count = active,    Pct = Math.Round((double)active    / total * 100, 1) },
                new { Status = "Cancelled", Count = cancelled, Pct = Math.Round((double)cancelled / total * 100, 1) }
            };
            rptStatusList.DataBind();
        }

        // ════════════════════════════════════════════════════════════════════════
        //  4. ORDERS BY TIME OF DAY
        // ════════════════════════════════════════════════════════════════════════
        private void LoadOrdersByTimeOfDay(SqlConnection conn, DateTime cutoff)
        {
            int[] hourCounts = new int[24];
            using (SqlCommand cmd = new SqlCommand(@"
                SELECT DATEPART(HOUR, CreatedAt) AS Hr, COUNT(*) AS Cnt
                FROM   Tickets WHERE CreatedAt >= @cutoff
                GROUP BY DATEPART(HOUR, CreatedAt) ORDER BY Hr", conn))
            {
                cmd.Parameters.AddWithValue("@cutoff", cutoff);
                using (SqlDataReader dr = cmd.ExecuteReader())
                    while (dr.Read())
                        hourCounts[Convert.ToInt32(dr["Hr"])] = Convert.ToInt32(dr["Cnt"]);
            }

            var labels = new List<string>();
            var data = new List<int>();
            for (int h = 6; h <= 23; h++)
            {
                labels.Add(h == 12 ? "12PM" : h > 12 ? (h - 12) + "PM" : h + "AM");
                data.Add(hourCounts[h]);
            }

            hfTimeLabels.Value = ToJson(labels.Select(l => $"\"{l}\""));
            hfTimeData.Value = ToJson(data.Select(v => v.ToString()));

            if (data.Count > 0)
            {
                int peak1Idx = data.IndexOf(data.Max());
                var copy = data.ToList(); copy[peak1Idx] = -1;
                int peak2Idx = copy.IndexOf(copy.Max());
                lblPeakHours.Text = $"<i class=\"fas fa-clock\"></i> Peak hours: {labels[peak1Idx]} & {labels[peak2Idx]}";
            }
        }

        // ════════════════════════════════════════════════════════════════════════
        //  5. TOP SELLING MEALS
        // ════════════════════════════════════════════════════════════════════════
        private void LoadTopSellingMeals(SqlConnection conn, DateTime cutoff)
        {
            var rows = new List<object>();
            using (SqlCommand cmd = new SqlCommand(@"
                SELECT TOP 4 ti.FoodName, SUM(ti.SubTotal) AS Revenue
                FROM   TicketItems ti
                JOIN   Tickets     t ON t.TicketID = ti.TicketID
                WHERE  t.CreatedAt >= @cutoff
                GROUP BY ti.FoodName ORDER BY Revenue DESC", conn))
            {
                cmd.Parameters.AddWithValue("@cutoff", cutoff);
                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    var raw = new List<(string Name, decimal Rev)>();
                    decimal mx = 0;
                    while (dr.Read())
                    {
                        decimal rev = dr["Revenue"] == DBNull.Value ? 0 : Convert.ToDecimal(dr["Revenue"]);
                        raw.Add((dr["FoodName"].ToString(), rev));
                        if (rev > mx) mx = rev;
                    }
                    if (mx == 0) mx = 1;
                    foreach (var r in raw)
                        rows.Add(new
                        {
                            FoodName = r.Name,
                            Revenue = r.Rev,
                            BarPct = Math.Round((double)(r.Rev / mx) * 100, 1)
                        });
                }
            }
            rptTopMeals.DataSource = rows;
            rptTopMeals.DataBind();
        }

        // ════════════════════════════════════════════════════════════════════════
        //  6. POPULAR MENU ITEMS TABLE
        // ════════════════════════════════════════════════════════════════════════
        private void LoadPopularMenuItems(SqlConnection conn, DateTime cutoff)
        {
            using (SqlCommand cmd = new SqlCommand(@"
                SELECT TOP 20
                    ti.FoodName, m.FoodType,
                    COUNT(ti.TicketItemID) AS TotalOrders,
                    SUM(ti.SubTotal)       AS Revenue
                FROM   TicketItems ti
                JOIN   Tickets     t ON t.TicketID = ti.TicketID
                JOIN   Menu        m ON m.MenuID   = ti.MenuID
                WHERE  t.CreatedAt >= @cutoff
                GROUP BY ti.FoodName, m.FoodType ORDER BY Revenue DESC", conn))
            {
                cmd.Parameters.AddWithValue("@cutoff", cutoff);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                rptMenuItems.DataSource = dt;
                rptMenuItems.DataBind();
            }
        }

        // ════════════════════════════════════════════════════════════════════════
        //  EXPORT — EXCEL via XML Spreadsheet 2003 (no NuGet needed)
        //  Opens natively in Excel, LibreOffice, Google Sheets
        // ════════════════════════════════════════════════════════════════════════
        protected void btnExportExcel_Click(object sender, EventArgs e)
        {
            int days = int.Parse(ddlDateRange.SelectedValue);
            DateTime cutoff = DateTime.Today.AddDays(-days);
            string period = ddlDateRange.SelectedItem.Text;

            // Gather all data
            DataSet ds = GetExportData(cutoff);

            // Build XML Spreadsheet
            StringBuilder xml = new StringBuilder();
            xml.AppendLine("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
            xml.AppendLine("<?mso-application progid=\"Excel.Sheet\"?>");
            xml.AppendLine("<Workbook xmlns=\"urn:schemas-microsoft-com:office:spreadsheet\"");
            xml.AppendLine("  xmlns:ss=\"urn:schemas-microsoft-com:office:spreadsheet\"");
            xml.AppendLine("  xmlns:x=\"urn:schemas-microsoft-com:office:excel\">");

            // Styles
            xml.AppendLine("<Styles>");
            // Default
            xml.AppendLine("<Style ss:ID=\"Default\"><Alignment ss:Vertical=\"Center\"/></Style>");
            // Title row
            xml.AppendLine("<Style ss:ID=\"Title\">" +
                "<Alignment ss:Horizontal=\"Center\" ss:Vertical=\"Center\"/>" +
                "<Font ss:Bold=\"1\" ss:Size=\"14\" ss:Color=\"#6b0d1e\"/>" +
                "<Interior ss:Color=\"#fffaf3\" ss:Pattern=\"Solid\"/>" +
                "</Style>");
            // Timestamp
            xml.AppendLine("<Style ss:ID=\"Stamp\">" +
                "<Alignment ss:Horizontal=\"Center\" ss:Vertical=\"Center\"/>" +
                "<Font ss:Italic=\"1\" ss:Size=\"9\" ss:Color=\"#888888\"/>" +
                "</Style>");
            // Header
            xml.AppendLine("<Style ss:ID=\"Header\">" +
                "<Alignment ss:Horizontal=\"Center\" ss:Vertical=\"Center\"/>" +
                "<Font ss:Bold=\"1\" ss:Size=\"10\" ss:Color=\"#FFFFFF\"/>" +
                "<Interior ss:Color=\"#6b0d1e\" ss:Pattern=\"Solid\"/>" +
                "<Borders><Border ss:Position=\"Bottom\" ss:LineStyle=\"Continuous\" ss:Weight=\"2\" ss:Color=\"#FFFFFF\"/></Borders>" +
                "</Style>");
            // Even row
            xml.AppendLine("<Style ss:ID=\"Even\">" +
                "<Interior ss:Color=\"#f9f4ee\" ss:Pattern=\"Solid\"/>" +
                "<Borders><Border ss:Position=\"Bottom\" ss:LineStyle=\"Continuous\" ss:Weight=\"1\" ss:Color=\"#e2d1d1\"/></Borders>" +
                "</Style>");
            // Odd row
            xml.AppendLine("<Style ss:ID=\"Odd\">" +
                "<Interior ss:Color=\"#FFFFFF\" ss:Pattern=\"Solid\"/>" +
                "<Borders><Border ss:Position=\"Bottom\" ss:LineStyle=\"Continuous\" ss:Weight=\"1\" ss:Color=\"#e2d1d1\"/></Borders>" +
                "</Style>");
            // Currency even
            xml.AppendLine("<Style ss:ID=\"CurrEven\">" +
                "<NumberFormat ss:Format=\"#,##0.00\"/>" +
                "<Interior ss:Color=\"#f9f4ee\" ss:Pattern=\"Solid\"/>" +
                "<Borders><Border ss:Position=\"Bottom\" ss:LineStyle=\"Continuous\" ss:Weight=\"1\" ss:Color=\"#e2d1d1\"/></Borders>" +
                "</Style>");
            // Currency odd
            xml.AppendLine("<Style ss:ID=\"CurrOdd\">" +
                "<NumberFormat ss:Format=\"#,##0.00\"/>" +
                "<Interior ss:Color=\"#FFFFFF\" ss:Pattern=\"Solid\"/>" +
                "<Borders><Border ss:Position=\"Bottom\" ss:LineStyle=\"Continuous\" ss:Weight=\"1\" ss:Color=\"#e2d1d1\"/></Borders>" +
                "</Style>");
            xml.AppendLine("</Styles>");

            // One Worksheet per DataTable
            foreach (DataTable dt in ds.Tables)
            {
                xml.AppendLine($"<Worksheet ss:Name=\"{XmlEscape(dt.TableName)}\">");
                xml.AppendLine("<Table>");

                // Column widths
                for (int c = 0; c < dt.Columns.Count; c++)
                    xml.AppendLine("<Column ss:AutoFitWidth=\"1\" ss:Width=\"120\"/>");

                // Row 1 — Sheet title
                xml.AppendLine($"<Row ss:Height=\"28\">" +
                    $"<Cell ss:MergeAcross=\"{dt.Columns.Count - 1}\" ss:StyleID=\"Title\">" +
                    $"<Data ss:Type=\"String\">{XmlEscape(dt.TableName + "  |  " + period)}</Data></Cell></Row>");

                // Row 2 — Timestamp
                xml.AppendLine($"<Row ss:Height=\"18\">" +
                    $"<Cell ss:MergeAcross=\"{dt.Columns.Count - 1}\" ss:StyleID=\"Stamp\">" +
                    $"<Data ss:Type=\"String\">Generated: {DateTime.Now:MMMM dd, yyyy  hh:mm tt}</Data></Cell></Row>");

                // Row 3 — Column headers
                xml.Append("<Row ss:Height=\"22\">");
                foreach (DataColumn col in dt.Columns)
                    xml.Append($"<Cell ss:StyleID=\"Header\"><Data ss:Type=\"String\">{XmlEscape(col.ColumnName)}</Data></Cell>");
                xml.AppendLine("</Row>");

                // Data rows
                if (dt.Rows.Count == 0)
                {
                    xml.AppendLine($"<Row><Cell ss:MergeAcross=\"{dt.Columns.Count - 1}\" ss:StyleID=\"Odd\">" +
                        "<Data ss:Type=\"String\">No data available for this period.</Data></Cell></Row>");
                }
                else
                {
                    for (int r = 0; r < dt.Rows.Count; r++)
                    {
                        string rowStyle = r % 2 == 0 ? "Odd" : "Even";
                        string currStyle = r % 2 == 0 ? "CurrOdd" : "CurrEven";

                        xml.Append("<Row>");
                        for (int c = 0; c < dt.Columns.Count; c++)
                        {
                            object val = dt.Rows[r][c];
                            string colName = dt.Columns[c].ColumnName.ToLower();
                            bool isCurr = colName.Contains("revenue") || colName.Contains("amount") || colName.Contains("value");
                            string style = isCurr ? currStyle : rowStyle;

                            if (val == null || val is DBNull)
                            {
                                xml.Append($"<Cell ss:StyleID=\"{style}\"><Data ss:Type=\"String\">—</Data></Cell>");
                            }
                            else if (isCurr && decimal.TryParse(val.ToString(), out decimal dv))
                            {
                                xml.Append($"<Cell ss:StyleID=\"{style}\"><Data ss:Type=\"Number\">{dv}</Data></Cell>");
                            }
                            else if (int.TryParse(val.ToString(), out int iv))
                            {
                                xml.Append($"<Cell ss:StyleID=\"{style}\"><Data ss:Type=\"Number\">{iv}</Data></Cell>");
                            }
                            else
                            {
                                xml.Append($"<Cell ss:StyleID=\"{style}\"><Data ss:Type=\"String\">{XmlEscape(val.ToString())}</Data></Cell>");
                            }
                        }
                        xml.AppendLine("</Row>");
                    }
                }

                xml.AppendLine("</Table>");
                xml.AppendLine("</Worksheet>");
            }

            xml.AppendLine("</Workbook>");

            string fileName = $"TasteNet_Reports_{DateTime.Now:yyyyMMdd_HHmmss}.xls";
            Response.Clear();
            Response.Charset = "UTF-8";
            Response.ContentEncoding = System.Text.Encoding.UTF8;
            Response.ContentType = "application/vnd.ms-excel";
            Response.AddHeader("content-disposition", $"attachment; filename=\"{fileName}\"");
            Response.Write(xml.ToString());
            Response.End();
        }

        // ════════════════════════════════════════════════════════════════════════
        //  SHARED DATA FETCH
        // ════════════════════════════════════════════════════════════════════════
        private DataSet GetExportData(DateTime cutoff)
        {
            DataSet ds = new DataSet();
            using (SqlConnection conn = new SqlConnection(ConnStr))
            {
                conn.Open();

                FillTable(conn, ds, "KPI Summary", @"
                    SELECT
                        COUNT(*)                   AS [Total Orders],
                        ISNULL(SUM(TotalAmount),0) AS [Total Revenue],
                        ISNULL(AVG(TotalAmount),0) AS [Avg Order Value],
                        (SELECT COUNT(*) FROM Users WHERE UserType='Customer'
                         AND CreatedAt >= @cutoff)  AS [New Customers]
                    FROM Tickets WHERE CreatedAt >= @cutoff", cutoff);

                FillTable(conn, ds, "Order Status", @"
                    SELECT Status, COUNT(*) AS [Order Count]
                    FROM   Tickets WHERE CreatedAt >= @cutoff
                    GROUP BY Status ORDER BY [Order Count] DESC", cutoff);

                FillTable(conn, ds, "Revenue Trend", @"
                    SELECT CONVERT(varchar(10), CreatedAt, 23) AS [Date],
                           COUNT(*)         AS [Orders],
                           SUM(TotalAmount) AS [Revenue]
                    FROM   Tickets WHERE CreatedAt >= @cutoff
                    GROUP BY CONVERT(varchar(10), CreatedAt, 23)
                    ORDER BY [Date]", cutoff);

                FillTable(conn, ds, "Orders by Hour", @"
                    SELECT DATEPART(HOUR, CreatedAt) AS [Hour],
                           COUNT(*) AS [Orders]
                    FROM   Tickets WHERE CreatedAt >= @cutoff
                    GROUP BY DATEPART(HOUR, CreatedAt)
                    ORDER BY [Hour]", cutoff);

                FillTable(conn, ds, "Popular Menu Items", @"
                    SELECT ti.FoodName            AS [Menu Item],
                           m.FoodType             AS [Category],
                           COUNT(ti.TicketItemID) AS [Total Orders],
                           SUM(ti.SubTotal)       AS [Revenue]
                    FROM   TicketItems ti
                    JOIN   Tickets     t ON t.TicketID = ti.TicketID
                    JOIN   Menu        m ON m.MenuID   = ti.MenuID
                    WHERE  t.CreatedAt >= @cutoff
                    GROUP BY ti.FoodName, m.FoodType
                    ORDER BY [Revenue] DESC", cutoff);
            }
            return ds;
        }

        private static void FillTable(SqlConnection conn, DataSet ds,
            string name, string sql, DateTime cutoff)
        {
            using (SqlCommand cmd = new SqlCommand(sql, conn))
            {
                cmd.Parameters.AddWithValue("@cutoff", cutoff);
                DataTable dt = new DataTable(name);
                new SqlDataAdapter(cmd).Fill(dt);
                ds.Tables.Add(dt);
            }
        }

        // ════════════════════════════════════════════════════════════════════════
        //  HELPERS
        // ════════════════════════════════════════════════════════════════════════
        private static string ToJson(IEnumerable<string> items)
            => "[" + string.Join(",", items) + "]";

        private static string FormatShort(decimal value)
        {
            if (value >= 1_000_000) return (value / 1_000_000m).ToString("0.#") + "M";
            if (value >= 1_000) return (value / 1_000m).ToString("0.#") + "K";
            return value.ToString("N2");
        }

        private static string XmlEscape(string s)
        {
            if (string.IsNullOrEmpty(s)) return "";
            return s.Replace("&", "&amp;")
                    .Replace("<", "&lt;")
                    .Replace(">", "&gt;")
                    .Replace("\"", "&quot;")
                    .Replace("'", "&apos;");
        }
    }
}