using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TasteNet.Users.SuperAdmin
{
    public partial class CustomerManagement : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindCustomerData();
                UpdateStatistics();
            }
        }

        private void BindCustomerData()
        {
            List<CustomerRow> customers = new List<CustomerRow>
            {
                new CustomerRow { CustomerID = "CUST-001", FullName = "Jayr Casano", Username = "jayrcsn", Email = "jayrcsn@email.com", Contact = "0917-123-4567", DateRegistered = new DateTime(2024, 1, 15), Status = "ACTIVE", TotalOrders = 45, TotalSpent = 8750 },
                new CustomerRow { CustomerID = "CUST-002", FullName = "George Gonzaga", Username = "georgie", Email = "georgonzaga@email.com", Contact = "0918-234-5678", DateRegistered = new DateTime(2024, 2, 20), Status = "ACTIVE", TotalOrders = 32, TotalSpent = 6240 },
                new CustomerRow { CustomerID = "CUST-003", FullName = "Zea Mae Sulit", Username = "zeaasulit", Email = "zeamaesulit@email.com", Contact = "0919-345-6789", DateRegistered = new DateTime(2024, 3, 10), Status = "ACTIVE", TotalOrders = 28, TotalSpent = 5460 },
                new CustomerRow { CustomerID = "CUST-004", FullName = "Lalaine Reyes", Username = "lalareyes", Email = "lalainereyes@email.com", Contact = "0920-456-7890", DateRegistered = new DateTime(2024, 1, 28), Status = "BLOCKED", TotalOrders = 12, TotalSpent = 1980 },
                new CustomerRow { CustomerID = "CUST-005", FullName = "Bryle Magallano", Username = "bryce", Email = "bryleandremagallano@email.com", Contact = "0921-567-8901", DateRegistered = new DateTime(2024, 4, 5), Status = "ACTIVE", TotalOrders = 55, TotalSpent = 11250 },
            };

            rptCustomers.DataSource = customers;
            rptCustomers.DataBind();
        }

        private void UpdateStatistics()
        {
            int totalCustomers = 5;
            int activeCustomers = 4;
            int blockedCustomers = 1;
            decimal totalRevenue = 8750 + 6240 + 5460 + 1980 + 11250;

            ViewState["TotalCustomers"] = totalCustomers;
            ViewState["ActiveCustomers"] = activeCustomers;
            ViewState["BlockedCustomers"] = blockedCustomers;
            ViewState["TotalRevenue"] = totalRevenue;
        }
    }

    public class CustomerRow
    {
        public string CustomerID { get; set; }
        public string FullName { get; set; }
        public string Username { get; set; }
        public string Email { get; set; }
        public string Contact { get; set; }
        public DateTime DateRegistered { get; set; }
        public string Status { get; set; }
        public int TotalOrders { get; set; }
        public decimal TotalSpent { get; set; }
    }
}