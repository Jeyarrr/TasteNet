using System;
using System.Data.SqlClient;
using System.IO;
using System.Text;
using System.Web;
using System.Web.UI;

namespace TasteNet.Users.SuperAdmin
{
    public partial class DeliveryPersonnel : System.Web.UI.Page
    {
        private string ConnStr =>
            System.Configuration.ConfigurationManager
                  .ConnectionStrings["TasteNetDB"]
                  .ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            string action = Request.QueryString["action"] ?? "";

            // Inline AJAX handlers — replaces SaveRider.ashx and DeleteRider.ashx
            if (action == "saveRider")
            {
                Response.ContentType = "application/json";
                Response.Write(DoSaveRider());
                Response.End();
                return;
            }

            if (action == "deleteRider")
            {
                Response.ContentType = "application/json";
                Response.Write(DoDeleteRider());
                Response.End();
                return;
            }

            // Normal page load — GetRidersJson() is called inline from the ASPX markup
        }

        // ── Add a new rider ───────────────────────────────────────────────────
        private string DoSaveRider()
        {
            try
            {
                string fullName = Request.Form["fullName"] ?? "";
                string username = Request.Form["username"] ?? "";
                string email = Request.Form["email"] ?? "";
                string password = Request.Form["password"] ?? "";
                string contact = Request.Form["contact"] ?? "";
                string gender = Request.Form["gender"] ?? "";
                string licenseNumber = Request.Form["licenseNumber"] ?? "";
                string nbiNumber = Request.Form["nbiNumber"] ?? "";
                string vehicle = Request.Form["vehicle"] ?? "";
                string vehicleModel = Request.Form["vehicleModel"] ?? "";
                string vehicleYear = Request.Form["vehicleYear"] ?? "";
                string licensePlate = Request.Form["licensePlate"] ?? "";
                string vehicleColor = Request.Form["vehicleColor"] ?? "";
                string orcrNumber = Request.Form["orcrNumber"] ?? "";
                string insurancePolicy = Request.Form["insurancePolicy"] ?? "";
                string insuranceDate = Request.Form["insuranceDate"] ?? "";

                string uploadFolder = Server.MapPath("~/Uploads/Riders/");
                if (!Directory.Exists(uploadFolder)) Directory.CreateDirectory(uploadFolder);

                string profilePicPath = SaveUploadedFile("profilePhoto", uploadFolder);
                string driverLicensePath = SaveUploadedFile("driverLicensePhoto", uploadFolder);
                string orcrPhotoPath = SaveUploadedFile("orcrPhoto", uploadFolder);
                string insurancePhotoPath = SaveUploadedFile("insurancePhoto", uploadFolder);
                string nbiClearancePath = SaveUploadedFile("nbiClearancePhoto", uploadFolder);

                string joinDate = DateTime.Now.ToString("MMM d, yyyy");
                int newId = 0;

                using (var con = new SqlConnection(ConnStr))
                {
                    con.Open();
                    const string sql = @"
                        INSERT INTO [DeliverySystem].[dbo].[Users]
                            (FullName, Username, Email, Password, Phone, Gender, UserType, IsActive, CreatedAt,
                             LicenseNumber, NBINumber, Vehicle, VehicleModel, VehicleYear,
                             LicensePlate, VehicleColor, ORCRNumber, InsurancePolicy,
                             InsuranceDate, ProfilePhoto, DriverLicensePhoto, ORCRPhoto,
                             InsurancePhoto, NBIClearancePhoto, RiderStatus, DateJoined,
                             AssignedOrders, CompletedOrders, Ratings)
                        OUTPUT INSERTED.UserID
                        VALUES
                            (@FullName, @Username, @Email, @Password, @Phone, @Gender, 'Rider', 1, GETDATE(),
                             @LicenseNumber, @NBINumber, @Vehicle, @VehicleModel, @VehicleYear,
                             @LicensePlate, @VehicleColor, @ORCRNumber, @InsurancePolicy,
                             @InsuranceDate, @ProfilePhoto, @DriverLicensePhoto, @ORCRPhoto,
                             @InsurancePhoto, @NBIClearancePhoto, 'available', GETDATE(), 0, 0, 0)";

                    using (var cmd = new SqlCommand(sql, con))
                    {
                        cmd.Parameters.AddWithValue("@FullName", fullName);
                        cmd.Parameters.AddWithValue("@Username", username);
                        cmd.Parameters.AddWithValue("@Email", email);
                        cmd.Parameters.AddWithValue("@Password", password); // Plain text password
                        cmd.Parameters.AddWithValue("@Phone", contact);
                        cmd.Parameters.AddWithValue("@Gender", gender);
                        cmd.Parameters.AddWithValue("@LicenseNumber", licenseNumber);
                        cmd.Parameters.AddWithValue("@NBINumber", nbiNumber);
                        cmd.Parameters.AddWithValue("@Vehicle", vehicle);
                        cmd.Parameters.AddWithValue("@VehicleModel", vehicleModel);
                        cmd.Parameters.AddWithValue("@VehicleYear", vehicleYear);
                        cmd.Parameters.AddWithValue("@LicensePlate", licensePlate);
                        cmd.Parameters.AddWithValue("@VehicleColor", vehicleColor);
                        cmd.Parameters.AddWithValue("@ORCRNumber", orcrNumber);
                        cmd.Parameters.AddWithValue("@InsurancePolicy", insurancePolicy);
                        cmd.Parameters.AddWithValue("@InsuranceDate",
                            string.IsNullOrEmpty(insuranceDate) ? (object)DBNull.Value : DateTime.Parse(insuranceDate));
                        cmd.Parameters.AddWithValue("@ProfilePhoto",
                            string.IsNullOrEmpty(profilePicPath) ? (object)DBNull.Value : profilePicPath);
                        cmd.Parameters.AddWithValue("@DriverLicensePhoto",
                            string.IsNullOrEmpty(driverLicensePath) ? (object)DBNull.Value : driverLicensePath);
                        cmd.Parameters.AddWithValue("@ORCRPhoto",
                            string.IsNullOrEmpty(orcrPhotoPath) ? (object)DBNull.Value : orcrPhotoPath);
                        cmd.Parameters.AddWithValue("@InsurancePhoto",
                            string.IsNullOrEmpty(insurancePhotoPath) ? (object)DBNull.Value : insurancePhotoPath);
                        cmd.Parameters.AddWithValue("@NBIClearancePhoto",
                            string.IsNullOrEmpty(nbiClearancePath) ? (object)DBNull.Value : nbiClearancePath);

                        newId = (int)cmd.ExecuteScalar();
                    }
                }

                string appRoot = Request.ApplicationPath.TrimEnd('/');
                string WebPath(string serverPath) =>
                    string.IsNullOrEmpty(serverPath) ? "" :
                    appRoot + "/Uploads/Riders/" + Path.GetFileName(serverPath);

                return "{\"success\":true," +
                       "\"riderId\":" + newId + "," +
                       "\"joinDate\":\"" + joinDate + "\"," +
                       "\"profilePicture\":\"" + WebPath(profilePicPath) + "\"," +
                       "\"driverLicensePhoto\":\"" + WebPath(driverLicensePath) + "\"," +
                       "\"orcrPhoto\":\"" + WebPath(orcrPhotoPath) + "\"," +
                       "\"insurancePhoto\":\"" + WebPath(insurancePhotoPath) + "\"," +
                       "\"nbiClearancePhoto\":\"" + WebPath(nbiClearancePath) + "\"}";
            }
            catch (Exception ex)
            {
                return "{\"success\":false,\"message\":\"" + ex.Message.Replace("\"", "'") + "\"}";
            }
        }

