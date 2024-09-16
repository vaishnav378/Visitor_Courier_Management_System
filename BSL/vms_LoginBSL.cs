using DBL;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using static DBL.vms_LoginDAL;

namespace BSL
{
    public class vms_LoginBSL
    {
        private readonly vms_LoginDAL loginDAL;
        private readonly vms_LoginDAL userDAL;

        // Constructor that accepts a connection string
        public vms_LoginBSL(string connectionString)
        {
            // Initialize DAL with the connection string
            loginDAL = new vms_LoginDAL(connectionString);
            userDAL = new vms_LoginDAL(connectionString);
        }
        public bool RegisterUser(string userId, string userName, string mobileNo, string email, string password, string plantCode, string userType)
        {
            // Call DAL to insert the user
            return userDAL.InsertUser(userId, userName, mobileNo, email, password, plantCode, userType);
        }

        public bool UpdateUser(string userName, string email, string mobileNo, string password, string userType, string plantCode)
        {
            return userDAL.UpdateUser(userName, email, mobileNo, password, userType, plantCode);
        }

        public User GetUserDetailsByName(string userName)
        {
            return userDAL.GetUserDetailsByName(userName);
        }

        public List<string> GetVisitorNames()
        {
            return userDAL.GetVisitorNames();
        }

        public bool ValidateUser(string userId, string password, out string userType, out string userName, out string email, out string plantCode)
        {
            userType = string.Empty;
            userName = string.Empty;
            email = string.Empty;
            plantCode = string.Empty;

            SqlDataReader reader = loginDAL.GetUserDetails(userId);

            if (reader.Read())
            {
                string userpass = reader["Password"].ToString();
                userType = reader["user_type"].ToString();
                userName = reader["User_Name"].ToString();
                email = reader["Email"].ToString();
                plantCode = reader["PlantCode"].ToString();
                reader.Close();

                return password.Trim() == userpass.Trim();
            }
            reader.Close();
            return false;
        }

        public bool CheckUserExists(string userId)
        {
            return loginDAL.CheckUserExists(userId) > 0;
        }
    }
}