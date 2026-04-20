<%@ WebHandler Language="C#" Class="UpdateMenuStatus" %>

using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web;

public class UpdateMenuStatus : IHttpHandler
{
    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "application/json";
        context.Response.AddHeader("Cache-Control", "no-cache");

        try
        {
            string menuIdStr = context.Request.Form["MenuID"];
            string status    = (context.Request.Form["Status"] ?? "").Trim().ToLower();

            int menuId;
            if (!int.TryParse(menuIdStr, out menuId) || menuId <= 0)
            {
                context.Response.Write("{\"success\":false,\"message\":\"Invalid MenuID.\"}");
                return;
            }

            if (status != "active" && status != "hidden")
            {
                context.Response.Write("{\"success\":false,\"message\":\"Invalid status value. Must be active or hidden.\"}");
                return;
            }

            string connStr = ConfigurationManager.ConnectionStrings["TasteNetDB"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();

                // Auto-add Status column if it doesn't exist yet
                string addColumnSql = @"
                    IF NOT EXISTS (
                        SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS
                        WHERE TABLE_NAME = 'Menu' AND COLUMN_NAME = 'Status'
                    )
                    BEGIN
                        ALTER TABLE Menu ADD Status NVARCHAR(10) NOT NULL DEFAULT 'active'
                    END";

                using (SqlCommand cmdAlter = new SqlCommand(addColumnSql, con))
                {
                    cmdAlter.ExecuteNonQuery();
                }

                // Now update the status
                using (SqlCommand cmd = new SqlCommand(
                    "UPDATE Menu SET Status = @Status WHERE MenuID = @MenuID", con))
                {
                    cmd.Parameters.AddWithValue("@Status", status);
                    cmd.Parameters.AddWithValue("@MenuID", menuId);
                    int rows = cmd.ExecuteNonQuery();

                    if (rows > 0)
                        context.Response.Write("{\"success\":true,\"message\":\"Status updated to " + status + ".\"}");
                    else
                        context.Response.Write("{\"success\":false,\"message\":\"Menu not found. MenuID=" + menuId + "\"}");
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
