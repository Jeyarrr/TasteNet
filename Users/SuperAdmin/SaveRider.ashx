<%@ WebHandler Language="C#" Class="TasteNet.Users.SuperAdmin.SaveRider" %>

using System;
using System.Data.SqlClient;
using System.IO;
using System.Text;
using System.Web;

namespace TasteNet.Users.SuperAdmin
{
    public class SaveRider : IHttpHandler
    {
        private static readonly string[] AllowedImageExts = { ".jpg", ".jpeg", ".png", ".gif", ".webp" };

        public void ProcessRequest(HttpContext ctx)
        {
            ctx.Response.ContentType = "application/json";
            ctx.Response.AddHeader("Cache-Control", "no-cache");

            try
            {
                var req = ctx.Request;

                // ── Read text fields ────────────────────────────────────────
                string fullName        = req.Form["fullName"]        ?? "";
                string username        = req.Form["username"]        ?? "";
                string email           = req.Form["email"]           ?? "";
                string password        = req.Form["password"]        ?? "";
                string contact         = req.Form["contact"]         ?? "";
                string gender          = req.Form["gender"]          ?? "";
                string licenseNumber   = req.Form["licenseNumber"]   ?? "";
                string nbiNumber       = req.Form["nbiNumber"]       ?? "";
                string vehicle         = req.Form["vehicle"]         ?? "";
                string vehicleModel    = req.Form["vehicleModel"]    ?? "";
                string vehicleYear     = req.Form["vehicleYear"]     ?? "";
                string licensePlate    = req.Form["licensePlate"]    ?? "";
                string vehicleColor    = req.Form["vehicleColor"]    ?? "";
                string orcrNumber      = req.Form["orcrNumber"]      ?? "";
                string insurancePolicy = req.Form["insurancePolicy"] ?? "";
                string insuranceDate   = req.Form["insuranceDate"]   ?? "";

                // ── Basic validation ────────────────────────────────────────
                if (string.IsNullOrWhiteSpace(fullName) || string.IsNullOrWhiteSpace(username)
                    || string.IsNullOrWhiteSpace(email) || string.IsNullOrWhiteSpace(password))
                {
                    WriteError(ctx, "Required fields are missing.");
                    return;
                }

                // ── Hash password (SHA-256) ─────────────────────────────────
                string passwordHash;
                using (var sha = System.Security.Cryptography.SHA256.Create())
                {
                    var bytes = sha.ComputeHash(Encoding.UTF8.GetBytes(password));
                    var sb = new StringBuilder();
                    foreach (var b in bytes) sb.Append(b.ToString("x2"));
                    passwordHash = sb.ToString();
                }

                // ── Upload folder ───────────────────────────────────────────
                string uploadDir = ctx.Server.MapPath("~/Uploads/Riders/");
                if (!Directory.Exists(uploadDir))
                    Directory.CreateDirectory(uploadDir);

                // ── Save profile photo (ProfilePhoto column) ────────────────
                string profilePhotoPath = SaveUploadedFile(ctx, req.Files["profilePhoto"], uploadDir, "profile");

                // ── Save document photos ────────────────────────────────────
                string driverLicensePhotoPath = SaveUploadedFile(ctx, req.Files["driverLicensePhoto"], uploadDir, "license");
                string orcrPhotoPath          = SaveUploadedFile(ctx, req.Files["orcrPhoto"],          uploadDir, "orcr");
                string insurancePhotoPath     = SaveUploadedFile(ctx, req.Files["insurancePhoto"],     uploadDir, "insurance");
                string nbiClearancePhotoPath  = SaveUploadedFile(ctx, req.Files["nbiClearancePhoto"],  uploadDir, "nbi");

                // ── Parse insurance date ────────────────────────────────────
                DateTime? insuranceDateParsed = null;
                if (DateTime.TryParse(insuranceDate, out DateTime parsedDate))
                    insuranceDateParsed = parsedDate;

                // ── Insert into DB ──────────────────────────────────────────
                string connStr = System.Configuration.ConfigurationManager
                                       .ConnectionStrings["TasteNetDB"]
                                       .ConnectionString;

                string insertSql = @"
                    INSERT INTO [DeliverySystem].[dbo].[riders]
                        (FullName, Username, Email, PasswordHash, Contact, Gender,
                         LicenseNumber, NBINumber,
                         Vehicle, VehicleModel, VehicleYear, LicensePlate, VehicleColor,
                         ORCRNumber, InsurancePolicy, InsuranceDate,
                         ProfilePhoto,
                         DriverLicensePhoto, ORCRPhoto, InsurancePhoto, NBIClearancePhoto,
                         Status, AssignedOrders, CompletedOrders, Ratings, DateJoined)
                    OUTPUT INSERTED.RiderId
                    VALUES
                        (@FullName, @Username, @Email, @PasswordHash, @Contact, @Gender,
                         @LicenseNumber, @NBINumber,
                         @Vehicle, @VehicleModel, @VehicleYear, @LicensePlate, @VehicleColor,
                         @ORCRNumber, @InsurancePolicy, @InsuranceDate,
                         @ProfilePhoto,
                         @DriverLicensePhoto, @ORCRPhoto, @InsurancePhoto, @NBIClearancePhoto,
                         'Active', 0, 0, 0.0, GETDATE())";

                using (var con = new SqlConnection(connStr))
                using (var cmd = new SqlCommand(insertSql, con))
                {
                    cmd.Parameters.AddWithValue("@FullName",       fullName);
                    cmd.Parameters.AddWithValue("@Username",        username);
                    cmd.Parameters.AddWithValue("@Email",           email);
                    cmd.Parameters.AddWithValue("@PasswordHash",    passwordHash);
                    cmd.Parameters.AddWithValue("@Contact",         contact);
                    cmd.Parameters.AddWithValue("@Gender",          gender);
                    cmd.Parameters.AddWithValue("@LicenseNumber",   licenseNumber);
                    cmd.Parameters.AddWithValue("@NBINumber",       nbiNumber);
                    cmd.Parameters.AddWithValue("@Vehicle",         vehicle);
                    cmd.Parameters.AddWithValue("@VehicleModel",    vehicleModel);
                    cmd.Parameters.AddWithValue("@VehicleYear",     vehicleYear);
                    cmd.Parameters.AddWithValue("@LicensePlate",    licensePlate);
                    cmd.Parameters.AddWithValue("@VehicleColor",    vehicleColor);
                    cmd.Parameters.AddWithValue("@ORCRNumber",      orcrNumber);
                    cmd.Parameters.AddWithValue("@InsurancePolicy", insurancePolicy);
                    cmd.Parameters.AddWithValue("@InsuranceDate",
                        insuranceDateParsed.HasValue
                            ? (object)insuranceDateParsed.Value
                            : System.DBNull.Value);

                    // Photo columns — store NULL if no file was uploaded
                    cmd.Parameters.AddWithValue("@ProfilePhoto",
                        NullIfEmpty(profilePhotoPath));
                    cmd.Parameters.AddWithValue("@DriverLicensePhoto",
                        NullIfEmpty(driverLicensePhotoPath));
                    cmd.Parameters.AddWithValue("@ORCRPhoto",
                        NullIfEmpty(orcrPhotoPath));
                    cmd.Parameters.AddWithValue("@InsurancePhoto",
                        NullIfEmpty(insurancePhotoPath));
                    cmd.Parameters.AddWithValue("@NBIClearancePhoto",
                        NullIfEmpty(nbiClearancePhotoPath));

                    con.Open();
                    int newId = (int)cmd.ExecuteScalar();

                    // Convert ~/... paths to real URLs for the JS response
                    string appPath = ctx.Request.ApplicationPath.TrimEnd('/');
                    string ToUrl(string p) => string.IsNullOrEmpty(p) ? "" : p.Replace("~/", appPath + "/");

                    string joinDateStr = DateTime.Now.ToString("MMM d, yyyy");

                    ctx.Response.Write(
                        "{\"success\":true," +
                        "\"riderId\":"              + newId + "," +
                        "\"joinDate\":\""           + joinDateStr + "\"," +
                        "\"profilePicture\":\""     + ToUrl(profilePhotoPath)        + "\"," +
                        "\"driverLicensePhoto\":\"" + ToUrl(driverLicensePhotoPath)  + "\"," +
                        "\"orcrPhoto\":\""          + ToUrl(orcrPhotoPath)           + "\"," +
                        "\"insurancePhoto\":\""     + ToUrl(insurancePhotoPath)      + "\"," +
                        "\"nbiClearancePhoto\":\""  + ToUrl(nbiClearancePhotoPath)   + "\"," +
                        "\"message\":\"\"}"
                    );
                }
            }
            catch (Exception ex)
            {
                WriteError(ctx, ex.Message);
            }
        }

