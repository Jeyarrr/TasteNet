using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.IO;
using System.Text;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.Services.Description;
using System.Web.UI;

namespace TasteNet.Users.Admin
{
    [ScriptService]
    public partial class Menu : System.Web.UI.Page
    {
        private static string ConnStr =>
            ConfigurationManager.ConnectionStrings["TasteNetDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // ── Intercept AJAX actions posted by JS fetch calls ───────────────
            string action = Request.QueryString["action"] ?? "";

            if (action == "upload")
            {
                // Save the uploaded image file, return the relative path as JSON
                Response.ContentType = "application/json";
                Response.Write(DoImageUpload());
                Response.End();
                return;
            }

            if (action == "toggleStatus")
            {
                // Toggle active <-> hidden for a menu item
                Response.ContentType = "application/json";
                int menuId = 0;
                int.TryParse(Request.Form["menuId"], out menuId);
                string newStatus = Request.Form["newStatus"] ?? "active";
                Response.Write(DoToggleStatus(menuId, newStatus));
                Response.End();
                return;
            }

            if (action == "delete")
            {
                // Delete a menu item
                Response.ContentType = "application/json";
                int menuId = 0;
                int.TryParse(Request.Form["menuId"], out menuId);
                Response.Write(DoDelete(menuId));
                Response.End();
                return;
            }

            // Normal page load
            LoadMenu();
        }

        // ── Save uploaded image file ──────────────────────────────────────────
        private string DoImageUpload()
        {
            try
            {
                HttpPostedFile img = Request.Files["ImageFile"];
                if (img == null || img.ContentLength == 0)
                    return "{\"success\":true,\"imagePath\":\"\"}";

                string ext = Path.GetExtension(img.FileName).ToLower();
                string folder = Server.MapPath("~/Images/Menus/");
                if (!Directory.Exists(folder)) Directory.CreateDirectory(folder);

                string uniqueName = Guid.NewGuid().ToString("N") + ext;
                img.SaveAs(Path.Combine(folder, uniqueName));
                string path = "Images/Menus/" + uniqueName;

                return "{\"success\":true,\"imagePath\":\"" + path + "\"}";
            }
            catch (Exception ex)
            {
                return "{\"success\":false,\"message\":\"" + ex.Message.Replace("\"", "'") + "\"}";
            }
        }

