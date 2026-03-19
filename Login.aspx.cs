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
            lblError.Visible = false;
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text;

            lblError.Visible = false;
            lblError.Text = "";

            if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
            {
                lblError.Text = "Please enter your username and password.";
                lblError.Visible = true;
                return;
            }

            string userType = null;

            try
            {
                string connStr = ConfigurationManager.ConnectionStrings["TasteNetDB"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();

                    string query = @"SELECT UserType FROM Users 
                                     WHERE Username = @Username 
                                       AND Password = @Password 
                                       AND IsActive = 1";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Username", username);
                        cmd.Parameters.AddWithValue("@Password", password);

                        object result = cmd.ExecuteScalar();
                        if (result != null)
                            userType = result.ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                lblError.Text = "A system error occurred. Please try again.";
                lblError.Visible = true;
                return;
            }

            if (userType == null)
            {
                lblError.Text = "Invalid username or password.";
                lblError.Visible = true;
                txtPassword.Text = "";
                txtUsername.Focus();
                return;
            }

            SetUserSession(username, userType);

            switch (userType)
            {
                case "SuperAdmin":
                    Response.Redirect(ResolveUrl("~/Users/SuperAdmin/Dashboard.aspx"));
                    break;
                case "Admin":
                    Response.Redirect(ResolveUrl("~/Users/Admin/Inventory.aspx"));
                    break;
                case "Rider":
                    Response.Redirect(ResolveUrl("~/Users/Rider/Dashboard.aspx"));
                    break;
                case "Customer":
                    Response.Redirect(ResolveUrl("~/Users/Customer/LandingPage.aspx"));
                    break;
                default:
                    lblError.Text = "Unrecognized user role. Please contact support.";
                    lblError.Visible = true;
                    break;
            }
        }

        private void SetUserSession(string username, string userType)
        {
            Session["Username"] = username;
            Session["UserType"] = userType;
            Session[$"Is{userType}"] = true;
            Session["LoginTime"] = DateTime.Now;
        }
    }
}