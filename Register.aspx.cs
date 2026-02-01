using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

namespace TasteNet
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ClearAllMessages();
            ClearRiderMessages();
        }

        protected void btnCustomerRegister_Click(object sender, EventArgs e)
        {
            ClearAllMessages();
            ClearRiderMessages();

            string fullName = txtFullName.Text.Trim();
            string username = txtUsername.Text.Trim();
            string email = txtEmail.Text.Trim();
            string mobile = txtMobile.Text.Trim();
            string password = txtPassword.Text.Trim();
            string confirmPassword = txtConfirmPassword.Text.Trim();
            string gender = rblGender.SelectedValue;
            string userType = hdnUserType.Value;

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

            if (string.IsNullOrEmpty(userType))
            {
                lblGeneralError.Text = "Please select user type (Customer or Rider)";
                lblGeneralError.Visible = true;
                isValid = false;
            }

            if (!isValid)
            {
                lblGeneralError.Text = "Please fill all required fields";
                lblGeneralError.Visible = true;
                RegisterClientScriptForCustomerValidation();
                return;
            }

            bool registrationSuccess = RegisterCustomerInDatabase(fullName, username, email, mobile, password, gender, userType);

            if (registrationSuccess)
            {
                lblSuccess.Text = "Registration successful! You can now login.";
                lblSuccess.Visible = true;
                RegisterClientScriptForCustomerSuccess();
                ClearFormFields();
            }
            else
            {
                lblGeneralError.Text = "Registration failed. Username or email might already exist.";
                lblGeneralError.Visible = true;
                RegisterClientScriptForCustomerError();
            }
        }

        private void RegisterClientScriptForCustomerValidation()
        {
            string script = @"
                <script type='text/javascript'>
                    document.getElementById('customerValidationSummary').classList.remove('hidden');
                    
                    let errorMessages = [];
                    const errorLabels = document.querySelectorAll('#customerRegisterCard .field-error, #customerRegisterCard .gender-error');
                    
                    errorLabels.forEach(label => {
                        if (label.textContent.trim() !== '' && label.style.display !== 'none') {
                            errorMessages.push(label.textContent);
                        }
                    });
                    
                    const errorList = document.getElementById('customerErrorList');
                    errorList.innerHTML = '';
                    errorMessages.forEach(msg => {
                        const li = document.createElement('li');
                        li.textContent = msg;
                        errorList.appendChild(li);
                    });
                    
                    document.getElementById('customerRegisterCard').scrollTop = 0;
                    
                    document.querySelectorAll('#customerRegisterCard input, #customerRegisterCard select').forEach(input => {
                        const inputId = input.id;
                        const errorLabel = document.querySelector(`[id$='${inputId}Error']`);
                        if (errorLabel && errorLabel.textContent.trim() !== '' && errorLabel.style.display !== 'none') {
                            input.classList.add('input-error');
                        }
                    });
                </script>
            ";
            ClientScript.RegisterStartupScript(this.GetType(), "ShowCustomerValidation", script);
        }

        private void RegisterClientScriptForCustomerSuccess()
        {
            string script = @"
                <script type='text/javascript'>
                    document.getElementById('customerValidationSummary').classList.add('hidden');
                    document.getElementById('customerSuccessBox').classList.remove('hidden');
                    document.querySelectorAll('.input-error').forEach(el => {
                        el.classList.remove('input-error');
                    });
                    document.getElementById('customerSuccessBox').scrollIntoView({ behavior: 'smooth', block: 'start' });
                </script>
            ";
            ClientScript.RegisterStartupScript(this.GetType(), "ShowCustomerSuccess", script);
        }

        private void RegisterClientScriptForCustomerError()
        {
            string script = @"
                <script type='text/javascript'>
                    document.getElementById('customerValidationSummary').classList.remove('hidden');
                    const errorList = document.getElementById('customerErrorList');
                    errorList.innerHTML = '<li>Registration failed. Username or email might already exist.</li>';
                    document.getElementById('customerRegisterCard').scrollTop = 0;
                </script>
            ";
            ClientScript.RegisterStartupScript(this.GetType(), "ShowCustomerError", script);
        }

        protected void btnRiderRegister_Click(object sender, EventArgs e)
        {
            ClearAllMessages();
            ClearRiderMessages();

            string fullName = txtRiderFullName.Text.Trim();
            string username = txtRiderUsername.Text.Trim();
            string email = txtRiderEmail.Text.Trim();
            string mobile = txtRiderMobile.Text.Trim();
            string driverLicense = txtDriverLicense.Text.Trim();
            string nbiClearance = txtNBIClearance.Text.Trim();
            string password = txtRiderPassword.Text.Trim();
            string confirmPassword = txtRiderConfirmPassword.Text.Trim();
            string gender = rblRiderGender.SelectedValue;
            string userType = "rider";

            string vehicleType = ddlVehicleType.SelectedValue;
            string makeModel = txtMakeModel.Text.Trim();
            string year = txtYear.Text.Trim();
            string licensePlate = txtLicensePlate.Text.Trim();
            string vehicleColor = txtVehicleColor.Text.Trim();
            string orcr = txtORCR.Text.Trim();

            string insurancePolicy = txtInsurancePolicy.Text.Trim();
            string insuranceExpiry = txtInsuranceExpiry.Text.Trim();

            bool isValid = true;

            if (string.IsNullOrEmpty(fullName))
            {
                lblRiderFullNameError.Text = "Full name is required";
                lblRiderFullNameError.Visible = true;
                isValid = false;
            }

            if (string.IsNullOrEmpty(username))
            {
                lblRiderUsernameError.Text = "Username is required";
                lblRiderUsernameError.Visible = true;
                isValid = false;
            }

            if (string.IsNullOrEmpty(email))
            {
                lblRiderEmailError.Text = "Email is required";
                lblRiderEmailError.Visible = true;
                isValid = false;
            }
            else if (!IsValidEmail(email))
            {
                lblRiderEmailError.Text = "Please enter a valid email";
                lblRiderEmailError.Visible = true;
                isValid = false;
            }

            if (string.IsNullOrEmpty(mobile))
            {
                lblRiderMobileError.Text = "Mobile number is required";
                lblRiderMobileError.Visible = true;
                isValid = false;
            }

            if (string.IsNullOrEmpty(driverLicense))
            {
                lblDriverLicenseError.Text = "Driver's license number is required";
                lblDriverLicenseError.Visible = true;
                isValid = false;
            }

            if (string.IsNullOrEmpty(nbiClearance))
            {
                lblNBIClearanceError.Text = "NBI Clearance number is required";
                lblNBIClearanceError.Visible = true;
                isValid = false;
            }

            if (string.IsNullOrEmpty(password))
            {
                lblRiderPasswordError.Text = "Password is required";
                lblRiderPasswordError.Visible = true;
                isValid = false;
            }
            else if (password.Length < 6)
            {
                lblRiderPasswordError.Text = "Password must be at least 6 characters";
                lblRiderPasswordError.Visible = true;
                isValid = false;
            }

            if (string.IsNullOrEmpty(confirmPassword))
            {
                lblRiderConfirmPasswordError.Text = "Please confirm your password";
                lblRiderConfirmPasswordError.Visible = true;
                isValid = false;
            }
            else if (password != confirmPassword)
            {
                lblRiderConfirmPasswordError.Text = "Passwords do not match";
                lblRiderConfirmPasswordError.Visible = true;
                txtRiderPassword.Text = "";
                txtRiderConfirmPassword.Text = "";
                txtRiderPassword.Focus();
                isValid = false;
            }

            if (string.IsNullOrEmpty(gender))
            {
                lblRiderGenderError.Text = "Please select a gender";
                lblRiderGenderError.Visible = true;
                isValid = false;
            }

            if (string.IsNullOrEmpty(vehicleType) || vehicleType == "")
            {
                lblVehicleTypeError.Text = "Vehicle type is required";
                lblVehicleTypeError.Visible = true;
                isValid = false;
            }

            if (string.IsNullOrEmpty(makeModel))
            {
                lblMakeModelError.Text = "Make & Model is required";
                lblMakeModelError.Visible = true;
                isValid = false;
            }

            if (string.IsNullOrEmpty(year))
            {
                lblYearError.Text = "Year is required";
                lblYearError.Visible = true;
                isValid = false;
            }
            else
            {
                int yearInt;
                if (!int.TryParse(year, out yearInt) || yearInt < 2000 || yearInt > DateTime.Now.Year + 1)
                {
                    lblYearError.Text = "Please enter a valid year (2000 - present)";
                    lblYearError.Visible = true;
                    isValid = false;
                }
            }

            if (string.IsNullOrEmpty(licensePlate))
            {
                lblLicensePlateError.Text = "License plate number is required";
                lblLicensePlateError.Visible = true;
                isValid = false;
            }

            if (string.IsNullOrEmpty(vehicleColor))
            {
                lblVehicleColorError.Text = "Vehicle color is required";
                lblVehicleColorError.Visible = true;
                isValid = false;
            }

            if (string.IsNullOrEmpty(orcr))
            {
                lblORCRError.Text = "OR/CR number is required";
                lblORCRError.Visible = true;
                isValid = false;
            }

            if (string.IsNullOrEmpty(insurancePolicy))
            {
                lblInsurancePolicyError.Text = "Insurance policy number is required";
                lblInsurancePolicyError.Visible = true;
                isValid = false;
            }

            if (string.IsNullOrEmpty(insuranceExpiry))
            {
                lblInsuranceExpiryError.Text = "Insurance expiry date is required";
                lblInsuranceExpiryError.Visible = true;
                isValid = false;
            }
            else
            {
                DateTime expiryDate;
                if (DateTime.TryParse(insuranceExpiry, out expiryDate))
                {
                    if (expiryDate < DateTime.Now)
                    {
                        lblInsuranceExpiryError.Text = "Insurance must be valid (not expired)";
                        lblInsuranceExpiryError.Visible = true;
                        isValid = false;
                    }
                }
            }

            if (!fuDriverLicense.HasFile)
            {
                lblDriverLicenseFileError.Text = "Driver's License file is required";
                lblDriverLicenseFileError.Visible = true;
                isValid = false;
            }

            if (!fuVehicleRegistration.HasFile)
            {
                lblVehicleRegistrationError.Text = "Vehicle Registration file is required";
                lblVehicleRegistrationError.Visible = true;
                isValid = false;
            }

            if (!fuInsurance.HasFile)
            {
                lblInsuranceFileError.Text = "Insurance Certificate file is required";
                lblInsuranceFileError.Visible = true;
                isValid = false;
            }

            if (!fuNBIClearance.HasFile)
            {
                lblNBIClearanceFileError.Text = "NBI Clearance file is required";
                lblNBIClearanceFileError.Visible = true;
                isValid = false;
            }

            if (isValid)
            {
                string[] allowedExtensions = { ".jpg", ".jpeg", ".png", ".pdf", ".doc", ".docx" };
                long maxFileSize = 5 * 1024 * 1024;

                if (!ValidateFileUpload(fuDriverLicense, allowedExtensions, maxFileSize))
                {
                    lblDriverLicenseFileError.Text = "Invalid file. Allowed: JPG, PNG, PDF, DOC (Max 5MB)";
                    lblDriverLicenseFileError.Visible = true;
                    isValid = false;
                }

                if (!ValidateFileUpload(fuVehicleRegistration, allowedExtensions, maxFileSize))
                {
                    lblVehicleRegistrationError.Text = "Invalid file. Allowed: JPG, PNG, PDF, DOC (Max 5MB)";
                    lblVehicleRegistrationError.Visible = true;
                    isValid = false;
                }

                if (!ValidateFileUpload(fuInsurance, allowedExtensions, maxFileSize))
                {
                    lblInsuranceFileError.Text = "Invalid file. Allowed: JPG, PNG, PDF, DOC (Max 5MB)";
                    lblInsuranceFileError.Visible = true;
                    isValid = false;
                }

                if (!ValidateFileUpload(fuNBIClearance, allowedExtensions, maxFileSize))
                {
                    lblNBIClearanceFileError.Text = "Invalid file. Allowed: JPG, PNG, PDF, DOC (Max 5MB)";
                    lblNBIClearanceFileError.Visible = true;
                    isValid = false;
                }
            }

            if (!isValid)
            {
                lblRiderGeneralError.Text = "Please fill all required fields correctly";
                lblRiderGeneralError.Visible = true;
                RegisterClientScriptForRiderValidation();
                return;
            }

            Dictionary<string, string> uploadedFiles = new Dictionary<string, string>();
            try
            {
                uploadedFiles["DriverLicense"] = SaveUploadedFile(fuDriverLicense, username, "DriverLicense");
                uploadedFiles["VehicleRegistration"] = SaveUploadedFile(fuVehicleRegistration, username, "VehicleRegistration");
                uploadedFiles["Insurance"] = SaveUploadedFile(fuInsurance, username, "Insurance");
                uploadedFiles["NBIClearance"] = SaveUploadedFile(fuNBIClearance, username, "NBIClearance");
            }
            catch (Exception ex)
            {
                lblRiderGeneralError.Text = "Error uploading files: " + ex.Message;
                lblRiderGeneralError.Visible = true;
                RegisterClientScriptForRiderValidation();
                return;
            }

            bool registrationSuccess = RegisterRiderInDatabase(
                fullName, username, email, mobile, driverLicense, nbiClearance,
                password, gender, vehicleType, makeModel, year, licensePlate,
                vehicleColor, orcr, insurancePolicy, insuranceExpiry, uploadedFiles
            );

            if (registrationSuccess)
            {
                lblRiderSuccess.Text = "Rider application submitted successfully! We will review your documents and contact you soon.";
                lblRiderSuccess.Visible = true;
                RegisterClientScriptForRiderSuccess();
                ClearRiderFormFields();
            }
            else
            {
                lblRiderGeneralError.Text = "Registration failed. Username or email might already exist.";
                lblRiderGeneralError.Visible = true;
                RegisterClientScriptForRiderError();

                foreach (var filePath in uploadedFiles.Values)
                {
                    if (File.Exists(filePath))
                    {
                        try { File.Delete(filePath); } catch { }
                    }
                }
            }
        }

        private void RegisterClientScriptForRiderValidation()
        {
            string script = @"
                <script type='text/javascript'>
                    document.getElementById('riderValidationSummary').classList.remove('hidden');
                    
                    let errorMessages = [];
                    const errorLabels = document.querySelectorAll('#riderRegisterCard .field-error, #riderRegisterCard .gender-error');
                    
                    errorLabels.forEach(label => {
                        if (label.textContent.trim() !== '' && label.style.display !== 'none') {
                            errorMessages.push(label.textContent);
                        }
                    });
                    
                    const errorList = document.getElementById('riderErrorList');
                    errorList.innerHTML = '';
                    errorMessages.forEach(msg => {
                        const li = document.createElement('li');
                        li.textContent = msg;
                        errorList.appendChild(li);
                    });
                    
                    document.getElementById('riderRegisterCard').scrollTop = 0;
                    
                    document.querySelectorAll('#riderRegisterCard input, #riderRegisterCard select, #riderRegisterCard .file-upload-input').forEach(input => {
                        const inputId = input.id;
                        const errorLabel = document.querySelector(`[id$='${inputId}Error']`);
                        if (errorLabel && errorLabel.textContent.trim() !== '' && errorLabel.style.display !== 'none') {
                            input.classList.add('input-error');
                        }
                    });
                </script>
            ";
            ClientScript.RegisterStartupScript(this.GetType(), "ShowRiderValidation", script);
        }

        private void RegisterClientScriptForRiderSuccess()
        {
            string script = @"
                <script type='text/javascript'>
                    document.getElementById('riderValidationSummary').classList.add('hidden');
                    document.getElementById('riderSuccessBox').classList.remove('hidden');
                    document.querySelectorAll('.input-error').forEach(el => {
                        el.classList.remove('input-error');
                    });
                    document.getElementById('riderSuccessBox').scrollIntoView({ behavior: 'smooth', block: 'start' });
                </script>
            ";
            ClientScript.RegisterStartupScript(this.GetType(), "ShowRiderSuccess", script);
        }

        private void RegisterClientScriptForRiderError()
        {
            string script = @"
                <script type='text/javascript'>
                    document.getElementById('riderValidationSummary').classList.remove('hidden');
                    const errorList = document.getElementById('riderErrorList');
                    errorList.innerHTML = '<li>Registration failed. Username or email might already exist.</li>';
                    document.getElementById('riderRegisterCard').scrollTop = 0;
                </script>
            ";
            ClientScript.RegisterStartupScript(this.GetType(), "ShowRiderError", script);
        }

        private bool ValidateFileUpload(FileUpload fileUpload, string[] allowedExtensions, long maxSize)
        {
            if (!fileUpload.HasFile) return false;

            string fileExtension = Path.GetExtension(fileUpload.FileName).ToLower();
            if (!allowedExtensions.Contains(fileExtension)) return false;

            if (fileUpload.FileContent.Length > maxSize) return false;

            return true;
        }

        private string SaveUploadedFile(FileUpload fileUpload, string username, string documentType)
        {
            if (!fileUpload.HasFile) return null;

            string uploadsFolder = Server.MapPath("~/Uploads/RiderDocuments/" + username);
            if (!Directory.Exists(uploadsFolder))
            {
                Directory.CreateDirectory(uploadsFolder);
            }

            string fileExtension = Path.GetExtension(fileUpload.FileName);
            string fileName = $"{documentType}_{DateTime.Now:yyyyMMddHHmmss}{fileExtension}";
            string filePath = Path.Combine(uploadsFolder, fileName);

            fileUpload.SaveAs(filePath);

            return filePath;
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

        private void ClearRiderMessages()
        {
            lblRiderGeneralError.Visible = false;
            lblRiderGeneralError.Text = "";

            lblRiderFullNameError.Visible = false;
            lblRiderFullNameError.Text = "";

            lblRiderUsernameError.Visible = false;
            lblRiderUsernameError.Text = "";

            lblRiderEmailError.Visible = false;
            lblRiderEmailError.Text = "";

            lblRiderMobileError.Visible = false;
            lblRiderMobileError.Text = "";

            lblDriverLicenseError.Visible = false;
            lblDriverLicenseError.Text = "";

            lblNBIClearanceError.Visible = false;
            lblNBIClearanceError.Text = "";

            lblRiderPasswordError.Visible = false;
            lblRiderPasswordError.Text = "";

            lblRiderConfirmPasswordError.Visible = false;
            lblRiderConfirmPasswordError.Text = "";

            lblRiderGenderError.Visible = false;
            lblRiderGenderError.Text = "";

            lblVehicleTypeError.Visible = false;
            lblVehicleTypeError.Text = "";

            lblMakeModelError.Visible = false;
            lblMakeModelError.Text = "";

            lblYearError.Visible = false;
            lblYearError.Text = "";

            lblLicensePlateError.Visible = false;
            lblLicensePlateError.Text = "";

            lblVehicleColorError.Visible = false;
            lblVehicleColorError.Text = "";

            lblORCRError.Visible = false;
            lblORCRError.Text = "";

            lblInsurancePolicyError.Visible = false;
            lblInsurancePolicyError.Text = "";

            lblInsuranceExpiryError.Visible = false;
            lblInsuranceExpiryError.Text = "";

            lblDriverLicenseFileError.Visible = false;
            lblDriverLicenseFileError.Text = "";

            lblVehicleRegistrationError.Visible = false;
            lblVehicleRegistrationError.Text = "";

            lblInsuranceFileError.Visible = false;
            lblInsuranceFileError.Text = "";

            lblNBIClearanceFileError.Visible = false;
            lblNBIClearanceFileError.Text = "";

            lblRiderSuccess.Visible = false;
            lblRiderSuccess.Text = "";
        }

        private bool RegisterCustomerInDatabase(string name, string user, string mail, string phone, string pass, string gen, string userType)
        {
            try
            {
                System.Diagnostics.Debug.WriteLine($"Customer Registration: {name}, {user}, {mail}, UserType: {userType}");
                return true;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Customer registration error: {ex.Message}");
                return false;
            }
        }

        private bool RegisterRiderInDatabase(
            string name, string user, string mail, string phone,
            string driverLicense, string nbiClearance, string pass, string gen,
            string vehicleType, string makeModel, string year, string licensePlate,
            string vehicleColor, string orcr, string insurancePolicy, string insuranceExpiry,
            Dictionary<string, string> uploadedFiles)
        {
            try
            {
                System.Diagnostics.Debug.WriteLine($"Rider Registration Attempt:");
                System.Diagnostics.Debug.WriteLine($"Name: {name}, Username: {user}");
                System.Diagnostics.Debug.WriteLine($"Email: {mail}, Phone: {phone}");
                System.Diagnostics.Debug.WriteLine($"Vehicle: {makeModel} ({year})");
                System.Diagnostics.Debug.WriteLine($"License Plate: {licensePlate}");
                System.Diagnostics.Debug.WriteLine($"Documents uploaded: {uploadedFiles.Count}");

                return true;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Rider registration error: {ex.Message}");
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

        private void ClearRiderFormFields()
        {
            txtRiderFullName.Text = "";
            txtRiderUsername.Text = "";
            txtRiderEmail.Text = "";
            txtRiderMobile.Text = "";
            txtDriverLicense.Text = "";
            txtNBIClearance.Text = "";
            txtRiderPassword.Text = "";
            txtRiderConfirmPassword.Text = "";
            rblRiderGender.ClearSelection();

            ddlVehicleType.SelectedIndex = 0;
            txtMakeModel.Text = "";
            txtYear.Text = "";
            txtLicensePlate.Text = "";
            txtVehicleColor.Text = "";
            txtORCR.Text = "";

            txtInsurancePolicy.Text = "";
            txtInsuranceExpiry.Text = "";

            fuDriverLicense.Attributes.Clear();
            fuVehicleRegistration.Attributes.Clear();
            fuInsurance.Attributes.Clear();
            fuNBIClearance.Attributes.Clear();
        }
    }
}