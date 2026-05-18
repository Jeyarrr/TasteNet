using System;
using System.Data;
using System.Data.SqlClient;
using System.Net;
using System.Net.Mail;
using System.Web.UI;
using System.Web.Security;

namespace TasteNet
{
    public partial class ForgotPassword : System.Web.UI.Page
    {
        string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["TasteNetDB"].ConnectionString;

        string gmailEmail = "tastenet01@gmail.com";
        string gmailAppPassword = "birs aigq ojwz gvpv";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string email = Session["ResetEmail"]?.ToString();
                if (!string.IsNullOrEmpty(email))
                {
                    CleanExpiredOTPs(email);
                }
                Session["ResetEmail"] = null;
            }
        }

        protected void btnSendOTP_Click(object sender, EventArgs e)
        {
            try
            {
                string email = txtEmail.Text.Trim();

                if (IsEmailExists(email))
                {
                    string otp = GenerateOTP();
                    DateTime expiryTime = DateTime.Now.AddMinutes(10);

                    if (SaveOTPToDatabase(email, otp, expiryTime))
                    {
                        if (SendOTPEmail(email, otp))
                        {
                            Session["ResetEmail"] = email;

                            lblMessage.Text = "OTP has been sent to your email address. Valid for 10 minutes.";
                            lblMessage.CssClass = "message success";
                            lblMessage.Visible = true;

                            pnlEmail.Visible = false;
                            pnlOTP.Visible = true;

                            ClientScript.RegisterStartupScript(this.GetType(), "timer", "startTimer(600);", true);
                        }
                        else
                        {
                            lblMessage.Text = "Failed to send OTP. Please try again later.";
                            lblMessage.CssClass = "message error";
                            lblMessage.Visible = true;
                        }
                    }
                    else
                    {
                        lblMessage.Text = "Failed to generate OTP. Please try again.";
                        lblMessage.CssClass = "message error";
                        lblMessage.Visible = true;
                    }
                }
                else
                {
                    lblMessage.Text = "Email address not found in our records.";
                    lblMessage.CssClass = "message error";
                    lblMessage.Visible = true;
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "An error occurred: " + ex.Message;
                lblMessage.CssClass = "message error";
                lblMessage.Visible = true;
            }
        }

        protected void btnResetPassword_Click(object sender, EventArgs e)
        {
            try
            {
                string email = Session["ResetEmail"]?.ToString();
                string enteredOTP = txtOTP.Text.Trim();

                if (string.IsNullOrEmpty(email))
                {
                    lblMessage.Text = "Session expired. Please request OTP again.";
                    lblMessage.CssClass = "message error";
                    lblMessage.Visible = true;
                    ResetForm();
                    return;
                }

                if (ValidateOTP(email, enteredOTP))
                {
                    string newPassword = txtNewPassword.Text.Trim();
                    string confirmPassword = txtConfirmPassword.Text.Trim();

                    if (string.IsNullOrEmpty(newPassword) || newPassword.Length < 6)
                    {
                        lblMessage.Text = "Password must be at least 6 characters long.";
                        lblMessage.CssClass = "message error";
                        lblMessage.Visible = true;
                        return;
                    }

                    if (newPassword != confirmPassword)
                    {
                        lblMessage.Text = "Passwords do not match.";
                        lblMessage.CssClass = "message error";
                        lblMessage.Visible = true;
                        return;
                    }

                    string plainTextPassword = newPassword;

                    if (UpdatePassword(email, plainTextPassword))
                    {
                        MarkOTPAsVerified(email, enteredOTP);

                        CleanExpiredOTPs(email);

                        lblMessage.Text = "Password reset successfully! Redirecting to login page...";
                        lblMessage.CssClass = "message success";
                        lblMessage.Visible = true;

                        Session.Clear();
                        Session.Abandon();

                        ClientScript.RegisterStartupScript(this.GetType(), "redirect",
                            "setTimeout(function(){ window.location.href = 'Login.aspx'; }, 3000);", true);
                    }
                    else
                    {
                        lblMessage.Text = "Failed to reset password. Please try again.";
                        lblMessage.CssClass = "message error";
                        lblMessage.Visible = true;
                    }
                }
                else
                {
                    lblMessage.Text = "Invalid or expired OTP. Please try again.";
                    lblMessage.CssClass = "message error";
                    lblMessage.Visible = true;
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "An error occurred: " + ex.Message;
                lblMessage.CssClass = "message error";
                lblMessage.Visible = true;
            }
        }

        protected void btnResendOTP_Click(object sender, EventArgs e)
        {
            try
            {
                string email = Session["ResetEmail"]?.ToString();

                if (!string.IsNullOrEmpty(email))
                {
                    CleanExpiredOTPs(email);

                    string newOTP = GenerateOTP();
                    DateTime expiryTime = DateTime.Now.AddMinutes(10);

                    if (SaveOTPToDatabase(email, newOTP, expiryTime))
                    {
                        if (SendOTPEmail(email, newOTP))
                        {
                            lblMessage.Text = "New OTP has been sent to your email address.";
                            lblMessage.CssClass = "message success";
                            lblMessage.Visible = true;

                            ClientScript.RegisterStartupScript(this.GetType(), "timer", "clearTimer(); startTimer(600);", true);
                        }
                        else
                        {
                            lblMessage.Text = "Failed to send OTP. Please try again.";
                            lblMessage.CssClass = "message error";
                            lblMessage.Visible = true;
                        }
                    }
                    else
                    {
                        lblMessage.Text = "Failed to generate OTP. Please try again.";
                        lblMessage.CssClass = "message error";
                        lblMessage.Visible = true;
                    }
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "An error occurred: " + ex.Message;
                lblMessage.CssClass = "message error";
                lblMessage.Visible = true;
            }
        }

        private string GenerateOTP()
        {
            Random random = new Random();
            return random.Next(100000, 999999).ToString();
        }

        private bool IsEmailExists(string email)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT COUNT(*) FROM Users WHERE Email = @Email AND IsActive = 1";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Email", email);
                    conn.Open();
                    int count = (int)cmd.ExecuteScalar();
                    return count > 0;
                }
            }
        }

        private bool SaveOTPToDatabase(string email, string otp, DateTime expiryTime)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"INSERT INTO EmailOTP (Email, OTPCode, IsVerified, ExpiresAt, CreatedAt) 
                               VALUES (@Email, @OTPCode, 0, @ExpiresAt, GETDATE())";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@OTPCode", otp);
                    cmd.Parameters.AddWithValue("@ExpiresAt", expiryTime);

                    conn.Open();
                    int rowsAffected = cmd.ExecuteNonQuery();
                    return rowsAffected > 0;
                }
            }
        }

        private bool ValidateOTP(string email, string otp)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"SELECT COUNT(*) FROM EmailOTP 
                               WHERE Email = @Email 
                               AND OTPCode = @OTPCode 
                               AND IsVerified = 0 
                               AND ExpiresAt > GETDATE()";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@OTPCode", otp);

                    conn.Open();
                    int count = (int)cmd.ExecuteScalar();
                    return count > 0;
                }
            }
        }

        private void MarkOTPAsVerified(string email, string otp)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"UPDATE EmailOTP 
                               SET IsVerified = 1 
                               WHERE Email = @Email AND OTPCode = @OTPCode AND IsVerified = 0";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@OTPCode", otp);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        private void CleanExpiredOTPs(string email)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"DELETE FROM EmailOTP 
                               WHERE Email = @Email AND (ExpiresAt <= GETDATE() OR IsVerified = 1)";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Email", email);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        private bool UpdatePassword(string email, string plainTextPassword)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "UPDATE Users SET Password = @Password WHERE Email = @Email";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Password", plainTextPassword);
                    cmd.Parameters.AddWithValue("@Email", email);

                    conn.Open();
                    int rowsAffected = cmd.ExecuteNonQuery();
                    return rowsAffected > 0;
                }
            }
        }

        private bool SendOTPEmail(string toEmail, string otp)
        {
            try
            {
                using (SmtpClient smtpClient = new SmtpClient("smtp.gmail.com", 587))
                {
                    smtpClient.EnableSsl = true;
                    smtpClient.UseDefaultCredentials = false;
                    smtpClient.Credentials = new NetworkCredential(gmailEmail, gmailAppPassword);
                    smtpClient.DeliveryMethod = SmtpDeliveryMethod.Network;
                    smtpClient.Timeout = 20000;

                    MailMessage mail = new MailMessage();
                    mail.From = new MailAddress(gmailEmail, "TasteNet Delivery System");
                    mail.To.Add(toEmail);
                    mail.Subject = "Password Reset OTP - TasteNet";
                    mail.Body = $@"
                        <html>
                        <body style='font-family: Arial, sans-serif;'>
                            <h2 style='color: #4CAF50;'>Password Reset Request</h2>
                            <p>Hello,</p>
                            <p>We received a request to reset your password for your TasteNet account.</p>
                            <p>Please use the following OTP to reset your password:</p>
                            <div style='background-color: #f4f4f4; padding: 20px; font-size: 28px; font-weight: bold; text-align: center; letter-spacing: 5px; border-radius: 5px;'>
                                {otp}
                            </div>
                            <p><strong>This OTP is valid for 10 minutes.</strong></p>
                            <p>If you didn't request this password reset, please ignore this email or contact support.</p>
                            <hr />
                            <p style='font-size: 12px; color: #666;'>This is an automated message, please do not reply to this email.</p>
                            <p>Best regards,<br/><strong>TasteNet Delivery System Team</strong></p>
                        </body>
                        </html>";
                    mail.IsBodyHtml = true;

                    smtpClient.Send(mail);
                    return true;
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Email Error: " + ex.Message);
                return false;
            }
        }

        private void ResetForm()
        {
            string email = Session["ResetEmail"]?.ToString();
            if (!string.IsNullOrEmpty(email))
            {
                CleanExpiredOTPs(email);
            }

            Session["ResetEmail"] = null;

            pnlEmail.Visible = true;
            pnlOTP.Visible = false;
            txtEmail.Text = "";
            txtOTP.Text = "";
            txtNewPassword.Text = "";
            txtConfirmPassword.Text = "";

            ClientScript.RegisterStartupScript(this.GetType(), "clearTimer", "clearTimer();", true);
        }
    }
}