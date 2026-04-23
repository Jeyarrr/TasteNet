using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Net.Http;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TasteNet
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check for remember me cookie
                if (Request.Cookies["RememberMe"] != null)
                {
                    txtUsername.Text = Request.Cookies["RememberMe"]["Username"];
                    chkRemember.Checked = true;
                }

                // Check for Google callback
                string code = Request.QueryString["code"];
                string state = Request.QueryString["state"];

                if (!string.IsNullOrEmpty(code) && state == "google-login")
                {
                    HandleGoogleCallback(code);
                }
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();

            // Validate inputs
            if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
            {
                lblError.Text = "Please enter both username and password";
                lblError.Visible = true;
                return;
            }

            // Check credentials against database
            string userType = ValidateUser(username, password);

            if (userType != null)
            {
                // Handle remember me
                if (chkRemember.Checked)
                {
                    HttpCookie cookie = new HttpCookie("RememberMe");
                    cookie["Username"] = username;
                    cookie.Expires = DateTime.Now.AddDays(30);
                    Response.Cookies.Add(cookie);
                }
                else
                {
                    if (Request.Cookies["RememberMe"] != null)
                    {
                        HttpCookie cookie = new HttpCookie("RememberMe");
                        cookie.Expires = DateTime.Now.AddDays(-1);
                        Response.Cookies.Add(cookie);
                    }
                }

                // Set session variables
                Session["Username"] = username;
                Session["UserType"] = userType;
                Session[$"Is{userType}"] = true;
                Session["LoginTime"] = DateTime.Now;

                // Redirect based on user type
                RedirectByUserType(userType);
            }
            else
            {
                lblError.Text = "Invalid username or password";
                lblError.Visible = true;
            }
        }

        private string ValidateUser(string username, string password)
        {
            string userType = null;

            try
            {
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["TasteNetDB"].ConnectionString))
                {
                    conn.Open();

                    // Query to check username/email and password
                    string query = @"SELECT UserType, Password FROM Users 
                                    WHERE (Username = @Username OR Email = @Username) AND IsActive = 1";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Username", username);

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                string storedPassword = reader["Password"].ToString();
                                userType = reader["UserType"].ToString();

                                // For plain text comparison
                                if (storedPassword != password)
                                {
                                    userType = null; // Password doesn't match
                                }
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblError.Text = "Database error: " + ex.Message;
                lblError.Visible = true;
                return null;
            }

            return userType;
        }

        private void RedirectByUserType(string userType)
        {
            switch (userType.ToLower())
            {
                case "superadmin":
                    Response.Redirect("Users/Superadmin/Dashboard.aspx");
                    break;
                case "admin":
                    Response.Redirect("Users/Admin/Inventory.aspx");
                    break;
                case "rider":
                    Response.Redirect("Users/Rider/Dashboard.aspx");
                    break;
                case "customer":
                    Response.Redirect("Users/Customer/CustomerPortal.aspx");
                    break;
                default:
                    // Default redirect if user type doesn't match
                    Response.Redirect("Home.aspx");
                    break;
            }
        }

        private void HandleGoogleCallback(string code)
        {
            try
            {
                string clientId = "212574206218-1q5521s82manegu756dr108a7n6eck0s.apps.googleusercontent.com";
                string clientSecret = "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";
                string redirectUri = HttpUtility.UrlEncode(Request.Url.GetLeftPart(UriPartial.Authority) + "/Login.aspx");

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

                    var userInfo = LoginOrCreateUser(userData.email.ToString(), userData.name.ToString(), userData.picture.ToString());

                    Session["Username"] = userInfo.Username;
                    Session["UserType"] = userInfo.UserType;
                    Session[$"Is{userInfo.UserType}"] = true;
                    Session["LoginTime"] = DateTime.Now;

                    // Redirect based on user type
                    RedirectByUserType(userInfo.UserType);
                }
            }
            catch (Exception ex)
            {
                lblError.Text = "Google login failed: " + ex.Message;
                lblError.Visible = true;
            }
        }

        private dynamic LoginOrCreateUser(string email, string name, string picture)
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
                // Add a random number if username exists
                string finalUsername = username;
                int counter = 1;
                while (UsernameExists(finalUsername))
                {
                    finalUsername = username + counter;
                    counter++;
                }

                string insertQuery = @"INSERT INTO Users (Username, Email, UserType, IsActive, ProfilePicture, CreatedDate) 
                                      VALUES (@Username, @Email, 'customer', 1, @Picture, GETDATE())";

                using (SqlCommand cmd = new SqlCommand(insertQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@Username", finalUsername);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@Picture", picture ?? "");
                    cmd.ExecuteNonQuery();
                }

                return new { Username = finalUsername, UserType = "customer" };
            }
        }

        private bool UsernameExists(string username)
        {
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["TasteNetDB"].ConnectionString))
            {
                conn.Open();
                string query = "SELECT COUNT(*) FROM Users WHERE Username = @Username";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Username", username);
                    int count = (int)cmd.ExecuteScalar();
                    return count > 0;
                }
            }
        }
    }
}