<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="vms1.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>LOGIN</title>
    <link rel="icon" href="https://foreselastomech.com/wp-content/uploads/2019/03/FORES-Logo.png" />
    <!-- Bootstrap and Font Awesome -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet" />
    <style>
        body {
            font-family: 'Times New Roman', serif;
        }

        #header {
            height: 70px;
        }

        .login-container {
            background-color: aqua;
            background-image: url('images/fores_vms.jpg');
            background-size: cover;
            padding: 5%;
            border-radius: 20px;
            box-shadow: 0px 0px 20px rgba(0, 0, 0, 0.5);
            width: 80%;
            height: 60%;
            max-width: 500px;
            margin: auto;
        }

        .login-button {
            width: 60%;
            margin-top: 20px;
            border-radius: 20px;
            font-weight: bold;
        }

        #lblpassword,
        #lblusername {
            color: black;
            font-weight: 600;
        }

        .password-toggle-icon {
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            right: 10px;
        }

        /* Responsive design for smaller devices */
        @media (max-width: 767.98px) {
            .login-container {
                padding: 20px;
                background-size: contain;
            }

            h3 {
                font-size: 1.5rem;
            }

            .login-button {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div class="container-fluid">
            <!-- Header Section -->
            <div class="row">
                <div class="col-md-12" id="header" style="background-color: aqua;">
                    <marquee style="font-weight: bold; font-size: 1.5rem; margin-top: 15px; word-spacing: 10px;" scrollamount="12">
                       *** WELCOME TO THE VISITOR AND COURIER MANAGEMENT SYSTEM ***
                    </marquee>
                </div>
            </div>
            <!-- Login Form Section -->
            <div class="container mt-5">
                <div class="row justify-content-center">
                    <div class="col-lg-5 col-md-7 col-sm-12 login-container">
                        <h3 class="text-center mb-4">LOGIN</h3>
                        <!-- Employee ID -->
                        <div class="form-group">
                            <asp:Label ID="lblusername" runat="server">User ID</asp:Label>
<%--                            <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" AutoPostBack="true" />--%>
                            <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" AutoPostBack="true"></asp:TextBox>
                        </div>
                        <!-- Password -->
                        <div class="form-group">
                            <asp:Label ID="lblpassword" runat="server">Password</asp:Label>
                            <div class="input-group">
                                <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" />
                                <div class="input-group-append">
                                    <span id="eyeIcon2" class="password-toggle-icon" onclick="togglePasswordVisibility('txtPassword')">
                                        <i class="fa fa-eye"></i>
                                    </span>
                                </div>
                            </div>
                        </div>
                        <!-- Login Button -->
                        <div class="form-group text-center">
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                <ContentTemplate>
                                    <!-- Login Button -->
                                    <asp:Button ID="loginbtn" runat="server" Text="LOGIN" CssClass="btn btn-primary login-button" OnClick="loginbtn_Click" />
                                    <br />
                                    <asp:Label ID="lblMessage" runat="server" Text="" CssClass="text-danger"></asp:Label>
                                    <asp:Button ID="registerbtn" runat="server" Text="Register First" CssClass="btn btn-success mt-4 login-button" OnClick="registerbtn_Click" />
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <script>
        function togglePasswordVisibility(inputId) {
            const passwordInput = document.getElementById(inputId);
            const eyeIcon = document.getElementById('eyeIcon2');

            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                eyeIcon.innerHTML = '<i class="fa fa-eye-slash"></i>';
            } else {
                passwordInput.type = 'password';
                eyeIcon.innerHTML = '<i class="fa fa-eye"></i>';
            }
        }
    </script>

    <!-- Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
