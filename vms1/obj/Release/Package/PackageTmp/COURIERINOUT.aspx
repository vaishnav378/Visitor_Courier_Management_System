<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="COURIERINOUT.aspx.cs" Inherits="vms1.COURIERINOUT" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Courier In Out</title>
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <link rel="icon" href="https://foreselastomech.com/wp-content/uploads/2019/03/FORES-Logo.png" />

    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" />

    <style>
        /* General Styling */
        body {
            font-family: 'Times New Roman', serif;
            overflow: hidden;
        }

        /* Sidebar Styling */
        .sidebar {
            position: fixed;
            left: 0;
            top: 0;
            bottom: 0;
            width: 30px;
            height: 900px;
            margin-top: 70px;
            overflow-x: hidden;
            transition: width 0.2s ease;
            background-color: #f8f9fa;
            z-index: 1000;
        }

            .sidebar:hover {
                width: 180px !important; /* Expanded width on hover */
            }

            .sidebar .nav-link {
                color: white;
                padding: 25px 12px;
                display: flex;
                align-items: center;
                text-decoration: none;
            }

                .sidebar .nav-link i {
                    margin-right: 5px;
                    padding-top: 15px;
                }

                .sidebar .nav-link span {
                    display: none;
                    margin-left: 1px;
                    padding-top: 15px;
                }

            .sidebar:hover .nav-link span {
                display: inline;
            }

            .sidebar .nav-link:hover {
                background-color: darkgrey; /* Background color on hover */
                border-radius: 4px;
            }

            .sidebar .logout {
                margin-top: auto;
                background-color: red;
                color: white;
            }

        /* Main Content */
        .main-content {
            margin-left: 30px;
            transition: margin-left 0.2s ease;
            padding: 15px;
        }

        /* Toggle Sidebar for Mobile */
        .toggle-sidebar {
            display: none;
        }

        @media (max-width: 768px) {
            .sidebar {
                display: none; /* Hide sidebar on small screens */
            }

                .sidebar.active {
                    display: block;
                    width: 200px;
                }

            .main-content {
                margin-left: 0;
            }

            .toggle-sidebar {
                display: block;
                align-items: center;
                position: fixed;
                top: 10px;
                left: 10px;
                font-size: 10px;
                cursor: pointer;
                z-index: 1100;
            }
        }

        @media (min-width: 769px) {
            .toggle-sidebar {
                display: none;
            }
        }

        /* Add this to your CSS file or within a <style> tag in the head section */
        .large-checkbox input[type="checkbox"] {
            width: 30px;
            height: 25px;
            transform: scale(1.5);
            margin-left: 33px;
            margin-top: 10px;
            appearance: none;
            background-color: #fff;
            border: 2px solid #ccc;
            border-radius: 3px;
            position: relative;
            cursor: pointer;
        }

            .large-checkbox input[type="checkbox"]:checked {
                border-color: green;
            }

                .large-checkbox input[type="checkbox"]:checked::after {
                    content: '';
                    position: absolute;
                    left: 12px;
                    top: 6px;
                    width: 5px;
                    height: 11px;
                    border: solid green;
                    border-width: 0 2px 2px 0;
                    transform: rotate(45deg);
                }


        /* Table Styling */
        .table-container {
            overflow-x: auto;
            overflow-y: auto;
            height: 230px;
            width: auto;
            font-family: 'Times New Roman', serif;
            font-size: 11px;
            margin-top: -5px;
        }

        .table-container1 {
            overflow-x: auto;
            overflow-y: auto;
            height: 220px;
            width: auto;
            font-family: 'Times New Roman', serif;
            font-size: 11px;
        }

        .table-container2 {
            height: 220px;
            width: auto;
            font-family: 'Times New Roman', serif;
            font-size: 11px;
        }

        .table-responsive {
            max-height: 230px;
            overflow-y: auto;
        }

        .table-bordered-all {
            border-collapse: collapse;
            width: 100%;
            border-color: black;
        }

            .table-bordered-all th, .table-bordered-all td {
                border: 1px solid black;
                padding: 8px;
            }

            .table-bordered-all thead th {
                background-color: lightgray;
                border-bottom: 2px solid black;
            }

            .table-bordered-all tbody tr:last-child td {
                border-bottom: 1px solid black;
            }

        .scrollable-gridview {
            width: 100%;
            overflow-x: auto;
        }

            .scrollable-gridview th, .scrollable-gridview td {
                border: 1px solid #ddd;
                padding: 8px;
                text-align: left;
            }

            .scrollable-gridview th {
                background-color: #f2f2f2;
                color: #333;
                position: sticky;
                top: 0;
                z-index: 2;
                font-size: 14px;
            }

            .scrollable-gridview tr:nth-child(even) {
                background-color: #f9f9f9;
            }

            .scrollable-gridview tr:hover {
                background-color: #f1f1f1;
            }

        /* Form Control Styling */
        .custom-form-control,
        .custom-form-select {
            width: 100%;
            max-width: 300px;
        }

        /* Responsive Adjustments */
        @media (max-width: 768px) {
            .table-container {
                font-size: 10px;
                height: 200px;
                margin-top: 0;
            }

            .table {
                width: 100%;
            }

            .form-control,
            .form-select {
                font-size: 10px;
            }
        }

        .small-font {
            font-size: 13px;
        }

        .grid-header th {
            font-size: 15px;
        }


        .table-responsive {
            max-height: 230px; /* Adjust height as needed */
            overflow-y: auto; /* Adds vertical scroll if content overflows */
        }

        .table-responsive1 {
            margin-left: 45px;
            width: 96%;
            margin-top: 45px;
        }

        @media screen and (max-width: 768px) {
            .scrollable-gridview th,
            .scrollable-gridview td {
                font-size: 12px; /* Adjust font size for smaller screens */
                padding: 5px; /* Adjust padding for smaller screens */
            }

            .scrollable-gridview .btn {
                font-size: 10px; /* Smaller button size for mobile */
                padding: 2px 5px;
            }
        }
    </style>

    <script>
        function toggleByMode() {
            var ddlByMode = document.getElementById('<%= ddlByMode.ClientID %>');
            var txtByMode = document.getElementById('<%= txtByMode.ClientID %>');

            if (ddlByMode.value === 'Other') {
                txtByMode.style.display = 'block';
                ddlByMode.style.display = "none";
            } else {
                txtByMode.style.display = 'none';

            }
        }



        function toggleReceiptPacking() {
            var ddlReceiptPacking = document.getElementById('<%= ddlReceiptPacking.ClientID %>');
            var txtReceiptPacking = document.getElementById('<%= txtReceiptPacking.ClientID %>');

            if (ddlReceiptPacking.value === 'Other') {
                txtReceiptPacking.style.display = 'block';
                ddlReceiptPacking.style.display = "none";
            } else {
                txtReceiptPacking.style.display = 'none';

            }
        }



        function setCurrentDate() {
            var currentDate = new Date();
            var day = ("0" + currentDate.getDate()).slice(-2);
            var month = ("0" + (currentDate.getMonth() + 1)).slice(-2);
            var year = currentDate.getFullYear();
            var formattedDate = day + "/" + month + "/" + year;

            document.getElementById('<%= txtInDate.ClientID %>').value = formattedDate;
        }

        function setCurrentTime() {
            var currentTime = new Date();
            var hours = ("0" + currentTime.getHours()).slice(-2);
            var minutes = ("0" + currentTime.getMinutes()).slice(-2);
            var seconds = ("0" + currentTime.getSeconds()).slice(-2);
            var formattedTime = hours + ":" + minutes + ":" + seconds;

            document.getElementById('<%= txtInTime.ClientID %>').value = formattedTime;
        }

    </script>



