<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Visitor_Dashboard.aspx.cs" Inherits="vms1.Visitor_Dashboard" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>VISITOR DASHBOARD</title>
    <link rel="icon" href="https://foreselastomech.com/wp-content/uploads/2019/03/FORES-Logo.png" />
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet" />
    <script src="https://unpkg.com/jsqr/dist/jsQR.js"></script>

    <style>
        body {
            font-family: 'Times New Roman';
            overflow: hidden;
        }

        .sidebar {
            position: fixed;
            left: 0;
            top: 0;
            bottom: 0;
            width: 30px;
            height: 800px;
            margin-top: 70px;
            overflow-x: hidden;
            overflow-y: hidden;
            transition: width 0.2s ease;
            background-color: #f8f9fa;
            z-index: 1000;
        }

            .sidebar:hover {
                width: 130px;
            }

            .sidebar .nav-link {
                color: red;
                padding: 25px 25px;
                display: flex;
                align-items: center;
                text-decoration: none;
                color: white;
            }

                .sidebar .nav-link i {
                    margin-right: 5px;
                }

                .sidebar .nav-link span {
                    display: none;
                    margin-left: 10px;
                }

            .sidebar:hover .nav-link span {
                display: inline;
            }

            .sidebar .nav-link:hover {
                background-color: darkgrey; /* Change this to your desired background color */
                border-radius: 4px; /* Optional: adds rounded corners to the background */
            }

        .main-content {
            margin-left: 30px;
            transition: margin-left 0.2s ease;
            padding: 15px;
        }

        @media (max-width: 768px) {
            .sidebar {
                display: none;
            }

                .sidebar.active {
                    display: block;
                    width: 100px;
                    position: fixed;
                    z-index: 1000;
                }

            .main-content {
                margin-left: 0;
            }

            .toggle-sidebar {
                display: block;
                position: fixed;
                top: 10px;
                left: 10px;
                font-size: 24px;
                cursor: pointer;
                z-index: 1100;
            }
        }

        @media (min-width: 769px) {
            .toggle-sidebar {
                display: none;
            }
        }


        .shadow-custom {
            background-color: #f8f9fa; /* Light gray background */
            padding: 10px 15px;
            border-radius: 5px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* Shadow effect */
        }


        .auto-style1 {
            position: relative;
            width: 103%;
            -ms-flex: 0 0 100%;
            flex: 0 0 100%;
            max-width: 100%;
            left: -61px;
            top: 0px;
            padding-left: 15px;
            padding-right: 15px;
        }

        .table-container1 {
            overflow-x: auto; /* Adds horizontal scrollbar if needed */
            height: 135px; /* Adjusted to fit content height */
            width: 138%; /* Make the container width responsive */
            font-size: 13px;
        }

        .table-container2 {
            overflow-x: auto; /* Adds horizontal scrollbar */
            overflow-y: auto; /* Adds vertical scrollbar if needed */
            height: 135px; /* Adjusted to fit content height */
            width: 138%; /* Make the container width responsive */
            font-family: "Times New Roman";
            font-size: 11px;
            margin-top: 45px;
        }

        .table-container3 {
            overflow-x: auto; /* Adds horizontal scrollbar */
            overflow-y: auto; /* Adds vertical scrollbar if needed */
            height: 135px; /* Adjusted to fit content height */
            width: 138%; /* Make the container width responsive */
            font-family: "Times New Roman";
            font-size: 11px;
            margin-top: 60px;
        }

        .table-container4 {
            overflow-x: auto; /* Adds horizontal scrollbar */
            overflow-y: auto; /* Adds vertical scrollbar if needed */
            height: 135px; /* Adjusted to fit content height */
            width: 138%; /* Make the container width responsive */
            font-family: "Times New Roman";
            font-size: 11px;
            margin-top: 80px;
        }

        .scrollable-gridview th {
            background-color: #e0e0e0;
            font-weight: bold;
            font-size: 15px;
            position: sticky;
            top: 0; /* Sticky header */
            z-index: 1;
        }

        /* Media Query for Smaller Screens */
        @media (max-width: 768px) {
            .table-container1 {
                margin-left: 0; /* Remove left margin for smaller screens */
                padding: 0; /* Remove padding if necessary */
            }

                .table-container1 .table {
                    font-size: 0.8rem; /* Adjust font size for smaller screens */
                    min-width: 600px; /* Ensure table width does not shrink too much */
                }

                /* Hide less important columns */
                .table-container1 .hide-on-mobile {
                    display: none; /* Hide columns on smaller screens */
                }
        }

        .edit-button {
            background-color: #4CAF50; /* Green */
            border: none;
            color: white;
            padding: 2px 5px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 14px;
            font-weight: bold;
            margin: 2px 2px;
            cursor: pointer;
            border-radius: 4px;
            margin-left: 40px;
        }

        .update-button {
            background-color: #008CBA; /* Blue */
            border: none;
            color: white;
            padding: 2px 5px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 14px;
            font-weight: bold;
            margin: 2px 2px;
            cursor: pointer;
            border-radius: 4px;
            margin-left: 15px;
        }

        .cancel-button {
            background-color: #f44336; /* Red */
            border: none;
            color: white;
            padding: 2px 5px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 14px;
            font-weight: bold;
            margin: 2px 2px;
            cursor: pointer;
            border-radius: 4px;
            margin-left: 5px;
        }

        /*############################################*/
        /*############################################*/
    </style>

