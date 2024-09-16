<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="User_Registration.aspx.cs" Inherits="vms1.Registration" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>New User</title>
    <link rel="icon" href="https://foreselastomech.com/wp-content/uploads/2019/03/FORES-Logo.png" />
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet" />
    <style>
        body {
            font-family: 'Times New Roman';
        }

        .blinking {
            animation: blinkingText 1.5s infinite;
        }

        @keyframes blinkingText {
            0% {
                color: red;
            }

            50% {
                color: transparent;
            }

            100% {
                color: red;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container mt-3">
            <div class="row">
                <div class="col-12 text-center">
                    <asp:Label ID="lbl_heading" runat="server" Text="New User Register Here" Font-Size="x-large" Font-Names="Times New Roman" Font-Bold="true"></asp:Label>
                </div>
            </div>

            <div class="row justify-content-center mt-4">
                <div class="col-lg-8 col-md-10 col-sm-12">
                    <div class="card p-4">
                        <!-- Name Field -->
                        <div class="form-group">
                            <label for="txtName" class="font-weight-bold">Name <span class="text-danger">*</span></label>
                            <asp:TextBox
                                ID="txtVisitorName"
                                class="form-control text-uppercase"
                                Style="border: 2px solid #4A90E2;"
                                runat="server"
                                list="visitorList"
                                AutoPostBack="True"
                                OnTextChanged="txtVisitorName_TextChanged"></asp:TextBox>

                            <datalist id="visitorList">
                                <asp:Repeater ID="rptVisitorNames" runat="server">
                                    <ItemTemplate>
                                        <option value='<%# Container.DataItem %>'><%# Container.DataItem %></option>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </datalist>
                            <div id="validationMessage" class="error"></div>
                        </div>

                        <!-- User ID Field -->
                        <div class="form-group">
                            <label for="txt_userid" class="font-weight-bold">User Id<span class="text-danger">*</span></label>
                            <asp:TextBox ID="txt_datetime" runat="server" CssClass="form-control" Style="border: 2px solid #4A90E2;" required="true"></asp:TextBox>
                        </div>

                        <!-- Mobile No Field -->
                        <div class="form-group">
                            <label for="txtMono" class="font-weight-bold">Mobile No <span class="text-danger">*</span></label>
                            <asp:TextBox
                                ID="txtMono"
                                runat="server"
                                CssClass="form-control" Style="border: 2px solid #4A90E2;"
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

                        <!-- Email Field -->
                        <div class="form-group">
                            <label for="txt_Email" class="font-weight-bold">E-Mail <span class="text-danger">*</span></label>
                            <asp:TextBox ID="txt_Email" runat="server" CssClass="form-control" Style="border: 2px solid #4A90E2;" required="true"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="regexEmail" runat="server"
                                ControlToValidate="txt_Email"
                                ErrorMessage="Please enter a valid email address with '@' symbol and a '.' before the ending word."
                                ForeColor="Red"
                                ValidationExpression="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
                                Display="Dynamic"></asp:RegularExpressionValidator>
                        </div>

                        <!-- Password (or Company Name) Field -->
                        <div class="form-group">
                            <label for="txt_Company" class="font-weight-bold">Password<span class="text-danger">*</span></label>
                            <asp:TextBox ID="txt_Company" runat="server" CssClass="form-control text-uppercase" Style="border: 2px solid #4A90E2;" required="true"></asp:TextBox>
                            <asp:RequiredFieldValidator runat="server" ID="reqCompany"
                                ControlToValidate="txt_Company"
                                ErrorMessage="Please enter the company name!"
                                ForeColor="Red"
                                Display="Dynamic" />
                        </div>

                        <!-- Plant Code Field -->
                        <div class="form-group">
                            <label for="txt_Plant" class="font-weight-bold">Plant Code<span class="text-danger">*</span></label>
                            <asp:TextBox ID="txt_Plant" runat="server" CssClass="form-control" Style="border: 2px solid #4A90E2;" required="true"></asp:TextBox>
                        </div>

                        <!-- User Type Dropdown -->
                        <div class="form-group">
                            <label for="ddl_usertype" class="font-weight-bold">User-Type<span class="text-danger">*</span></label>
                            <asp:DropDownList ID="ddl_usertype" runat="server" CssClass="form-control" Style="border: 2px solid #4A90E2;">
                                <asp:ListItem Text="SELECT OPTION"></asp:ListItem>
                                <asp:ListItem>SupperAdmin</asp:ListItem>
                                <asp:ListItem>Admin</asp:ListItem>
                                <asp:ListItem>User</asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <!-- Buttons -->
                        <div class="row mt-4">
                            <div class="col-md-6 text-center">
                                <asp:Button ID="btn_registerinvite" runat="server" CssClass="btn btn-success btn-block" Text="REGISTER" OnClick="btn_registerinvite_Click" />
                            </div>
                            <div class="col-md-6 text-center">
                                <asp:Button ID="Btn_edit" runat="server" Text="Edit" CssClass="btn btn-primary btn-block" OnClick="Btn_edit_Click1" />
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-sm-12 text-center">
                                <a href="Login.aspx" class="blinking font-weight-bold">Go to Login Page</a>
                            </div>
                        </div>
                        <!-- Loading Message -->
                        <div class="row mt-3">
                            <div class="col-md-12 text-center">
                                <div id="loadingMessage" style="display: none; color: red; font-weight: bold;">
                                    Please Wait For The Pop Up Message
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
