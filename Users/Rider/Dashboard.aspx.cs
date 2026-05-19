using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web;
using System.Web.UI;

namespace TasteNet.Users.Rider
{
    public partial class Dashboard : System.Web.UI.Page
    {
        private readonly string _connStr =
            System.Web.Configuration.WebConfigurationManager
                  .ConnectionStrings["TasteNetDB"].ConnectionString;

        // ── Logged-in rider's UserID ─────────────────────────────────────────────
        // Your login page must set these two session keys, e.g.:
        //   Session["UserID"]   = reader["UserID"];
        //   Session["UserType"] = reader["UserType"];   // "Rider"
        private int CurrentRiderID
        {
            get { return Convert.ToInt32(Session["UserID"]); }
        }

        // ════════════════════════════════════════════════════════════════════════
        //  Page Load
        // ════════════════════════════════════════════════════════════════════════
        protected void Page_Load(object sender, EventArgs e)
        {
            // ── Auth guard: only Riders may access this dashboard ────────────────
            if (Session["UserID"] == null || Session["UserType"]?.ToString() != "Rider")
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            // ── AJAX: complete a ticket with proof-of-delivery upload ────────────
            // Called via JS: POST Dashboard.aspx?completeTicket=TKT-0001
            // Expects multipart form with file field "proofPhoto"
            string ticketToComplete = Request.QueryString["completeTicket"];
            if (!string.IsNullOrEmpty(ticketToComplete))
            {
                HandleCompleteTicket(ticketToComplete);
                return;
            }

            if (!IsPostBack)
            {
                LoadStats();
                LoadDeliveryTickets();
            }
        }

        // ════════════════════════════════════════════════════════════════════════
        //  Complete Ticket Handler (called via AJAX POST)
        // ════════════════════════════════════════════════════════════════════════
        private void HandleCompleteTicket(string ticketNumber)
        {
            Response.Clear();
            Response.ContentType = "text/plain";

            // 1. Verify this ticket actually belongs to the logged-in rider
            if (!TicketBelongsToRider(ticketNumber, CurrentRiderID))
            {
                Response.StatusCode = 403;
                Response.Write("FORBIDDEN");
                Response.End();
                return;
            }

            // 2. Get the internal TicketID (needed for Proofs table)
            int ticketID = GetTicketID(ticketNumber);
            if (ticketID == 0)
            {
                Response.StatusCode = 404;
                Response.Write("NOTFOUND");
                Response.End();
                return;
            }

            // 3. Save proof-of-delivery photo (if uploaded)
            string proofPath = null;
            HttpPostedFile proofFile = Request.Files["proofPhoto"];
            if (proofFile != null && proofFile.ContentLength > 0)
            {
                string allowedExt = ".jpg.jpeg.png.gif.webp";
                string ext = Path.GetExtension(proofFile.FileName).ToLower();
                if (!allowedExt.Contains(ext))
                {
                    Response.StatusCode = 400;
                    Response.Write("INVALID_FILE_TYPE");
                    Response.End();
                    return;
                }

                string uploadDir = Server.MapPath("~/Uploads/Proofs/");
                if (!Directory.Exists(uploadDir))
                    Directory.CreateDirectory(uploadDir);

                string safeTicket = System.Text.RegularExpressions.Regex
                    .Replace(ticketNumber, @"[^a-zA-Z0-9_-]", "_");
                string fileName = $"POD_{safeTicket}_{Guid.NewGuid():N}{ext}";
                string fullPath = Path.Combine(uploadDir, fileName);
                proofFile.SaveAs(fullPath);

                // Store a root-relative web path (e.g. /Uploads/Proofs/POD_TKT-0001_<guid>.jpg)
                // so it works correctly from any page and with ResolveUrl/GetProofHtml.
                string appRoot = Request.ApplicationPath.TrimEnd('/');
                proofPath = $"{appRoot}/Uploads/Proofs/{fileName}";
            }

            // 4. Mark ticket complete + insert proof row + update rider counters
            CompleteTicketInDb(ticketNumber, ticketID, CurrentRiderID, proofPath);

            Response.Write("OK");
            Response.End();
        }

        // ════════════════════════════════════════════════════════════════════════
        //  DB Helpers
        // ════════════════════════════════════════════════════════════════════════

        /// <summary>Returns true only if the ticket is assigned to this rider.</summary>
        private bool TicketBelongsToRider(string ticketNumber, int riderID)
        {
            const string sql = @"
                SELECT COUNT(1)
                FROM   Tickets
                WHERE  TicketNumber    = @TicketNumber
                  AND  RiderID = @RiderID";

            using (SqlConnection con = new SqlConnection(_connStr))
            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                cmd.Parameters.AddWithValue("@TicketNumber", ticketNumber);
                cmd.Parameters.AddWithValue("@RiderID", riderID);
                con.Open();
                return Convert.ToInt32(cmd.ExecuteScalar()) > 0;
            }
        }

