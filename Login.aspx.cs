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

            switch (username.ToLower())
            {
                case "superadmin" when password == "superadmin":
                    SetUserSession(username, "SuperAdmin");
                    Response.Redirect(ResolveUrl("~/Users/SuperAdmin/Dashboard.aspx"));
                    return;

                case "admin" when password == "admin":
                    SetUserSession(username, "Admin");
                    Response.Redirect(ResolveUrl("~/Users/Admin/Inventory.aspx"));
                    return;

                case "rider" when password == "rider":
                    SetUserSession(username, "Rider");
                    Response.Redirect(ResolveUrl("~/Users/Rider/Dashboard.aspx"));
                    return;

                case "customer" when password == "customer":
                    SetUserSession(username, "Customer");
                    Response.Redirect(ResolveUrl("~/Users/Customer/LandingPage.aspx"));
                    return;

                default:
                    lblError.Text = "Invalid username or password";
                    lblError.Visible = true;
                    txtPassword.Text = "";
                    txtUsername.Focus();
                    return;
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