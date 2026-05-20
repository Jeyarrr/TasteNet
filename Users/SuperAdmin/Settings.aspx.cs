using System;
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

        // ─────────────────────────────────────────────
        //  PAGE LOAD
        // ─────────────────────────────────────────────
        protected void Page_Load(object sender, EventArgs e)
        {
            currentUser = User.Identity.IsAuthenticated ? User.Identity.Name : "System";

            if (!IsPostBack)
            {
                LoadPaymentMethodsGrid();
            }
        }

        // ─────────────────────────────────────────────
        //  HELPER: icon per method name (used in .aspx)
        // ─────────────────────────────────────────────
        protected string GetMethodIcon(string methodName)
        {
            switch (methodName?.ToLower())
            {
                case "cash on delivery": return "fas fa-hand-holding-usd";
                case "gcash": return "fas fa-wallet";
                case "paymaya":
                case "maya": return "fas fa-mobile-alt";
                case "bank transfer": return "fas fa-university";
                default: return "fas fa-credit-card";
            }
        }

        // ─────────────────────────────────────────────
        //  LOAD: bind all columns to the Repeater
        // ─────────────────────────────────────────────
        private void LoadPaymentMethodsGrid()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    string query = @"
                        SELECT  PaymentMethodId,
                                MethodName,
                                IsEnabled,
                                DisplayOrder,
                                AccountDetails,
                                Instructions,
                                CreatedDate,
                                ModifiedDate,
                                Status,
                                QRPhoto
                        FROM    PaymentMethods
                        ORDER BY DisplayOrder ASC, PaymentMethodId ASC";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        rptPaymentMethods.DataSource = dt;
                        rptPaymentMethods.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                rptPaymentMethods.DataSource = GetFallbackPaymentData();
                rptPaymentMethods.DataBind();
                System.Diagnostics.Debug.WriteLine("LoadPaymentMethodsGrid error: " + ex.Message);
            }
        }

        private DataTable GetFallbackPaymentData()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("PaymentMethodId", typeof(int));
            dt.Columns.Add("MethodName", typeof(string));
            dt.Columns.Add("IsEnabled", typeof(bool));
            dt.Columns.Add("DisplayOrder", typeof(int));
            dt.Columns.Add("AccountDetails", typeof(string));
            dt.Columns.Add("Instructions", typeof(string));
            dt.Columns.Add("CreatedDate", typeof(DateTime));
            dt.Columns.Add("ModifiedDate", typeof(DateTime));
            dt.Columns.Add("Status", typeof(string));
            dt.Columns.Add("QRPhoto", typeof(string));

            dt.Rows.Add(1, "Cash on Delivery", true, 1, "", "Pay upon delivery.", DateTime.Now, DateTime.Now, "Active", "");
            dt.Rows.Add(2, "GCash", true, 2, "09171234567", "Send screenshot after paying.", DateTime.Now, DateTime.Now, "Active", "");
            dt.Rows.Add(3, "PayMaya", true, 3, "09181234567", "Send screenshot after paying.", DateTime.Now, DateTime.Now, "Active", "");
            dt.Rows.Add(4, "Bank Transfer", false, 4, "BDO – Acct 123456", "Include order # in remarks.", DateTime.Now, DateTime.Now, "Inactive", "");
            return dt;
        }

        // ─────────────────────────────────────────────
        //  REPEATER: command handler
        // ─────────────────────────────────────────────
        protected void rptPaymentMethods_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int id = Convert.ToInt32(e.CommandArgument);

            // ── Toggle Active/Inactive ──────────────────
            if (e.CommandName == "ToggleStatus")
            {
                try
                {
                    using (SqlConnection conn = new SqlConnection(connectionString))
                    {
                        conn.Open();
                        string query = @"
                            UPDATE PaymentMethods
                            SET    IsEnabled    = CASE WHEN IsEnabled = 1 THEN 0 ELSE 1 END,
                                   Status       = CASE WHEN IsEnabled = 1 THEN 'Inactive' ELSE 'Active' END,
                                   ModifiedDate = GETDATE()
                            WHERE  PaymentMethodId = @Id";
                        using (SqlCommand cmd = new SqlCommand(query, conn))
                        {
                            cmd.Parameters.AddWithValue("@Id", id);
                            cmd.ExecuteNonQuery();
                        }
                    }
                    LoadPaymentMethodsGrid();
                }
                catch (Exception ex)
                {
                    ShowMessage("Error toggling status: " + ex.Message, false);
                }
                return;
            }

            // ── Delete ─────────────────────────────────
            if (e.CommandName == "DeleteMethod")
            {
                try
                {
                    using (SqlConnection conn = new SqlConnection(connectionString))
                    {
                        conn.Open();
                        using (SqlCommand cmd = new SqlCommand(
                            "DELETE FROM PaymentMethods WHERE PaymentMethodId = @Id", conn))
                        {
                            cmd.Parameters.AddWithValue("@Id", id);
                            cmd.ExecuteNonQuery();
                        }
                    }
                    LoadPaymentMethodsGrid();
                    ShowMessage("Payment method deleted successfully.", true);
                }
                catch (Exception ex)
                {
                    ShowMessage("Error deleting payment method: " + ex.Message, false);
                }
                return;
            }

            // ── Edit — load into modal ─────────────────
            if (e.CommandName != "EditMethod") return;

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    string query = @"
                        SELECT  PaymentMethodId, MethodName, IsEnabled,
                                DisplayOrder, AccountDetails, Instructions,
                                Status, QRPhoto
                        FROM    PaymentMethods
                        WHERE   PaymentMethodId = @Id";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Id", id);
                        using (SqlDataReader r = cmd.ExecuteReader())
                        {
                            if (r.Read())
                            {
                                hfEditId.Value = r["PaymentMethodId"].ToString();
                                hfEditMethod.Value = r["MethodName"].ToString();

                                txtEditMethodName.Text = r["MethodName"].ToString();
                                chkEditEnabled.Checked = Convert.ToBoolean(r["IsEnabled"]);
                                txtEditDisplayOrder.Text = r["DisplayOrder"].ToString();
                                txtEditAccountDetails.Text = r["AccountDetails"] != DBNull.Value ? r["AccountDetails"].ToString() : "";
                                txtEditInstructions.Text = r["Instructions"] != DBNull.Value ? r["Instructions"].ToString() : "";

                                string status = r["Status"] != DBNull.Value ? r["Status"].ToString() : "Active";
                                if (ddlEditStatus.Items.FindByValue(status) != null)
                                    ddlEditStatus.SelectedValue = status;

                                string qrPath = r["QRPhoto"] != DBNull.Value ? r["QRPhoto"].ToString() : "";
                                qrPreviewWrap.InnerHtml = !string.IsNullOrEmpty(qrPath)
                                    ? $"<p style='font-size:12px;color:var(--muted-text);margin-bottom:6px;'>Current QR:</p><img src='{qrPath}' />"
                                    : "";
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                hfEditId.Value = id.ToString();
                System.Diagnostics.Debug.WriteLine("EditMethod load error: " + ex.Message);
            }

            ScriptManager.RegisterStartupScript(this, GetType(), "OpenModal", "openPmModal();", true);
        }

        // ─────────────────────────────────────────────
        //  SAVE EDITED PAYMENT METHOD (modal Save btn)
        // ─────────────────────────────────────────────
        protected void btnSaveEditMethod_Click(object sender, EventArgs e)
        {
            int id = Convert.ToInt32(hfEditId.Value);

            try
            {
                string qrPhotoPath = null;

                if (fileEditQR.HasFile)
                {
                    string ext = Path.GetExtension(fileEditQR.FileName).ToLower();
                    if (ext != ".png" && ext != ".jpg" && ext != ".jpeg" && ext != ".webp")
                    {
                        ShowMessage("QR upload failed: only PNG, JPG, WEBP are allowed.", false);
                        ScriptManager.RegisterStartupScript(this, GetType(), "OpenModal", "openPmModal();", true);
                        return;
                    }
                    if (fileEditQR.PostedFile.ContentLength > 2 * 1024 * 1024)
                    {
                        ShowMessage("QR upload failed: file exceeds 2 MB limit.", false);
                        ScriptManager.RegisterStartupScript(this, GetType(), "OpenModal", "openPmModal();", true);
                        return;
                    }

                    string folder = Server.MapPath("~/Assets/QR/");
                    if (!Directory.Exists(folder)) Directory.CreateDirectory(folder);
                    string fileName = $"qr_{id}_{DateTime.Now:yyyyMMddHHmmss}{ext}";
                    fileEditQR.SaveAs(Path.Combine(folder, fileName));
                    qrPhotoPath = $"/Assets/QR/{fileName}";
                }

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    string query = qrPhotoPath != null
                        ? @"UPDATE PaymentMethods
                            SET  IsEnabled      = @IsEnabled,
                                 DisplayOrder   = @DisplayOrder,
                                 AccountDetails = @AccountDetails,
                                 Instructions   = @Instructions,
                                 Status         = @Status,
                                 QRPhoto        = @QRPhoto,
                                 ModifiedDate   = GETDATE()
                            WHERE PaymentMethodId = @Id"
                        : @"UPDATE PaymentMethods
                            SET  IsEnabled      = @IsEnabled,
                                 DisplayOrder   = @DisplayOrder,
                                 AccountDetails = @AccountDetails,
                                 Instructions   = @Instructions,
                                 Status         = @Status,
                                 ModifiedDate   = GETDATE()
                            WHERE PaymentMethodId = @Id";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Id", id);
                        cmd.Parameters.AddWithValue("@IsEnabled", chkEditEnabled.Checked);
                        cmd.Parameters.AddWithValue("@DisplayOrder", int.TryParse(txtEditDisplayOrder.Text, out int ord) ? ord : 0);
                        cmd.Parameters.AddWithValue("@AccountDetails", string.IsNullOrWhiteSpace(txtEditAccountDetails.Text) ? (object)DBNull.Value : txtEditAccountDetails.Text.Trim());
                        cmd.Parameters.AddWithValue("@Instructions", string.IsNullOrWhiteSpace(txtEditInstructions.Text) ? (object)DBNull.Value : txtEditInstructions.Text.Trim());
                        cmd.Parameters.AddWithValue("@Status", ddlEditStatus.SelectedValue);
                        if (qrPhotoPath != null)
                            cmd.Parameters.AddWithValue("@QRPhoto", qrPhotoPath);

                        cmd.ExecuteNonQuery();
                    }
                }

                LoadPaymentMethodsGrid();
                ShowMessage($"Payment method '{txtEditMethodName.Text}' updated successfully!", true);
            }
            catch (Exception ex)
            {
                ShowMessage("Error saving payment method: " + ex.Message, false);
                ScriptManager.RegisterStartupScript(this, GetType(), "OpenModal", "openPmModal();", true);
            }
        }

        // ─────────────────────────────────────────────
        //  REFRESH button
        // ─────────────────────────────────────────────
        protected void btnSavePayment_Click(object sender, EventArgs e)
        {
            try
            {
                LoadPaymentMethodsGrid();
                ShowMessage("Payment methods reloaded.", true);
            }
            catch (Exception ex)
            {
                ShowMessage("Error: " + ex.Message, false);
            }
        }

        // ─────────────────────────────────────────────
        //  UI MESSAGE
        // ─────────────────────────────────────────────
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

            string script = @"setTimeout(function(){
                var m = document.querySelector('.message-container');
                if(m){ m.style.opacity='0'; setTimeout(function(){ m.style.display='none'; },300); }
            }, 5000);";
            ClientScript.RegisterStartupScript(GetType(), "HideMessage", script, true);
        }
    }
}
