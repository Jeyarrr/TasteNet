<%@ WebHandler Language="C#" Class="AddMenu" %>

using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web;
using System.Web.Script.Serialization;

public class AddMenu : IHttpHandler
{
    public void ProcessRequest(HttpContext context)
    {
        // ── Always return JSON ───────────────────────────────────────
        context.Response.ContentType = "application/json";

        var json = new JavaScriptSerializer();

        // ── Only accept POST ─────────────────────────────────────────
        if (context.Request.HttpMethod != "POST")
        {
            context.Response.StatusCode = 405;
            context.Response.Write(json.Serialize(new { success = false, message = "Method not allowed." }));
            return;
        }

        // ── Read form values ─────────────────────────────────────────
        string foodName    = (context.Request.Form["FoodName"]    ?? "").Trim();
        string foodType    = (context.Request.Form["FoodType"]    ?? "").Trim();
        string priceStr    = (context.Request.Form["Price"]       ?? "").Trim();
        string description = (context.Request.Form["Description"] ?? "").Trim();

        // ── Handle image upload ───────────────────────────────────────
        // The JS sends the file as "ImageFile" (multipart) when the user
        // picks one from disk.  If no file was chosen it sends "ImagePath"
        // (the existing text path) as a plain form field instead.
        string imagePath = (context.Request.Form["ImagePath"] ?? "").Trim(); // default: keep existing / empty

        HttpPostedFile imgFile = context.Request.Files["ImageFile"];
        if (imgFile != null && imgFile.ContentLength > 0)
        {
            // Validate file extension — only allow safe image types
            string ext = System.IO.Path.GetExtension(imgFile.FileName).ToLower();
            string[] allowed = { ".jpg", ".jpeg", ".png", ".webp", ".gif" };
            if (Array.IndexOf(allowed, ext) < 0)
            {
                context.Response.Write(json.Serialize(new { success = false, message = "Invalid file type. Allowed: jpg, jpeg, png, webp, gif." }));
                return;
            }

            // Make sure the save folder exists (creates it if missing)
            string folderPath = context.Server.MapPath("~/Images/Menus/");
            if (!System.IO.Directory.Exists(folderPath))
                System.IO.Directory.CreateDirectory(folderPath);

            // Save with a unique GUID filename to avoid collisions
            string uniqueName = Guid.NewGuid().ToString("N") + ext;
            imgFile.SaveAs(System.IO.Path.Combine(folderPath, uniqueName));

            // Store the relative path — this is what goes in the DB and gets
            // used as the src / background-image URL in the browser
            imagePath = "Images/Menus/" + uniqueName;
        }

        // ── Server-side validation ───────────────────────────────────
        if (string.IsNullOrEmpty(foodName))
        {
            context.Response.Write(json.Serialize(new { success = false, message = "FoodName is required." }));
            return;
        }
        if (string.IsNullOrEmpty(foodType))
        {
            context.Response.Write(json.Serialize(new { success = false, message = "FoodType is required." }));
            return;
        }

        decimal price;
        if (!decimal.TryParse(priceStr, out price) || price < 0)
        {
            context.Response.Write(json.Serialize(new { success = false, message = "Invalid price value." }));
            return;
        }

        // ── Insert into database ─────────────────────────────────────
        try
        {
            string connStr = ConfigurationManager.ConnectionStrings["TasteNetDB"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connStr))
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.Connection  = con;
                cmd.CommandType = System.Data.CommandType.Text;

                // Auto-add Description column if it doesn't exist
                cmd.CommandText = @"
                    IF NOT EXISTS (
                        SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS
                        WHERE TABLE_NAME = 'Menu' AND COLUMN_NAME = 'Description'
                    )
                    BEGIN
                        ALTER TABLE Menu ADD Description NVARCHAR(MAX) NULL
                    END";

                con.Open();
                cmd.ExecuteNonQuery();

                cmd.CommandText = @"
                    INSERT INTO Menu (FoodName, FoodType, Price, ImagePath, Description)
                    VALUES (@FoodName, @FoodType, @Price, @ImagePath, @Description)";

                cmd.Parameters.AddWithValue("@FoodName",    foodName);
                cmd.Parameters.AddWithValue("@FoodType",    foodType);
                cmd.Parameters.AddWithValue("@Price",       price);
                cmd.Parameters.AddWithValue("@ImagePath",   imagePath);
                cmd.Parameters.AddWithValue("@Description", description);

                int rows = cmd.ExecuteNonQuery();

                if (rows > 0)
                    context.Response.Write(json.Serialize(new { success = true, message = "Food item added successfully." }));
                else
                    context.Response.Write(json.Serialize(new { success = false, message = "Insert did not affect any rows." }));
            }
        }
        catch (SqlException sqlEx)
        {
            context.Response.Write(json.Serialize(new { success = false, message = "Database error: " + sqlEx.Message }));
        }
        catch (Exception ex)
        {
            context.Response.Write(json.Serialize(new { success = false, message = "Unexpected error: " + ex.Message }));
        }
    }

    public bool IsReusable { get { return false; } }
}
