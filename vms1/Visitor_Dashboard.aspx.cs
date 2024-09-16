using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static BSL.VisitorBusinessLogic;
using System.Configuration;
using BSL;

namespace vms1
{
    public partial class Visitor_Dashboard : System.Web.UI.Page
    {
        private static readonly string ConnectionString = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;
        private readonly VisitorBusinessLogic _visitorBusinessLogic;

        public Visitor_Dashboard()
        {
            _visitorBusinessLogic = new VisitorBusinessLogic(ConnectionString);
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            txt_userlogin.Text = (string)Session["loginuser"];

            if (!IsPostBack)
            {
                BindGridView();
                BindGridView1();
                BindGridView2();
                BindGridView3();
            }
        }

        private void BindGridView()
        {
            string query = "SELECT token, Name, Whometo_Visit, Meet_DateTime, Total_Visitor " +
     "FROM Record " +
     "WHERE TRY_CONVERT(DATE, Meet_DateTime, 103) = CONVERT(DATE, GETDATE()) " + // 103 is the format for dd/MM/yyyy
     "AND TRY_CONVERT(TIME, Meet_DateTime, 103) > CAST(GETDATE() AS TIME) " +
     "AND IN_time IS NULL";

            using (SqlConnection connection = new SqlConnection(ConnectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    try
                    {
                        connection.Open();
                        System.Diagnostics.Trace.WriteLine("connection open ");

                        DataTable dataTable = new DataTable();
                        dataTable.Columns.Add("token", typeof(string));
                        dataTable.Columns.Add("Name", typeof(string));
                        dataTable.Columns.Add("Whometo_Visit", typeof(string));
                        dataTable.Columns.Add("Meet_DateTime", typeof(String));
                        dataTable.Columns.Add("Total_Visitor", typeof(int));
                        dataTable.Columns.Add("Person1", typeof(string));
                        dataTable.Columns.Add("Person2", typeof(string));
                        dataTable.Columns.Add("Person3", typeof(string));
                        dataTable.Columns.Add("Person4", typeof(string));
                        dataTable.Columns.Add("Person5", typeof(string));

                        SqlDataAdapter adapter = new SqlDataAdapter(command);

                        adapter.Fill(dataTable);

                        GridView1.DataSource = dataTable;
                        GridView1.DataBind();
                    }
                    catch (SqlException ex)
                    {
                        // Log detailed exception information
                        System.Diagnostics.Trace.WriteLine($"SQL Exception: {ex.Message}\nStackTrace: {ex.StackTrace}");

                        // Display user-friendly error message
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('An error occurred while retrieving data: {ex.Message}');", true);
                    }
                    catch (Exception ex)
                    {
                        // Handle other exceptions
                        System.Diagnostics.Trace.WriteLine($"Exception: {ex.Message}\nStackTrace: {ex.StackTrace}");

                        // Display user-friendly error message
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('An unexpected error occurred: {ex.Message}');", true);
                    }

                }
            }
        }

        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            BindGridView();
        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            if (e.RowIndex >= 0 && e.RowIndex < GridView1.Rows.Count)
            {
                GridViewRow row = GridView1.Rows[e.RowIndex];

                // Check if DataKeys and RowIndex are valid
                if (GridView1.DataKeys != null && e.RowIndex >= 0 && e.RowIndex < GridView1.DataKeys.Count)
                {
                    string token = GridView1.DataKeys[e.RowIndex].Values["token"].ToString();

                    // Access TextBoxes directly using FindControl
                    TextBox txtPerson1 = (TextBox)row.FindControl("txtPerson1");
                    TextBox txtPerson2 = (TextBox)row.FindControl("txtPerson2");
                    TextBox txtPerson3 = (TextBox)row.FindControl("txtPerson3");
                    TextBox txtPerson4 = (TextBox)row.FindControl("txtPerson4");
                    TextBox txtPerson5 = (TextBox)row.FindControl("txtPerson5");

                    string person1 = txtPerson1.Text.Trim();
                    string person2 = txtPerson2.Text.Trim();
                    string person3 = txtPerson3.Text.Trim();
                    string person4 = txtPerson4.Text.Trim();
                    string person5 = txtPerson5.Text.Trim();

                    // Construct the updated value for Person_Names
                    string personNames = string.Join(", ", new string[] { person1, person2, person3, person4, person5 }.Where(s => !string.IsNullOrEmpty(s)));

                    // Update the Record table
                    string updateQuery = "UPDATE Record SET Person_Names = @PersonNames WHERE token = @Token";

                    using (SqlConnection connection = new SqlConnection(ConnectionString))
                    {
                        using (SqlCommand command = new SqlCommand(updateQuery, connection))
                        {
                            command.Parameters.AddWithValue("@PersonNames", personNames);
                            command.Parameters.AddWithValue("@Token", token);

                            try
                            {
                                connection.Open();
                                int rowsAffected = command.ExecuteNonQuery();

                                // Optionally, check rowsAffected to ensure the update was successful
                                if (rowsAffected > 0)
                                {


                                    // Hide textboxes after successful update
                                    txtPerson1.Visible = false;
                                    txtPerson2.Visible = false;
                                    txtPerson3.Visible = false;
                                    txtPerson4.Visible = false;
                                    txtPerson5.Visible = false;

                                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Data updated successfully!');", true);
                                }
                                else
                                {
                                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('No rows were updated. Please check your data.');", true);
                                }
                            }
                            catch (SqlException ex)
                            {
                                // Handle SQL exception
                                System.Diagnostics.Trace.WriteLine($"SQL Exception: {ex.Message}\nStackTrace: {ex.StackTrace}");
                                ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('An error occurred while updating data: {ex.Message}');", true);
                            }
                            finally
                            {
                                connection.Close();
                            }
                        }
                    }
                }
                else
                {
                    // Handle case where DataKeys or RowIndex is invalid
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Invalid row index or data keys.');", true);
                }
            }
            else
            {
                // Handle case where RowIndex is out of range
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Invalid row index.');", true);
            }
        }


        protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            BindGridView();
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // Get the Total_Visitor value for the current row
                int totalVisitors = Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "Total_Visitor"));

                // Show or hide columns based on the Total_Visitor value
                e.Row.Cells[5].Visible = totalVisitors >= 1; // Person1
                e.Row.Cells[6].Visible = totalVisitors >= 2; // Person2
                e.Row.Cells[7].Visible = totalVisitors >= 3; // Person3
                e.Row.Cells[8].Visible = totalVisitors >= 4; // Person4
                e.Row.Cells[9].Visible = totalVisitors >= 5; // Person5
            }
        }

        private void BindGridView1()
        {
            DataTable dataTable = _visitorBusinessLogic.GetVisitorStatus();
            GridView2.DataSource = dataTable;
            GridView2.DataBind();
        }

        private void BindGridView2()
        {
            DataTable dataTable = _visitorBusinessLogic.GetVisitorWithOutTime();
            GridView3.DataSource = dataTable;
            GridView3.DataBind();
        }

        private void BindGridView3()
        {
            DataTable dataTable = _visitorBusinessLogic.GetPastVisitor();
            GridView4.DataSource = dataTable;
            GridView4.DataBind();
        }
    }
}