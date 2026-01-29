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
            ClearAllMessages();
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            ClearAllMessages();

            string fullName = txtFullName.Text.Trim();
            string username = txtUsername.Text.Trim();
            string email = txtEmail.Text.Trim();
            string mobile = txtMobile.Text.Trim();
            string password = txtPassword.Text.Trim();
            string confirmPassword = txtConfirmPassword.Text.Trim();
            string gender = rblGender.SelectedValue;

            bool isValid = true;

            if (string.IsNullOrEmpty(fullName))
            {
                lblFullNameError.Text = "Full name is required";
                lblFullNameError.Visible = true;
                isValid = false;
            }

            if (string.IsNullOrEmpty(username))
            {
                lblUsernameError.Text = "Username is required";
                lblUsernameError.Visible = true;
                isValid = false;
            }

            if (string.IsNullOrEmpty(email))
            {
                lblEmailError.Text = "Email is required";
                lblEmailError.Visible = true;
                isValid = false;
            }
            else if (!IsValidEmail(email))
            {
                lblEmailError.Text = "Please enter a valid email";
                lblEmailError.Visible = true;
                isValid = false;
            }

            if (string.IsNullOrEmpty(mobile))
            {
                lblMobileError.Text = "Mobile number is required";
                lblMobileError.Visible = true;
                isValid = false;
            }

            if (string.IsNullOrEmpty(password))
            {
                lblPasswordError.Text = "Password is required";
                lblPasswordError.Visible = true;
                isValid = false;
            }
            else if (password.Length < 6)
            {
                lblPasswordError.Text = "Password must be at least 6 characters";
                lblPasswordError.Visible = true;
                isValid = false;
            }

            if (string.IsNullOrEmpty(confirmPassword))
            {
                lblConfirmPasswordError.Text = "Please confirm your password";
                lblConfirmPasswordError.Visible = true;
                isValid = false;
            }
            else if (password != confirmPassword)
            {
                lblConfirmPasswordError.Text = "Passwords do not match";
                lblConfirmPasswordError.Visible = true;
                txtPassword.Text = "";
                txtConfirmPassword.Text = "";
                txtPassword.Focus();
                isValid = false;
            }

            if (string.IsNullOrEmpty(gender))
            {
                lblGenderError.Text = "Please select a gender";
                lblGenderError.Visible = true;
                isValid = false;
            }

            if (!isValid)
            {
                lblGeneralError.Text = "All Data Fields Required";
                lblGeneralError.Visible = true;
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
                lblGeneralError.Text = "Registration failed. Username or email might already exist.";
                lblGeneralError.Visible = true;
            }
        }

        private void ClearAllMessages()
        {
            lblGeneralError.Visible = false;
            lblGeneralError.Text = "";

            lblFullNameError.Visible = false;
            lblFullNameError.Text = "";

            lblUsernameError.Visible = false;
            lblUsernameError.Text = "";

            lblEmailError.Visible = false;
            lblEmailError.Text = "";

            lblMobileError.Visible = false;
            lblMobileError.Text = "";

            lblPasswordError.Visible = false;
            lblPasswordError.Text = "";

            lblConfirmPasswordError.Visible = false;
            lblConfirmPasswordError.Text = "";

            lblGenderError.Visible = false;
            lblGenderError.Text = "";

            lblSuccess.Visible = false;
            lblSuccess.Text = "";
        }

        private bool RegisterUserInDatabase(string name, string user, string mail, string phone, string pass, string gen)
        {
            try
            {
                // database logic na dito pag meron ng db
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