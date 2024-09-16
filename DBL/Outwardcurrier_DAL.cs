using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DBL
{
    public class Outwardcurrier_DAL
    {
        private readonly string connectionString = "Server=sql.bsite.net\\MSSQL2016;Database=developer17_; User ID=developer17_; Password=Pass@123;";

        public DataTable GetSaveOutwardCouriers()
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("usp_GetOutwardCourierData", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    try
                    {
                        SqlDataAdapter adapter = new SqlDataAdapter(command);
                        DataTable dataTable = new DataTable();
                        adapter.Fill(dataTable);
                        return dataTable;
                    }
                    catch (SqlException ex)
                    {
                        // Log exception details
                        Console.Error.WriteLine($"SQL Error: {ex.Message}");
                        throw new Exception("Error retrieving data from the database.", ex);
                    }
                    catch (Exception ex)
                    {
                        // Log any other exceptions
                        Console.Error.WriteLine($"General Error: {ex.Message}");
                        throw new Exception("An error occurred while retrieving data.", ex);
                    }
                }
            }
        }

        public void InsertOutwardCourier(string inDate, string inTime, string senderName, string receiverName, string receiverAddress, string receiverCity, string byMode, string packingType, int noOfPacks, string value, string PlantNo)
        {
            if (string.IsNullOrEmpty(senderName) || string.IsNullOrEmpty(receiverName) || string.IsNullOrEmpty(receiverAddress) || string.IsNullOrEmpty(receiverCity) || string.IsNullOrEmpty(byMode) || string.IsNullOrEmpty(packingType))
            {
                throw new ArgumentException("One or more required fields are missing or invalid.");
            }

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"
            INSERT INTO OutwardCourier 
            (Currier_Entry_Date, Currier_Entry_Time, Courier_Sender_Name, Courier_Receiver_Name, Courier_Receiver_Address, Receiver_City, By_Mode, Packing_Type, Number_of_Packs, Value, Plant_No) 
            VALUES 
            (@InDate, @InTime, @SenderName, @ReceiverName, @ReceiverAddress, @ReceiverCity, @ByMode, @PackingType, @NoOfPacks, @Value, @PlantNo)";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@InDate", inDate ?? (object)DBNull.Value);
                    cmd.Parameters.AddWithValue("@InTime", inTime ?? (object)DBNull.Value);
                    cmd.Parameters.AddWithValue("@SenderName", senderName ?? (object)DBNull.Value);
                    cmd.Parameters.AddWithValue("@ReceiverName", receiverName ?? (object)DBNull.Value);
                    cmd.Parameters.AddWithValue("@ReceiverAddress", receiverAddress ?? (object)DBNull.Value);
                    cmd.Parameters.AddWithValue("@ReceiverCity", receiverCity ?? (object)DBNull.Value);
                    cmd.Parameters.AddWithValue("@ByMode", byMode ?? (object)DBNull.Value);
                    cmd.Parameters.AddWithValue("@PackingType", packingType ?? (object)DBNull.Value);
                    cmd.Parameters.AddWithValue("@NoOfPacks", noOfPacks);
                    cmd.Parameters.AddWithValue("@Value", value ?? (object)DBNull.Value);
                    cmd.Parameters.AddWithValue("@PlantNo", PlantNo ?? (object)DBNull.Value);

                    try
                    {
                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }
                    catch (SqlException ex)
                    {
                        // Log the detailed SQL exception
                        Console.Error.WriteLine($"SQL Error: {ex.Message}");
                        throw new ApplicationException("Data access error", ex);
                    }
                    catch (Exception ex)
                    {
                        // Log general exceptions
                        Console.Error.WriteLine($"General Error: {ex.Message}");
                        throw new ApplicationException("An error occurred while inserting data.", ex);
                    }
                }
            }
        }

    }
}