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
    public partial class Main_Dashboard : System.Web.UI.Page
    {
        private DataService _dataService;
        protected void Page_Load(object sender, EventArgs e)
        {

            txt_userlogin.Text = (string)Session["loginuser"];

            // Get the connection string and initialize the DataService
            string connectionString = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;
            _dataService = new DataService(connectionString);

            // Check the user's type
            string userType = (string)Session["User_type"];
            if (userType != null)
            {
                if (userType.Equals("SupperAdmin", StringComparison.OrdinalIgnoreCase))
                {
                    // If the user is SupperAdmin, show all panels
                    panel_MainDashboard.Visible = true;
                    panel_Report.Visible = true;
                    panel_InviteVisitor.Visible = true;
                    panel_ConfirmMeeting.Visible = true;
                    panel_CourierInOut.Visible = true;
                    panel_CreateDepartment.Visible = true;
                    panel_visitor.Visible = true;
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
                    panel_visitor.Visible = true;
                    panel_Report.Visible=true;
                }
                else
                {
                    // If the user is not SupperAdmin, show only the specified panels
                    panel_MainDashboard.Visible = true;
                    panel_Report.Visible = true;
                    panel_InviteVisitor.Visible = true;
                    panel_ConfirmMeeting.Visible = true;
                    panel_CourierInOut.Visible = true;

                    // Hide any other panels that might exist
                    panel_CreateDepartment.Visible = false;
                    panel_visitor.Visible = false;
                }
            }
            else
            {
                Response.Redirect("Login.aspx");
            }

            // Load data on first page load
            if (!IsPostBack)
            {
                LoadChartData();
                LoadTotalVisitors();
                LoadVisitorsThisMonth();
                LoadBounceRate();
                LoadVisitorDetails();
                LoadVisitorMonthDetails();
                LoadBounceRateDetails();
                LoadEmployeeRate();
            }
        }

        private void LoadTotalVisitors()
        {
            lbl_TotalVisitors.Text = _dataService.GetTotalVisitors().ToString();
        }

        private void LoadVisitorDetails()
        {
            rpt_VisitorDetails.DataSource = _dataService.GetVisitorDetails();
            rpt_VisitorDetails.DataBind();
        }

        private void LoadVisitorsThisMonth()
        {
            lbl_VisitorsThisMonth.Text = _dataService.GetVisitorsThisMonth().ToString();
        }

        private void LoadVisitorMonthDetails()
        {
            rpt_VisitorMonthDetails.DataSource = _dataService.GetVisitorsThisMonthDetails();
            rpt_VisitorMonthDetails.DataBind();
        }

        private void LoadBounceRate()
        {
            lbl_BounceRate.Text = _dataService.GetBounceRate().ToString();
        }

        private void LoadEmployeeRate()
        {
            rpt_EmployeeRateDetails.DataSource = _dataService.GetEmployeeRate();
            rpt_EmployeeRateDetails.DataBind();
        }

        private void LoadBounceRateDetails()
        {
            var bounceRateDetails = _dataService.GetBounceRateDetails();
            rpt_BounceRateDetails.DataSource = bounceRateDetails;
            rpt_BounceRateDetails.DataBind();
        }

        private void LoadChartData()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;
            string query = "SELECT CONVERT(VARCHAR, Date_Time, 23) AS VisitDate, COUNT(*) as VisitorCount FROM [Record] WHERE MONTH(Date_Time) = @CurrentMonth AND YEAR(Date_Time) = @CurrentYear GROUP BY CONVERT(VARCHAR, Date_Time, 23) ORDER BY VisitDate";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@CurrentMonth", DateTime.Now.Month);
                command.Parameters.AddWithValue("@CurrentYear", DateTime.Now.Year);

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                List<string> visitDates = new List<string>();
                List<int> visitorCounts = new List<int>();

                while (reader.Read())
                {
                    visitDates.Add(reader["VisitDate"].ToString());
                    visitorCounts.Add(Convert.ToInt32(reader["VisitorCount"]));
                }

                // Pass the data to the front end
                string visitDatesJson = Newtonsoft.Json.JsonConvert.SerializeObject(visitDates);
                string visitorCountsJson = Newtonsoft.Json.JsonConvert.SerializeObject(visitorCounts);

                ClientScript.RegisterStartupScript(this.GetType(), "chartData", $"var visitDates = {visitDatesJson}; var visitorCounts = {visitorCountsJson};", true);
            }
        }

    }
}