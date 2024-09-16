using Microsoft.AspNet.SignalR;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace VMS
{
    public class ChatHub : Hub
    {
        public async Task ReceiveVisitorCount(int newCount)
        {
            await Clients.All.SendAsync("ReceiveVisitorCount", newCount);
        }
        public async Task UpdateVisitorStatus(string updatedStatusJson)
        {
            await Clients.All.SendAsync("UpdateVisitorStatus", updatedStatusJson);
        }
    }
}