using BSL;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace vms1
{
    public partial class Registration : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;
        private vms_LoginBSL userBSL; // Business Logic Layer reference

        protected void Page_Load(object sender, EventArgs e)
        {
            userBSL = new vms_LoginBSL(connectionString);
            BindVisitorNames();

        }

        protected void btn_registerinvite_Click(object sender, EventArgs e)
        {
            string userId = txt_datetime.Text.Trim();
            string userName = txtVisitorName.Text.Trim();
            string mobileNo = txtMono.Text.Trim();
            string email = txt_Email.Text.Trim();
            string password = txt_Company.Text.Trim();
            string plantCode = txt_Plant.Text.Trim();
            string userType = ddl_usertype.Text.Trim();

            try
            {
                bool isSuccess = userBSL.RegisterUser(userId, userName, mobileNo, email, password, plantCode, userType);
                if (isSuccess)
                {
                    lbl_heading.Text = "User registered successfully!       Go to Login Page For Login";
                    lbl_heading.ForeColor = System.Drawing.Color.Green;
                }
                else
                {
                    lbl_heading.Text = "Error while registering the user.";
                    lbl_heading.ForeColor = System.Drawing.Color.Red;
                }
            }
            catch (Exception ex)
            {
                lbl_heading.Text = "An error occurred: " + ex.Message;
                lbl_heading.ForeColor = System.Drawing.Color.Red;
            }
        }


        private void BindVisitorNames()
        {
            rptVisitorNames.DataSource = userBSL.GetVisitorNames();
            rptVisitorNames.DataBind();
        }
        protected void txtVisitorName_TextChanged(object sender, EventArgs e)
        {
            string visitorName = txtVisitorName.Text.Trim();
            if (!string.IsNullOrEmpty(visitorName))
            {
                var userDetails = userBSL.GetUserDetailsByName(visitorName);
                if (userDetails != null)
                {
                    // Fill form fields with user data
                    txt_datetime.Text = userDetails.UserId;
                    txtMono.Text = userDetails.MobileNo;
                    txt_Email.Text = userDetails.Email;
                    txt_Company.Text = userDetails.Password;
                    txt_Plant.Text = userDetails.PlantCode;
                    ddl_usertype.SelectedValue = userDetails.UserType;
                }
                else
                {
                    //Btn_edit.Visible = false;
                }
            }
        }

        protected void Btn_edit_Click1(object sender, EventArgs e)
        {
            string userName = txtVisitorName.Text.Trim();
            if (!string.IsNullOrEmpty(userName))
            {
                bool isSuccess = userBSL.UpdateUser(
                    txtVisitorName.Text,
                    txt_Email.Text,
                    txtMono.Text,
                    txt_Company.Text,
                    ddl_usertype.SelectedValue,
                    txt_Plant.Text
                );

                if (isSuccess)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('User details updated successfully.');", true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Failed to update user details.');", true);
                }
            }
        }
    }
}