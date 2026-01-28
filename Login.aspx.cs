using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebGrease.Activities;

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

            if (username == "superadmin" && password == "superadmin")
            {
                Session["Username"] = username;
                Session["IsSuperAdmin"] = true;

                Response.Redirect(ResolveUrl("~/Users/SuperAdmin/Dashboard.aspx"));
            }
            else
            {
                lblError.Text = "Invalid username or password";
                lblError.Visible = true;

                txtPassword.Text = "";
                txtUsername.Focus();
            }
        }
    }
}