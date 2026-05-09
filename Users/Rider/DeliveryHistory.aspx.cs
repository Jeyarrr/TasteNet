using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace TasteNet.Users.Rider
{
    public partial class DeliveryHistory : Page
    {
        private readonly string _connStr =
            System.Configuration.ConfigurationManager.ConnectionStrings["TasteNetDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDeliveryHistory();
            }
        }

        private void LoadDeliveryHistory()
        {
            using (SqlConnection conn = new SqlConnection(_connStr))
            {
                string query = @"
                    SELECT
                        t.[TicketID],
                        t.[TicketNumber],
                        t.[OrderNumber],
                        t.[OrderType],
                        t.[DeliveryAddress],
                        t.[Status],
                        t.[Priority],
                        t.[TotalAmount],
                        t.[CreatedAt],
                        t.[StartedAt],
                        t.[CompletedAt],
                        t.[CreatedBy],
                        t.[UpdatedAt],
                        u.[FullName],
                        u.[Phone]
                    FROM [DeliverySystem].[dbo].[Tickets] t
                    INNER JOIN [DeliverySystem].[dbo].[Users] u
                        ON t.[CreatedBy] = u.[UserID]
                    WHERE t.[Status] = 'Completed'
                      AND t.[OrderType] = 'Delivery'
                      AND u.[UserType] = 'Customer'
                    ORDER BY t.[CompletedAt] DESC";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    if (dt.Rows.Count > 0)
                    {
                        rptDeliveries.DataSource = dt;
                        rptDeliveries.DataBind();

                        lblTotalDeliveries.Text = dt.Rows.Count.ToString();

                        decimal totalAmount = 0;
                        foreach (DataRow row in dt.Rows)
                        {
                            if (row["TotalAmount"] != DBNull.Value)
                                totalAmount += Convert.ToDecimal(row["TotalAmount"]);
                        }
                        lblTotalAmount.Text = string.Format("₱{0:N2}", totalAmount);
                        lblResultsCount.Text = dt.Rows.Count.ToString();

                        pnlEmpty.Visible = false;
                    }
                    else
                    {
                        rptDeliveries.DataSource = null;
                        rptDeliveries.DataBind();

                        lblTotalDeliveries.Text = "0";
                        lblTotalAmount.Text = "₱0.00";
                        lblResultsCount.Text = "0";

                        pnlEmpty.Visible = true;
                    }
                }
            }
        }
    }
}