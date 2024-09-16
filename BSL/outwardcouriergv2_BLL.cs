using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace BSL
{

    public class Outwardcurriergv2_BLL
    {
        private DBL.Outwardcurriergv2_DAL dal = new DBL.Outwardcurriergv2_DAL();

        public DataTable GetSaveOutwardCouriers()
        {
            return dal.GetSaveOutwardCouriers();
        }

        public void UpdateOutwardCourier(int courierEntryNo, string docketNumber, DateTime outDate, TimeSpan outTime, string courierAgency)
        {
            dal.UpdateOutwardCourier(courierEntryNo, docketNumber, outDate, outTime, courierAgency);
        }
        public void UpdateFilePath(int courierEntryNo, string filePath)
        {
            dal.UpdateFilePath(courierEntryNo, filePath);
        }

    }
}
