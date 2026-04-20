using System;
using System.Data.SqlClient;
using System.Text;
using System.Web.UI;

namespace TasteNet.Users.SuperAdmin
{
    public partial class DeliveryPersonnel : System.Web.UI.Page
    {
        private string ConnStr =>
            System.Configuration.ConfigurationManager
                  .ConnectionStrings["TasteNetDB"]
                  .ConnectionString;

        protected void Page_Load(object sender, EventArgs e) { }

        // Helper: safely read a string column — returns "" if column missing or null
        private static string SafeStr(System.Data.IDataRecord dr, string col)
        {
            try { return dr[col] == DBNull.Value ? "" : dr[col].ToString(); }
            catch { return ""; }
        }

        protected string GetRidersJson()
        {
            var sb = new StringBuilder("[");
            bool first = true;

            try
            {
                // Use SELECT * so we never crash on a missing non-critical column
                // New table uses ProfilePhoto (was ProfilePicture) and has separate photo columns
                string selectSql = "SELECT TOP(1000) * FROM [DeliverySystem].[dbo].[riders] ORDER BY RiderId";

                using (var con = new SqlConnection(ConnStr))
                using (var cmd = new SqlCommand(selectSql, con))
                {
                    con.Open();
                    using (var dr = cmd.ExecuteReader())
                    {
                        while (dr.Read())
                        {
                            if (!first) sb.Append(",");
                            first = false;

                            // Normalise status → available | delivery | offline
                            string status = SafeStr(dr, "Status").ToLower().Trim();
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
                            }
                            catch { }

                            // Column is now ProfilePhoto (renamed from ProfilePicture)
                            string profilePic = "";
                            string rawPic = SafeStr(dr, "ProfilePhoto");
                            if (!string.IsNullOrEmpty(rawPic))
                                profilePic = rawPic.Replace("~/", Request.ApplicationPath.TrimEnd('/') + "/");

                            // Dedicated document photo columns (new in this schema)
                            string driverLicensePhoto = SafeStr(dr, "DriverLicensePhoto");
                            string orcrPhoto = SafeStr(dr, "ORCRPhoto");
                            string insurancePhoto = SafeStr(dr, "InsurancePhoto");
                            string nbiClearancePhoto = SafeStr(dr, "NBIClearancePhoto");

                            string insDate = "";
                            try
                            {
                                if (dr["InsuranceDate"] != DBNull.Value)
                                    insDate = Convert.ToDateTime(dr["InsuranceDate"]).ToString("yyyy-MM-dd");
                            }
                            catch { }

                            sb.AppendFormat(
                                "{{" +
                                "\"id\":{0}," +
                                "\"name\":{1}," +
                                "\"username\":{2}," +
                                "\"phone\":{3}," +
                                "\"email\":{4}," +
                                "\"gender\":{5}," +
                                "\"joinDate\":{6}," +
                                "\"vehicle\":{7}," +
                                "\"vehicleModel\":{8}," +
                                "\"vehicleYear\":{9}," +
                                "\"licensePlate\":{10}," +
                                "\"vehicleColor\":{11}," +
                                "\"licenseNumber\":{12}," +
                                "\"nbiNumber\":{13}," +
                                "\"orcrNumber\":{14}," +
                                "\"insurancePolicy\":{15}," +
                                "\"insuranceDate\":{16}," +
                                "\"profilePicture\":{17}," +
                                "\"driverLicensePhoto\":{18}," +
                                "\"orcrPhoto\":{19}," +
                                "\"insurancePhoto\":{20}," +
                                "\"nbiClearancePhoto\":{21}," +
                                "\"status\":{22}," +
                                "\"assigned\":{23}," +
                                "\"completed\":{24}," +
                                "\"rating\":{25}," +
                                "\"lastActivity\":\"\"," +
                                "\"recentDeliveries\":[]" +
                                "}}",
                                JsonStr(SafeStr(dr, "RiderId")),
                                JsonStr(SafeStr(dr, "FullName")),
                                JsonStr(SafeStr(dr, "Username")),
                                JsonStr(SafeStr(dr, "Contact")),
                                JsonStr(SafeStr(dr, "Email")),
                                JsonStr(SafeStr(dr, "Gender")),
                                JsonStr(joinDate),
                                JsonStr(SafeStr(dr, "Vehicle")),
                                JsonStr(SafeStr(dr, "VehicleModel")),
                                JsonStr(SafeStr(dr, "VehicleYear")),
                                JsonStr(SafeStr(dr, "LicensePlate")),
                                JsonStr(SafeStr(dr, "VehicleColor")),
                                JsonStr(SafeStr(dr, "LicenseNumber")),
                                JsonStr(SafeStr(dr, "NBINumber")),
                                JsonStr(SafeStr(dr, "ORCRNumber")),
                                JsonStr(SafeStr(dr, "InsurancePolicy")),
                                JsonStr(insDate),
                                JsonStr(profilePic),
                                JsonStr(driverLicensePhoto),
                                JsonStr(orcrPhoto),
                                JsonStr(insurancePhoto),
                                JsonStr(nbiClearancePhoto),
                                JsonStr(status),
                                SafeStr(dr, "AssignedOrders") == "" ? "0" : SafeStr(dr, "AssignedOrders"),
                                SafeStr(dr, "CompletedOrders") == "" ? "0" : SafeStr(dr, "CompletedOrders"),
                                rating.ToString("F1", System.Globalization.CultureInfo.InvariantCulture)
                            );
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Surface the real error as a JS comment so you can see it in browser DevTools
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
