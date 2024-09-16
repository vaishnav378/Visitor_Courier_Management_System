<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Meeting_Confirmation.aspx.cs" Inherits="vms1.Meeting_Confirmation" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>MEETING CONFIRMATION</title>
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
                padding: 26px 23px;
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

            .shadow-custom {
                background-color: #f8f9fa;
                padding: 10px 15px;
                border-radius: 5px;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            }

            .container.d-flex {
                margin-left: 0; /* Remove margin on mobile */
                justify-content: center; /* Center button */
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container-fluid">
            <div class="row">
                <div class="container-fluid">
                    <div class="row py-2" style="background-color: gray;">
                        <div class="col-md-10 text-center">
                            <img src="https://foreselastomech.com/wp-content/uploads/2019/03/FORES-Logo.png" alt="Logo" style="float: left; height: 55px;" />
                            <asp:Label ID="lbl_heading" runat="server" Text="MEETING CONFIRMATION" Style="margin-left: 200px;" Font-Size="x-large" Font-Names="Times New Roman" Font-Bold="true"></asp:Label>
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
                    <i class="fas fa-ellipsis-v"></i>
                </div>
                <div class="col-md-2 sidebar" style="background-color: gray;">
                    <nav class="nav flex-column">
                        <ul class="menu-list" style="margin-left: -70px; color: black; margin-top: 25px;">
                            <li class="nav-item">
                                <asp:Panel ID="panel_MainDashboard" runat="server" CssClass="nav-link">
                                    <a href="Main_Dashboard.aspx">
                                        <i class='fas fa-tachometer-alt  sidebar-icon '></i>
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
                                <asp:Panel ID="panel_InviteVisitor" runat="server" CssClass="nav-link">
                                    <a href="Registration_Invite.aspx">
                                        <i class='fas fa-user-plus sidebar-icon '></i>
                                        <asp:Label ID="lbl_InviteVisitor" runat="server" Style="color: black; font-size: 15px; margin-left: 1px;" Text="INVITE VISITOR"></asp:Label>
                                    </a>
                                </asp:Panel>
                            </li>
                            <li class="nav-item">
                                <asp:Panel ID="panel_ConfirmMeeting" runat="server" CssClass="nav-link">
                                    <a href="Meeting_Confirmation.aspx">
                                        <i class='fas fa-door-open sidebar-icon '></i>
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

            <div class="container d-flex justify-content-center align-items-center">
                <asp:Button ID="confirmButton" runat="server" CssClass="btn btn-success custom-button" OnClientClick="opencamere_forconform(); return false;" Text="SCAN QR" />
            </div>

            <!-- Video wrapper -->
            <div id="videoWrapper" class="video-wrapper d-flex justify-content-center w-100 w-md-auto mt-5">
                <video autoplay playsinline></video>
            </div>

            <div class="logout-section d-flex justify-content-end align-items-center p-3" style="position: fixed; bottom: 0; right: 0; width: 100%; background-color: white;">
                <a href="#" class="text-danger d-flex align-items-center logout-btn" style="text-decoration: none;" onclick="logout()">
                    <i class="fas fa-sign-out-alt fa-3x"></i>
                    <span class="ml-2 d-none d-md-inline"></span>
                </a>
            </div>
    </form>
    <!-- Bootstrap JS and other dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/jsqr/dist/jsQR.min.js"></script>
    <script>
        document.querySelector(".logout-btn").addEventListener("click", function (event) {
            event.preventDefault(); // Prevent default navigation

            // Send an asynchronous POST request to the server for logout
            fetch('/Meeting_Confirmation.aspx', { // Replace with your actual logout handler URL
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

        function opencamere_forconform() {
            if (navigator.mediaDevices && navigator.mediaDevices.getUserMedia) {
                console.log('getUserMedia supported.');

                var existingVideo = document.querySelector('video');
                if (existingVideo.srcObject) {
                    existingVideo.srcObject.getTracks().forEach(track => track.stop());
                    existingVideo.srcObject = null;
                    document.getElementById('videoWrapper').style.display = 'none';
                    return;
                }

                var videoWrapper = document.getElementById('videoWrapper');
                var video = videoWrapper.querySelector('video');
                videoWrapper.style.display = 'flex';

                navigator.mediaDevices.getUserMedia({ video: { facingMode: 'environment' } })
                    .then(function (stream) {
                        console.log('Camera stream obtained.');
                        video.srcObject = stream;

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
                                video.srcObject.getTracks().forEach(track => track.stop());
                                videoWrapper.style.display = 'none';
                                Conform_meeting(code.data);
                            }
                        }, 100);
                    })
                    .catch(function (error) {
                        console.error('Error accessing camera:', error);
                        videoWrapper.style.display = 'none';
                    });
            } else {
                alert('getUserMedia is not supported in this browser');
            }
        }

        function Conform_meeting(qrData) {
            fetch('Home/Conform_meeting', {
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
                        throw new Error('Network response was not ok');
                    }
                })
                .then(message => {
                    alert(message);
                })
                .catch(error => {
                    alert('Error saving QR: ' + error.message);
                });
        }

    </script>
</body>
</html>
