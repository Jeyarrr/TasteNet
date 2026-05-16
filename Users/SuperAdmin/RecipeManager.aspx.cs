using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TasteNet.Users.SuperAdmin
{
    public partial class RecipeManager : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["TasteNetDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            lblToast.Text = ""; // clear any previous toast on every load
            if (!IsPostBack)
            {
                LoadMenuList();
                LoadIngredientDropdown();
            }
        }

        // ── Load all active menu items with ingredient count ──────────────────────
        private void LoadMenuList()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string sql = @"
                    SELECT
                        m.MenuID,
                        m.FoodName,
                        COUNT(r.RecipeID) AS RecipeCount
                    FROM Menu m
                    LEFT JOIN MenuRecipeIngredients r ON m.MenuID = r.MenuID
                    WHERE m.Status = 'active'
                    GROUP BY m.MenuID, m.FoodName
                    ORDER BY m.FoodName";

                DataTable dt = new DataTable();
                new SqlDataAdapter(sql, conn).Fill(dt);
                rptMenuList.DataSource = dt;
                rptMenuList.DataBind();
                litMenuCount.Text = dt.Rows.Count.ToString();
            }
        }

        // ── Fill ingredient dropdown + emit JS unit map ───────────────────────────
        private void LoadIngredientDropdown()
        {
            var unitMap = new System.Text.StringBuilder();
            unitMap.Append("{");

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(
                    "SELECT InventoryID, ItemName, UnitOfMeasure FROM Inventory WHERE IsActive = 1 ORDER BY ItemName", conn);
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                ddlIngredient.Items.Clear();
                ddlIngredient.Items.Add(new ListItem("-- Select ingredient --", ""));

                bool first = true;
                while (reader.Read())
                {
                    string id = reader["InventoryID"].ToString();
                    string name = reader["ItemName"].ToString();
                    string unit = reader["UnitOfMeasure"].ToString().Replace("'", "\\'");

                    ddlIngredient.Items.Add(new ListItem(name, id));

                    if (!first) unitMap.Append(",");
                    unitMap.Append($"'{id}':'{unit}'");
                    first = false;
                }
            }

            unitMap.Append("}");

            // Inject unit map as a JS variable so rmSyncUnit() can read it
            string script = $"var rmUnitMap = {unitMap};";
            ScriptManager.RegisterStartupScript(this, GetType(), "rmUnitMap", script, true);
        }

        // ── Load ingredients for the selected menu ────────────────────────────────
        private void LoadRecipeItems(int menuId)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string sql = @"
                    SELECT
                        r.RecipeID,
                        i.ItemName,
                        i.UnitOfMeasure,
                        r.QuantityRequired
                    FROM MenuRecipeIngredients r
                    INNER JOIN Inventory i ON r.InventoryID = i.InventoryID
                    WHERE r.MenuID = @MenuID
                    ORDER BY i.ItemName";

                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@MenuID", menuId);
                DataTable dt = new DataTable();
                new SqlDataAdapter(cmd).Fill(dt);
                rptRecipeItems.DataSource = dt;
                rptRecipeItems.DataBind();
            }
        }

        // ── User clicks a menu item on the left ──────────────────────────────────
        protected void rptMenuList_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName != "SelectMenu") return;

            int menuId = Convert.ToInt32(e.CommandArgument);
            hfSelectedMenuID.Value = menuId.ToString();

            litMenuName.Text = GetMenuName(menuId);
            pnlEmpty.Style["display"] = "none";
            pnlEditor.Style["display"] = "block";

            LoadRecipeItems(menuId);
            LoadMenuList();
            LoadIngredientDropdown();
        }

        // ── User clicks "+ Add" ───────────────────────────────────────────────────
        protected void btnAddIngredient_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(hfSelectedMenuID.Value) || hfSelectedMenuID.Value == "0")
            {
                ShowToast("Please select a menu item first.", "warning");
                return;
            }

            if (string.IsNullOrEmpty(ddlIngredient.SelectedValue))
            {
                ShowToast("Please select an ingredient.", "warning");
                return;
            }

            if (!decimal.TryParse(txtQty.Text, out decimal qty) || qty <= 0)
            {
                ShowToast("Please enter a valid quantity greater than 0.", "warning");
                return;
            }

            int menuId = Convert.ToInt32(hfSelectedMenuID.Value);
            int inventoryId = Convert.ToInt32(ddlIngredient.SelectedValue);
            string ingName = ddlIngredient.SelectedItem.Text;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                // If already exists, update quantity instead of duplicating
                SqlCommand checkCmd = new SqlCommand(
                    "SELECT COUNT(*) FROM MenuRecipeIngredients WHERE MenuID=@M AND InventoryID=@I", conn);
                checkCmd.Parameters.AddWithValue("@M", menuId);
                checkCmd.Parameters.AddWithValue("@I", inventoryId);
                bool exists = Convert.ToInt32(checkCmd.ExecuteScalar()) > 0;

                if (exists)
                {
                    SqlCommand upd = new SqlCommand(
                        "UPDATE MenuRecipeIngredients SET QuantityRequired=@Q WHERE MenuID=@M AND InventoryID=@I", conn);
                    upd.Parameters.AddWithValue("@Q", qty);
                    upd.Parameters.AddWithValue("@M", menuId);
                    upd.Parameters.AddWithValue("@I", inventoryId);
                    upd.ExecuteNonQuery();
                    ShowToast("Quantity updated for " + ingName + ".", "success");
                }
                else
                {
                    SqlCommand ins = new SqlCommand(
                        "INSERT INTO MenuRecipeIngredients (MenuID, InventoryID, QuantityRequired) VALUES (@M, @I, @Q)", conn);
                    ins.Parameters.AddWithValue("@M", menuId);
                    ins.Parameters.AddWithValue("@I", inventoryId);
                    ins.Parameters.AddWithValue("@Q", qty);
                    ins.ExecuteNonQuery();
                    ShowToast(ingName + " added to recipe!", "success");
                }
            }

            litMenuName.Text = GetMenuName(menuId);
            pnlEmpty.Style["display"] = "none";
            pnlEditor.Style["display"] = "block";
            txtQty.Text = "1";

            LoadRecipeItems(menuId);
            LoadMenuList();
            LoadIngredientDropdown();
        }

        // ── User clicks trash icon ────────────────────────────────────────────────
        protected void rptRecipeItems_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName != "RemoveIngredient") return;

            int recipeId = Convert.ToInt32(e.CommandArgument);

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(
                    "DELETE FROM MenuRecipeIngredients WHERE RecipeID=@ID", conn);
                cmd.Parameters.AddWithValue("@ID", recipeId);
                conn.Open();
                cmd.ExecuteNonQuery();
            }

            ShowToast("Ingredient removed from recipe.", "success");

            int menuId = Convert.ToInt32(hfSelectedMenuID.Value);
            litMenuName.Text = GetMenuName(menuId);
            pnlEmpty.Style["display"] = "none";
            pnlEditor.Style["display"] = "block";

            LoadRecipeItems(menuId);
            LoadMenuList();
            LoadIngredientDropdown();
        }

        // ── Helpers ───────────────────────────────────────────────────────────────
        private string GetMenuName(int menuId)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("SELECT FoodName FROM Menu WHERE MenuID=@ID", conn);
                cmd.Parameters.AddWithValue("@ID", menuId);
                conn.Open();
                return cmd.ExecuteScalar()?.ToString() ?? "Unknown";
            }
        }

        protected string GetInitials(string name)
        {
            if (string.IsNullOrEmpty(name)) return "?";
            var parts = name.Split(' ');
            return parts.Length == 1
                ? name.Substring(0, Math.Min(2, name.Length)).ToUpper()
                : (parts[0][0].ToString() + parts[1][0].ToString()).ToUpper();
        }

        private void ShowToast(string message, string type)
        {
            lblToast.Text = message + "|" + type;
        }
    }
}