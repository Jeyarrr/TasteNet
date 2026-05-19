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
            // Redirect to login if the rider is not authenticated
            if (Session["UserID"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadDeliveryHistory();
            }
        }

        private void LoadDeliveryHistory()
        {
            // Get the currently logged-in rider's ID from session
            int riderID = Convert.ToInt32(Session["UserID"]);

            using (SqlConnection conn = new SqlConnection(_connStr))
            {
                // JOIN against the customer (CreatedBy) for name/phone display,
                // and JOIN again against the rider (RiderID) to get the rider's FullName.
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
                        u.[Phone],
                        r.[FullName] AS RiderName
                    FROM [DeliverySystem].[dbo].[Tickets] t
                    INNER JOIN [DeliverySystem].[dbo].[Users] u
                        ON t.[CreatedBy] = u.[UserID]
                    INNER JOIN [DeliverySystem].[dbo].[Users] r
                        ON t.[RiderID] = r.[UserID]
                    WHERE t.[Status]    = 'Completed'
                      AND t.[OrderType] = 'Delivery'
                      AND u.[UserType]  = 'Customer'
                      AND t.[RiderID]   = @RiderID
                    ORDER BY t.[CompletedAt] DESC";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@RiderID", riderID);

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
