using BSL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace vms1
{
    public partial class Inward : System.Web.UI.Page
    {
        Inwardcurrier_BLL bll = new Inwardcurrier_BLL();
        protected void Page_Load(object sender, EventArgs e)
        {
            txt_userlogin.Text = (string)Session["loginuser"];

            if (!IsPostBack)
            {
                //BindReceiverNames();
                BindGridView();
                GetReceiverNames();
            }
        }
        protected void btnSave_Click1(object sender, EventArgs e)
        {
            try
            {
                // Retrieve form data
                string inDate = txtInDate.Text;
                string inTime = txtInTime.Text;
                string courierAgency = ddlCourierAgency.SelectedValue;
                string senderCity = ddlSenderCity.SelectedValue;
                string byMode = ddlByMode.SelectedValue;
                string receiptPacking = ddlReceiptPacking.SelectedValue;

                // Handle "Other" selections
                string otherCourierAgency = txtCourierAgency.Text;
                string otherSenderCity = txtSenderCity.Text;
                string otherByMode = txtByMode.Text;
                string otherReceiptPacking = txtReceiptPacking.Text;

                // Validate that the selected values are not the same or null
                if ((courierAgency == "Other" && string.IsNullOrEmpty(otherCourierAgency)) ||
                    (senderCity == "Other" && string.IsNullOrEmpty(otherSenderCity)) ||
                    (byMode == "Other" && string.IsNullOrEmpty(otherByMode)) ||
                    (receiptPacking == "Other" && string.IsNullOrEmpty(otherReceiptPacking)) ||
                    courierAgency == null || courierAgency == "Select" ||
                    senderCity == null || senderCity == "Select" ||
                    byMode == null || byMode == "Select" ||
                    receiptPacking == null || receiptPacking == "Select")
                {
                    Response.Write("<script>alert('Please select valid values for all dropdowns and fill in other fields if selected.');</script>");
                    return;
                }

                // Use the "Other" value if provided
                if (courierAgency == "Other") courierAgency = otherCourierAgency;
                if (senderCity == "Other") senderCity = otherSenderCity;
                if (byMode == "Other") byMode = otherByMode;
                if (receiptPacking == "Other") receiptPacking = otherReceiptPacking;

                // Check if any selected dropdown value is a duplicate
                var selectedValues = new HashSet<string> { courierAgency, senderCity, byMode, receiptPacking };
                if (selectedValues.Count < 4)
                {
                    Response.Write("<script>alert('Please ensure all selected values are unique.');</script>");
                    return;
                }

                string docketNumber = txtDocketNumber.Text;
                string senderName = txtSenderName.Text;
                int noOfPacks = int.Parse(txtNoOfPacks.Text);
                string receiverName = DropDownList1.Text; // Use Text to get the value from asp:TextBox
                string remark = txtRemark.Text;

                // Call the BLL method to save data
                bll.SaveInwardCourier(inDate, inTime, courierAgency, docketNumber, senderName, senderCity, byMode, receiptPacking, noOfPacks, receiverName, remark);

                // Show success message and then redirect
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Data saved successfully!'); window.location='" + Request.RawUrl + "';", true);
            }
            catch (ArgumentException ex)
            {
                // Show validation error messages to the user
                Response.Write($"<script>alert('Error: {ex.Message}');</script>");
            }
            catch (Exception ex)
            {
                // Handle other exceptions
                Response.Write($"<script>alert('An error occurred: {ex.Message}');</script>");
            }
        }

        private void ClearFields()
        {
            txtInDate.Text = string.Empty;
            txtInTime.Text = string.Empty;
            ddlCourierAgency.SelectedIndex = 0; // Assuming index 0 is the default "Select" option
            ddlSenderCity.SelectedIndex = 0;
            ddlByMode.SelectedIndex = 0;
            ddlReceiptPacking.SelectedIndex = 0;
            txtCourierAgency.Text = string.Empty;
            txtSenderCity.Text = string.Empty;
            txtByMode.Text = string.Empty;
            txtReceiptPacking.Text = string.Empty;
            txtDocketNumber.Text = string.Empty;
            txtSenderName.Text = string.Empty;
            txtNoOfPacks.Text = string.Empty;
            DropDownList1.Text = string.Empty;
            txtRemark.Text = string.Empty;
        }



        private void BindGridView()
        {
            try
            {
                DataTable dataTable = bll.GetAllInwardCouriers(); // Call method without parameters
                gvInwardCouriers.DataSource = dataTable;
                gvInwardCouriers.DataBind();
            }
            catch (Exception ex)
            {
                // Handle exceptions (logging, displaying error messages, etc.)
                ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('An error occurred while retrieving data: {ex.Message}');", true);
            }
        }

        protected string GetReceiptStatusCssClass(string receiptStatus)
        {
            if (receiptStatus == "Received") // Replace with your actual condition
            {
                return "receipt-status-Received";
            }
            else
            {
                return "receipt-status-pending";
            }
        }




        private void GetReceiverNames()
        {
            try
            {
                DataTable dataTable = bll.GetVisitorNames();
                DropDownList1.DataSource = dataTable;
                DropDownList1.DataTextField = "User_Name"; // Name of the column to display in the listbox
                DropDownList1.DataValueField = "User_Name"; // Value to be used for selection
                DropDownList1.DataBind();

                // Insert a default item at the first position
                DropDownList1.Items.Insert(0, new ListItem("Select a user", ""));
            }
            catch (Exception ex)
            {
                // Handle exceptions (logging, displaying error messages, etc.)
                ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('An error occurred while retrieving data: {ex.Message}');", true);
            }
        }
    }
}