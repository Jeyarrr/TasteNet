using System;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TasteNet.Users.SuperAdmin
{
    public partial class Transactions : System.Web.UI.Page
    {
        private string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["TasteNetDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["export"] != null)
                {
                    string exportType = Request.QueryString["export"];
                    string ids = Request.QueryString["ids"];
                    ExportData(exportType, ids);
                }
                else
                {
                    LoadTransactions();
                }
            }
        }

        private void LoadTransactions()
        {
            try
            {
                DataTable dt = GetTransactionData("");

                if (dt.Rows.Count > 0)
                {
                    rptTransactions.DataSource = dt;
                    rptTransactions.DataBind();
                    noResults.Visible = false;
                    UpdateStatistics(dt);
                }
                else
                {
                    rptTransactions.DataSource = null;
                    rptTransactions.DataBind();
                    noResults.Visible = true;
                    ClearStatistics();
                }
            }
            catch (Exception ex)
            {
                noResults.Visible = true;
                noResults.InnerHtml = $"<p>Error loading transactions: {ex.Message}</p>";
            }
        }

        private DataTable GetTransactionData(string selectedIds = "")
        {
            DataTable dt = new DataTable();

            string query = @"
                SELECT 
                    it.TransactionID,
                    it.TransactionType,
                    it.Quantity,
                    it.PreviousStock,
                    it.NewStock,
                    it.Notes,
                    it.TransactionDate,
                    it.PerformedBy,
                    i.ItemName,
                    i.ItemCode,
                    i.UnitCost,
                    i.UnitPrice,
                    i.UnitOfMeasure,
                    ISNULL(u.FullName, 'System') AS PerformedByName,
                    (it.Quantity * CASE 
                        WHEN it.TransactionType = 'Sale' THEN i.UnitPrice
                        ELSE i.UnitCost
                    END) AS TotalValue
                FROM InventoryTransactions it
                INNER JOIN Inventory i ON it.InventoryID = i.InventoryID
                LEFT JOIN Users u ON it.PerformedBy = u.UserID
                WHERE 1=1";

            if (!string.IsNullOrEmpty(txtSearch.Text))
            {
                query += @" AND (CAST(it.TransactionID AS NVARCHAR(50)) LIKE @Search 
                           OR i.ItemName LIKE @Search)";
            }

            if (ddlStatus.SelectedValue != "all")
            {
                if (ddlStatus.SelectedValue == "completed")
                    query += " AND it.TransactionType IN ('Purchase', 'Sale')";
                else if (ddlStatus.SelectedValue == "pending")
                    query += " AND it.TransactionType = 'Pending'";
                else if (ddlStatus.SelectedValue == "return")
                    query += " AND it.TransactionType = 'Return'";
            }

            if (ddlType.SelectedValue != "all")
            {
                query += " AND it.TransactionType = @Type";
            }

            if (!string.IsNullOrEmpty(txtDate.Text))
            {
                query += " AND CAST(it.TransactionDate AS DATE) = @Date";
            }

            if (!string.IsNullOrEmpty(selectedIds))
            {
                query += $" AND it.TransactionID IN ({selectedIds})";
            }

            query += " ORDER BY it.TransactionDate DESC";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    if (!string.IsNullOrEmpty(txtSearch.Text))
                        cmd.Parameters.AddWithValue("@Search", "%" + txtSearch.Text + "%");
                    if (ddlType.SelectedValue != "all")
                        cmd.Parameters.AddWithValue("@Type", ddlType.SelectedValue);
                    if (!string.IsNullOrEmpty(txtDate.Text))
                        cmd.Parameters.AddWithValue("@Date", txtDate.Text);

                    conn.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                }
            }

            return dt;
        }

        private void UpdateStatistics(DataTable dt)
        {
            int totalTransactions = dt.Rows.Count;
            int sales = 0;
            int purchases = 0;
            decimal totalValue = 0;

            foreach (DataRow row in dt.Rows)
            {
                string type = row["TransactionType"].ToString();
                decimal value = Convert.ToDecimal(row["TotalValue"]);

                if (type == "Sale")
                {
                    sales++;
                    totalValue += value;
                }
                else if (type == "Purchase")
                {
                    purchases++;
                }
            }

            lblTotalTransactions.Text = totalTransactions.ToString();
            lblSales.Text = sales.ToString();
            lblPurchases.Text = purchases.ToString();
            lblTotalValue.Text = "₱" + totalValue.ToString("N2");
        }

        private void ClearStatistics()
        {
            lblTotalTransactions.Text = "0";
            lblSales.Text = "0";
            lblPurchases.Text = "0";
            lblTotalValue.Text = "₱0";
        }

        // Filter event handlers
        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            LoadTransactions();
        }

        protected void ddlStatus_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadTransactions();
        }

        protected void ddlType_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadTransactions();
        }

        protected void txtDate_TextChanged(object sender, EventArgs e)
        {
            LoadTransactions();
        }

        protected void rptTransactions_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "View")
            {
                int transactionId = Convert.ToInt32(e.CommandArgument);
                ShowTransactionDetails(transactionId);
            }
        }

        private void ShowTransactionDetails(int transactionId)
        {
            try
            {
                string query = @"
                    SELECT 
                        it.TransactionID,
                        it.TransactionType,
                        it.Quantity,
                        it.PreviousStock,
                        it.NewStock,
                        it.Notes,
                        it.TransactionDate,
                        i.ItemName,
                        i.ItemCode,
                        i.UnitCost,
                        i.UnitPrice,
                        ISNULL(u.FullName, 'System') AS PerformedBy
                    FROM InventoryTransactions it
                    INNER JOIN Inventory i ON it.InventoryID = i.InventoryID
                    LEFT JOIN Users u ON it.PerformedBy = u.UserID
                    WHERE it.TransactionID = @TransactionID";

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@TransactionID", transactionId);
                        conn.Open();
                        SqlDataReader reader = cmd.ExecuteReader();

                        if (reader.Read())
                        {
                            decimal totalValue = Convert.ToDecimal(reader["Quantity"]) * Convert.ToDecimal(reader["UnitPrice"]);
                            string statusClass = GetStatusClass(reader["TransactionType"].ToString());
                            string statusText = GetStatus(reader["TransactionType"].ToString());

                            string html = $@"
                                <div class='info-section'>
                                    <h4><i class='fas fa-box'></i> Item Information</h4>
                                    <div class='info-row'><span class='info-label'>Transaction ID:</span><span class='info-value'>TXN-{Convert.ToInt32(reader["TransactionID"]):000000}</span></div>
                                    <div class='info-row'><span class='info-label'>Item Name:</span><span class='info-value'>{reader["ItemName"]}</span></div>
                                    <div class='info-row'><span class='info-label'>Item Code:</span><span class='info-value'>{reader["ItemCode"] ?? "N/A"}</span></div>
                                    <div class='info-row'><span class='info-label'>Transaction Type:</span><span class='info-value'>{reader["TransactionType"]}</span></div>
                                </div>
                                <div class='info-section'>
                                    <h4><i class='fas fa-chart-line'></i> Stock Movement</h4>
                                    <div class='info-row'><span class='info-label'>Previous Stock:</span><span class='info-value'>{Convert.ToDecimal(reader["PreviousStock"]):N0} units</span></div>
                                    <div class='info-row'><span class='info-label'>Quantity Changed:</span><span class='info-value'>{Convert.ToDecimal(reader["Quantity"]):N0} units</span></div>
                                    <div class='info-row'><span class='info-label'>New Stock:</span><span class='info-value'>{Convert.ToDecimal(reader["NewStock"]):N0} units</span></div>
                                </div>
                                <div class='info-section'>
                                    <h4><i class='fas fa-money-bill-wave'></i> Financial Details</h4>
                                    <div class='info-row'><span class='info-label'>Unit Cost:</span><span class='info-value'>₱{Convert.ToDecimal(reader["UnitCost"]):N2}</span></div>
                                    <div class='info-row'><span class='info-label'>Unit Price:</span><span class='info-value'>₱{Convert.ToDecimal(reader["UnitPrice"]):N2}</span></div>
                                    <div class='info-row'><span class='info-label'>Total Value:</span><span class='info-value'>₱{totalValue:N2}</span></div>
                                </div>
                                <div class='info-section'>
                                    <h4><i class='fas fa-history'></i> Transaction Details</h4>
                                    <div class='info-row'><span class='info-label'>Date & Time:</span><span class='info-value'>{Convert.ToDateTime(reader["TransactionDate"]):yyyy-MM-dd HH:mm:ss}</span></div>
                                    <div class='info-row'><span class='info-label'>Performed By:</span><span class='info-value'>{reader["PerformedBy"]}</span></div>
                                    <div class='info-row'><span class='info-label'>Status:</span><span class='info-value'><span class='status-badge status-badge--{statusClass}'>{statusText}</span></span></div>
                                    <div class='info-row'><span class='info-label'>Notes:</span><span class='info-value'>{reader["Notes"] ?? "No additional notes"}</span></div>
                                </div>
                            ";

                            lblModalContent.Text = html;
                            string script = "showModal();";
                            ClientScript.RegisterStartupScript(this.GetType(), "ShowModal", script, true);
                        }
                        reader.Close();
                    }
                }
            }
            catch (Exception ex)
            {
                lblModalContent.Text = $"<div class='info-section'><p>Error loading details: {ex.Message}</p></div>";
                string script = "showModal();";
                ClientScript.RegisterStartupScript(this.GetType(), "ShowModal", script, true);
            }
        }

        private void ExportData(string exportType, string ids)
        {
            DataTable dt = GetTransactionData(exportType == "selected" ? ids : "");

            StringBuilder html = new StringBuilder();
            html.Append("<html><head><meta charset='UTF-8'></head><body>");
            html.Append("<h2>Transactions Report</h2>");
            html.Append($"<p>Generated on: {DateTime.Now:yyyy-MM-dd HH:mm:ss}</p>");
            html.Append("<table border='1' cellpadding='5' cellspacing='0'>");
            html.Append("<tr style='background-color:#6b0d1e; color:white;'><th>Transaction ID</th><th>Item Name</th><th>Type</th><th>Date</th><th>Quantity</th><th>Value</th><th>Status</th></tr>");

            foreach (DataRow row in dt.Rows)
            {
                html.Append("<tr>");
                html.Append($"<td>TXN-{Convert.ToInt32(row["TransactionID"]):000000}</td>");
                html.Append($"<td>{row["ItemName"]}</td>");
                html.Append($"<td>{row["TransactionType"]}</td>");
                html.Append($"<td>{Convert.ToDateTime(row["TransactionDate"]):yyyy-MM-dd HH:mm}</td>");
                html.Append($"<td>{row["Quantity"]} {row["UnitOfMeasure"]}</td>");
                html.Append($"<td>₱{Convert.ToDecimal(row["TotalValue"]):N2}</td>");
                html.Append($"<td>{GetStatus(row["TransactionType"].ToString())}</td>");
                html.Append("</tr>");
            }

            html.Append("</table></body></html>");

            Response.Clear();
            Response.ContentType = "application/vnd.ms-excel";
            Response.AddHeader("Content-Disposition", $"attachment; filename=Transactions_Report_{DateTime.Now:yyyyMMdd_HHmmss}.xls");
            Response.Write(html.ToString());
            Response.End();
        }

        public string GetStatus(string transactionType)
        {
            if (transactionType == "Purchase" || transactionType == "Sale") return "Completed";
            if (transactionType == "Return") return "Return";
            return "Pending";
        }

        public string GetStatusClass(string transactionType)
        {
            if (transactionType == "Purchase" || transactionType == "Sale") return "completed";
            if (transactionType == "Return") return "return";
            return "pending";
        }
    }
}