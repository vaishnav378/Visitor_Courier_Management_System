<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="image.aspx.cs" Inherits="vms1.ShowImage" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Show Image</title>
</head>
<body>
    <form id="form1" runat="server">
        <div style="text-align:center;">
            <asp:Image ID="imgCourierReceipt" runat="server" ImageUrl='<%# "image.aspx?CourierEntryNo=" + Request.QueryString["CourierEntryNo"] %>' />
        </div>
    </form>
</body>
</html>