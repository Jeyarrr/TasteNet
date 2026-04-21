<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Register.aspx.cs" Inherits="TasteNet.Register" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Register | TasteNet</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet" />
    <style>
        body {
            margin: 0;
            font-family: 'Poppins', 'Segoe UI', sans-serif;
            background: url('Images/landingpage.jpg') no-repeat center center fixed;
            background-size: cover;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
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

        .register-card {
            width: 500px;
            max-width: 90vw;
            background: #4b0000;
            padding: 25px 25px;
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
            position: relative;
        }

        .header-container {
            position: relative;
            width: 100%;
            display: flex;
            align-items: flex-start;
            justify-content: center;
        }

        .back-button {
            position: absolute;
            left: -5px;
            top: -5px;
            color: #ffc107;
            text-decoration: none;
            font-size: 20px;
            transition: all 0.3s ease;
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            background: rgba(255, 193, 7, 0.1);
            border: 1px solid rgba(255, 193, 7, 0.3);
        }

        .back-button:hover {
            background: #ffc107;
            color: #4b0000;
            border-color: #ffc107;
            transform: scale(1.1);
            box-shadow: 0 0 15px rgba(255, 193, 7, 0.5);
        }

        .logo img {
            width: 80px;
            margin-bottom: 5px;
            border-radius: 50%;
            border: solid #FFD41D;
        }

        h2 {
            margin-top: 2px;
            margin-bottom: 18px;
            font-weight: 600;
            font-size: 1.6em;
            font-family: 'Poppins', sans-serif;
            letter-spacing: 0.5px;
        }

        .btn-register {
            margin-top: 15px;
            background: transparent;
            border: 2px solid #ffc107;
            padding: 8px 25px;
            width: auto;
            min-width: 120px;
            color: #ffc107;
            font-size: 15px;
            font-family: 'Poppins', sans-serif;
            font-weight: 500;
            letter-spacing: 1px;
            border-radius: 30px;
            cursor: pointer;
            transition: all 0.3s ease;
            text-transform: uppercase;
            box-shadow: none;
            display: inline-block;
        }

        .btn-register:hover {
            background: #ffc107;
            color: #4b0000;
            border-color: #ffc107;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 193, 7, 0.4);
        }

        .btn-register:active {
            transform: translateY(0);
            box-shadow: 0 2px 5px rgba(255, 193, 7, 0.4);
        }

        .btn-verify {
            background: transparent;
            border: 2px solid #4CAF50;
            padding: 8px 15px;
            color: #4CAF50;
            font-size: 14px;
            font-family: 'Poppins', sans-serif;
            font-weight: 500;
            border-radius: 30px;
            cursor: pointer;
            transition: all 0.3s ease;
            width: 100%;
        }

        .btn-verify:hover {
            background: #4CAF50;
            color: white;
            transform: translateY(-2px);
        }

        .input-row {
            display: flex;
            gap: 12px;
            margin-bottom: 8px;
        }

        .input-box {
            flex: 1;
            position: relative;
        }

        .input-box input, .input-box select {
            width: 100%;
            height: 45px;
            padding: 0 40px 0 15px;
            border-radius: 25px;
            border: none;
            outline: none;
            font-size: 15px;
            font-family: 'Poppins', sans-serif;
            box-sizing: border-box;
            line-height: 45px;
            font-weight: 400;
            letter-spacing: 0.3px;
            background: white;
            transition: all 0.3s ease;
        }

        .input-box input:focus, .input-box select:focus {
            box-shadow: 0 0 0 2px #ffc107, 0 0 10px rgba(255, 193, 7, 0.5);
        }

        .input-box input::placeholder, .input-box select::placeholder {
            font-family: 'Poppins', sans-serif;
            font-size: 14px;
            font-weight: 300;
            color: #888;
        }

        .password-box input {
            padding-right: 45px !important;
        }

        .gender-container {
            text-align: left;
            margin: 15px 0 8px 0;
        }

        .gender-label {
            display: block;
            margin-bottom: 8px;
            font-size: 14px;
            font-family: 'Poppins', sans-serif;
            color: #ccc;
            padding-left: 10px;
        }

        .gender-category-list {
            display: flex;
            gap: 10px;
        }

        .gender-category-list input[type="radio"] {
            display: none;
        }

        .gender-category-list label {
            flex: 1;
            display: block;
            padding: 10px;
            text-align: center;
            border: 2px solid rgba(255, 212, 29, 0.3);
            border-radius: 25px;
            cursor: pointer;
            font-size: 14px;
            font-family: 'Poppins', sans-serif;
            transition: all 0.3s ease;
            background: rgba(255, 255, 255, 0.05);
        }

        .gender-category-list label:hover {
            border-color: #FFD41D;
            background: rgba(255, 212, 29, 0.1);
            transform: translateY(-1px);
            box-shadow: 0 3px 6px rgba(255, 193, 7, 0.2);
        }

        .gender-category-list input[type="radio"]:checked + label {
            background: #FFD41D;
            color: #4b0000;
            border-color: #FFD41D;
            font-weight: 600;
            transform: translateY(-1px);
            box-shadow: 0 3px 8px rgba(255, 193, 7, 0.4);
        }

        .password-box {
            position: relative;
        }

        .password-box i {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%) scale(1);
            cursor: pointer;
            color: #777;
            transition: transform 0.25s ease, opacity 0.25s ease;
            z-index: 2;
            background: transparent;
            width: 20px;
            height: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.1em;
        }

        .password-box i.active {
            transform: translateY(-50%) scale(1.05);
            opacity: 0.85;
        }

        .password-box i:hover {
            color: #ffc107;
            transform: translateY(-50%) scale(1.05);
        }

        @keyframes glowPulse {
            from {
                box-shadow: 0 0 5px #ffc107;
            }
            to {
                box-shadow: 0 0 12px #ffc107, 0 0 24px rgba(255, 193, 7, 0.8);
            }
        }

        .extra-text {
            margin-top: 15px;
            font-size: 14px;
            font-family: 'Poppins', sans-serif;
            color: #fff;
            line-height: 1.8;
        }

        .sign-in-link {
            color: #ffc107;
            text-decoration: none;
            font-weight: 500;
            padding: 4px 10px;
            border-radius: 18px;
            background: rgba(255, 193, 7, 0.1);
            transition: all 0.3s ease;
            display: inline-block;
            margin-left: 5px;
            font-size: 14px;
            font-family: 'Poppins', sans-serif;
        }

        .sign-in-link:hover {
            background: rgba(255, 193, 7, 0.2);
            text-decoration: none;
            color: #fff;
            transform: translateY(-1px);
            box-shadow: 0 2px 5px rgba(255, 193, 7, 0.3);
        }

        .field-error {
            color: #ffc107 !important;
            font-size: 12px;
            font-family: 'Poppins', sans-serif;
            text-align: left;
            padding-left: 15px;
            margin-top: 4px;
            margin-bottom: 6px;
            display: block;
            font-weight: 500;
            text-shadow: 0 0 3px rgba(0, 0, 0, 0.5);
            min-height: 18px;
            background: rgba(255, 193, 7, 0.1);
            padding: 4px 8px;
            border-radius: 5px;
            border-left: 3px solid #ffc107;
        }

        .hidden {
            display: none !important;
        }

        .validation-summary {
            background: rgba(255, 193, 7, 0.1);
            border: 1px solid #ffc107;
            border-radius: 10px;
            padding: 12px;
            margin: 15px 0;
            text-align: left;
        }

        .validation-summary h4 {
            color: #ffc107;
            margin: 0 0 8px 0;
            font-size: 14px;
            font-family: 'Poppins', sans-serif;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .validation-summary h4 i {
            font-size: 16px;
        }

        .validation-summary ul {
            margin: 0;
            padding-left: 20px;
            color: #ffc107;
            font-size: 13px;
            font-family: 'Poppins', sans-serif;
        }

        .validation-summary li {
            margin: 5px 0;
        }

        .input-error {
            border: 1px solid #ffc107 !important;
            box-shadow: 0 0 8px rgba(255, 193, 7, 0.5) !important;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .button-group {
            display: flex;
            gap: 12px;
            justify-content: center;
            margin-top: 20px;
        }

        select {
            appearance: none;
            background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='currentColor' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3e%3cpolyline points='6 9 12 15 18 9'%3e%3c/polyline%3e%3c/svg%3e");
            background-repeat: no-repeat;
            background-position: right 12px center;
            background-size: 16px;
            background-color: white;
        }

        select option {
            font-family: 'Poppins', sans-serif;
        }

        .mobile-prefix {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #666;
            font-size: 14px;
            font-weight: 500;
            pointer-events: none;
            z-index: 1;
        }
        
        .input-box.mobile-input {
            position: relative;
        }
        
        .input-box.mobile-input input {
            padding-left: 45px;
        }

        .form-container {
            max-height: 500px;
            overflow-y: auto;
            padding-right: 8px;
            margin: 15px 0;
            overflow-x: hidden;
        }

        .form-container::-webkit-scrollbar {
            width: 6px;
        }

        .form-container::-webkit-scrollbar-track {
            background: rgba(255, 193, 7, 0.1);
            border-radius: 3px;
        }

        .form-container::-webkit-scrollbar-thumb {
            background: #ffc107;
            border-radius: 3px;
        }

        .otp-section-container {
            display: none;
            margin: 15px 0;
            padding: 12px;
            border-top: 1px solid rgba(255, 193, 7, 0.3);
            border-bottom: 1px solid rgba(255, 193, 7, 0.3);
            background: rgba(0, 0, 0, 0.2);
            border-radius: 12px;
        }

        .otp-email-info {
            display: flex;
            align-items: flex-start;
            gap: 10px;
            background: rgba(255, 193, 7, 0.1);
            padding: 10px 12px;
            border-radius: 10px;
            margin-bottom: 15px;
            border-left: 3px solid #ffc107;
            word-break: break-word;
            overflow-wrap: break-word;
            white-space: normal;
        }

        .otp-email-info i {
            color: #ffc107;
            font-size: 16px;
            flex-shrink: 0;
            margin-top: 2px;
        }

        .otp-email-info span {
            color: #e0e0e0;
            font-size: 12px;
            line-height: 1.5;
            word-break: break-word;
            overflow-wrap: break-word;
            white-space: normal;
        }

        .otp-email-info .email-highlight {
            color: #ffc107;
            font-weight: 600;
            word-break: break-all;
            display: inline-block;
        }

        .otp-input-group {
            display: flex;
            gap: 10px;
            align-items: center;
            flex-wrap: wrap;
        }

        .otp-input-group .input-box {
            flex: 2;
            min-width: 150px;
        }

        .otp-input-group .btn-verify {
            flex: 1;
            min-width: 100px;
            margin-top: 0;
            white-space: nowrap;
        }

        .resend-section {
            text-align: center;
            margin-top: 12px;
            font-size: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
            flex-wrap: wrap;
        }

        .resend-section .sign-in-link {
            background: transparent;
            padding: 4px 12px;
            font-size: 12px;
            margin-left: 0;
        }

        #timerDisplay {
            color: #ffc107;
            font-size: 12px;
            white-space: nowrap;
        }

        .success-box {
            background: rgba(76, 175, 80, 0.1);
            border: 1px solid #4CAF50;
            border-radius: 10px;
            padding: 15px;
            margin: 15px 0;
            text-align: center;
        }

        .success-box i {
            color: #4CAF50;
            font-size: 24px;
            margin-bottom: 10px;
        }

        .success-box h4 {
            color: #4CAF50;
            margin: 0 0 8px 0;
            font-size: 16px;
            font-family: 'Poppins', sans-serif;
        }

        .success-box p {
            color: #e0e0e0;
            margin: 0;
            font-size: 13px;
            font-family: 'Poppins', sans-serif;
        }

        .general-error {
            color: #ffc107 !important;
            font-size: 13px;
            font-family: 'Poppins', sans-serif;
            text-align: center;
            display: block;
            font-weight: 500;
            text-shadow: 0 0 3px rgba(0, 0, 0, 0.5);
            background: rgba(255, 193, 7, 0.1);
            padding: 8px 12px;
            border-radius: 8px;
            border-left: 3px solid #ffc107;
            margin: 10px 0;
        }

        .success-message {
            color: #4CAF50 !important;
            font-size: 13px;
            font-family: 'Poppins', sans-serif;
            text-align: center;
            display: block;
            font-weight: 500;
            background: rgba(76, 175, 80, 0.1);
            padding: 8px 12px;
            border-radius: 8px;
            border-left: 3px solid #4CAF50;
            margin: 10px 0;
        }

        @media (max-width: 480px) {
            .input-row {
                flex-direction: column;
                gap: 8px;
            }
            
            .otp-input-group {
                flex-direction: column;
            }
            
            .otp-input-group .input-box,
            .otp-input-group .btn-verify {
                width: 100%;
                min-width: auto;
            }
            
            .otp-email-info {
                padding: 8px 10px;
            }
            
            .otp-email-info span {
                font-size: 11px;
            }
            
            .otp-input-group .btn-verify {
                white-space: normal;
            }
            
            .resend-section {
                flex-direction: column;
                gap: 8px;
            }
            
            #timerDisplay {
                white-space: normal;
            }
            
            .gender-category-list {
                flex-direction: column;
                gap: 8px;
            }
            
            .back-button {
                width: 35px;
                height: 35px;
                font-size: 18px;
                left: -3px;
                top: -3px;
            }
            .input-box input, 
            .input-box select,
            .otp-email-info span {
                white-space: normal;
                word-break: break-word;
            }
        }

    </style>
