<%@ WebHandler Language="C#" Class="TasteNet.Users.SuperAdmin.DeleteRider" %>

using System;
using System.Data.SqlClient;
using System.Web;

namespace TasteNet.Users.SuperAdmin
{
    public class DeleteRider : IHttpHandler
    {
        public void ProcessRequest(HttpContext ctx)
        {
            ctx.Response.ContentType = "application/json";
            ctx.Response.AddHeader("Cache-Control", "no-cache");

            try
            {
                string riderId = ctx.Request.Form["riderId"];

                if (string.IsNullOrWhiteSpace(riderId) || !int.TryParse(riderId, out int id))
                {
                    ctx.Response.Write("{\"success\":false,\"message\":\"Invalid rider ID.\"}");
                    return;
                }

                string connStr = System.Configuration.ConfigurationManager
                                       .ConnectionStrings["TasteNetDB"]
                                       .ConnectionString;

                using (var con = new SqlConnection(connStr))
                using (var cmd = new SqlCommand(
                    "DELETE FROM [DeliverySystem].[dbo].[riders] WHERE RiderId = @RiderId", con))
                {
                    cmd.Parameters.AddWithValue("@RiderId", id);
                    con.Open();
                    int rows = cmd.ExecuteNonQuery();

                    if (rows > 0)
                        ctx.Response.Write("{\"success\":true,\"message\":\"\"}");
                    else
                        ctx.Response.Write("{\"success\":false,\"message\":\"Rider not found in database.\"}");
                }
            }
            catch (Exception ex)
            {
                string msg = ex.Message.Replace("\\", "\\\\").Replace("\"", "\\\"").Replace("\r", "").Replace("\n", " ");
                ctx.Response.Write("{\"success\":false,\"message\":\"" + msg + "\"}");
            }
        }

        public bool IsReusable => false;
    }
}
