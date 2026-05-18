<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ForgotPassword.aspx.cs" Inherits="TasteNet.ForgotPassword" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Forgot Password | TasteNet</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet" />
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            margin: 0;
            padding: 0;
            font-family: 'Poppins', 'Segoe UI', sans-serif;
            background: url('Images/landingpage.jpg') no-repeat center center fixed;
            background-size: cover;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
        }

        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            z-index: -1;
        }

        .forgot-card {
            width: 360px;
            background: #4b0000;
            padding: 20px 20px 24px 20px;
            border-radius: 18px;
            text-align: center;
            color: #fff;
            border: 2px solid #ffc107;
            box-shadow: 0 0 6px #ffc107, 
                        0 0 12px #ffc107, 
                        0 0 24px rgba(255, 193, 7, 0.3),
                        inset 0 0 6px rgba(255, 193, 7, 0.2);
            transition: all 0.3s ease;
            animation: glowPulse 1.5s infinite alternate;
        }

        .logo img {
            width: 70px;
            margin-bottom: 4px;
            border-radius: 50%;
            border: solid #FFD41D;
        }

        h2 {
            margin: 0 0 12px 0;
            font-weight: 600;
            font-size: 1.5em;
            font-family: 'Poppins', sans-serif;
            letter-spacing: 0.5px;
        }

        .input-box {
            width: 85%;
            margin: 0 auto 12px auto;
            position: relative;
        }

        .input-box input {
            width: 100%;
            height: 42px;
            padding: 0 40px 0 15px;
            border-radius: 25px;
            border: none;
            outline: none;
            font-size: 14px;
            font-family: 'Poppins', sans-serif;
            box-sizing: border-box;
            background: #fff;
            transition: all 0.3s ease;
        }

        .input-box input:focus {
            box-shadow: 0 0 0 2px #ffc107, 0 0 10px rgba(255, 193, 7, 0.5);
        }

        .input-box input::placeholder {
            font-family: 'Poppins', sans-serif;
            font-size: 13px;
            font-weight: 300;
            color: #888;
        }

        .password-box {
            position: relative;
        }

        .password-box i {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%) scale(1);
            color: #777;
            cursor: pointer;
            transition: transform 0.25s ease, opacity 0.25s ease;
            font-size: 1em;
        }

        .password-box i.active {
            transform: translateY(-50%) scale(1.05);
            opacity: 0.85;
        }

        .otp-box {
            position: relative;
        }

        .otp-box i {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #777;
            font-size: 1em;
        }

        .btn-submit {
            margin-top: 6px;
            background: transparent;
            border: 2px solid #ffc107;
            padding: 8px 10px;
            width: 85%;
            color: #ffc107;
            font-size: 14px;
            font-family: 'Poppins', sans-serif;
            font-weight: 500;
            letter-spacing: 1px;
            border-radius: 30px;
            cursor: pointer;
            transition: all 0.3s ease;
            text-transform: uppercase;
            display: inline-block;
        }

        .btn-submit:hover {
            background: #ffc107;
            color: #4b0000;
            border-color: #ffc107;
            transform: translateY(-1px);
            box-shadow: 0 5px 15px rgba(255, 193, 7, 0.4);
        }

        .btn-submit:active {
            transform: translateY(0);
        }

        .btn-resend {
            background: transparent;
            border: 2px solid #ffc107;
            padding: 6px 10px;
            width: 85%;
            color: #ffc107;
            font-size: 12px;
            font-family: 'Poppins', sans-serif;
            font-weight: 500;
            letter-spacing: 1px;
            border-radius: 30px;
            cursor: pointer;
            transition: all 0.3s ease;
            text-transform: uppercase;
            margin-top: 8px;
        }

        .btn-resend:hover {
            background: #ffc107;
            color: #4b0000;
            transform: translateY(-1px);
            box-shadow: 0 5px 15px rgba(255, 193, 7, 0.4);
        }

        @keyframes glowPulse {
            from { box-shadow: 0 0 5px #ffc107; }
            to { box-shadow: 0 0 12px #ffc107, 0 0 24px rgba(255, 193, 7, 0.8); }
        }
        
        .message {
            padding: 6px 10px;
            margin: 6px auto 10px auto;
            border-radius: 8px;
            width: 85%;
            font-size: 12px;
            font-family: 'Poppins', sans-serif;
            text-align: center;
        }

        .success {
            background-color: rgba(40, 167, 69, 0.2);
            color: #28a745;
            border: 1px solid #28a745;
        }

        .error {
            background-color: rgba(220, 53, 69, 0.2);
            color: #ffc107;
            border: 1px solid #ffc107;
        }

        .info {
            background-color: rgba(23, 162, 184, 0.2);
            color: #17a2b8;
            border: 1px solid #17a2b8;
        }

        .back-link {
            margin-top: 12px;
            font-size: 12px;
            font-family: 'Poppins', sans-serif;
        }

        .back-link a {
            color: #ffc107;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
            padding: 3px 10px;
            border-radius: 18px;
            background: rgba(255, 193, 7, 0.1);
            display: inline-block;
        }

        .back-link a:hover {
            background: rgba(255, 193, 7, 0.2);
            text-decoration: none;
            color: #fff;
            transform: translateY(-1px);
        }

        .timer {
            width: 85%;
            margin: -5px auto 10px auto;
            font-size: 11px;
            color: #ffc107;
            text-align: center;
            font-family: 'Poppins', sans-serif;
        }

        .password-strength {
            width: 85%;
            margin: 4px auto 8px auto;
            font-size: 10px;
            color: #ffc107;
            text-align: left;
            font-family: 'Poppins', sans-serif;
        }

        hr {
            width: 85%;
            margin: 12px auto;
            border-color: rgba(255, 193, 7, 0.25);
        }

        .message-container {
            width: 100%;
            display: flex;
            justify-content: center;
        }

        form {
            margin: 0;
            padding: 0;
        }

        .forgot-card .btn-resend {
            margin-bottom: 0;
        }

        .input-box:last-of-type {
            margin-bottom: 8px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="forgot-card">
            <div class="logo">
                <img src="Images/LOGO.png" alt="Logo" />
            </div>

            <h2>Forgot Password</h2>

            <div class="message-container">
                <asp:Label ID="lblMessage" runat="server" CssClass="message" Visible="false"></asp:Label>
            </div>

            <asp:Panel ID="pnlEmail" runat="server">
                <div class="input-box">
                    <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" placeholder="Enter your email address"></asp:TextBox>
                </div>
                <asp:Button ID="btnSendOTP" runat="server" Text="SEND OTP" CssClass="btn-submit" OnClick="btnSendOTP_Click" />
                <div class="back-link">
                    <a href="Login.aspx">Back to Login</a>
                </div>
            </asp:Panel>

            <asp:Panel ID="pnlOTP" runat="server" Visible="false">
                <div class="input-box otp-box">
                    <asp:TextBox ID="txtOTP" runat="server" TextMode="SingleLine" placeholder="Enter OTP" MaxLength="6"></asp:TextBox>
                    <i class="fa fa-key"></i>
                </div>
                <div id="timerDisplay" class="timer"></div>

                <div class="input-box password-box">
                    <asp:TextBox ID="txtNewPassword" runat="server" TextMode="Password" placeholder="New Password"></asp:TextBox>
                    <i id="toggleNewPwd" class="fa fa-eye-slash"></i>
                </div>

                <div class="input-box password-box">
                    <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" placeholder="Confirm New Password"></asp:TextBox>
                    <i id="toggleConfirmPwd" class="fa fa-eye-slash"></i>
                </div>

                <div class="password-strength">
                    <i class="fa fa-info-circle"></i> Password must be at least 6 characters
                </div>

                <asp:Button ID="btnResetPassword" runat="server" Text="RESET PASSWORD" CssClass="btn-submit" OnClick="btnResetPassword_Click" />
                <asp:Button ID="btnResendOTP" runat="server" Text="RESEND OTP" CssClass="btn-resend" OnClick="btnResendOTP_Click" />
                <hr />
                <div class="back-link">
                    <a href="Login.aspx">Back to Login</a>
                </div>
            </asp:Panel>
        </div>
    </form>

    <script type="text/javascript">
        var countdownTimer;

        function startTimer(seconds) {
            var timerDisplay = document.getElementById("timerDisplay");
            if (!timerDisplay) return;

            var remaining = seconds;
            if (countdownTimer) clearInterval(countdownTimer);

            countdownTimer = setInterval(function () {
                if (remaining <= 0) {
                    clearInterval(countdownTimer);
                    timerDisplay.innerHTML = "⏰ OTP expired. Please request a new OTP.";
                    timerDisplay.style.color = "#dc3545";
                } else {
                    var minutes = Math.floor(remaining / 60);
                    var secs = remaining % 60;
                    timerDisplay.innerHTML = "⏱️ OTP expires in: " + minutes + ":" + (secs < 10 ? "0" : "") + secs;
                    remaining--;
                }
            }, 1000);
        }

        function clearTimer() {
            if (countdownTimer) {
                clearInterval(countdownTimer);
                countdownTimer = null;
            }
        }

        function getElementByClientId(clientId) {
            var element = document.getElementById(clientId);
            if (!element) {
                var selector = '[id$="' + clientId.split('_').pop() + '"]';
                return document.querySelector(selector);
            }
            return element;
        }

        // Toggle for New Password field
        var toggleNewPwd = document.getElementById("toggleNewPwd");
        var newPwdField = getElementByClientId('<%= txtNewPassword.ClientID %>');
        if (toggleNewPwd && newPwdField) {
            toggleNewPwd.addEventListener("click", function (e) {
                e.preventDefault();
                this.classList.add("active");
                if (newPwdField.type === "password") {
                    newPwdField.type = "text";
                    this.classList.remove("fa-eye-slash");
                    this.classList.add("fa-eye");
                } else {
                    newPwdField.type = "password";
                    this.classList.remove("fa-eye");
                    this.classList.add("fa-eye-slash");
                }
                setTimeout(function () {
                    if (toggleNewPwd) toggleNewPwd.classList.remove("active");
                }, 200);
            });
        }

        // Toggle for Confirm Password field
        var toggleConfirmPwd = document.getElementById("toggleConfirmPwd");
        var confirmPwdField = getElementByClientId('<%= txtConfirmPassword.ClientID %>');
        if (toggleConfirmPwd && confirmPwdField) {
            toggleConfirmPwd.addEventListener("click", function (e) {
                e.preventDefault();
                this.classList.add("active");
                if (confirmPwdField.type === "password") {
                    confirmPwdField.type = "text";
                    this.classList.remove("fa-eye-slash");
                    this.classList.add("fa-eye");
                } else {
                    confirmPwdField.type = "password";
                    this.classList.remove("fa-eye");
                    this.classList.add("fa-eye-slash");
                }
                setTimeout(function () {
                    if (toggleConfirmPwd) toggleConfirmPwd.classList.remove("active");
                }, 200);
            });
        }

        var inputs = document.querySelectorAll('.input-box input');
        inputs.forEach(function (input) {
            input.addEventListener('focus', function () {
                if (this.parentElement) {
                    this.parentElement.style.transform = 'scale(1.01)';
                    this.parentElement.style.transition = 'transform 0.2s ease';
                }
            });
            input.addEventListener('blur', function () {
                if (this.parentElement) {
                    this.parentElement.style.transform = 'scale(1)';
                }
            });
        });

        // OTP uppercase handling
        var otpInput = getElementByClientId('<%= txtOTP.ClientID %>');
        if (otpInput) {
            otpInput.addEventListener('input', function (e) {
                this.value = this.value.toUpperCase();
            });
        }

        var newPassword = getElementByClientId('<%= txtNewPassword.ClientID %>');
        var confirmPassword = getElementByClientId('<%= txtConfirmPassword.ClientID %>');

        function validatePassword() {
            if (newPassword && confirmPassword) {
                if (newPassword.value.length > 0 && newPassword.value.length < 6) {
                    newPassword.style.boxShadow = "0 0 0 2px #dc3545";
                } else if (newPassword.value.length >= 6) {
                    newPassword.style.boxShadow = "0 0 0 2px #28a745";
                } else {
                    newPassword.style.boxShadow = "";
                }

                if (confirmPassword.value.length > 0 && newPassword.value !== confirmPassword.value) {
                    confirmPassword.style.boxShadow = "0 0 0 2px #dc3545";
                } else if (confirmPassword.value.length > 0 && newPassword.value === confirmPassword.value) {
                    confirmPassword.style.boxShadow = "0 0 0 2px #28a745";
                } else {
                    confirmPassword.style.boxShadow = "";
                }
            }
        }

        if (newPassword) {
            newPassword.addEventListener('keyup', validatePassword);
        }
        if (confirmPassword) {
            confirmPassword.addEventListener('keyup', validatePassword);
        }

        function adjustPanelSpacing() {
            var emailPanel = document.getElementById('<%= pnlEmail.ClientID %>');
            var otpPanel = document.getElementById('<%= pnlOTP.ClientID %>');
            if (otpPanel && otpPanel.style.display !== 'none' && otpPanel.style.visibility !== 'hidden') {
                var otpBoxes = otpPanel.querySelectorAll('.input-box');
                for (var i = 0; i < otpBoxes.length; i++) {
                    otpBoxes[i].style.marginBottom = '10px';
                }
            }
        }
        setTimeout(adjustPanelSpacing, 10);
    </script>
</body>
</html>