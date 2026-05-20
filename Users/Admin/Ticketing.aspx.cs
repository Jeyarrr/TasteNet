using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;

namespace TasteNet.Users.Admin
{
    public partial class Ticketing : System.Web.UI.Page
    {
        private const string DbConnectionKey = "TasteNetDB";
        private readonly string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["TasteNetDB"].ConnectionString;

        private List<ModalMenuItem> ModalItems
        {
            get
            {
                // Fix 5 NOTE: Session-stored cart is shared across all browser tabs for the same user.
                // If the user opens two tabs and adds items in both, they will silently overwrite each other.
                // For true multi-tab safety, key the cart by a per-tab GUID stored in a hidden field instead.
                if (Session["ModalItems"] == null)
                {
                    Session["ModalItems"] = new List<ModalMenuItem>();
                    if (IsPostBack)
                    {
                        // Session was lost mid-use (e.g. timeout); notify the user
                        ShowClientNotification("Your session expired and the cart was cleared. Please add items again.", "warning");
                    }
                }
                return (List<ModalMenuItem>)Session["ModalItems"];
            }
            set { Session["ModalItems"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            // Fix 6: Authorization check — only SuperAdmin may access this page
            if (Session["UserType"] == null || Session["UserType"].ToString() != "Admin")
            {
                Response.Redirect("~/Login.aspx", endResponse: true);
                return;
            }

            if (!IsPostBack)
            {
                hfSelectedStatus.Value = "Open";
                LoadTickets();
                LoadMenuItemsIntoDropdown();
                LoadTicketCounts();
                ModalItems = new List<ModalMenuItem>();
                RefreshModalItemsDisplay();
            }
        }

        private void LoadTicketCounts()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"
                        SELECT 
                            COUNT(CASE WHEN Status = 'Open' THEN 1 END) AS OpenCount,
                            COUNT(CASE WHEN Status = 'In Progress' THEN 1 END) AS InProgressCount,
                            COUNT(CASE WHEN Status = 'Completed' THEN 1 END) AS CompletedCount,
                            COUNT(CASE WHEN Status = 'Cancelled' THEN 1 END) AS CancelledCount,
                            COUNT(*) AS AllCount
                        FROM Tickets";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        conn.Open();
                        SqlDataReader reader = cmd.ExecuteReader();
                        if (reader.Read())
                        {
                            litOpenCount.Text = reader["OpenCount"].ToString();
                            litInProgressCount.Text = reader["InProgressCount"].ToString();
                            litCompletedCount.Text = reader["CompletedCount"].ToString();
                            litCancelledCount.Text = reader["CancelledCount"].ToString();
                            litAllCount.Text = reader["AllCount"].ToString();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("LoadTicketCounts ERROR: " + ex.Message);
                // Fix 7: Never expose raw exception/SQL details to the client
                ShowClientNotification("Error loading ticket counts. Please try again.", "error");
            }
        }

        private void EnsureRiderIDColumn()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string sql = @"
                        IF NOT EXISTS (
                            SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS 
                            WHERE TABLE_NAME = 'Tickets' AND COLUMN_NAME = 'RiderID'
                        )
                        BEGIN
                            ALTER TABLE Tickets ADD RiderID INT NULL 
                            REFERENCES Users(UserID);
                        END";
                    using (SqlCommand cmd = new SqlCommand(sql, conn))
                    {
                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("EnsureRiderIDColumn ERROR: " + ex.Message);
            }
        }

