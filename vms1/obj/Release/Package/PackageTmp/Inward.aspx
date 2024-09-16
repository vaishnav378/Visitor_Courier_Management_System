<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Inward.aspx.cs" Inherits="vms1.Inward" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Inward Courier</title>
    <link rel="icon" href="https://foreselastomech.com/wp-content/uploads/2019/03/FORES-Logo.png" />

    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" />







    <link rel="icon" href="https://foreselastomech.com/wp-content/uploads/2019/03/FORES-Logo.png" />
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0/dist/css/select2.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0/dist/js/select2.min.js"></script>

    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" />

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.1.0-beta.1/js/select2.min.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.1.0-beta.1/css/select2.min.css" rel="stylesheet" />

    <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/css/select2.min.css" rel="stylesheet" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/js/select2.full.min.js"></script>


    <script>
        $(document).ready(function () {
            $('#<%= DropDownList1.ClientID %>').select2({
                placeholder: "Select a user",
                allowClear: true
            });
        });

    </script>
    <style>
        /*############################################*/
        body {
            font-family: 'Times New Roman';
        }
        /* General styling */
        .large-checkbox input[type="checkbox"] {
            margin-top: -6px;
            width: 20px;
            height: 20px;
        }

        /* Sidebar styling */
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
                width: 190px !important;
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
                    margin-right: 20px;
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

        /* Card styling */

        /*############################################*/

        .shadow-custom {
            background-color: darkgrey; /* Light gray background */
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
        /*############################################*/
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

        .receipt-status-Received {
            color: green;
            font-size: 20px;
        }

        .receipt-status-pending {
            color: red;
            font-size: 20px;
        }

        .scrollable-gridview th {
            background-color: #f2f2f2;
            color: #333;
            position: sticky;
            top: 0;
            z-index: 2;
            font-size: 14px;
            white-space: nowrap;
        }

        .table-container {
            overflow-x: auto;
            overflow-y: auto;
            height: 500px;
            font-family: "Times New Roman";
            font-size: 14px;
        }

        .scrollable-gridview {
            width: 100%;
            border-collapse: collapse;
            table-layout: fixed;
        }

            .scrollable-gridview th,
            .scrollable-gridview td {
                border: 1px solid #ddd;
                padding: 8px;
                text-align: left;
                word-wrap: break-word;
            }

        @media screen and (max-width: 768px) {
            .scrollable-gridview th,
            .scrollable-gridview td {
                font-size: 12px;
                padding: 6px;
            }

            .scrollable-gridview th {
                white-space: normal;
            }
        }

        /*############################################*/
    </style>

    <script type="text/javascript">
        function toggleCourierAgency() {
            var ddlCourierAgency = document.getElementById('<%= ddlCourierAgency.ClientID %>');
            var txtCourierAgency = document.getElementById('<%= txtCourierAgency.ClientID %>');

            if (ddlCourierAgency.value === 'Other') {
                txtCourierAgency.style.display = 'block';
                ddlCourierAgency.style.display = "none";
            } else {
                txtCourierAgency.style.display = 'none';

            }
        }


        function toggleSenderCity() {
            var ddlSenderCity = document.getElementById('<%= ddlSenderCity.ClientID %>');
            var txtSenderCity = document.getElementById('<%= txtSenderCity.ClientID %>');

            if (ddlSenderCity.value === 'Other') {
                txtSenderCity.style.display = 'block';
                ddlSenderCity.style.display = "none";
            } else {
                txtSenderCity.style.display = 'none';

            }
        }

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


          <%-- <div class="container-fluid" style="margin-left: 10px;">        
       <div class="row">
   <div class="col-12">
       <div class="table-responsive" style="max-height: 500px; overflow-y: auto;">
           <asp:GridView ID="gvInwardCouriers" runat="server" AutoGenerateColumns="False"
               CssClass="table table-striped table-bordered table-hover table-responsive ">--%>
        /////////////////////////////////////////////////////////////
        $(document).ready(function () {
            $('#<%= DropDownList1.ClientID %>').select2({
                placeholder: "Select a user",
                allowClear: true
            });
        });

    </script>




</head>
<body>
    <form id="form1" runat="server">
        <div class="container-fluid">


            <div class="row">

                <div class="container-fluid">
                    <div class="row py-2 " style="background-color: gray;">

                        <div class="col-md-10 text-center">
                            <img src="https://foreselastomech.com/wp-content/uploads/2019/03/FORES-Logo.png" alt="Logo" style="float: left; height: 55px;" />
                            <asp:Label ID="lbl_heading" runat="server" Text="INWARD COURIER" Font-Size="x-large" Font-Names="Times New Roman" Style="margin-left: 180px" Font-Bold="true"></asp:Label>
                        </div>
                        <div class="col-md-2 d-flex align-items-center justify-content-end">
                            <asp:Image ID="img_admin" runat="server" ImageUrl="images/admin.png" CssClass="img-fluid" Style="max-height: 30px; max-width: 30px;" />
                            <asp:TextBox ID="txt_userlogin" runat="server" ReadOnly="true" Text="ADMIN" CssClass="form-control text-center ml-2" Font-Size="Small" Font-Bold="true" Font-Names="Times New Roman" Style="font-size: 13px; width: 120px;"></asp:TextBox>
                        </div>
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
                                <a href="Visitor_Dashboard.aspx">
                                    <asp:Label ID="lbl_visitordashboard" runat="server" Style="color: black; font-size: 14px;" onclick="CreateUser()" class="nav-link ml-1">
                        <i class="fas fa-tachometer-alt"></i> VISITOR DASHBOARD
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




            <div class="col content" style="margin-left: 10px;">
                <div>
                    <asp:Label ID="lbl_Inwardcurrierentry" runat="server" Text="<b>INWARD COURIER ENTRY</b>" Style="text-align: center; margin: 4px; padding-top: 3px; box-shadow: 10px 10px 15px; font-size: 13px;" BackColor="LightGray" Height="30" Width="200"></asp:Label>
                </div>

                <div class="table-responsive">
                    <table class="table table-bordered table-bordered-all">
                        <thead style="background-color: lightgray;">
                            <tr>
                                <th>In_Date</th>
                                <th>In_Time</th>
                                <th>Courier_Agency</th>
                                <th>Docket_Number</th>
                                <th>Sender_Name</th>
                                <th>Sender_City</th>
                                <th>By_Mode</th>
                                <th>Receipt_Packing</th>
                                <th>No_of_Packs</th>
                                <th>Receiver_Name</th>
                                <th>Remark</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>
                                    <asp:TextBox ID="txtInDate" runat="server" CssClass="form-control custom-form-control" onclick="setCurrentDate()" required="true" /></td>
                                <td>
                                    <asp:TextBox ID="txtInTime" runat="server" CssClass="form-control custom-form-control" onclick="setCurrentTime()" required="true" /></td>
                                <td>
                                    <asp:DropDownList ID="ddlCourierAgency" runat="server" CssClass="form-select custom-form-control" required="true">
                                        <asp:ListItem Text="SELECT" Value="" />
                                        <asp:ListItem>D.T.DC</asp:ListItem>
                                        <asp:ListItem>BlueDart</asp:ListItem>
                                        <asp:ListItem>FedEx</asp:ListItem>
                                        <asp:ListItem>Express</asp:ListItem>
                                        <asp:ListItem>PNU</asp:ListItem>
                                        <asp:ListItem>Shree Maruti</asp:ListItem>
                                        <asp:ListItem>Tirupati</asp:ListItem>
                                        <asp:ListItem>Professional</asp:ListItem>
                                        <asp:ListItem>EMS Speed Post</asp:ListItem>
                                        <asp:ListItem>Other</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:TextBox ID="txtCourierAgency" runat="server" CssClass="form-select custom-form-control" />
                                </td>
                                <td>
                                    <asp:TextBox ID="txtDocketNumber" runat="server" CssClass="form-control custom-form-control" required="true" /></td>
                                <td>
                                    <asp:TextBox ID="txtSenderName" runat="server" CssClass="form-control custom-form-control" required="true" /></td>
                                <td>
                                    <asp:DropDownList ID="ddlSenderCity" runat="server" CssClass="form-select custom-form-select" required="true">
                                        <asp:ListItem Text="SELECT" Value="" />
                                        <asp:ListItem>Aurangabad</asp:ListItem>
                                        <asp:ListItem>Mumbai</asp:ListItem>
                                        <asp:ListItem>Delhi</asp:ListItem>
                                        <asp:ListItem>Bangalore</asp:ListItem>
                                        <asp:ListItem>Chennai</asp:ListItem>
                                        <asp:ListItem>Hyderabad</asp:ListItem>
                                        <asp:ListItem>Ahmedabad</asp:ListItem>
                                        <asp:ListItem>Kolkata</asp:ListItem>
                                        <asp:ListItem>Pune</asp:ListItem>
                                        <asp:ListItem>Jaipur</asp:ListItem>
                                        <asp:ListItem>Surat</asp:ListItem>
                                        <asp:ListItem>Lucknow</asp:ListItem>
                                        <asp:ListItem>Other</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:TextBox ID="txtSenderCity" runat="server" CssClass="form-select custom-form-select" />
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlByMode" runat="server" CssClass="form-select custom-form-select" required="true">
                                        <asp:ListItem Text="SELECT" Value="" />
                                        <asp:ListItem>By Hand</asp:ListItem>
                                        <asp:ListItem>By Post</asp:ListItem>
                                        <asp:ListItem>By Courier</asp:ListItem>
                                        <asp:ListItem>By Air</asp:ListItem>
                                        <asp:ListItem>By Ship</asp:ListItem>
                                        <asp:ListItem>By Train</asp:ListItem>
                                        <asp:ListItem>By Truck</asp:ListItem>
                                        <asp:ListItem>Other</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:TextBox ID="txtByMode" runat="server" CssClass="form-select custom-form-select" />
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlReceiptPacking" runat="server" CssClass="form-select custom-form-select" required="true">
                                        <asp:ListItem Text="SELECT" Value="" />
                                        <asp:ListItem>Document</asp:ListItem>
                                        <asp:ListItem>Box</asp:ListItem>
                                        <asp:ListItem>Envelope</asp:ListItem>
                                        <asp:ListItem>Parcel</asp:ListItem>
                                        <asp:ListItem>Package</asp:ListItem>
                                        <asp:ListItem>Other</asp:ListItem>
                                        <asp:ListItem>Letter</asp:ListItem>
                                        <asp:ListItem>Tube</asp:ListItem>
                                        <asp:ListItem>Bag</asp:ListItem>
                                        <asp:ListItem>Other</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:TextBox ID="txtReceiptPacking" runat="server" CssClass="form-select custom-form-select" />
                                </td>
                                <td>
                                    <asp:TextBox ID="txtNoOfPacks" runat="server" CssClass="form-control" required="true" /></td>
                                <td>
                                    <%-- EEEEEEEEEEEEEEEEEEEEEEEEEEE --%>
                                    <asp:DropDownList ID="DropDownList1" runat="server" CssClass="form-select custom-form-select"></asp:DropDownList>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtRemark" runat="server" CssClass="form-control custom-form-control" required="true" /></td>
                                <td>
                                    <asp:Button ID="btnSave" runat="server" CssClass="btn btn-success" Text="Save" OnClick="btnSave_Click1" /></td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <div>
                    <asp:Label ID="Label1" runat="server" Text="<b>INWARD COURIER STATUS</b>" Style="text-align: center; margin: 4px; padding-top: 3px; box-shadow: 10px 10px 15px; font-size: 13px;" BackColor="LightGray" Height="30" Width="200"></asp:Label>
                </div>

                <div class="table-container">
                    <asp:GridView ID="gvInwardCouriers" runat="server" CssClass="scrollable-gridview" AutoGenerateColumns="False">
                        <Columns>
                            <asp:BoundField DataField="Currier_Entry_No" HeaderText="Sr.No" />
                            <asp:BoundField DataField="Currier_Inward_Date" HeaderText="In Date" />
                            <asp:BoundField DataField="Currier_Inward_Time" HeaderText="In Time" />
                            <asp:BoundField DataField="Courier_Agency" HeaderText="Courier Agency" />
                            <asp:BoundField DataField="Docket_Number" HeaderText="Docket Number" />
                            <asp:BoundField DataField="Courier_Sender_Name" HeaderText="Sender Name" />
                            <asp:BoundField DataField="Sender_City" HeaderText="Sender City" />
                            <asp:BoundField DataField="Receipt_By_mode" HeaderText="By Mode" />
                            <asp:BoundField DataField="Receipt_Packing" HeaderText="Receipt Packing" />
                            <asp:BoundField DataField="No_of_Packs" HeaderText="No of Packs" />
                            <asp:BoundField DataField="Currier_Receiver_Name " HeaderText="Receiver Name" />
                            <asp:BoundField DataField="Remarks" HeaderText="Remarks" />
                            <asp:TemplateField HeaderText="Receipt">
                                <ItemTemplate>
                                    <asp:Label ID="lblReceiptStatus" runat="server" Text='<%# Eval("Receipt_Status") %>'
                                        CssClass='<%# GetReceiptStatusCssClass(Eval("Receipt_Status").ToString()) %>' />

                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>

                <div class="logout-section d-flex justify-content-end align-items-center p-1" style="position: fixed; bottom: 0; right: 0;">
                    <a href="#" class="text-danger d-flex align-items-center logout-btn" style="text-decoration: none;" onclick="logout()">
                        <i class="fas fa-sign-out-alt fa-3x"></i>
                        <span class="ml-2 d-none d-md-inline"></span>
                    </a>
                </div>
    </form>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.1.0-beta.1/js/select2.min.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.1.0-beta.1/css/select2.min.css" rel="stylesheet" />
    <script src="Scripts/jquery-3.7.1.slim.js"></script>
    <script src="Scripts/popper.min.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>

    <script type="text/javascript">
        document.querySelector(".logout-btn").addEventListener("click", function (event) {
            event.preventDefault(); // Prevent default navigation

            // Send an asynchronous POST request to the server for logout
            fetch('/Inward.aspx', { // Replace with your actual logout handler URL
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

        document.getElementById('<%= ddlCourierAgency.ClientID %>').addEventListener('change', toggleCourierAgency);
        toggleCourierAgency();


        document.getElementById('<%= ddlSenderCity.ClientID %>').addEventListener('change', toggleSenderCity);
        toggleSenderCity();



        document.getElementById('<%= ddlByMode.ClientID %>').addEventListener('change', toggleByMode);
        toggleByMode();


        document.getElementById('<%= ddlReceiptPacking.ClientID %>').addEventListener('change', toggleReceiptPacking);
        toggleReceiptPacking();

    </script>



    <script>

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
