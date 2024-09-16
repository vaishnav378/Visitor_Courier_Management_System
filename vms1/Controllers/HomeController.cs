using System;
using System.Collections.Generic;
using System.Drawing.Imaging;
using System.Drawing;
using System.Linq;
using System.Net.NetworkInformation;
using System.Web;
using System.Web.Mvc;
using ZXing;
using ZXing.Common;
using System.Data.SqlClient;
using System.Web.WebPages;
using System.Xml.Linq;
using System.Diagnostics;
using System.Net.Mail;
using System.Net;
using System.Web.UI;
using System.Configuration;

namespace vms1.Controllers
{
    public class HomeController : Controller
    {
        private readonly string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;

        private String SENDER_EMAIL = "lakhanbairagi378@gmail.com";
        private String SENDER_PASSWORD = "gxvx tbrp uwex mwjb";
        private static string SUBJECT_ENTRY = "Visitor Entry Notification";
        private static string SUBJECT_EXIT = "Visitor Exit Notification";

        //public ActionResult Index()
        //{
        //    return View();
        //}

        //public ActionResult About()
        //{
        //    ViewBag.Message = "Your application description page.";

        //    return View();
        //}

        //public ActionResult Contact()
        //{
        //    ViewBag.Message = "Your contact page.";

        //    return View();
        //}