        // ── Toggle menu status ────────────────────────────────────────────────
        private string DoToggleStatus(int menuId, string newStatus)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(ConnStr))
                using (SqlCommand cmd = new SqlCommand(
                    "UPDATE Menu SET Status=@Status WHERE MenuID=@MenuID", con))
                {
                    cmd.Parameters.AddWithValue("@Status", newStatus);
                    cmd.Parameters.AddWithValue("@MenuID", menuId);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
                return "{\"success\":true}";
            }
            catch (Exception ex)
            {
                return "{\"success\":false,\"message\":\"" + ex.Message.Replace("\"", "'") + "\"}";
            }
        }

        // ── Delete menu item ──────────────────────────────────────────────────
        private string DoDelete(int menuId)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(ConnStr))
                using (SqlCommand cmd = new SqlCommand(
                    "DELETE FROM Menu WHERE MenuID=@MenuID", con))
                {
                    cmd.Parameters.AddWithValue("@MenuID", menuId);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
                return "{\"success\":true}";
            }
            catch (Exception ex)
            {
                return "{\"success\":false,\"message\":\"" + ex.Message.Replace("\"", "'") + "\"}";
            }
        }

        // ── Save (Add or Edit) triggered by the hidden form postback ─────────
        protected void btnSaveMenu_Click(object sender, EventArgs e)
        {
            string foodName = Request.Form["hFoodName"] ?? "";
            string foodType = Request.Form["hFoodType"] ?? "";
            string priceStr = Request.Form["hPrice"] ?? "0";
            string menuIdStr = Request.Form["hMenuId"] ?? "";
            string imagePath = Request.Form["hImagePath"] ?? "";

            decimal price = 0;
            decimal.TryParse(priceStr,
                System.Globalization.NumberStyles.Any,
                System.Globalization.CultureInfo.InvariantCulture, out price);

            using (SqlConnection con = new SqlConnection(ConnStr))
            {
                con.Open();
                bool isEdit = !string.IsNullOrEmpty(menuIdStr) && menuIdStr != "0";

                if (isEdit)
                {
                    string sql = string.IsNullOrEmpty(imagePath)
                        ? "UPDATE Menu SET FoodName=@N,FoodType=@T,Price=@P WHERE MenuID=@ID"
                        : "UPDATE Menu SET FoodName=@N,FoodType=@T,Price=@P,ImagePath=@I WHERE MenuID=@ID";

                    using (SqlCommand cmd = new SqlCommand(sql, con))
                    {
                        cmd.Parameters.AddWithValue("@N", foodName);
                        cmd.Parameters.AddWithValue("@T", foodType);
                        cmd.Parameters.AddWithValue("@P", price);
                        cmd.Parameters.AddWithValue("@ID", int.Parse(menuIdStr));
                        if (!string.IsNullOrEmpty(imagePath))
                            cmd.Parameters.AddWithValue("@I", imagePath);
                        cmd.ExecuteNonQuery();
                    }
                }
                else
                {
                    using (SqlCommand cmd = new SqlCommand(
                        "INSERT INTO Menu(FoodName,FoodType,Price,ImagePath,Status) VALUES(@N,@T,@P,@I,'active')", con))
                    {
                        cmd.Parameters.AddWithValue("@N", foodName);
                        cmd.Parameters.AddWithValue("@T", foodType);
                        cmd.Parameters.AddWithValue("@P", price);
                        cmd.Parameters.AddWithValue("@I", imagePath);
                        cmd.ExecuteNonQuery();
                    }
                }
            }
            // PRG (Post-Redirect-Get): redirect back to the same page so the browser
            // history holds a GET, not a POST.  This prevents the "refresh duplicates"
            // bug where hitting F5 / reload re-submits the hidden save form.
            Response.Redirect(Request.Url.AbsolutePath, false);
            Context.ApplicationInstance.CompleteRequest();
        }

        // ── Load all menu rows and inject as window.__menusData ───────────────
        private void LoadMenu()
        {
            DataTable dt = new DataTable();
            try
            {
                using (SqlConnection con = new SqlConnection(ConnStr))
                using (SqlCommand cmd = new SqlCommand(@"
                    SELECT MenuID, FoodName, FoodType, Price,
                           ISNULL(ImagePath,'') AS ImagePath,
                           ISNULL(Status,'active') AS Status
                    FROM   Menu
                    ORDER  BY MenuID DESC", con))
                {
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    con.Open();
                    da.Fill(dt);
                }

                rptMenu.DataSource = dt;
                rptMenu.DataBind();

                // Inject app root so JS can build absolute image URLs
                string appRoot = VirtualPathUtility.ToAbsolute("~/").TrimEnd('/');

                var sb = new StringBuilder();
                sb.AppendFormat("<script>window.__appRoot='{0}';window.__menusData=[", appRoot);

                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    DataRow r = dt.Rows[i];
                    if (i > 0) sb.Append(",");
                    sb.Append("{");
                    sb.AppendFormat("\"menuId\":{0},", r["MenuID"]);
                    sb.AppendFormat("\"foodName\":\"{0}\",", JsEsc(r["FoodName"]));
                    sb.AppendFormat("\"foodType\":\"{0}\",", JsEsc(r["FoodType"]));
                    sb.AppendFormat("\"price\":{0},",
                        Convert.ToDecimal(r["Price"]).ToString("F2",
                            System.Globalization.CultureInfo.InvariantCulture));
                    sb.AppendFormat("\"imagePath\":\"{0}\",", JsEsc(r["ImagePath"]));
                    sb.AppendFormat("\"status\":\"{0}\",", JsEsc(r["Status"]));
                    sb.Append("\"itemCount\":0}");
                }

                sb.Append("];</script>");
                MenusJsonLiteral.Text = sb.ToString();
            }
            catch (Exception ex)
            {
                MenusJsonLiteral.Text =
                    "<script>window.__appRoot='';window.__menusData=[];" +
                    "console.error('Menu load error: " + JsEsc(ex.Message) + "');</script>";
            }
        }

        private static string JsEsc(object val)
        {
            if (val == null || val == DBNull.Value) return "";
            return val.ToString()
                .Replace("\\", "\\\\")
                .Replace("\"", "\\\"")
                .Replace("\r", "").Replace("\n", "");
        }
    }
}
