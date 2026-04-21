using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web;
using System.Web.UI;

namespace TasteNet.Users.SuperAdmin
{
    // ─────────────────────────────────────────────────────────────────────────
    // Menu.aspx.cs  —  Code-behind for the SuperAdmin Menu management page.
    //
    // Responsibilities:
    //   • LoadMenu()        → fetches all rows from the [Menu] table and
    //                         (a) binds them to the server-side Repeater as
    //                             a fallback, and
    //                         (b) serialises them into window.__menusData so the
    //                             client-side JavaScript grid can work with real
    //                             database data without an extra AJAX call.
    //   • ShowError()       → injects a styled error banner above the Repeater
    //                         when a database or unexpected error occurs.
    //   • JsEscape()        → helper to safely embed string values in the
    //                         inline <script> JSON without breaking the JS.
    //
    // Image upload (Add / Edit):
    //   The actual file saving is handled in AddMenu.ashx / UpdateMenu.ashx.
    //   See the NOTE block below for the expected handler logic.
    // ─────────────────────────────────────────────────────────────────────────
    public partial class Menu : System.Web.UI.Page
    {
        // ──────────────────────────────────────────────────────────────────────
        // NOTE FOR AddMenu.ashx / UpdateMenu.ashx — Image Upload Handler Steps
        //
        // When the user picks a file in the modal, the JS posts it as the
        // "ImageFile" field inside a multipart/form-data request.
        // Your handler MUST:
        //
        //   1. Read the file FIRST (before reading Request.Form):
        //        HttpPostedFile imgFile = context.Request.Files["ImageFile"];
        //
        //   2. Validate the extension (.jpg, .jpeg, .png, .webp, .gif only).
        //
        //   3. Ensure the save folder exists (this is the most common reason
        //      uploads silently fail):
        //        string folder = context.Server.MapPath("~/Images/Menus/");
        //        if (!Directory.Exists(folder)) Directory.CreateDirectory(folder);
        //
        //   4. Save with a unique filename to avoid collisions:
        //        string unique = Guid.NewGuid().ToString("N") + ext;
        //        imgFile.SaveAs(Path.Combine(folder, unique));
        //
        //   5. Store the RELATIVE path in the DB (not the physical path):
        //        savedImagePath = "Images/Menus/" + unique;
        //
        //   6. If no file was posted, fall back to the "ImagePath" form field:
        //        if (imgFile == null || imgFile.ContentLength == 0)
        //            savedImagePath = context.Request.Form["ImagePath"] ?? "";
        //
        //   7. Return JSON: { "success": true } or { "success": false, "message": "..." }
        // ──────────────────────────────────────────────────────────────────────

        // Connection string pulled from Web.config → <connectionStrings>
        private string connStr = ConfigurationManager.ConnectionStrings["TasteNetDB"].ConnectionString;