        [HttpPost]
        public ActionResult SaveQRData(string qrData)
        {
            System.Diagnostics.Trace.WriteLine("this is qr data" + qrData);
            Trace.WriteLine($"method called " + qrData);
            var tokenfromqr = qrData.Split('/');
            Trace.WriteLine($"array length {tokenfromqr.Length}");

            string Token = tokenfromqr[7];
            TimeSpan currentTime = DateTime.Now.TimeOfDay;
            string formattedTime = currentTime.ToString("hh\\:mm");
            Trace.WriteLine($"token from controller = {Token}");

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string queryCheck = "SELECT IN_time, OUT_time, confirmation, Email, Whometo_Visit FROM Record WHERE token = @token";
                    string queryInsert = "UPDATE Record SET IN_time = @time WHERE token = @token";
                    string queryUpdateOutTime = "UPDATE Record SET OUT_time = @time WHERE token = @token";
                    string queryUpdateErrorFlag = "UPDATE Record SET error_flag = 1 WHERE token = @token";

                    connection.Open();
                    SqlCommand commandCheck = new SqlCommand(queryCheck, connection);
                    commandCheck.Parameters.AddWithValue("@token", Token);
                    SqlDataReader reader = commandCheck.ExecuteReader();

                    if (reader.Read())
                    {
                        string visitorEmail = reader["Email"].ToString();
                        string employeeName = reader["Whometo_Visit"].ToString();
                        string employeeEmail = GetEmployeeEmail(employeeName);

                        if (string.IsNullOrEmpty(employeeEmail))
                        {
                            return Content("**** EMPLOYEE EMAIL NOT FOUND ****", "text/plain");
                        }

                        if (reader.IsDBNull(0))
                        {
                            reader.Close();
                            SqlCommand commandInsert = new SqlCommand(queryInsert, connection);
                            commandInsert.Parameters.AddWithValue("@time", formattedTime);
                            commandInsert.Parameters.AddWithValue("@token", Token);
                            commandInsert.ExecuteNonQuery();

                            // Send entry email notification
                            SendEmail(employeeEmail, visitorEmail, employeeName, true);

                            return Content("**** VISITOR ENTRY SUCCESSFUL ****", "text/plain");
                        }

                        if (!reader.IsDBNull(2))
                        {
                            reader.Close();
                            SqlCommand commandUpdateOutTime = new SqlCommand(queryUpdateOutTime, connection);
                            commandUpdateOutTime.Parameters.AddWithValue("@time", formattedTime);
                            commandUpdateOutTime.Parameters.AddWithValue("@token", Token);
                            commandUpdateOutTime.ExecuteNonQuery();

                            // Send exit email notification
                            SendEmail(employeeEmail, visitorEmail, employeeName, false);

                            return Content("**** THANK YOU FOR VISIT OUR PREMICES ****", "text/plain");
                        }
                        else
                        {
                            return Content("**** YOUR MEETING CONFIRMATION IS PENDING ****", "text/plain");
                        }

                        if (!reader.IsDBNull(1))
                        {
                            SqlCommand commandUpdateErrorFlag = new SqlCommand(queryUpdateErrorFlag, connection);
                            commandUpdateErrorFlag.Parameters.AddWithValue("@token", Token);
                            commandUpdateErrorFlag.ExecuteNonQuery();
                            return Content("Invalid QR detected: More than two scans detected", "text/plain");
                        }
                    }
                    else
                    {
                        reader.Close();
                        return Content("Invalid QR detected: No record found for the given user", "text/plain");
                    }
                }
            }
            catch (Exception ex)
            {
                Trace.WriteLine($"Error: {ex.Message}");
                return Content(ex.ToString());
            }
        }


        private string GetEmployeeEmail(string employeeName)
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = "SELECT Email FROM Master_User WHERE User_Name = @Name";
                    SqlCommand command = new SqlCommand(query, connection);
                    command.Parameters.AddWithValue("@Name", employeeName);

                    connection.Open();
                    object result = command.ExecuteScalar();
                    return result != null ? result.ToString() : null;
                }
            }
            catch (Exception ex)
            {
                Trace.WriteLine($"An error occurred while retrieving employee email: {ex.Message}");
                return null;
            }
        }

        private void SendEmail(string employeeEmail, string visitorEmail, string employeeName, bool isEntry)
        {
            try
            {
                using (SmtpClient client = new SmtpClient("smtp.gmail.com"))
                {
                    client.Port = 587;
                    client.Credentials = new NetworkCredential(SENDER_EMAIL, SENDER_PASSWORD);
                    client.EnableSsl = true;

                    using (MailMessage message = new MailMessage())
                    {
                        message.From = new MailAddress(SENDER_EMAIL);
                        message.To.Add(new MailAddress(employeeEmail));
                        message.CC.Add(new MailAddress(visitorEmail));

                        if (isEntry)
                        {
                            message.Subject = SUBJECT_ENTRY;
                            message.Body = "<h1 style=\"color: blue\">Dear " + employeeName + ",</h1>" +
                              "<p>A visitor has just entered the premises for a meeting.</p>" +
                              "<p>This is a quick message to confirm their entry.</p>" +
                              "<br><p>Thank you.</p>" +
                              "<p>Best regards,</p>" +
                              "<p>FORES ELASTOMECH INDIA PVT LTD</p>";
                        }
                        else
                        {
                            message.Subject = SUBJECT_EXIT;
                            message.Body = "<h1 style=\"color: blue\">Dear " + employeeName + ",</h1>" +
                                   "<p>A visitor has just exited the premises after the meeting.</p>" +
                                   "<p>This is a quick message to confirm their exit.</p>" +
                                   "<br><p>Thank you for your cooperation.</p>" +
                                   "<p>Best regards,</p>" +
                                   "<p>FORES ELASTOMECH INDIA PVT LTD</p>";
                        }

                        message.IsBodyHtml = true;
                        client.Send(message);
                        Trace.WriteLine("Email sent successfully!");
                    }
                }
            }
            catch (Exception ex)
            {
                Trace.WriteLine($"Failed to send email: {ex.Message}");
            }
        }


        [HttpPost]
        public ActionResult Conform_meeting(string qrData)
        {
            // Log all session variables
            System.Diagnostics.Trace.WriteLine("Checking all session variables:");
            foreach (string key in Session.Keys)
            {
                System.Diagnostics.Trace.WriteLine($"{key}: {Session[key]}");
            }

            // Retrieve the User_id from the session
            string userId = Session["User_id"]?.ToString().Trim(); // Use null-conditional operator

            // Debug output for User_id
            System.Diagnostics.Trace.WriteLine("User ID from session: " + userId);

            //// Check if the User_id is null or empty
            //if (string.IsNullOrEmpty(userId))
            //{
            //    System.Diagnostics.Trace.WriteLine("User ID is null or empty.");
            //    System.Diagnostics.Trace.WriteLine($"Session['User_id']: {Session["User_id"]}"); // Additional debug
            //    return Content("**** UNAUTHORIZED USER FOUND!! ****", "text/plain");
            //}

            // Process QR Code Data
            var tokenfromqr = qrData.Split('/');
            System.Diagnostics.Trace.WriteLine($"array length: {tokenfromqr.Length}");

            if (tokenfromqr.Length < 8)
            {
                System.Diagnostics.Trace.WriteLine("QR Data is invalid.");
                return Content("**** INVALID QR CODE DATA ****", "text/plain");
            }

            string token = tokenfromqr[7];
            TimeSpan currentTime = DateTime.Now.TimeOfDay;
            string formattedTime = currentTime.ToString("hh\\:mm");

            try
            {

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    // Query to check the token
                    string queryCheck = "SELECT IN_time, confirmation, Employee_mob FROM Record WHERE token = @token";

                    using (SqlCommand commandCheck = new SqlCommand(queryCheck, connection))
                    {
                        commandCheck.Parameters.AddWithValue("@token", token);

                        using (SqlDataReader reader = commandCheck.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                if (!reader.IsDBNull(0))
                                {
                                    string confirmation = reader.GetString(2).Trim();

                                    if (reader.IsDBNull(1) && confirmation == userId)
                                    {
                                        // Close the reader before running an update command
                                        reader.Close();

                                        // Query to update the confirmation
                                        string queryUpdateConfirmation = "UPDATE Record SET confirmation = @confirmationDate WHERE token = @token";

                                        using (SqlCommand commandUpdateConfirmation = new SqlCommand(queryUpdateConfirmation, connection))
                                        {
                                            commandUpdateConfirmation.Parameters.AddWithValue("@token", token);
                                            commandUpdateConfirmation.Parameters.AddWithValue("@confirmationDate", formattedTime); // Set current system date
                                            commandUpdateConfirmation.ExecuteNonQuery();
                                            System.Diagnostics.Trace.WriteLine($"Confirmation updated for token: {token}");

                                            return Content("**** CONFIRMATION DONE !! ****", "text/plain");
                                        }
                                    }
                                    else
                                    {
                                        return Content("**** UNAUTHORIZED USER FOUND!! ****", "text/plain");
                                    }
                                }
                                else
                                {
                                    return Content("**** IN-TIME ENTRY STILL PENDING !! ****", "text/plain");
                                }
                            }
                            else
                            {
                                return Content("**** NO RECORD FOUND FOR THE GIVEN TOKEN ****", "text/plain");
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Trace.WriteLine($"Error: {ex}");
                return Content("**** UNABLE TO READ QRCODE: " + ex.Message, "text/plain");
            }
        }
    }
}