</head>
<body>
    <form id="form1" runat="server">
        <div class="container-fluid">

            <%-- EEEEEEEEEEEE111111111111EEEEEEEEEEEe --%>


            <div class="row">

                <div class="container-fluid">
                    <div class="row py-2 " style="background-color: gray;">

                        <div class="col-md-10 text-center">
                            <img src="https://foreselastomech.com/wp-content/uploads/2019/03/FORES-Logo.png" alt="Logo" style="float: left; height: 55px;" />
                            <asp:Label ID="lbl_heading" runat="server" Text="COURIER IN OUT " Font-Size="x-large" Font-Names="Times New Roman" Style="margin-left: 180px" Font-Bold="true"></asp:Label>
                        </div>
                        <div class="col-md-2 d-flex align-items-center justify-content-end">
                            <asp:Image ID="img_admin" runat="server" ImageUrl="images/admin.png" CssClass="img-fluid" Style="max-height: 30px; max-width: 30px;" />
                            <asp:TextBox ID="txt_userlogin" runat="server" ReadOnly="true" Text="ADMIN" CssClass="form-control text-center ml-2" Font-Size="Small" Font-Bold="true" Font-Names="Times New Roman" Style="font-size: 11.5px; width: 140px;"></asp:TextBox>
                        </div>
                    </div>
                </div>
            </div>




            <div class="row">
                <div class="toggle-sidebar">
                    <i class="fas fa-ellipsi s-v"></i>
                </div>

                <div class="col-md-2 sidebar" style="background-color: gray;">
                    <nav class="nav flex-column" style="width: 250px;">
                        <ul class="menu-list" style="margin-left: -60px; color: black; margin-top: 35px;">
                            <li class="nav-item">

                                <asp:Panel ID="panel_MainDashboard" runat="server" CssClass="nav-link">
                                    <a href="Main_Dashboard.aspx">
                                        <i class="fas fa-tachometer-alt sidebar-icon" style="color: black"></i>
                                        <asp:Label ID="lbl_MainDashboard" runat="server" Style="color: black; font-size: 15px;" Text="MAIN DASHBOARD"></asp:Label>
                                    </a>
                                </asp:Panel>

                                <asp:Panel ID="panel_Report" runat="server" CssClass="nav-link">
                                    <a href="Report.aspx">
                                        <i class="fas fa-file-alt sidebar-icon" style="color: black"></i>
                                        <asp:Label ID="Label3" runat="server" Style="color: black; font-size: 15px;" Text="REPORT"></asp:Label>
                                    </a>
                                </asp:Panel>


                                <asp:Panel ID="panel_InviteVisitor" runat="server" CssClass="nav-link">
                                    <a href="Registration_Invite.aspx">
                                        <i class="fas fa-user-plus sidebar-icon" style="color: black"></i>
                                        <asp:Label ID="lbl_InviteVisitor" runat="server" Style="color: black; font-size: 15px;" Text="INVITE VISITOR"></asp:Label>
                                    </a>
                                </asp:Panel>
                            </li>
                            <li class="nav-item">
                                <asp:Panel ID="panel_ConfirmMeeting" runat="server" CssClass="nav-link">
                                    <a href="Meeting_Confirmation.aspx">
                                        <i class="fas fa-door-open sidebar-icon" style="color: black"></i>
                                        <asp:Label ID="lbl_ConfirmMeeting" runat="server" Style="color: black; font-size: 14px;" Text="SIGN VISITOR PASS"></asp:Label>
                                    </a>
                                </asp:Panel>
                            </li>

                            <li class="nav-item">
                                <asp:Panel ID="panel_CourierInOut" runat="server" CssClass="nav-link">
                                    <a href="CourierInOut.aspx">
                                        <i class="fas fa-box sidebar-icon" style="color: black"></i>
                                        <asp:Label ID="lbl_CourierInOut" runat="server" Style="color: black; font-size: 14px; margin-left: 1px;" Text="COURIER IN-OUT"></asp:Label>
                                    </a>
                                </asp:Panel>
                            </li>

                        </ul>
                    </nav>
                </div>
            </div>







            <div class="container-fluid" style="margin-left: 10px;">

                <div>
                    <asp:Label ID="Label2" runat="server" Text="<b>INWARD COURIER STATUS</b>" Style="text-align: center; margin: 4px; padding-top: 3px; box-shadow: 10px 10px 15px; font-size: 13px;" BackColor="LightGray" Height="30" Width="200"></asp:Label>
                </div>

                <div class="table-container1">
                    <asp:GridView ID="InwardICSGridView1" runat="server" CssClass="scrollable-gridview"
                        AutoGenerateColumns="False" OnRowDataBound="InwardICSGridView1_RowDataBound">
                        <Columns>
                            <asp:BoundField DataField="Currier_Entry_No" HeaderText="Sr.No" />
                            <asp:BoundField DataField="Currier_Inward_Date" HeaderText="In_Date" />
                            <asp:BoundField DataField="Currier_Inward_Time" HeaderText="In_Time" />
                            <asp:BoundField DataField="Courier_Agency" HeaderText="Courier_Agency" />
                            <asp:BoundField DataField="Docket_Number" HeaderText="Docket_Number" />
                            <asp:BoundField DataField="Courier_Sender_Name" HeaderText="Sender_Name" />
                            <asp:BoundField DataField="Sender_City" HeaderText="Sender_City" />
                            <asp:BoundField DataField="Receipt_By_mode" HeaderText="By_Mode" />
                            <asp:BoundField DataField="Receipt_Packing" HeaderText="Receipt_Packing" />
                            <asp:BoundField DataField="No_of_Packs" HeaderText="No_of_Packs" />
                            <asp:BoundField DataField="Currier_Receiver_Name " HeaderText="Receiver_Name" />
                            <asp:BoundField DataField="Remarks" HeaderText="Remarks" />
                            <asp:TemplateField HeaderText="Update Rec. Sta.">
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkReceiptStatus" runat="server" AutoPostBack="true" CssClass="large-checkbox" OnCheckedChanged="chkReceiptStatus_CheckedChanged" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>





        <div class="container-fluid" style="margin-left: 10px;">
            <div>
                <asp:Label ID="Label1" runat="server" Text="<b>OUTWARD COURIER STATUS</b>" Style="text-align: center; margin: 2px; padding-top: 3px; box-shadow: 10px 10px 15px; font-size: 13px; margin-left: 10px" BackColor="LightGray" Height="25" Width="200"></asp:Label>
            </div>
            <div class="table-container2" style="margin-left: 10px;">
                <div class="table-responsive">
                    <asp:GridView ID="gvOutwardCouriers" runat="server" CssClass="scrollable-gridview" AutoGenerateColumns="false"
                        AllowPaging="false" OnRowCommand="gvOutwardCouriers_RowCommand">
                        <Columns>
                            <asp:BoundField DataField="Courier_Entry_No" HeaderText="Sr.No" HeaderStyle-Width="50" />
                            <asp:BoundField DataField="Currier_Entry_Date" HeaderText="Entry Date" />
                            <asp:BoundField DataField="Currier_Entry_Time" HeaderText="Entry Time" />
                            <asp:BoundField DataField="Courier_Sender_Name" HeaderText="Sender Name" />
                            <asp:BoundField DataField="Courier_Receiver_Name" HeaderText="Receiver Name" ItemStyle-CssClass="text-center" />
                            <asp:BoundField DataField="Courier_Receiver_Address" HeaderText="Receiver Address" ItemStyle-CssClass="text-center" />
                            <asp:BoundField DataField="Receiver_City" HeaderText="Receiver City" />
                            <asp:BoundField DataField="By_Mode" HeaderText="By Mode" />
                            <asp:BoundField DataField="Packing_Type" HeaderText="Packing Type" />
                            <asp:BoundField DataField="Number_of_Packs" HeaderText="No of Packs" />
                            <asp:BoundField DataField="Value" HeaderText="Value" />
                            <asp:BoundField DataField="Courier_Agency" HeaderText="Courier Agency" />
                            <asp:BoundField DataField="Docket_Number" HeaderText="Docket Number" />
                            <asp:BoundField DataField="Courier_Out_Date" HeaderText="Out Date" />
                            <asp:BoundField DataField="Courier_Out_Time" HeaderText="Out Time" />
                            <asp:TemplateField HeaderText="Attach Receipt">
                                <ItemTemplate>
                                    <asp:Button ID="btnViewImage" runat="server" CommandName="ViewImage" Width="70" CssClass="btn btn-outline-info btn-sm" Style="font-size: 11px" CommandArgument='<%# Eval("Courier_Entry_No") %>' Text="View Image" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Receipt Status">
                                <ItemTemplate>
                                    <%# GetReceiptStatus(Eval("Attach_Courier_Receipt")) %>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>



        <div>
            <asp:Label ID="lbl_Inwardcurrierentry" runat="server" Text="<b>OUTWARD COURIER UPDATE</b>" Style="text-align: center; margin: 4px; padding-top: 3px; box-shadow: 10px 10px 15px; font-size: 13px; position: absolute; top: 580px; left: 35px;" BackColor="LightGray" Height="25" Width="200"></asp:Label>
        </div>
        <div class="table-responsive1">
            <table class="table table-bordered table-bordered-all">
                <thead style="background-color: lightgray;">
                    <tr>
                        <th>In Date</th>
                        <th>In Time</th>
                        <th>Sender_Name</th>
                        <th>Receiver_Name</th>
                        <th>Receiver_Address</th>
                        <th>Receiver_City</th>
                        <th>By_Mode</th>
                        <th>Packing_Type</th>
                        <th>No_of_Packs</th>
                        <th>Value</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>
                            <asp:TextBox ID="txtInDate" runat="server" CssClass="form-control custom-form-control" onclick="setCurrentDate()" />
                        </td>
                        <td>
                            <asp:TextBox ID="txtInTime" runat="server" CssClass="form-control custom-form-control" onclick="setCurrentTime()" />
                        </td>
                        <td>
                            <asp:TextBox ID="txtSenderName" runat="server" CssClass="form-control custom-form-control" />
                        </td>
                        <td>
                            <asp:TextBox ID="txtReceiverName" runat="server" CssClass="form-control custom-form-control" />
                        </td>
                        <td>
                            <asp:TextBox ID="txtCourierReceiverAddress" runat="server" CssClass="form-control custom-form-control" />
                        </td>
                        <td>
                            <asp:TextBox ID="txtReceiverCity" runat="server" CssClass="form-control custom-form-control" />
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlByMode" runat="server" CssClass="form-select custom-form-control">
                                <asp:ListItem>SELECT</asp:ListItem>
                                <asp:ListItem>By Hand</asp:ListItem>
                                <asp:ListItem>By Post</asp:ListItem>
                                <asp:ListItem>By Courier</asp:ListItem>
                                <asp:ListItem>By Air</asp:ListItem>
                                <asp:ListItem>By Ship</asp:ListItem>
                                <asp:ListItem>By Train</asp:ListItem>
                                <asp:ListItem>By Truck</asp:ListItem>
                                <asp:ListItem>Other</asp:ListItem>
                            </asp:DropDownList>
                            <asp:TextBox ID="txtByMode" runat="server" CssClass="form-select custom-form-control" />
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlReceiptPacking" runat="server" CssClass="form-select custom-form-control">
                                <asp:ListItem>SELECT</asp:ListItem>
                                <asp:ListItem>Document</asp:ListItem>
                                <asp:ListItem>Box</asp:ListItem>
                                <asp:ListItem>Envelope</asp:ListItem>
                                <asp:ListItem>Parcel</asp:ListItem>
                                <asp:ListItem>Package</asp:ListItem>
                                <asp:ListItem>Letter</asp:ListItem>
                                <asp:ListItem>Tube</asp:ListItem>
                                <asp:ListItem>Bag</asp:ListItem>
                                <asp:ListItem>Other</asp:ListItem>
                            </asp:DropDownList>
                            <asp:TextBox ID="txtReceiptPacking" runat="server" CssClass="form-select custom-form-control" />
                        </td>
                        <td>
                            <asp:TextBox ID="txtNoOfPacks" runat="server" CssClass="form-control custom-form-control" />
                        </td>
                        <td>
                            <asp:TextBox ID="txtValue" runat="server" CssClass="form-control custom-form-control" />
                        </td>
                        <td>
                            <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-success btn-sm" OnClick="btnSave_Click1" />
                        </td>
                    </tr>
                </tbody>
            </table>
            <asp:TextBox ID="txt_plNTCODE" runat="server" hidden="true"></asp:TextBox>
        </div>

        <div class="logout-section d-flex justify-content-end align-items-center p-1" style="position: fixed; bottom: 0; right: 0;">
            <a href="#" class="text-danger d-flex align-items-center logout-btn" style="text-decoration: none;" onclick="logout()">
                <i class="fas fa-sign-out-alt fa-3x"></i>
                <span class="ml-2 d-none d-md-inline"></span>
            </a>
        </div>
    </form>

    <%--<div class="logout-section d-flex justify-content-end align-items-center p-1" style="position: fixed; bottom: 0; right: 0; width: 100%; margin-bottom: 5px">
        <a href="http://192.168.20.70:96/Home.aspx" class="text-danger d-flex align-items-center" style="text-decoration: none;" onclick="logout()">
            <i class="fas fa-sign-out-alt fa-3x"></i>
            <span class="ml-2 d-none d-md-inline"></span>
        </a>
    </div>--%>
    <script src="Scripts/jquery-3.7.1.slim.js"></script>
    <script src="Scripts/popper.min.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>

    <script>
        document.getElementById('<%= ddlByMode.ClientID %>').addEventListener('change', toggleByMode);
        toggleByMode();


        document.getElementById('<%= ddlReceiptPacking.ClientID %>').addEventListener('change', toggleReceiptPacking);
        toggleReceiptPacking();


    </script>
    <script>
        document.querySelector(".logout-btn").addEventListener("click", function (event) {
            event.preventDefault(); // Prevent default navigation

            // Send an asynchronous POST request to the server for logout
            fetch('/COURIERINOUT.aspx', { // Replace with your actual logout handler URL
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

        $(document).ready(function () {
            $('.sidebar').hover(
                function () {
                    $(this).css('width', 'auto');
                },
                function () {
                    $(this).css('width', '30px');
                }
            );

            $('.toggle-sidebar').click(function () {
                $('.sidebar').toggleClass('active');
            });
        });

    </script>

</body>
</html>