        // ─────────────────────────────────────────────────────────────────────
        // Page_Load
        //   ASP.NET lifecycle entry point.  We only load data on the first
        //   request (IsPostBack = false) because all subsequent interactions
        //   (add / edit / delete) go through the ASHX handlers and reload
        //   the page from scratch.
        // ─────────────────────────────────────────────────────────────────────
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadMenu();
            }
        }

        // ─────────────────────────────────────────────────────────────────────
        // LoadMenu()
        //   1. Queries the [Menu] table ordered newest-first.
        //   2. Binds the result to rptMenu (server-side Repeater — HTML fallback
        //      for non-JS environments or search-engine crawlers).
        //   3. Serialises the same rows into a <script> block that sets
        //      window.__menusData so the JavaScript grid has real DB data
        //      without a separate AJAX / fetch call.
        // ─────────────────────────────────────────────────────────────────────
        private void LoadMenu()
        {
            DataTable dt = new DataTable();
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = @"
                        SELECT MenuID, FoodName, FoodType, Price, ImagePath,
                               ISNULL(Status, 'active') AS Status
                        FROM   Menu
                        ORDER  BY MenuID DESC"; 

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    con.Open();
                    da.Fill(dt); // fill the DataTable
                }

                // ── Server-side Repeater (HTML fallback) ──────────────────────
                rptMenu.DataSource = dt;
                rptMenu.DataBind();

                // ── Client-side JSON injection ────────────────────────────────
                // Serialize every row into a JS array literal so the browser's
                // JavaScript can access live DB data the moment the page loads,
                // without waiting for a separate AJAX request.
                //
                // Output format:
                //   <script>window.__menusData = [{...}, {...}];</script>
                //
                // The JS code in Menu.aspx reads this via:
                //   var menusData = window.__menusData || [];
                var sb = new StringBuilder();
                sb.Append("<script>window.__menusData = [");

                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    DataRow r = dt.Rows[i];
                    if (i > 0) sb.Append(","); // comma-separate objects

                    sb.Append("{");
                    sb.AppendFormat("\"menuId\":{0},", r["MenuID"]);
                    sb.AppendFormat("\"foodName\":\"{0}\",", JsEscape(r["FoodName"]));
                    sb.AppendFormat("\"foodType\":\"{0}\",", JsEscape(r["FoodType"]));
                    // Always use InvariantCulture so we get "12.50" not "12,50" on European servers
                    sb.AppendFormat("\"price\":{0},",
                        Convert.ToDecimal(r["Price"]).ToString("F2", System.Globalization.CultureInfo.InvariantCulture));
                    sb.AppendFormat("\"imagePath\":\"{0}\",", JsEscape(r["ImagePath"]));
                    sb.AppendFormat("\"status\":\"{0}\",", JsEscape(r["Status"]));
                    sb.AppendFormat("\"itemCount\":{0}", 0); // placeholder — join to OrderItems if needed
                    sb.Append("}");
                }

                sb.Append("];</script>");
                MenusJsonLiteral.Text = sb.ToString(); // render the <script> block into the page
            }
            catch (SqlException sqlEx) { ShowError("Database error: " + sqlEx.Message); }
            catch (Exception ex) { ShowError("Unexpected error: " + ex.Message); }
        }

        // ─────────────────────────────────────────────────────────────────────
        // JsEscape(val)
        //   Makes a database value safe to embed inside a JavaScript string
        //   literal by escaping backslashes, double-quotes, and line breaks.
        //   Returns an empty string for NULL / DBNull values.
        // ─────────────────────────────────────────────────────────────────────
        private static string JsEscape(object val)
        {
            if (val == null || val == DBNull.Value) return "";
            return val.ToString()
                      .Replace("\\", "\\\\")  // backslash  → \\
                      .Replace("\"", "\\\"")  // quote      → \"
                      .Replace("\r", "")      // strip CR
                      .Replace("\n", "");     // strip LF  (newlines break JS string literals)
        }

        // ─────────────────────────────────────────────────────────────────────
        // ShowError(message)
        //   Injects a red error banner directly above the Repeater control
        //   when LoadMenu() catches an exception.  The message is HTML-encoded
        //   before output to prevent XSS.
        // ─────────────────────────────────────────────────────────────────────
        private void ShowError(string message)
        {
            string banner = string.Format(@"
                <div style=""background:#fee2e2;border:1px solid #fca5a5;border-left:4px solid #b91c1c;
                    color:#7f1d1d;padding:14px 18px;border-radius:10px;font-family:'Poppins',sans-serif;
                    font-size:14px;margin:10px 0 20px 0;display:flex;align-items:center;gap:10px;"">
                    <i class=""fas fa-exclamation-circle"" style=""font-size:18px;color:#b91c1c;""></i>
                    <span>{0}</span>
                </div>", HttpUtility.HtmlEncode(message)); // HtmlEncode prevents XSS

            // Insert the banner immediately before the Repeater in the control tree
            rptMenu.Parent.Controls.AddAt(
                rptMenu.Parent.Controls.IndexOf(rptMenu),
                new LiteralControl(banner));
        }
    }
}
