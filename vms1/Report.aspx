<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Report.aspx.cs" Inherits="vms1.Report" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
    <meta http-equiv="Pragma" content="no-cache" />
    <meta http-equiv="Expires" content="0" />

    <title>REPORT</title>
    <link rel="icon" href="https://foreselastomech.com/wp-content/uploads/2019/03/FORES-Logo.png" />
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-timepicker/1.13.18/jquery.timepicker.min.css" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-timepicker/1.13.18/jquery.timepicker.min.js"></script>
    <style>
        body {
            font-family: 'Times New Roman';
            overflow-x: hidden; /* Prevent horizontal overflow */
            overflow-y: auto;
        }

        /* Sidebar styling */
        .sidebar {
            position: fixed;
            left: 0;
            top: 0;
            bottom: 0;
            width: 30px;
            overflow-x: hidden;
            transition: width 0.2s ease;
            background-color: #f8f9fa;
            padding-top: 50px;
            z-index: 1000;
        }

            .sidebar:hover {
                width: 190px;
            }

            .sidebar .nav-link {
                color: red;
                padding: 26px 25px;
                display: flex;
                align-items: center;
                text-decoration: none;
                color: white;
            }

                .sidebar .nav-link i {
                    margin-right: 10px;
                    color: black;
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
            background-color: #f8f9fa;
            padding: 10px 15px;
            border-radius: 5px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .card-total-visitors {
            background-color: #17a2b8;
            color: white;
        }

        .card-visitors-this-month {
            background-color: #ffc107;
            color: white;
        }

        .card-bounce-rate {
            background-color: #dc3545;
            color: white;
        }

        .bg-gray {
            background-color: gray;
        }

        .menu-list {
            list-style: none;
            padding: 0;
        }

        .nav-link {
            color: black;
            cursor: pointer;
        }

        .sidebar-icon {
            margin-right: 10px;
        }

        .toggle-sidebar {
            cursor: pointer;
            padding: 10px;
        }

        .auto-style1 {
            position: relative;
            width: 100%;
            -ms-flex: 0 0 33.333333%;
            flex: 0 0 33.333333%;
            max-width: 33.333333%;
            left: 0px;
            top: 0px;
            padding-left: 15px;
            padding-right: 15px;
        }

        .custom-card-height {
            min-height: 90px;
            width: 40%;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="row">
            <div class="container-fluid">
                <div class="row py-2 bg-gray">
                    <div class="col-md-10 text-center">
                        <asp:Label ID="lbl_heading" runat="server" Text="VISITOR LOG REPORT" Font-Size="x-large" Font-Names="Times New Roman" Font-Bold="true"></asp:Label>
                    </div>
                    <div class="col-md-2 d-flex align-items-center justify-content-end">
                        <asp:Image ID="img_admin" runat="server" ImageUrl="images/admin.png" CssClass="img-fluid" Style="max-height: 30px; max-width: 30px;" />
                        <asp:TextBox ID="txt_userlogin" runat="server" ReadOnly="true" Text="ADMIN" CssClass="form-control text-center ml-2" Font-Size="Small" Font-Bold="true" Font-Names="Times New Roman" Style="font-size: 11.5px; width: 140px;"></asp:TextBox>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-2 sidebar" style="background-color: gray;">
            <nav class="nav flex-column" style="width: 250px;">
                <ul class="menu-list" style="margin-left: -40px; color: black; margin-top: 35px;">
                    <li class="nav-item">

                        <asp:Panel ID="panel_MainDashboard" runat="server" CssClass="nav-link">
                            <a href="Main_Dashboard.aspx">
                                <i class='fas fa-tachometer-alt sidebar-icon ml-2'></i>
                                <asp:Label ID="lbl_MainDashboard" runat="server" Style="color: black; font-size: 15px; margin-left: 1px;" Text="MAIN DASHBOARD"></asp:Label>
                            </a>
                        </asp:Panel>

                        <asp:Panel ID="panel_InviteVisitor" runat="server" CssClass="nav-link">
                            <a href="Registration_Invite.aspx">
                                <i class='fas fa-user-plus sidebar-icon ml-2'></i>
                                <asp:Label ID="lbl_InviteVisitor" runat="server" Style="color: black; font-size: 15px; margin-left: 1px;" Text="INVITE VISITOR"></asp:Label>
                            </a>
                        </asp:Panel>
                    </li>
                    <li class="nav-item">
                        <asp:Panel ID="panel_ConfirmMeeting" runat="server" CssClass="nav-link">
                            <a href="Meeting_Confirmation.aspx">
                                <i class='fas fa-door-open sidebar-icon ml-2'></i>
                                <asp:Label ID="lbl_ConfirmMeeting" runat="server" Style="color: black; font-size: 14px; margin-left: 1px;" Text="SIGN VISITOR PASS"></asp:Label>
                            </a>
                        </asp:Panel>
                    </li>
                    <li class="nav-item">
                        <asp:Panel ID="panel_CreateDepartment" runat="server" CssClass="nav-link">
                            <a href="Create_Department.aspx">
                                <i class="fas fa-plus sidebar-icon ml-2"></i>
                                <asp:Label ID="lbl_CreateDepartment" runat="server" Style="color: black; font-size: 14px; margin-left: 1px;" Text="CREATE DEPARTMENT"></asp:Label>
                            </a>
                        </asp:Panel>
                    </li>
                    <li class="nav-item">
                        <asp:Panel ID="panel_CourierInOut" runat="server" CssClass="nav-link">
                            <a href="CourierInOut.aspx">
                                <i class="fas fa-box sidebar-icon ml-2"></i>
                                <asp:Label ID="lbl_CourierInOut" runat="server" Style="color: black; font-size: 14px; margin-left: 1px;" Text="COURIER IN-OUT"></asp:Label>
                            </a>
                        </asp:Panel>
                    </li>
                    <li class="nav-item">
                        <asp:Panel ID="panel_Visitor" runat="server" CssClass="nav-link">
                            <a href="Visitor_Dashboard.aspx">
                                <i class="fas fa-tachometer-alt sidebar-icon ml-2"></i>
                                <asp:Label ID="lbl_visitor" runat="server" Style="color: black; font-size: 14px; margin-left: 1px;" Text="VISITOR DASHBOARD"></asp:Label>
                            </a>
                        </asp:Panel>
                    </li>
                    <li class="nav-item">
                        <asp:Panel ID="panel_Inward" runat="server" CssClass="nav-link">
                            <a href="Inward.aspx">
                                <i class="fas fa-inbox ml-2"></i>
                                <asp:Label ID="lbl_Inward" runat="server" Style="color: black; font-size: 14px; margin-left: 1px;" Text="COURIER INWARD"></asp:Label>
                            </a>
                        </asp:Panel>
                    </li>
                    <li class="nav-item">
                        <asp:Panel ID="panel_Outward" runat="server" CssClass="nav-link">
                            <a href="Outward.aspx">
                                <i class="fas fa-paper-plane sidebar-icon ml-2"></i>
                                <asp:Label ID="lbl_Outward" runat="server" Style="color: black; font-size: 14px; margin-left: 1px;" Text="COURIER OUTWARD"></asp:Label>
                            </a>
                        </asp:Panel>
                    </li>

                </ul>
            </nav>
        </div>

        <div class="container my-4 p-4 border rounded bg-light">
            <div class="row mb-2">
                <div class="col-12 col-md-3 mb-2">
                    <asp:Label ID="lbl_visitorName" runat="server" Text="Visitor Name" CssClass="font-weight-bold"></asp:Label>
                    <asp:TextBox ID="txtVisitorName" class="form-control custom-border text-uppercase" runat="server" list="visitorList"></asp:TextBox>
                    <datalist id="visitorList">
                        <asp:Repeater ID="rptVisitorNames" runat="server">
                            <ItemTemplate>
                                <option value='<%# Eval("Name") %>'><%# Eval("Name") %></option>
                            </ItemTemplate>
                        </asp:Repeater>
                    </datalist>
                </div>

                <div class="col-12 col-md-3 mb-2">
                    <asp:Label ID="lbl_mobileNumber" runat="server" Text="Mobile Number" CssClass="font-weight-bold"></asp:Label>
                    <asp:TextBox ID="txtMobileNumber" class="form-control custom-border text-uppercase" runat="server" list="mobileNumberList"></asp:TextBox>
                    <datalist id="mobileNumberList">
                        <asp:Repeater ID="rptMobileNumbers" runat="server">
                            <ItemTemplate>
                                <option value='<%# Eval("Mobile_No") %>'><%# Eval("Mobile_No") %></option>
                            </ItemTemplate>
                        </asp:Repeater>
                    </datalist>
                </div>

                <div class="col-12 col-md-3 mb-2">
                    <asp:Label ID="lbl_meetingWith" runat="server" Text="Meeting With" CssClass="font-weight-bold"></asp:Label>
                    <asp:TextBox ID="txtMeetingWith" class="form-control custom-border text-uppercase" runat="server" list="meetingWithList"></asp:TextBox>
                    <datalist id="meetingWithList">
                        <asp:Repeater ID="rptMeetingWith" runat="server">
                            <ItemTemplate>
                                <option value='<%# Eval("User_Name") %>'><%# Eval("User_Name") %></option>
                            </ItemTemplate>
                        </asp:Repeater>
                    </datalist>
                </div>

                <div class="col-12 col-md-3 mb-2">
                    <asp:Label ID="lbl_Plant" runat="server" Text="Plant Number" CssClass="font-weight-bold"></asp:Label>
                    <asp:TextBox ID="txtPlant" class="form-control custom-border text-uppercase" runat="server" list="plantList"></asp:TextBox>
                    <datalist id="plantList">
                        <asp:Repeater ID="rptPlants" runat="server">
                            <ItemTemplate>
                                <option value='<%# Eval("Plant_No") %>'><%# Eval("Plant_No") %></option>
                            </ItemTemplate>
                        </asp:Repeater>
                    </datalist>
                </div>

            </div>
            <div class="row mb-3">
                <div class="col-12 col-md-3 mb-2">
                    <asp:Label ID="lbl_dateFrom" runat="server" Text="Date From" CssClass="font-weight-bold"></asp:Label>
                    <asp:TextBox ID="txt_dateFrom" runat="server" CssClass="form-control" TextMode="Date" />
                </div>
                <div class="col-12 col-md-3 mb-2">
                    <asp:Label ID="lbl_dateTo" runat="server" Text="Date To" CssClass="font-weight-bold"></asp:Label>
                    <asp:TextBox ID="txt_dateTo" runat="server" CssClass="form-control" TextMode="Date" />
                </div>
                <div class="col-12 col-md-3 mb-2">
                    <asp:Label ID="lbl_inTime" runat="server" Text="In Time" CssClass="font-weight-bold"></asp:Label>
                    <asp:TextBox ID="txt_inTime" runat="server" CssClass="form-control" />
                </div>
                <div class="col-12 col-md-3 mb-2">
                    <asp:Label ID="lbl_outTime" runat="server" Text="Out Time" CssClass="font-weight-bold"></asp:Label>
                    <asp:TextBox ID="txt_outTime" runat="server" CssClass="form-control" />
                </div>
            </div>
            <div class="row justify-content-center">
                <div class="col-12 col-md-3 mb-2">
                    <asp:Button ID="btn_search" runat="server" Text="Search" CssClass="btn btn-primary btn-block" OnClick="btn_search_Click" />
                </div>
            </div>
        </div>

        <div class="container-fluid mt-4">
            <div class="row justify-content-center">
                <div class="col-10">
                    <div class="table-responsive">
                        <asp:GridView ID="gvRecords" runat="server" CssClass="table table-striped table-bordered table-hover" AutoGenerateColumns="False">
                            <Columns>
                                <asp:BoundField DataField="token" HeaderText="App.No." />
                                <asp:BoundField DataField="Name" HeaderText="Visitor Name" />
                                <asp:BoundField DataField="Whometo_Visit" HeaderText="Employee Name" />
                                <asp:BoundField DataField="Meet_DateTime" HeaderText="Meeting Date_Time" />
                                <asp:BoundField DataField="Total_Visitor" HeaderText="Total Visitors" />
                                <asp:BoundField DataField="IN_time" HeaderText="IN Time" />
                                <asp:BoundField DataField="confirmation" HeaderText="Confirmation" />
                                <asp:BoundField DataField="OUT_time" HeaderText="OUT Time" />
                                <asp:BoundField DataField="Person_Names" HeaderText="Person Names" />
                                <asp:BoundField DataField="Mobile_No" HeaderText="Visitor Mobile No" />
                                <asp:BoundField DataField="Meeting_Subject" HeaderText="Meeting Subject" />
                                <asp:BoundField DataField="Email" HeaderText="Visitor Email" />
                                <asp:BoundField DataField="Company" HeaderText="Visitor Company" />
                            </Columns>
                            <HeaderStyle CssClass="bg-info text-white" />
                            <FooterStyle CssClass="bg-info text-white" />
                            <RowStyle Font-Size="12px" />
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>

        <div class="logout-section d-flex justify-content-end align-items-center p-1" style="position: fixed; bottom: 0; right: 0;">
            <a href="#" class="text-danger d-flex align-items-center logout-btn" style="text-decoration: none;" onclick="logout()">
                <i class="fas fa-sign-out-alt fa-3x"></i>
                <span class="ml-2 d-none d-md-inline"></span>
            </a>
        </div>

    </form>
    <script>
        document.querySelector(".logout-btn").addEventListener("click", function (event) {
            event.preventDefault(); // Prevent default navigation

            // Send an asynchronous POST request to the server for logout
            fetch('/Report.aspx', { // Replace with your actual logout handler URL
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

        document.addEventListener("DOMContentLoaded", function () {
            var inTimeInput = document.getElementById('<%= txt_inTime.ClientID %>');
            var outTimeInput = document.getElementById('<%= txt_outTime.ClientID %>');

            $(inTimeInput).timepicker({
                timeFormat: 'H:i', // 24-hour format with leading zeros
                interval: 30,      // Interval between times in the dropdown
                minTime: '00:00',  // Earliest time available
                maxTime: '23:59',  // Latest time available
                startTime: '00:00',// Initial time shown when the picker opens
                dynamic: false,    // Time picker will not dynamically show options
                dropdown: true,    // Show the dropdown arrow
                scrollbar: true    // Enable scrolling in the dropdown
            });

            $(outTimeInput).timepicker({
                timeFormat: 'H:i', // 24-hour format with leading zeros
                interval: 30,      // Interval between times in the dropdown
                minTime: '00:00',  // Earliest time available
                maxTime: '23:59',  // Latest time available
                startTime: '00:00',// Initial time shown when the picker opens
                dynamic: false,    // Time picker will not dynamically show options
                dropdown: true,    // Show the dropdown arrow
                scrollbar: true    // Enable scrolling in the dropdown
            });
        });
    </script>

</body>
</html>
