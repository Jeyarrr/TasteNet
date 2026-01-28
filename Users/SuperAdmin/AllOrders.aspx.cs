using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TasteNet.Users.SuperAdmin
{
    public partial class AllOrders : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadMockData();
            }
        }
        private void LoadMockData()
        {
            var orders = new List<object>
            {
                new { OrderNumber = "12345", OrderDate = new DateTime(2025, 11, 22, 10, 45, 0), CustomerName = "Jay-r Casano", ItemsSummary = "Tapsilog x2, Iced Tea x1", TotalAmount = "350", PaymentMethod = "Cash on Delivery", OrderStatus = "Completed" },
                new { OrderNumber = "12344", OrderDate = new DateTime(2025, 11, 22, 10, 30, 0), CustomerName = "George Gonzaga", ItemsSummary = "Sizzling Sisig x1", TotalAmount = "280", PaymentMethod = "GCash", OrderStatus = "Active" },
                new { OrderNumber = "12343", OrderDate = new DateTime(2025, 11, 22, 10, 15, 0), CustomerName = "Zea Mae Sulit", ItemsSummary = "Longsilog x1, Coffee x1", TotalAmount = "320", PaymentMethod = "PayMaya", OrderStatus = "Active" },
                new { OrderNumber = "12342", OrderDate = new DateTime(2025, 11, 22, 10, 0, 0), CustomerName = "Lalaine Reyes", ItemsSummary = "Sizzling Pork x2", TotalAmount = "560", PaymentMethod = "Cash on Delivery", OrderStatus = "Completed" },
                new { OrderNumber = "12341", OrderDate = new DateTime(2025, 11, 22, 9, 45, 0), CustomerName = "Bryle Magallano", ItemsSummary = "Tocilog x1, Orange Juice x1", TotalAmount = "290", PaymentMethod = "GCash", OrderStatus = "Completed" },
                            };

            rptOrders.DataSource = orders;
            rptOrders.DataBind();
        }
    }
}