</head>

<body>
    <form id="form1" runat="server">
        <div id="customerRegisterCard" class="register-card">
            <div class="header-container">
                <a href="Login.aspx" class="back-button">
                    <i class="fas fa-arrow-left"></i>
                </a>
                <div class="logo">
                    <img src="Images/logo.png" alt="Logo" />
                </div>
            </div>

            <h2>Create Customer Account</h2>
            
            <div class="form-container">
                <asp:Label ID="lblGeneralError" runat="server" CssClass="general-error" Visible="false"></asp:Label>
                <asp:Label ID="lblSuccess" runat="server" CssClass="success-message" Visible="false"></asp:Label>

                <div class="input-row">
                    <div class="input-box">
                        <asp:TextBox ID="txtFullName" runat="server" placeholder="Full Name" />
                        <asp:Label ID="lblFullNameError" runat="server" CssClass="field-error" Text="" Visible="false"></asp:Label>
                    </div>
                    <div class="input-box">
                        <asp:TextBox ID="txtUsername" runat="server" placeholder="Username" />
                        <asp:Label ID="lblUsernameError" runat="server" CssClass="field-error" Text="" Visible="false"></asp:Label>
                    </div>
                </div>

                <div class="input-row">
                    <div class="input-box">
                        <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" placeholder="Email" />
                        <asp:Label ID="lblEmailError" runat="server" CssClass="field-error" Text="" Visible="false"></asp:Label>
                    </div>
                    <div class="input-box mobile-input">
                        <span class="mobile-prefix">+63</span>
                        <asp:TextBox ID="txtMobile" runat="server" placeholder="9XXXXXXXXX" MaxLength="10" />
                        <asp:Label ID="lblMobileError" runat="server" CssClass="field-error" Text="" Visible="false"></asp:Label>
                    </div>
                </div>

                <div class="input-row">
                    <div class="input-box password-box">
                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Password" />
                        <i id="togglePwd" class="fa fa-eye-slash"></i>
                        <asp:Label ID="lblPasswordError" runat="server" CssClass="field-error" Text="" Visible="false"></asp:Label>
                    </div>
                    <div class="input-box password-box">
                        <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" placeholder="Confirm Password" />
                        <i id="toggleConfirmPwd" class="fa fa-eye-slash"></i>
                        <asp:Label ID="lblConfirmPasswordError" runat="server" CssClass="field-error" Text="" Visible="false"></asp:Label>
                    </div>
                </div>

                <div class="gender-container">
                    <span class="gender-label">Gender</span>
                    <asp:RadioButtonList ID="rblGender" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow" CssClass="gender-category-list">
                        <asp:ListItem Text="Male" Value="Male"></asp:ListItem>
                        <asp:ListItem Text="Female" Value="Female"></asp:ListItem>
                    </asp:RadioButtonList>
                    <asp:Label ID="lblGenderError" runat="server" CssClass="field-error" Text="" Visible="false"></asp:Label>
                </div>

                <div id="otpSectionContainer" class="otp-section-container">
                    <div class="otp-email-info">
                        <i class="fas fa-envelope"></i>
                        <span>
                            <strong>OTP sent to</strong> 
                            <span class="email-highlight" id="emailDisplay"></span>
                            <span>. Please check your inbox and enter the 6-digit code.</span>
                        </span>
                    </div>
                    
                    <div class="otp-input-group">
                        <div class="input-box">
                            <asp:TextBox ID="txtOTP" runat="server" placeholder="Enter 6-digit OTP" MaxLength="6" />
                            <asp:Label ID="lblOTPError" runat="server" CssClass="field-error" Text="" Visible="false"></asp:Label>
                        </div>
                        <asp:Button ID="btnVerifyOTP" runat="server" Text="Verify OTP" CssClass="btn-verify" OnClick="btnVerifyOTP_Click" />
                    </div>
                    <div class="resend-section">
                        <asp:LinkButton ID="btnResendOTP" runat="server" Text="Resend OTP" CssClass="sign-in-link" OnClick="btnResendOTP_Click" style="font-size:12px;"></asp:LinkButton>
                        <span id="timerDisplay" style="color: #ffc107; font-size: 12px;"></span>
                    </div>
                </div>
            </div>

            <div class="button-group">
                <asp:Button ID="btnCustomerRegister" runat="server" Text="Register" CssClass="btn-register" OnClick="btnCustomerRegister_Click" OnClientClick="return validateMobile()" />
            </div>

            <div id="validationSummary" class="validation-summary hidden">
                <h4><i class="fas fa-exclamation-triangle"></i> Please fix the following errors:</h4>
                <ul id="errorList"></ul>
            </div>

            <div id="successBox" class="success-box hidden">
                <i class="fas fa-check-circle"></i>
                <h4>Registration Successful!</h4>
                <p>You can now login to your account.</p>
            </div>

            <div class="extra-text">
                Already have an account?
                <a href="Login.aspx" class="sign-in-link">Sign In</a>
            </div>
        </div>
    </form>

    <script>
        let timerInterval;

        function validatePhilippineMobile(mobileNumber) {
            const cleaned = mobileNumber.replace(/\D/g, '');
            if (cleaned.length === 10 && cleaned.startsWith('9')) {
                return true;
            }
            return false;
        }

        function formatMobileNumber(input) {
            let cleaned = input.value.replace(/\D/g, '');
            if (cleaned.length > 10) {
                cleaned = cleaned.slice(0, 10);
            }
            input.value = cleaned;
        }

        function validateMobile() {
            const mobileField = document.getElementById('<%= txtMobile.ClientID %>');
            const mobileNumber = mobileField.value.trim();
            const errorLabel = document.getElementById('<%= lblMobileError.ClientID %>');

            if (!mobileNumber) {
                if (errorLabel) {
                    errorLabel.textContent = 'Mobile number is required';
                    errorLabel.style.display = 'block';
                    errorLabel.style.visibility = 'visible';
                }
                mobileField.classList.add('input-error');
                return false;
            }

            if (!validatePhilippineMobile(mobileNumber)) {
                if (errorLabel) {
                    errorLabel.textContent = 'Please enter a valid Philippine mobile number (e.g., 9123456789)';
                    errorLabel.style.display = 'block';
                    errorLabel.style.visibility = 'visible';
                }
                mobileField.classList.add('input-error');
                return false;
            }

            if (errorLabel) {
                errorLabel.style.display = 'none';
            }
            mobileField.classList.remove('input-error');
            return true;
        }

        function setupMobileValidation() {
            const mobileField = document.getElementById('<%= txtMobile.ClientID %>');

            if (mobileField) {
                mobileField.addEventListener('input', function () {
                    formatMobileNumber(this);
                    const isValid = validatePhilippineMobile(this.value.trim());
                    const errorLabel = document.getElementById('<%= lblMobileError.ClientID %>');
                    if (this.value.trim() && !isValid) {
                        if (errorLabel) {
                            errorLabel.textContent = 'Enter 10 digits starting with 9 (e.g., 9123456789)';
                            errorLabel.style.display = 'block';
                        }
                        this.classList.add('input-error');
                    } else {
                        if (errorLabel) {
                            errorLabel.style.display = 'none';
                        }
                        this.classList.remove('input-error');
                    }
                });
            }
        }

        function updateEmailDisplay() {
            const emailField = document.getElementById('<%= txtEmail.ClientID %>');
            const emailDisplaySpan = document.getElementById('emailDisplay');
            if (emailField && emailDisplaySpan) {
                const email = emailField.value.trim();
                if (email) {
                    emailDisplaySpan.textContent = email;
                } else {
                    emailDisplaySpan.textContent = 'your email';
                }
            }
        }

        function startTimer(duration) {
            let timer = duration;
            const timerDisplay = document.getElementById('timerDisplay');
            const resendButton = document.getElementById('<%= btnResendOTP.ClientID %>');
            
            if (timerInterval) clearInterval(timerInterval);
            
            if (resendButton) {
                resendButton.style.pointerEvents = 'none';
                resendButton.style.opacity = '0.5';
            }
            
            timerInterval = setInterval(function() {
                const minutes = parseInt(timer / 60, 10);
                const seconds = parseInt(timer % 60, 10);
                
                const displayMinutes = minutes < 10 ? '0' + minutes : minutes;
                const displaySeconds = seconds < 10 ? '0' + seconds : seconds;
                
                if (timerDisplay) {
                    timerDisplay.textContent = 'Resend available in ' + displayMinutes + ':' + displaySeconds;
                }
                
                if (--timer < 0) {
                    clearInterval(timerInterval);
                    if (timerDisplay) timerDisplay.textContent = '';
                    if (resendButton) {
                        resendButton.style.pointerEvents = 'auto';
                        resendButton.style.opacity = '1';
                    }
                }
            }, 1000);
        }

        function showOTPSection() {
            const otpSection = document.getElementById('otpSectionContainer');
            const registerBtn = document.getElementById('<%= btnCustomerRegister.ClientID %>');
            
            updateEmailDisplay();
            
            if (otpSection) {
                otpSection.style.display = 'block';
                otpSection.scrollIntoView({ behavior: 'smooth', block: 'center' });
            }
            if (registerBtn) {
                registerBtn.disabled = true;
                registerBtn.style.opacity = '0.5';
                registerBtn.style.cursor = 'not-allowed';
            }
            startTimer(300);
        }

        function hideOTPSection() {
            const otpSection = document.getElementById('otpSectionContainer');
            const registerBtn = document.getElementById('<%= btnCustomerRegister.ClientID %>');
            
            if (otpSection) otpSection.style.display = 'none';
            if (registerBtn) {
                registerBtn.disabled = false;
                registerBtn.style.opacity = '1';
                registerBtn.style.cursor = 'pointer';
            }
            if (timerInterval) clearInterval(timerInterval);
        }

        function showSuccessMessage() {
            const successBox = document.getElementById('successBox');
            if (successBox) {
                successBox.classList.remove('hidden');
                successBox.scrollIntoView({ behavior: 'smooth', block: 'start' });
            }
        }

        const togglePwd = document.getElementById("togglePwd");
        const pwd = document.getElementById('<%= txtPassword.ClientID %>');
        const toggleConfirmPwd = document.getElementById("toggleConfirmPwd");
        const confirmPwd = document.getElementById('<%= txtConfirmPassword.ClientID %>');

        if (togglePwd && pwd) {
            togglePwd.addEventListener("click", () => {
                togglePwd.classList.add("active");
                if (pwd.type === "password") {
                    pwd.type = "text";
                    togglePwd.classList.replace("fa-eye-slash", "fa-eye");
                } else {
                    pwd.type = "password";
                    togglePwd.classList.replace("fa-eye", "fa-eye-slash");
                }
                setTimeout(() => togglePwd.classList.remove("active"), 200);
            });
        }

        if (toggleConfirmPwd && confirmPwd) {
            toggleConfirmPwd.addEventListener("click", () => {
                toggleConfirmPwd.classList.add("active");
                if (confirmPwd.type === "password") {
                    confirmPwd.type = "text";
                    toggleConfirmPwd.classList.replace("fa-eye-slash", "fa-eye");
                } else {
                    confirmPwd.type = "password";
                    toggleConfirmPwd.classList.replace("fa-eye", "fa-eye-slash");
                }
                setTimeout(() => toggleConfirmPwd.classList.remove("active"), 200);
            });
        }

        document.addEventListener('DOMContentLoaded', function () {
            setupMobileValidation();
            
            const emailField = document.getElementById('<%= txtEmail.ClientID %>');
            if (emailField) {
                emailField.addEventListener('change', updateEmailDisplay);
                emailField.addEventListener('blur', updateEmailDisplay);
                emailField.addEventListener('input', updateEmailDisplay);
            }

            updateEmailDisplay();
        });
    </script>
</body>
</html>