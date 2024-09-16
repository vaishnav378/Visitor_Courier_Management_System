using BSL;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace vms1
{
    public partial class Create_Department : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                txt_userlogin.Text = (string)Session["loginuser"];

            }
        }

        protected void Btn_save_Click(object sender, EventArgs e)
        {
            string departmentName = txteName.Text.Trim();

            if (!string.IsNullOrEmpty(departmentName))
            {
                try
                {
                    string connectionString = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;
                    DataService dataService = new DataService(connectionString);

                    bool isSaved = dataService.SaveDepartment(departmentName);

                    if (isSaved)
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('**** DEPARTMENT SAVED SUCCESSFULLY! ****');", true);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('**** FAILED TO SAVE DEPARTMENT! ****');", true);
                    }
                }
                catch (Exception ex)
                {
                    // Handle exception
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert", $"alert('An error occurred: {ex.Message}');", true);
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('**** PLEASE ENTER DEPARTMENT NAME. ****');", true);
            }
        }
    }
}