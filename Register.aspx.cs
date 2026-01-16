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
            // 1. Get values from inputs
            string fullName = txtFullName.Text.Trim();
            string username = txtUsername.Text.Trim();
            string email = txtEmail.Text.Trim();
            string mobile = txtMobile.Text.Trim();
            string password = txtPassword.Text.Trim();
            string confirmPassword = txtConfirmPassword.Text.Trim();
            string gender = rblGender.SelectedValue;

            // 2. Not Null Validation Logic
            if (string.IsNullOrEmpty(fullName) ||
                string.IsNullOrEmpty(username) ||
                string.IsNullOrEmpty(email) ||
                string.IsNullOrEmpty(mobile) ||
                string.IsNullOrEmpty(password) ||
                string.IsNullOrEmpty(gender))
            {
                // Display an error message (You can use a Label or JavaScript Alert)
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('All fields are required!');", true);
                return;
            }

            // 3. Password Match Validation
            if (password != confirmPassword)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Passwords do not match!');", true);
                return;
            }

            // 4. If all checks pass, proceed to Database logic
            RegisterUserInDatabase(fullName, username, email, mobile, password, gender);
        }

        private void RegisterUserInDatabase(string name, string user, string mail, string phone, string pass, string gen)
        {
            // Your SQL connection and Insert logic goes here
            // Example: INSERT INTO Users (FullName, Username, Email, Mobile, Password, Gender) ...
        }
    }
}