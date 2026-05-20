using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TasteNet.Users.Customer
{
    public partial class CustomerPortal : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["TasteNetDB"].ConnectionString;
        private int currentUserId = 0;

        public class MenuItem
        {
            public int MenuID { get; set; }
            public string Name { get; set; }
            public decimal Price { get; set; }
            public string ImagePath { get; set; }
            public string FoodType { get; set; }
            public string Description { get; set; }
            public string Status { get; set; }
        }

        public class MenuCategoryGroup
        {
            public string FoodType { get; set; }
            public List<MenuItem> Items { get; set; }
        }

        public class CartItemServer
        {
            public string CartItemId { get; set; }
            public int MenuID { get; set; }
            public string Name { get; set; }
            public decimal Price { get; set; }
            public int Quantity { get; set; }
            public string SpecialRequest { get; set; }
        }

        public class PaymentMethodItem
        {
            public int PaymentMethodId { get; set; }
            public string MethodName { get; set; }
            public string AccountDetails { get; set; }
            public string Instructions { get; set; }
            public string Status { get; set; }
            public bool IsEnabled { get; set; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Session["UserID"] = 1;
                Session["UserType"] = "Customer";
                Session["Username"] = "customer@tastenet.com";
            }

            if (Session["UserID"] != null)
            {
                currentUserId = Convert.ToInt32(Session["UserID"]);

                if (!IsPostBack)
                {
                    LoadBarangayDropdowns();
                    LoadUserProfile();
                    LoadMenuItems();
                    BindCartRepeater();
                    UpdateCartTotals();
                    LoadOrdersData();
                }
                // Always rebind payment methods on every request (including postbacks)
                // so the repeater is never empty after a postback triggers the checkout modal
                LoadPaymentMethods();
            }
            else
            {
                Response.Redirect("~/Login.aspx");
            }
        }

        // ============ HELPER METHODS ============

        // Helper method to parse full address into separate textboxes
        private void ParseAddressToFields(string fullAddress)
        {
            // Clear all fields first
            txtHouseNo.Text = "";
            txtStreet.Text = "";
            ddlBarangay.SelectedIndex = 0;
            txtCity.Text = "Dasmariñas";

            if (string.IsNullOrEmpty(fullAddress))
            {
                litDefaultAddress.Text = "No address set. Please update your profile.";
                return;
            }

            // Parse address format: "HouseNo, Street, Barangay, Dasmariñas"
            string[] parts = fullAddress.Split(new[] { ',' }, StringSplitOptions.RemoveEmptyEntries);

            if (parts.Length >= 1) txtHouseNo.Text = parts[0].Trim();
            if (parts.Length >= 2) txtStreet.Text = parts[1].Trim();
            if (parts.Length >= 3)
            {
                string savedBarangay = parts[2].Trim();
                var matchItem = ddlBarangay.Items.FindByValue(savedBarangay);
                if (matchItem != null)
                    ddlBarangay.SelectedValue = savedBarangay;
            }

            // City is always Dasmariñas
            txtCity.Text = "Dasmariñas";

            // Update the default address display in checkout
            litDefaultAddress.Text = fullAddress;
        }

        // Helper method to combine separate fields into one address
        private string CombineAddressFields()
        {
            List<string> addressParts = new List<string>();

            if (!string.IsNullOrEmpty(txtHouseNo.Text))
                addressParts.Add(txtHouseNo.Text.Trim());

            if (!string.IsNullOrEmpty(txtStreet.Text))
                addressParts.Add(txtStreet.Text.Trim());

            if (!string.IsNullOrEmpty(ddlBarangay.SelectedValue))
                addressParts.Add(ddlBarangay.SelectedValue.Trim());

            // City is always Dasmariñas
            addressParts.Add("Dasmariñas");

            string fullAddress = string.Join(", ", addressParts);

            // Remove any double commas or empty parts
            fullAddress = System.Text.RegularExpressions.Regex.Replace(fullAddress, @",\s*,", ",");
            fullAddress = fullAddress.Trim(',', ' ');

            return fullAddress;
        }

        // Helper method to combine new address fields from checkout
        private string CombineNewAddressFields()
        {
            List<string> addressParts = new List<string>();

            if (!string.IsNullOrEmpty(txtNewHouseNo.Text))
                addressParts.Add(txtNewHouseNo.Text.Trim());

            if (!string.IsNullOrEmpty(txtNewStreet.Text))
                addressParts.Add(txtNewStreet.Text.Trim());

            if (!string.IsNullOrEmpty(ddlNewBarangay.SelectedValue))
                addressParts.Add(ddlNewBarangay.SelectedValue.Trim());

            // City is always Dasmariñas
            addressParts.Add("Dasmariñas");

            if (!string.IsNullOrEmpty(txtNewLandmark.Text))
                addressParts.Add("(" + txtNewLandmark.Text.Trim() + ")");

            string fullAddress = string.Join(", ", addressParts);

            // Remove any double commas or empty parts
            fullAddress = System.Text.RegularExpressions.Regex.Replace(fullAddress, @",\s*,", ",");
            fullAddress = fullAddress.Trim(',', ' ');

            return fullAddress;
        }

        // ============ CART METHODS ============

        private List<CartItemServer> GetCart()
        {
            if (Session["ServerCart"] == null)
            {
                Session["ServerCart"] = new List<CartItemServer>();
            }
            return (List<CartItemServer>)Session["ServerCart"];
        }

        private void SaveCart(List<CartItemServer> cart)
        {
            Session["ServerCart"] = cart;
            BindCartRepeater();
            UpdateCartTotals();
            UpdateCartBadge();
        }

        private void BindCartRepeater()
        {
            List<CartItemServer> cart = GetCart();
            rptCart.DataSource = cart;
            rptCart.DataBind();

            pnlEmptyCart.Visible = (cart.Count == 0);
            btnCheckout.Enabled = (cart.Count > 0);
        }

        private void UpdateCartTotals()
        {
            List<CartItemServer> cart = GetCart();
            decimal subtotal = cart.Sum(item => item.Price * item.Quantity);

            // Get barangay from profile dropdown (already loaded)
            string barangay = ddlBarangay.SelectedValue;
            decimal barangayFee = GetDeliveryFeeByBarangay(barangay);
            decimal deliveryFee = subtotal >= 500 ? 0 : barangayFee;

            decimal total = subtotal + deliveryFee;

            litSubtotal.Text = subtotal.ToString("F2");
            litDeliveryFee.Text = deliveryFee == 0 ? "FREE" : "₱" + deliveryFee.ToString("F2");
            litTotal.Text = total.ToString("F2");
            btnCheckout.Text = $"Checkout - ₱{total:F2}";
        }

        // Looks up the delivery fee for a given barangay name from the DeliveryFees table.
        // Returns a fallback of ₱50 if the barangay is not found or not selected.
        private decimal GetDeliveryFeeByBarangay(string barangayName)
        {
            if (string.IsNullOrWhiteSpace(barangayName))
                return 50m; // fallback default

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    string query = "SELECT Fee FROM DeliveryFees WHERE BarangayName = @BarangayName";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@BarangayName", barangayName.Trim());
                        object result = cmd.ExecuteScalar();
                        if (result != null && result != DBNull.Value)
                            return Convert.ToDecimal(result);
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error fetching delivery fee: " + ex.Message);
            }

            return 50m; // fallback default
        }

        // Populates the barangay dropdowns from the DeliveryFees table
        // ============ PAYMENT METHODS ============

        private void LoadPaymentMethods()
        {
            var methods = new List<PaymentMethodItem>();

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    // Table is: dbo.PaymentMethods (with S)
                    // Status values in DB: Active / Inactive
                    // IsEnabled: 1 = enabled, 0 = disabled
                    string sql = @"SELECT PaymentMethodId, MethodName, IsEnabled,
                                          DisplayOrder, AccountDetails, Instructions, Status
                                   FROM PaymentMethods
                                   ORDER BY DisplayOrder ASC";

                    using (SqlCommand cmd = new SqlCommand(sql, conn))
                    using (SqlDataReader rdr = cmd.ExecuteReader())
                    {
                        while (rdr.Read())
                        {
                            string acct = rdr["AccountDetails"] != DBNull.Value ? rdr["AccountDetails"].ToString() : "";
                            string instr = rdr["Instructions"] != DBNull.Value ? rdr["Instructions"].ToString() : "";
                            string status = rdr["Status"] != DBNull.Value ? rdr["Status"].ToString() : "Active";
                            bool enabled = rdr["IsEnabled"] != DBNull.Value && Convert.ToBoolean(rdr["IsEnabled"]);

                            methods.Add(new PaymentMethodItem
                            {
                                PaymentMethodId = Convert.ToInt32(rdr["PaymentMethodId"]),
                                MethodName = rdr["MethodName"].ToString(),
                                AccountDetails = acct,
                                Instructions = instr,
                                Status = status,
                                IsEnabled = enabled
                            });
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("LoadPaymentMethods error: " + ex.Message);
            }

            rptPaymentMethods.DataSource = methods;
            rptPaymentMethods.DataBind();
        }

        protected string GetPaymentIcon(string methodName)
        {
            if (string.IsNullOrEmpty(methodName)) return "fas fa-credit-card";
            string name = methodName.ToUpper();
            if (name.Contains("GCASH") || name.Contains("MAYA") || name.Contains("PAYMAYA"))
                return "fas fa-mobile-alt";
            if (name.Contains("COD") || name.Contains("CASH"))
                return "fas fa-money-bill-wave";
            if (name.Contains("BANK") || name.Contains("TRANSFER"))
                return "fas fa-university";
            if (name.Contains("CARD") || name.Contains("CREDIT") || name.Contains("DEBIT"))
                return "fas fa-credit-card";
            return "fas fa-wallet";
        }

        private void LoadBarangayDropdowns()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    string query = "SELECT BarangayName, Fee FROM DeliveryFees ORDER BY BarangayName";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        var items = new System.Web.UI.WebControls.ListItemCollection();
                        items.Add(new System.Web.UI.WebControls.ListItem("-- Select Barangay --", ""));

                        while (reader.Read())
                        {
                            string name = reader["BarangayName"].ToString();
                            decimal fee = Convert.ToDecimal(reader["Fee"]);
                            items.Add(new System.Web.UI.WebControls.ListItem(
                                $"{name} (₱{fee:F0} delivery fee)", name));
                        }

                        ddlBarangay.Items.Clear();
                        foreach (System.Web.UI.WebControls.ListItem li in items)
                            ddlBarangay.Items.Add(li);

                        ddlNewBarangay.Items.Clear();
                        foreach (System.Web.UI.WebControls.ListItem li in items)
                            ddlNewBarangay.Items.Add(li);
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error loading barangay list: " + ex.Message);
            }
        }

        private void UpdateCartBadge()
        {
            int count = GetCart().Sum(x => x.Quantity);
            string script = $"updateCartBadge({count});";
            ClientScript.RegisterStartupScript(this.GetType(), "updateBadge", script, true);
        }

        private void AddToCart(int menuId, string name, decimal price, int quantity = 1, string specialRequest = "")
        {
            List<CartItemServer> cart = GetCart();

            var existing = cart.FirstOrDefault(x => x.MenuID == menuId && x.SpecialRequest == specialRequest);

            if (existing != null)
            {
                existing.Quantity += quantity;
            }
            else
            {
                cart.Add(new CartItemServer
                {
                    CartItemId = Guid.NewGuid().ToString(),
                    MenuID = menuId,
                    Name = specialRequest != "" ? $"{name} (📝 {specialRequest.Substring(0, Math.Min(30, specialRequest.Length))})" : name,
                    Price = price,
                    Quantity = quantity,
                    SpecialRequest = specialRequest
                });
            }

            SaveCart(cart);

            string successScript = $"showNotification('Added {name} to cart!', false); openCartModal();";
            ClientScript.RegisterStartupScript(this.GetType(), "cartAdded", successScript, true);
        }

        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            string[] args = btn.CommandArgument.Split('|');

            int menuId = Convert.ToInt32(args[0]);
            string name = args[1];
            decimal price = Convert.ToDecimal(args[2]);

            AddToCart(menuId, name, price, 1, "");
        }

        protected void btnView_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            string[] args = btn.CommandArgument.Split('|');

            hdnSelectedMenuID.Value = args[0];
            hdnSelectedMenuName.Value = args[1];
            hdnSelectedMenuPrice.Value = args[2];

            string name = args[1].Replace("'", "\\'");
            string description = args.Length > 3 ? args[3].Replace("'", "\\'") : "Delicious meal prepared fresh daily!";
            string image = args.Length > 4 ? args[4] : "";

            string script = $"openMealModal('{args[0]}', '{name}', '{args[2]}', '{description}', '{image}');";
            ClientScript.RegisterStartupScript(this.GetType(), "openModal", script, true);
        }

        protected void btnAddToCartFromModal_Click(object sender, EventArgs e)
        {
            int menuId = Convert.ToInt32(hdnSelectedMenuID.Value);
            string name = hdnSelectedMenuName.Value;
            decimal basePrice = Convert.ToDecimal(hdnSelectedMenuPrice.Value);
            int quantity = string.IsNullOrEmpty(hdnSelectedQuantity.Value) ? 1 : Convert.ToInt32(hdnSelectedQuantity.Value);
            string specialRequest = hdnSelectedSpecialRequest.Value;
            string extras = hdnSelectedExtras.Value;

            decimal extrasTotal = 0;
            if (!string.IsNullOrEmpty(extras))
            {
                string[] extraItems = extras.Split(',');
                foreach (string extra in extraItems)
                {
                    string extraTrimmed = extra.Trim();
                    if (extraTrimmed == "Extra Rice") extrasTotal += 15;
                    else if (extraTrimmed == "Add Egg") extrasTotal += 10;
                    else if (extraTrimmed == "Extra Spicy") extrasTotal += 5;
                    else if (extraTrimmed == "Extra Sauce") extrasTotal += 10;
                }
            }

            decimal finalPrice = basePrice + extrasTotal;
            string displayName = name;
            if (!string.IsNullOrEmpty(extras)) displayName += " (+" + extras + ")";
            if (!string.IsNullOrEmpty(specialRequest)) displayName += " - " + specialRequest;

            List<CartItemServer> cart = GetCart();
            var existing = cart.FirstOrDefault(x => x.MenuID == menuId && x.SpecialRequest == specialRequest);

            if (existing != null)
            {
                existing.Quantity += quantity;
            }
            else
            {
                cart.Add(new CartItemServer
                {
                    CartItemId = Guid.NewGuid().ToString(),
                    MenuID = menuId,
                    Name = displayName.Length > 100 ? displayName.Substring(0, 100) : displayName,
                    Price = finalPrice,
                    Quantity = quantity,
                    SpecialRequest = specialRequest
                });
            }

            SaveCart(cart);

            hdnSelectedMenuID.Value = "";
            hdnSelectedMenuName.Value = "";
            hdnSelectedMenuPrice.Value = "";
            hdnSelectedQuantity.Value = "";
            hdnSelectedSpecialRequest.Value = "";
            hdnSelectedExtras.Value = "";

            string script = $"showNotification('Added {name.Replace("'", "\\'")} to cart!', false); closeMealModal(); openCartModal();";
            ClientScript.RegisterStartupScript(this.GetType(), "cartAddedModal", script, true);
        }

        protected void rptCart_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            List<CartItemServer> cart = GetCart();
            string cartItemId = e.CommandArgument.ToString();
            var item = cart.FirstOrDefault(x => x.CartItemId == cartItemId);

            if (item == null) return;

            if (e.CommandName == "Remove")
            {
                cart.Remove(item);
            }
            else if (e.CommandName == "Update")
            {
                TextBox txtQty = (TextBox)e.Item.FindControl("txtQty");
                int newQty;
                if (int.TryParse(txtQty.Text, out newQty) && newQty >= 1 && newQty <= 99)
                {
                    item.Quantity = newQty;
                }
                else
                {
                    item.Quantity = 1;
                }
            }

            SaveCart(cart);
        }

        protected void btnClearCart_Click(object sender, EventArgs e)
        {
            Session["ServerCart"] = new List<CartItemServer>();
            BindCartRepeater();
            UpdateCartTotals();
            UpdateCartBadge();

            ClientScript.RegisterStartupScript(this.GetType(), "closeCart", "closeCartModal();", true);
        }

        protected void btnCheckout_Click(object sender, EventArgs e)
        {
            List<CartItemServer> cart = GetCart();

            if (cart.Count == 0)
            {
                ShowCartMessage("Your cart is empty", false);
                return;
            }

            // Open checkout modal
            string script = "openCheckoutModal();";
            ClientScript.RegisterStartupScript(this.GetType(), "openCheckout", script, true);
        }

        // ============ CHECKOUT CONFIRMATION ============

        protected void btnConfirmOrder_Click(object sender, EventArgs e)
        {
            string deliveryAddress = "";
            string paymentMethod = "";

            // Get payment method from radio buttons
            if (Request.Form["paymentMethod"] != null)
            {
                paymentMethod = Request.Form["paymentMethod"].ToString();
            }
            else
            {
                paymentMethod = "COD";
            }

            // Get special instructions
            string specialInstructions = txtCheckoutInstructions.Text;

            // Check if using new address or profile address
            bool useNewAddress = false;
            if (useNewAddressCheckbox != null)
            {
                useNewAddress = useNewAddressCheckbox.Checked;
            }

            if (useNewAddress)
            {
                deliveryAddress = CombineNewAddressFields();

                // Validate new address fields
                if (string.IsNullOrWhiteSpace(txtNewHouseNo.Text) ||
                    string.IsNullOrWhiteSpace(txtNewStreet.Text) ||
                    string.IsNullOrWhiteSpace(ddlNewBarangay.SelectedValue))
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "showError",
                        "showNotification('Please fill in all address fields (House No, Street, Barangay)!', true);", true);
                    return;
                }
            }
            else
            {
                deliveryAddress = CombineAddressFields();

                // Validate profile address
                if (string.IsNullOrWhiteSpace(txtHouseNo.Text) ||
                    string.IsNullOrWhiteSpace(txtStreet.Text) ||
                    string.IsNullOrWhiteSpace(ddlBarangay.SelectedValue))
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "showError",
                        "showNotification('Please update your delivery address in Profile Settings first!', true);", true);
                    return;
                }
            }

            // Proceed with order
            List<CartItemServer> cart = GetCart();
            if (cart.Count > 0)
            {
                PlaceOrderWithDetails(cart, deliveryAddress, paymentMethod, specialInstructions);
            }
            else
            {
                ShowCartMessage("Your cart is empty", false);
            }
        }

        private void PlaceOrderWithDetails(List<CartItemServer> cart, string deliveryAddress, string paymentMethod, string specialInstructions)
        {
            try
            {
                string ticketNumber = "TKT-" + DateTime.Now.ToString("yyyyMMdd") + "-" + new Random().Next(1000, 9999);
                string orderNumber = "ON-" + DateTime.Now.ToString("yyyyMMdd") + "-" + new Random().Next(1000, 9999);
                decimal subtotal = cart.Sum(x => x.Price * x.Quantity);

                // Determine the barangay: prefer new address dropdown if in use, else profile dropdown
                bool useNewAddress = useNewAddressCheckbox != null && useNewAddressCheckbox.Checked;
                string barangayForFee = useNewAddress
                    ? ddlNewBarangay.SelectedValue
                    : ddlBarangay.SelectedValue;

                decimal barangayFee = GetDeliveryFeeByBarangay(barangayForFee);
                decimal deliveryFee = subtotal >= 500 ? 0 : barangayFee;
                decimal totalAmount = subtotal + deliveryFee;

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    SqlTransaction transaction = conn.BeginTransaction();

                    try
                    {
                        string ticketQuery = @"
                            INSERT INTO Tickets (TicketNumber, OrderNumber, OrderType, DeliveryAddress, 
                                                Status, Priority, TotalAmount, PaymentMethod, CreatedAt, CreatedBy)
                            VALUES (@TicketNumber, @OrderNumber, @OrderType, @DeliveryAddress, 
                                    'Open', 'Normal', @TotalAmount, @PaymentMethod, GETDATE(), @CreatedBy);
                            SELECT SCOPE_IDENTITY();";

                        int ticketId;
                        using (SqlCommand cmd = new SqlCommand(ticketQuery, conn, transaction))
                        {
                            cmd.Parameters.AddWithValue("@TicketNumber", ticketNumber);
                            cmd.Parameters.AddWithValue("@OrderNumber", orderNumber);
                            cmd.Parameters.AddWithValue("@OrderType", "Delivery");
                            cmd.Parameters.AddWithValue("@DeliveryAddress", deliveryAddress);
                            cmd.Parameters.AddWithValue("@TotalAmount", totalAmount);
                            cmd.Parameters.AddWithValue("@PaymentMethod", paymentMethod);
                            cmd.Parameters.AddWithValue("@CreatedBy", currentUserId);
                            ticketId = Convert.ToInt32(cmd.ExecuteScalar());
                        }

                        foreach (var item in cart)
                        {
                            string itemQuery = @"
                                INSERT INTO TicketItems (TicketID, MenuID, FoodName, Quantity, UnitPrice, 
                                                        SubTotal, SpecialInstructions, Status)
                                VALUES (@TicketID, @MenuID, @FoodName, @Quantity, @UnitPrice, 
                                        @SubTotal, @SpecialInstructions, 'Pending');";

                            using (SqlCommand cmd = new SqlCommand(itemQuery, conn, transaction))
                            {
                                cmd.Parameters.AddWithValue("@TicketID", ticketId);
                                cmd.Parameters.AddWithValue("@MenuID", item.MenuID);
                                cmd.Parameters.AddWithValue("@FoodName", item.Name);
                                cmd.Parameters.AddWithValue("@Quantity", item.Quantity);
                                cmd.Parameters.AddWithValue("@UnitPrice", item.Price);
                                cmd.Parameters.AddWithValue("@SubTotal", item.Price * item.Quantity);
                                cmd.Parameters.AddWithValue("@SpecialInstructions",
                                    string.IsNullOrEmpty(item.SpecialRequest) ? (object)DBNull.Value : item.SpecialRequest);
                                cmd.ExecuteNonQuery();
                            }
                        }

                        transaction.Commit();

                        // Clear the cart
                        Session["ServerCart"] = new List<CartItemServer>();
                        BindCartRepeater();
                        UpdateCartTotals();
                        UpdateCartBadge();

                        string paymentDisplay = paymentMethod.ToUpper() == "COD" ? "Cash on Delivery" : paymentMethod;
                        string successScript = $"closeCheckoutModal(); showOrderConfirmedAnimation('{ticketNumber}', '{totalAmount:F2}', '{paymentDisplay}');";
                        ClientScript.RegisterStartupScript(this.GetType(), "orderSuccess", successScript, true);
                    }
                    catch (Exception ex)
                    {
                        transaction.Rollback();
                        ShowCartMessage("Error placing order: " + ex.Message, false);
                    }
                }
            }
            catch (Exception ex)
            {
                ShowCartMessage("Error: " + ex.Message, false);
            }
        }

        private void ShowCartMessage(string message, bool isSuccess)
        {
            string script = $"showNotification('{message.Replace("'", "\\'")}', {(!isSuccess).ToString().ToLower()}); closeCheckoutModal();";
            ClientScript.RegisterStartupScript(this.GetType(), "cartMessage", script, true);
        }

        // ============ ORDERS METHODS ============

        private void LoadOrdersData()
        {
            try
            {
                DataTable activeOrders = GetActiveOrders();
                rptActiveOrders.DataSource = activeOrders;
                rptActiveOrders.DataBind();

                DataTable orderHistory = GetOrderHistory();
                rptOrderHistory.DataSource = orderHistory;
                rptOrderHistory.DataBind();
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error loading orders: " + ex.Message);
            }
        }

        private DataTable GetActiveOrders()
        {
            DataTable dt = new DataTable();
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = @"SELECT TicketNumber, TotalAmount, Status, DeliveryAddress, CreatedAt,
                                (SELECT COUNT(*) FROM TicketItems WHERE TicketID = t.TicketID) as ItemCount
                                FROM Tickets t
                                WHERE CreatedBy = @UserID 
                                AND Status NOT IN ('Completed', 'Cancelled')
                                ORDER BY CreatedAt DESC";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@UserID", currentUserId);
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(dt);
                    }
                }
            }
            return dt;
        }

        private DataTable GetOrderHistory()
        {
            DataTable dt = new DataTable();
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = @"SELECT TicketNumber, TotalAmount, Status, CreatedAt,
                                (SELECT COUNT(*) FROM TicketItems WHERE TicketID = t.TicketID) as ItemCount
                                FROM Tickets t
                                WHERE CreatedBy = @UserID 
                                AND Status IN ('Completed', 'Cancelled')
                                ORDER BY CreatedAt DESC";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@UserID", currentUserId);
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(dt);
                    }
                }
            }
            return dt;
        }

        protected string GetDisplayStatus(string status)
        {
            switch (status)
            {
                case "Open": return "Preparing";
                case "Cooking": return "Cooking";
                case "Ready": return "Ready for Pickup";
                case "Delivering": return "On Delivery";
                case "Completed": return "Delivered";
                case "Cancelled": return "Cancelled";
                default: return status;
            }
        }

        protected void rptActiveOrders_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            string ticketNumber = e.CommandArgument.ToString();

            if (e.CommandName == "Received")
            {
                // Mark order as Completed and open rating modal
                try
                {
                    using (SqlConnection conn = new SqlConnection(connectionString))
                    {
                        conn.Open();
                        string query = @"UPDATE Tickets 
                                        SET Status = 'Completed' 
                                        WHERE TicketNumber = @TicketNumber 
                                        AND CreatedBy = @UserID";

                        using (SqlCommand cmd = new SqlCommand(query, conn))
                        {
                            cmd.Parameters.AddWithValue("@TicketNumber", ticketNumber);
                            cmd.Parameters.AddWithValue("@UserID", currentUserId);
                            cmd.ExecuteNonQuery();
                        }
                    }

                    LoadOrdersData();
                    string script = $"openProfileModal('orders'); setTimeout(function(){{ openRatingModal('{ticketNumber}'); }}, 400);";
                    ClientScript.RegisterStartupScript(this.GetType(), "openRating", script, true);
                }
                catch (Exception ex)
                {
                    ShowCartMessage("Error: " + ex.Message, false);
                }
            }
            else if (e.CommandName == "Cancel")
            {
                CancelOrder(ticketNumber);
            }
        }

        protected void btnSubmitRating_Click(object sender, EventArgs e)
        {
            string ticketNumber = hdnRatingTicket.Value;
            int rating = 0;
            int.TryParse(hdnRatingValue.Value, out rating);

            if (rating < 1 || rating > 5)
            {
                string errorScript = "closeRatingModal(); showNotification('Please select a star rating!', true);";
                ClientScript.RegisterStartupScript(this.GetType(), "ratingError", errorScript, true);
                return;
            }

            try
            {
                // Get all MenuIDs from the ticket
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    string query = @"SELECT DISTINCT ti.MenuID 
                                    FROM TicketItems ti
                                    INNER JOIN Tickets t ON ti.TicketID = t.TicketID
                                    WHERE t.TicketNumber = @TicketNumber AND t.CreatedBy = @UserID";

                    List<int> menuIds = new List<int>();
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@TicketNumber", ticketNumber);
                        cmd.Parameters.AddWithValue("@UserID", currentUserId);
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            while (reader.Read())
                                menuIds.Add(Convert.ToInt32(reader["MenuID"]));
                        }
                    }

                    // Update Ratings on each menu item (running average)
                    foreach (int menuId in menuIds)
                    {
                        string updateQuery = @"UPDATE Menu 
                                              SET Ratings = CASE 
                                                  WHEN Ratings IS NULL THEN @Rating
                                                  ELSE CAST(ROUND((Ratings + @Rating) / 2.0, 1) AS DECIMAL(2,1))
                                              END
                                              WHERE MenuID = @MenuID";

                        using (SqlCommand cmd = new SqlCommand(updateQuery, conn))
                        {
                            cmd.Parameters.AddWithValue("@Rating", (decimal)rating);
                            cmd.Parameters.AddWithValue("@MenuID", menuId);
                            cmd.ExecuteNonQuery();
                        }
                    }
                }

                string script = "closeRatingModal(); showNotification('Thank you for your rating! ⭐', false);";
                ClientScript.RegisterStartupScript(this.GetType(), "ratingSuccess", script, true);
            }
            catch (Exception ex)
            {
                string script = $"closeRatingModal(); showNotification('Error saving rating: {ex.Message.Replace("'", "\\'")}', true);";
                ClientScript.RegisterStartupScript(this.GetType(), "ratingError2", script, true);
            }
        }

        protected void rptOrderHistory_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Reorder")
            {
                string ticketNumber = e.CommandArgument.ToString();
                ReorderItems(ticketNumber);
            }
        }

        private void CancelOrder(string ticketNumber)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    string query = @"UPDATE Tickets 
                                    SET Status = 'Cancelled' 
                                    WHERE TicketNumber = @TicketNumber 
                                    AND CreatedBy = @UserID 
                                    AND Status IN ('Open', 'Cooking')";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@TicketNumber", ticketNumber);
                        cmd.Parameters.AddWithValue("@UserID", currentUserId);
                        int rowsAffected = cmd.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            ShowCartMessage("Order " + ticketNumber + " has been cancelled.", true);
                            LoadOrdersData();
                        }
                        else
                        {
                            ShowCartMessage("Unable to cancel order. Order may already be in progress.", false);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ShowCartMessage("Error cancelling order: " + ex.Message, false);
            }
        }

        private DataTable GetOrderDetails(string ticketNumber)
        {
            DataTable dt = new DataTable();
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = @"SELECT TicketNumber, TotalAmount, Status, DeliveryAddress, CreatedAt
                                FROM Tickets 
                                WHERE TicketNumber = @TicketNumber AND CreatedBy = @UserID";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@TicketNumber", ticketNumber);
                    cmd.Parameters.AddWithValue("@UserID", currentUserId);
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(dt);
                    }
                }
            }
            return dt;
        }

        private void ReorderItems(string ticketNumber)
        {
            try
            {
                DataTable orderItems = new DataTable();
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    string query = @"SELECT ti.MenuID, ti.FoodName, ti.UnitPrice, ti.SpecialInstructions
                                    FROM TicketItems ti
                                    INNER JOIN Tickets t ON ti.TicketID = t.TicketID
                                    WHERE t.TicketNumber = @TicketNumber AND t.CreatedBy = @UserID";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@TicketNumber", ticketNumber);
                        cmd.Parameters.AddWithValue("@UserID", currentUserId);
                        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                        {
                            da.Fill(orderItems);
                        }
                    }
                }

                List<CartItemServer> cart = GetCart();

                foreach (DataRow row in orderItems.Rows)
                {
                    int menuId = Convert.ToInt32(row["MenuID"]);
                    string foodName = row["FoodName"].ToString();
                    decimal price = Convert.ToDecimal(row["UnitPrice"]);
                    string specialInstructions = row["SpecialInstructions"]?.ToString() ?? "";

                    string cleanName = foodName.Split('-')[0].Trim();
                    if (cleanName.Contains("(+")) cleanName = cleanName.Split('(')[0].Trim();

                    var existing = cart.FirstOrDefault(x => x.MenuID == menuId && x.SpecialRequest == specialInstructions);

                    if (existing != null)
                    {
                        existing.Quantity += 1;
                    }
                    else
                    {
                        cart.Add(new CartItemServer
                        {
                            CartItemId = Guid.NewGuid().ToString(),
                            MenuID = menuId,
                            Name = string.IsNullOrEmpty(specialInstructions) ? cleanName : $"{cleanName} - {specialInstructions}",
                            Price = price,
                            Quantity = 1,
                            SpecialRequest = specialInstructions
                        });
                    }
                }

                SaveCart(cart);

                string script = $"showNotification('Items added to cart!', false); openCartModal();";
                ClientScript.RegisterStartupScript(this.GetType(), "reorderSuccess", script, true);
            }
            catch (Exception ex)
            {
                ShowCartMessage("Error reordering: " + ex.Message, false);
            }
        }

        // ============ PROFILE METHODS ============

        private void LoadUserProfile()
        {
            int userId = Convert.ToInt32(Session["UserID"]);

            string query = "SELECT FullName, Email, Phone, Gender, Address FROM Users WHERE UserID = @UserID";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@UserID", userId);
                    conn.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            txtFullName.Text = reader["FullName"].ToString();
                            txtEmail.Text = reader["Email"].ToString();
                            txtPhone.Text = reader["Phone"].ToString();

                            string gender = reader["Gender"].ToString();
                            if (!string.IsNullOrEmpty(gender))
                                ddlGender.SelectedValue = gender;

                            // Parse the full address into separate fields
                            string fullAddress = reader["Address"]?.ToString() ?? "";
                            ParseAddressToFields(fullAddress);

                            // Update dropdown display
                            litFullName.Text = txtFullName.Text;
                            litEmail.Text = txtEmail.Text;
                        }
                    }
                }
            }
        }

        private void LoadMenuItems()
        {
            try
            {
                var groupedMenu = GetMenuItemsGroupedByCategory();

                if (groupedMenu == null || groupedMenu.Count == 0)
                {
                    return;
                }

                rptMenuCategories.DataSource = groupedMenu;
                rptMenuCategories.DataBind();
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error loading menu: " + ex.Message);
            }
        }

        private List<MenuCategoryGroup> GetMenuItemsGroupedByCategory()
        {
            var groupedMenu = new List<MenuCategoryGroup>();

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    string query = @"SELECT MenuID, FoodType, FoodName, Price, ImagePath, Status, Description 
                                    FROM Menu 
                                    WHERE Status = 'active'
                                    ORDER BY 
                                        CASE FoodType 
                                            WHEN 'Sizzling Specials' THEN 1
                                            WHEN 'Special Meals' THEN 2
                                            WHEN 'Silog' THEN 3
                                            ELSE 4
                                        END,
                                        FoodName";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            var allItems = new List<MenuItem>();

                            while (reader.Read())
                            {
                                allItems.Add(new MenuItem
                                {
                                    MenuID = Convert.ToInt32(reader["MenuID"]),
                                    Name = reader["FoodName"].ToString(),
                                    Price = Convert.ToDecimal(reader["Price"]),
                                    FoodType = reader["FoodType"].ToString(),
                                    ImagePath = reader["ImagePath"]?.ToString() ?? "",
                                    Status = reader["Status"]?.ToString() ?? "active",
                                    Description = reader["Description"]?.ToString() ?? "Delicious meal prepared fresh daily!"
                                });
                            }

                            var groups = allItems.GroupBy(x => x.FoodType);

                            foreach (var group in groups)
                            {
                                groupedMenu.Add(new MenuCategoryGroup
                                {
                                    FoodType = group.Key,
                                    Items = group.ToList()
                                });
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error getting grouped menu: " + ex.Message);
                throw;
            }

            return groupedMenu;
        }

        protected void rptMenuCategories_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                var categoryGroup = (MenuCategoryGroup)e.Item.DataItem;
                var itemsRepeater = (Repeater)e.Item.FindControl("rptCategoryItems");

                if (itemsRepeater != null && categoryGroup.Items != null)
                {
                    itemsRepeater.DataSource = categoryGroup.Items;
                    itemsRepeater.DataBind();
                }
            }
        }

        protected string GetImagePath(object imagePathObj, string foodName)
        {
            string imagePath = imagePathObj?.ToString() ?? "";

            if (!string.IsNullOrEmpty(imagePath))
            {
                return ResolveUrl("~/" + imagePath);
            }

            var imageMap = new Dictionary<string, string>(StringComparer.OrdinalIgnoreCase)
            {
                { "Pork Sisig", "~/Images/sisig.jpg" },
                { "Tofu Sisig", "~/Images/tofu-sisig.jpg" },
                { "Goto Overload", "~/Images/goto-overload.jpg" },
                { "Goto", "~/Images/goto.jpg" },
                { "Tapsilog", "~/Images/tapsilog.jpg" },
                { "Baconsilog", "~/Images/baconsilog.jpg" },
                { "Tocilog", "~/Images/tocilog.jpg" },
                { "Longsilog", "~/Images/longsilog.jpg" },
                { "Sizzling Sisig", "~/Images/sizzling.jpg" },
                { "Sizzling Pork Steak", "~/Images/porksteak.jpg" },
                { "Sizzling Chicken", "~/Images/chicken.jpg" },
                { "Sizzling Tofu", "~/Images/tofu.jpg" },
                { "Sizzling Liempo", "~/Images/liempo.jpg" },
                { "Special Bulalo", "~/Images/bulalo.jpg" },
                { "Special Sinigang", "~/Images/sinigang.jpg" },
                { "Special Arrozcaldo", "~/Images/arroz.jpg" },
                { "Special Goto Overload", "~/Images/gotoover.jpg" }
            };

            if (imageMap.ContainsKey(foodName))
                return ResolveUrl(imageMap[foodName]);

            return ResolveUrl("~/Images/default-menu.jpg");
        }

        protected void btnSaveProfile_Click(object sender, EventArgs e)
        {
            int userId = Convert.ToInt32(Session["UserID"]);

            // Combine the separate address fields into one full address
            string fullAddress = CombineAddressFields();

            string query = @"
                UPDATE Users 
                SET FullName = @FullName, 
                    Phone = @Phone, 
                    Gender = @Gender,
                    Address = @Address
                WHERE UserID = @UserID";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@FullName", txtFullName.Text.Trim());
                    cmd.Parameters.AddWithValue("@Phone", txtPhone.Text.Trim());
                    cmd.Parameters.AddWithValue("@Gender", ddlGender.SelectedValue);
                    cmd.Parameters.AddWithValue("@Address", fullAddress);
                    cmd.Parameters.AddWithValue("@UserID", userId);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            // Update dropdown display
            litFullName.Text = txtFullName.Text;
            litDefaultAddress.Text = fullAddress;

            litProfileMessage.Text = "Profile updated successfully!";
            pnlProfileMessage.CssClass = "message success";
            pnlProfileMessage.Visible = true;
        }

        private void ShowProfileMessage(string message, bool isSuccess)
        {
            litProfileMessage.Text = message;
            pnlProfileMessage.CssClass = isSuccess ? "message success" : "message error";
            pnlProfileMessage.Visible = true;
        }

        protected void btnChangePassword_Click(object sender, EventArgs e)
        {
            try
            {
                string currentPassword = txtCurrentPassword.Text;
                string newPassword = txtNewPassword.Text;
                string confirmPassword = txtConfirmPassword.Text;

                if (string.IsNullOrEmpty(currentPassword))
                {
                    ShowPasswordMessage("Please enter your current password", false);
                    return;
                }

                if (string.IsNullOrEmpty(newPassword))
                {
                    ShowPasswordMessage("Please enter a new password", false);
                    return;
                }

                if (newPassword.Length < 6)
                {
                    ShowPasswordMessage("Password must be at least 6 characters", false);
                    return;
                }

                if (newPassword != confirmPassword)
                {
                    ShowPasswordMessage("New passwords do not match", false);
                    return;
                }

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    string verifyQuery = "SELECT Password FROM Users WHERE UserID = @UserID";
                    using (SqlCommand verifyCmd = new SqlCommand(verifyQuery, conn))
                    {
                        verifyCmd.Parameters.AddWithValue("@UserID", currentUserId);
                        object result = verifyCmd.ExecuteScalar();

                        if (result == null)
                        {
                            ShowPasswordMessage("User not found", false);
                            return;
                        }

                        string storedPassword = result.ToString();

                        if (storedPassword != currentPassword)
                        {
                            ShowPasswordMessage("Current password is incorrect", false);
                            return;
                        }

                        string updateQuery = "UPDATE Users SET Password = @NewPassword WHERE UserID = @UserID";
                        using (SqlCommand updateCmd = new SqlCommand(updateQuery, conn))
                        {
                            updateCmd.Parameters.AddWithValue("@UserID", currentUserId);
                            updateCmd.Parameters.AddWithValue("@NewPassword", newPassword);
                            updateCmd.ExecuteNonQuery();

                            ShowPasswordMessage("Password changed successfully!", true);

                            txtCurrentPassword.Text = "";
                            txtNewPassword.Text = "";
                            txtConfirmPassword.Text = "";
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ShowPasswordMessage("Error: " + ex.Message, false);
            }
        }

        private void ShowPasswordMessage(string message, bool isSuccess)
        {
            litPasswordMessage.Text = message;
            pnlPasswordMessage.CssClass = isSuccess ? "message success" : "message error";
            pnlPasswordMessage.Visible = true;
        }

        protected int GetCartCount()
        {
            return GetCart().Sum(x => x.Quantity);
        }
    }
}