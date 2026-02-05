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
        public class OrderItem
        {
            public string OrderNumber { get; set; }
            public DateTime OrderDate { get; set; }
            public string CustomerName { get; set; }
            public string ItemsSummary { get; set; }
            public string TotalAmount { get; set; }
            public string PaymentMethod { get; set; }
            public string OrderStatus { get; set; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadMockData();
            }
        }

        private void LoadMockData()
        {
            var orders = new List<OrderItem>
            {
                new OrderItem { OrderNumber = "ORD-2024-12345", OrderDate = new DateTime(2025, 11, 22, 10, 45, 0), CustomerName = "Jay-r Casano", ItemsSummary = "Tapsilog x2, Iced Tea x1", TotalAmount = "350", PaymentMethod = "Cash on Delivery", OrderStatus = "Completed" },
                new OrderItem { OrderNumber = "ORD-2024-12344", OrderDate = new DateTime(2025, 11, 22, 10, 30, 0), CustomerName = "George Gonzaga", ItemsSummary = "Sizzling Sisig x1", TotalAmount = "280", PaymentMethod = "GCash", OrderStatus = "Active" },
                new OrderItem { OrderNumber = "ORD-2024-12343", OrderDate = new DateTime(2025, 11, 22, 10, 15, 0), CustomerName = "Zea Mae Sulit", ItemsSummary = "Longsilog x1, Coffee x1", TotalAmount = "320", PaymentMethod = "PayMaya", OrderStatus = "Active" },
                new OrderItem { OrderNumber = "ORD-2024-12342", OrderDate = new DateTime(2025, 11, 22, 10, 0, 0), CustomerName = "Lalaine Reyes", ItemsSummary = "Sizzling Pork x2", TotalAmount = "560", PaymentMethod = "Cash on Delivery", OrderStatus = "Completed" },
                new OrderItem { OrderNumber = "ORD-2024-12341", OrderDate = new DateTime(2025, 11, 22, 9, 45, 0), CustomerName = "Bryle Magallano", ItemsSummary = "Tocilog x1, Orange Juice x1", TotalAmount = "290", PaymentMethod = "GCash", OrderStatus = "Completed" },
            };

            rptOrders.DataSource = orders;
            rptOrders.DataBind();

            UpdateTabCounts(orders);
        }

        private void UpdateTabCounts(List<OrderItem> orders)
        {
            int allCount = orders.Count;
            int activeCount = orders.Count(o => o.OrderStatus == "Active");
            int completedCount = orders.Count(o => o.OrderStatus == "Completed");
            int cancelledCount = orders.Count(o => o.OrderStatus == "Cancelled");
            int pendingCount = orders.Count(o => o.OrderStatus == "Pending");

            ScriptManager.RegisterStartupScript(this, GetType(), "UpdateCounts",
                $"updateTabCounts({allCount}, {activeCount}, {completedCount}, {cancelledCount}, {pendingCount});", true);
        }
    }
}