        private void LoadTickets()
        {
            // Fix 4: EnsureRiderIDColumn removed from here — it should be a one-time DB migration,
            // not executed on every page load. Run the ALTER TABLE script once in your DB setup.

            try
            {
                string status = string.IsNullOrEmpty(hfSelectedStatus.Value) ? "Open" : hfSelectedStatus.Value;
                System.Diagnostics.Debug.WriteLine($"Loading tickets with status: {status}");

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"
                        SELECT 
                            t.TicketID, 
                            t.TicketNumber, 
                            t.OrderNumber,
                            t.OrderType, 
                            t.DeliveryAddress,
                            t.Priority, 
                            t.Status, 
                            t.TotalAmount, 
                            t.CreatedAt,
                            t.RiderID,
                            r.FullName AS RiderName,
                            r.Phone    AS RiderPhone,
                            FORMAT(t.CreatedAt, 'hh:mm tt') as CreatedTime,
                            DATEDIFF(MINUTE, t.CreatedAt, GETDATE()) as MinutesAgo
                        FROM Tickets t
                        LEFT JOIN Users r ON r.UserID = t.RiderID AND r.UserType = 'Rider'
                        WHERE (@Status = 'All' OR t.Status = @Status)
                        ORDER BY 
                            CASE WHEN t.Priority = 'Rush' THEN 0 ELSE 1 END, 
                            CASE WHEN t.Status = 'Open' THEN 0 WHEN t.Status = 'In Progress' THEN 1 ELSE 2 END,
                            t.CreatedAt DESC";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Status", status);
                        conn.Open();

                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        System.Diagnostics.Debug.WriteLine($"Tickets found: {dt.Rows.Count}");

                        rptTickets.DataSource = dt;
                        rptTickets.DataBind();
                        pnlNoTickets.Visible = dt.Rows.Count == 0;
                    }
                }