</head>
<body onload="setFocus()">
    <form id="form1" runat="server">
        <div class="container-fluid">

            <%-- EEEEEEEEEEEE111111111111EEEEEEEEEEEe --%>

            <div class="row">

                <div class="container-fluid">
                    <div class="row py-2 " style="background-color: gray;">

                        <div class="col-md-10 text-center">
                            <img src="https://foreselastomech.com/wp-content/uploads/2019/03/FORES-Logo.png" alt="Logo" style="float: left; height: 55px;" />
                            <asp:Label ID="lbl_heading" runat="server" Text="VISITOR DASHBOARD" Font-Size="x-large" Font-Names="Times New Roman" Style="margin-left: 190px;" Font-Bold="true"></asp:Label>
                        </div>
                        <div class="col-md-2 d-flex align-items-center justify-content-end">
                            <asp:Image ID="img_admin" runat="server" ImageUrl="images/admin.png" CssClass="img-fluid" Style="max-height: 30px; max-width: 30px;" />
                            <asp:TextBox ID="txt_userlogin" runat="server" ReadOnly="true" Text="ADMIN" CssClass="form-control text-center ml-2" Font-Size="Small" Font-Bold="true" Font-Names="Times New Roman" Style="font-size: 13px; width: 120px;"></asp:TextBox>
                        </div>
                    </div>
                </div>
            </div>


            <div class="container-fluid">
                <div class="row justify-content-center" style="margin-top: 5px;">
                    <div class="col-md-4 d-flex align-items-center" style="margin-right: 0;">
                        <asp:Label ID="qrLabel" runat="server" Text="SCAN QR" Font-Bold="true" CssClass="mr-2"></asp:Label>
                        <asp:TextBox ID="scannertxt" runat="server" CssClass="form-control border border-dark" placeholder="Scan QR code here" Style="max-width: 200px;"></asp:TextBox>
                        <asp:Button ID="btnOpenCamera" runat="server" Text="OPEN CAMERA" CssClass="btn btn-success ml-3" OnClientClick="opencamere_forconform(); return false;" />
                    </div>
                </div>
            </div>



            <div class="row">
                <div class="toggle-sidebar">
                    <i class="fas fa-ellipsis-v"></i>
                </div>
                <div class="col-md-2 sidebar" style="background-color: gray;">
                    <nav class="nav flex-column">
                        <ul class="menu-list" style="margin-left: -70px; color: black; margin-top: 25px;">
                            <li>
                                <a href="Main_Dashboard.aspx">
                                    <asp:Label ID="Label1" runat="server" Style="color: black; font-size: 14px;" onclick="CreateUser()" class="nav-link">
                                <i class="fas fa-tachometer-alt"></i> MAIN DASHBOARD
                                    </asp:Label>
                                </a>
                            </li>

                            <li>
                                <a href="Report.aspx">
                                    <asp:Label ID="Label2" runat="server" Style="color: black; font-size: 14px;" onclick="CreateUser()" class="nav-link">
                                    <i class="fas fa-file-alt"></i> REPORT
                                    </asp:Label>
                                </a>
                            </li>
                            <li>
                                <a href="Inward.aspx">
                                    <asp:Label ID="lbl_inwardcourier" runat="server" Style="color: black; font-size: 14px;" onclick="Molding()" class="nav-link">
                        <i class="fas fa-inbox"></i> INWARD COURIER
                                    </asp:Label>
                                </a>
                            </li>
                            <li>
                                <a href="Outward.aspx">
                                    <asp:Label ID="lbl_outwardcourier" runat="server" Style="color: black; font-size: 14px;" onclick="PlantMaster()" class="nav-link">
                        <i class="fas fa-paper-plane"></i> OUTWARD COURIER
                                    </asp:Label>
                                </a>
                            </li>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>

        <div class="container mt-2 ml-4">
            <div class="row">
                <div class="col-12 ml-0">
                    <asp:Label ID="Label3" runat="server" Text="<b>UPCOMING VISITOR STATUS</b>"
                        Style="text-align: center; position: fixed; margin-top: -30px; margin-left: 100px; background-color: lightblue; padding-top: 5px; box-shadow: 10px 10px 15px; font-size: 15px;"
                        BackColor="LightGray" Height="26" Width="230"></asp:Label>
                </div>
            </div>

            <div class="row">
                <div class="col-12">
                    <div class="table-responsive table-container1">

                        <asp:GridView ID="GridView1" runat="server" CssClass="table table-bordered table-hover table-striped scrollable-gridview" AutoGenerateColumns="false" AllowPaging="false" OnRowEditing="GridView1_RowEditing" OnRowUpdating="GridView1_RowUpdating" OnRowCancelingEdit="GridView1_RowCancelingEdit" Style="height: 60px;" DataKeyNames="token" OnRowDataBound="GridView1_RowDataBound">
                            <Columns>
                                <asp:BoundField DataField="token" HeaderText="Appl. No." ReadOnly="true" HeaderStyle-CssClass="bg-primary text-white" />
                                <asp:BoundField DataField="Name" HeaderText="Visitor Name" ReadOnly="true" HeaderStyle-CssClass="bg-primary text-white" />
                                <asp:BoundField DataField="Whometo_Visit" HeaderText="Whom to Visit" ReadOnly="true" HeaderStyle-CssClass="bg-primary text-white" />
                                <asp:BoundField DataField="Meet_DateTime" HeaderText="Visit Date Time" ReadOnly="true" HeaderStyle-CssClass="bg-primary text-white" />

                                <asp:TemplateField HeaderText="With Persons" SortExpression="Total_Visitor" HeaderStyle-CssClass="bg-primary text-white">
                                    <ItemTemplate>
                                        <%# Eval("Total_Visitor") %>
                                        <asp:LinkButton ID="EditButton" runat="server" CommandName="Edit" Text="Edit" CssClass="edit-button" />
                                        <asp:LinkButton ID="UpdateButton" runat="server" CommandName="Update" Text="Update" CssClass="update-button" Visible="false" />
                                        <asp:LinkButton ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" CssClass="cancel-button" Visible="false" />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <%# Eval("Total_Visitor") %>
                                        <asp:LinkButton ID="EditButton" runat="server" CommandName="Edit" Text="Edit" CssClass="edit-button" Visible="false" />
                                        <asp:LinkButton ID="UpdateButton" runat="server" CommandName="Update" Text="Update" CssClass="update-button" />
                                        <asp:LinkButton ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" CssClass="cancel-button" />
                                    </EditItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Person 1" SortExpression="Person1" HeaderStyle-CssClass="bg-primary text-white">
                                    <ItemTemplate>
                                        <asp:Label ID="lblPerson1" runat="server" Text='<%# Bind("Person1") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtPerson1" runat="server" CssClass="small-textbox" Text='<%# Eval("Person1") %>' ReadOnly='<%# !GridView1.EditIndex.Equals(Container.DataItemIndex) %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Person 2" SortExpression="Person2" HeaderStyle-CssClass="bg-primary text-white">
                                    <ItemTemplate>
                                        <asp:Label ID="lblPerson2" runat="server" Text='<%# Bind("Person2") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtPerson2" runat="server" CssClass="small-textbox" Text='<%# Eval("Person2") %>' ReadOnly='<%# !GridView1.EditIndex.Equals(Container.DataItemIndex) %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Person 3" SortExpression="Person3" HeaderStyle-CssClass="bg-primary text-white">
                                    <ItemTemplate>
                                        <asp:Label ID="lblPerson3" runat="server" Text='<%# Bind("Person3") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtPerson3" runat="server" CssClass="small-textbox" Text='<%# Eval("Person3") %>' ReadOnly='<%# !GridView1.EditIndex.Equals(Container.DataItemIndex) %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Person 4" SortExpression="Person4" HeaderStyle-CssClass="bg-primary text-white">
                                    <ItemTemplate>
                                        <asp:Label ID="lblPerson4" runat="server" Text='<%# Bind("Person4") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtPerson4" runat="server" CssClass="small-textbox" Text='<%# Eval("Person4") %>' ReadOnly='<%# !GridView1.EditIndex.Equals(Container.DataItemIndex) %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Person 5" SortExpression="Person5" HeaderStyle-CssClass="bg-primary text-white">
                                    <ItemTemplate>
                                        <asp:Label ID="lblPerson5" runat="server" Text='<%# Bind("Person5") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtPerson5" runat="server" CssClass="small-textbox" Text='<%# Eval("Person5") %>' ReadOnly='<%# !GridView1.EditIndex.Equals(Container.DataItemIndex) %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>

            <div>
                <asp:Label ID="Label4" runat="server" Text="<b>IN - VISITOR STATUS</b>" Style="text-align: center; position: fixed; margin-top: 10px; margin-left: 100px; background-color: lightgreen; padding-top: 3px; box-shadow: 10px 10px 15px; font-size: 15px;" BackColor="LightGray" Height="26" Width="230"></asp:Label>
            </div>
            <div class="row">
                <div class="col-12">
                    <div class="table-responsive table-container2">
                        <asp:GridView ID="GridView2" runat="server" CssClass="table table-bordered table-hover table-striped scrollable-gridview" AutoGenerateColumns="false">
                            <Columns>
                                <asp:BoundField DataField="token" HeaderText="Appl. No." ReadOnly="true" HeaderStyle-CssClass="bg-primary text-white" />
                                <asp:BoundField DataField="Name" HeaderText="Visitor Name" ReadOnly="true" HeaderStyle-CssClass="bg-primary text-white" />
                                <asp:BoundField DataField="Whometo_Visit" HeaderText="Whom to Visit" ReadOnly="true" HeaderStyle-CssClass="bg-primary text-white" />
                                <asp:BoundField DataField="Meet_DateTime" HeaderText="Visit Date Time" ReadOnly="true" HeaderStyle-CssClass="bg-primary text-white" />
                                <asp:BoundField DataField="Total_Visitor" HeaderText="With Persons" ReadOnly="true" HeaderStyle-CssClass="bg-primary text-white" />
                                <asp:BoundField DataField="IN_time" HeaderText="In Time" ReadOnly="true" HeaderStyle-CssClass="bg-primary text-white" />
                                <asp:BoundField DataField="confirmation" HeaderText="Confirmation Time" ReadOnly="true" HeaderStyle-CssClass="bg-primary text-white" />
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>

            <div>
                <asp:Label ID="Label5" runat="server" Text="<b>OUT - VISITOR STATUS</b>" Style="text-align: center; position: fixed; margin-top: 5px; margin-left: 100px; background-color: lightgrey; padding-top: 3px; box-shadow: 10px 10px 15px; font-size: 15px;" Height="26" Width="230"
                    BackColor="LightGray"></asp:Label>
            </div>

            <div class="row">
                <div class="col-12">
                    <div class="table-responsive table-container3" style="margin-top: 35px;">
                        <asp:GridView ID="GridView3" runat="server" CssClass="table table-bordered table-hover table-striped scrollable-gridview" AutoGenerateColumns="false" AllowPaging="false">
                            <Columns>
                                <asp:BoundField DataField="token" HeaderText="Appl. No." ReadOnly="true" HeaderStyle-CssClass="bg-primary text-white" />
                                <asp:BoundField DataField="Name" HeaderText="Visitor Name" ReadOnly="true" HeaderStyle-CssClass="bg-primary text-white" />
                                <asp:BoundField DataField="Whometo_Visit" HeaderText="Whom to Visit" ReadOnly="true" HeaderStyle-CssClass="bg-primary text-white" />
                                <asp:BoundField DataField="Meet_DateTime" HeaderText="Visit Date Time" ReadOnly="true" HeaderStyle-CssClass="bg-primary text-white" />
                                <asp:BoundField DataField="Total_Visitor" HeaderText="With Persons" ReadOnly="true" HeaderStyle-CssClass="bg-primary text-white" />
                                <asp:BoundField DataField="IN_time" HeaderText="In Time" ReadOnly="true" HeaderStyle-CssClass="bg-primary text-white" />
                                <asp:BoundField DataField="confirmation" HeaderText="Confirmation Time" ReadOnly="true" HeaderStyle-CssClass="bg-primary text-white" />
                                <asp:BoundField DataField="OUT_time" HeaderText="Out Time" ReadOnly="true" HeaderStyle-CssClass="bg-primary text-white" />
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>

            <div>
                <asp:Label ID="Label6" runat="server" Text="<b>CANCELATION STATUS</b>" Style="text-align: center; position: fixed; margin-top: 10px; margin-left: 100px; background-color: lightcoral; padding-top: 3px; box-shadow: 10px 10px 15px; font-size: 15px;"
                    BackColor="LightGray" Height="26" Width="230"></asp:Label>

            </div>

            <div class="row">
                <div class="col-12">
                    <div class="table-responsive table-container4" style="margin-top: 40px;">
                        <asp:GridView ID="GridView4" runat="server" CssClass="table table-bordered table-hover table-striped scrollable-gridview" AutoGenerateColumns="false" AllowPaging="false">
                            <Columns>
                                <asp:BoundField DataField="token" HeaderText="Appl. No." ReadOnly="true" HeaderStyle-CssClass="bg-primary text-white" />
                                <asp:BoundField DataField="Name" HeaderText="Visitor Name" ReadOnly="true" HeaderStyle-CssClass="bg-primary text-white" />
                                <asp:BoundField DataField="Whometo_Visit" HeaderText="Whom to Visit" ReadOnly="true" HeaderStyle-CssClass="bg-primary text-white" />
                                <asp:BoundField DataField="Meet_DateTime" HeaderText="Visit Date Time" ReadOnly="true" HeaderStyle-CssClass="bg-primary text-white" />
                                <asp:BoundField DataField="Total_Visitor" HeaderText="With Persons" ReadOnly="true" HeaderStyle-CssClass="bg-primary text-white" />
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>

        </div>

        <div id="camera-preview" class="col-ml-6"></div>

        <div class="logout-section d-flex justify-content-end align-items-center p-1" style="position: fixed; bottom: 0; right: 0;">
            <a href="#" class="text-danger d-flex align-items-center logout-btn" style="text-decoration: none;" onclick="logout()">
                <i class="fas fa-sign-out-alt fa-3x"></i>
                <span class="ml-2 d-none d-md-inline"></span>
            </a>
        </div>

    </form>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>


    <script>
        document.querySelector(".logout-btn").addEventListener("click", function (event) {
            event.preventDefault(); // Prevent default navigation

            // Send an asynchronous POST request to the server for logout
            fetch('/Visitor_Dashboard.aspx', { // Replace with your actual logout handler URL
                method: 'POST'
            })
                .then(response => {
                    if (response.ok) {
                        // Logout successful, clear session information (client-side)
                        sessionStorage.clear(); // Clear session storage for client-side data

                        // Replace the current URL in the browser history with the login page
                        history.replaceState(null, null, '/Login.aspx');

                        // Redirect to login page
                        window.location.href = '/Login.aspx';
                    } else {
                        console.error('Logout failed with status:', response.status);
                        // Handle logout failure (optional: display error message)
                    }
                })
                .catch(error => {
                    console.error('Error logging out:', error);
                    // Handle network errors (optional: display error message)
                });
        });

        var isSaveMessageShown = false;
        function handleTextChange(scannertxt) {
            var code = scannertxt.value;

            // Your custom logic here
            console.log("Text changed heresc sc scs cs c   : " + code);
            var dataFromQR = splitQRCodeData(code); // Assuming splitQRCodeData is defined elsewhere


            saveQRDataToDatabase(code);
            // Assuming saveQRDataToDatabase is defined elsewhere
            scannertxt.value = "";

        }

        function splitQRCodeData(data) {
            // Split the QR code data using '/' as the delimiter
            const parts = data.split('/');
            // Extract date and time parts (6th, 7th, and 8th indexes), excluding the 9th index
            const dateAndTime = `${parts[5]} ${parts[6]} ${parts[7]}`;
            return [...parts.slice(0, 5), dateAndTime];
        }


        function saveQRDataToDatabase(qrData) {
            if (isSaveMessageShown) return;


            var token = extractTokenFromQRData(qrData); // Implement this function to extract token from qrData

            fetch('/Home/SaveQRData', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ qrData: qrData })
            })
                .then(response => {
                    if (response.ok) {
                        return response.text();
                    } else {
                        throw new Error('Failed to save QR data');
                    }
                })
                .then(message => {
                    isSaveMessageShown = true;
                    alert(message);
                })
                .catch(error => {
                    console.error('Error saving QR data:', error);

                });
        }

        function extractTokenFromQRData(qrData) {
            // Implement your logic to extract the token from qrData
            // For example, if qrData is a string in the format "data1/data2/token/data4", you can split it
            var parts = qrData.split('/');
            return parts[9]; // Assuming the token is at the third position
        }

        function setFocus() {
            // Get a reference to the textbox
            var textBox = document.getElementById('<%= scannertxt.ClientID %>');

            // Set focus on the textbox
            textBox.focus();
        }

        function debounce(func, wait) {
            let timeout;
            return function (...args) {
                const later = () => {
                    clearTimeout(timeout);
                    func(...args);
                };
                clearTimeout(timeout);
                timeout = setTimeout(later, wait);
            };
        }
        document.addEventListener('DOMContentLoaded', (event) => {
            var scannerInput = document.getElementById('scannertxt');
            const debouncedHandleTextChange = debounce(() => handleTextChange(scannerInput), 400);

            scannerInput.addEventListener('input', debouncedHandleTextChange);
        });

        function opencamere_forconform() {
            if (navigator.mediaDevices && navigator.mediaDevices.getUserMedia) {
                var existingVideo = document.querySelector('video');
                if (existingVideo) {
                    existingVideo.srcObject.getTracks().forEach(track => track.stop());
                    existingVideo.remove();
                    return;
                }

                navigator.mediaDevices.getUserMedia({ video: { facingMode: 'environment' } })
                    .then(function (stream) {
                        var video = document.createElement('video');
                        video.setAttribute('autoplay', '');
                        video.setAttribute('playsinline', '');
                        video.style.position = 'fixed';
                        video.style.top = '15vh';
                        video.style.left = '35vh';
                        video.style.width = '70%';
                        video.style.height = '82%';
                        video.style.objectFit = 'cover';
                        video.style.zIndex = '1';
                        video.srcObject = stream;
                        document.body.appendChild(video);

                        let intervalId = setInterval(function () {
                            var canvas = document.createElement('canvas');
                            canvas.width = video.videoWidth;
                            canvas.height = video.videoHeight;
                            var context = canvas.getContext('2d');
                            context.drawImage(video, 0, 0, canvas.width, canvas.height);
                            var imageData = context.getImageData(0, 0, canvas.width, canvas.height);
                            var code = jsQR(imageData.data, imageData.width, imageData.height);

                            if (code) {
                                console.log('QR code detected:', code.data);
                                clearInterval(intervalId);

                                // Stop the video stream
                                video.srcObject.getTracks().forEach(track => track.stop());
                                video.remove();

                                // Ensure that code.data is valid
                                if (code.data && code.data.trim() !== '') {
                                    saveQRDataToDatabase(code.data); // Pass the detected QR data to the function
                                } else {
                                    console.error('Detected QR data is invalid or empty:', code.data);
                                }
                            } else {
                                console.log('No QR code detected.');
                            }
                        }, 100);
                    })
                    .catch(function (error) {
                        console.error('Error accessing camera:', error);
                    });
            } else {
                alert('getUserMedia is not supported in this browser');
            }
        }

    </script>
</body>
</html>
