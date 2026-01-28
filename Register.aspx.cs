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
            lblError.Visible = false;
            lblSuccess.Visible = false;
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            lblError.Visible = false;
            lblError.Text = "";
            lblSuccess.Visible = false;
            lblSuccess.Text = "";

            string fullName = txtFullName.Text.Trim();
            string username = txtUsername.Text.Trim();
            string email = txtEmail.Text.Trim();
            string mobile = txtMobile.Text.Trim();
            string password = txtPassword.Text.Trim();
            string confirmPassword = txtConfirmPassword.Text.Trim();
            string gender = rblGender.SelectedValue;

            if (string.IsNullOrEmpty(fullName) ||
                string.IsNullOrEmpty(username) ||
                string.IsNullOrEmpty(email) ||
                string.IsNullOrEmpty(mobile) ||
                string.IsNullOrEmpty(password) ||
                string.IsNullOrEmpty(gender))
            {
                lblError.Text = "All fields are required!";
                lblError.Visible = true;
                return;
            }

            if (password != confirmPassword)
            {
                lblError.Text = "Passwords do not match!";
                lblError.Visible = true;
                txtPassword.Text = "";
                txtConfirmPassword.Text = "";
                txtPassword.Focus();
                return;
            }

            if (password.Length < 6)
            {
                lblError.Text = "Password must be at least 6 characters long!";
                lblError.Visible = true;
                return;
            }

            if (!IsValidEmail(email))
            {
                lblError.Text = "Please enter a valid email address!";
                lblError.Visible = true;
                return;
            }

            bool registrationSuccess = RegisterUserInDatabase(fullName, username, email, mobile, password, gender);

            if (registrationSuccess)
            {
                lblSuccess.Text = "Registration successful! You can now login.";
                lblSuccess.Visible = true;
                ClearFormFields();
            }
            else
            {
                lblError.Text = "Registration failed. Username or email might already exist.";
                lblError.Visible = true;
            }
        }

        private bool RegisterUserInDatabase(string name, string user, string mail, string phone, string pass, string gen)
        {
            try
            {
                return true;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Registration error: {ex.Message}");
                return false;
            }
        }

        private bool IsValidEmail(string email)
        {
            try
            {
                var addr = new System.Net.Mail.MailAddress(email);
                return addr.Address == email;
            }
            catch
            {
                return false;
            }
        }

        private void ClearFormFields()
        {
            txtFullName.Text = "";
            txtUsername.Text = "";
            txtEmail.Text = "";
            txtMobile.Text = "";
            txtPassword.Text = "";
            txtConfirmPassword.Text = "";
            rblGender.ClearSelection();
        }
    }
}