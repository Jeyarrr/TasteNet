using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TasteNet.Users.Admin
{
    public partial class Inventory : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["TasteNetDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadInventoryData();
                LoadCategories();
                UpdateStatistics();
            }
        }

        private void LoadInventoryData()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"
                    SELECT 
                        i.InventoryID,
                        i.ItemCode,
                        i.ItemName,
                        i.Description,
                        i.CategoryID,
                        c.CategoryName,
                        i.CurrentStock AS Quantity,
                        i.MinimumStock AS LowStockThreshold,
                        i.UnitCost,
                        i.UnitPrice,
                        i.IsAvailable AS Available,
                        i.UnitOfMeasure,
                        CASE 
                            WHEN i.CurrentStock = 0 THEN 'out-of-stock'
                            WHEN i.CurrentStock <= i.MinimumStock THEN 'low-stock'
                            ELSE 'in-stock'
                        END AS StockStatus
                    FROM Inventory i
                    LEFT JOIN InventoryCategories c ON i.CategoryID = c.CategoryID
                    WHERE i.IsActive = 1";

                string searchText = txtSearch.Text.Trim();
                if (!string.IsNullOrEmpty(searchText))
                {
                    query += " AND (i.ItemName LIKE @Search OR i.Description LIKE @Search)";
                }

                string categoryFilter = ddlCategoryFilter.SelectedValue;
                if (categoryFilter != "all")
                {
                    query += " AND i.CategoryID = @CategoryID";
                }

                string statusFilter = ddlStatusFilter.SelectedValue;
                if (statusFilter != "all")
                {
                    if (statusFilter == "in-stock")
                        query += " AND i.CurrentStock > i.MinimumStock AND i.CurrentStock > 0";
                    else if (statusFilter == "low-stock")
                        query += " AND i.CurrentStock <= i.MinimumStock AND i.CurrentStock > 0";
                    else if (statusFilter == "out-of-stock")
                        query += " AND i.CurrentStock = 0";
                }

                query += " ORDER BY i.ItemName";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    if (!string.IsNullOrEmpty(searchText))
                        cmd.Parameters.AddWithValue("@Search", "%" + searchText + "%");
                    if (categoryFilter != "all")
                        cmd.Parameters.AddWithValue("@CategoryID", Convert.ToInt32(categoryFilter));

                    conn.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    conn.Close();

                    rptInventory.DataSource = dt;
                    rptInventory.DataBind();

                    noResultsMessage.Visible = dt.Rows.Count == 0;
                }
            }
        }

        private void LoadCategories()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT CategoryID, CategoryName FROM InventoryCategories WHERE IsActive = 1 ORDER BY CategoryName";
                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlCategory.DataSource = dt;
                ddlCategory.DataTextField = "CategoryName";
                ddlCategory.DataValueField = "CategoryID";
                ddlCategory.DataBind();
            }
        }

        private void UpdateStatistics()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string countQuery = "SELECT COUNT(*) FROM Inventory WHERE IsActive = 1";
                string lowStockQuery = "SELECT COUNT(*) FROM Inventory WHERE IsActive = 1 AND CurrentStock <= MinimumStock AND CurrentStock > 0";
                string outStockQuery = "SELECT COUNT(*) FROM Inventory WHERE IsActive = 1 AND CurrentStock = 0";
                string valueQuery = "SELECT ISNULL(SUM(CurrentStock * UnitPrice), 0) FROM Inventory WHERE IsActive = 1";

                SqlCommand cmd = new SqlCommand(countQuery, conn);
                conn.Open();
                lblTotalIngredients.Text = cmd.ExecuteScalar().ToString();

                cmd.CommandText = lowStockQuery;
                lblLowStockCount.Text = cmd.ExecuteScalar().ToString();

                cmd.CommandText = outStockQuery;
                lblOutOfStockCount.Text = cmd.ExecuteScalar().ToString();

                cmd.CommandText = valueQuery;
                decimal totalValue = Convert.ToDecimal(cmd.ExecuteScalar());
                lblInventoryValue.Text = "₱" + totalValue.ToString("N0");

                conn.Close();
            }
        }

        protected void rptInventory_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int inventoryId = Convert.ToInt32(e.CommandArgument);

            switch (e.CommandName)
            {
                case "EditItem":
                    LoadItemForEdit(inventoryId);
                    ScriptManager.RegisterStartupScript(this, GetType(), "ShowModal", "showModal('editModal');", true);
                    break;
                case "DeleteItem":
                    DeleteItem(inventoryId);
                    break;
            }
        }

        private void LoadItemForEdit(int inventoryId)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"
                    SELECT InventoryID, ItemName, Description, CategoryID, CurrentStock, 
                           MinimumStock, IsAvailable, UnitCost, UnitPrice, UnitOfMeasure
                    FROM Inventory 
                    WHERE InventoryID = @InventoryID";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@InventoryID", inventoryId);
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    hfInventoryID.Value = reader["InventoryID"].ToString();
                    txtItemName.Text = reader["ItemName"].ToString();
                    txtDescription.Text = reader["Description"].ToString();
                    ddlCategory.SelectedValue = reader["CategoryID"].ToString();
                    txtQuantity.Text = reader["CurrentStock"].ToString();
                    txtLowStockThreshold.Text = reader["MinimumStock"].ToString();
                    chkIsAvailable.Checked = Convert.ToBoolean(reader["IsAvailable"]);
                    txtUnitCost.Text = Convert.ToDecimal(reader["UnitCost"]).ToString("F2");
                    txtUnitPrice.Text = Convert.ToDecimal(reader["UnitPrice"]).ToString("F2");
                    ddlUnitOfMeasure.SelectedValue = reader["UnitOfMeasure"].ToString();
                }
                reader.Close();
                conn.Close();
            }
        }

        private void DeleteItem(int inventoryId)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "UPDATE Inventory SET IsActive = 0, UpdatedAt = GETDATE() WHERE InventoryID = @InventoryID";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@InventoryID", inventoryId);
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
            }

            LoadInventoryData();
            UpdateStatistics();
            ShowMessage("Ingredient deleted successfully!", "success");
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(hfInventoryID.Value))
            {
                AddNewItem();
            }
            else
            {
                UpdateItem();
            }
        }

        private void AddNewItem()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string itemCode = GenerateItemCode();

                string query = @"
                    INSERT INTO Inventory (ItemCode, ItemName, Description, CategoryID, CurrentStock, 
                                          MinimumStock, IsAvailable, UnitCost, UnitPrice, 
                                          UnitOfMeasure, ReorderLevel, IsActive, CreatedAt, UpdatedAt)
                    VALUES (@ItemCode, @ItemName, @Description, @CategoryID, @Quantity,
                            @LowStockThreshold, @IsAvailable, @UnitCost, @UnitPrice,
                            @UnitOfMeasure, @LowStockThreshold, 1, GETDATE(), GETDATE());
                    SELECT SCOPE_IDENTITY();";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@ItemCode", itemCode);
                cmd.Parameters.AddWithValue("@ItemName", txtItemName.Text.Trim());
                cmd.Parameters.AddWithValue("@Description", txtDescription.Text.Trim());
                cmd.Parameters.AddWithValue("@CategoryID", Convert.ToInt32(ddlCategory.SelectedValue));
                cmd.Parameters.AddWithValue("@Quantity", Convert.ToDecimal(txtQuantity.Text));
                cmd.Parameters.AddWithValue("@LowStockThreshold", Convert.ToDecimal(txtLowStockThreshold.Text));
                cmd.Parameters.AddWithValue("@IsAvailable", chkIsAvailable.Checked);
                cmd.Parameters.AddWithValue("@UnitCost", Convert.ToDecimal(txtUnitCost.Text));
                cmd.Parameters.AddWithValue("@UnitPrice", Convert.ToDecimal(txtUnitPrice.Text));
                cmd.Parameters.AddWithValue("@UnitOfMeasure", ddlUnitOfMeasure.SelectedValue);

                conn.Open();
                int newInventoryId = Convert.ToInt32(cmd.ExecuteScalar());

                string logQuery = @"
                    INSERT INTO InventoryTransactions (InventoryID, TransactionType, Quantity, PreviousStock, NewStock, Notes, TransactionDate)
                    VALUES (@InventoryID, 'Purchase', @Quantity, 0, @Quantity, 'Initial stock setup', GETDATE())";
                cmd.CommandText = logQuery;
                cmd.Parameters.Clear();
                cmd.Parameters.AddWithValue("@InventoryID", newInventoryId);
                cmd.Parameters.AddWithValue("@Quantity", Convert.ToDecimal(txtQuantity.Text));
                cmd.ExecuteNonQuery();

                conn.Close();
            }

            ClearModalFields();
            LoadInventoryData();
            UpdateStatistics();
            ShowMessage("Ingredient added successfully!", "success");
            ScriptManager.RegisterStartupScript(this, GetType(), "CloseModal", "closeModal('editModal');", true);
        }

        private void UpdateItem()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string getCurrentStock = "SELECT CurrentStock FROM Inventory WHERE InventoryID = @InventoryID";
                SqlCommand cmd = new SqlCommand(getCurrentStock, conn);
                cmd.Parameters.AddWithValue("@InventoryID", Convert.ToInt32(hfInventoryID.Value));
                conn.Open();
                decimal oldStock = Convert.ToDecimal(cmd.ExecuteScalar());
                decimal newStock = Convert.ToDecimal(txtQuantity.Text);

                string query = @"
                    UPDATE Inventory 
                    SET ItemName = @ItemName, Description = @Description, CategoryID = @CategoryID,
                        CurrentStock = @Quantity, MinimumStock = @LowStockThreshold, IsAvailable = @IsAvailable,
                        UnitCost = @UnitCost, UnitPrice = @UnitPrice,
                        UnitOfMeasure = @UnitOfMeasure, UpdatedAt = GETDATE()
                    WHERE InventoryID = @InventoryID";

                cmd.CommandText = query;
                cmd.Parameters.Clear();
                cmd.Parameters.AddWithValue("@InventoryID", Convert.ToInt32(hfInventoryID.Value));
                cmd.Parameters.AddWithValue("@ItemName", txtItemName.Text.Trim());
                cmd.Parameters.AddWithValue("@Description", txtDescription.Text.Trim());
                cmd.Parameters.AddWithValue("@CategoryID", Convert.ToInt32(ddlCategory.SelectedValue));
                cmd.Parameters.AddWithValue("@Quantity", newStock);
                cmd.Parameters.AddWithValue("@LowStockThreshold", Convert.ToDecimal(txtLowStockThreshold.Text));
                cmd.Parameters.AddWithValue("@IsAvailable", chkIsAvailable.Checked);
                cmd.Parameters.AddWithValue("@UnitCost", Convert.ToDecimal(txtUnitCost.Text));
                cmd.Parameters.AddWithValue("@UnitPrice", Convert.ToDecimal(txtUnitPrice.Text));
                cmd.Parameters.AddWithValue("@UnitOfMeasure", ddlUnitOfMeasure.SelectedValue);
                cmd.ExecuteNonQuery();

                if (oldStock != newStock)
                {
                    string logQuery = @"
                        INSERT INTO InventoryTransactions (InventoryID, TransactionType, Quantity, PreviousStock, NewStock, Notes, TransactionDate)
                        VALUES (@InventoryID, 'Adjustment', @Quantity, @PreviousStock, @NewStock, 'Manual adjustment', GETDATE())";
                    cmd.CommandText = logQuery;
                    cmd.Parameters.Clear();
                    cmd.Parameters.AddWithValue("@InventoryID", Convert.ToInt32(hfInventoryID.Value));
                    cmd.Parameters.AddWithValue("@Quantity", newStock - oldStock);
                    cmd.Parameters.AddWithValue("@PreviousStock", oldStock);
                    cmd.Parameters.AddWithValue("@NewStock", newStock);
                    cmd.ExecuteNonQuery();
                }

                conn.Close();
            }

            ClearModalFields();
            LoadInventoryData();
            UpdateStatistics();
            ShowMessage("Ingredient updated successfully!", "success");
            ScriptManager.RegisterStartupScript(this, GetType(), "CloseModal", "closeModal('editModal');", true);
        }

        private string GenerateItemCode()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT COUNT(*) FROM Inventory";
                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();
                int count = Convert.ToInt32(cmd.ExecuteScalar()) + 1;
                conn.Close();
                return "ITM-" + count.ToString("D4");
            }
        }

        private void ClearModalFields()
        {
            hfInventoryID.Value = "";
            txtItemName.Text = "";
            txtDescription.Text = "";
            txtQuantity.Text = "";
            txtLowStockThreshold.Text = "";
            chkIsAvailable.Checked = true;
            txtUnitCost.Text = "";
            txtUnitPrice.Text = "";
            ddlUnitOfMeasure.SelectedIndex = 0;
        }

        protected void btnAddIngredient_Click(object sender, EventArgs e)
        {
            ClearModalFields();
            ScriptManager.RegisterStartupScript(this, GetType(), "ShowModal", "showModal('editModal');", true);
        }

        protected void btnBulkRestock_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"
                    UPDATE Inventory 
                    SET CurrentStock = MinimumStock * 2,
                        UpdatedAt = GETDATE()
                    WHERE CurrentStock <= MinimumStock AND IsActive = 1";

                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();
                int rowsAffected = cmd.ExecuteNonQuery();
                conn.Close();

                if (rowsAffected > 0)
                {
                    LoadInventoryData();
                    UpdateStatistics();
                    ShowMessage(rowsAffected + " ingredients restocked successfully!", "success");
                }
                else
                {
                    ShowMessage("No items need restocking", "info");
                }
            }
        }

        protected void chkAvailable_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox chk = (CheckBox)sender;
            RepeaterItem item = (RepeaterItem)chk.NamingContainer;
            HiddenField hfInventoryIDHidden = (HiddenField)item.FindControl("hfInventoryID");

            if (hfInventoryIDHidden != null)
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = "UPDATE Inventory SET IsAvailable = @IsAvailable, UpdatedAt = GETDATE() WHERE InventoryID = @InventoryID";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@IsAvailable", chk.Checked);
                    cmd.Parameters.AddWithValue("@InventoryID", Convert.ToInt32(hfInventoryIDHidden.Value));
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();
                }
                ShowMessage("Availability updated successfully!", "success");
            }
        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            LoadInventoryData();
        }

        protected void ddlFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadInventoryData();
        }

        protected void rptInventory_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                HiddenField hfInventoryIDHidden = new HiddenField();
                hfInventoryIDHidden.ID = "hfInventoryID";
                hfInventoryIDHidden.Value = DataBinder.Eval(e.Item.DataItem, "InventoryID").ToString();
                e.Item.Controls.Add(hfInventoryIDHidden);
            }
        }

        public string GetStockStatusClass(string status)
        {
            switch (status)
            {
                case "in-stock": return "in-stock";
                case "low-stock": return "low-stock";
                case "out-of-stock": return "out-of-stock";
                default: return "";
            }
        }

        public string GetStockStatusText(string status)
        {
            switch (status)
            {
                case "in-stock": return "IN STOCK";
                case "low-stock": return "LOW STOCK";
                case "out-of-stock": return "OUT OF STOCK";
                default: return status;
            }
        }

        private void ShowMessage(string message, string type)
        {
            lblMessage.Text = message + "|" + type;
        }
    }
}