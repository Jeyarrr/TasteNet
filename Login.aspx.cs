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
        }
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text;
            string password = txtPassword.Text;

            if (username == "admin" && password == "admin")
            {
                Response.Redirect(ResolveUrl("~/Users/SuperAdmin/Dashboard.aspx"));

            }
            else
            {
                ClientScript.RegisterStartupScript(
                    this.GetType(), 
                    "alert",
                    "alert('Invalid username or password');", 
                    true
                    );
            }
        }
    }
}