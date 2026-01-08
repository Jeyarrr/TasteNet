using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
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
                // Clear any existing session
                Session.Clear();

                // Hide error panel initially
                pnlError.CssClass = "error-message";
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string username = txtUsername.Text.Trim();
                string password = txtPassword.Text;

                // Validate credentials
                if (ValidateUser(username, password))
                {
                    // Set session variables
                    Session["Username"] = username;
                    Session["IsAuthenticated"] = true;
                    Session["LoginTime"] = DateTime.Now;

                    // Redirect to dashboard or home page
                    Response.Redirect("~/Dashboard.aspx");
                }
                else
                {
                    ShowError("Invalid username or password. Please try again.");
                }
            }
        }

        private bool ValidateUser(string username, string password)
        {
            try
            {
                // Connection string from Web.config
                string connectionString = ConfigurationManager.ConnectionStrings["CaballerosDB"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"SELECT COUNT(1) FROM Users 
                                   WHERE Username = @Username 
                                   AND PasswordHash = HASHBYTES('SHA2_512', @Password + Salt) 
                                   AND IsActive = 1";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Username", username);
                        cmd.Parameters.AddWithValue("@Password", password);

                        conn.Open();
                        int count = Convert.ToInt32(cmd.ExecuteScalar());

                        if (count == 1)
                        {
                            // Update last login time
                            UpdateLastLogin(username, conn);
                            return true;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Log the error (implement your logging mechanism)
                LogError(ex);
                ShowError("An error occurred during login. Please try again later.");
            }

            return false;
        }

        private void UpdateLastLogin(string username, SqlConnection conn)
        {
            try
            {
                string updateQuery = "UPDATE Users SET LastLoginDate = @LoginDate WHERE Username = @Username";

                using (SqlCommand cmd = new SqlCommand(updateQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@LoginDate", DateTime.Now);
                    cmd.Parameters.AddWithValue("@Username", username);
                    cmd.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {
                // Log the error but don't prevent login
                LogError(ex);
            }
        }

        protected void btnFacebook_Click(object sender, EventArgs e)
        {
            // Implement Facebook OAuth integration
            // Redirect to Facebook authentication endpoint
            string facebookAuthUrl = "https://www.facebook.com/v12.0/dialog/oauth?" +
                                    "client_id=YOUR_FACEBOOK_APP_ID" +
                                    "&redirect_uri=YOUR_REDIRECT_URI" +
                                    "&scope=email,public_profile";

            // Response.Redirect(facebookAuthUrl);
            ShowError("Facebook sign-in is currently unavailable. Please use username/password.");
        }

        protected void btnGoogle_Click(object sender, EventArgs e)
        {
            // Implement Google OAuth integration
            // Redirect to Google authentication endpoint
            string googleAuthUrl = "https://accounts.google.com/o/oauth2/v2/auth?" +
                                  "client_id=YOUR_GOOGLE_CLIENT_ID" +
                                  "&redirect_uri=YOUR_REDIRECT_URI" +
                                  "&response_type=code" +
                                  "&scope=email profile";

            // Response.Redirect(googleAuthUrl);
            ShowError("Google sign-in is currently unavailable. Please use username/password.");
        }

        private void ShowError(string message)
        {
            lblError.Text = message;
            pnlError.CssClass = "error-message show";
        }

        private void LogError(Exception ex)
        {
            // Implement your logging mechanism here
            // Examples: Log to file, database, or application insights
            System.Diagnostics.Debug.WriteLine($"Login Error: {ex.Message}");

            // You can also use a logging framework like NLog or log4net
            // Logger.Error(ex, "Login error occurred");
    }
    }
}