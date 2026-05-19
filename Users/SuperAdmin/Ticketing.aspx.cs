using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections.Generic;
using System.Linq;

namespace TasteNet.Users.SuperAdmin
{
    public partial class Ticketing : System.Web.UI.Page
    {
        private readonly string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["TasteNetDB"].ConnectionString;

        private List<ModalMenuItem> ModalItems
        {
            get
            {
                // Fix: If session expired, re-initialize and warn the user rather than silently blocking ticket creation
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
                ShowClientNotification("Error loading ticket counts: " + ex.Message, "error");
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
            EnsureRiderIDColumn();

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
                ShowClientNotification("Load error: " + ex.Message, "error");
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
                ShowClientNotification("Error loading menu: " + ex.Message, "error");
            }
        }

        protected void RptTickets_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
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
            int ticketId = Convert.ToInt32(e.CommandArgument);

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
                ShowClientNotification("Error updating status: " + ex.Message, "error");
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
                            throw ex;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Delete ERROR: {ex.Message}");
                throw ex;
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
                decimal price = decimal.Parse(pricePart);

                int qty = 1;
                if (!string.IsNullOrEmpty(txtQuantity.Text))
                {
                    int.TryParse(txtQuantity.Text, out qty);
                    if (qty < 1) qty = 1;
                }

                var existingItem = ModalItems.FirstOrDefault(x => x.MenuID == int.Parse(ddlMenuItem.SelectedValue));

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
                        MenuID = int.Parse(ddlMenuItem.SelectedValue),
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
                ShowClientNotification("Error adding item: " + ex.Message, "error");
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
            return $"ORD-{today}-{nextNumber:D3}";
        }

        /// <summary>
        /// Generates a sequential order number in format: ON-YYYYMMDD-XXX
        /// Must be called inside an open transaction to prevent race conditions.
        /// </summary>
        private string GenerateOrderNumber(SqlConnection conn, SqlTransaction trans)
        {
            string today = DateTime.Now.ToString("yyyyMMdd");
            int nextNumber = GetNextSequenceNumber(conn, trans, "OrderNumber", "ON", today);
            return $"ON-{today}-{nextNumber:D3}";
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
                string pattern = $"{prefix}-{datePrefix}-%";
                // Fix: Use RIGHT(field, 3) instead of SUBSTRING with a fragile offset
                string query = $@"
                    SELECT TOP 1 
                        CAST(RIGHT({fieldToCheck}, 3) AS INT) AS SeqNumber
                    FROM Tickets WITH (UPDLOCK, HOLDLOCK)
                    WHERE {fieldToCheck} LIKE @pattern
                    ORDER BY {fieldToCheck} DESC";

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
                                    setTimeout(function() {{ 
                                        __doPostBack('{upTickets.ClientID}', ''); 
                                    }}, 500);
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
                    ShowClientNotification("Database constraint error. Please check if Menu items exist.", "error");
                }
                else if (sqlEx.Number == 8152)
                {
                    ShowClientNotification("Data too long for one of the fields. Please check input lengths.", "error");
                }
                else
                {
                    ShowClientNotification($"Database error: {sqlEx.Message}", "error");
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Create ERROR: {ex.Message}");
                System.Diagnostics.Debug.WriteLine($"Stack Trace: {ex.StackTrace}");
                ShowClientNotification($"Create ERROR: {ex.Message}", "error");
            }
        }

        protected void DdlOrderType_SelectedIndexChanged(object sender, EventArgs e)
        {
            pnlDeliveryAddress.Visible = (ddlOrderType.SelectedValue == "Delivery");
            upModal.Update();
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
                ShowClientNotification("Error loading riders: " + ex.Message, "error");
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

            int ticketId = Convert.ToInt32(hfAssignTicketID.Value);
            int riderId = Convert.ToInt32(ddlRider.SelectedValue);
            string riderName = ddlRider.SelectedItem.Text;

            try
            {
                EnsureRiderIDColumn();
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
                ShowClientNotification("Error assigning rider: " + ex.Message, "error");
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
                ShowClientNotification("Warning: Inventory deduction failed. " + ex.Message, "error");
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