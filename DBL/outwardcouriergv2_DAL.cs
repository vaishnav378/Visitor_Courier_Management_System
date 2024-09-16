using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DBL
{
    public class Outwardcurriergv2_DAL
    {
        string connectionString = "Server=sql.bsite.net\\MSSQL2016;Database=developer17_; User ID=developer17_; Password=Pass@123;";

        public DataTable GetSaveOutwardCouriers()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("usp_GetSaveOutwardCouriers", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    conn.Open();

                    using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        adapter.Fill(dt);
                        return dt;
                    }
                }
            }
        }

        public void UpdateOutwardCourier(int courierEntryNo, string docketNumber, DateTime outDate, TimeSpan outTime, string courierAgency)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("sp_UpdateOutwardCourier", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@CourierEntryNo", courierEntryNo);
                    cmd.Parameters.AddWithValue("@DocketNumber", docketNumber);
                    cmd.Parameters.AddWithValue("@OutDate", outDate);
                    cmd.Parameters.AddWithValue("@OutTime", outTime);
                    cmd.Parameters.AddWithValue("@CourierAgency", courierAgency);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }
        public void UpdateFilePath(int courierEntryNo, string filePath)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("sp_UpdateFilePath", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@CourierEntryNo", courierEntryNo);
                    cmd.Parameters.AddWithValue("@FilePath", filePath);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

    }
}
