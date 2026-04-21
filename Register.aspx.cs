using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Text.RegularExpressions;
using System.Net;
using System.Net.Mail;

namespace TasteNet
{
    public partial class Register : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["TasteNetDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ClearAllMessages();
            }
        }

        // Generate 6 digit otp sending gmail
        private string GenerateOTP()
        {
            Random rand = new Random();
            return rand.Next(100000, 999999).ToString();
        }

        // Send OTP to email
        private void SendOTPEmail(string email, string otp)
        {
            try
            {
                MailMessage mail = new MailMessage();
                mail.From = new MailAddress("tastenet01@gmail.com");
                mail.To.Add(email);
                mail.Subject = "TasteNet Email Verification";
                mail.Body = "Your OTP code is: " + otp + "\n\nThis code will expire in 5 minutes.\n\nThank you for registering with TasteNet!";
                mail.IsBodyHtml = false;

                SmtpClient smtp = new SmtpClient();
                smtp.Host = "smtp.gmail.com";
                smtp.Port = 587;
                smtp.EnableSsl = true;
                smtp.Credentials = new NetworkCredential("tastenet01@gmail.com", "birs aigq ojwz gvpv");
                smtp.Send(mail);
            }
            catch (Exception ex)
            {
                lblGeneralError.Text = "Email sending failed: " + ex.Message;
                lblGeneralError.Visible = true;
            }
        }

        // Validate Philippine mobile number if ever na may same number sa database
        private bool IsValidPhilippineMobile(string mobileNumber)
        {
            if (string.IsNullOrEmpty(mobileNumber))
                return false;

            string cleaned = Regex.Replace(mobileNumber, @"\D", "");
            return cleaned.Length == 10 && cleaned.StartsWith("9");
        }

        // 63+ format sa mob num
        private string GetFullMobileNumber(string mobileNumber)
        {
            string cleaned = Regex.Replace(mobileNumber, @"\D", "");
            return "+63" + cleaned;
        }

        private bool IsValidEmail(string email)
        {
            try
            {
                var addr = new MailAddress(email);
                return addr.Address == email;
            }
            catch
            {
                return false;
            }
        }
        private void ClearAllMessages()
        {
            lblGeneralError.Visible = false;
            lblFullNameError.Visible = false;
            lblUsernameError.Visible = false;
            lblEmailError.Visible = false;
            lblMobileError.Visible = false;
            lblPasswordError.Visible = false;
            lblConfirmPasswordError.Visible = false;
            lblGenderError.Visible = false;
            lblOTPError.Visible = false;
            lblSuccess.Visible = false;
        }
        private void ClearFormFields()
        {
            txtFullName.Text = "";
            txtUsername.Text = "";
            txtEmail.Text = "";
            txtMobile.Text = "";
            txtPassword.Text = "";
            txtConfirmPassword.Text = "";
            txtOTP.Text = "";
            rblGender.ClearSelection();
        }
        private bool UserExists(string username, string email)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = "SELECT COUNT(*) FROM [Users] WHERE Username = @Username OR Email = @Email";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Username", username);
                cmd.Parameters.AddWithValue("@Email", email);
                int count = (int)cmd.ExecuteScalar();
                return count > 0;
            }
        }
        private bool RegisterCustomerInDatabase(string fullName, string username, string email,
            string phone, string password, string gender, string userType)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    if (UserExists(username, email))
                    {
                        lblGeneralError.Text = "Username or Email already exists!";
                        lblGeneralError.Visible = true;
                        return false;
                    }

                    string insertQuery = @"INSERT INTO [Users] 
                        (Username, Password, UserType, FullName, Email, Phone, Gender, IsActive, CreatedAt)
                        VALUES 
                        (@Username, @Password, @UserType, @FullName, @Email, @Phone, @Gender, 1, @CreatedAt)";

                    SqlCommand insertCmd = new SqlCommand(insertQuery, conn);
                    insertCmd.Parameters.AddWithValue("@Username", username);
                    insertCmd.Parameters.AddWithValue("@Password", password);
                    insertCmd.Parameters.AddWithValue("@UserType", userType);
                    insertCmd.Parameters.AddWithValue("@FullName", fullName);
                    insertCmd.Parameters.AddWithValue("@Email", email);
                    insertCmd.Parameters.AddWithValue("@Phone", phone);
                    insertCmd.Parameters.AddWithValue("@Gender", gender);
                    insertCmd.Parameters.AddWithValue("@CreatedAt", DateTime.Now);

                    int rows = insertCmd.ExecuteNonQuery();
                    return rows > 0;
                }
            }
            catch (SqlException ex)
            {
                lblGeneralError.Text = "Database error: " + ex.Message;
                lblGeneralError.Visible = true;
                return false;
            }
            catch (Exception ex)
            {
                lblGeneralError.Text = "Error: " + ex.Message;
                lblGeneralError.Visible = true;
                return false;
            }
        }

        // Register button click - sends OTP proct lang to
        protected void btnCustomerRegister_Click(object sender, EventArgs e)
        {
            ClearAllMessages();

            string fullName = txtFullName.Text.Trim();
            string username = txtUsername.Text.Trim();
            string email = txtEmail.Text.Trim();
            string mobile = txtMobile.Text.Trim();
            string fullMobile = GetFullMobileNumber(mobile);
            string password = txtPassword.Text.Trim();
            string confirmPassword = txtConfirmPassword.Text.Trim();
            string gender = rblGender.SelectedValue;
            string userType = "Customer";

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
                lblEmailError.Text = "Invalid email format";
                lblEmailError.Visible = true;
                isValid = false;
            }

            if (string.IsNullOrEmpty(mobile))
            {
                lblMobileError.Text = "Mobile number is required";
                lblMobileError.Visible = true;
                isValid = false;
            }
            else if (!IsValidPhilippineMobile(mobile))
            {
                lblMobileError.Text = "Invalid mobile number (must start with 9 and be 10 digits)";
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

            if (password != confirmPassword)
            {
                lblConfirmPasswordError.Text = "Passwords do not match";
                lblConfirmPasswordError.Visible = true;
                isValid = false;
            }

            if (string.IsNullOrEmpty(gender))
            {
                lblGenderError.Text = "Please select gender";
                lblGenderError.Visible = true;
                isValid = false;
            }

            if (!isValid)
            {
                lblGeneralError.Text = "Please fix the errors above.";
                lblGeneralError.Visible = true;
                return;
            }

            if (UserExists(username, email))
            {
                lblGeneralError.Text = "Username or Email already exists!";
                lblGeneralError.Visible = true;
                return;
            }

            string otp = GenerateOTP();

            Session["RegisterOTP"] = otp;
            Session["FullName"] = fullName;
            Session["Username"] = username;
            Session["Email"] = email;
            Session["Mobile"] = fullMobile;
            Session["Password"] = password;
            Session["Gender"] = gender;
            Session["UserType"] = userType;

            SendOTPEmail(email, otp);

            string script = "setTimeout(function() { showOTPSection(); }, 100);";
            ClientScript.RegisterStartupScript(this.GetType(), "showOTP", script, true);

        }

        protected void btnVerifyOTP_Click(object sender, EventArgs e)
        {
            string userOTP = txtOTP.Text.Trim();
            string sessionOTP = Session["RegisterOTP"]?.ToString();

            if (string.IsNullOrEmpty(userOTP))
            {
                lblOTPError.Text = "Please enter the OTP code.";
                lblOTPError.Visible = true;
                return;
            }

            if (userOTP == sessionOTP)
            {
                if (Session["FullName"] == null || Session["Username"] == null ||
                    Session["Email"] == null || Session["Mobile"] == null ||
                    Session["Password"] == null || Session["Gender"] == null)
                {
                    lblGeneralError.Text = "Session expired. Please register again.";
                    lblGeneralError.Visible = true;
                    return;
                }

                string fullName = Session["FullName"].ToString();
                string username = Session["Username"].ToString();
                string email = Session["Email"].ToString();
                string mobile = Session["Mobile"].ToString();
                string password = Session["Password"].ToString();
                string gender = Session["Gender"].ToString();
                string userType = Session["UserType"]?.ToString() ?? "Customer";

                bool success = RegisterCustomerInDatabase(fullName, username, email, mobile, password, gender, userType);

                if (success)
                {
                    // Clear OTP from session
                    Session.Remove("RegisterOTP");

                    // Show success message
                    lblSuccess.Text = "Registration successful! Redirecting to login page...";
                    lblSuccess.Visible = true;

                    // Hide OTP section
                    string hideScript = "hideOTPSection();";
                    ClientScript.RegisterStartupScript(this.GetType(), "hideOTP", hideScript, true);

                    // Show success box and redirect
                    string successScript = "showSuccessMessage(); setTimeout(function(){ window.location.href='Login.aspx'; }, 3000);";
                    ClientScript.RegisterStartupScript(this.GetType(), "success", successScript, true);

                    // Clear form fields
                    ClearFormFields();
                }
                else
                {
                    lblOTPError.Text = "Registration failed. Username or email may already exist.";
                    lblOTPError.Visible = true;
                }
            }
            else
            {
                lblOTPError.Text = "Invalid OTP. Please try again.";
                lblOTPError.Visible = true;
            }
        }

        protected void btnResendOTP_Click(object sender, EventArgs e)
        {
            string email = Session["Email"]?.ToString();

            if (string.IsNullOrEmpty(email))
            {
                lblGeneralError.Text = "Session expired. Please register again.";
                lblGeneralError.Visible = true;
                return;
            }

            string otp = GenerateOTP();
            Session["RegisterOTP"] = otp;

            SendOTPEmail(email, otp);

            lblSuccess.Text = "New OTP sent to " + email;
            lblSuccess.Visible = true;
            lblOTPError.Visible = false;

            // eto yung timer pagkasend ng otp
            string resetTimerScript = "if(timerInterval) clearInterval(timerInterval); startTimer(300);";
            ClientScript.RegisterStartupScript(this.GetType(), "resetTimer", resetTimerScript, true);
        }
    }
}