<%@ WebHandler Language="C#" Class="DeleteMenu" %>

using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web;

public class DeleteMenu : IHttpHandler
{
    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "application/json";
        context.Response.AddHeader("Cache-Control", "no-cache");

        try
        {
            string menuIdStr = context.Request.Form["MenuID"];
            int menuId;

            if (!int.TryParse(menuIdStr, out menuId) || menuId <= 0)
            {
                context.Response.Write("{\"success\":false,\"message\":\"Invalid MenuID.\"}");
                return;
            }

            string connStr = ConfigurationManager.ConnectionStrings["TasteNetDB"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();

                // Delete child items first (if you have a FoodItems / MenuItems table)
                // Uncomment the lines below if your schema has a child table:
                // using (SqlCommand cmdItems = new SqlCommand("DELETE FROM MenuItems WHERE MenuID = @MenuID", con))
                // {
                //     cmdItems.Parameters.AddWithValue("@MenuID", menuId);
                //     cmdItems.ExecuteNonQuery();
                // }

                using (SqlCommand cmd = new SqlCommand("DELETE FROM Menu WHERE MenuID = @MenuID", con))
                {
                    cmd.Parameters.AddWithValue("@MenuID", menuId);
                    int rows = cmd.ExecuteNonQuery();

                    if (rows > 0)
                        context.Response.Write("{\"success\":true,\"message\":\"Menu deleted successfully.\"}");
                    else
                        context.Response.Write("{\"success\":false,\"message\":\"Menu not found.\"}");
                }
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