                LoadTicketCounts();
                SetActiveTab(status);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("LoadTickets ERROR: " + ex.Message);
                // Fix 7: Don't expose SQL/exception details to the client
                ShowClientNotification("Error loading tickets. Please refresh the page.", "error");
            }
        }

        private void SetActiveTab(string status)
        {
            string script = @"
                setTimeout(function() {
                    document.querySelectorAll('.status-tab').forEach(function(tab) {
                        tab.classList.remove('active');
                    });
                    var activeText = '" + status + @"';
                    document.querySelectorAll('.status-tab').forEach(function(tab) {
                        if(tab.innerText.includes(activeText)) {
                            tab.classList.add('active');
                        }
                    });
                }, 100);
            ";
            ScriptManager.RegisterStartupScript(this, GetType(), "SetActiveTab", script, true);
        }

        private void LoadMenuItemsIntoDropdown()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = "SELECT MenuID, FoodName, Price FROM Menu WHERE Status = 'active' ORDER BY FoodType, FoodName";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        conn.Open();
                        SqlDataReader reader = cmd.ExecuteReader();
                        ddlMenuItem.Items.Clear();
                        ddlMenuItem.Items.Add(new ListItem("-- Select item --", ""));

                        while (reader.Read())
                        {
                            string text = $"{reader["FoodName"]} - ₱{Convert.ToDecimal(reader["Price"]):N2}";
                            ddlMenuItem.Items.Add(new ListItem(text, reader["MenuID"].ToString()));
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Menu load ERROR: " + ex.Message);
                // Fix 7: Generic message to client, full detail to server log only
                ShowClientNotification("Error loading menu items. Please refresh the page.", "error");
            }
        }

        protected void RptTickets_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            // Fix 11 NOTE: This fires a separate DB query per ticket row (N+1 query pattern).
            // For better performance at scale, load all TicketItems in one query in LoadTickets()
            // and store them in ViewState or a Dictionary<int, DataTable>, then filter here.
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                DataRowView row = (DataRowView)e.Item.DataItem;
                int ticketId = Convert.ToInt32(row["TicketID"]);
                Repeater rptItems = e.Item.FindControl("rptItems") as Repeater;

                if (rptItems != null)
                {
                    DataTable items = GetTicketItems(ticketId);
                    rptItems.DataSource = items;
                    rptItems.DataBind();
                }
            }
        }

        private DataTable GetTicketItems(int ticketId)
        {
            DataTable dt = new DataTable();
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = "SELECT Quantity, FoodName AS ItemName, SubTotal FROM TicketItems WHERE TicketID = @id";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@id", ticketId);
                        conn.Open();
                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        da.Fill(dt);
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("GetTicketItems ERROR: " + ex.Message);
            }
            return dt;
        }

        protected void RptTickets_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (!int.TryParse(e.CommandArgument?.ToString(), out int ticketId))
            {
                ShowClientNotification("Invalid ticket reference. Please refresh and try again.", "error");
                return;
            }

            if (e.CommandName == "Start")
            {
                UpdateTicketStatus(ticketId, "In Progress");
                DeductIngredientsByTicket(ticketId);
                ShowClientNotification("Ticket started! Inventory updated.", "success");
                LoadTickets();
            }
            else if (e.CommandName == "Complete")
            {
                UpdateTicketStatus(ticketId, "Completed");
                ShowClientNotification("Ticket completed successfully!", "success");
                LoadTickets();
            }
            else if (e.CommandName == "DeleteTicket")
            {
                DeleteTicketById(ticketId);
                ShowClientNotification("Ticket deleted successfully!", "success");
                LoadTickets();
            }
            else if (e.CommandName == "CancelTicket")
            {
                UpdateTicketStatus(ticketId, "Cancelled");
                ShowClientNotification("Ticket cancelled.", "warning");
                LoadTickets();
            }
            else if (e.CommandName == "AssignRider")
            {
                hfAssignTicketID.Value = ticketId.ToString();
                LoadRiders();
                ScriptManager.RegisterStartupScript(this, GetType(), "openRiderModal", "openRiderModal();", true);
                upRiderModal.Update();
            }
        }

        private void UpdateTicketStatus(int ticketId, string status)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"UPDATE Tickets SET Status = @status, 
                                    StartedAt = CASE WHEN @status = 'In Progress' AND StartedAt IS NULL THEN GETDATE() ELSE StartedAt END,
                                    CompletedAt = CASE WHEN @status = 'Completed' THEN GETDATE() ELSE CompletedAt END
                                    WHERE TicketID = @id";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@status", status);
                        cmd.Parameters.AddWithValue("@id", ticketId);
                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("UpdateTicketStatus ERROR: " + ex.Message);
                // Fix 7: Generic message to client
                ShowClientNotification("Error updating ticket status. Please try again.", "error");
            }
        }

        private void DeleteTicketById(int ticketId)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    using (SqlTransaction trans = conn.BeginTransaction())
                    {
                        try
                        {
                            // Delete Proofs first — FK_Proofs_Tickets prevents removing the ticket while proof rows exist
                            string deleteProofsSql = "DELETE FROM Proofs WHERE TicketID = @id";
                            using (SqlCommand cmd = new SqlCommand(deleteProofsSql, conn, trans))
                            {
                                cmd.Parameters.AddWithValue("@id", ticketId);
                                cmd.ExecuteNonQuery();
                            }

                            string deleteItemsSql = "DELETE FROM TicketItems WHERE TicketID = @id";
                            using (SqlCommand cmd = new SqlCommand(deleteItemsSql, conn, trans))
                            {
                                cmd.Parameters.AddWithValue("@id", ticketId);
                                cmd.ExecuteNonQuery();
                            }

                            string deleteTicketSql = "DELETE FROM Tickets WHERE TicketID = @id";
                            using (SqlCommand cmd = new SqlCommand(deleteTicketSql, conn, trans))
                            {
                                cmd.Parameters.AddWithValue("@id", ticketId);
                                int rowsAffected = cmd.ExecuteNonQuery();

                                if (rowsAffected == 0)
                                {
                                    trans.Rollback();
                                    throw new Exception("Ticket not found");
                                }
                            }

                            trans.Commit();
                            System.Diagnostics.Debug.WriteLine($"Ticket {ticketId} deleted successfully");
                        }
                        catch (Exception ex)
                        {
                            trans.Rollback();
                            // Fix 1: Use bare throw to preserve the original stack trace
                            System.Diagnostics.Debug.WriteLine("DeleteTicketById inner ERROR: " + ex.Message);
                            throw;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Delete ERROR: {ex.Message}");
                // Fix 1: Use bare throw to preserve the original stack trace
                throw;
            }
        }

        protected void BtnAddItem_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(ddlMenuItem.SelectedValue) || ddlMenuItem.SelectedValue == "")
            {
                ShowClientNotification("Please select an item", "warning");
                return;
            }

            try
            {
                string selectedText = ddlMenuItem.SelectedItem.Text;
                // Fix: Split on last " - ₱" to handle food names that contain dashes
                int lastDashIdx = selectedText.LastIndexOf(" - ₱");
                if (lastDashIdx < 0)
                    throw new Exception("Unexpected menu item format: " + selectedText);
                string itemName = selectedText.Substring(0, lastDashIdx).Trim();
                string pricePart = selectedText.Substring(lastDashIdx + 4).Replace(",", "").Trim();
                decimal price = decimal.Parse(pricePart, System.Globalization.CultureInfo.InvariantCulture);

                int qty = 1;
                if (!string.IsNullOrEmpty(txtQuantity.Text))
                {
                    int.TryParse(txtQuantity.Text, out qty);
                    if (qty < 1) qty = 1;
                }

                // Fix minor: Use TryParse instead of Parse to avoid exceptions on malformed MenuID
                if (!int.TryParse(ddlMenuItem.SelectedValue, out int menuId))
                {
                    ShowClientNotification("Invalid menu item selected.", "warning");
                    upModal.Update();
                    return;
                }

                var existingItem = ModalItems.FirstOrDefault(x => x.MenuID == menuId);

                if (existingItem != null)
                {
                    existingItem.Quantity += qty;
                    existingItem.SubTotal = existingItem.Quantity * existingItem.UnitPrice;
                    ShowClientNotification($"Updated {itemName} quantity to {existingItem.Quantity}", "success");
                }
                else
                {
                    ModalItems.Add(new ModalMenuItem
                    {
                        MenuID = menuId,
                        ItemName = itemName,
                        Quantity = qty,
                        UnitPrice = price,
                        SubTotal = qty * price
                    });
                    ShowClientNotification($"Added {qty}x {itemName}", "success");
                }

                RefreshModalItemsDisplay();
                ddlMenuItem.SelectedIndex = 0;
                txtQuantity.Text = "1";
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Add Item ERROR: " + ex.Message);
                // Fix 7: Generic message to client, full detail only in server log
                ShowClientNotification("Error adding item. Please try again.", "error");
            }

            upModal.Update();
        }

        protected void RptSelectedItems_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "RemoveItem")
            {
                int index = int.Parse(e.CommandArgument.ToString());
                if (index >= 0 && index < ModalItems.Count)
                {
                    string itemName = ModalItems[index].ItemName;
                    ModalItems.RemoveAt(index);
                    ShowClientNotification($"Removed {itemName}", "success");
                }

                RefreshModalItemsDisplay();
            }
            upModal.Update();
        }

        private void RefreshModalItemsDisplay()
        {
            pnlNoItems.Visible = ModalItems.Count == 0;
            rptSelectedItems.DataSource = ModalItems;
            rptSelectedItems.DataBind();

            decimal total = ModalItems.Sum(x => x.SubTotal);
            litModalTotal.Text = $"₱{total:N2}";

            upModal.Update();
        }

        /// <summary>
        /// Generates a sequential ticket number in format: ORD-YYYYMMDD-XXX
        /// Must be called inside an open transaction to prevent race conditions.
        /// </summary>
        private string GenerateTicketNumber(SqlConnection conn, SqlTransaction trans)
        {
            string today = DateTime.Now.ToString("yyyyMMdd");
            int nextNumber = GetNextSequenceNumber(conn, trans, "TicketNumber", "ORD", today);
            // Fix 3: Use Math.Max(3, digits) so the suffix never truncates beyond 999
            string suffix = nextNumber.ToString().PadLeft(Math.Max(3, nextNumber.ToString().Length), '0');
            return $"ORD-{today}-{suffix}";
        }

        /// <summary>
        /// Generates a sequential order number in format: ON-YYYYMMDD-XXX
        /// Must be called inside an open transaction to prevent race conditions.
        /// </summary>
        private string GenerateOrderNumber(SqlConnection conn, SqlTransaction trans)
        {
            string today = DateTime.Now.ToString("yyyyMMdd");
            int nextNumber = GetNextSequenceNumber(conn, trans, "OrderNumber", "ON", today);
            // Fix 3: Use Math.Max(3, digits) so the suffix never truncates beyond 999
            string suffix = nextNumber.ToString().PadLeft(Math.Max(3, nextNumber.ToString().Length), '0');
            return $"ON-{today}-{suffix}";
        }

        /// <summary>
        /// Gets the next sequence number for a given prefix and date.
        /// Must be called inside an open transaction to prevent race conditions.
        /// </summary>
        private int GetNextSequenceNumber(SqlConnection conn, SqlTransaction trans, string fieldToCheck, string prefix, string datePrefix)
        {
            int nextNumber = 1;

            try
            {
                // Pattern: PREFIX-YYYYMMDD-NNN (suffix may exceed 3 digits at high volume)
                string pattern = $"{prefix}-{datePrefix}-%";
                // Fix: Extract suffix after the second dash using CHARINDEX so sequences > 999 work correctly
                // e.g. "ORD-20250101-1000" → suffix = "1000"
                string query = $@"
                    SELECT TOP 1 
                        CAST(SUBSTRING({fieldToCheck},
                            CHARINDEX('-', {fieldToCheck},
                                CHARINDEX('-', {fieldToCheck}) + 1
                            ) + 1,
                            LEN({fieldToCheck})
                        ) AS INT) AS SeqNumber
                    FROM Tickets WITH (UPDLOCK, HOLDLOCK)
                    WHERE {fieldToCheck} LIKE @pattern
                      AND ISNUMERIC(SUBSTRING({fieldToCheck},
                            CHARINDEX('-', {fieldToCheck},
                                CHARINDEX('-', {fieldToCheck}) + 1
                            ) + 1,
                            LEN({fieldToCheck})
                        )) = 1
                    ORDER BY SeqNumber DESC";

                using (SqlCommand cmd = new SqlCommand(query, conn, trans))
                {
                    cmd.Parameters.AddWithValue("@pattern", pattern);
                    object result = cmd.ExecuteScalar();

                    if (result != null && result != DBNull.Value)
                    {
                        nextNumber = Convert.ToInt32(result) + 1;
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"GetNextSequenceNumber ERROR: {ex.Message}");
                // Do not silently return 1 — rethrow so the caller can handle it
                throw;
            }

            return nextNumber;
        }

        protected void BtnCreateTicket_Click(object sender, EventArgs e)
        {
            decimal total = ModalItems.Sum(x => x.SubTotal);

            if (ModalItems.Count == 0)
            {
                ShowClientNotification("Please add at least one item to the ticket", "warning");
                return;
            }

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    using (SqlTransaction trans = conn.BeginTransaction())
                    {
                        try
                        {
                            // Fix: Generate numbers INSIDE the transaction with UPDLOCK to prevent race conditions / duplicate keys
                            string ticketNumber = GenerateTicketNumber(conn, trans);
                            string orderNumber = GenerateOrderNumber(conn, trans);
                            System.Diagnostics.Debug.WriteLine($"Creating ticket: {ticketNumber}, Order: {orderNumber}");

                            string ticketSql = @"
                                INSERT INTO Tickets (TicketNumber, OrderNumber, OrderType, DeliveryAddress, Priority, Status, TotalAmount)
                                VALUES (@num, @ordernum, @type, @addr, @priority, 'Open', @total);
                                SELECT CAST(SCOPE_IDENTITY() AS INT)";

                            using (SqlCommand cmd = new SqlCommand(ticketSql, conn, trans))
                            {
                                cmd.Parameters.AddWithValue("@num", ticketNumber);
                                cmd.Parameters.AddWithValue("@ordernum", orderNumber);
                                cmd.Parameters.AddWithValue("@type", ddlOrderType.SelectedValue);
                                cmd.Parameters.AddWithValue("@addr", string.IsNullOrWhiteSpace(txtDeliveryAddress.Text) ? (object)DBNull.Value : txtDeliveryAddress.Text.Trim());
                                cmd.Parameters.AddWithValue("@priority", ddlPriority.SelectedValue);
                                cmd.Parameters.AddWithValue("@total", total);

                                object result = cmd.ExecuteScalar();

                                if (result == null || result == DBNull.Value)
                                {
                                    throw new Exception("Failed to create ticket - no ID returned from database");
                                }

                                int ticketId = Convert.ToInt32(result);
                                System.Diagnostics.Debug.WriteLine($"Ticket created with ID: {ticketId}");

                                string itemSql = @"
                                    INSERT INTO TicketItems (TicketID, MenuID, FoodName, Quantity, UnitPrice, SubTotal)
                                    VALUES (@tid, @mid, @name, @qty, @price, @subtotal)";

                                foreach (var item in ModalItems)
                                {
                                    using (SqlCommand itemCmd = new SqlCommand(itemSql, conn, trans))
                                    {
                                        itemCmd.Parameters.AddWithValue("@tid", ticketId);
                                        itemCmd.Parameters.AddWithValue("@mid", item.MenuID);
                                        itemCmd.Parameters.AddWithValue("@name", item.ItemName);
                                        itemCmd.Parameters.AddWithValue("@qty", item.Quantity);
                                        itemCmd.Parameters.AddWithValue("@price", item.UnitPrice);
                                        itemCmd.Parameters.AddWithValue("@subtotal", item.SubTotal);
                                        itemCmd.ExecuteNonQuery();
                                        System.Diagnostics.Debug.WriteLine($"Added item: {item.ItemName}, Qty: {item.Quantity}");
                                    }
                                }

                                trans.Commit();
                                System.Diagnostics.Debug.WriteLine("Transaction committed successfully");

                                ModalItems.Clear();
                                RefreshModalItemsDisplay();

                                ddlPriority.SelectedIndex = 0;
                                ddlOrderType.SelectedIndex = 0;
                                txtDeliveryAddress.Text = "";
                                pnlDeliveryAddress.Visible = false;

                                string script = $@"
                                    closeModal();
                                    showNotification('✅ Ticket {ticketNumber} (Order: {orderNumber}) created successfully! Total: ₱{total:N2}', 'success');
                                ";
                                ScriptManager.RegisterStartupScript(this, GetType(), "success", script, true);

                                LoadTickets();
                            }
                        }
                        catch (Exception ex)
                        {
                            trans.Rollback();
                            System.Diagnostics.Debug.WriteLine($"Transaction error: {ex.Message}");
                            System.Diagnostics.Debug.WriteLine($"Stack Trace: {ex.StackTrace}");
                            throw;
                        }
                    }
                }
            }
            catch (SqlException sqlEx)
            {
                System.Diagnostics.Debug.WriteLine($"SQL ERROR: {sqlEx.Message}");
                System.Diagnostics.Debug.WriteLine($"SQL Error Number: {sqlEx.Number}");

                if (sqlEx.Number == 547)
                {
                    ShowClientNotification("Unable to create ticket: a referenced item no longer exists in the menu.", "error");
                }
                else if (sqlEx.Number == 8152)
                {
                    ShowClientNotification("One or more fields exceed the allowed length. Please shorten your input.", "error");
                }
                else
                {
                    ShowClientNotification("A database error occurred while creating the ticket. Please try again.", "error");
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Create ERROR: {ex.Message}");
                System.Diagnostics.Debug.WriteLine($"Stack Trace: {ex.StackTrace}");
                ShowClientNotification("An unexpected error occurred. Please try again.", "error");
            }
        }

        protected void DdlOrderType_SelectedIndexChanged(object sender, EventArgs e)
        {
            pnlDeliveryAddress.Visible = (ddlOrderType.SelectedValue == "Delivery");
            upModal.Update();
        }

        /// <summary>
        /// Fix 13: Called each time the Create Ticket modal opens (via hidden button click in JS).
        /// Clears any stale cart items left from a previously abandoned modal session.
        /// </summary>
        protected void BtnResetCart_Click(object sender, EventArgs e)
        {
            ModalItems = new List<ModalMenuItem>();
            ddlPriority.SelectedIndex = 0;
            ddlOrderType.SelectedIndex = 0;
            txtDeliveryAddress.Text = "";
            pnlDeliveryAddress.Visible = false;
            txtQuantity.Text = "1";
            ddlMenuItem.SelectedIndex = 0;
            RefreshModalItemsDisplay();
        }

        private void LoadRiders()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = "SELECT UserID AS RiderID, FullName, Phone FROM Users WHERE UserType = 'Rider' AND IsActive = 1 ORDER BY FullName";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        conn.Open();
                        SqlDataReader reader = cmd.ExecuteReader();
                        ddlRider.Items.Clear();
                        ddlRider.Items.Add(new ListItem("-- Select Rider --", ""));
                        bool hasRiders = false;
                        while (reader.Read())
                        {
                            hasRiders = true;
                            string phone = reader["Phone"] != DBNull.Value ? reader["Phone"].ToString() : "";
                            string label = reader["FullName"].ToString() + (string.IsNullOrEmpty(phone) ? "" : $" ({phone})");
                            ddlRider.Items.Add(new ListItem(label, reader["RiderID"].ToString()));
                        }
                        noRidersMsg.Visible = !hasRiders;
                        btnConfirmRider.Visible = hasRiders;
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("LoadRiders ERROR: " + ex.Message);
                // Fix 7: Generic message to client
                ShowClientNotification("Error loading riders. Please try again.", "error");
            }
        }

        protected void BtnConfirmRider_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(ddlRider.SelectedValue))
            {
                ShowClientNotification("Please select a rider.", "warning");
                upRiderModal.Update();
                return;
            }

            // Fix minor: Guard against non-integer values in hidden fields
            if (!int.TryParse(hfAssignTicketID.Value, out int ticketId) || ticketId <= 0)
            {
                ShowClientNotification("Invalid ticket. Please try again.", "warning");
                upRiderModal.Update();
                return;
            }

            if (!int.TryParse(ddlRider.SelectedValue, out int riderId))
            {
                ShowClientNotification("Invalid rider selected.", "warning");
                upRiderModal.Update();
                return;
            }

            string riderName = ddlRider.SelectedItem.Text;

            try
            {
                // Fix 4: Removed EnsureRiderIDColumn() — this is a one-time DB migration, not runtime work
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string sql = "UPDATE Tickets SET RiderID = @riderID WHERE TicketID = @ticketID";
                    using (SqlCommand cmd = new SqlCommand(sql, conn))
                    {
                        cmd.Parameters.AddWithValue("@riderID", riderId);
                        cmd.Parameters.AddWithValue("@ticketID", ticketId);
                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }
                }

                ScriptManager.RegisterStartupScript(this, GetType(), "closeRiderModal", "closeRiderModal();", true);
                ShowClientNotification($"Rider {riderName} assigned successfully!", "success");
                LoadTickets();
                upTickets.Update();
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("BtnConfirmRider_Click ERROR: " + ex.Message);
                // Fix 7: Generic message to client
                ShowClientNotification("Error assigning rider. Please try again.", "error");
            }

            upRiderModal.Update();
        }

        protected void btnFilterOpen_Click(object sender, EventArgs e)
        {
            hfSelectedStatus.Value = "Open";
            LoadTickets();
        }

        protected void btnFilterInProgress_Click(object sender, EventArgs e)
        {
            hfSelectedStatus.Value = "In Progress";
            LoadTickets();
        }

        protected void btnFilterCompleted_Click(object sender, EventArgs e)
        {
            hfSelectedStatus.Value = "Completed";
            LoadTickets();
        }

        protected void btnFilterCancelled_Click(object sender, EventArgs e)
        {
            hfSelectedStatus.Value = "Cancelled";
            LoadTickets();
        }

        protected void btnFilterAll_Click(object sender, EventArgs e)
        {
            hfSelectedStatus.Value = "All";
            LoadTickets();
        }

        // ── Deduct inventory ingredients when a ticket is started ─────────────────
        private void DeductIngredientsByTicket(int ticketId)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    // Get all items in this ticket (MenuID + Quantity ordered)
                    string getItemsSql = "SELECT MenuID, Quantity FROM TicketItems WHERE TicketID = @TicketID";
                    DataTable ticketItems = new DataTable();
                    using (SqlCommand cmd = new SqlCommand(getItemsSql, conn))
                    {
                        cmd.Parameters.AddWithValue("@TicketID", ticketId);
                        new SqlDataAdapter(cmd).Fill(ticketItems);
                    }

                    // For each ordered item, deduct its recipe ingredients from inventory
                    string deductSql = @"
                        UPDATE inv
                        SET    inv.CurrentStock = inv.CurrentStock - (r.QuantityRequired * @PortionQty)
                        FROM   Inventory inv
                        INNER JOIN MenuRecipeIngredients r ON inv.InventoryID = r.InventoryID
                        WHERE  r.MenuID = @MenuID
                          AND  inv.IsActive = 1";

                    foreach (DataRow row in ticketItems.Rows)
                    {
                        int menuId = Convert.ToInt32(row["MenuID"]);
                        decimal portionQty = Convert.ToDecimal(row["Quantity"]);

                        using (SqlCommand deductCmd = new SqlCommand(deductSql, conn))
                        {
                            deductCmd.Parameters.AddWithValue("@MenuID", menuId);
                            deductCmd.Parameters.AddWithValue("@PortionQty", portionQty);
                            deductCmd.ExecuteNonQuery();
                        }
                    }

                    System.Diagnostics.Debug.WriteLine($"Ingredients deducted for TicketID: {ticketId}");
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"DeductIngredientsByTicket ERROR: {ex.Message}");
                // Fix 7: Generic message to client — full detail already in debug log
                ShowClientNotification("Warning: Inventory deduction failed. Please check inventory manually.", "error");
            }
        }

        private void ShowClientNotification(string msg, string type)
        {
            string safeMsg = msg.Replace("'", "\\'").Replace("\"", "\\\"");
            string script = $"showNotification('{safeMsg}', '{type}');";
            ScriptManager.RegisterStartupScript(this, GetType(), "notification_" + Guid.NewGuid().ToString(), script, true);
        }

        protected string GetStatusDotClass(string status)
        {
            switch (status)
            {
                case "Open":
                    return "open";
                case "In Progress":
                    return "inprogress";
                case "Completed":
                    return "completed";
                case "Cancelled":
                    return "cancelled";
                default:
                    return "";
            }
        }

        public class ModalMenuItem
        {
            public int MenuID { get; set; }
            public string ItemName { get; set; }
            public int Quantity { get; set; }
            public decimal UnitPrice { get; set; }
            public decimal SubTotal { get; set; }
        }
    }
}