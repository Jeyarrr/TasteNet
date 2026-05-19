using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web.Script.Serialization;

namespace TasteNet.Users.SuperAdmin
{
    public partial class CustomerManagement : System.Web.UI.Page
    {
        private readonly string _connStr =
            System.Configuration.ConfigurationManager.ConnectionStrings["TasteNetDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindCustomerData();
            }
        }

        private void BindCustomerData()
        {
            List<CustomerRow> customers = new List<CustomerRow>();

            string sql = @"
                SELECT
                    u.UserID,
                    u.FullName,
                    u.Username,
                    u.Email,
                    u.Phone,
                    u.CreatedAt,
                    u.IsActive,
                    (SELECT COUNT(*) FROM Tickets o WHERE o.CreatedBy = u.UserID) AS TotalOrders,
                    (SELECT ISNULL(SUM(o.TotalAmount), 0) FROM Tickets o WHERE o.CreatedBy = u.UserID) AS TotalSpent
                FROM Users u
                WHERE u.UserType = 'Customer'
                ORDER BY u.CreatedAt DESC";

            using (SqlConnection con = new SqlConnection(_connStr))
            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                con.Open();
                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    int rowNum = 1;
                    while (dr.Read())
                    {
                        bool isActive = Convert.ToBoolean(dr["IsActive"]);
                        int userId = Convert.ToInt32(dr["UserID"]);

                        customers.Add(new CustomerRow
                        {
                            CustomerID = "CUST-" + rowNum.ToString("D3"),
                            RawUserID = userId,
                            FullName = dr["FullName"].ToString(),
                            Username = dr["Username"].ToString(),
                            Email = dr["Email"].ToString(),
                            Contact = dr["Phone"].ToString(),
                            DateRegistered = Convert.ToDateTime(dr["CreatedAt"]),
                            Status = isActive ? "ACTIVE" : "BLOCKED",
                            TotalOrders = Convert.ToInt32(dr["TotalOrders"]),
                            TotalSpent = Convert.ToDecimal(dr["TotalSpent"]),
                            RecentOrdersJson = GetRecentOrdersJson(userId)
                        });
                        rowNum++;
                    }
                }
            }

            rptCustomers.DataSource = customers;
            rptCustomers.DataBind();

            int total = customers.Count;
            int active = customers.FindAll(c => c.Status == "ACTIVE").Count;
            int blocked = customers.FindAll(c => c.Status == "BLOCKED").Count;
            decimal revenue = 0;
            customers.ForEach(c => revenue += c.TotalSpent);

            lblTotalCustomers.Text = total.ToString();
            lblActiveCustomers.Text = active.ToString();
            lblBlockedCustomers.Text = blocked.ToString();
            lblTotalRevenue.Text = "&#8369;" + revenue.ToString("N0");
        }

        private string GetRecentOrdersJson(int userId)
        {
            var orders = new List<object>();

            string sql = @"
                SELECT TOP 5
                    t.TicketNumber,
                    t.CreatedAt,
                    t.TotalAmount,
                    t.Status
                FROM Tickets t
                WHERE t.CreatedBy = @UserID
                ORDER BY t.CreatedAt DESC";

            using (SqlConnection con = new SqlConnection(_connStr))
            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                cmd.Parameters.AddWithValue("@UserID", userId);
                con.Open();
                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        orders.Add(new
                        {
                            id = dr["TicketNumber"].ToString(),
                            date = Convert.ToDateTime(dr["CreatedAt"]).ToString("MMM dd, yyyy"),
                            amount = "&#8369;" + Convert.ToDecimal(dr["TotalAmount"]).ToString("N0"),
                            status = dr["Status"].ToString()
                        });
                    }
                }
            }

            return new JavaScriptSerializer().Serialize(orders);
        }

        protected void btnToggleBlock_Click(object sender, EventArgs e)
        {
            System.Web.UI.WebControls.LinkButton btn =
                (System.Web.UI.WebControls.LinkButton)sender;

            int userId = Convert.ToInt32(btn.CommandArgument);
            int newIsActive = btn.CommandName == "BLOCK" ? 0 : 1;

            using (SqlConnection con = new SqlConnection(_connStr))
            using (SqlCommand cmd = new SqlCommand(
                "UPDATE Users SET IsActive = @IsActive WHERE UserID = @UserID", con))
            {
                cmd.Parameters.AddWithValue("@IsActive", newIsActive);
                cmd.Parameters.AddWithValue("@UserID", userId);
                con.Open();
                cmd.ExecuteNonQuery();
            }

            BindCustomerData();
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            System.Web.UI.WebControls.LinkButton btn =
                (System.Web.UI.WebControls.LinkButton)sender;

            int userId = Convert.ToInt32(btn.CommandArgument);

            using (SqlConnection con = new SqlConnection(_connStr))
            using (SqlCommand cmd = new SqlCommand(
                "DELETE FROM Users WHERE UserID = @UserID AND UserType = 'Customer'", con))
            {
                cmd.Parameters.AddWithValue("@UserID", userId);
                con.Open();
                cmd.ExecuteNonQuery();
            }

            BindCustomerData();
        }

        protected string GetStatusClass(object status)
        {
            return status != null && status.ToString() == "ACTIVE"
                ? "status-badge--active"
                : "status-badge--blocked";
        }

        protected string GetStatus(object status)
        {
            return status != null && status.ToString() == "ACTIVE"
                ? "Active"
                : "Blocked";
        }

        public class CustomerRow
        {
            public string CustomerID { get; set; }
            public int RawUserID { get; set; }
            public string FullName { get; set; }
            public string Username { get; set; }
            public string Email { get; set; }
            public string Contact { get; set; }
            public DateTime DateRegistered { get; set; }
            public string Status { get; set; }
            public int TotalOrders { get; set; }
            public decimal TotalSpent { get; set; }
            public string RecentOrdersJson { get; set; }
        }
    }
}