        // ── Helpers ─────────────────────────────────────────────────────────

        /// <summary>
        /// Saves an uploaded file to uploadDir with the given prefix.
        /// Returns the "~/Uploads/Riders/filename" virtual path, or "" if nothing was uploaded.
        /// Throws if the extension is not allowed.
        /// </summary>
        private static string SaveUploadedFile(HttpContext ctx, HttpPostedFile file, string uploadDir, string prefix)
        {
            if (file == null || file.ContentLength == 0) return "";

            string ext = Path.GetExtension(file.FileName).ToLower();
            if (!Array.Exists(AllowedImageExts, e => e == ext))
                throw new Exception($"File '{file.FileName}' is not an allowed image type (JPG, PNG, GIF, WEBP).");

            string fileName = prefix + "_" + Guid.NewGuid().ToString("N") + ext;
            file.SaveAs(Path.Combine(uploadDir, fileName));
            return "~/Uploads/Riders/" + fileName;
        }

        private static object NullIfEmpty(string s)
            => string.IsNullOrEmpty(s) ? (object)System.DBNull.Value : s;

        private static void WriteError(HttpContext ctx, string msg)
        {
            msg = msg.Replace("\\", "\\\\").Replace("\"", "\\\"").Replace("\r", "").Replace("\n", " ");
            ctx.Response.Write("{\"success\":false,\"riderId\":0,\"message\":\"" + msg + "\"}");
        }

        public bool IsReusable => false;
    }
}
