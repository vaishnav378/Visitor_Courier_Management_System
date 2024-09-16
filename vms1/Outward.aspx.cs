using BSL;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace vms1
{
    public partial class Outward : System.Web.UI.Page
    {
        string connectionString = "Server=sql.bsite.net\\MSSQL2016;Database=developer17_; User ID=developer17_; Password=Pass@123;";

        Outwardcurriergv2_BLL bll = new Outwardcurriergv2_BLL();

        protected void Page_Load(object sender, EventArgs e)
        {
            txt_userlogin.Text = (string)Session["loginuser"];

            if (!IsPostBack)
            {
                BindGridViewOutwardGridUpdate();
                BindGridView2status();
            }
        }
        private void BindGridViewOutwardGridUpdate()
        {
            try
            {
                DataTable dataTable = bll.GetSaveOutwardCouriers();
                OutwardGridUpdate.DataSource = dataTable;
                OutwardGridUpdate.DataBind();
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('An error occurred while retrieving data: {ex.Message}');", true);
            }
        }

        //for enable the field  in grid viewwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww
        protected void OutwardGridUpdate_RowEditing(object sender, GridViewEditEventArgs e)
        {
            try
            {
                // Set the row to edit mode
                OutwardGridUpdate.EditIndex = e.NewEditIndex;

                // Rebind the GridView to reflect the edit mode
                BindGridViewOutwardGridUpdate();

                // Ensure the GridView has the row we want to edit
                GridViewRow row = OutwardGridUpdate.Rows[e.NewEditIndex];
                if (row != null)
                {
                    // Find controls within the editing row
                    DropDownList ddlCourierAgency = row.FindControl("ddlCourier_Agency") as DropDownList;
                    TextBox txtOtherAgency = row.FindControl("txtOtherAgency") as TextBox;
                    TextBox txtDocketNumber = row.FindControl("txtDocket_Number") as TextBox;
                    TextBox txtOutDate = row.FindControl("txtCourier_Out_Date") as TextBox;
                    TextBox txtOutTime = row.FindControl("txtCourier_Out_Time") as TextBox;

                    // Check if the DropDownList is null and handle it
                    if (ddlCourierAgency != null)
                    {
                        // Enable or disable the 'Other' agency text box based on selected value
                        txtOtherAgency.Enabled = ddlCourierAgency.SelectedValue == "Other";
                    }

                    // Enable other text boxes for editing
                    if (txtDocketNumber != null) txtDocketNumber.Enabled = true;
                    if (txtOutDate != null) txtOutDate.Enabled = true;
                    if (txtOutTime != null) txtOutTime.Enabled = true;
                }
            }
            catch (Exception ex)
            {
                // Log and handle exceptions
                ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('An error occurred while entering edit mode: {ex.Message}');", true);
            }
        }



        protected void ddlCourier_Agency_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList ddlCourier_Agency = (DropDownList)sender;
            GridViewRow row = (GridViewRow)ddlCourier_Agency.NamingContainer;
            TextBox txtOtherAgency = (TextBox)row.FindControl("txtOtherAgency");

            if (ddlCourier_Agency.SelectedValue == "Other")
            {
                txtOtherAgency.Enabled = true;
                txtOtherAgency.Visible = true;
            }
            else
            {
                txtOtherAgency.Enabled = false;
                txtOtherAgency.Visible = false;
            }
        }

        //protected void OutwardGridUpdate_RowUpdating(object sender, GridViewUpdateEventArgs e)
        //{
        //    GridViewRow row = OutwardGridUpdate.Rows[e.RowIndex];
        //    string courierEntryNo = OutwardGridUpdate.DataKeys[e.RowIndex].Value.ToString();
        //    string editstatus = "Updated";

        //    string courierAgency = "";
        //    DropDownList ddlCourier_Agency = (DropDownList)row.FindControl("ddlCourier_Agency");
        //    TextBox txtOtherAgency = (TextBox)row.FindControl("txtOtherAgency");

        //    if (ddlCourier_Agency.SelectedValue == "Other" && txtOtherAgency != null)
        //    {
        //        courierAgency = txtOtherAgency.Text;
        //    }
        //    else if (ddlCourier_Agency != null)
        //    {
        //        courierAgency = ddlCourier_Agency.SelectedValue;
        //    }

        //    string docketNumber = ((TextBox)row.FindControl("txtDocket_Number")).Text;
        //    string courierOutDate = ((TextBox)row.FindControl("txtCourier_Out_Date")).Text;
        //    string courierOutTime = ((TextBox)row.FindControl("txtCourier_Out_Time")).Text;

        //    using (SqlConnection connection = new SqlConnection(connectionString))
        //    {
        //        using (SqlCommand command = new SqlCommand("UpdateOutwardCourier", connection))
        //        {
        //            command.CommandType = CommandType.StoredProcedure;
        //            command.Parameters.AddWithValue("@CourierEntryNo", courierEntryNo);
        //            command.Parameters.AddWithValue("@CourierAgency", courierAgency);
        //            command.Parameters.AddWithValue("@DocketNumber", docketNumber);
        //            command.Parameters.AddWithValue("@CourierOutDate", courierOutDate);
        //            command.Parameters.AddWithValue("@CourierOutTime", courierOutTime);
        //            command.Parameters.AddWithValue("@EditStatus", editstatus);

        //            try
        //            {
        //                connection.Open();
        //                int rowsAffected = command.ExecuteNonQuery();
        //                if (rowsAffected > 0)
        //                {
        //                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Data updated successfully!');", true);
        //                }
        //                else
        //                {
        //                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('No rows were updated.');", true);
        //                }
        //            }
        //            catch (SqlException ex)
        //            {
        //                System.Diagnostics.Trace.WriteLine($"SQL Exception: {ex.Message}\nStackTrace: {ex.StackTrace}");
        //                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", $"alert('An error occurred while updating data: {ex.Message}');", true);
        //            }
        //            catch (Exception ex)
        //            {
        //                System.Diagnostics.Trace.WriteLine($"Exception: {ex.Message}\nStackTrace: {ex.StackTrace}");
        //                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", $"alert('An unexpected error occurred: {ex.Message}');", true);
        //            }
        //        }
        //    }

        //    OutwardGridUpdate.EditIndex = -1;
        //    BindGridViewOutwardGridUpdate();
        //}

        protected void OutwardGridUpdate_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow row = OutwardGridUpdate.Rows[e.RowIndex];
            string courierEntryNo = OutwardGridUpdate.DataKeys[e.RowIndex].Value.ToString();
            string editstatus = "Updated";

            // Validate Dropdown and TextBox
            DropDownList ddlCourier_Agency = (DropDownList)row.FindControl("ddlCourier_Agency");
            TextBox txtOtherAgency = (TextBox)row.FindControl("txtOtherAgency");
            string courierAgency = "";

            if (ddlCourier_Agency.SelectedValue == "Other")
            {
                if (txtOtherAgency != null && string.IsNullOrWhiteSpace(txtOtherAgency.Text))
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Other agency field cannot be empty.');", true);
                    return;
                }
                courierAgency = txtOtherAgency.Text;
            }
            else if (ddlCourier_Agency != null)
            {
                if (string.IsNullOrWhiteSpace(ddlCourier_Agency.SelectedValue))
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Courier Agency is required.');", true);
                    return;
                }
                courierAgency = ddlCourier_Agency.SelectedValue;
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Courier Agency is required.');", true);
                return;
            }

            // Validate other fields
            string docketNumber = ((TextBox)row.FindControl("txtDocket_Number")).Text;
            string courierOutDate = ((TextBox)row.FindControl("txtCourier_Out_Date")).Text;
            string courierOutTime = ((TextBox)row.FindControl("txtCourier_Out_Time")).Text;

            if (string.IsNullOrWhiteSpace(docketNumber))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Docket Number cannot be empty.');", true);
                return;
            }
            if (string.IsNullOrWhiteSpace(courierOutDate))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Out Date cannot be empty.');", true);
                return;
            }
            if (string.IsNullOrWhiteSpace(courierOutTime))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Out Time cannot be empty.');", true);
                return;
            }

            // Update database
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("UpdateOutwardCourier", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@CourierEntryNo", courierEntryNo);
                    command.Parameters.AddWithValue("@CourierAgency", courierAgency);
                    command.Parameters.AddWithValue("@DocketNumber", docketNumber);
                    command.Parameters.AddWithValue("@CourierOutDate", courierOutDate);
                    command.Parameters.AddWithValue("@CourierOutTime", courierOutTime);
                    command.Parameters.AddWithValue("@EditStatus", editstatus);

                    try
                    {
                        connection.Open();
                        int rowsAffected = command.ExecuteNonQuery();
                        if (rowsAffected > 0)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Data updated successfully!');", true);
                        }
                        //else
                        //{
                        //    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('No rows were updated.');", true);
                        //}
                    }
                    catch (SqlException ex)
                    {
                        System.Diagnostics.Trace.WriteLine($"SQL Exception: {ex.Message}\nStackTrace: {ex.StackTrace}");
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", $"alert('An error occurred while updating data: {ex.Message}');", true);
                    }
                    catch (Exception ex)
                    {
                        System.Diagnostics.Trace.WriteLine($"Exception: {ex.Message}\nStackTrace: {ex.StackTrace}");
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", $"alert('An unexpected error occurred: {ex.Message}');", true);
                    }
                }
            }

            // Exit edit mode and rebind data
            OutwardGridUpdate.EditIndex = -1;
            BindGridViewOutwardGridUpdate();
        }


        ///btnUpload_Clickkkkkkkkkkkkkkkkkkkkkkkkk      kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk
        protected void btnUpload_Click(object sender, EventArgs e)
        {
            Button btnUpload = sender as Button;
            if (btnUpload == null)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Button control not found.');", true);
                return;
            }

            GridViewRow row = btnUpload.NamingContainer as GridViewRow;
            if (row == null)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('GridViewRow not found.');", true);
                return;
            }

            FileUpload fileUpload = row.FindControl("fileUpload") as FileUpload;
            if (fileUpload == null)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('FileUpload control not found.');", true);
                return;
            }

            if (fileUpload.HasFile)
            {
                byte[] fileData;
                using (BinaryReader reader = new BinaryReader(fileUpload.PostedFile.InputStream))
                {
                    fileData = reader.ReadBytes(fileUpload.PostedFile.ContentLength);
                }

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("UploadFile", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@FileData", SqlDbType.VarBinary).Value = fileData;
                        cmd.Parameters.AddWithValue("@CourierEntryNo", OutwardGridUpdate.DataKeys[row.RowIndex].Value);
                        cmd.Parameters.AddWithValue("@Status", "Updated");

                        try
                        {
                            conn.Open();
                            cmd.ExecuteNonQuery();
                            conn.Close();

                            ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('File uploaded successfully.');", true);
                        }
                        catch (SqlException ex)
                        {
                            System.Diagnostics.Trace.WriteLine($"SQL Exception: {ex.Message}\nStackTrace: {ex.StackTrace}");
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", $"alert('An error occurred while uploading file: {ex.Message}');", true);
                        }
                        catch (Exception ex)
                        {
                            System.Diagnostics.Trace.WriteLine($"Exception: {ex.Message}\nStackTrace: {ex.StackTrace}");
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", $"alert('An unexpected error occurred: {ex.Message}');", true);
                        }
                    }
                }
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('No file selected.');", true);
            }
        }





        //for the Receipt   statussssssssssssssssssssssssssssssssssssssssssssssss
        /////////////////////////////////////////////////////////////////////////////////////////////////////






        protected string GetReceiptStatusText(object receiptStatus, object editStatus)
        {
            string receipt = receiptStatus != DBNull.Value ? receiptStatus.ToString() : "";
            string edit = editStatus != DBNull.Value ? editStatus.ToString() : "";

            if (receipt == "Updated" && edit == "Updated")
            {
                return "Outward";
            }
            else
            {
                return "Pending";
            }
        }
        protected string GetReceiptStatusCssClass(object receiptStatus, object editStatus)
        {
            string receipt = receiptStatus != DBNull.Value ? receiptStatus.ToString() : "";
            string edit = editStatus != DBNull.Value ? editStatus.ToString() : "";

            if (receipt == "Updated" && edit == "Updated")
            {
                return "receipt-status-outward";
            }
            else
            {
                return "receipt-status-pending";
            }
        }

        /////////////////////////////////////////////////////////////////////////////////////////////////////
        ///










        private void BindGridView2status()
        {
            string procedureName = "usp_GetOutwardCourierData";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(procedureName, connection))
                {
                    command.CommandType = CommandType.StoredProcedure;

                    connection.Open();

                    DataTable dt = new DataTable();
                    using (SqlDataAdapter adapter = new SqlDataAdapter(command))
                    {
                        adapter.Fill(dt);
                    }

                    GridView2.DataSource = dt;
                    GridView2.DataBind();
                }
            }
        }

        protected void GridView2_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ViewImage")
            {
                string courierEntryNo = e.CommandArgument.ToString();
                Response.Redirect("image.aspx?CourierEntryNo=" + courierEntryNo);
            }
        }





        /*######################for image not preset popup ######################*/

        //protected void GridView2_RowCommand(object sender, GridViewCommandEventArgs e)
        //{
        //    if (e.CommandName == "ViewImage")
        //    {
        //        string courierEntryNo = e.CommandArgument.ToString();
        //        string url = "image.aspx?CourierEntryNo=" + courierEntryNo;
        //        ScriptManager.RegisterStartupScript(this, GetType(), "CheckImage", "checkImage('" + url + "');", true);
        //    }
        //}


        protected string GetReceiptStatusText1(object receiptStatus, object editStatus)
        {
            string receipt = receiptStatus != DBNull.Value ? receiptStatus.ToString() : "";
            string edit = editStatus != DBNull.Value ? editStatus.ToString() : "";

            if (receipt == "Updated" && edit == "Updated")
            {
                return "Outward";
            }
            else
            {
                return "Pending";
            }
        }
        protected string GetReceiptStatusCssClass2(object receiptStatus, object editStatus)
        {
            string receipt = receiptStatus != DBNull.Value ? receiptStatus.ToString() : "";
            string edit = editStatus != DBNull.Value ? editStatus.ToString() : "";

            if (receipt == "Updated" && edit == "Updated")
            {
                return "receipt-status-outward";
            }
            else
            {
                return "receipt-status-pending";
            }
        }

        ///for hide outward status in grid 1st 
        protected void OutwardGridUpdate_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            // Check if the row is a data row (not header or footer)
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // Find the Receipt Status label
                Label lblReceiptStatus = e.Row.FindControl("lblReceiptStatus") as Label;

                if (lblReceiptStatus != null && lblReceiptStatus.Text == "Outward")
                {
                    // Hide the row if the status is "Outward"
                    e.Row.Visible = false;
                }
            }
        }




        ////cancle
        ///

        protected void OutwardGridUpdate_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            // Exit edit mode and rebind data
            OutwardGridUpdate.EditIndex = -1;
            BindGridViewOutwardGridUpdate();
        }


    }
}