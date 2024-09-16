<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Outward.aspx.cs" Inherits="vms1.Outward" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Outward Courier</title>
    <link rel="icon" href="https://foreselastomech.com/wp-content/uploads/2019/03/FORES-Logo.png" />

    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" />
    <style>
        body {
            font-family: 'Times New Roman', serif;
        }

        /* General styling */
        .large-checkbox input[type="checkbox"] {
            margin-top: -6px;
            width: 30px;
            height: 30px;
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
                width: 120px !important; /* Expanded width on hover */
            }

            .sidebar .nav-link {
                color: white;
                padding: 24px 20px;
                display: flex;
                align-items: center;
                text-decoration: none;
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
                background-color: darkgrey; /* Background color on hover */
                border-radius: 4px; /* Optional: adds rounded corners */
            }

            .sidebar .logout {
                margin-top: auto;
                background-color: red;
                color: white;
            }

        /* Main content styling */
        .main-content {
            margin-left: 30px;
            transition: margin-left 0.2s ease;
            padding: 15px;
        }

        @media (max-width: 768px) {
            .sidebar {
                display: none; /* Hide sidebar on small screens */
            }

                .sidebar.active {
                    display: block;
                    width: 200px;
                    position: fixed;
                    z-index: 1000;
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

        /* Utility classes */
        .d-none {
            display: none;
        }

        .receipt-status-outward {
            color: green;
            font-size: 20px;
        }

        .receipt-status-pending {
            color: red;
            font-size: 20px;
        }

        .small-font {
            font-size: 13px;
        }

        .grid-header th {
            font-size: 15px;
        }

        /* Table styling */
        .table-container1, .table-container2 {
            font-family: 'Times New Roman', serif;
            font-size: 10px;
        }

        .table-container1 {
            overflow-x: auto; /* Adds horizontal scrollbar */
            overflow-y: auto; /* Adds vertical scrollbar if needed */
            height: 300px;
            width: auto;
        }

        .table-container2 {
            height: 260px;
            width: auto;
        }

        .scrollable-gridview {
            width: 100%;
            border-collapse: collapse;
            display: table;
            table-layout: fixed;
            overflow-x: auto; /* Allows horizontal scrolling on small screens */
        }

            .scrollable-gridview th,
            .scrollable-gridview td {
                text-align: center;
                vertical-align: middle;
                padding: 8px;
                border: 1px solid #ddd;
                word-wrap: break-word; /* Breaks long words to fit in cells */
            }

            .scrollable-gridview tr:nth-child(even) {
                background-color: #f9f9f9;
            }

            .scrollable-gridview tr:hover {
                background-color: #f1f1f1;
            }

            .scrollable-gridview th {
                background-color: #f2f2f2;
                color: #333;
                position: sticky;
                top: 0;
                z-index: 2;
                font-size: 14px;
            }

        /* Media queries for responsive design */
        @media (max-width: 768px) {
            .scrollable-gridview th,
            .scrollable-gridview td {
                font-size: 12px; /* Smaller font size on small screens */
                padding: 4px; /* Reduce padding for more compact view */
            }
        }

        @media (max-width: 480px) {
            .scrollable-gridview th,
            .scrollable-gridview td {
                font-size: 10px; /* Even smaller font size on very small screens */
                padding: 2px; /* Further reduce padding */
            }

            .scrollable-gridview {
                display: block; /* Enable block display for better scrolling */
            }
        }
    </style>



    <script type="text/javascript">
        function showUploadButton(fileUploadControl) {
            var uploadButton = fileUploadControl.nextElementSibling; // Get the button next to the file input
            if (fileUploadControl.files.length > 0) {
                uploadButton.classList.remove('d-none'); // Remove 'd-none' class to show the button
            } else {
                uploadButton.classList.add('d-none'); // Add 'd-none' class to hide the button
            }
        }

    </script>

    <%--        /*######################for image not preset popup ######################*/--%>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container-fluid">

            <%--/***************************************************HEADER*************************************************************************/--%>


            <div class="row">

                <div class="container-fluid">
                    <div class="row py-2 " style="background-color: gray;">

                        <div class="col-md-10 text-center">
                            <img src="https://foreselastomech.com/wp-content/uploads/2019/03/FORES-Logo.png" alt="Logo" style="float: left; height: 55px;" />
                            <asp:Label ID="lbl_heading" runat="server" Text="OUTWARD COURIER" Font-Size="x-large" Font-Names="Times New Roman" Style="margin-left: 180px" Font-Bold="true"></asp:Label>
                        </div>
                        <div class="col-md-2 d-flex align-items-center justify-content-end">
                            <asp:Image ID="img_admin" runat="server" ImageUrl="images/admin.png" CssClass="img-fluid" Style="max-height: 30px; max-width: 30px;" />
                            <asp:TextBox ID="txt_userlogin" runat="server" ReadOnly="true" Text="ADMIN" CssClass="form-control text-center ml-2" Font-Size="Small" Font-Bold="true" Font-Names="Times New Roman" Style="font-size: 13px; width: 120px;"></asp:TextBox>
                        </div>
                    </div>
                </div>
            </div>


            <%--/***************************************************SIDEBAR *************************************************************************/--%>




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

            <%--/***************************************************GRIDVIEW    OutwardGridUpdate *************************************************************************/--%>


            <div class="container-fluid" style="margin-left: 10px;">

                <div>
                    <asp:Label ID="lbl_outwordcurrierentry" runat="server" Text="<b>OUTWARD COURIER UPDATE</b>" Style="text-align: center; margin: 4px; padding-top: 3px; box-shadow: 10px 10px 15px; font-size: 13px;" BackColor="LightGray" Height="30" Width="200"></asp:Label>
                </div>

                <div class="table-container1">
                    <div class="table-responsive" style="height: 300px; overflow: auto;">
                        <asp:GridView ID="OutwardGridUpdate" runat="server" CssClass="scrollable-gridview" AutoGenerateColumns="false" AllowPaging="false" EnableViewState="True"
                            OnRowEditing="OutwardGridUpdate_RowEditing"
                            OnRowUpdating="OutwardGridUpdate_RowUpdating"
                            OnRowCancelingEdit="OutwardGridUpdate_RowCancelingEdit"
                            OnRowDataBound="OutwardGridUpdate_RowDataBound"
                            DataKeyNames="Courier_Entry_No">
                            <Columns>
                                <asp:BoundField DataField="Courier_Entry_No" HeaderText="Sr.No" ReadOnly="true" />
                                <asp:BoundField DataField="Currier_Entry_Date" HeaderText="Entry Date" ReadOnly="true" />
                                <asp:BoundField DataField="Courier_Sender_Name" HeaderText="Sender Name" ReadOnly="true" />
                                <asp:BoundField DataField="Courier_Receiver_Name" HeaderText="Receiver Name" ReadOnly="true" />
                                <asp:BoundField DataField="Courier_Receiver_Address" HeaderText="Receiver Address" ReadOnly="true" />
                                <asp:BoundField DataField="Receiver_City" HeaderText="Receiver City" ReadOnly="true" />
                                <asp:BoundField DataField="By_Mode" HeaderText="By Mode" ReadOnly="true" />
                                <asp:BoundField DataField="Packing_Type" HeaderText="Packing Type" ReadOnly="true" />
                                <asp:BoundField DataField="Number_of_Packs" HeaderText="No of Packs" ReadOnly="true" />
                                <asp:BoundField DataField="Value" HeaderText="Value" ReadOnly="true" />



                                <asp:TemplateField HeaderText="Courier Agency">
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblCourier_Agency" runat="server" Text='<%# Eval("Courier_Agency") %>' CssClass="d-block text-center" />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:DropDownList ID="ddlCourier_Agency" runat="server" CssClass="form-select " AutoPostBack="true"
                                            OnSelectedIndexChanged="ddlCourier_Agency_SelectedIndexChanged" Width="70">
                                            <asp:ListItem Text="SELECT" Value="" />
                                            <asp:ListItem Text="D.T.DC" Value="D.T.DC" />
                                            <asp:ListItem Text="BlueDart" Value="BlueDart" />
                                            <asp:ListItem Text="FedEx" Value="FedEx" />
                                            <asp:ListItem Text="Express" Value="Express" />
                                            <asp:ListItem Text="PNU" Value="PNU" />
                                            <asp:ListItem Text="Shree Maruti" Value="Shree Maruti" />
                                            <asp:ListItem Text="Tirupati" Value="Tirupati" />
                                            <asp:ListItem Text="Professional" Value="Professional" />
                                            <asp:ListItem Text="EMS Speed Post" Value="EMS Speed Post" />
                                            <asp:ListItem Text="Other" Value="Other" />
                                        </asp:DropDownList>
                                        <asp:TextBox ID="txtOtherAgency" runat="server" CssClass="form-select " Visible="false" />
                                    </EditItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Docket Number">
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblDocket_Number" runat="server" Text='<%# Eval("Docket_Number") %>' CssClass="d-block text-center" />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtDocket_Number" runat="server" Width="70" Text='<%# Bind("Docket_Number") %>' CssClass="form-control" />
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Out Date">
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblCourier_Out_Date" runat="server" Text='<%# Eval("Courier_Out_Date") %>' CssClass="d-block text-center" />
                                    </ItemTemplate>

                                    <EditItemTemplate>

                                        <asp:TextBox ID="txtCourier_Out_Date" runat="server" TextMode="Date" Width="70" Text='<%# Bind("Courier_Out_Date") %>' CssClass="form-control form-control-sm w-55" />

                                    </EditItemTemplate>

                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Out Time">
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblCourier_Out_Time" runat="server" Text='<%# Eval("Courier_Out_Time") %>' CssClass="d-block text-center" />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtCourier_Out_Time" runat="server" TextMode="Time" Width="70" Text='<%# Bind("Courier_Out_Time") %>' CssClass="form-control form-control-sm w-55" />
                                    </EditItemTemplate>
                                </asp:TemplateField>



                                <%--  //********************************************************uplode image  uplode     --%>
                                <asp:TemplateField HeaderText="Attach Receipt">
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemTemplate>
                                        <asp:FileUpload ID="fileUpload" runat="server" CssClass="form-control-file" OnChange="showUploadButton(this);" Style="width: 56px; font-size: 10px;" />
                                        <asp:Button ID="UploadButton" runat="server" Text="Upload" CssClass="btn btn-outline-success d-none" Style="width: 56px; margin-top: 5px; font-size: 10px;" OnClick="btnUpload_Click" CommandName="Upload" />
                                    </ItemTemplate>
                                </asp:TemplateField>



                                <%--  //********************************************************Edit update        --%>
                                <asp:TemplateField HeaderText="Actions">
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemTemplate>
                                        <asp:Button ID="EditButton" runat="server" CommandName="Edit" CommandArgument='<%# Container.DataItemIndex %>' Text="Edit" CssClass="btn btn-success btn-sm" />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Update" CssClass="btn btn-outline-success btn-sm" />
                                        <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" CssClass="btn btn-outline-danger btn-sm" />

                                    </EditItemTemplate>
                                </asp:TemplateField>


                                <asp:TemplateField HeaderText="Receipt Status">
                                    <ItemTemplate>
                                        <asp:Label ID="lblReceiptStatus" runat="server"
                                            Text='<%# GetReceiptStatusText(Eval("Receipt_Status"), Eval("Edit_Status")) %>'
                                            CssClass='<%# GetReceiptStatusCssClass(Eval("Receipt_Status"), Eval("Edit_Status")) %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>

                    </div>
                </div>
            </div>



            <%--/***************************************************GRIDVIEW    OutwardGridSTATUS *************************************************************************/--%>


            <div class="container-fluid" style="margin-left: 10px;">

                <div>
                    <asp:Label ID="lbloutwardcourierstatus" runat="server" Text="<b>OUTWARD COURIER STATUS</b>" Style="text-align: center; margin: 4px; padding-top: 3px; box-shadow: 10px 10px 15px; font-size: 13px;" BackColor="LightGray" Height="30" Width="200"></asp:Label>
                </div>



                <div class="table-container2">
                    <div class="table-responsive" style="height: 300px;">

                        <asp:GridView ID="GridView2" runat="server" CssClass="scrollable-gridview" AutoGenerateColumns="false" AllowPaging="false" OnRowCommand="GridView2_RowCommand">
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
                                        <asp:Label ID="lblReceiptStatus" runat="server"
                                            Text='<%# GetReceiptStatusText1(Eval("Receipt_Status"), Eval("Edit_Status")) %>'
                                            CssClass='<%# GetReceiptStatusCssClass2(Eval("Receipt_Status"), Eval("Edit_Status")) %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
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
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>



    <script>

        document.querySelector(".logout-btn").addEventListener("click", function (event) {
            event.preventDefault(); // Prevent default navigation

            // Send an asynchronous POST request to the server for logout
            fetch('/Outward.aspx', { // Replace with your actual logout handler URL
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
