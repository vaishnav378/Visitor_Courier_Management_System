<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registration_Invite.aspx.cs" Inherits="vms1.Registration_Invite" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>REGISTER & INVITE VISITOR</title>
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
                width: 220px !important;
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


        @media (max-width: 768px) {
            .sidebar {
                display: none;
            }


            /*            .error {
                color: red;
                text-align: center;
                margin-top: 5px;
                margin-left: 20px;
                font-size: 15px;
            }
        }
*/
    </style>
    <style>
        .error {
            color: red;
            text-align: center;
            margin-top: 5px;
            margin-left: 20px;
            font-size: 15px;
        }

        .custom-border {
            border: 3px solid lightblue;
        }

        .placeholder::placeholder {
            font-size: 12px; /* Adjust the size as needed */
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container-fluid">
            <div class="row py-2" style="background-color: gray;">
                <div class="col-md-10 text-center">
                    <img src="https://foreselastomech.com/wp-content/uploads/2019/03/FORES-Logo.png" alt="Logo" style="float: left; height: 55px;" />
                    <asp:Label ID="lbl_heading" runat="server" Text="REGISTER & INVITE VISITOR" Font-Size="x-large" Font-Names="Times New Roman" Font-Bold="true" Style="margin-left: 180px;"></asp:Label>
                </div>
                <div class="col-md-2 d-flex align-items-center justify-content-end">
                    <asp:Image ID="img_admin" runat="server" ImageUrl="images/admin.png" CssClass="img-fluid" Style="max-height: 30px; max-width: 30px;" />
                    <asp:TextBox ID="txt_userlogin" runat="server" ReadOnly="true" Text="ADMIN" CssClass="form-control text-center ml-2" Font-Size="Small" Font-Bold="true" Font-Names="Times New Roman" Style="font-size: 11.5px; width: 140px;"></asp:TextBox>
                </div>
            </div>

            <div class="row">
                <div class="toggle-sidebar">
                    <i class="fas fa-ellipsis-v"></i>
                </div>
                <div class="col-md-2 sidebar" style="background-color: gray;">
                    <nav class="nav flex-column">
                        <ul class="menu-list" style="margin-left: -75px; color: black; margin-top: 25px;">
                            <li class="nav-item">
                                <asp:Panel ID="panel_MainDashboard" runat="server" CssClass="nav-link">
                                    <a href="Main_Dashboard.aspx">
                                        <i class='fas fa-tachometer-alt sidebar-icon'></i>
                                        <asp:Label ID="lbl_MainDashboard" runat="server" Style="color: black; font-size: 15px; margin-left: 1px;" Text="MAIN DASHBOARD"></asp:Label>
                                    </a>
                                </asp:Panel>
                            </li>
                            <li class="nav-item">
                                <asp:Panel ID="panel_Report" runat="server" CssClass="nav-link">
                                    <a href="Report.aspx">
                                        <i class='fas fa-file-alt sidebar-icon'></i>
                                        <asp:Label ID="Label1" runat="server" Style="color: black; font-size: 15px; margin-left: 1px;" Text="REPORT"></asp:Label>
                                    </a>
                                </asp:Panel>
                            </li>
                            <li class="nav-item">
                                <asp:Panel ID="panel_ConfirmMeeting" runat="server" CssClass="nav-link">
                                    <a href="Meeting_Confirmation.aspx">
                                        <i class='fas fa-door-open sidebar-icon'></i>
                                        <asp:Label ID="lbl_ConfirmMeeting" runat="server" Style="color: black; font-size: 14px; margin-left: 1px;" Text="SIGN VISITOR PASS"></asp:Label>
                                    </a>
                                </asp:Panel>
                            </li>
                            <li class="nav-item">
                                <asp:Panel ID="panel_CourierInOut" runat="server" CssClass="nav-link">
                                    <a href="CourierInOut.aspx">
                                        <i class="fas fa-box sidebar-icon"></i>
                                        <asp:Label ID="lbl_CourierInOut" runat="server" Style="color: black; font-size: 14px; margin-left: 1px;" Text="COURIER IN-OUT"></asp:Label>
                                    </a>
                                </asp:Panel>
                            </li>
                        </ul>
                    </nav>
                </div>
            </div>

            <div class="row d-flex justify-content-center mt-4" style="margin-left: 320px; height: 100px">
                <div class="col-lg-8 col-md-10 col-sm-12">
                    <div class="custom-card">
                        <div class="row">

                            <div class="col-sm-4">
                                <div class="form-group">
                                    <label for="txtName" class="font-weight-bold ml-3">Name <span class="text-danger">*</span></label>
                                    <asp:TextBox ID="txtVisitorName" class="form-control custom-border ml-3 text-uppercase" runat="server" list="visitorList"></asp:TextBox>
                                    <datalist id="visitorList">
                                        <asp:Repeater ID="rptVisitorNames" runat="server">
                                            <ItemTemplate>
                                                <option value='<%# Eval("Name") %>'><%# Eval("Name") %></option>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </datalist>
                                    <div id="validationMessage" class="error"></div>
                                </div>
                            </div>

                            <div class="col-sm-1">
                                <i class="fas fa-plus-circle mt-5"></i>
                            </div>
                            <div class="col-md-2 mt-4">
                                <div class="form-group">
                                    <asp:TextBox ID="txtTotalPersons" runat="server" CssClass="form-control custom-border custom-textbox mt-1 placeholder" MaxLength="1" Placeholder="With Persons" Style="margin-left: -30px;"></asp:TextBox>
                                    <asp:CustomValidator
                                        ID="customValidatorTotalPersons"
                                        runat="server"
                                        ControlToValidate="txtTotalPersons"
                                        ForeColor="Red"
                                        Display="Dynamic"
                                        ClientValidationFunction="validateTotalPersons">
                                    </asp:CustomValidator>
                                </div>
                            </div>
                        </div>

                        <div class="col-sm-4">
                            <div class="form-group">
                                <label for="txtMono" class="font-weight-bold">Mobile No <span class="text-danger">*</span></label>
                                <asp:TextBox
                                    ID="txtMono"
                                    runat="server"
                                    CssClass="form-control custom-border"
                                    AutoPostBack="True"
                                    MaxLength="10"
                                    required="true">
                                </asp:TextBox>

                                <asp:RegularExpressionValidator
                                    ID="regexMobile"
                                    runat="server"
                                    ControlToValidate="txtMono"
                                    ForeColor="Red"
                                    ValidationExpression="^[0-9]{10}$"
                                    Display="Dynamic">
                                </asp:RegularExpressionValidator>

                            </div>
                        </div>

                        <div class="col-sm-4">
                            <div class="form-group">
                                <label for="txt_Email" class="font-weight-bold">E-Mail <span class="text-danger">*</span></label>
                                <asp:TextBox ID="txt_Email" runat="server" CssClass="form-control custom-border" AutoPostBack="True" required="true"></asp:TextBox>
                                <asp:RegularExpressionValidator ID="regexEmail" runat="server"
                                    ControlToValidate="txt_Email"
                                    ErrorMessage="Please enter a valid email address with '@' symbol and a '.' before the ending word."
                                    ForeColor="Red"
                                    ValidationExpression="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
                                    Display="Dynamic"></asp:RegularExpressionValidator>
                            </div>
                        </div>

                        <div class="col-sm-4">
                            <div class="form-group">
                                <label for="txt_Company" class="font-weight-bold">Company <span class="text-danger">*</span></label>
                                <asp:TextBox ID="txt_Company" runat="server" CssClass="form-control custom-border text-uppercase" AutoPostBack="True" required></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ID="reqCompany"
                                    ControlToValidate="txt_Company"
                                    ErrorMessage="Please enter the company name!"
                                    ForeColor="Red"
                                    Display="Dynamic" />
                            </div>
                        </div>

                        <div class="col-sm-4">
                            <div class="form-group">
                                <label for="ddl_meetingsubject" class="font-weight-bold">Meeting Subject <span class="text-danger">*</span></label>
                                <asp:DropDownList ID="ddl_meetingsubject" runat="server" CssClass="form-control custom-border" AutoPostBack="False" onchange="toggleOtherSubject(this)">
                                    <asp:ListItem Value="">Select Meeting Type</asp:ListItem>
                                    <asp:ListItem Value="Business Meeting">Business Meeting</asp:ListItem>
                                    <asp:ListItem Value="Job Interview">Job Interview</asp:ListItem>
                                    <asp:ListItem Value="Vendor Meeting">Vendor Meeting</asp:ListItem>
                                    <asp:ListItem Value="Client Visit">Client Visit</asp:ListItem>
                                    <asp:ListItem Value="Training Session">Training Session</asp:ListItem>
                                    <asp:ListItem Value="Delivery Pickup">Delivery Pickup</asp:ListItem>
                                    <asp:ListItem Value="Personal Visit">Personal Visit</asp:ListItem>
                                    <asp:ListItem Value="Maintenance Repair Visit">Maintenance/Repair Visit</asp:ListItem>
                                    <asp:ListItem Value="Government Inspection">Government Inspection</asp:ListItem>
                                    <asp:ListItem Value="Audit">Audit</asp:ListItem>
                                    <asp:ListItem Value="Material Inspection">Material Inspection</asp:ListItem>
                                    <asp:ListItem Value="Other">Other (Please Specify)</asp:ListItem>
                                </asp:DropDownList>

                                <asp:TextBox ID="txtOtherSubject" runat="server" CssClass="form-control custom-border text-uppercase" Style="display: none;" AutoPostBack="False"></asp:TextBox>

                                <asp:ScriptManager runat="server" ID="ScriptManager1" />
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="form-group">
                                <label for="txt_datetime" class="font-weight-bold">Date Time <span class="text-danger">*</span></label>
                                <asp:TextBox ID="txt_datetime" TextMode="DateTimeLocal" runat="server" CssClass="form-control custom-border" AutoPostBack="True" required="true"></asp:TextBox>
                            </div>
                        </div>
                        <div>
                            <div class="row mt-4">
                                <div class="col-sm-4">
                                    <div class="form-group">
                                        <asp:Button ID="btn_registerinvite" runat="server" CssClass="btn btn-success ml-3" Width="100%" Text="Register & Invite" OnClick="btn_registerinvite_Click" EnableViewState="false" />
                                    </div>
                                </div>

                                <div class="col-sm-2">
                                    <div class="form-group">
                                        <asp:Button ID="btn_edit" runat="server" CssClass="btn btn-success ml-5" Width="100%" Text="Edit" />
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div id="loadingMessage" style="display: none; color: red; font-weight: bold; margin-left: -410px;">
                                        Please Wait For The Pop Up Message
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <asp:TextBox ID="txt_plNTCODE" runat="server" hidden="true"></asp:TextBox>
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
            fetch('/Registration_Invite.aspx', { // Replace with your actual logout handler URL
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

        function validateTotalPersons(sender, args) {
            var value = args.Value;
            if (value >= 0 && value <= 5) {
                args.IsValid = true;
            } else {
                args.IsValid = false;
                alert("Please enter a number between 1 and 5.");
            }
        }

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

            // Hide btn_registerinvite and show the message on click
            $('#<%= btn_registerinvite.ClientID %>').click(function () {
                $(this).hide();
                $('#loadingMessage').show();
            });

            // Call the function on page load to ensure correct visibility based on the initial selection
            document.addEventListener('DOMContentLoaded', function () {
                var ddl = document.getElementById('<%= ddl_meetingsubject.ClientID %>');
                toggleOtherSubject(ddl);
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

        function validateName(name) {
            const namePattern = /^[A-Z][a-z]+ [A-Z][a-z]+$/;
            return namePattern.test(name);
        }

        document.getElementById('txtVisitorName').addEventListener('input', function () {
            const input = this.value;
            const validationMessage = document.getElementById('validationMessage');

            if (validateName(input)) {
                validationMessage.textContent = '';
            } else {
                validationMessage.textContent = 'Please enter a valid name with both first and last names, starting with capital letters.';
            }
        });

        function toggleOtherSubject(dropdown) {
            var otherSubjectDiv = document.getElementById('<%= txtOtherSubject.ClientID %>');
            var dropdownDiv = document.getElementById('<%= ddl_meetingsubject.ClientID %>');

            if (dropdown.value === "Other") {
                otherSubjectDiv.style.display = "block";
                dropdownDiv.style.display = "none";
            } else {
                otherSubjectDiv.style.display = "none";
                dropdownDiv.style.display = "block";
            }
        }

        // Call the function on page load to ensure correct visibility based on the initial selection
        document.addEventListener('DOMContentLoaded', function () {
            var ddl = document.getElementById('<%= ddl_meetingsubject.ClientID %>');
            toggleOtherSubject(ddl);
        });

        document.getElementById('txtVisitorName').addEventListener('change', function () {
            __doPostBack('txtVisitorName', this.value);
        });

    </script>
</body>
</html>
