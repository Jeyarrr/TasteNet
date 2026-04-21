using System;
using System.Collections.Generic;
using System.Data.SqlClient;

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

            // Uses your actual Users table columns:
            // Phone, CreatedAt, IsActive (bit: 1=Active / 0=Blocked)
            // TotalOrders and TotalSpent are set to 0 for now.
            // Once you have an Orders table, replace the 0s with:
            //   (SELECT COUNT(*) FROM Orders o WHERE o.UserID = u.UserID) AS TotalOrders
            //   (SELECT ISNULL(SUM(o.TotalAmount),0) FROM Orders o WHERE o.UserID = u.UserID) AS TotalSpent
            string sql = @"
                SELECT
                    u.UserID,
                    u.FullName,
                    u.Username,
                    u.Email,
                    u.Phone,
                    u.CreatedAt,
                    u.IsActive,
                    0 AS TotalOrders,
                    0 AS TotalSpent
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
                        // IsActive is a bit column: 1 = Active, 0 = Blocked
                        bool isActive = Convert.ToBoolean(dr["IsActive"]);

                        customers.Add(new CustomerRow
                        {
                            CustomerID = "CUST-" + rowNum.ToString("D3"),
                            RawUserID = Convert.ToInt32(dr["UserID"]),
                            FullName = dr["FullName"].ToString(),
                            Username = dr["Username"].ToString(),
                            Email = dr["Email"].ToString(),
                            Contact = dr["Phone"].ToString(),
                            DateRegistered = Convert.ToDateTime(dr["CreatedAt"]),
                            Status = isActive ? "ACTIVE" : "BLOCKED",
                            TotalOrders = Convert.ToInt32(dr["TotalOrders"]),
                            TotalSpent = Convert.ToDecimal(dr["TotalSpent"])
                        });
                        rowNum++;
                    }
                }
            }

            rptCustomers.DataSource = customers;
            rptCustomers.DataBind();

            // Compute stats from the loaded data
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

        // Block / Unblock — flips IsActive bit in the DB
        protected void btnToggleBlock_Click(object sender, EventArgs e)
        {
            System.Web.UI.WebControls.LinkButton btn =
                (System.Web.UI.WebControls.LinkButton)sender;

            int userId = Convert.ToInt32(btn.CommandArgument);
            int newIsActive = btn.CommandName == "BLOCK" ? 0 : 1;  // BLOCK → 0, UNBLOCK → 1

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

        // Delete — removes the customer row from the DB
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
    }

    public class CustomerRow
    {
        public string CustomerID { get; set; }
        public int RawUserID { get; set; }
        public string FullName { get; set; }
        public string Username { get; set; }
        public string Email { get; set; }
        public string Contact { get; set; }   // maps to Phone
        public DateTime DateRegistered { get; set; }   // maps to CreatedAt
        public string Status { get; set; }   // "ACTIVE" or "BLOCKED" (derived from IsActive bit)
        public int TotalOrders { get; set; }
        public decimal TotalSpent { get; set; }
    }
}