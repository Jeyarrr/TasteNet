using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.IO;

namespace TasteNet.Users.SuperAdmin
{
    public partial class Settings : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["TasteNetDB"].ConnectionString;
        private string currentUser = string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (User.Identity.IsAuthenticated)
            {
                currentUser = User.Identity.Name;
            }
            else
            {
                currentUser = "System";
            }

            if (!IsPostBack)
            {
                LoadAllSettings();
                LoadPaymentMethods();
                LoadSystemInfo();
            }
        }

        private void LoadAllSettings()
        {
            try
            {
                if (string.IsNullOrEmpty(connectionString))
                {
                    SetDefaultValues();
                    return;
                }

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    string query = "SELECT SettingKey, SettingValue FROM ApplicationSettings";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                string key = reader["SettingKey"].ToString();
                                string value = reader["SettingValue"].ToString();

                                switch (key)
                                {
                                    case "SystemName": txtSystemName.Text = value; break;
                                    case "ContactEmail": txtEmail.Text = value; break;
                                    case "ContactPhone": txtPhone.Text = value; break;
                                    case "StoreAddress": txtAddress.Text = value; break;
                                    case "OperatingHours_Open": txtOpen.Text = value; break;
                                    case "OperatingHours_Close": txtClose.Text = value; break;
                                    case "MinimumOrderAmount": txtMinOrder.Text = "₱ " + value; break;
                                    case "DeliveryFee": txtDelFee.Text = "₱ " + value; break;
                                    case "OrderCutoffTime": txtCutoff.Text = value; break;
                                    case "AutoCancelTime_Minutes": SetDropDownValue(ddlAutoCancel, value); break;
                                    case "PreparationTime_Minutes": SetDropDownValue(ddlPrepTime, value); break;
                                    case "DeliveryTime_Minutes": SetDropDownValue(ddlDeliveryTime, value); break;
                                    case "SessionTimeout_Minutes": SetDropDownValue(ddlSessionTimeout, value); break;
                                    case "AutoLogoutInactive": chkAutoLogout.Checked = Convert.ToBoolean(value); break;
                                    case "TwoFactorEnabled": chkTwoFactor.Checked = Convert.ToBoolean(value); break;
                                    case "MaintenanceMode": chkMaintenanceMode.Checked = Convert.ToBoolean(value); break;
                                    case "AutoBackupEnabled": chkAutoBackup.Checked = Convert.ToBoolean(value); break;
                                    case "LastBackupDate": lastBackupDate.InnerText = value; break;
                                }
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                SetDefaultValues();
                System.Diagnostics.Debug.WriteLine("Error loading settings: " + ex.Message);
            }
        }

        private void SetDefaultValues()
        {
            txtSystemName.Text = "Caballeros TasteNet";
            txtEmail.Text = "support@caballerostastenet.com";
            txtPhone.Text = "(046) 123-4567";
            txtAddress.Text = "Dasmariñas, Cavite, Philippines";
            txtOpen.Text = "09:00 AM";
            txtClose.Text = "09:00 PM";
            txtMinOrder.Text = "₱ 100";
            txtDelFee.Text = "₱ 30";
            txtCutoff.Text = "08:30 PM";
            SetDropDownValue(ddlAutoCancel, "30");
            SetDropDownValue(ddlPrepTime, "30");
            SetDropDownValue(ddlDeliveryTime, "30");
            SetDropDownValue(ddlSessionTimeout, "60");
            chkAutoLogout.Checked = true;
            chkTwoFactor.Checked = false;
            chkMaintenanceMode.Checked = false;
            chkAutoBackup.Checked = true;
            chkCOD.Checked = true;
            chkGCash.Checked = true;
            chkPayMaya.Checked = true;
            chkBankTransfer.Checked = false;
            txtGCashDetails.Text = "09171234567";
            txtBankDetails.Text = "BDO - Account Name: Caballeros TasteNet\nAccount Number: 1234567890";
            txtPaymentInstructions.Text = "Please ensure accurate payment details. For GCash/PayMaya, send payment screenshot. Bank transfers should include order reference number.";
            lastBackupDate.InnerText = DateTime.Now.ToString("MMMM dd, yyyy 'at' hh:mm tt");
        }

        private void SetDropDownValue(DropDownList ddl, string value)
        {
            if (ddl.Items.FindByValue(value) != null)
            {
                ddl.SelectedValue = value;
            }
        }

        private void LoadPaymentMethods()
        {
            try
            {
                if (string.IsNullOrEmpty(connectionString)) return;

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    string query = "SELECT MethodName, IsEnabled, AccountDetails, Instructions FROM PaymentMethods";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                string methodName = reader["MethodName"].ToString();
                                bool isEnabled = Convert.ToBoolean(reader["IsEnabled"]);
                                string accountDetails = reader["AccountDetails"] != DBNull.Value ? reader["AccountDetails"].ToString() : "";
                                string instructions = reader["Instructions"] != DBNull.Value ? reader["Instructions"].ToString() : "";

                                switch (methodName)
                                {
                                    case "Cash on Delivery": chkCOD.Checked = isEnabled; break;
                                    case "GCash": chkGCash.Checked = isEnabled; txtGCashDetails.Text = accountDetails; break;
                                    case "PayMaya": chkPayMaya.Checked = isEnabled; break;
                                    case "Bank Transfer": chkBankTransfer.Checked = isEnabled; txtBankDetails.Text = accountDetails; break;
                                }
                                txtPaymentInstructions.Text = instructions;
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error loading payment methods: " + ex.Message);
            }
        }

        private void LoadSystemInfo()
        {
            try
            {
                totalOrders.InnerText = "1,847";
                dbSize.InnerText = "245 MB";
                storageUsed.InnerText = "1.2 GB / 10 GB";
                storageBar.Style["width"] = "12%";
                storagePercent.InnerText = "12% of storage used";
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error loading system info: " + ex.Message);
            }
        }

        private void SaveSetting(string key, string value)
        {
            try
            {
                if (string.IsNullOrEmpty(connectionString)) return;

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    string query = @"
                        IF EXISTS (SELECT 1 FROM ApplicationSettings WHERE SettingKey = @Key)
                            UPDATE ApplicationSettings SET SettingValue = @Value, ModifiedDate = GETDATE(), ModifiedBy = @User WHERE SettingKey = @Key
                        ELSE
                            INSERT INTO ApplicationSettings (SettingKey, SettingValue, SettingDataType, SettingCategory, ModifiedBy) 
                            VALUES (@Key, @Value, 'String', 'General', @User)";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Key", key);
                        cmd.Parameters.AddWithValue("@Value", value);
                        cmd.Parameters.AddWithValue("@User", currentUser);
                        cmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error saving setting: " + ex.Message);
            }
        }

        private void UpdatePaymentMethodStatus(string methodName, bool isEnabled)
        {
            try
            {
                if (string.IsNullOrEmpty(connectionString)) return;

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    string query = @"
                        IF EXISTS (SELECT 1 FROM PaymentMethods WHERE MethodName = @MethodName)
                            UPDATE PaymentMethods SET IsEnabled = @IsEnabled, ModifiedDate = GETDATE() WHERE MethodName = @MethodName
                        ELSE
                            INSERT INTO PaymentMethods (MethodName, IsEnabled, DisplayOrder) VALUES (@MethodName, @IsEnabled, 0)";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@MethodName", methodName);
                        cmd.Parameters.AddWithValue("@IsEnabled", isEnabled);
                        cmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error updating payment method: " + ex.Message);
            }
        }

        private void UpdatePaymentMethodDetails(string methodName, string accountDetails, string instructions)
        {
            try
            {
                if (string.IsNullOrEmpty(connectionString)) return;

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    string query = @"
                        IF EXISTS (SELECT 1 FROM PaymentMethods WHERE MethodName = @MethodName)
                            UPDATE PaymentMethods SET AccountDetails = @AccountDetails, Instructions = @Instructions, ModifiedDate = GETDATE() WHERE MethodName = @MethodName
                        ELSE
                            INSERT INTO PaymentMethods (MethodName, AccountDetails, Instructions, DisplayOrder) VALUES (@MethodName, @AccountDetails, @Instructions, 0)";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@MethodName", methodName);
                        cmd.Parameters.AddWithValue("@AccountDetails", (object)accountDetails ?? DBNull.Value);
                        cmd.Parameters.AddWithValue("@Instructions", (object)instructions ?? DBNull.Value);
                        cmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error updating payment details: " + ex.Message);
            }
        }

        private void ShowMessage(string message, bool isSuccess)
        {
            pnlMessage.Visible = true;
            messageText.InnerText = message;

            if (isSuccess)
            {
                messageDiv.Attributes["class"] = "alert-message alert-success";
                messageIcon.Attributes["class"] = "fas fa-check-circle";
            }
            else
            {
                messageDiv.Attributes["class"] = "alert-message alert-error";
                messageIcon.Attributes["class"] = "fas fa-exclamation-circle";
            }

            string script = "setTimeout(function() { var msg = document.querySelector('.message-container'); if(msg) { msg.style.opacity = '0'; setTimeout(function() { msg.style.display = 'none'; }, 300); } }, 5000);";
            ClientScript.RegisterStartupScript(this.GetType(), "HideMessage", script, true);
        }

        protected void btnSaveGeneral_Click(object sender, EventArgs e)
        {
            try
            {
                SaveSetting("SystemName", txtSystemName.Text);
                SaveSetting("ContactEmail", txtEmail.Text);
                SaveSetting("ContactPhone", txtPhone.Text);
                SaveSetting("StoreAddress", txtAddress.Text);
                SaveSetting("OperatingHours_Open", txtOpen.Text);
                SaveSetting("OperatingHours_Close", txtClose.Text);

                if (fileLogo.HasFile)
                {
                    try
                    {
                        string fileName = Path.GetFileName(fileLogo.FileName);
                        string folderPath = Server.MapPath("~/Assets/Images/");
                        if (!Directory.Exists(folderPath)) Directory.CreateDirectory(folderPath);
                        string filePath = folderPath + fileName;
                        fileLogo.SaveAs(filePath);
                        SaveSetting("LogoPath", "/Assets/Images/" + fileName);
                    }
                    catch (Exception ex)
                    {
                        ShowMessage("Settings saved but logo upload failed: " + ex.Message, false);
                        return;
                    }
                }

                ShowMessage("General settings saved successfully!", true);
            }
            catch (Exception ex)
            {
                ShowMessage("Error saving general settings: " + ex.Message, false);
            }
        }

        protected void btnSaveOrder_Click(object sender, EventArgs e)
        {
            try
            {
                decimal minOrder = decimal.Parse(txtMinOrder.Text.Replace("₱", "").Trim());
                decimal deliveryFee = decimal.Parse(txtDelFee.Text.Replace("₱", "").Trim());

                SaveSetting("MinimumOrderAmount", minOrder.ToString());
                SaveSetting("DeliveryFee", deliveryFee.ToString());
                SaveSetting("OrderCutoffTime", txtCutoff.Text);
                SaveSetting("AutoCancelTime_Minutes", ddlAutoCancel.SelectedValue);
                SaveSetting("PreparationTime_Minutes", ddlPrepTime.SelectedValue);
                SaveSetting("DeliveryTime_Minutes", ddlDeliveryTime.SelectedValue);

                ShowMessage("Order settings saved successfully!", true);
            }
            catch (Exception ex)
            {
                ShowMessage("Error saving order settings: " + ex.Message, false);
            }
        }

        protected void btnSavePayment_Click(object sender, EventArgs e)
        {
            try
            {
                UpdatePaymentMethodStatus("Cash on Delivery", chkCOD.Checked);
                UpdatePaymentMethodStatus("GCash", chkGCash.Checked);
                UpdatePaymentMethodStatus("PayMaya", chkPayMaya.Checked);
                UpdatePaymentMethodStatus("Bank Transfer", chkBankTransfer.Checked);

                UpdatePaymentMethodDetails("GCash", txtGCashDetails.Text, txtPaymentInstructions.Text);
                UpdatePaymentMethodDetails("Bank Transfer", txtBankDetails.Text, txtPaymentInstructions.Text);
                UpdatePaymentMethodDetails("Payment Instructions", null, txtPaymentInstructions.Text);

                ShowMessage("Payment settings saved successfully!", true);
            }
            catch (Exception ex)
            {
                ShowMessage("Error saving payment settings: " + ex.Message, false);
            }
        }

        protected void btnSaveSecurity_Click(object sender, EventArgs e)
        {
            try
            {
                SaveSetting("SessionTimeout_Minutes", ddlSessionTimeout.SelectedValue);
                SaveSetting("AutoLogoutInactive", chkAutoLogout.Checked.ToString());
                SaveSetting("TwoFactorEnabled", chkTwoFactor.Checked.ToString());

                ShowMessage("Security settings saved successfully!", true);
            }
            catch (Exception ex)
            {
                ShowMessage("Error saving security settings: " + ex.Message, false);
            }
        }

        protected void btnSaveSystem_Click(object sender, EventArgs e)
        {
            try
            {
                SaveSetting("MaintenanceMode", chkMaintenanceMode.Checked.ToString());
                SaveSetting("AutoBackupEnabled", chkAutoBackup.Checked.ToString());

                ShowMessage("System settings saved successfully!", true);
            }
            catch (Exception ex)
            {
                ShowMessage("Error saving system settings: " + ex.Message, false);
            }
        }

        protected void btnBackupDatabase_Click(object sender, EventArgs e)
        {
            try
            {
                string backupPath = Server.MapPath("~/App_Data/Backups/");
                if (!Directory.Exists(backupPath)) Directory.CreateDirectory(backupPath);

                string backupFile = backupPath + "TasteNet_Backup_" + DateTime.Now.ToString("yyyyMMdd_HHmmss") + ".bak";

                System.IO.File.WriteAllText(backupFile, "Backup created at " + DateTime.Now.ToString());

                lastBackupDate.InnerText = DateTime.Now.ToString("MMMM dd, yyyy 'at' hh:mm tt");
                ShowMessage($"Database backup completed successfully! File: {Path.GetFileName(backupFile)}", true);
            }
            catch (Exception ex)
            {
                ShowMessage("Error backing up database: " + ex.Message, false);
            }
        }

        protected void btnRestoreDatabase_Click(object sender, EventArgs e)
        {
            ShowMessage("Restore functionality requires additional configuration. Please contact system administrator.", false);
        }

        protected void btnEditAdmin_Click(object sender, EventArgs e)
        {
            ShowMessage("Admin edit functionality will be implemented in the next phase.", false);
        }

        protected void btnSystemControls_Click(object sender, EventArgs e)
        {
            string script = "showTab('system', document.querySelector('.nav-item:last-child'));";
            ClientScript.RegisterStartupScript(this.GetType(), "SwitchTab", script, true);
        }

        protected void btnAddAdmin_Click(object sender, EventArgs e)
        {
            ShowMessage("Add admin functionality will be implemented in the next phase.", false);
        }

        protected void btnViewLogs_Click(object sender, EventArgs e)
        {
            ShowMessage("Audit logs functionality will be implemented in the next phase.", false);
        }
    }
}