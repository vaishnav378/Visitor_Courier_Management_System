<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Main_Dashboard.aspx.cs" Inherits="vms1.Main_Dashboard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>MAIN DASHBOARD</title>
    <link rel="icon" href="https://foreselastomech.com/wp-content/uploads/2019/03/FORES-Logo.png" />
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
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
        }

        .visitor-details-panel {
            position: absolute;
            background-color: #ffffff;
            border: 1px solid #ddd;
            padding: 10px;
            z-index: 1000;
            width: 100%;
            max-width: 350px;
            max-height: 300px;
            overflow-y: auto;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
            margin-top: 10px;
        }

        .card-total-visitors:hover,
        .card-bounce-rate:hover,
        .card-employee-rate:hover,
        .card-visitors-this-month:hover {
            background-color: palevioletred;
        }

        .table-hover tbody tr:hover {
            background-color: #f1f1f1;
        }

        .table-sm {
            font-size: 0.7rem;
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

        .card-employee-rate {
            background-color: #ff6a00;
            color: white;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="row">
            <div class="container-fluid">
                <div class="row py-2 bg-gray">
                    <div class="col-md-10 text-center">
                        <img src="https://foreselastomech.com/wp-content/uploads/2019/03/FORES-Logo.png" alt="Logo" style="float: left; height: 55px;" />
                        <asp:Label ID="lbl_heading" runat="server" Text="MAIN DASHBOARD" Font-Size="x-large" Font-Names="Times New Roman" Style="margin-left: 180px;" Font-Bold="true"></asp:Label>
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
                    <ul class="menu-list" style="margin-left: -40px; color: black; margin-top: 35px;">
                        <li class="nav-item">

                            <asp:Panel ID="panel_MainDashboard" runat="server" CssClass="nav-link">
                                <a href="Main_Dashboard.aspx">
                                    <i class='fas fa-tachometer-alt sidebar-icon ml-2'></i>
                                    <asp:Label ID="lbl_MainDashboard" runat="server" Style="color: black; font-size: 15px; margin-left: 1px;" Text="MAIN DASHBOARD"></asp:Label>
                                </a>
                            </asp:Panel>

                            <asp:Panel ID="panel_Report" runat="server" CssClass="nav-link">
                                <a href="Report.aspx">
                                    <i class='fas fa-file-alt sidebar-icon ml-2'></i>
                                    <asp:Label ID="Label1" runat="server" Style="color: black; font-size: 15px; margin-left: 1px;" Text="REPORT"></asp:Label>
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
                            <asp:Panel ID="panel_visitor" runat="server" CssClass="nav-link" Enabled="false">
                                <a href="Visitor_Dashboard.aspx">
                                    <i class="fas fa-tachometer-alt ml-2"></i>
                                    <asp:Label ID="Label" runat="server" Style="color: black; font-size: 14px; margin-left: 1px;" Text="VISITOR DASHBOARD"></asp:Label>
                                </a>
                            </asp:Panel>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>

        <div class="content">
            <asp:Panel ID="panel_master" runat="server" Visible="false">
                <!-- Content inside panel_master -->
            </asp:Panel>
        </div>

        <div class="toggle-sidebar">
            <i class="fas fa-bars"></i>
        </div>

        <div class="main-content">
            <div class="container-fluid">
                <div class="row justify-content-center text-center py-3 mr-5">
                    <div class="col-md-2 mb-3">
                        <div class="shadow-custom card-total-visitors custom-card-height" onclick="toggleVisitorDetails();">
                            <h4>Total Visitors</h4>
                            <asp:Label ID="lbl_TotalVisitors" runat="server" CssClass="d-block mt-2"></asp:Label>
                        </div>
                        <asp:Panel ID="pnl_VisitorDetails" runat="server" CssClass="visitor-details-panel" Style="display: none;">
                            <table class="table table-hover table-sm">
                                <thead>
                                    <tr>
                                        <th scope="col">Name</th>
                                        <th scope="col">Meet Datetime</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:Repeater ID="rpt_VisitorDetails" runat="server">
                                        <ItemTemplate>
                                            <tr>
                                                <td><%# Eval("Name") %></td>
                                                <td><%# Eval("Meet_Datetime") %></td>
                                            </tr>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </tbody>
                            </table>
                        </asp:Panel>
                    </div>

                    <div class="col-md-2 mb-3">
                        <div class="shadow-custom card-visitors-this-month custom-card-height" onclick="toggleVisitorMonthDetails();">
                            <h4>This Month</h4>
                            <asp:Label ID="lbl_VisitorsThisMonth" runat="server" CssClass="text-white"></asp:Label>
                        </div>
                        <asp:Panel ID="pnl_VisitorMonthDetails" runat="server" CssClass="visitor-details-panel" Style="display: none;">
                            <table class="table table-hover table-sm">
                                <thead>
                                    <tr>
                                        <th scope="col">Name</th>
                                        <th scope="col">Meet Datetime</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:Repeater ID="rpt_VisitorMonthDetails" runat="server">
                                        <ItemTemplate>
                                            <tr>
                                                <td><%# Eval("Name") %></td>
                                                <td><%# Eval("Meet_Datetime") %></td>
                                            </tr>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </tbody>
                            </table>
                        </asp:Panel>
                    </div>

                    <div class="col-md-2 mb-3">
                        <div class="shadow-custom card-bounce-rate custom-card-height" onclick="toggleBounceRateDetails()">
                            <h4>Bounce Rate</h4>
                            <asp:Label ID="lbl_BounceRate" runat="server" CssClass="text-white" />
                        </div>
                        <asp:Panel ID="pnl_BounceRateDetails" runat="server" CssClass="visitor-details-panel" Style="display: none;">
                            <table class="table table-hover table-sm">
                                <thead>
                                    <tr>
                                        <th scope="col">Name</th>
                                        <th scope="col">Meet Datetime</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:Repeater ID="rpt_BounceRateDetails" runat="server">
                                        <ItemTemplate>
                                            <tr>
                                                <td><%# Eval("Name") %></td>
                                                <td><%# Eval("Meet_Datetime") %></td>
                                            </tr>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </tbody>
                            </table>
                        </asp:Panel>
                    </div>

                    <div class="col-md-2 mb-3">
                        <div class="shadow-custom card-employee-rate custom-card-height" onclick="togglemployeeDetails()">
                            <h5>Most Visited Employee</h5>
                            <asp:Label ID="Label2" runat="server" CssClass="text-white" />
                        </div>
                        <asp:Panel ID="pnl_EmployeeRateDetails" runat="server" CssClass="visitor-details-panel" Style="display: none;">
                            <table class="table table-hover table-sm">
                                <thead>
                                    <tr>
                                        <th scope="col">Employee Name</th>
                                        <th scope="col">Visitor Count</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:Repeater ID="rpt_EmployeeRateDetails" runat="server">
                                        <ItemTemplate>
                                            <tr>
                                                <td><%# Eval("EmployeeName") %></td>
                                                <td><%# Eval("VisitorCount") %></td>
                                            </tr>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </tbody>
                            </table>
                        </asp:Panel>
                    </div>
                </div>
            </div>
        </div>

        <div class="container-md" style="box-shadow: 0 0 20px rgb(0, 0, 0);">
            <div class="row mb-5">
                <div class="col-md-12 p-6">
                    <div class="shadow-custom p-4" style="height: 458px;">
                        <div class="d-flex justify-content-center align-items-center">
                            <ul class="nav nav-tabs">
                                <li class="nav-item">
                                    <a id="areaTab" class="nav-link active" href="#" onclick="showLineChart()">Area</a>
                                </li>
                                <li class="nav-item">
                                    <a id="donutTab" class="nav-link" href="#" onclick="showDonutChart()">Donut</a>
                                </li>
                            </ul>
                        </div>
                        <!-- Canvas for the Chart -->
                        <canvas id="myLineChart" style="max-height: 370px; margin-top: 20px"></canvas>
                    </div>
                </div>
            </div>
        </div>

        <div class="logout-section d-flex justify-content-end align-items-center p-3" style="position: fixed; bottom: 0; right: 0; width: 100%; background-color: white;">
            <a href="#" class="text-danger d-flex align-items-center logout-btn" style="text-decoration: none;" onclick="logout()">
                <i class="fas fa-sign-out-alt fa-3x"></i>
                <span class="ml-2 d-none d-md-inline"></span>
            </a>
        </div>

    </form>

    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/microsoft-signalr/3.1.26/signalr.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <script>
        document.querySelector(".logout-btn").addEventListener("click", function (event) {
            event.preventDefault(); // Prevent default navigation

            // Send an asynchronous POST request to the server for logout
            fetch('/Main_Dashboard.aspx', { // Replace with your actual logout handler URL
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


        function toggleVisitorDetails() {
            var panel1 = document.getElementById('<%= pnl_VisitorDetails.ClientID %>');
            if (panel1.style.display === 'block') {
                panel1.style.display = 'none';
            } else {
                panel1.style.display = 'block';
            }
        }

        function toggleVisitorMonthDetails() {
            var panel2 = document.getElementById('<%= pnl_VisitorMonthDetails.ClientID %>');
            if (panel2.style.display === 'block') {
                panel2.style.display = 'none';
            } else {
                panel2.style.display = 'block';
            }
        }

        function toggleBounceRateDetails() {
            var panel3 = document.getElementById('<%= pnl_BounceRateDetails.ClientID %>');
            if (panel3.style.display === 'block') {
                panel3.style.display = 'none';
            } else {
                panel3.style.display = 'block';
            }
        }

        function togglemployeeDetails() {
            var panel4 = document.getElementById('<%= pnl_EmployeeRateDetails.ClientID %>');
            if (panel4.style.display === 'block') {
                panel4.style.display = 'none';
            } else {
                panel4.style.display = 'block';
            }
        }

        document.addEventListener('click', function (event) {
            var panel1 = document.getElementById('<%= pnl_VisitorDetails.ClientID %>');
            var card1 = document.querySelector('.card-total-visitors');

            var panel2 = document.getElementById('<%= pnl_VisitorMonthDetails.ClientID %>');
            var card2 = document.querySelector('.card-visitors-this-month');

            var panel3 = document.getElementById('<%= pnl_BounceRateDetails.ClientID %>');
            var card3 = document.querySelector('.card-bounce-rate');

            var panel4 = document.getElementById('<%= pnl_EmployeeRateDetails.ClientID %>');
            var card4 = document.querySelector('.card-employee-rate');

            // Close panel1 if click is outside
            if (panel1.style.display === 'block' && !card1.contains(event.target) && !panel1.contains(event.target)) {
                panel1.style.display = 'none';
            }

            // Close panel2 if click is outside
            if (panel2.style.display === 'block' && !card2.contains(event.target) && !panel2.contains(event.target)) {
                panel2.style.display = 'none';
            }

            if (panel3.style.display === 'block' && !card3.contains(event.target) && !panel3.contains(event.target)) {
                panel3.style.display = 'none';
            }

            if (panel4.style.display === 'block' && !card4.contains(event.target) && !panel4.contains(event.target)) {
                panel4.style.display = 'none';
            }
        });



        let myChart; // To store the current chart instance

        document.addEventListener('DOMContentLoaded', function () {
            showLineChart(); // Show the line chart by default on page load
        });

        function showLineChart() {
            // If there's an existing chart, destroy it before creating a new one
            if (myChart) {
                myChart.destroy();
            }

            var ctx = document.getElementById('myLineChart').getContext('2d');
            myChart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: visitDates, // Dates of the current month
                    datasets: [{
                        label: 'Number of Visitors',
                        data: visitorCounts, // Visitor counts per date
                        fill: false,
                        borderColor: 'rgba(75, 192, 192, 1)',
                        tension: 0.1 // Slight curve on the lines
                    }]
                },
                options: {
                    scales: {
                        x: {
                            beginAtZero: true,
                            title: {
                                display: true,
                                text: 'DATE'
                            }
                        },
                        y: {
                            beginAtZero: true,
                            title: {
                                display: true,
                                text: 'NO OF VISITORS'
                            }
                        }
                    },
                    plugins: {
                        tooltip: {
                            mode: 'index',
                            intersect: false
                        },
                        legend: {
                            display: true,
                            position: 'top'
                        }
                    },
                    responsive: true, // Ensure the chart is responsive
                    maintainAspectRatio: false // Allow the chart to adjust to the container size
                }
            });

            // Highlight the Area tab and remove highlight from Donut tab
            document.getElementById('areaTab').classList.add('active');
            document.getElementById('donutTab').classList.remove('active');
        }

        function showDonutChart() {
            // If there's an existing chart, destroy it before creating a new one
            if (myChart) {
                myChart.destroy();
            }

            var ctx = document.getElementById('myLineChart').getContext('2d');
            myChart = new Chart(ctx, {
                type: 'doughnut', // Switch to donut chart
                data: {
                    labels: visitDates, // Dates of the current month
                    datasets: [{
                        label: 'Number of Visitors',
                        data: visitorCounts, // Visitor counts per date
                        backgroundColor: [
                            'rgba(255, 99, 132, 0.2)',
                            'rgba(54, 162, 235, 0.2)',
                            'rgba(255, 206, 86, 0.2)',
                            'rgba(75, 192, 192, 0.2)',
                            'rgba(153, 102, 255, 0.2)',
                            'rgba(255, 159, 64, 0.2)'
                        ],
                        borderColor: [
                            'rgba(255, 99, 132, 1)',
                            'rgba(54, 162, 235, 1)',
                            'rgba(255, 206, 86, 1)',
                            'rgba(75, 192, 192, 1)',
                            'rgba(153, 102, 255, 1)',
                            'rgba(255, 159, 64, 1)'
                        ],
                        borderWidth: 1
                    }]
                },
                options: {
                    plugins: {
                        tooltip: {
                            mode: 'index',
                            intersect: false
                        },
                        legend: {
                            display: true,
                            position: 'top'
                        }
                    },
                    responsive: true, // Ensure the chart is responsive
                    maintainAspectRatio: false // Allow the chart to adjust to the container size
                }
            });

            // Highlight the Donut tab and remove highlight from Area tab
            document.getElementById('donutTab').classList.add('active');
            document.getElementById('areaTab').classList.remove('active');
        }

    </script>
</body>
</html>
