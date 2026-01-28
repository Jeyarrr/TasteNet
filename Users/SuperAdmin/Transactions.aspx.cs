using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TasteNet.Users.SuperAdmin
{
    public partial class Transactions : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadData();
            }
        }
        private void LoadData()
        {
            var data = new List<object>
            {
                new { TxnID = "TXN-001234", OrderID = "ORD-5678", Customer = "Jay-r Casano", Method = "GCash", Date = new DateTime(2024, 1, 8, 14, 23, 15), Amount = "435", Status = "Paid" },
                new { TxnID = "TXN-001235", OrderID = "ORD-5679", Customer = "George Gonzaga", Method = "Cash on Delivery", Date = new DateTime(2024, 1, 8, 13, 45, 22), Amount = "280", Status = "Paid" },
                new { TxnID = "TXN-001236", OrderID = "ORD-5680", Customer = "Zea Mae Sulit", Method = "GCash", Date = new DateTime(2024, 1, 8, 13, 12, 45), Amount = "520", Status = "Pending" },
                new { TxnID = "TXN-001237", OrderID = "ORD-5681", Customer = "Lalaine Reyes", Method = "PayMaya", Date = new DateTime(2024, 1, 8, 12, 34, 18), Amount = "195", Status = "Paid" },
                new { TxnID = "TXN-001238", OrderID = "ORD-5682", Customer = "Bryle Andre Magallano", Method = "Cash on Delivery", Date = new DateTime(2024, 1, 8, 11, 56, 33), Amount = "360", Status = "Paid" },
                new { TxnID = "TXN-001239", OrderID = "ORD-5683", Customer = "Bossing Kamusta", Method = "Bank Transfer", Date = new DateTime(2024, 1, 8, 11, 23, 08), Amount = "1,250", Status = "Failed" }
            };

            rptTransactions.DataSource = data;
            rptTransactions.DataBind();
        }
    }
}