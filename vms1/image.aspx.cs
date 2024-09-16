using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Configuration;
using System.Data.SqlClient;

namespace vms1
{
    public partial class ShowImage : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string courierEntryNo = Request.QueryString["CourierEntryNo"];
                if (!string.IsNullOrEmpty(courierEntryNo))
                {
                    LoadImage(courierEntryNo);
                }
            }
        }

        private void LoadImage(string courierEntryNo)
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;
            string query = "SELECT Attach_Courier_Receipt FROM OutwardCourier WHERE Courier_Entry_No = @CourierEntryNo";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@CourierEntryNo", courierEntryNo);

                try
                {
                    conn.Open();
                    byte[] imageData = cmd.ExecuteScalar() as byte[];
                    if (imageData != null)
                    {
                        Response.ContentType = "image/jpeg"; // Adjust content type based on your image format
                        Response.BinaryWrite(imageData);
                        Response.End();
                    }
                    else
                    {
                        // Handle case when no image is found
                    }
                }
                catch (Exception ex)
                {
                    // Handle exceptions
                }
            }
        }
    }
}
