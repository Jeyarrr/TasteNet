using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Net.Http;
using System.Web;


public class Login : IHttpHandler
{
    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "application/json";
        context.Response.Charset = "utf-8";

        try
        {
            string requestBody = new StreamReader(context.Request.InputStream).ReadToEnd();
            dynamic data = Newtonsoft.Json.JsonConvert.DeserializeObject(requestBody);
            string code = data.code;

            // Google Client ID to 
            string clientId = "212574206218-1q5521s82manegu756dr108a7n6eck0s.apps.googleusercontent.com";
            string clientSecret = "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";

            string redirectUri = HttpUtility.UrlEncode(context.Request.Url.GetLeftPart(UriPartial.Authority) + "/Login.aspx");

            using (var client = new HttpClient())
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
                dynamic tokenData = JObject.Parse(tokenJson);
                string accessToken = tokenData.access_token;

                var userResponse = client.GetAsync($"https://www.googleapis.com/oauth2/v2/userinfo?access_token={accessToken}").Result;
                string userJson = userResponse.Content.ReadAsStringAsync().Result;
                dynamic userData = JObject.Parse(userJson);

                var userInfo = LoginOrCreateUser(context, userData.email, userData.name, userData.picture);

                context.Session["Username"] = userInfo.Username;
                context.Session["UserType"] = userInfo.UserType;
                context.Session[$"Is{userInfo.UserType}"] = true;
                context.Session["LoginTime"] = DateTime.Now;

                string redirectUrl = GetRedirectUrl(userInfo.UserType);
                context.Response.Write(Newtonsoft.Json.JsonConvert.SerializeObject(new
                {
                    success = true,
                    email = userData.email,
                    name = userData.name,
                    userType = userInfo.UserType,
                    redirectUrl = redirectUrl
                }));
            }
        }
        catch (Exception ex)
        {
            context.Response.Write(Newtonsoft.Json.JsonConvert.SerializeObject(new
            {
                success = false,
                error = ex.Message
            }));
        }
    }

    private dynamic LoginOrCreateUser(HttpContext context, string email, string name, string picture)
    {
        using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["TasteNetDB"].ConnectionString))
        {
            conn.Open();

            string checkQuery = "SELECT Username, UserType FROM Users WHERE Email = @Email OR Username = @Email";
            using (SqlCommand cmd = new SqlCommand(checkQuery, conn))
            {
                cmd.Parameters.AddWithValue("@Email", email);
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        return new { Username = reader["Username"].ToString(), UserType = reader["UserType"].ToString() };
                    }
                }
            }

            string username = email.Split('@')[0].Replace(".", "").Replace("_", "");
            string insertQuery = @"INSERT INTO Users (Username, Email, UserType, IsActive, ProfilePicture, CreatedDate) 
                                  VALUES (@Username, @Email, 'customer', 1, @Picture, GETDATE())";

            using (SqlCommand cmd = new SqlCommand(insertQuery, conn))
            {
                cmd.Parameters.AddWithValue("@Username", username);
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@Picture", picture ?? "");
                cmd.ExecuteNonQuery();
            }

            return new { Username = username, UserType = "customer" };
        }
    }
    public bool IsReusable { get { return false; } }
}