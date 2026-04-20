<%@ WebHandler Language="C#" Class="UpdateMenu" %>

using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web;

public class UpdateMenu : IHttpHandler
{
    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "application/json";
        context.Response.AddHeader("Cache-Control", "no-cache");

        // ── Only accept POST ─────────────────────────────────────────
        if (context.Request.HttpMethod != "POST")
        {
            context.Response.StatusCode = 405;
            context.Response.Write("{\"success\":false,\"message\":\"Method not allowed.\"}");
            return;
        }

        try
        {
            // ── Read form values ─────────────────────────────────────
            string menuIdStr   = context.Request.Form["MenuID"];
            string foodName    = (context.Request.Form["FoodName"]    ?? "").Trim();
            string foodType    = (context.Request.Form["FoodType"]    ?? "").Trim();
            string priceStr    = (context.Request.Form["Price"]       ?? "").Trim();
            string description = (context.Request.Form["Description"] ?? "").Trim();

            // ── Handle image upload ───────────────────────────────────
            // If the user picked a new file the JS sends it as "ImageFile".
            // If they left the image unchanged the JS sends "ImagePath" with
            // the existing DB path so we don't accidentally blank it out.
            string imagePath = (context.Request.Form["ImagePath"] ?? "").Trim(); // default: keep existing

            HttpPostedFile imgFile = context.Request.Files["ImageFile"];
            if (imgFile != null && imgFile.ContentLength > 0)
            {
                // Validate extension
                string ext = System.IO.Path.GetExtension(imgFile.FileName).ToLower();
                string[] allowed = { ".jpg", ".jpeg", ".png", ".webp", ".gif" };
                if (Array.IndexOf(allowed, ext) < 0)
                {
                    context.Response.Write("{\"success\":false,\"message\":\"Invalid file type. Allowed: jpg, jpeg, png, webp, gif.\"}");
                    return;
                }

                // Ensure the save folder exists
                string folderPath = context.Server.MapPath("~/Images/Menus/");
                if (!System.IO.Directory.Exists(folderPath))
                    System.IO.Directory.CreateDirectory(folderPath);

                // Save with a unique GUID name to avoid overwriting other files
                string uniqueName = Guid.NewGuid().ToString("N") + ext;
                imgFile.SaveAs(System.IO.Path.Combine(folderPath, uniqueName));

                // Relative path stored in DB and rendered by the browser
                imagePath = "Images/Menus/" + uniqueName;
            }

            // ── Validation ───────────────────────────────────────────
            int menuId;
            if (!int.TryParse(menuIdStr, out menuId) || menuId <= 0)
            {
                context.Response.Write("{\"success\":false,\"message\":\"Invalid or missing MenuID.\"}");
                return;
            }

            if (string.IsNullOrEmpty(foodName))
            {
                context.Response.Write("{\"success\":false,\"message\":\"FoodName is required.\"}");
                return;
            }

            if (string.IsNullOrEmpty(foodType))
            {
                context.Response.Write("{\"success\":false,\"message\":\"FoodType is required.\"}");
                return;
            }

            decimal price;
            if (!decimal.TryParse(priceStr, out price) || price < 0)
            {
                context.Response.Write("{\"success\":false,\"message\":\"Invalid price value.\"}");
                return;
            }

            // ── Update database ──────────────────────────────────────
            string connStr = ConfigurationManager.ConnectionStrings["TasteNetDB"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connStr))
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.Connection  = con;
                cmd.CommandType = System.Data.CommandType.Text;

                con.Open();

                // Auto-add Description column if it doesn't exist
                cmd.CommandText = @"
                    IF NOT EXISTS (
                        SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS
                        WHERE TABLE_NAME = 'Menu' AND COLUMN_NAME = 'Description'
                    )
                    BEGIN
                        ALTER TABLE Menu ADD Description NVARCHAR(MAX) NULL
                    END";
                cmd.ExecuteNonQuery();

                // Now run the update
                cmd.Parameters.Clear();
                cmd.CommandText = @"
                    UPDATE Menu
                    SET    FoodName    = @FoodName,
                           FoodType    = @FoodType,
                           Price       = @Price,
                           ImagePath   = @ImagePath,
                           Description = @Description
                    WHERE  MenuID      = @MenuID";

                cmd.Parameters.AddWithValue("@MenuID",      menuId);
                cmd.Parameters.AddWithValue("@FoodName",    foodName);
                cmd.Parameters.AddWithValue("@FoodType",    foodType);
                cmd.Parameters.AddWithValue("@Price",       price);
                cmd.Parameters.AddWithValue("@ImagePath",   imagePath);
                cmd.Parameters.AddWithValue("@Description", description);

                int rows = cmd.ExecuteNonQuery();

                if (rows > 0)
                    context.Response.Write("{\"success\":true,\"message\":\"Menu updated successfully.\"}");
                else
                    context.Response.Write("{\"success\":false,\"message\":\"Menu not found.\"}");
            }
        }
        catch (SqlException sqlEx)
        {
            context.Response.Write("{\"success\":false,\"message\":\"Database error: " + Escape(sqlEx.Message) + "\"}");
        }
        catch (Exception ex)
        {
            context.Response.Write("{\"success\":false,\"message\":\"Error: " + Escape(ex.Message) + "\"}");
        }
    }

    private string Escape(string s)
    {
        if (s == null) return "";
        return s.Replace("\\", "\\\\").Replace("\"", "\\\"").Replace("\r", "").Replace("\n", " ");
    }

    public bool IsReusable { get { return false; } }
}
