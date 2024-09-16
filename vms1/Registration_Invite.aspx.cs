using BSL;
using DBL;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Net.Mail;
using System.Net.NetworkInformation;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ZXing.Common;
using ZXing;

namespace vms1
{
    public partial class Registration_Invite : System.Web.UI.Page
    {
        private readonly string _connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadVisitorNames();
                txt_userlogin.Text = (string)Session["loginuser"];

                txt_plNTCODE.Text = (string)Session["PlantCode"];

            }

            txt_userlogin.Text = (string)Session["loginuser"];
        }


        private void LoadVisitorNames()
        {
            var dataService = new DataService(_connectionString);
            var dt = dataService.GetVisitorNames();

            rptVisitorNames.DataSource = dt;
            rptVisitorNames.DataBind();
        }

        protected void LoadVisitorDetails(string name)
        {
            var dataService = new DataService(_connectionString);
            DataTable dt = dataService.GetVisitorDetailsByName(name);

            if (dt.Rows.Count > 0)
            {
                DataRow row = dt.Rows[0];
                txtVisitorName.Text = row["Name"].ToString();
                txtMono.Text = row["Mobile_No"].ToString(); // Adjust column name as per your database
                txt_Email.Text = row["Email"].ToString(); // Adjust column name as per your database
                txt_Company.Text = row["Company"].ToString(); // Adjust column name as per your database

            }
        }

        protected void btn_registerinvite_Click(object sender, EventArgs e)
        {
            //try
            //{
            // Check if Session variables are not null
            if (Session["loginuser"] != null && Session["passmail"] != null && Session["User_id"] != null)
            {
                string employeename = Session["loginuser"].ToString();
                string employymail = Session["passmail"].ToString();
                string EmployeeMob = Session["User_id"].ToString();
                System.Diagnostics.Debug.WriteLine(employymail + employeename + "          ttttttt");

                string mobile_No = txtMono.Text;
                string meetingSubject = ddl_meetingsubject.SelectedValue;
                if (meetingSubject == "Other")
                {
                    meetingSubject = txtOtherSubject.Text.ToUpper();
                }

                string meetingdate = txt_datetime.Text;
                string visitor_Name = txtVisitorName.Text.ToUpper();
                string visitor_Email = txt_Email.Text;
                string Company = txt_Company.Text.ToUpper();
                string totalPersons = txtTotalPersons.Text;
                string PlantNo = txt_plNTCODE.Text;

                // Create DataAccess instance
                DataAccess dataAccess = new DataAccess(ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString);

                // Insert records into the database
                dataAccess.InsertVisitorRegistration(visitor_Name, mobile_No, visitor_Email, Company);
                dataAccess.InsertMeetingRecord(employeename, EmployeeMob, mobile_No, meetingSubject, meetingdate, visitor_Name, visitor_Email, Company, totalPersons, meetingdate, PlantNo);

                // Retrieve the latest token
                string token = dataAccess.GetLastToken();
                System.Diagnostics.Trace.WriteLine($"token is  {token}");

                // Prepare QR code data and generate QR code
                List<string> Qrdata = new List<string> { meetingSubject, visitor_Email, mobile_No, visitor_Name, Company, meetingdate, employeename, token };
                MemoryStream qrCodeStream = PrintQRCode(Qrdata);

                // Send the email with the QR code
                SendMail(visitor_Email, employymail, employeename, Qrdata);
                System.Diagnostics.Trace.WriteLine($" mail is sent successfully to {employymail}");

                //string alertMessage = "alert('**** YOUR MEETING HAS BEEN SUCCESFULLY SUBMITED **** ');";
                //ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", alertMessage, true);


                // Display success message using ScriptManager
                //ScriptManager.RegisterStartupScript(this, GetType(), "SuccessMessage", "alert('Email sent successfully!');", true);

                // Clear form fields
                txtMono.Text = string.Empty;
                ddl_meetingsubject.SelectedIndex = 0; // Set to the first item (default value)
                txtOtherSubject.Text = string.Empty;
                txt_datetime.Text = string.Empty;
                txtVisitorName.Text = string.Empty;
                txt_Email.Text = string.Empty;
                txt_Company.Text = string.Empty;
                txtTotalPersons.Text = string.Empty;
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "SessionError", "alert('Session variables are null.');", true);
            }
            //}
            //    catch (SqlException sqlEx)
            //    {
            //        // Handle SQL exceptions
            //        ScriptManager.RegisterStartupScript(this, GetType(), "SqlError", $"alert('SQL error occurred: {sqlEx.Message}');", true);
            //}
            //    catch (System.FormatException formatEx)
            //    {
            //        // Handle format exceptions (e.g., DateTime.Parse)
            //        ScriptManager.RegisterStartupScript(this, GetType(), "FormatError", $"alert('Format error occurred: {formatEx.Message}');", true);
            //}
            //    catch (Exception ex)
            //    {
            //        // Handle all other exceptions
            //        ScriptManager.RegisterStartupScript(this, GetType(), "GeneralError", $"alert('An unexpected error occurred: {ex.Message}');", true);
            //}
        }

        public MemoryStream PrintQRCode(List<string> values)
        {
            int qrCodeSize = 90;
            int paperWidth = 350;
            int paperHeight = 465; // Increased height to fit all instructions
            string combinedValue = string.Join("/", values);

            var hintMap = new Dictionary<EncodeHintType, object>
    {
        { EncodeHintType.CHARACTER_SET, "UTF-8" },
        { EncodeHintType.ERROR_CORRECTION, ZXing.QrCode.Internal.ErrorCorrectionLevel.L },
        { EncodeHintType.MARGIN, 1 }
    };

            BarcodeWriter writer = new BarcodeWriter
            {
                Format = BarcodeFormat.QR_CODE,
                Options = new EncodingOptions
                {
                    Height = qrCodeSize,
                    Width = qrCodeSize,
                    Margin = 1
                }
            };

            // Generate QR code
            var bitMatrix = writer.Encode(combinedValue);
            Bitmap qrImage = new Bitmap(qrCodeSize, qrCodeSize);
            for (int x = 0; x < qrCodeSize; x++)
            {
                for (int y = 0; y < qrCodeSize; y++)
                {
                    qrImage.SetPixel(x, y, bitMatrix[x, y] ? Color.Black : Color.White);
                }
            }

            // Create the combined image
            Bitmap combinedImage = new Bitmap(paperWidth, paperHeight);
            using (Graphics g = Graphics.FromImage(combinedImage))
            {
                g.FillRectangle(Brushes.LightBlue, 0, 0, paperWidth, paperHeight);

                // Draw the QR code image
                int qrCodeX = (paperWidth - qrCodeSize) / 2;
                int qrCodeY = paperHeight - qrCodeSize - 120; // Adjust Y to make room for instructions
                g.DrawImage(qrImage, qrCodeX, qrCodeY);

                // Draw the visitor instructions heading and text
                string heading = "INSTRUCTIONS :- ";
                string[] instructions = new string[]
                {
            "Do not take any photograph/documents from the factory without permission.",
            "You will abide all rules of this company which are displayed in security office.",
            "You will be held responsible for your belongings.",
            "Park the vehicles at the designated parking area only.",
            "Do not attempt any unsafe act which can harm yourself or others."
                };

                int instructionX = 15;
                int instructionY = qrCodeY + qrCodeSize + 10; // Position below the QR code

                // Original font sizes
                float originalHeadingFontSize = 10;
                float originalInstructionFontSize = 7;

                // Reduced font sizes
                float reducedHeadingFontSize = originalHeadingFontSize - 0.5f;
                float reducedInstructionFontSize = originalInstructionFontSize - 0.5f;

                Font headingFont = new Font("Cambria", reducedHeadingFontSize, FontStyle.Bold);
                Font instructionFont = new Font("Cambria", reducedInstructionFontSize, FontStyle.Bold);
                Brush headingBrush = Brushes.DarkSlateGray;
                Brush instructionBrush = Brushes.Red;

                // Draw the heading
                g.DrawString(heading, headingFont, headingBrush, instructionX, instructionY);
                instructionY += (int)g.MeasureString(heading, headingFont).Height + 5;

                // Draw the instructions with bullet points
                int bulletSize = 5;
                int bulletPadding = 5;
                Brush bulletBrush = new SolidBrush(Color.Red);

                foreach (var instruction in instructions)
                {
                    // Draw the bullet point
                    g.FillEllipse(bulletBrush, instructionX - bulletSize - bulletPadding, instructionY + 5, bulletSize, bulletSize);

                    // Draw the instruction text
                    g.DrawString(instruction, instructionFont, instructionBrush, instructionX, instructionY);
                    instructionY += (int)g.MeasureString(instruction, instructionFont).Height + 5;
                }

                // Draw the logo
                System.Drawing.Image gatePassImage;
                try
                {
                    gatePassImage = System.Drawing.Image.FromFile(@"D:\fores.jpg");
                }
                catch (Exception ex)
                {
                    // Handle image file not found or other issues
                    Console.WriteLine("Error loading image: " + ex.Message);
                    gatePassImage = new Bitmap(1, 1); // Placeholder for error handling
                }
                int logoX = 13;
                int logoY = 10;
                int desiredHeight = 40;
                int desiredWidth = (int)(gatePassImage.Width * ((float)desiredHeight / gatePassImage.Height));
                g.DrawImage(gatePassImage, logoX, logoY, desiredWidth, desiredHeight);

                // Draw the white background square
                int squareWidth = 280;
                int squareHeight = 38;
                int squareX = paperWidth - squareWidth - 20;
                int squareY = 12;
                int borderWidth = 2;
                Brush lightGreenBrush = new SolidBrush(Color.LightGreen);
                g.FillRectangle(lightGreenBrush, squareX - borderWidth, squareY - borderWidth, squareWidth + 2 * borderWidth, squareHeight + 2 * borderWidth);
                g.FillRectangle(Brushes.White, squareX, squareY, squareWidth, squareHeight);

                // Add text elements
                g.DrawString("FORES ELASTOMECH INDIA PVT LTD", new Font("Cambria", 10, FontStyle.Bold), Brushes.DarkSlateGray, squareX + 25, squareY + 3);

                int addressWidth = (int)g.MeasureString("M-191/2, Waluj MIDC, Aurangabad", new Font("Cambria", 7, FontStyle.Bold)).Width;
                int addressX = squareX + squareWidth - addressWidth - 50;
                g.DrawString("M-191/2, Waluj MIDC, Aurangabad", new Font("Cambria", 7, FontStyle.Bold), Brushes.DarkSlateGray, addressX - 15, squareY + 18);

                // Draw borders and text boxes
                using (Pen borderPen = new Pen(Color.LightGreen, 1))
                {
                    int textX = 130;
                    int textY = 60;
                    SizeF textSize = g.MeasureString("VISITOR GATE PASS", new Font("Cambria", 9, FontStyle.Bold));
                    g.DrawRectangle(borderPen, textX - 2, textY - 2, (int)textSize.Width + 4, (int)textSize.Height + 4);
                    g.FillRectangle(Brushes.White, textX - 2, textY - 2, (int)textSize.Width + 4, (int)textSize.Height + 4);
                    g.DrawString("VISITOR GATE PASS", new Font("Cambria", 9, FontStyle.Bold), Brushes.DarkSlateGray, 130, 60);

                    textX = 230;
                    textY = 90;
                    SizeF dateSize = g.MeasureString("DATE :", new Font("Cambria", 7, FontStyle.Bold));
                    g.FillRectangle(Brushes.White, textX - 2, textY - 2, (int)dateSize.Width + 70, (int)dateSize.Height + 4);
                    g.DrawRectangle(borderPen, textX - 2, textY - 2, (int)dateSize.Width + 70, (int)dateSize.Height + 4);

                    // Ensure the string is parsed correctly
                    DateTime dateTimeValue;
                    string inputFormat = "yyyy-MM-ddTHH:mm";
                    if (DateTime.TryParseExact(values[5], inputFormat, null, System.Globalization.DateTimeStyles.None, out dateTimeValue))
                    {
                        string dateValue = dateTimeValue.ToString("dd/MM/yyyy");
                        g.DrawString("DATE : " + dateValue, new Font("Cambria", 7, FontStyle.Bold), Brushes.DarkSlateGray, 230, 90);
                    }
                    else
                    {
                        g.DrawString("DATE : Invalid Date", new Font("Cambria", 7, FontStyle.Bold), Brushes.DarkSlateGray, 230, 90);
                    }
                }


                void DrawBulletAndText(Graphics graphics, string text, int x, int y, int bSize, int bPadding, Brush bBrush)
                {
                    graphics.FillRectangle(bBrush, x - bSize - bPadding, y + 3, bSize, bSize);
                    graphics.DrawString(text, new Font("Cambria", 8, FontStyle.Bold), Brushes.Black, x, y);
                }

                bulletSize = 10;
                bulletPadding = 5;
                int bulletTextX = 15 + bulletSize + bulletPadding;
                Brush bulletBrushGray = new SolidBrush(Color.Gray);

                DateTime dateTimeValue1;
                string inputFormat1 = "yyyy-MM-ddTHH:mm";
                string outputFormat1 = "dd-MM-yyyy  HH:mm";

                // Move bullet points higher on the page
                int yOffset = 130; // Adjust this value to move the bullet points up
                DrawBulletAndText(g, "Visitor Name : " + values[3], bulletTextX, yOffset, bulletSize, bulletPadding, bulletBrushGray);
                DrawBulletAndText(g, "Mobile Number : " + values[2], bulletTextX, yOffset + 15, bulletSize, bulletPadding, bulletBrushGray);
                DrawBulletAndText(g, "Email ID : " + values[1], bulletTextX, yOffset + 30, bulletSize, bulletPadding, bulletBrushGray);
                DrawBulletAndText(g, "Whom To Meet : " + values[6], bulletTextX, yOffset + 45, bulletSize, bulletPadding, bulletBrushGray);
                DrawBulletAndText(g, "Meeting Date & Time : " + (DateTime.TryParseExact(values[5], inputFormat1, null, System.Globalization.DateTimeStyles.None, out dateTimeValue1) ? dateTimeValue1.ToString(outputFormat1) : "Invalid Date"), bulletTextX, yOffset + 60, bulletSize, bulletPadding, bulletBrushGray);
                DrawBulletAndText(g, "Reason : " + values[0], bulletTextX, yOffset + 75, bulletSize, bulletPadding, bulletBrushGray);

                using (Pen bluePen = new Pen(Color.Blue, 5))
                {
                    g.DrawRectangle(bluePen, 0, 0, paperWidth - 1, paperHeight - 1);
                }
            }

            // Save the image to a MemoryStream
            MemoryStream memoryStream = new MemoryStream();
            combinedImage.Save(memoryStream, System.Drawing.Imaging.ImageFormat.Png);
            memoryStream.Position = 0; // Reset the position to the beginning of the stream

            return memoryStream;
        }

        public void SendMail(string receiverMail, string employeemial, string employeename, List<string> values)
        {
            const string SENDER_EMAIL = "lakhanbairagi378@gmail.com";
            const string SENDER_PASSWORD = "gxvx tbrp uwex mwjb";
            const string SUBJECT = "CONFIRMATION OF YOUR APPOINTMENT AT FORES GROUP";

            //try
            //{
                using (SmtpClient client = new SmtpClient("smtp.gmail.com"))
                {
                    client.Port = 587;
                    client.Credentials = new NetworkCredential(SENDER_EMAIL, SENDER_PASSWORD);
                    client.EnableSsl = true;

                    using (MailMessage message = new MailMessage())
                    {
                        message.From = new MailAddress(SENDER_EMAIL);
                        message.To.Add(new MailAddress(receiverMail));
                        message.CC.Add(new MailAddress(employeemial));

                        message.Subject = SUBJECT;
                        message.IsBodyHtml = true;

                        string BODY_HTML = "<h2 style=\"color: blue\">Dear " + values[3] + "</h2><p> This is your Gate pass<br>" +
                                           "<p style=\"padding-left: 20px;\">This is a just quick message to confirm your upcoming appointment at Fores Group. <p>We're thrilled to have you visit our office!</p><br>" +
                                           "Thank You.<br>" + "<h4><p>Best regards,</p><p> " + employeename + "</p></h4>";

                        message.Body = BODY_HTML;

                        using (MemoryStream qrCodeStream = PrintQRCode(values))
                        {
                            // Create the QR code attachment
                            Attachment qrCodeAttachment = new Attachment(qrCodeStream, "QRCodeImage.png", "image/png");
                            message.Attachments.Add(qrCodeAttachment);

                            // Send the email
                            client.Send(message);
                            Console.WriteLine("Email sent successfully.");

                            string script = @"
        alert('Registration and invitation successful!');
        document.getElementById('" + btn_registerinvite.ClientID + @"').style.display = 'block';
        document.getElementById('loadingSpinner').style.display = 'none';
    ";
                            string alertMessage = "alert('**** YOUR MEETING HAS BEEN SUCCESFULLY SUBMITED **** ');";
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", alertMessage, true);

                        }
                    }
                }
            //}
            //catch (Exception ex)
            //{
            //    Console.WriteLine("Error occurred while sending email: " + ex.Message);
            //}
        }
    }
}