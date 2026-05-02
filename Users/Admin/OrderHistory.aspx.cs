using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;

namespace TasteNet.Users.Admin
{
    public partial class OrderHistory : System.Web.UI.Page
    {
        private string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["TasteNetDB"].ConnectionString;
        private int pageSize = 10;
        public int CurrentPage { get; set; } = 1;
        private int totalRecords = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CurrentPage = 1;
                LoadStatistics();
                LoadOrders();
            }
            else
            {
                if (ViewState["CurrentPage"] != null)
                {
                    CurrentPage = (int)ViewState["CurrentPage"];
                }
                LoadOrders();
            }
        }

        protected void Page_PreRender(object sender, EventArgs e)
        {
            ViewState["CurrentPage"] = CurrentPage;
        }

        private void LoadStatistics()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    using (SqlCommand cmdTotal = new SqlCommand("SELECT COUNT(*) FROM Tickets", conn))
                    {
                        lblTotalOrders.Text = cmdTotal.ExecuteScalar().ToString();
                    }

                    using (SqlCommand cmdCompleted = new SqlCommand("SELECT COUNT(*) FROM Tickets WHERE Status = 'Completed'", conn))
                    {
                        lblCompletedOrders.Text = cmdCompleted.ExecuteScalar().ToString();
                    }

                    using (SqlCommand cmdProgress = new SqlCommand("SELECT COUNT(*) FROM Tickets WHERE Status = 'In Progress'", conn))
                    {
                        lblInProgressOrders.Text = cmdProgress.ExecuteScalar().ToString();
                    }

                    using (SqlCommand cmdRevenue = new SqlCommand("SELECT ISNULL(SUM(TotalAmount), 0) FROM Tickets WHERE Status = 'Completed'", conn))
                    {
                        decimal revenue = Convert.ToDecimal(cmdRevenue.ExecuteScalar());
                        lblTotalRevenue.Text = "₱" + revenue.ToString("N2");
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error loading statistics: " + ex.Message);
                lblTotalOrders.Text = "0";
                lblCompletedOrders.Text = "0";
                lblInProgressOrders.Text = "0";
                lblTotalRevenue.Text = "₱0.00";
            }
        }

        private void LoadOrders()
        {
            try
            {
                var orders = new List<OrderViewModel>();
                int offset = (CurrentPage - 1) * pageSize;

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string countQuery = @"
                        SELECT COUNT(*) 
                        FROM Tickets t
                        LEFT JOIN Users u ON t.CreatedBy = u.UserID
                        WHERE 1=1 " + GetFilterConditions();

                    using (SqlCommand cmdCount = new SqlCommand(countQuery, conn))
                    {
                        AddFilterParameters(cmdCount);
                        conn.Open();
                        totalRecords = Convert.ToInt32(cmdCount.ExecuteScalar());
                        conn.Close();
                    }

                    string query = @"
                        SELECT 
                            t.TicketID,
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
                            ISNULL(u.FullName, 'Guest') AS CustomerName,
                            u.Email AS CustomerEmail,
                            u.Phone AS CustomerPhone
                        FROM Tickets t
                        LEFT JOIN Users u ON t.CreatedBy = u.UserID
                        WHERE 1=1
                        " + GetFilterConditions() + @"
                        ORDER BY t.CreatedAt DESC
                        OFFSET @Offset ROWS
                        FETCH NEXT @PageSize ROWS ONLY";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Offset", offset);
                        cmd.Parameters.AddWithValue("@PageSize", pageSize);
                        AddFilterParameters(cmd);

                        conn.Open();

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                var order = new OrderViewModel
                                {
                                    TicketID = Convert.ToInt32(reader["TicketID"]),
                                    TicketNumber = reader["TicketNumber"].ToString(),
                                    OrderNumber = reader["OrderNumber"].ToString(),
                                    OrderType = reader["OrderType"].ToString(),
                                    DeliveryAddress = reader["DeliveryAddress"]?.ToString(),
                                    Status = reader["Status"].ToString(),
                                    Priority = reader["Priority"].ToString(),
                                    TotalAmount = Convert.ToDecimal(reader["TotalAmount"]),
                                    CreatedAt = Convert.ToDateTime(reader["CreatedAt"]),
                                    CustomerName = reader["CustomerName"].ToString(),
                                    CustomerEmail = reader["CustomerEmail"]?.ToString(),
                                    CustomerPhone = reader["CustomerPhone"]?.ToString()
                                };

                                orders.Add(order);
                            }
                        }
                    }

                    foreach (var order in orders)
                    {
                        order.Items = GetOrderItems(order.TicketID);
                    }
                }

                if (orders.Count > 0)
                {
                    rptOrders.Visible = true;
                    pnlEmptyData.Visible = false;
                    rptOrders.DataSource = orders;
                    rptOrders.DataBind();
                }
                else
                {
                    rptOrders.Visible = false;
                    pnlEmptyData.Visible = true;
                }

                SetupPagination();
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error loading orders: " + ex.Message);
                rptOrders.Visible = false;
                pnlEmptyData.Visible = true;
            }
        }

        private List<OrderItemViewModel> GetOrderItems(int ticketID)
        {
            var items = new List<OrderItemViewModel>();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"
                    SELECT 
                        TicketItemID,
                        FoodName,
                        Quantity,
                        UnitPrice,
                        SubTotal,
                        Status AS ItemStatus
                    FROM TicketItems 
                    WHERE TicketID = @TicketID";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@TicketID", ticketID);
                    conn.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            items.Add(new OrderItemViewModel
                            {
                                TicketItemID = Convert.ToInt32(reader["TicketItemID"]),
                                FoodName = reader["FoodName"].ToString(),
                                Quantity = Convert.ToDecimal(reader["Quantity"]),
                                UnitPrice = Convert.ToDecimal(reader["UnitPrice"]),
                                SubTotal = Convert.ToDecimal(reader["SubTotal"]),
                                Status = reader["ItemStatus"].ToString()
                            });
                        }
                    }
                }
            }

            return items;
        }

        private string GetFilterConditions()
        {
            string conditions = "";

            if (!string.IsNullOrEmpty(txtSearch.Text))
            {
                conditions += " AND (t.TicketNumber LIKE @Search OR t.OrderNumber LIKE @Search OR u.FullName LIKE @Search OR u.Phone LIKE @Search OR u.Email LIKE @Search)";
            }

            if (!string.IsNullOrEmpty(ddlStatus.SelectedValue))
            {
                conditions += " AND t.Status = @Status";
            }

            if (!string.IsNullOrEmpty(ddlOrderType.SelectedValue))
            {
                conditions += " AND t.OrderType = @OrderType";
            }

            if (!string.IsNullOrEmpty(ddlPriority.SelectedValue))
            {
                conditions += " AND t.Priority = @Priority";
            }

            if (!string.IsNullOrEmpty(ddlDateFilter.SelectedValue) && ddlDateFilter.SelectedValue != "all")
            {
                switch (ddlDateFilter.SelectedValue)
                {
                    case "today":
                        conditions += " AND CAST(t.CreatedAt AS DATE) = CAST(GETDATE() AS DATE)";
                        break;
                    case "week":
                        conditions += " AND t.CreatedAt >= DATEADD(day, -7, GETDATE())";
                        break;
                    case "month":
                        conditions += " AND t.CreatedAt >= DATEADD(month, -1, GETDATE())";
                        break;
                    case "year":
                        conditions += " AND t.CreatedAt >= DATEADD(year, -1, GETDATE())";
                        break;
                }
            }

            return conditions;
        }

        private void AddFilterParameters(SqlCommand cmd)
        {
            if (!string.IsNullOrEmpty(txtSearch.Text))
            {
                cmd.Parameters.AddWithValue("@Search", "%" + txtSearch.Text.Trim() + "%");
            }

            if (!string.IsNullOrEmpty(ddlStatus.SelectedValue))
            {
                cmd.Parameters.AddWithValue("@Status", ddlStatus.SelectedValue);
            }

            if (!string.IsNullOrEmpty(ddlOrderType.SelectedValue))
            {
                cmd.Parameters.AddWithValue("@OrderType", ddlOrderType.SelectedValue);
            }

            if (!string.IsNullOrEmpty(ddlPriority.SelectedValue))
            {
                cmd.Parameters.AddWithValue("@Priority", ddlPriority.SelectedValue);
            }
        }

        private void SetupPagination()
        {
            int totalPages = (int)Math.Ceiling((double)totalRecords / pageSize);
            var pages = new List<int>();

            for (int i = 1; i <= totalPages; i++)
            {
                pages.Add(i);
            }

            rptPagination.DataSource = pages;
            rptPagination.DataBind();

            foreach (RepeaterItem item in rptPagination.Items)
            {
                if (item.ItemType == ListItemType.Item || item.ItemType == ListItemType.AlternatingItem)
                {
                    var btnPage = (LinkButton)item.FindControl("btnPage");
                    if (btnPage != null && btnPage.Text == CurrentPage.ToString())
                    {
                        btnPage.CssClass = "page-link active";
                    }
                }
            }
        }

        protected void rptOrders_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                var order = (OrderViewModel)e.Item.DataItem;
                var phItems = (PlaceHolder)e.Item.FindControl("phItems");

                if (phItems != null && order.Items.Count > 0)
                {
                    var itemsHtml = new Literal();
                    string html = @"
                        <table class='items-table'>
                            <thead>
                                <tr>
                                    <th>ITEM</th>
                                    <th>QUANTITY</th>
                                    <th>PRICE</th>
                                    <th>SUBTOTAL</th>
                                    <th>STATUS</th>
                                </tr>
                            </thead>
                            <tbody>";

                    foreach (var item in order.Items)
                    {
                        html += $@"
                            <tr>
                                <td><strong>{item.FoodName}</strong></td>
                                <td>{item.Quantity}</td>
                                <td>₱{item.UnitPrice:N2}</td>
                                <td style='color: #6b0d1e; font-weight: 600;'>₱{item.SubTotal:N2}</td>
                                <td><span class='order-status status-{GetStatusClass(item.Status)}'>{item.Status}</span></td>
                            </tr>";
                    }

                    html += @"
                            </tbody>
                        </table>";

                    itemsHtml.Text = html;
                    phItems.Controls.Add(itemsHtml);
                }
            }
        }

        protected void rptOrders_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "View")
            {
                string ticketNumber = e.CommandArgument.ToString();
                ShowOrderDetails(ticketNumber);
            }
        }

        private void ShowOrderDetails(string ticketNumber)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"
                        SELECT 
                            t.TicketID,
                            t.TicketNumber,
                            t.OrderNumber,
                            t.OrderType,
                            t.DeliveryAddress,
                            t.Status,
                            t.Priority,
                            t.TotalAmount,
                            t.CreatedAt,
                            ISNULL(u.FullName, 'Guest') AS CustomerName,
                            u.Email AS CustomerEmail,
                            u.Phone AS CustomerPhone
                        FROM Tickets t
                        LEFT JOIN Users u ON t.CreatedBy = u.UserID
                        WHERE t.TicketNumber = @TicketNumber";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@TicketNumber", ticketNumber);
                        conn.Open();

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                int ticketID = Convert.ToInt32(reader["TicketID"]);
                                var items = GetOrderItems(ticketID);

                                var orderData = new
                                {
                                    orderNumber = reader["OrderNumber"].ToString(),
                                    orderType = reader["OrderType"].ToString(),
                                    status = reader["Status"].ToString(),
                                    priority = reader["Priority"].ToString(),
                                    totalAmount = Convert.ToDecimal(reader["TotalAmount"]),
                                    createdAt = Convert.ToDateTime(reader["CreatedAt"]).ToString("MMM dd, yyyy hh:mm tt"),
                                    customerName = reader["CustomerName"].ToString(),
                                    customerPhone = reader["CustomerPhone"]?.ToString() ?? "N/A",
                                    customerEmail = reader["CustomerEmail"]?.ToString() ?? "N/A",
                                    items = items.Select(i => new {
                                        i.FoodName,
                                        i.Quantity,
                                        i.UnitPrice,
                                        i.SubTotal,
                                        Status = string.IsNullOrEmpty(i.Status) ? "Pending" : i.Status
                                    })
                                };

                                string json = JsonConvert.SerializeObject(orderData);
                                string script = $"showOrderDetailsModal({JsonConvert.SerializeObject(json)});";
                                ScriptManager.RegisterStartupScript(this, GetType(), "showModal", script, true);
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error showing details: " + ex.Message);
                string script = $"showNotification('Error loading order details: {ex.Message.Replace("'", "\\'")}', 'error');";
                ScriptManager.RegisterStartupScript(this, GetType(), "modalError", script, true);
            }
        }

        protected void btnUpdateStatus_Click(object sender, EventArgs e)
        {
            try
            {
                string orderNumber = Request.Form["hiddenOrderNumber"];
                string newStatus = Request.Form["hiddenNewStatus"];

                if (!string.IsNullOrEmpty(orderNumber) && !string.IsNullOrEmpty(newStatus))
                {
                    using (SqlConnection conn = new SqlConnection(connectionString))
                    {
                        string query = @"
                            UPDATE Tickets 
                            SET Status = @Status,
                                CompletedAt = CASE WHEN @Status = 'Completed' THEN GETDATE() ELSE CompletedAt END,
                                StartedAt = CASE WHEN @Status = 'In Progress' AND Status = 'Open' THEN GETDATE() ELSE StartedAt END
                            WHERE TicketNumber = @TicketNumber";

                        using (SqlCommand cmd = new SqlCommand(query, conn))
                        {
                            cmd.Parameters.AddWithValue("@TicketNumber", orderNumber);
                            cmd.Parameters.AddWithValue("@Status", newStatus);
                            conn.Open();
                            int rowsAffected = cmd.ExecuteNonQuery();

                            if (rowsAffected > 0)
                            {
                                LoadStatistics();
                                LoadOrders();

                                string script = "showNotification('Order status updated successfully!', 'success');";
                                ScriptManager.RegisterStartupScript(this, GetType(), "updateSuccess", script, true);
                            }
                            else
                            {
                                string script = "showNotification('Order not found!', 'error');";
                                ScriptManager.RegisterStartupScript(this, GetType(), "updateNotFound", script, true);
                            }
                        }
                    }
                }
                else
                {
                    string script = "showNotification('Missing order information!', 'error');";
                    ScriptManager.RegisterStartupScript(this, GetType(), "updateMissing", script, true);
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error updating status: " + ex.Message);
                string script = $"showNotification('Error updating status: {ex.Message.Replace("'", "\\'")}', 'error');";
                ScriptManager.RegisterStartupScript(this, GetType(), "updateError", script, true);
            }
        }

        protected void rptPagination_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Page")
            {
                CurrentPage = Convert.ToInt32(e.CommandArgument);
                LoadOrders();
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            CurrentPage = 1;
            LoadOrders();

            string script = "var searchBox = document.getElementById('searchBox'); if(searchBox) searchBox.classList.remove('loading');";
            ScriptManager.RegisterStartupScript(this, GetType(), "removeLoading", script, true);
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            ddlStatus.SelectedIndex = 0;
            ddlOrderType.SelectedIndex = 0;
            ddlPriority.SelectedIndex = 0;
            ddlDateFilter.SelectedIndex = 0;
            CurrentPage = 1;
            LoadOrders();
        }

        protected void btnExport_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"
                        SELECT 
                            t.TicketNumber AS 'Order #',
                            t.OrderNumber AS 'Order No',
                            t.OrderType AS 'Type',
                            ISNULL(u.FullName, 'Guest') AS 'Customer',
                            u.Phone AS 'Phone',
                            u.Email AS 'Email',
                            t.Status,
                            t.Priority,
                            t.TotalAmount AS 'Total',
                            t.CreatedAt AS 'Date'
                        FROM Tickets t
                        LEFT JOIN Users u ON t.CreatedBy = u.UserID
                        ORDER BY t.CreatedAt DESC";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        conn.Open();
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            var dt = new DataTable();
                            dt.Load(reader);

                            string csv = "";
                            foreach (DataColumn col in dt.Columns)
                            {
                                csv += col.ColumnName + ",";
                            }
                            csv = csv.TrimEnd(',') + "\n";

                            foreach (DataRow row in dt.Rows)
                            {
                                foreach (var item in row.ItemArray)
                                {
                                    string value = item?.ToString().Replace("\"", "\"\"");
                                    csv += "\"" + value + "\",";
                                }
                                csv = csv.TrimEnd(',') + "\n";
                            }

                            Response.Clear();
                            Response.ContentType = "text/csv";
                            Response.AddHeader("Content-Disposition", $"attachment; filename=OrderHistory_{DateTime.Now:yyyyMMdd_HHmmss}.csv");
                            Response.Write(csv);
                            Response.End();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Export error: " + ex.Message);
                string script = $"alert('Error exporting report: {ex.Message.Replace("'", "\\'")}');";
                ScriptManager.RegisterStartupScript(this, GetType(), "exportError", script, true);
            }
        }

        public string GetStatusClass(string status)
        {
            switch (status?.ToLower())
            {
                case "open": return "open";
                case "in progress": return "inprogress";
                case "completed": return "completed";
                case "cancelled": return "cancelled";
                default: return "default";
            }
        }

        public string GetOrderTypeIcon(string orderType)
        {
            switch (orderType?.ToLower())
            {
                case "delivery": return "fa-truck";
                case "dine-in": return "fa-utensils";
                case "takeout": return "fa-box";
                default: return "fa-shopping-bag";
            }
        }
    }

    [Serializable]
    public class OrderViewModel
    {
        public int TicketID { get; set; }
        public string TicketNumber { get; set; }
        public string OrderNumber { get; set; }
        public string OrderType { get; set; }
        public string DeliveryAddress { get; set; }
        public string Status { get; set; }
        public string Priority { get; set; }
        public decimal TotalAmount { get; set; }
        public DateTime CreatedAt { get; set; }
        public DateTime? StartedAt { get; set; }
        public DateTime? CompletedAt { get; set; }
        public string CustomerName { get; set; }
        public string CustomerEmail { get; set; }
        public string CustomerPhone { get; set; }
        public List<OrderItemViewModel> Items { get; set; } = new List<OrderItemViewModel>();
    }

    [Serializable]
    public class OrderItemViewModel
    {
        public int TicketItemID { get; set; }
        public string FoodName { get; set; }
        public decimal Quantity { get; set; }
        public decimal UnitPrice { get; set; }
        public decimal SubTotal { get; set; }
        public string Status { get; set; }
    }
}