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

            // Check credentials
            LoginResult result = ValidateUser(username, password);

            if (result.Success)
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
                Session["UserID"] = result.UserId;
                Session["Username"] = result.Username;
                Session["UserType"] = result.UserType;
                Session["FullName"] = result.FullName;
                Session["Email"] = result.Email;
                Session["Phone"] = result.Phone;
                Session["LoginTime"] = DateTime.Now;

                // For riders, also store rider-specific session variables
                if (result.UserType.ToLower() == "rider")
                {
                    GetRiderDetails(result.UserId);
                }

                // Redirect based on user type
                RedirectByUserType(result.UserType);
            }
            else
            {
                lblError.Text = result.ErrorMessage;
                lblError.Visible = true;
            }
        }

        private LoginResult ValidateUser(string username, string password)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["TasteNetDB"].ConnectionString))
                {
                    conn.Open();

                    // Single query for ALL user types (including riders)
                    string query = @"SELECT UserID, Username, Password, UserType, FullName, Email, Phone, IsActive 
                                    FROM Users 
                                    WHERE Username = @Username OR Email = @Username";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Username", username);

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                string storedPassword = reader["Password"].ToString();
                                string userType = reader["UserType"].ToString();
                                bool isActive = Convert.ToBoolean(reader["IsActive"]);

                                // Check if account is active
                                if (!isActive)
                                {
                                    return new LoginResult
                                    {
                                        Success = false,
                                        ErrorMessage = "Your account is deactivated. Please contact support."
                                    };
                                }

                                // Check password
                                if (storedPassword == password)
                                {
                                    return new LoginResult
                                    {
                                        Success = true,
                                        UserId = Convert.ToInt32(reader["UserID"]),
                                        Username = reader["Username"].ToString(),
                                        UserType = userType,
                                        FullName = reader["FullName"].ToString(),
                                        Email = reader["Email"].ToString(),
                                        Phone = reader["Phone"]?.ToString()
                                    };
                                }
                                else
                                {
                                    return new LoginResult
                                    {
                                        Success = false,
                                        ErrorMessage = "Invalid password"
                                    };
                                }
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                return new LoginResult
                {
                    Success = false,
                    ErrorMessage = "Database error: " + ex.Message
                };
            }

            return new LoginResult
            {
                Success = false,
                ErrorMessage = "Username or email not found"
            };
        }

        private void GetRiderDetails(int userId)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["TasteNetDB"].ConnectionString))
                {
                    conn.Open();

                    string query = @"SELECT RiderStatus, AssignedOrders, CompletedOrders, Ratings, 
                                            Vehicle, VehicleModel, LicensePlate, ProfilePhoto,
                                            LicenseNumber, NBINumber
                                    FROM Users 
                                    WHERE UserID = @UserID AND UserType = 'Rider'";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@UserID", userId);

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                Session["RiderStatus"] = reader["RiderStatus"]?.ToString() ?? "available";
                                Session["AssignedOrders"] = reader["AssignedOrders"] ?? 0;
                                Session["CompletedOrders"] = reader["CompletedOrders"] ?? 0;
                                Session["Ratings"] = reader["Ratings"] ?? 0.0;
                                Session["Vehicle"] = reader["Vehicle"]?.ToString() ?? "";
                                Session["VehicleModel"] = reader["VehicleModel"]?.ToString() ?? "";
                                Session["LicensePlate"] = reader["LicensePlate"]?.ToString() ?? "";
                                Session["ProfilePhoto"] = reader["ProfilePhoto"]?.ToString() ?? "";
                                Session["LicenseNumber"] = reader["LicenseNumber"]?.ToString() ?? "";
                                Session["NBINumber"] = reader["NBINumber"]?.ToString() ?? "";
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Log error but don't stop login process
                System.Diagnostics.Debug.WriteLine("Error loading rider details: " + ex.Message);
            }
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

                    var userInfo = LoginOrCreateUser(userData.email.ToString(), userData.name.ToString());

                    Session["UserID"] = userInfo.UserId;
                    Session["Username"] = userInfo.Username;
                    Session["UserType"] = userInfo.UserType;
                    Session["FullName"] = userInfo.FullName;
                    Session["Email"] = userInfo.Email;
                    Session["LoginTime"] = DateTime.Now;

                    RedirectByUserType(userInfo.UserType);
                }
            }
            catch (Exception ex)
            {
                lblError.Text = "Google login failed: " + ex.Message;
                lblError.Visible = true;
            }
        }

        private dynamic LoginOrCreateUser(string email, string name)
        {
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["TasteNetDB"].ConnectionString))
            {
                conn.Open();

                // Check if user exists
                string checkQuery = "SELECT UserID, Username, UserType, FullName, Email FROM Users WHERE Email = @Email";
                using (SqlCommand cmd = new SqlCommand(checkQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@Email", email);
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            return new
                            {
                                UserId = Convert.ToInt32(reader["UserID"]),
                                Username = reader["Username"].ToString(),
                                UserType = reader["UserType"].ToString(),
                                FullName = reader["FullName"].ToString(),
                                Email = reader["Email"].ToString()
                            };
                        }
                    }
                }

                // Create new user (Customer by default for Google login)
                string username = email.Split('@')[0].Replace(".", "").Replace("_", "");
                string finalUsername = username;
                int counter = 1;
                while (UsernameExists(finalUsername))
                {
                    finalUsername = username + counter;
                    counter++;
                }

                string insertQuery = @"INSERT INTO Users (Username, Password, UserType, FullName, Email, IsActive, CreatedAt) 
                                      VALUES (@Username, @Password, 'customer', @FullName, @Email, 1, GETDATE());
                                      SELECT SCOPE_IDENTITY();";

                using (SqlCommand cmd = new SqlCommand(insertQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@Username", finalUsername);
                    cmd.Parameters.AddWithValue("@Password", ""); // Empty password for Google users
                    cmd.Parameters.AddWithValue("@FullName", name);
                    cmd.Parameters.AddWithValue("@Email", email);

                    int newUserId = Convert.ToInt32(cmd.ExecuteScalar());

                    return new
                    {
                        UserId = newUserId,
                        Username = finalUsername,
                        UserType = "customer",
                        FullName = name,
                        Email = email
                    };
                }
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

    // Helper class for login result
    public class LoginResult
    {
        public bool Success { get; set; }
        public int UserId { get; set; }
        public string Username { get; set; }
        public string UserType { get; set; }
        public string FullName { get; set; }
        public string Email { get; set; }
        public string Phone { get; set; }
        public string ErrorMessage { get; set; }
    }
}