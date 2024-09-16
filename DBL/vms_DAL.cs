using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Xml.Linq;
using System.Globalization;
using System.Collections.Generic;

namespace DBL
{
    public class DataAccess
    {
        private readonly string _connectionString;

        // Constructor that accepts a connection string
        public DataAccess(string connectionString)
        {
            _connectionString = connectionString;
        }

        public DataTable GetVisitorNames1()
        {
            DataTable dt = new DataTable();
            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
                string query = "SELECT DISTINCT Name FROM Record";
                using (SqlDataAdapter da = new SqlDataAdapter(query, conn))
                {
                    da.Fill(dt);
                }
            }
            return dt;
        }

        public DataTable GetMobileNumbers()
        {
            DataTable dt = new DataTable();
            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
                string query = "SELECT DISTINCT Mobile_No FROM Record";
                using (SqlDataAdapter da = new SqlDataAdapter(query, conn))
                {
                    da.Fill(dt);
                }
            }
            return dt;
        }

        public DataTable GetMeetingWith()
        {
            DataTable dt = new DataTable();
            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
                string query = "SELECT DISTINCT User_Name FROM Master_User";
                using (SqlDataAdapter da = new SqlDataAdapter(query, conn))
                {
                    da.Fill(dt);
                }
            }
            return dt;
        }

        public DataTable GetPlants()
        {
            DataTable dt = new DataTable();
            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
                string query = "SELECT DISTINCT Plant_No FROM Record";
                using (SqlDataAdapter da = new SqlDataAdapter(query, conn))
                {
                    da.Fill(dt);
                }
            }
            return dt;
        }
        public int GetTotalVisitors()
        {
            string query = "SELECT COUNT(*) FROM [Record]";
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                SqlCommand command = new SqlCommand(query, connection);
                connection.Open();
                return (int)command.ExecuteScalar();
            }
        }

        public List<Visitor> GetVisitorDetails()
        {
            string query = "SELECT Name, Meet_Datetime FROM [Record]";
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                SqlCommand command = new SqlCommand(query, connection);
                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                List<Visitor> visitors = new List<Visitor>();
                while (reader.Read())
                {
                    visitors.Add(new Visitor
                    {
                        Name = reader["Name"].ToString(),
                        Meet_Datetime = reader["Meet_Datetime"].ToString()
                    });
                }
                return visitors;
            }
        }

        public int GetVisitorsThisMonth()
        {
            string query = "SELECT COUNT(*) FROM [Record] WHERE MONTH(Date_Time) = @CurrentMonth AND YEAR(Date_Time) = @CurrentYear AND (IN_time IS NOT NULL OR OUT_time IS NOT NULL OR confirmation IS NOT NULL)";
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@CurrentMonth", DateTime.Now.Month);
                command.Parameters.AddWithValue("@CurrentYear", DateTime.Now.Year);

                connection.Open();
                return (int)command.ExecuteScalar();
            }
        }

        public List<Visitor> GetVisitorsThisMonthDetails()
        {
            string query = "SELECT Name, Meet_Datetime FROM [Record] WHERE MONTH(Date_Time) = @CurrentMonth AND YEAR(Date_Time) = @CurrentYear AND (IN_time IS NOT NULL OR OUT_time IS NOT NULL OR confirmation IS NOT NULL)";
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@CurrentMonth", DateTime.Now.Month);
                command.Parameters.AddWithValue("@CurrentYear", DateTime.Now.Year);

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                List<Visitor> visitors = new List<Visitor>();
                while (reader.Read())
                {
                    visitors.Add(new Visitor
                    {
                        Name = reader["Name"].ToString(),
                        Meet_Datetime = reader["Meet_Datetime"].ToString()
                    });
                }
                return visitors;
            }
        }

        public int GetBounceRate()
        {
            string query = "SELECT COUNT(*) FROM [Record] WHERE IN_time IS NULL AND OUT_time IS NULL AND confirmation IS NULL";
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@CurrentMonth", DateTime.Now.Month);
                command.Parameters.AddWithValue("@CurrentYear", DateTime.Now.Year);

                connection.Open();
                return (int)command.ExecuteScalar();
            }
        }

        public List<EmployeeVisitor> GetEmployeeRate()
        {
            string query = @"
                SELECT TOP 5 Whometo_Visit AS EmployeeName, COUNT(*) AS VisitorCount
                FROM [Record]
                WHERE Whometo_Visit IS NOT NULL
                GROUP BY Whometo_Visit
                ORDER BY COUNT(*) DESC;
            ";
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                SqlCommand command = new SqlCommand(query, connection);
                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                List<EmployeeVisitor> employeeVisitors = new List<EmployeeVisitor>();
                while (reader.Read())
                {
                    employeeVisitors.Add(new EmployeeVisitor
                    {
                        EmployeeName = reader["EmployeeName"].ToString(),
                        VisitorCount = (int)reader["VisitorCount"]
                    });
                }
                return employeeVisitors;
            }
        }

        public class Visitor
        {
            public string Name { get; set; }
            public string Meet_Datetime { get; set; }
        }

        public class EmployeeVisitor
        {
            public string EmployeeName { get; set; }
            public int VisitorCount { get; set; }
        }
        public List<Visitor> GetBounceRateDetails()
        {
            string query = "SELECT Name, Meet_Datetime FROM [Record] WHERE MONTH(Date_Time) = @CurrentMonth AND YEAR(Date_Time) = @CurrentYear AND IN_time IS NULL AND OUT_time IS NULL AND confirmation IS NULL";
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@CurrentMonth", DateTime.Now.Month);
                command.Parameters.AddWithValue("@CurrentYear", DateTime.Now.Year);

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                List<Visitor> visitors = new List<Visitor>();
                while (reader.Read())
                {
                    visitors.Add(new Visitor
                    {
                        Name = reader["Name"].ToString(),
                        Meet_Datetime = reader["Meet_Datetime"].ToString()
                    });
                }
                return visitors;
            }
        }

        // Method to get visitor names
        public DataTable GetVisitorNames()
        {
            DataTable dt = new DataTable();
            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
                string query = "SELECT Name FROM Visitor_Registration";
                using (SqlDataAdapter da = new SqlDataAdapter(query, conn))
                {
                    da.Fill(dt);
                }
            }
            return dt;
        }

        public DataTable GetVisitorDetailsByName(string name)
        {
            DataTable dt = new DataTable();
            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
                string query = "SELECT * FROM Visitor_Registration WHERE Name = @Name";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Name", name);
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(dt);
                    }
                }
            }
            return dt;
        }


        // Method to get records by filters
        public DataTable GetRecordsByFilters(string visitorName, string mobileNumber, string meetingWith, DateTime? fromDate, DateTime? toDate, TimeSpan? inTime, TimeSpan? outTime, string plantNo)
        {
            DataTable dt = new DataTable();
            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
                string query = "SELECT * FROM Record WHERE 1=1";

                if (!string.IsNullOrEmpty(visitorName))
                {
                    query += " AND Name LIKE '%' + @VisitorName + '%'";
                }

                if (!string.IsNullOrEmpty(mobileNumber))
                {
                    query += " AND Mobile_No = @MobileNumber";
                }

                if (!string.IsNullOrEmpty(meetingWith))
                {
                    query += " AND Whometo_Visit LIKE '%' + @MeetingWith + '%'";
                }

                if (fromDate.HasValue && toDate.HasValue)
                {
                    query += " AND TRY_CONVERT(DATETIME, Meet_DateTime, 103) BETWEEN @DateFrom AND @DateTo";
                }

                if (inTime.HasValue)
                {
                    query += " AND IN_time IS NOT NULL AND TRY_CONVERT(TIME, IN_time) >= @InTime";
                }

                if (outTime.HasValue)
                {
                    query += " AND OUT_time IS NOT NULL AND TRY_CONVERT(TIME, OUT_time) <= @OutTime";
                }

                if (!string.IsNullOrEmpty(plantNo))
                {
                    query += " AND Plant_No LIKE '%' + @Plant_No + '%'";
                }

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    if (!string.IsNullOrEmpty(visitorName))
                    {
                        cmd.Parameters.AddWithValue("@VisitorName", visitorName);
                    }

                    if (!string.IsNullOrEmpty(mobileNumber))
                    {
                        cmd.Parameters.AddWithValue("@MobileNumber", mobileNumber);
                    }

                    if (!string.IsNullOrEmpty(meetingWith))
                    {
                        cmd.Parameters.AddWithValue("@MeetingWith", meetingWith);
                    }

                    if (fromDate.HasValue && toDate.HasValue)
                    {
                        cmd.Parameters.AddWithValue("@DateFrom", fromDate.Value);
                        cmd.Parameters.AddWithValue("@DateTo", toDate.Value);
                    }

                    if (inTime.HasValue)
                    {
                        cmd.Parameters.AddWithValue("@InTime", inTime.Value);
                    }

                    if (outTime.HasValue)
                    {
                        cmd.Parameters.AddWithValue("@OutTime", outTime.Value);
                    }

                    if (!string.IsNullOrEmpty(plantNo))
                    {
                        cmd.Parameters.AddWithValue("@Plant_No", plantNo);
                    }

                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(dt);
                    }
                }
            }
            return dt;
        }


        public void InsertVisitorRegistration(string name, string mobileNo, string email, string company)
        {
            string checkQuery = "SELECT COUNT(*) FROM Visitor_Registration WHERE Name = @Name AND Mobile_No = @MobileNo AND Email = @Email AND Company = @Company";
            string insertQuery = "INSERT INTO Visitor_Registration (Name, Mobile_No, Email, Company) VALUES (@Name, @MobileNo, @Email, @Company)";

            try
            {
                using (SqlConnection connection = new SqlConnection(_connectionString))
                {
                    using (SqlCommand checkCommand = new SqlCommand(checkQuery, connection))
                    {
                        checkCommand.Parameters.AddWithValue("@Name", name);
                        checkCommand.Parameters.AddWithValue("@MobileNo", mobileNo);
                        checkCommand.Parameters.AddWithValue("@Email", email);
                        checkCommand.Parameters.AddWithValue("@Company", company);

                        connection.Open();
                        int count = (int)checkCommand.ExecuteScalar();

                        if (count == 0) // No existing record found
                        {
                            using (SqlCommand insertCommand = new SqlCommand(insertQuery, connection))
                            {
                                insertCommand.Parameters.AddWithValue("@Name", name);
                                insertCommand.Parameters.AddWithValue("@MobileNo", mobileNo);
                                insertCommand.Parameters.AddWithValue("@Email", email);
                                insertCommand.Parameters.AddWithValue("@Company", company);

                                insertCommand.ExecuteNonQuery();
                            }
                        }
                        else
                        {
                            Console.WriteLine("Record already exists. No new record inserted.");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error inserting visitor registration: {ex.Message}");
                throw; // You can handle this exception as per your application's error handling strategy
            }
        }

        // Method to insert meeting record
        public void InsertMeetingRecord(string Whometo_Visit, string EmployeeMob, string Mobile_No, string Meeting_Subject, string Date_Time, string Name, string Email, string Company, string totalPersons, string Meet_DateTime, string PlantNo)
        {

            try
            {

                using (SqlConnection connection = new SqlConnection(_connectionString))
                {
                    connection.Open();

                    // Convert Meet_DateTime to the desired format (dd-MM-yyyy HH:mm)
                    DateTime parsedDateTime;
                    if (DateTime.TryParse(Meet_DateTime, out parsedDateTime))
                    {
                        Meet_DateTime = parsedDateTime.ToString("dd-MM-yyyy HH:mm");
                    }
                    else
                    {
                        // Handle the case where parsing fails (if necessary)
                        throw new Exception("Invalid date format.");
                    }

                    // Extract the date part for comparison
                    string datePart = parsedDateTime.ToString("yyyy-MM-dd");

                    // Check if record exists
                    string checkQuery = @"
            SELECT COUNT(*) 
            FROM Record 
            WHERE Mobile_No = @Mobile_No 
            AND LEFT(Meet_DateTime, 10) = @Meet_DateTime";

                    using (var checkCommand = new SqlCommand(checkQuery, connection))
                    {
                        checkCommand.Parameters.AddWithValue("@Mobile_No", Mobile_No);
                        checkCommand.Parameters.AddWithValue("@Meet_DateTime", datePart);

                        int recordCount = (int)checkCommand.ExecuteScalar();

                        if (recordCount > 0)
                        {
                            string updateQuery = @"
                    UPDATE Record
                    SET Whometo_Visit = @Whometo_Visit,
                        Mobile_No = @Mobile_No,
                        Meeting_Subject = @Meeting_Subject,
                        Date_Time = @Date_Time,
                        Name = @Name,
                        Email = @Email,
                        Company = @Company,
                        Employee_mob = @EmployeeMob,
                        Total_Visitor = @totalPersons,
                        Meet_DateTime = @Meet_DateTime,
                        Plant_No = @Plant_No
                    WHERE token = (
                        SELECT TOP 1 token
                        FROM Record
                        ORDER BY token DESC
                    )";

                            using (var updateCommand = new SqlCommand(updateQuery, connection))
                            {
                                updateCommand.Parameters.AddWithValue("@Whometo_Visit", Whometo_Visit);
                                updateCommand.Parameters.AddWithValue("@Mobile_No", Mobile_No);
                                updateCommand.Parameters.AddWithValue("@Meeting_Subject", Meeting_Subject);
                                updateCommand.Parameters.AddWithValue("@Date_Time", DateTime.Now);
                                updateCommand.Parameters.AddWithValue("@Name", Name);
                                updateCommand.Parameters.AddWithValue("@Email", Email);
                                updateCommand.Parameters.AddWithValue("@Company", Company);
                                updateCommand.Parameters.AddWithValue("@EmployeeMob", EmployeeMob);
                                updateCommand.Parameters.AddWithValue("@totalPersons", totalPersons);
                                updateCommand.Parameters.AddWithValue("@Meet_DateTime", Meet_DateTime);
                                updateCommand.Parameters.AddWithValue("@Plant_No", PlantNo);

                                updateCommand.ExecuteNonQuery();
                            }
                        }
                        else
                        {
                            string insertQuery = @"
                    INSERT INTO Record (Whometo_Visit, Mobile_No, Meeting_Subject, Date_Time, Name, Email, Company, Employee_mob, Total_Visitor, Meet_DateTime, Plant_No) 
                    VALUES (@Whometo_Visit, @Mobile_No, @Meeting_Subject, @Date_Time, @Name, @Email, @Company, @EmployeeMob, @totalPersons, @Meet_DateTime, @Plant_No)";

                            using (var insertCommand = new SqlCommand(insertQuery, connection))
                            {
                                insertCommand.Parameters.AddWithValue("@Whometo_Visit", Whometo_Visit);
                                insertCommand.Parameters.AddWithValue("@Mobile_No", Mobile_No);
                                insertCommand.Parameters.AddWithValue("@Meeting_Subject", Meeting_Subject);
                                insertCommand.Parameters.AddWithValue("@Date_Time", DateTime.Now);
                                insertCommand.Parameters.AddWithValue("@Name", Name);
                                insertCommand.Parameters.AddWithValue("@Email", Email);
                                insertCommand.Parameters.AddWithValue("@Company", Company);
                                insertCommand.Parameters.AddWithValue("@EmployeeMob", EmployeeMob);
                                insertCommand.Parameters.AddWithValue("@totalPersons", totalPersons);
                                insertCommand.Parameters.AddWithValue("@Meet_DateTime", Meet_DateTime);
                                insertCommand.Parameters.AddWithValue("@Plant_No", PlantNo);

                                insertCommand.ExecuteNonQuery();
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Trace.WriteLine($"Error occurred: {ex.Message}");
                throw; // Re-throw the exception to be handled by the caller
            }
        }

        // Method to get the last token
        public string GetLastToken()
        {
            string token = "";
            string query = "SELECT MAX(token) AS LastToken FROM Record";
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, connection))
                {
                    connection.Open();
                    object result = cmd.ExecuteScalar();
                    if (result != null)
                    {
                        token = result.ToString();
                    }
                }
            }
            return token;
        }

        public int InsertDepartment(string departmentName)
        {
            int rowsAffected = 0;
            string query = "INSERT INTO Department (Department_List) VALUES (@Department_List)";

            try
            {
                using (SqlConnection connection = new SqlConnection(_connectionString))
                {
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@Department_List", departmentName);
                        connection.Open();
                        rowsAffected = command.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                // Handle the exception as needed (log, rethrow, etc.)
                throw new Exception("Error inserting department", ex);
            }

            return rowsAffected;
        }
        public DataTable GetRecords()
        {
            string query = "SELECT token, Name, Whometo_Visit, Meet_DateTime, Total_Visitor " +
                           "FROM Record " +
                           "WHERE TRY_CONVERT(DATE, Meet_DateTime, 103) = CONVERT(DATE, GETDATE()) " +
                           "AND TRY_CONVERT(TIME, Meet_DateTime, 103) > CAST(GETDATE() AS TIME) " +
                           "AND IN_time IS NULL";

            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    connection.Open();

                    DataTable dataTable = new DataTable();
                    using (SqlDataAdapter adapter = new SqlDataAdapter(command))
                    {
                        adapter.Fill(dataTable);
                    }

                    return dataTable;
                }
            }
        }

        public int UpdateRecord(string token, string personNames)
        {
            string updateQuery = "UPDATE Record SET Person_Names = @PersonNames WHERE token = @Token";

            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                using (SqlCommand command = new SqlCommand(updateQuery, connection))
                {
                    command.Parameters.AddWithValue("@PersonNames", personNames);
                    command.Parameters.AddWithValue("@Token", token);

                    connection.Open();
                    return command.ExecuteNonQuery();
                }
            }
        }
    }

    public class VisitorDataAccess
    {
        private readonly string connectionString;

        public VisitorDataAccess(string connectionString)
        {
            this.connectionString = connectionString;
        }

        public DataTable GetVisitorStatus()
        {
            string query = "SELECT token, Name, Whometo_Visit, Meet_DateTime, Total_Visitor, IN_time, confirmation " +
"FROM Record " +
"WHERE IN_time IS NOT NULL AND confirmation IS NOT NULL AND OUT_time IS NULL " +
"AND TRY_CONVERT(date, Meet_DateTime, 103) = CONVERT(date, GETDATE())";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    SqlDataAdapter adapter = new SqlDataAdapter(command);
                    DataTable dataTable = new DataTable();
                    adapter.Fill(dataTable);
                    return dataTable;
                }
            }
        }

        public DataTable GetVisitorWithOutTime()
        {
            string query = "SELECT token, Name, Whometo_Visit, Meet_DateTime, Total_Visitor, IN_time, confirmation, OUT_time " +
"FROM Record " +
"WHERE IN_time IS NOT NULL AND confirmation IS NOT NULL AND OUT_time IS NOT NULL " +
"AND TRY_CONVERT(date, Meet_DateTime, 103) = CONVERT(date, GETDATE())";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    SqlDataAdapter adapter = new SqlDataAdapter(command);
                    DataTable dataTable = new DataTable();
                    adapter.Fill(dataTable);
                    return dataTable;
                }
            }
        }

        public DataTable GetPastVisitor()
        {
            string query = "SELECT token, Name, Whometo_Visit, Meet_DateTime, Total_Visitor " +
"FROM Record " +
"WHERE TRY_CONVERT(date, Meet_DateTime, 103) = CAST(GETDATE() AS DATE) " + // Adjust format 103 if needed
"AND TRY_CONVERT(time, Meet_DateTime, 103) < CAST(GETDATE() AS TIME) " + // Adjust format 103 if needed
"AND IN_time IS NULL";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    SqlDataAdapter adapter = new SqlDataAdapter(command);
                    DataTable dataTable = new DataTable();
                    adapter.Fill(dataTable);
                    return dataTable;
                }
            }
        }

        public void UpdatePersonNames(string token, string personNames)
        {
            string query = "UPDATE Record SET Person_Names = @PersonNames WHERE token = @Token";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@PersonNames", personNames);
                    command.Parameters.AddWithValue("@Token", token);

                    connection.Open();
                    command.ExecuteNonQuery();
                }
            }
        }

        public class RecordRepository
        {
            private readonly string _connectionString;

            public RecordRepository(string connectionString)
            {
                _connectionString = connectionString;
            }

            public DataTable GetVisitorStatusRecords()
            {
                string query = "SELECT token, Name, Whometo_Visit, Meet_DateTime, Total_Visitor, IN_time, confirmation " +
                               "FROM Record " +
                               "WHERE IN_time IS NOT NULL AND confirmation IS NOT NULL " +
                               "AND TRY_CONVERT(date, Meet_DateTime, 103) = CONVERT(date, GETDATE())";

                using (SqlConnection connection = new SqlConnection(_connectionString))
                {
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        SqlDataAdapter adapter = new SqlDataAdapter(command);
                        DataTable dataTable = new DataTable();
                        adapter.Fill(dataTable);
                        return dataTable;
                    }
                }
            }

            public DataTable GetCheckedInAndCheckedOutRecords()
            {
                string query = "SELECT token, Name, Whometo_Visit, Meet_DateTime, Total_Visitor, IN_time, confirmation, OUT_time " +
                               "FROM Record " +
                               "WHERE IN_time IS NOT NULL AND confirmation IS NOT NULL AND OUT_time IS NOT NULL " +
                               "AND TRY_CONVERT(date, Meet_DateTime, 103) = CONVERT(date, GETDATE())";

                using (SqlConnection connection = new SqlConnection(_connectionString))
                {
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        SqlDataAdapter adapter = new SqlDataAdapter(command);
                        DataTable dataTable = new DataTable();
                        adapter.Fill(dataTable);
                        return dataTable;
                    }
                }
            }

            public DataTable GetRecordsForCheckIn()
            {
                string query = "SELECT token, Name, Whometo_Visit, Meet_DateTime, Total_Visitor " +
                               "FROM Record " +
                               "WHERE TRY_CONVERT(date, Meet_DateTime, 103) = CAST(GETDATE() AS DATE) " +
                               "AND TRY_CONVERT(time, Meet_DateTime, 103) < CAST(GETDATE() AS TIME) " +
                               "AND IN_time IS NULL";

                using (SqlConnection connection = new SqlConnection(_connectionString))
                {
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        SqlDataAdapter adapter = new SqlDataAdapter(command);
                        DataTable dataTable = new DataTable();
                        adapter.Fill(dataTable);
                        return dataTable;
                    }
                }
            }
        }
    }
}