        // ── Delete a rider ────────────────────────────────────────────────────
        private string DoDeleteRider()
        {
            try
            {
                int riderId = 0;
                int.TryParse(Request.Form["riderId"], out riderId);
                if (riderId == 0)
                    return "{\"success\":false,\"message\":\"Invalid rider ID.\"}";

                using (var con = new SqlConnection(ConnStr))
                using (var cmd = new SqlCommand(
                    "DELETE FROM [DeliverySystem].[dbo].[Users] WHERE UserID=@RiderId AND UserType='Rider'", con))
                {
                    cmd.Parameters.AddWithValue("@RiderId", riderId);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
                return "{\"success\":true}";
            }
            catch (Exception ex)
            {
                return "{\"success\":false,\"message\":\"" + ex.Message.Replace("\"", "'") + "\"}";
            }
        }

        // ── Save uploaded file to disk, return server path ────────────────────
        private string SaveUploadedFile(string inputName, string folder)
        {
            HttpPostedFile file = Request.Files[inputName];
            if (file == null || file.ContentLength == 0) return "";
            string ext = Path.GetExtension(file.FileName).ToLower();
            string name = Guid.NewGuid().ToString("N") + ext;
            string path = Path.Combine(folder, name);
            file.SaveAs(path);
            return path;
        }

        // ── Safely read a nullable DB column ─────────────────────────────────
        private static string SafeStr(System.Data.IDataRecord dr, string col)
        {
            try { return dr[col] == DBNull.Value ? "" : dr[col].ToString(); }
            catch { return ""; }
        }

        // ── Build the riders JSON array injected into the page ────────────────
        protected string GetRidersJson()
        {
            var sb = new StringBuilder("[");
            bool first = true;

            try
            {
                using (var con = new SqlConnection(ConnStr))
                using (var cmd = new SqlCommand(
                    "SELECT TOP(1000) * FROM [DeliverySystem].[dbo].[Users] WHERE UserType = 'Rider' ORDER BY UserID", con))
                {
                    con.Open();
                    using (var dr = cmd.ExecuteReader())
                    {
                        while (dr.Read())
                        {
                            if (!first) sb.Append(",");
                            first = false;

                            string status = SafeStr(dr, "RiderStatus").ToLower().Trim();
                            if (status == "on delivery" || status == "delivering") status = "delivery";
                            else if (status == "active" || status == "online") status = "available";
                            else if (status != "available" && status != "delivery") status = "offline";

                            double rating = 0;
                            double.TryParse(SafeStr(dr, "Ratings"), out rating);

                            string joinDate = "";
                            try
                            {
                                if (dr["DateJoined"] != DBNull.Value)
                                    joinDate = Convert.ToDateTime(dr["DateJoined"]).ToString("MMM d, yyyy");
                                else if (dr["CreatedAt"] != DBNull.Value)
                                    joinDate = Convert.ToDateTime(dr["CreatedAt"]).ToString("MMM d, yyyy");
                            }
                            catch { }

                            string appRoot = Request.ApplicationPath.TrimEnd('/');
                            string profilePic = SafeStr(dr, "ProfilePhoto");
                            if (!string.IsNullOrEmpty(profilePic) && !profilePic.StartsWith("http"))
                                profilePic = appRoot + "/Uploads/Riders/" + Path.GetFileName(profilePic);

                            // Resolve photo paths to absolute web URLs
                            string driverLicensePhoto = SafeStr(dr, "DriverLicensePhoto");
                            if (!string.IsNullOrEmpty(driverLicensePhoto) && !driverLicensePhoto.StartsWith("http"))
                                driverLicensePhoto = appRoot + "/Uploads/Riders/" + Path.GetFileName(driverLicensePhoto);

                            string orcrPhoto = SafeStr(dr, "ORCRPhoto");
                            if (!string.IsNullOrEmpty(orcrPhoto) && !orcrPhoto.StartsWith("http"))
                                orcrPhoto = appRoot + "/Uploads/Riders/" + Path.GetFileName(orcrPhoto);

                            string insurancePhoto = SafeStr(dr, "InsurancePhoto");
                            if (!string.IsNullOrEmpty(insurancePhoto) && !insurancePhoto.StartsWith("http"))
                                insurancePhoto = appRoot + "/Uploads/Riders/" + Path.GetFileName(insurancePhoto);

                            string nbiClearancePhoto = SafeStr(dr, "NBIClearancePhoto");
                            if (!string.IsNullOrEmpty(nbiClearancePhoto) && !nbiClearancePhoto.StartsWith("http"))
                                nbiClearancePhoto = appRoot + "/Uploads/Riders/" + Path.GetFileName(nbiClearancePhoto);

                            string insDate = "";
                            try
                            {
                                if (dr["InsuranceDate"] != DBNull.Value)
                                    insDate = Convert.ToDateTime(dr["InsuranceDate"]).ToString("yyyy-MM-dd");
                            }
                            catch { }

                            // Emit assigned/completed/rating as bare numbers
                            int assigned = 0; int.TryParse(SafeStr(dr, "AssignedOrders"), out assigned);
                            int completed = 0; int.TryParse(SafeStr(dr, "CompletedOrders"), out completed);

                            sb.Append("{");
                            sb.AppendFormat("\"id\":{0},", JsonStr(SafeStr(dr, "UserID")));
                            sb.AppendFormat("\"name\":{0},", JsonStr(SafeStr(dr, "FullName")));
                            sb.AppendFormat("\"username\":{0},", JsonStr(SafeStr(dr, "Username")));
                            sb.AppendFormat("\"phone\":{0},", JsonStr(SafeStr(dr, "Phone")));
                            sb.AppendFormat("\"email\":{0},", JsonStr(SafeStr(dr, "Email")));
                            sb.AppendFormat("\"gender\":{0},", JsonStr(SafeStr(dr, "Gender")));
                            sb.AppendFormat("\"joinDate\":{0},", JsonStr(joinDate));
                            sb.AppendFormat("\"vehicle\":{0},", JsonStr(SafeStr(dr, "Vehicle")));
                            sb.AppendFormat("\"vehicleModel\":{0},", JsonStr(SafeStr(dr, "VehicleModel")));
                            sb.AppendFormat("\"vehicleYear\":{0},", JsonStr(SafeStr(dr, "VehicleYear")));
                            sb.AppendFormat("\"licensePlate\":{0},", JsonStr(SafeStr(dr, "LicensePlate")));
                            sb.AppendFormat("\"vehicleColor\":{0},", JsonStr(SafeStr(dr, "VehicleColor")));
                            sb.AppendFormat("\"licenseNumber\":{0},", JsonStr(SafeStr(dr, "LicenseNumber")));
                            sb.AppendFormat("\"nbiNumber\":{0},", JsonStr(SafeStr(dr, "NBINumber")));
                            sb.AppendFormat("\"orcrNumber\":{0},", JsonStr(SafeStr(dr, "ORCRNumber")));
                            sb.AppendFormat("\"insurancePolicy\":{0},", JsonStr(SafeStr(dr, "InsurancePolicy")));
                            sb.AppendFormat("\"insuranceDate\":{0},", JsonStr(insDate));
                            sb.AppendFormat("\"profilePicture\":{0},", JsonStr(profilePic));
                            sb.AppendFormat("\"driverLicensePhoto\":{0},", JsonStr(driverLicensePhoto));
                            sb.AppendFormat("\"orcrPhoto\":{0},", JsonStr(orcrPhoto));
                            sb.AppendFormat("\"insurancePhoto\":{0},", JsonStr(insurancePhoto));
                            sb.AppendFormat("\"nbiClearancePhoto\":{0},", JsonStr(nbiClearancePhoto));
                            sb.AppendFormat("\"status\":{0},", JsonStr(status));
                            // Numbers — NOT quoted
                            sb.AppendFormat("\"assigned\":{0},", assigned);
                            sb.AppendFormat("\"completed\":{0},", completed);
                            sb.AppendFormat("\"rating\":{0},", rating.ToString("F1", System.Globalization.CultureInfo.InvariantCulture));
                            sb.Append("\"lastActivity\":\"\",\"recentDeliveries\":[]}");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("GetRidersJson error: " + ex.Message);
                return "[] /* ERROR: " + ex.Message.Replace("*/", "") + " */";
            }

            sb.Append("]");
            return sb.ToString();
        }

        private static string JsonStr(string s)
        {
            if (s == null) return "\"\"";
            return "\"" + s.Replace("\\", "\\\\")
                            .Replace("\"", "\\\"")
                            .Replace("\r", "")
                            .Replace("\n", "") + "\"";
        }
    }
}