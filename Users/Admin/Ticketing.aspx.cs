using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections.Generic;
using System.Linq;

namespace TasteNet.Users.Admin
{
    public partial class Ticketing : System.Web.UI.Page
    {
        private readonly string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["TasteNetDB"].ConnectionString;

        private List<ModalMenuItem> ModalItems
        {
            get
            {
                if (Session["ModalItems"] == null)
                    Session["ModalItems"] = new List<ModalMenuItem>();
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

        private void LoadTickets()
        {
            try
            {
                string status = string.IsNullOrEmpty(hfSelectedStatus.Value) ? "Open" : hfSelectedStatus.Value;
                System.Diagnostics.Debug.WriteLine($"Loading tickets with status: {status}");

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"
                        SELECT 
                            TicketID, 
                            TicketNumber, 
                            OrderNumber,
                            OrderType, 
                            DeliveryAddress,
                            Priority, 
                            Status, 
                            TotalAmount, 
                            CreatedAt,
                            FORMAT(CreatedAt, 'hh:mm tt') as CreatedTime,
                            DATEDIFF(MINUTE, CreatedAt, GETDATE()) as MinutesAgo
                        FROM Tickets 
                        WHERE (@Status = 'All' OR Status = @Status)
                        ORDER BY 
                            CASE WHEN Priority = 'Rush' THEN 0 ELSE 1 END, 
                            CASE WHEN Status = 'Open' THEN 0 WHEN Status = 'In Progress' THEN 1 ELSE 2 END,
                            CreatedAt DESC";

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
                ShowClientNotification("Ticket started successfully!", "success");
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
                string[] parts = selectedText.Split('-');
                string itemName = parts[0].Trim();
                string pricePart = parts[1].Trim().Replace("₱", "").Replace(",", "");
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
        /// Example: ORD-20260423-001, ORD-20260423-002, etc.
        /// </summary>
        private string GenerateTicketNumber()
        {
            string today = DateTime.Now.ToString("yyyyMMdd");
            int nextNumber = GetNextSequenceNumber("ORD", today);
            return $"ORD-{today}-{nextNumber:D3}";
        }

        /// <summary>
        /// Generates a sequential order number in format: ON-YYYYMMDD-XXX
        /// Example: ON-20260423-001, ON-20260423-002, etc.
        /// </summary>
        private string GenerateOrderNumber()
        {
            string today = DateTime.Now.ToString("yyyyMMdd");
            int nextNumber = GetNextSequenceNumber("ON", today);
            return $"ON-{today}-{nextNumber:D3}";
        }

        /// <summary>
        /// Gets the next sequence number for a given prefix and date
        /// </summary>
        /// <param name="prefix">Prefix like 'ORD' or 'ON'</param>
        /// <param name="datePrefix">Date in YYYYMMDD format</param>
        /// <returns>Next sequence number (1, 2, 3, etc.)</returns>
        private int GetNextSequenceNumber(string prefix, string datePrefix)
        {
            int nextNumber = 1;

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string pattern = $"{prefix}-{datePrefix}-%";
                    string query = @"
                        SELECT TOP 1 
                            CAST(SUBSTRING(TicketNumber, LEN(@pattern) - 2, 3) AS INT) AS SeqNumber
                        FROM Tickets 
                        WHERE TicketNumber LIKE @pattern
                        ORDER BY TicketNumber DESC";

                    string fieldToCheck = (prefix == "ORD") ? "TicketNumber" : "OrderNumber";
                    query = $@"
                        SELECT TOP 1 
                            CAST(SUBSTRING({fieldToCheck}, LEN(@pattern) - 2, 3) AS INT) AS SeqNumber
                        FROM Tickets 
                        WHERE {fieldToCheck} LIKE @pattern
                        ORDER BY {fieldToCheck} DESC";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@pattern", pattern);
                        conn.Open();
                        object result = cmd.ExecuteScalar();

                        if (result != null && result != DBNull.Value)
                        {
                            nextNumber = Convert.ToInt32(result) + 1;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"GetNextSequenceNumber ERROR: {ex.Message}");
                nextNumber = 1;
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
                string ticketNumber = GenerateTicketNumber();
                string orderNumber = GenerateOrderNumber();
                System.Diagnostics.Debug.WriteLine($"Creating ticket: {ticketNumber}, Order: {orderNumber}");

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    using (SqlTransaction trans = conn.BeginTransaction())
                    {
                        try
                        {
                            string ticketSql = @"
                                INSERT INTO Tickets (TicketNumber, OrderNumber, OrderType, DeliveryAddress, Priority, Status, TotalAmount)
                                VALUES (@num, @ordernum, @type, @addr, @priority, 'Open', @total);
                                SELECT CAST(SCOPE_IDENTITY() AS INT);";

                            using (SqlCommand cmd = new SqlCommand(ticketSql, conn, trans))
                            {
                                cmd.Parameters.AddWithValue("@num", ticketNumber);
                                cmd.Parameters.AddWithValue("@ordernum", orderNumber);
                                cmd.Parameters.AddWithValue("@type", ddlOrderType.SelectedValue);
                                cmd.Parameters.AddWithValue("@addr", DBNull.Value);
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

        protected void btnFilterAll_Click(object sender, EventArgs e)
        {
            hfSelectedStatus.Value = "All";
            LoadTickets();
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