using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DBL
{
    public class Inwardcurrier_DAL
    {
        string connectionString = "Server=sql.bsite.net\\MSSQL2016;Database=developer17_; User ID=developer17_; Password=Pass@123;";

        public DataTable GetVisitorNames()
        {
            DataTable dataTable = new DataTable();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT User_Name FROM Master_User";

                using (SqlDataAdapter adapter = new SqlDataAdapter(query, conn))
                {
                    // Fill the DataTable with data from the database
                    adapter.Fill(dataTable);
                }
            }

            return dataTable;
        }

        //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        public DataTable GetAllInwardCouriers(string receiverName)
        {
            DataTable dt = new DataTable();
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("usp__GetAllInwardCouriers", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@ReceiverName", receiverName);

                    SqlDataAdapter adapter = new SqlDataAdapter(command);
                    adapter.Fill(dt);
                }
            }
            return dt;
        }
        public DataTable GetAllInwardCouriers()
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("usp_GetAllInwardCouriers", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;

                    try
                    {
                        connection.Open();
                        using (SqlDataAdapter adapter = new SqlDataAdapter(command))
                        {
                            DataTable dataTable = new DataTable();
                            adapter.Fill(dataTable);
                            return dataTable;
                        }
                    }
                    catch (SqlException ex)
                    {
                        // Handle exceptions (logging, rethrowing, etc.)
                        throw new Exception("Error retrieving data from the database.", ex);
                    }
                }
            }
        }



        //Save data
        public void InsertInwardCourier(string inDate, string inTime, string courierAgency, string docketNumber, string senderName, string senderCity, string byMode, string receiptPacking, int noOfPacks, string receiverName, string remark, string plantNo)
        {
            // Validate input values
            if (string.IsNullOrEmpty(courierAgency) || string.IsNullOrEmpty(senderCity) || string.IsNullOrEmpty(byMode) || string.IsNullOrEmpty(receiptPacking))
            {
                throw new ArgumentException("One or more required fields are missing or invalid.");
            }

            // Use using statements to ensure resources are properly disposed
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                // SQL query with parameters to avoid SQL injection
                string query = @"
        INSERT INTO InwardCourier 
        (Currier_Inward_Date, Currier_Inward_Time, Courier_Agency, Docket_Number, Courier_Sender_Name, Sender_City, Receipt_By_mode, Receipt_Packing, No_of_Packs, Currier_Receiver_Name, Remarks, Plant_No) 
        VALUES 
        (@InDate, @InTime, @CourierAgency, @DocketNumber, @SenderName, @SenderCity, @ByMode, @ReceiptPacking, @NoOfPacks, @ReceiverName, @Remark, @PlantNo)";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    // Add parameters with proper types
                    cmd.Parameters.AddWithValue("@InDate", inDate ?? (object)DBNull.Value);
                    cmd.Parameters.AddWithValue("@InTime", inTime ?? (object)DBNull.Value);
                    cmd.Parameters.AddWithValue("@CourierAgency", courierAgency ?? (object)DBNull.Value);
                    cmd.Parameters.AddWithValue("@DocketNumber", docketNumber ?? (object)DBNull.Value);
                    cmd.Parameters.AddWithValue("@SenderName", senderName ?? (object)DBNull.Value);
                    cmd.Parameters.AddWithValue("@SenderCity", senderCity ?? (object)DBNull.Value);
                    cmd.Parameters.AddWithValue("@ByMode", byMode ?? (object)DBNull.Value);
                    cmd.Parameters.AddWithValue("@ReceiptPacking", receiptPacking ?? (object)DBNull.Value);
                    cmd.Parameters.AddWithValue("@NoOfPacks", noOfPacks);
                    cmd.Parameters.AddWithValue("@ReceiverName", receiverName ?? (object)DBNull.Value);
                    cmd.Parameters.AddWithValue("@Remark", remark ?? (object)DBNull.Value);
                    cmd.Parameters.AddWithValue("@PlantNo", plantNo ?? (object)DBNull.Value);

                    // Open connection, execute command, and handle exceptions
                    try
                    {
                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }
                    catch (SqlException ex)
                    {
                        // Log exception or handle it as needed
                        throw new ApplicationException("Data access error", ex);
                    }
                    finally
                    {
                        conn.Close();
                    }
                }
            }
        }

        public string GetPlantNoByReceiverName(string receiverName)
        {
            string plantNo = null;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT PlantCode FROM Master_User WHERE User_Name = @ReceiverName";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@ReceiverName", receiverName);

                    try
                    {
                        conn.Open();
                        var result = cmd.ExecuteScalar();
                        if (result != null)
                        {
                            plantNo = result.ToString();
                        }
                    }
                    catch (SqlException ex)
                    {
                        // Handle exception
                        throw new ApplicationException("Data access error", ex);
                    }
                    finally
                    {
                        conn.Close();
                    }
                }
            }

            return plantNo;
        }
    }
}