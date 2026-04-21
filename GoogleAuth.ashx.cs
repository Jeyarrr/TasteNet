using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Net.Http;
using System.Web;
using System.Web.SessionState;

public class GoogleAuth : IHttpHandler, IRequiresSessionState
{
    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "application/json";
        context.Response.Charset = "utf-8";

        try
        {
            string requestBody = new StreamReader(context.Request.InputStream).ReadToEnd();
            JObject data = JObject.Parse(requestBody);
            string code = data["code"].ToString();

            string clientId = ConfigurationManager.AppSettings["GoogleClientId"];
            string clientSecret = ConfigurationManager.AppSettings["GoogleClientSecret"];
            string redirectUri = context.Request.Url.GetLeftPart(UriPartial.Authority) + "/Login.aspx";

            using (HttpClient client = new HttpClient())
            {
                var tokenContent = new FormUrlEncodedContent(new[]
                {
                    new KeyValuePair<string, string>("code", code),
                    new KeyValuePair<string, string>("client_id", clientId),
                    new KeyValuePair<string, string>("client_secret", clientSecret),
                    new KeyValuePair<string, string>("redirect_uri", redirectUri),
                    new KeyValuePair<string, string>("grant_type", "authorization_code")
                });

                var tokenResponse = client.PostAsync("https://oauth2.googleapis.com/token", tokenContent).Result;
                string tokenJson = tokenResponse.Content.ReadAsStringAsync().Result;
                JObject tokenData = JObject.Parse(tokenJson);
                string accessToken = tokenData["access_token"].ToString();

                var userResponse = client.GetAsync($"https://www.googleapis.com/oauth2/v2/userinfo?access_token={accessToken}").Result;
                string userJson = userResponse.Content.ReadAsStringAsync().Result;
                JObject userData = JObject.Parse(userJson);

                string email = userData["email"].ToString();
                string name = userData["name"].ToString();
                string picture = userData["picture"]?.ToString() ?? "";

                var userInfo = LoginOrCreateUser(email, name, picture);

                context.Session["Username"] = userInfo.Username;
                context.Session["UserType"] = userInfo.UserType;
                context.Session["LoginTime"] = DateTime.Now;
                context.Session["GoogleUser"] = true;
                context.Session[$"Is{userInfo.UserType}"] = true;

                string redirectUrl = GetRedirectUrl(userInfo.UserType);

                var response = new
                {
                    success = true,
                    email = email,
                    name = name,
                    userType = userInfo.UserType,
                    redirectUrl = redirectUrl
                };

                context.Response.Write(JsonConvert.SerializeObject(response));
            }
        }
        catch (Exception ex)
        {
            context.Response.Write(JsonConvert.SerializeObject(new
            {
                success = false,
                error = ex.Message
            }));
        }
    }

    private dynamic LoginOrCreateUser(string email, string name, string picture)
    {
        using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["TasteNetDB"].ConnectionString))
        {
            conn.Open();

            string checkQuery = "SELECT Username, UserType, IsActive FROM Users WHERE Email = @Email";
            using (SqlCommand cmd = new SqlCommand(checkQuery, conn))
            {
                cmd.Parameters.AddWithValue("@Email", email);
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        string username = reader["Username"].ToString();
                        string userType = reader["UserType"].ToString();
                        bool isActive = Convert.ToBoolean(reader["IsActive"]);

                        if (!isActive)
                            throw new Exception("Account is deactivated. Please contact support.");

                        return new { Username = username, UserType = userType };
                    }
                }
            }

            string usernameNew = email.Split('@')[0].Replace(".", "").Replace("_", "");
            if (usernameNew.Length > 20)
                usernameNew = usernameNew.Substring(0, 20);

            string insertQuery = @"INSERT INTO Users 
                (Username, Email, Password, UserType, IsActive, ProfilePicture, CreatedDate)
                VALUES (@Username, @Email, '', 'customer', 1, @Picture, GETDATE())";

            using (SqlCommand cmd = new SqlCommand(insertQuery, conn))
            {
                cmd.Parameters.AddWithValue("@Username", usernameNew);
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@Picture", picture);
                cmd.ExecuteNonQuery();
            }

            return new { Username = usernameNew, UserType = "customer" };
        }
    }

    private string GetRedirectUrl(string userType)
    {
        switch (userType.ToLower())
        {
            case "superadmin":
                return "~/Users/SuperAdmin/Dashboard.aspx";
            case "admin":
                return "~/Users/Admin/Inventory.aspx";
            case "rider":
                return "~/Users/Rider/Dashboard.aspx";
            case "customer":
                return "~/Users/Customer/CustomerPortal.aspx";
            default:
                return "~/Default.aspx";
        }
    }

    public bool IsReusable => false;
}