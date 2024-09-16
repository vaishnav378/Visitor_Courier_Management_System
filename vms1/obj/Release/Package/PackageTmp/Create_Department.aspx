<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Create_Department.aspx.cs" Inherits="vms1.Create_Department" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>CREATE DEPARTMENT</title>
    <link rel="icon" href="https://foreselastomech.com/wp-content/uploads/2019/03/FORES-Logo.png" />
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet" />
    <style>
        body {
            font-family: 'Times New Roman';
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
                width: 180px !important; /* Reduced width on hover */
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

        @media (max-width: 768px) {
            .sidebar {
                display: none;
            }

            /*############################################*/

            .shadow-custom {
                background-color: #f8f9fa; /* Light gray background */
                padding: 10px 15px;
                border-radius: 5px;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* Shadow effect */
            }

            .custom-border {
                border: 2px solid #0094ff;
            }
        }
    </style>
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
                        <ul class="menu-list" style="margin-left: -80px; color: black; margin-top: 35px;">
                            <li class="nav-item">
                                <asp:Panel ID="panel_MainDashboard" runat="server" CssClass="nav-link">
                                    <a href="Main_Dashboard.aspx">
                                        <i class='fas fa-tachometer-alt  sidebar-icon ml-2'></i>
                                        <asp:Label ID="lbl_MainDashboard" runat="server" Style="color: black; font-size: 15px; margin-left: 1px;" Text="MAIN DASHBOARD"></asp:Label>
                                    </a>
                                </asp:Panel>
                            </li>
                            <li class="nav-item">
                                <asp:Panel ID="panel_Report" runat="server" CssClass="nav-link">
                                    <a href="Report.aspx">
                                        <i class='fas fa-file-alt sidebar-icon ml-2'></i>
                                        <asp:Label ID="Label1" runat="server" Style="color: black; font-size: 15px; margin-left: 1px;" Text="REPORT"></asp:Label>
                                    </a>
                                </asp:Panel>
                            </li>

                            <li class="nav-item">
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
                                <asp:Panel ID="panel_CourierInOut" runat="server" CssClass="nav-link">
                                    <a href="CourierInOut.aspx">
                                        <i class="fas fa-box sidebar-icon ml-2"></i>
                                        <asp:Label ID="lbl_CourierInOut" runat="server" Style="color: black; font-size: 14px; margin-left: 1px;" Text="COURIER IN-OUT"></asp:Label>
                                    </a>
                                </asp:Panel>
                            </li>
                        </ul>
                    </nav>
                </div>
            </div>


            <div class="container" style="margin-top: 140px; margin-left: 250px">
                <div class="row justify-content-center">
                    <div class="col-md-8 col-lg-6">
                        <div class="card shadow-sm">
                            <div class="card-body">
                                <div class="form-group mt-4 ml-5">
                                    <asp:Label ID="lbldepartmentname" runat="server" Text="Department Name :" CssClass="form-label" Style="font-size: 20px; font-weight: bold;"></asp:Label>
                                    <asp:TextBox ID="txteName" runat="server" CssClass="form-control custom-border w-75" placeholder="Enter Department Name"></asp:TextBox>
                                </div>
                                <div class="form-group mt-4 d-flex justify-content-center" style="margin-right: 80px">
                                    <asp:Button ID="Btn_save" runat="server" Text="SAVE" CssClass="btn btn-primary btn-sm btn-lg w-50" OnClick="Btn_save_Click" />
                                </div>
                            </div>
                        </div>
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

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script>
        document.querySelector(".logout-btn").addEventListener("click", function (event) {
            event.preventDefault(); // Prevent default navigation

            // Send an asynchronous POST request to the server for logout
            fetch('/Create_Department.aspx', { // Replace with your actual logout handler URL
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
