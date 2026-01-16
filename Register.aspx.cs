using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TasteNet
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnRegister_Click(object sender, EventArgs e)
        {
            // Password validation
            if (txtPassword.Text != txtConfirmPassword.Text)
            {
                ClientScript.RegisterStartupScript(this.GetType(),
                    "alert", "alert('Passwords do not match');", true);
                return;
            }

            // TODO:
            // - Hash password
            // - Insert into MSSQL
            // - Redirect to Login

            ClientScript.RegisterStartupScript(this.GetType(),
                "alert", "alert('Registration successful!');", true);
        }
    }
}