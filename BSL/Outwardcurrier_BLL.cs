using DBL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BSL
{
    public class Outwardcurrier_BLL
    {
        private readonly Outwardcurrier_DAL currierOutwardDAL = new Outwardcurrier_DAL();

        public DataTable GetSaveOutwardCouriers()
        {
            return currierOutwardDAL.GetSaveOutwardCouriers();
        }

        public void SaveOutwardCourier(string inDate, string inTime, string senderName, string receiverName, string receiverAddress, string receiverCity, string byMode, string packingType, int noOfPacks, string value, string PlantNo)
        {
            ValidateInputs(inDate, inTime, senderName, receiverName, receiverAddress, receiverCity, byMode, packingType, noOfPacks, value);
            currierOutwardDAL.InsertOutwardCourier(inDate, inTime, senderName, receiverName, receiverAddress, receiverCity, byMode, packingType, noOfPacks, value, PlantNo);
        }

        private void InsertOutwardCourier(string inDate, string inTime, string senderName, string receiverName, string receiverAddress, string receiverCity, string byMode, string packingType, int noOfPacks, string value, string plantNo)
        {
            throw new NotImplementedException();
        }

        private void ValidateInputs(string inDate, string inTime, string senderName, string receiverName, string receiverAddress, string receiverCity, string byMode, string packingType, int noOfPacks, string value)
        {
            if (string.IsNullOrWhiteSpace(inDate))
                throw new ArgumentException("InDate is required.", nameof(inDate));
            if (string.IsNullOrWhiteSpace(inTime))
                throw new ArgumentException("InTime is required.", nameof(inTime));
            if (string.IsNullOrWhiteSpace(senderName))
                throw new ArgumentException("SenderName is required.", nameof(senderName));
            if (string.IsNullOrWhiteSpace(receiverName))
                throw new ArgumentException("ReceiverName is required.", nameof(receiverName));
            if (string.IsNullOrWhiteSpace(receiverAddress))
                throw new ArgumentException("ReceiverAddress is required.", nameof(receiverAddress));
            if (string.IsNullOrWhiteSpace(receiverCity))
                throw new ArgumentException("ReceiverCity is required.", nameof(receiverCity));
            if (string.IsNullOrWhiteSpace(byMode))
                throw new ArgumentException("ByMode is required.", nameof(byMode));
            if (string.IsNullOrWhiteSpace(packingType))
                throw new ArgumentException("PackingType is required.", nameof(packingType));
            if (noOfPacks <= 0)
                throw new ArgumentException("NoOfPacks must be greater than zero.", nameof(noOfPacks));
            if (string.IsNullOrWhiteSpace(value))
                throw new ArgumentException("Value is required.", nameof(value));
        }
    }
}