        /// <summary>Gets the integer TicketID from a TicketNumber string.</summary>
        private int GetTicketID(string ticketNumber)
        {
            const string sql = "SELECT TicketID FROM Tickets WHERE TicketNumber = @TicketNumber";
            using (SqlConnection con = new SqlConnection(_connStr))
            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                cmd.Parameters.AddWithValue("@TicketNumber", ticketNumber);
                con.Open();
                object result = cmd.ExecuteScalar();
                return result == null ? 0 : Convert.ToInt32(result);
            }
        }

        /// <summary>
        /// Marks the ticket Completed, inserts a Proofs row with the delivery photo,
        /// and updates the rider's CompletedOrders / AssignedOrders counters.
        /// </summary>
        private void CompleteTicketInDb(string ticketNumber, int ticketID, int riderID, string proofPath)
        {
            const string sql = @"
                -- 1. Mark ticket completed
                UPDATE Tickets
                SET    Status      = 'Completed',
                       CompletedAt = GETDATE(),
                       UpdatedAt   = GETDATE()
                WHERE  TicketNumber    = @TicketNumber
                  AND  RiderID = @RiderID;

                -- 2. Insert proof-of-delivery row into [DeliverySystem].[dbo].[Proofs]
                --    Columns: ProofID (identity), TicketID, ProofOfPayment (NULL - cashier handles),
                --             ProofOfDelivery (path), CreatedAt
                IF @ProofPath IS NOT NULL
                BEGIN
                    INSERT INTO [DeliverySystem].[dbo].[Proofs] (TicketID, ProofOfDelivery, CreatedAt)
                    VALUES (@TicketID, @ProofPath, GETDATE());
                END

                -- 3. Sync rider counters: +1 Completed, -1 Assigned
                UPDATE Users
                SET    CompletedOrders = CompletedOrders + 1,
                       AssignedOrders  = CASE WHEN AssignedOrders > 0
                                              THEN AssignedOrders - 1
                                              ELSE 0 END
                WHERE  UserID = @RiderID;";

            using (SqlConnection con = new SqlConnection(_connStr))
            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                cmd.Parameters.AddWithValue("@TicketNumber", ticketNumber);
                cmd.Parameters.AddWithValue("@RiderID", riderID);
                cmd.Parameters.AddWithValue("@TicketID", ticketID);
                cmd.Parameters.AddWithValue("@ProofPath",
                    string.IsNullOrEmpty(proofPath) ? (object)DBNull.Value : proofPath);
                con.Open();
                cmd.ExecuteNonQuery();
            }
        }

        // ════════════════════════════════════════════════════════════════════════
        //  Stats — scoped to THIS rider only
        // ════════════════════════════════════════════════════════════════════════
        private void LoadStats()
        {
            const string sql = @"
                -- Rider's personal totals
                SELECT
                    COUNT(*)                                                                 AS TotalAssigned,
                    COUNT(CASE
                              WHEN LTRIM(RTRIM(LOWER(Status))) = 'completed'
                               AND CAST(CompletedAt AS DATE) = CAST(GETDATE() AS DATE)
                              THEN 1 END)                                                    AS CompletedToday,
                    COUNT(CASE WHEN LTRIM(RTRIM(LOWER(Status))) <> 'completed' THEN 1 END)  AS PendingNow
                FROM Tickets
                WHERE LTRIM(RTRIM(LOWER(OrderType))) = 'delivery'
                  AND RiderID = @RiderID;

                -- Yesterday's completed count (for trend arrow on Completed Today card)
                SELECT
                    COUNT(CASE WHEN LTRIM(RTRIM(LOWER(Status))) = 'completed' THEN 1 END) AS CompletedYest
                FROM Tickets
                WHERE LTRIM(RTRIM(LOWER(OrderType))) = 'delivery'
                  AND RiderID = @RiderID
                  AND CAST(CompletedAt AS DATE) = CAST(DATEADD(DAY, -1, GETDATE()) AS DATE);";

            using (SqlConnection con = new SqlConnection(_connStr))
            using (SqlCommand cmd = new SqlCommand(sql, con))
            using (SqlDataAdapter da = new SqlDataAdapter(cmd))
            {
                cmd.Parameters.AddWithValue("@RiderID", CurrentRiderID);

                DataSet ds = new DataSet();
                con.Open();
                da.Fill(ds);

                DataRow today = ds.Tables[0].Rows[0];
                int totalAssigned = Convert.ToInt32(today["TotalAssigned"]);
                int completedToday = Convert.ToInt32(today["CompletedToday"]);
                int pendingNow = Convert.ToInt32(today["PendingNow"]);

                DataRow yest = ds.Tables[1].Rows[0];
                int completedYest = Convert.ToInt32(yest["CompletedYest"]);

                // Stat card values
                litTotalDeliveries.Text = totalAssigned.ToString("N0");
                litCompletedToday.Text = completedToday.ToString("N0");
                litPending.Text = pendingNow.ToString("N0");

                // Trend labels
                litTrendTotalDeliveries.Text = "<i class='fas fa-history'></i> All-time assigned to you";
                litTrendCompletedToday.Text = BuildTrendHtml(completedToday, completedYest, "vs yesterday");
                litTrendPending.Text = pendingNow == 0
                    ? "<i class='fas fa-check-circle'></i> All caught up!"
                    : $"<i class='fas fa-clock'></i> {pendingNow} awaiting delivery";
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

        // ════════════════════════════════════════════════════════════════════════
        //  Delivery Tickets Repeater
        //  Only shows tickets assigned to THIS rider that are NOT yet completed.
        //  Also pulls the proof-of-delivery status from the Proofs table.
        // ════════════════════════════════════════════════════════════════════════
        // ════════════════════════════════════════════════════════════════════════
        //  Delivery Tickets Repeater — only tickets assigned to THIS rider,
        //  not yet completed. Includes order items from TicketItems.
        // ════════════════════════════════════════════════════════════════════════
        private void LoadDeliveryTickets()
        {
            // Step 1: load the tickets assigned to this rider
            const string ticketSql = @"
                SELECT  t.TicketID,
                        t.TicketNumber,
                        t.OrderNumber,
                        t.OrderType,
                        t.DeliveryAddress,
                        t.Status,
                        t.Priority,
                        t.TotalAmount,
                        t.CreatedAt,
                        t.StartedAt,
                        t.CompletedAt,
                        t.CreatedBy,
                        t.UpdatedAt,
                        u.FullName  AS CustomerUsername,
                        u.Phone     AS CustomerPhone,
                        p.ProofOfDelivery   AS ProofPhoto,
                        p.CreatedAt         AS ProofUploadedAt,
                        df.Fee              AS DeliveryFee
                FROM    Tickets t
                LEFT JOIN Users u
                       ON t.CreatedBy = u.UserID
                      AND LTRIM(RTRIM(LOWER(u.UserType))) = 'customer'
                LEFT JOIN Proofs p
                       ON p.TicketID = t.TicketID
                OUTER APPLY (
                    SELECT TOP 1 Fee
                    FROM   [DeliverySystem].[dbo].[DeliveryFees] df2
                    WHERE
                        CHARINDEX(
                            LTRIM(RTRIM(LOWER(df2.BarangayName))),
                            LTRIM(RTRIM(LOWER(t.DeliveryAddress)))
                        ) > 0
                        AND
                        (
                            CHARINDEX(
                                LTRIM(RTRIM(LOWER(df2.BarangayName))),
                                LTRIM(RTRIM(LOWER(t.DeliveryAddress)))
                            ) + LEN(LTRIM(RTRIM(df2.BarangayName))) - 1
                            >= LEN(LTRIM(RTRIM(t.DeliveryAddress)))
                            OR
                            SUBSTRING(
                                LTRIM(RTRIM(LOWER(t.DeliveryAddress))),
                                CHARINDEX(
                                    LTRIM(RTRIM(LOWER(df2.BarangayName))),
                                    LTRIM(RTRIM(LOWER(t.DeliveryAddress)))
                                ) + LEN(LTRIM(RTRIM(df2.BarangayName))),
                                1
                            ) NOT LIKE '[a-z0-9]'
                        )
                    ORDER BY LEN(df2.BarangayName) DESC
                ) df (Fee)
                WHERE   LTRIM(RTRIM(LOWER(t.OrderType))) = 'delivery'
                  AND   t.RiderID                        = @RiderID
                  AND   LTRIM(RTRIM(LOWER(t.Status)))   <> 'completed'
                ORDER BY
                    CASE LTRIM(RTRIM(LOWER(t.Priority)))
                        WHEN 'high'   THEN 1
                        WHEN 'medium' THEN 2
                        ELSE               3
                    END,
                    t.CreatedAt ASC";

            // Step 2: load all TicketItems for those tickets in one query
            const string itemsSql = @"
                SELECT  ti.TicketID,
                        ti.FoodName,
                        ti.Quantity,
                        ti.UnitPrice,
                        ti.SubTotal,
                        ti.SpecialInstructions
                FROM    TicketItems ti
                INNER JOIN Tickets t ON ti.TicketID = t.TicketID
                WHERE   t.RiderID = @RiderID
                  AND   LTRIM(RTRIM(LOWER(t.Status))) <> 'completed'
                ORDER BY ti.TicketID, ti.TicketItemID";

            using (SqlConnection con = new SqlConnection(_connStr))
            {
                con.Open();

                // Load tickets
                DataTable dt = new DataTable();
                using (SqlCommand cmd = new SqlCommand(ticketSql, con))
                {
                    cmd.Parameters.AddWithValue("@RiderID", CurrentRiderID);
                    new SqlDataAdapter(cmd).Fill(dt);
                }

                // Load items
                DataTable dtItems = new DataTable();
                using (SqlCommand cmd = new SqlCommand(itemsSql, con))
                {
                    cmd.Parameters.AddWithValue("@RiderID", CurrentRiderID);
                    new SqlDataAdapter(cmd).Fill(dtItems);
                }

                // Add computed columns
                dt.Columns.Add("ItemsHtml", typeof(string));
                dt.Columns.Add("ItemCount", typeof(int));

                // Match items to each ticket and build HTML
                foreach (DataRow ticketRow in dt.Rows)
                {
                    int ticketID = Convert.ToInt32(ticketRow["TicketID"]);
                    DataRow[] ticketItems = dtItems.Select("TicketID = " + ticketID);
                    ticketRow["ItemCount"] = ticketItems.Length;
                    ticketRow["ItemsHtml"] = BuildItemsHtml(ticketItems);
                }

                rptDeliveries.DataSource = dt;
                rptDeliveries.DataBind();
            }
        }

        /// <summary>
        /// Builds the inner HTML for the order items list of one ticket.
        /// </summary>
        private string BuildItemsHtml(DataRow[] items)
        {
            if (items == null || items.Length == 0)
                return "<div class='order-item-row'><span class='order-item-name' style='color:var(--muted-text);font-style:italic;'>No items found.</span></div>";

            var sb = new System.Text.StringBuilder();
            foreach (DataRow item in items)
            {
                string name = System.Web.HttpUtility.HtmlEncode(item["FoodName"]?.ToString() ?? "\u2014");
                decimal qty = Convert.ToDecimal(item["Quantity"]);
                decimal unit = Convert.ToDecimal(item["UnitPrice"]);
                decimal sub = Convert.ToDecimal(item["SubTotal"]);
                string note = item["SpecialInstructions"]?.ToString()?.Trim();

                sb.Append("<div class='order-item-row'>");
                sb.Append("<div class='order-item-name'>");
                sb.Append(name);
                if (!string.IsNullOrEmpty(note))
                    sb.Append("<span class='order-item-note'>"
                              + "<i class='fas fa-sticky-note' style='margin-right:3px;'></i>"
                              + System.Web.HttpUtility.HtmlEncode(note)
                              + "</span>");
                sb.Append("</div>");
                sb.Append("<div class='order-item-right'>");
                sb.Append("<span class='order-item-qty'>x" + qty.ToString("0.##") + " &times; &#8369;" + unit.ToString("N2") + "</span>");
                sb.Append("<span class='order-item-subtotal'>&#8369;" + sub.ToString("N2") + "</span>");
                sb.Append("</div>");
                sb.Append("</div>");
            }
            return sb.ToString();
        }

        protected string GetStatusCss(string status)
        {
            switch ((status ?? string.Empty).Trim().ToLower())
            {
                case "pending": return "status-pending";
                case "active":
                case "started": return "status-active";
                case "completed": return "status-completed";
                default: return "status-pending";
            }
        }

        /// <summary>
        /// Returns the proof-of-delivery img tag if a photo exists,
        /// or a "No proof yet" placeholder — used inside the repeater.
        /// Paths stored in Proofs.ProofOfDelivery are root-relative
        /// (e.g. /Uploads/Proofs/POD_TKT-0001_<guid>.jpg).
        /// </summary>
        protected string GetProofHtml(object proofPath)
        {
            if (proofPath == DBNull.Value || proofPath == null || string.IsNullOrEmpty(proofPath.ToString()))
                return "<span class='no-proof'><i class='fas fa-image'></i> No proof uploaded yet</span>";

            // Path is already root-relative — use as-is (no ResolveUrl needed)
            string src = proofPath.ToString();
            if (src.StartsWith("~"))
                src = ResolveUrl(src);   // backward-compat for any old tilde paths

            return $"<a href='{src}' target='_blank'>" +
                   $"<img src='{src}' alt='Proof of Delivery' class='proof-thumb' /></a>";
        }
    }
}