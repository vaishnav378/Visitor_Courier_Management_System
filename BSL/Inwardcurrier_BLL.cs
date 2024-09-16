using DBL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BSL
{
    public class Inwardcurrier_BLL
    {
        Inwardcurrier_DAL currierDAL = new Inwardcurrier_DAL();

        public DataTable GetAllInwardCouriers(string receiverName)
        {
            return currierDAL.GetAllInwardCouriers(receiverName);
        }
        public DataTable GetAllInwardCouriers()
        {
            return currierDAL.GetAllInwardCouriers(); // Updated call without parameters
        }


        public DataTable GetVisitorNames()
        {
            return currierDAL.GetVisitorNames();
        }

        public void SaveInwardCourier(string inDate, string inTime, string courierAgency, string docketNumber, string senderName, string senderCity, string byMode, string receiptPacking, int noOfPacks, string receiverName, string remark)
        {
            // Add any business logic here if needed
            ValidateInputs(inDate, inTime, courierAgency, docketNumber, senderName, senderCity, byMode, receiptPacking, noOfPacks, receiverName, remark);

            // Fetch the Plant_No based on receiverName
            string plantNo = currierDAL.GetPlantNoByReceiverName(receiverName);

            if (string.IsNullOrEmpty(plantNo))
            {
                throw new ArgumentException("Invalid Receiver Name. Plant number not found.");
            }

            // Call the data access layer to save the data
            currierDAL.InsertInwardCourier(inDate, inTime, courierAgency, docketNumber, senderName, senderCity, byMode, receiptPacking, noOfPacks, receiverName, remark, plantNo);
        }
        private void ValidateInputs(string inDate, string inTime, string courierAgency, string docketNumber, string senderName, string senderCity, string byMode, string receiptPacking, int noOfPacks, string receiverName, string remark)
        {
            if (string.IsNullOrWhiteSpace(inDate))
                throw new ArgumentException("InDate is required.", nameof(inDate));
            if (string.IsNullOrWhiteSpace(inTime))
                throw new ArgumentException("InTime is required.", nameof(inTime));
            if (string.IsNullOrWhiteSpace(courierAgency))
                throw new ArgumentException("CourierAgency is required.", nameof(courierAgency));
            if (string.IsNullOrWhiteSpace(docketNumber))
                throw new ArgumentException("DocketNumber is required.", nameof(docketNumber));
            if (string.IsNullOrWhiteSpace(senderName))
                throw new ArgumentException("SenderName is required.", nameof(senderName));
            if (string.IsNullOrWhiteSpace(senderCity))
                throw new ArgumentException("SenderCity is required.", nameof(senderCity));
            if (string.IsNullOrWhiteSpace(byMode))
                throw new ArgumentException("ByMode is required.", nameof(byMode));
            if (string.IsNullOrWhiteSpace(receiptPacking))
                throw new ArgumentException("ReceiptPacking is required.", nameof(receiptPacking));
            if (noOfPacks <= 0)
                throw new ArgumentException("NoOfPacks must be greater than zero.", nameof(noOfPacks));
            if (string.IsNullOrWhiteSpace(receiverName))
                throw new ArgumentException("ReceiverName is required.", nameof(receiverName));
            if (string.IsNullOrWhiteSpace(remark))
                throw new ArgumentException("Remark is required.", nameof(remark));
        }
    }
}