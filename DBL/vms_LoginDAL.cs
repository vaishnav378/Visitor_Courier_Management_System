using Microsoft.Extensions.Configuration;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections.Generic;

namespace DBL
{
    public class vms_LoginDAL
    {
        private readonly string connectionString;

        // Constructor that accepts a connection string
        public vms_LoginDAL(string connectionString)
        {
            this.connectionString = connectionString;
        }
        public bool InsertUser(string userId, string userName, string mobileNo, string email, string password, string plantCode, string userType)
        {
            string query = "INSERT INTO Master_User (User_ID, User_Name, Mob_No, Email, Password, PlantCode, user_type) " +
                           "VALUES (@UserID, @UserName, @MobileNo, @Email, @Password, @PlantCode, @user_type)";
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@UserID", userId);
                    cmd.Parameters.AddWithValue("@UserName", userName);
                    cmd.Parameters.AddWithValue("@MobileNo", mobileNo);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@Password", password);
                    cmd.Parameters.AddWithValue("@PlantCode", plantCode);
                    cmd.Parameters.AddWithValue("@user_type", userType);

                    con.Open();
                    return cmd.ExecuteNonQuery() > 0;
                }
            }
        }

        public bool UpdateUser(string userName, string email, string mobileNo, string password, string userType, string plantCode)
        {
            string query = "UPDATE Master_User SET Email = @Email, Mob_No = @MobileNo, Password = @Password, " +
                           "user_type = @UserType, PlantCode = @PlantCode WHERE User_Name = @UserName";
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@UserName", userName);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@MobileNo", mobileNo);
                    cmd.Parameters.AddWithValue("@Password", password);
                    cmd.Parameters.AddWithValue("@UserType", userType);
                    cmd.Parameters.AddWithValue("@PlantCode", plantCode);

                    con.Open();
                    return cmd.ExecuteNonQuery() > 0;
                }
            }
        }

        public User GetUserDetailsByName(string userName)
        {
            string query = "SELECT User_ID, User_Name, Mob_No, Email, Password, PlantCode, user_type " +
                           "FROM Master_User WHERE User_Name = @UserName";
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@UserName", userName);
                    con.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            return new User
                            {
                                UserId = reader["User_ID"].ToString(),
                                UserName = reader["User_Name"].ToString(),
                                MobileNo = reader["Mob_No"].ToString(),
                                Email = reader["Email"].ToString(),
                                Password = reader["Password"].ToString(),
                                PlantCode = reader["PlantCode"].ToString(),
                                UserType = reader["user_type"].ToString()
                            };
                        }
                    }
                }
            }
            return null;
        }

        public class User
        {
            public string UserId { get; set; }
            public string UserName { get; set; }
            public string MobileNo { get; set; }
            public string Email { get; set; }
            public string Password { get; set; }
            public string PlantCode { get; set; }
            public string UserType { get; set; }
        }
        public List<string> GetVisitorNames()
        {
            List<string> visitorNames = new List<string>();
            string query = "SELECT User_Name FROM Master_User";
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            visitorNames.Add(reader["User_Name"].ToString());
                        }
                    }
                }
            }
            return visitorNames;
        }

        public SqlDataReader GetUserDetails(string userId)
        {
            SqlConnection con = new SqlConnection(connectionString);
            string query = "SELECT Password, user_type, User_Name, Email, PlantCode FROM Master_User WHERE User_ID = @User_ID";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@User_ID", userId);
            con.Open();

            // Execute the query and return the reader object to BLL
            return cmd.ExecuteReader(System.Data.CommandBehavior.CloseConnection);
        }

        public int CheckUserExists(string userId)
        {
            SqlConnection con = new SqlConnection(connectionString);
            string query = "SELECT COUNT(*) FROM Master_User WHERE User_ID = @UserId";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@UserId", userId);
            con.Open();
            int count = (int)cmd.ExecuteScalar();
            con.Close();
            return count;
        }
    }
}