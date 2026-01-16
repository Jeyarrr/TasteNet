using System;
using System.Collections.Generic;
using System.Data;

namespace TasteNet
{
    public partial class UserManagement : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDummyData();
            }
        }

        private void LoadDummyData()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("CustomerID");
            dt.Columns.Add("FullName");
            dt.Columns.Add("Username");
            dt.Columns.Add("Email");
            dt.Columns.Add("Contact");
            dt.Columns.Add("DateRegistered", typeof(DateTime));
            dt.Columns.Add("Status");
            dt.Columns.Add("TotalOrders");
            dt.Columns.Add("TotalSpent");

            dt.Rows.Add("CUST-001", "Maria Santos", "mariasantos", "maria.santos@email.com", "0917-123-4567", new DateTime(2024, 1, 15), "ACTIVE", 45, 8750);
            dt.Rows.Add("CUST-002", "Juan Dela Cruz", "juandc", "juan.delacruz@email.com", "0918-234-5678", new DateTime(2024, 2, 20), "ACTIVE", 32, 6240);
            dt.Rows.Add("CUST-003", "Ana Reyes", "anareyes", "ana.reyes@email.com", "0919-345-6789", new DateTime(2024, 3, 10), "ACTIVE", 28, 5460);
            dt.Rows.Add("CUST-004", "Carlos Mendoza", "carlosmendoza", "carlos.m@email.com", "0920-456-7890", new DateTime(2024, 1, 28), "BLOCKED", 12, 1980);

            rptCustomers.DataSource = dt;
            rptCustomers.DataBind();
        }
    }
}