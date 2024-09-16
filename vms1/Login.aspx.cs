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
    public partial class Login : System.Web.UI.Page
    {
        private readonly BSL.vms_LoginBSL loginBSL;

        public Login()
        {
            // Retrieve connection string and pass it to the business logic layer
            string connectionString = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;
            loginBSL = new BSL.vms_LoginBSL(connectionString);
        }
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void loginbtn_Click(object sender, EventArgs e)
        {
            try
            {
                string userid = txtUsername.Text;
                string password = txtPassword.Text;

                string userType, userName, email, plantCode;

                // Validate user using the business logic layer
                if (loginBSL.ValidateUser(userid, password, out userType, out userName, out email, out plantCode))
                {
                    // Set session variables for user details
                    Session["User_id"] = userid;
                    Session["User_type"] = userType;
                    Session["password"] = password;
                    Session["loginuser"] = userName;
                    Session["passmail"] = email;
                    Session["PlantCode"] = plantCode;

                    // Redirect based on user type
                    if (userType == "User")
                    {
                        Response.Redirect("Visitor_Dashboard.aspx");
                    }
                    else
                    {
                        Response.Redirect("Main_Dashboard.aspx");
                    }
                }
                else
                {
                    lblMessage.Text = "Invalid username or password!";
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "GeneralError", $"alert('An unexpected error occurred: {ex.Message}');", true);
            }
        }

        protected void registerbtn_Click(object sender, EventArgs e)
        {
            Response.Redirect("User_Registration.aspx");
        }
    }
}