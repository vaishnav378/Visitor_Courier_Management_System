using BSL;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace vms1
{
    public partial class COURIERINOUT : System.Web.UI.Page
    {
        Inwardcurrier_BLL inwardbll = new Inwardcurrier_BLL();
        Outwardcurrier_BLL bll = new Outwardcurrier_BLL();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                txt_plNTCODE.Text = (string)Session["PlantCode"];
                txt_userlogin.Text = (string)Session["loginuser"];
                BindGridView();
                BindGridViewICS();
            }
        }

        protected void InwardICSGridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string status = DataBinder.Eval(e.Row.DataItem, "Receipt_Status") as string;
                CheckBox chkReceiptStatus = e.Row.FindControl("chkReceiptStatus") as CheckBox;

                if (status == "Received")
                {
                    chkReceiptStatus.Checked = true;
                    chkReceiptStatus.Enabled = false;
                    e.Row.Cells[e.Row.Cells.Count - 1].ForeColor = System.Drawing.Color.Green;
                }
                else if (status == "Pending")
                {
                    chkReceiptStatus.Checked = false;
                    chkReceiptStatus.Enabled = true;
                    e.Row.Cells[e.Row.Cells.Count - 1].ForeColor = System.Drawing.Color.Red;
                }
                e.Row.Cells[e.Row.Cells.Count - 1].Font.Bold = true;
                e.Row.Cells[e.Row.Cells.Count - 1].Font.Name = "Times New Roman";
                e.Row.Cells[e.Row.Cells.Count - 1].Font.Size = FontUnit.Point(10);
            }
        }

        private void BindGridViewICS()
        {
            string receiverName = txt_userlogin.Text;

            if (!string.IsNullOrEmpty(receiverName))
            {
                DataTable dataTable = inwardbll.GetAllInwardCouriers(receiverName);
                InwardICSGridView1.DataSource = dataTable;
                InwardICSGridView1.DataBind();
            }
            else
            {
                InwardICSGridView1.DataSource = null;
                InwardICSGridView1.DataBind();
                // Optionally show a message like "No records found."
            }
        }
        /////////////////////////////////////////////////////////////////////////////////////////////////////
        ///


        ///////for check box only /////////////////////////////////////////////////////////////////

        protected void chkReceiptStatus_CheckedChanged(object sender, EventArgs e)
        {
            // Find the CheckBox that triggered the event
            CheckBox chkReceiptStatus = (CheckBox)sender;

            // Find the row that contains the CheckBox
            GridViewRow row = (GridViewRow)chkReceiptStatus.NamingContainer;

            // Get the Currier_Entry_No from the row
            string currierEntryNo = row.Cells[0].Text; // Adjust the index if needed

            // Update the database
            UpdateReceiptStatus(currierEntryNo);

            // Optionally, update the checkbox state or other UI elements directly
            // Example: If you need to disable the checkbox after update
            chkReceiptStatus.Enabled = false;

            // If you must re-bind the GridView, ensure to call BindGridViewICS method
            // BindGridViewICS();

            // Optionally, you can just update the particular row or control without re-binding the whole GridView.
        }


        //////////////////////////////////inward status check boxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

        private void UpdateReceiptStatus(string currierEntryNo)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "UPDATE InwardCourier SET Receipt_Status = 'Received' WHERE Currier_Entry_No = @CurrierEntryNo";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@CurrierEntryNo", currierEntryNo);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }


        /////////////////// ////////////////////////////////////////////////////////////////////////////
        ///
        public string GetReceiptStatus(object attachCourierReceipt)
        {
            string status = attachCourierReceipt == DBNull.Value ? "Pending" : "Outward";
            string color = status == "Outward" ? "green" : "red";
            return $"<span style='color:{color}; font-weight:bold; font-size:16px;'>{status}</span>";
        }

        protected void gvOutwardCouriers_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ViewImage")
            {
                string courierEntryNo = e.CommandArgument.ToString();
                Response.Redirect("image.aspx?CourierEntryNo=" + courierEntryNo);
            }
        }



        //***************************************
        //protected void gvOutwardCouriers_RowCommand(object sender, GridViewCommandEventArgs e)
        //{
        //    if (e.CommandName == "ViewImage")
        //    {
        //        string courierEntryNo = e.CommandArgument.ToString();
        //        string imageUrl = $"image.aspx?CourierEntryNo={courierEntryNo}";

        //        // Generate a JavaScript function call to check the image URL
        //        string script = $"checkImage('{imageUrl}');";
        //        ClientScript.RegisterStartupScript(this.GetType(), "CheckImage", script, true);
        //    }
        //}



        private void ClearFields()
        {
            txtInDate.Text = string.Empty;
            txtInTime.Text = string.Empty;
            txtSenderName.Text = string.Empty;
            txtCourierReceiverAddress.Text = string.Empty;
            txtReceiverCity.Text = string.Empty;
            ddlByMode.SelectedIndex = 0; // Assuming index 0 is the default "Select" option
            ddlReceiptPacking.SelectedIndex = 0;
            txtByMode.Text = string.Empty;
            txtReceiptPacking.Text = string.Empty;
            txtNoOfPacks.Text = string.Empty;
            txtValue.Text = string.Empty;
            // Ensure that any other form controls are also reset as needed
        }

        private void BindGridView()
        {
            //try
            //{
            DataTable dataTable = bll.GetSaveOutwardCouriers();
            gvOutwardCouriers.DataSource = dataTable;
            gvOutwardCouriers.DataBind();
            //}
            //catch (Exception ex)
            //{
            //    ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('An error occurred while retrieving data: {ex.Message}');", true);
            //}

        }
        protected void btnSave_Click1(object sender, EventArgs e)
        {
            try
            {
                string inDate = txtInDate.Text;
                string inTime = txtInTime.Text;
                string senderName = txtSenderName.Text;
                string receiverName = txtReceiverName.Text;
                string receiverAddress = txtCourierReceiverAddress.Text;
                string receiverCity = txtReceiverCity.Text;
                string byMode = ddlByMode.SelectedValue;
                string packingType = ddlReceiptPacking.SelectedValue;
                string value = txtValue.Text;

                string PlantNo = txt_plNTCODE.Text;

                string otherByMode = txtByMode.Text;
                string otherPackingType = txtReceiptPacking.Text;

                if ((byMode == "Other" && string.IsNullOrEmpty(otherByMode)) ||
                    (packingType == "Other" && string.IsNullOrEmpty(otherPackingType)) ||
                    string.IsNullOrEmpty(byMode) || byMode == "SELECT" ||
                    string.IsNullOrEmpty(packingType) || packingType == "SELECT")
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Please select valid values for all dropdowns and fill in other fields if selected.');", true);
                    return;
                }

                if (byMode == "Other") byMode = otherByMode;
                if (packingType == "Other") packingType = otherPackingType;

                if (string.IsNullOrWhiteSpace(inDate) || string.IsNullOrWhiteSpace(inTime) ||
                    string.IsNullOrWhiteSpace(senderName) || string.IsNullOrWhiteSpace(receiverName) ||
                    string.IsNullOrWhiteSpace(receiverAddress) || string.IsNullOrWhiteSpace(receiverCity) ||
                    string.IsNullOrWhiteSpace(byMode) || string.IsNullOrWhiteSpace(packingType) ||
                    string.IsNullOrWhiteSpace(value))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('All fields must be filled in correctly.');", true);
                    return;
                }

                if (!int.TryParse(txtNoOfPacks.Text, out int noOfPacks) || noOfPacks <= 0)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Please enter a valid number for No_of_Packs.');", true);
                    return;
                }

                try
                {
                    Outwardcurrier_BLL bll = new Outwardcurrier_BLL();
                    bll.SaveOutwardCourier(inDate, inTime, senderName, receiverName, receiverAddress, receiverCity, byMode, packingType, noOfPacks, value, PlantNo);

                    // Show success message and then redirect to prevent resubmission
                    string script = "alert('Data saved successfully!'); window.location='" + Request.Url.AbsoluteUri + "';";
                    ClientScript.RegisterStartupScript(this.GetType(), "redirect", script, true);
                }
                catch (Exception ex)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('An error occurred: {ex.Message}');", true);
                }
            }
            catch (ArgumentException ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('Error: {ex.Message}');", true);
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('An error occurred: {ex.Message}');", true);
            }
        }
        //private string GetImageUrl(string courierEntryNo)
        //{
        //    // Implement logic to get the image URL or path based on CourierEntryNo
        //    // This might involve querying the database or a predefined path
        //    // Example:
        //    // return $"~/Images/{courierEntryNo}.jpg";

        //    // Example implementation:
        //    // Assume images are stored in a specific folder
        //    return $"~/Images/{courierEntryNo}.jpg"; // Adjust this according to your image storage
        //}

    }
}