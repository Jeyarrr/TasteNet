using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace TasteNet
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            lblError.Visible = false;
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string emailOrUsername = txtUsername.Text.Trim();
            string password = txtPassword.Text; // Plain text password

            lblError.Visible = false;
            lblError.Text = "";

            try
            {
                using (SqlConnection conn = GetConnection())
                {
                    conn.Open();

                    string query = @"
                        SELECT Username, UserType, Password, IsActive
                        FROM Users 
                        WHERE (Email = @Login OR Username = @Login)";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Login", emailOrUsername);

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                string dbPassword = reader["Password"].ToString();
                                string username = reader["Username"].ToString();
                                string userType = reader["UserType"].ToString();
                                bool isActive = Convert.ToBoolean(reader["IsActive"]);

                                // Compare plain text passwords directly
                                if (dbPassword == password && isActive)
                                {
                                    SetUserSession(username, userType);

                                    // Redirect based on user type
                                    switch (userType.ToLower())
                                    {
                                        case "superadmin":
                                            Response.Redirect("~/Users/SuperAdmin/Dashboard.aspx");
                                            break;
                                        case "admin":
                                            Response.Redirect("~/Users/Admin/Inventory.aspx");
                                            break;
                                        case "rider":
                                            Response.Redirect("~/Users/Rider/Dashboard.aspx");
                                            break;
                                        case "customer":
                                            Response.Redirect("~/Users/Customer/CustomerPortal.aspx");
                                            break;
                                        default:
                                            Response.Redirect("~/Default.aspx");
                                            break;
                                    }
                                    return;
                                }
                                else if (!isActive)
                                {
                                    lblError.Text = "Account is deactivated. Please contact support.";
                                }
                                else
                                {
                                    lblError.Text = "Invalid username/email or password";
                                }
                            }
                            else
                            {
                                lblError.Text = "Invalid username/email or password";
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblError.Text = "Database error: " + ex.Message;
            }

            lblError.Visible = true;
            txtPassword.Text = "";
            txtUsername.Focus();
        }

        private void SetUserSession(string username, string userType)
        {
            Session["Username"] = username;
            Session["UserType"] = userType;
            Session[$"Is{userType}"] = true;
            Session["LoginTime"] = DateTime.Now;
        }

        private SqlConnection GetConnection()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["TasteNetDB"].ConnectionString;
            return new SqlConnection(connectionString);
        }
    }
}