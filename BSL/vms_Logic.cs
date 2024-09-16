using DBL;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Net.Mail;
using System.Net;
using System.Net.NetworkInformation;
using System.Drawing;
using System.Drawing.Imaging;
using System.Drawing.Text;
using ZXing;
using ZXing.Common;
using static System.Net.Mime.MediaTypeNames;
using System.Xml.Linq;
using static DBL.VisitorDataAccess;

namespace BSL
{
    public class DataService
    {
        private readonly DataAccess _dataAccess;
        public DataService(string connectionString)
        {
            _dataAccess = new DataAccess(connectionString);
        }

        public DataTable GetVisitorNames1()
        {
            return _dataAccess.GetVisitorNames();
        }

        public DataTable GetMobileNumbers()
        {
            return _dataAccess.GetMobileNumbers();
        }

        public DataTable GetMeetingWith()
        {
            return _dataAccess.GetMeetingWith();
        }

        public DataTable GetPlants()
        {
            return _dataAccess.GetPlants();
        }
        public int GetTotalVisitors()
        {
            return _dataAccess.GetTotalVisitors();
        }

        public List<DataAccess.Visitor> GetVisitorDetails()
        {
            return _dataAccess.GetVisitorDetails();
        }

        public int GetVisitorsThisMonth()
        {
            return _dataAccess.GetVisitorsThisMonth();
        }

        public List<DataAccess.Visitor> GetVisitorsThisMonthDetails()
        {
            return _dataAccess.GetVisitorsThisMonthDetails();
        }

        public int GetBounceRate()
        {
            return _dataAccess.GetBounceRate();
        }

        public List<DataAccess.EmployeeVisitor> GetEmployeeRate()
        {
            return _dataAccess.GetEmployeeRate();
        }
        // These methods need to be implemented in DataAccess
        public List<DataAccess.Visitor> GetBounceRateDetails()
        {
            // Assuming the implementation exists in DataAccess
            return _dataAccess.GetVisitorDetails(); // Adjust this as needed
        }

        // Method to get visitor names
        public DataTable GetVisitorNames()
        {
            return _dataAccess.GetVisitorNames();
        }

        public DataTable GetVisitorDetailsByName(string name)
        {
            return _dataAccess.GetVisitorDetailsByName(name);
        }


        // Method to get records by filters
        public DataTable GetRecords(string visitorName, string mobileNumber, string meetingWith, DateTime? fromDate, DateTime? toDate, TimeSpan? inTime, TimeSpan? outTime, string plantNo)
        {
            return _dataAccess.GetRecordsByFilters(visitorName, mobileNumber, meetingWith, fromDate, toDate, inTime, outTime, plantNo);
        }

        public bool SaveDepartment(string departmentName)
        {
            if (string.IsNullOrEmpty(departmentName))
            {
                throw new ArgumentException("Department name cannot be null or empty.");
            }

            int rowsAffected = _dataAccess.InsertDepartment(departmentName);

            return rowsAffected > 0;
        }
        public DataTable GetRecords()
        {
            return _dataAccess.GetRecords();
        }

        public bool UpdateRecord(string token, string personNames)
        {
            int rowsAffected = _dataAccess.UpdateRecord(token, personNames);
            return rowsAffected > 0;
        }
    }

    public class VisitorBusinessLogic
    {
        private readonly VisitorDataAccess dataAccess;

        public VisitorBusinessLogic(string connectionString)
        {
            dataAccess = new VisitorDataAccess(connectionString);
        }

        public DataTable GetVisitorStatus()
        {
            return dataAccess.GetVisitorStatus();
        }

        public DataTable GetVisitorWithOutTime()
        {
            return dataAccess.GetVisitorWithOutTime();
        }

        public DataTable GetPastVisitor()
        {
            return dataAccess.GetPastVisitor();
        }

        public void UpdatePersonNames(string token, string personNames)
        {
            dataAccess.UpdatePersonNames(token, personNames);
        }

        public class RecordService
        {
            private readonly RecordRepository _repository;

            public RecordService(string connectionString)
            {
                _repository = new RecordRepository(connectionString);
            }

            public DataTable GetVisitorStatusRecords()
            {
                return _repository.GetVisitorStatusRecords();
            }

            public DataTable GetCheckedInAndCheckedOutRecords()
            {
                return _repository.GetCheckedInAndCheckedOutRecords();
            }

            public DataTable GetRecordsForCheckIn()
            {
                return _repository.GetRecordsForCheckIn();
            }
        }
    }
}