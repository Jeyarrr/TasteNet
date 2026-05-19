using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TasteNet.Users.Rider
{
    // Helper class for documents
    public class DocumentItem
    {
        public string DocumentName { get; set; }
        public string DocumentColumn { get; set; }
        public string Status { get; set; }
        public string FilePath { get; set; }
    }

    public partial class Profile : System.Web.UI.Page
    {
        private string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["TasteNetDB"].ConnectionString;
        private int currentUserID = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null || Session["UserType"] == null || Session["UserType"].ToString() != "Rider")
            {
                Response.Redirect("~/Login.aspx");
            }

            currentUserID = Convert.ToInt32(Session["UserID"]);

            // Prevent browser from caching this page so approval status is always fresh
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetNoStore();
            Response.Cache.SetExpires(DateTime.UtcNow.AddDays(-1));

            if (!IsPostBack)
            {
                LoadRiderProfile();
                LoadVehicleDetails();
                LoadDocuments();
            }
            else
            {
                // On postback, only reload documents if it was NOT triggered by the
                // Upload button — re-binding the repeater during upload causes event
                // validation to fail because the button tokens are regenerated mid-request.
                // UploadDocument() calls LoadDocuments() itself after a successful save.
                string eventTarget = Request.Form["__EVENTTARGET"] ?? "";
                string eventArg = Request.Form["__EVENTARGUMENT"] ?? "";
                bool isUploadPostback = false;

                // Check if any btnUpload in the repeater triggered this postback
                foreach (RepeaterItem item in rptDocuments.Items)
                {
                    Button btnUpload = (Button)item.FindControl("btnUpload");
                    if (btnUpload != null && Request.Form[btnUpload.UniqueID] != null)
                    {
                        isUploadPostback = true;
                        break;
                    }
                }

                if (!isUploadPostback)
                    LoadDocuments();
            }
        }

        private void LoadRiderProfile()
        {
            string query = @"
                SELECT UserID, Username, FullName, Email, Phone, Gender, Address,
                       ProfilePhoto, DateJoined, RiderStatus, CompletedOrders, Ratings,
                       ISNULL(CONVERT(NVARCHAR, CreatedAt, 101), '') as JoinDate
                FROM Users 
                WHERE UserID = @UserID AND UserType = 'Rider'";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@UserID", currentUserID);
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.HasRows)
                    {
                        DataTable dt = new DataTable();
                        dt.Load(reader);
                        rptPersonalInfoForm.DataSource = dt;
                        rptPersonalInfoForm.DataBind();

                        // Reset reader position for second binding
                        DataTable dt2 = dt.Copy();
                        rptPersonalInfo.DataSource = dt2;
                        rptPersonalInfo.DataBind();
                    }
                    conn.Close();
                }
            }
        }

        private void LoadVehicleDetails()
        {
            string query = @"
                SELECT ISNULL(Vehicle, '') as Vehicle, 
                       ISNULL(VehicleModel, '') as VehicleModel, 
                       ISNULL(VehicleYear, '') as VehicleYear, 
                       ISNULL(LicensePlate, '') as LicensePlate, 
                       ISNULL(VehicleColor, '') as VehicleColor, 
                       ISNULL(ORCRNumber, '') as ORCRNumber, 
                       ISNULL(InsurancePolicy, '') as InsurancePolicy,
                       InsuranceDate
                FROM Users 
                WHERE UserID = @UserID AND UserType = 'Rider'";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@UserID", currentUserID);
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.HasRows)
                    {
                        DataTable dt = new DataTable();
                        dt.Load(reader);
                        rptVehicleDetails.DataSource = dt;
                        rptVehicleDetails.DataBind();
                    }
                    conn.Close();
                }
            }
        }

        private void LoadDocuments()
        {
            string query = @"
                SELECT
                    docs.DocumentName,
                    docs.DocumentColumn,
                    CASE
                        WHEN docs.RawPath IS NULL OR docs.RawPath = '' THEN 'Not Uploaded'
                        ELSE ISNULL(rda.Status, 'Pending Review')
                    END AS Status,
                    ISNULL(docs.RawPath, '') AS FilePath
                FROM (
                    SELECT
                        N'Drivers License'       AS DocumentName,
                        N'DriverLicensePhoto'    AS DocumentColumn,
                        ISNULL(DriverLicensePhoto, '') AS RawPath
                    FROM dbo.Users WHERE UserID = @UserID
                    UNION ALL
                    SELECT
                        N'OR/CR',
                        N'ORCRPhoto',
                        ISNULL(ORCRPhoto, '')
                    FROM dbo.Users WHERE UserID = @UserID
                    UNION ALL
                    SELECT
                        N'Insurance Certificate',
                        N'InsurancePhoto',
                        ISNULL(InsurancePhoto, '')
                    FROM dbo.Users WHERE UserID = @UserID
                    UNION ALL
                    SELECT
                        N'NBI Clearance',
                        N'NBIClearancePhoto',
                        ISNULL(NBIClearancePhoto, '')
                    FROM dbo.Users WHERE UserID = @UserID
                ) AS docs
                LEFT JOIN (
                    SELECT DocColumn, Status,
                           ROW_NUMBER() OVER (PARTITION BY DocColumn ORDER BY UpdatedAt DESC) AS rn
                    FROM dbo.RiderDocApprovals
                    WHERE UserID = @UserID
                ) AS rda ON LTRIM(RTRIM(rda.DocColumn)) = LTRIM(RTRIM(docs.DocumentColumn)) AND rda.rn = 1";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@UserID", currentUserID);
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    DataTable dt = new DataTable();
                    dt.Load(reader);
                    conn.Close();

                    // Resolve photo paths to absolute web URLs
                    // Handles both folders: ~/Uploads/Riders/ (DeliveryPersonnel) and ~/UploadedRiders/ (Profile upload)
                    string appRoot = Request.ApplicationPath.TrimEnd('/');
                    List<DocumentItem> documents = new List<DocumentItem>();

                    foreach (DataRow row in dt.Rows)
                    {
                        string rawPath = row["FilePath"].ToString(); // raw DB value
                        string status = row["Status"].ToString();   // from RiderDocApprovals
                        string webPath = "";

                        if (!string.IsNullOrEmpty(rawPath))
                        {
                            if (rawPath.StartsWith("http"))
                            {
                                webPath = rawPath;
                            }
                            else
                            {
                                string fileName = System.IO.Path.GetFileName(
                                    rawPath.Replace("/", "\\"));

                                string physicalUploads = Server.MapPath("~/Uploads/Riders/" + fileName);
                                string physicalUploaded = Server.MapPath("~/UploadedRiders/" + fileName);

                                if (System.IO.File.Exists(physicalUploads))
                                    webPath = appRoot + "/Uploads/Riders/" + fileName;
                                else if (System.IO.File.Exists(physicalUploaded))
                                    webPath = appRoot + "/UploadedRiders/" + fileName;
                                else
                                    webPath = ""; // file not on this machine — View disabled but Status kept
                            }
                        }

                        // IMPORTANT: Status comes from DB (RiderDocApprovals), NOT from whether
                        // the file exists on disk. A file uploaded on another machine still has
                        // its correct approval status.
                        documents.Add(new DocumentItem
                        {
                            DocumentName = row["DocumentName"].ToString(),
                            DocumentColumn = row["DocumentColumn"].ToString(),
                            Status = status,
                            FilePath = webPath
                        });
                    }

                    rptDocuments.DataSource = documents;
                    rptDocuments.DataBind();
                }
            }
        }

        protected void rptDocuments_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                DocumentItem doc = (DocumentItem)e.Item.DataItem;
                bool isRejected = doc.Status.ToLower() == "rejected";
                bool hasFile = !string.IsNullOrEmpty(doc.FilePath) && doc.FilePath != "Not Uploaded";

                // Wire up Upload button
                Button btnUpload = (Button)e.Item.FindControl("btnUpload");
                if (btnUpload != null)
                    btnUpload.CommandArgument = doc.DocumentColumn;

                // Wire up View button
                Literal litViewBtn = (Literal)e.Item.FindControl("litViewBtn");
                if (litViewBtn != null)
                {
                    if (hasFile && !isRejected)
                    {
                        string safePath = doc.FilePath.Replace("\\", "/");
                        string safeName = doc.DocumentName;
                        litViewBtn.Text = "<button type='button' class='btn-icon btn-view' " +
                                          "onclick='viewDocument(&quot;" + safePath + "&quot;, &quot;" + safeName + "&quot;);'>" +
                                          "<i class='fas fa-eye'></i> View</button>";
                    }
                    else
                    {
                        string tip = isRejected ? "title='Document rejected â please re-upload'" : "";
                        litViewBtn.Text = "<button type='button' class='btn-icon btn-view' " +
                                          "disabled " + tip + " style='opacity:0.5;cursor:not-allowed;'>" +
                                          "<i class='fas fa-eye'></i> View</button>";
                    }
                }

                // Wire up Choose File button
                Literal litChooseBtn = (Literal)e.Item.FindControl("litChooseBtn");
                if (litChooseBtn != null)
                {
                    string safeCol = doc.DocumentColumn;
                    if (isRejected)
                    {
                        litChooseBtn.Text = "<button type='button' class='btn-file btn-file-reupload' " +
                                            "onclick='triggerAspFileUpload(&quot;" + safeCol + "&quot;, this)' " +
                                            "title='Document rejected â click to re-upload'>" +
                                            "<i class='fas fa-redo'></i> Re-upload</button>";
                    }
                    else
                    {
                        litChooseBtn.Text = "<button type='button' class='btn-file' " +
                                            "onclick='triggerAspFileUpload(&quot;" + safeCol + "&quot;, this)'>" +
                                            "<i class='fas fa-cloud-upload-alt'></i> Choose File</button>";
                    }
                }
            }
        }


        protected void btnSavePersonalInfo_Click(object sender, EventArgs e)
        {
            string fullName = "", email = "", phone = "", address = "";

            foreach (RepeaterItem item in rptPersonalInfoForm.Items)
            {
                if (item.ItemType == ListItemType.Item || item.ItemType == ListItemType.AlternatingItem)
                {
                    TextBox txtFullName = (TextBox)item.FindControl("txtFullName");
                    TextBox txtEmail = (TextBox)item.FindControl("txtEmail");
                    TextBox txtPhone = (TextBox)item.FindControl("txtPhone");
                    TextBox txtAddress = (TextBox)item.FindControl("txtAddress");

                    if (txtFullName != null) fullName = txtFullName.Text.Trim();
                    if (txtEmail != null) email = txtEmail.Text.Trim();
                    if (txtPhone != null) phone = txtPhone.Text.Trim();
                    if (txtAddress != null) address = txtAddress.Text.Trim();
                }
            }

            if (string.IsNullOrEmpty(fullName) || string.IsNullOrEmpty(email))
            {
                ShowNotification("Full Name and Email are required!", "error");
                return;
            }

            string query = @"
                UPDATE Users 
                SET FullName = @FullName, Email = @Email, Phone = @Phone, Address = @Address
                WHERE UserID = @UserID";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@FullName", fullName);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@Phone", string.IsNullOrEmpty(phone) ? (object)DBNull.Value : phone);
                    cmd.Parameters.AddWithValue("@Address", string.IsNullOrEmpty(address) ? (object)DBNull.Value : address);
                    cmd.Parameters.AddWithValue("@UserID", currentUserID);

                    conn.Open();
                    int rowsAffected = cmd.ExecuteNonQuery();
                    conn.Close();

                    if (rowsAffected > 0)
                    {
                        ShowNotification("Personal information updated successfully!", "success");
                        LoadRiderProfile();
                    }
                    else
                    {
                        ShowNotification("Error updating information.", "error");
                    }
                }
            }
        }

        protected void btnSaveVehicleInfo_Click(object sender, EventArgs e)
        {
            string vehicle = "", vehicleModel = "", vehicleYear = "", licensePlate = "";
            string vehicleColor = "", orcrNumber = "", insurancePolicy = "", insuranceDate = "";

            foreach (RepeaterItem item in rptVehicleDetails.Items)
            {
                if (item.ItemType == ListItemType.Item || item.ItemType == ListItemType.AlternatingItem)
                {
                    TextBox txtVehicle = (TextBox)item.FindControl("txtVehicle");
                    TextBox txtVehicleModel = (TextBox)item.FindControl("txtVehicleModel");
                    TextBox txtVehicleYear = (TextBox)item.FindControl("txtVehicleYear");
                    TextBox txtLicensePlate = (TextBox)item.FindControl("txtLicensePlate");
                    TextBox txtVehicleColor = (TextBox)item.FindControl("txtVehicleColor");
                    TextBox txtORCRNumber = (TextBox)item.FindControl("txtORCRNumber");
                    TextBox txtInsurancePolicy = (TextBox)item.FindControl("txtInsurancePolicy");
                    TextBox txtInsuranceDate = (TextBox)item.FindControl("txtInsuranceDate");

                    if (txtVehicle != null) vehicle = txtVehicle.Text.Trim();
                    if (txtVehicleModel != null) vehicleModel = txtVehicleModel.Text.Trim();
                    if (txtVehicleYear != null) vehicleYear = txtVehicleYear.Text.Trim();
                    if (txtLicensePlate != null) licensePlate = txtLicensePlate.Text.Trim();
                    if (txtVehicleColor != null) vehicleColor = txtVehicleColor.Text.Trim();
                    if (txtORCRNumber != null) orcrNumber = txtORCRNumber.Text.Trim();
                    if (txtInsurancePolicy != null) insurancePolicy = txtInsurancePolicy.Text.Trim();
                    if (txtInsuranceDate != null) insuranceDate = txtInsuranceDate.Text.Trim();
                }
            }

            string query = @"
                UPDATE Users 
                SET Vehicle = @Vehicle, VehicleModel = @VehicleModel, VehicleYear = @VehicleYear,
                    LicensePlate = @LicensePlate, VehicleColor = @VehicleColor, ORCRNumber = @ORCRNumber,
                    InsurancePolicy = @InsurancePolicy, InsuranceDate = @InsuranceDate
                WHERE UserID = @UserID";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Vehicle", string.IsNullOrEmpty(vehicle) ? (object)DBNull.Value : vehicle);
                    cmd.Parameters.AddWithValue("@VehicleModel", string.IsNullOrEmpty(vehicleModel) ? (object)DBNull.Value : vehicleModel);
                    cmd.Parameters.AddWithValue("@VehicleYear", string.IsNullOrEmpty(vehicleYear) ? (object)DBNull.Value : vehicleYear);
                    cmd.Parameters.AddWithValue("@LicensePlate", string.IsNullOrEmpty(licensePlate) ? (object)DBNull.Value : licensePlate);
                    cmd.Parameters.AddWithValue("@VehicleColor", string.IsNullOrEmpty(vehicleColor) ? (object)DBNull.Value : vehicleColor);
                    cmd.Parameters.AddWithValue("@ORCRNumber", string.IsNullOrEmpty(orcrNumber) ? (object)DBNull.Value : orcrNumber);
                    cmd.Parameters.AddWithValue("@InsurancePolicy", string.IsNullOrEmpty(insurancePolicy) ? (object)DBNull.Value : insurancePolicy);
                    cmd.Parameters.AddWithValue("@InsuranceDate", string.IsNullOrEmpty(insuranceDate) ? (object)DBNull.Value : insuranceDate);
                    cmd.Parameters.AddWithValue("@UserID", currentUserID);

                    conn.Open();
                    int rowsAffected = cmd.ExecuteNonQuery();
                    conn.Close();

                    if (rowsAffected > 0)
                    {
                        ShowNotification("Vehicle information updated successfully!", "success");
                        LoadVehicleDetails();
                    }
                    else
                    {
                        ShowNotification("Error updating vehicle information.", "error");
                    }
                }
            }
        }

        protected void UploadDocument(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            string documentColumn = btn.CommandArgument;

            // Validate documentColumn against whitelist to prevent SQL injection
            string[] validColumns = { "DriverLicensePhoto", "ORCRPhoto", "InsurancePhoto", "NBIClearancePhoto" };
            if (!Array.Exists(validColumns, c => c == documentColumn))
            {
                ShowNotification("Invalid document type.", "error");
                return;
            }

            // Find the asp:FileUpload in the same repeater item as the clicked button
            RepeaterItem item = (RepeaterItem)btn.NamingContainer;
            FileUpload fuDocument = (FileUpload)item.FindControl("fuDocument");

            if (fuDocument == null || !fuDocument.HasFile)
            {
                ShowNotification("Please select a file to upload.", "error");
                return;
            }

            try
            {
                string extension = Path.GetExtension(fuDocument.FileName).ToLower();
                if (extension != ".jpg" && extension != ".jpeg" && extension != ".png" && extension != ".pdf")
                {
                    ShowNotification("Only JPG, PNG, and PDF files are allowed!", "error");
                    return;
                }

                if (fuDocument.PostedFile.ContentLength > 5 * 1024 * 1024)
                {
                    ShowNotification("File size must be less than 5MB!", "error");
                    return;
                }

                string fileName = Guid.NewGuid().ToString() + extension;
                string folderPath = Server.MapPath("~/Uploads/Riders/");

                if (!Directory.Exists(folderPath))
                    Directory.CreateDirectory(folderPath);

                string fullPhysicalPath = Path.Combine(folderPath, fileName);
                fuDocument.SaveAs(fullPhysicalPath);

                string relativePath = "~/Uploads/Riders/" + fileName;

                // Reset approval status to pending when rider uploads a new document
                string query = $"UPDATE Users SET {documentColumn} = @FilePath WHERE UserID = @UserID";
                // Delete any existing approval record so it shows as Pending Review for the admin
                using (SqlConnection connReset = new SqlConnection(connectionString))
                using (SqlCommand cmdReset = new SqlCommand(
                    "DELETE FROM dbo.RiderDocApprovals WHERE UserID = @uid AND DocColumn = @col", connReset))
                {
                    cmdReset.Parameters.AddWithValue("@uid", currentUserID);
                    cmdReset.Parameters.AddWithValue("@col", documentColumn);
                    connReset.Open();
                    cmdReset.ExecuteNonQuery();
                }

                using (SqlConnection conn = new SqlConnection(connectionString))
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@FilePath", relativePath);
                    cmd.Parameters.AddWithValue("@UserID", currentUserID);
                    conn.Open();
                    int rowsAffected = cmd.ExecuteNonQuery();

                    if (rowsAffected > 0)
                    {
                        ShowNotification("Document uploaded successfully!", "success");
                        LoadDocuments();
                    }
                    else
                    {
                        ShowNotification("Error uploading document.", "error");
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Upload Error: " + ex.Message);
                ShowNotification("Error: " + ex.Message, "error");
            }
        }

        protected void btnChangePassword_Click(object sender, EventArgs e)
        {
            string currentPassword = txtCurrentPassword.Text.Trim();
            string newPassword = txtNewPassword.Text.Trim();
            string confirmPassword = txtConfirmPassword.Text.Trim();

            if (string.IsNullOrEmpty(currentPassword) || string.IsNullOrEmpty(newPassword) || string.IsNullOrEmpty(confirmPassword))
            {
                ShowNotification("All password fields are required!", "error");
                return;
            }

            if (newPassword != confirmPassword)
            {
                ShowNotification("New password and confirmation do not match!", "error");
                return;
            }

            if (newPassword.Length < 8)
            {
                ShowNotification("Password must be at least 8 characters long!", "error");
                return;
            }

            string verifyQuery = "SELECT Password FROM Users WHERE UserID = @UserID";
            string storedPassword = "";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(verifyQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@UserID", currentUserID);
                    conn.Open();
                    object result = cmd.ExecuteScalar();
                    storedPassword = result?.ToString();
                    conn.Close();
                }
            }

            if (currentPassword != storedPassword)
            {
                ShowNotification("Current password is incorrect!", "error");
                return;
            }

            string updateQuery = "UPDATE Users SET Password = @NewPassword WHERE UserID = @UserID";
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(updateQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@NewPassword", newPassword);
                    cmd.Parameters.AddWithValue("@UserID", currentUserID);
                    conn.Open();
                    int rowsAffected = cmd.ExecuteNonQuery();
                    conn.Close();

                    if (rowsAffected > 0)
                    {
                        ShowNotification("Password updated successfully!", "success");
                        // Clear password fields
                        txtCurrentPassword.Text = "";
                        txtNewPassword.Text = "";
                        txtConfirmPassword.Text = "";
                    }
                    else
                    {
                        ShowNotification("Error updating password.", "error");
                    }
                }
            }
        }

        protected string GetProfilePhotoUrl(object photoObj)
        {
            if (photoObj == null || string.IsNullOrEmpty(photoObj.ToString()))
                return null;

            string photo = photoObj.ToString();
            try
            {
                string physicalPath = Server.MapPath(photo);
                if (File.Exists(physicalPath))
                {
                    return photo;
                }
            }
            catch { }
            return null;
        }

        protected string GetInitials(object fullNameObj)
        {
            if (fullNameObj == null || string.IsNullOrEmpty(fullNameObj.ToString())) return "R";
            string fullName = fullNameObj.ToString();
            string[] names = fullName.Split(' ');
            if (names.Length >= 2)
                return names[0][0].ToString().ToUpper() + names[1][0].ToString().ToUpper();
            else if (names.Length == 1 && names[0].Length >= 2)
                return names[0][0].ToString().ToUpper() + names[0][1].ToString().ToUpper();
            else if (names.Length == 1)
                return names[0][0].ToString().ToUpper();
            return "RD";
        }

        protected string GetDocumentIcon(string documentName)
        {
            if (string.IsNullOrEmpty(documentName)) return "fa-file-alt";
            if (documentName.Contains("License")) return "fa-id-card";
            if (documentName.Contains("OR/CR")) return "fa-file-contract";
            if (documentName.Contains("Insurance")) return "fa-shield-alt";
            if (documentName.Contains("NBI")) return "fa-user-check";
            return "fa-file-alt";
        }

        protected string GetStatusClass(string status)
        {
            if (string.IsNullOrEmpty(status)) return "status-pending";
            switch (status.ToLower())
            {
                case "approved":
                case "verified": return "status-verified";
                case "rejected": return "status-rejected";
                case "pending":
                case "pending review": return "status-pending";
                default: return "status-pending";
            }
        }

        protected string GetStatusIcon(string status)
        {
            if (string.IsNullOrEmpty(status)) return "fa-clock";
            switch (status.ToLower())
            {
                case "approved":
                case "verified": return "fa-check-circle";
                case "rejected": return "fa-times-circle";
                default: return "fa-clock";
            }
        }

        protected string GetStatusLabel(string status)
        {
            if (string.IsNullOrEmpty(status)) return "Pending Review";
            switch (status.ToLower())
            {
                case "approved": return "Approved";
                case "verified": return "Verified";
                case "rejected": return "Rejected";
                case "pending review": return "Pending Review";
                case "not uploaded": return "Not Uploaded";
                default: return status;
            }
        }

        private void ShowNotification(string message, string type)
        {
            string script = $@"
                <script>
                    if (typeof showNotification === 'function') {{
                        showNotification('{message.Replace("'", "\\'")}', '{type}');
                    }} else {{
                        alert('{message.Replace("'", "\\'")}');
                    }}
                </script>";
            ClientScript.RegisterStartupScript(this.GetType(), "Notification_" + Guid.NewGuid().ToString(), script);
        }
    }
}