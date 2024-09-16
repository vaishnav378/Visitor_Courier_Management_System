using BSL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DBL;

namespace vms1
{
    public partial class Report : System.Web.UI.Page
    {
        private readonly DataService _dataService;

        public Report()
        {
            _dataService = new DataService(System.Configuration.ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString);
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            string userType = (string)Session["User_type"];
            if (userType != null)
            {
                if (userType.Equals("SupperAdmin", StringComparison.OrdinalIgnoreCase))
                {
                    // If the user is SupperAdmin, show all panels
                    panel_MainDashboard.Visible = true;
                    panel_InviteVisitor.Visible = true;
                    panel_ConfirmMeeting.Visible = true;
                    panel_CourierInOut.Visible = true;
                    panel_CreateDepartment.Visible = true;
                    panel_Visitor.Visible = true;
                    panel_Outward.Visible = false;
                    panel_Inward.Visible = false;
                }
                else if (userType.Equals("User", StringComparison.OrdinalIgnoreCase))
                {
                    // If the user is not SupperAdmin, show only the specified panels
                    panel_MainDashboard.Visible = false;
                    panel_InviteVisitor.Visible = false;
                    panel_ConfirmMeeting.Visible = false;
                    panel_CourierInOut.Visible = false;

                    // Hide any other panels that might exist
                    panel_CreateDepartment.Visible = false;
                    panel_Inward.Visible = true;
                    panel_Outward.Visible = true;
                }
                else if (userType.Equals("Admin", StringComparison.OrdinalIgnoreCase))
                {
                    panel_ConfirmMeeting.Visible = true;
                    panel_CourierInOut.Visible = true;
                    panel_CreateDepartment.Visible = false;
                    panel_InviteVisitor.Visible = true;
                    panel_Inward.Visible = false;
                    panel_MainDashboard.Visible = true;
                    panel_Outward.Visible = false;
                    panel_Visitor.Visible = false;
                }
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
            if (!IsPostBack)
            {
                LoadVisitorNames1();
                LoadMobileNumbers();
                LoadMeetingWith();
                LoadPlants();

                txt_userlogin.Text = (string)Session["loginuser"];
            }
        }

        private void LoadVisitorNames1()
        {
            DataTable dt = _dataService.GetVisitorNames();
            rptVisitorNames.DataSource = dt;
            rptVisitorNames.DataBind();
        }

        private void LoadMobileNumbers()
        {
            DataTable dt = _dataService.GetMobileNumbers();
            rptMobileNumbers.DataSource = dt;
            rptMobileNumbers.DataBind();
        }

        private void LoadMeetingWith()
        {
            DataTable dt = _dataService.GetMeetingWith();
            rptMeetingWith.DataSource = dt;
            rptMeetingWith.DataBind();
        }

        private void LoadPlants()
        {
            DataTable dt = _dataService.GetPlants();
            rptPlants.DataSource = dt;
            rptPlants.DataBind();
        }
        protected void btn_search_Click(object sender, EventArgs e)
        {
            string visitorName = txtVisitorName.Text.Trim();
            string mobileNumber = txtMobileNumber.Text.Trim();
            string meetingWith = txtMeetingWith.Text.Trim();
            string dateFrom = txt_dateFrom.Text;
            string dateTo = txt_dateTo.Text;
            string inTime = txt_inTime.Text.Trim();
            string outTime = txt_outTime.Text.Trim();
            string plantNo = txtPlant.Text.Trim();

            DateTime? fromDate = null;
            DateTime? toDate = null;

            if (DateTime.TryParse(dateFrom, out DateTime parsedFromDate))
            {
                fromDate = parsedFromDate;
            }

            if (DateTime.TryParse(dateTo, out DateTime parsedToDate))
            {
                toDate = parsedToDate;
            }

            TimeSpan? inTimeSpan = null;
            TimeSpan? outTimeSpan = null;

            if (TimeSpan.TryParse(inTime, out TimeSpan parsedInTime))
            {
                inTimeSpan = parsedInTime;
            }

            if (TimeSpan.TryParse(outTime, out TimeSpan parsedOutTime))
            {
                outTimeSpan = parsedOutTime;
            }

            DataTable dtRecords = _dataService.GetRecords(visitorName, mobileNumber, meetingWith, fromDate, toDate, inTimeSpan, outTimeSpan, plantNo);


            if (dtRecords.Rows.Count > 0)
            {
                gvRecords.DataSource = dtRecords;
                gvRecords.DataBind();
            }
            else
            {
                string script = "alert('No records found.');";
                ClientScript.RegisterStartupScript(this.GetType(), "NoRecords", script, true);
            }
        }
    }
}