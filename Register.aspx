<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="TasteNet.Register" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Register | TasteNet</title>
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
            font-family: 'Poppins', 'Segoe UI', sans-serif;
            background: url('Images/landingpage.jpg') no-repeat center center fixed;
            background-size: cover;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 16px;
            position: relative;
        }

        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.55);
            z-index: -1;
        }

        .register-card {
            width: 100%;
            max-width: 520px;
            background: #4b0000;
            padding: 20px 24px;
            border-radius: 28px;
            text-align: center;
            color: #fff;
            border: 2px solid #ffc107;
            box-shadow: 0 0 6px #ffc107, 0 0 12px #ffc107, 0 0 24px rgba(255, 193, 7, 0.3), inset 0 0 6px rgba(255, 193, 7, 0.2);
            transition: all 0.3s ease;
            animation: glowPulse 1.5s infinite alternate;
            position: relative;
            margin: 0 auto;
        }

        @keyframes glowPulse {
            from { box-shadow: 0 0 5px #ffc107; }
            to { box-shadow: 0 0 14px #ffc107, 0 0 28px rgba(255, 193, 7, 0.8); }
        }

        .header-container {
            position: relative;
            width: 100%;
            display: flex;
            align-items: flex-start;
            justify-content: center;
            margin-bottom: 5px;
        }

        .back-button {
            position: absolute;
            left: -8px;
            top: -8px;
            color: #ffc107;
            text-decoration: none;
            font-size: 18px;
            transition: all 0.3s ease;
            width: 36px;
            height: 36px;
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
            width: 60px;
            margin-bottom: 5px;
            border-radius: 50%;
            border: 2px solid #FFD41D;
            background: #fff3d1;
        }

        h2 {
            margin-top: 5px;
            margin-bottom: 8px;
            font-weight: 600;
            font-size: 1.4em;
            font-family: 'Poppins', sans-serif;
            letter-spacing: 0.5px;
            color: #FFE6A3;
        }

        /* Privacy Notice - beautifully integrated */
        .privacy-notice-card {
            background: rgba(255, 193, 7, 0.08);
            border-radius: 20px;
            padding: 10px 14px;
            margin: 8px 0 12px 0;
            text-align: left;
            font-size: 11px;
            color: #f5e6c4;
            border-left: 3px solid #ffc107;
            backdrop-filter: blur(2px);
            transition: all 0.3s ease;
            display: flex;
            align-items: flex-start;
            gap: 12px;
            position: relative;
            overflow: hidden;
        }

        .privacy-notice-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 193, 7, 0.1), transparent);
            transition: left 0.6s ease;
        }

        .privacy-notice-card:hover::before {
            left: 100%;
        }

        .privacy-notice-card i {
            color: #ffc107;
            font-size: 16px;
            margin-top: 1px;
            flex-shrink: 0;
            filter: drop-shadow(0 0 3px rgba(255, 193, 7, 0.5));
        }

        .privacy-notice-card span {
            line-height: 1.45;
            font-weight: 400;
            letter-spacing: 0.2px;
            font-size: 11px;
        }

        .privacy-notice-card strong {
            color: #ffc107;
            font-weight: 600;
        }

        .privacy-notice-card:hover {
            background: rgba(255, 193, 7, 0.15);
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
        }

        .form-container {
            max-height: 440px;
            overflow-y: auto;
            padding-right: 6px;
            margin: 6px 0 10px 0;
            overflow-x: hidden;
        }

        .form-container::-webkit-scrollbar {
            width: 4px;
        }

        .form-container::-webkit-scrollbar-track {
            background: rgba(255, 193, 7, 0.1);
            border-radius: 3px;
        }

        .form-container::-webkit-scrollbar-thumb {
            background: #ffc107;
            border-radius: 3px;
        }

        .section-title {
            font-size: 13px;
            color: #ffc107;
            margin: 10px 0 6px 0;
            text-align: left;
            font-weight: 600;
            border-left: 3px solid #ffc107;
            padding-left: 10px;
        }

        .triple-row {
            display: flex;
            gap: 10px;
            margin-bottom: 6px;
            flex-wrap: wrap;
        }

        .triple-row .input-box {
            flex: 1;
            min-width: 0;
        }

        .double-row {
            display: flex;
            gap: 10px;
            margin-bottom: 6px;
            flex-wrap: wrap;
        }

        .double-row .input-box {
            flex: 1;
            min-width: 0;
        }

        .input-box {
            position: relative;
            margin-bottom: 4px;
        }

        .input-box input, .input-box select {
            width: 100%;
            height: 42px;
            padding: 0 40px 0 14px;
            border-radius: 30px;
            border: none;
            outline: none;
            font-size: 13px;
            font-family: 'Poppins', sans-serif;
            box-sizing: border-box;
            background: white;
            transition: all 0.3s ease;
        }

        .input-box input:focus, .input-box select:focus {
            box-shadow: 0 0 0 2px #ffc107, 0 0 8px rgba(255, 193, 7, 0.5);
        }

        .input-box input::placeholder {
            font-family: 'Poppins', sans-serif;
            font-size: 12px;
            font-weight: 300;
            color: #888;
        }

        .password-box input {
            padding-right: 45px;
        }

        .mobile-input {
            position: relative;
        }

        .mobile-prefix {
            position: absolute;
            left: 14px;
            top: 50%;
            transform: translateY(-50%);
            color: #666;
            font-size: 12px;
            font-weight: 500;
            pointer-events: none;
            z-index: 1;
        }

        .mobile-input input {
            padding-left: 42px;
        }

        .gender-container {
            text-align: left;
            margin: 8px 0 6px 0;
        }

        .gender-label {
            display: block;
            margin-bottom: 6px;
            font-size: 12px;
            font-family: 'Poppins', sans-serif;
            color: #FFE6A3;
            padding-left: 5px;
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
            padding: 8px 10px;
            text-align: center;
            border: 2px solid rgba(255, 212, 29, 0.4);
            border-radius: 30px;
            cursor: pointer;
            font-size: 13px;
            font-family: 'Poppins', sans-serif;
            transition: all 0.3s ease;
            background: rgba(255, 255, 255, 0.05);
            color: #fff;
        }

        .gender-category-list label:hover {
            border-color: #FFD41D;
            background: rgba(255, 212, 29, 0.15);
            transform: translateY(-1px);
        }

        .gender-category-list input[type="radio"]:checked + label {
            background: #FFD41D;
            color: #4b0000;
            border-color: #FFD41D;
            font-weight: 600;
        }

        .password-box {
            position: relative;
        }

        .password-box i {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: #777;
            transition: all 0.2s ease;
            z-index: 2;
            font-size: 1em;
        }

        .password-box i:hover {
            color: #ffc107;
        }

        .district-info {
            background: rgba(255, 193, 7, 0.12);
            padding: 6px 10px;
            border-radius: 20px;
            margin-top: 6px;
            text-align: left;
            font-size: 10px;
            color: #ffc107;
            border: 1px dashed rgba(255, 193, 7, 0.4);
            display: inline-block;
            width: auto;
        }

        .district-info i {
            margin-right: 4px;
            font-size: 10px;
        }

        .btn-register {
            margin-top: 8px;
            background: transparent;
            border: 2px solid #ffc107;
            padding: 7px 24px;
            width: auto;
            min-width: 130px;
            color: #ffc107;
            font-size: 14px;
            font-family: 'Poppins', sans-serif;
            font-weight: 600;
            letter-spacing: 0.5px;
            border-radius: 40px;
            cursor: pointer;
            transition: all 0.3s ease;
            text-transform: uppercase;
            display: inline-block;
        }

        .btn-register:hover {
            background: #ffc107;
            color: #4b0000;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 193, 7, 0.4);
        }

        .btn-verify {
            background: transparent;
            border: 2px solid #4CAF50;
            padding: 7px 16px;
            color: #4CAF50;
            font-size: 12px;
            font-family: 'Poppins', sans-serif;
            font-weight: 500;
            border-radius: 30px;
            cursor: pointer;
            transition: all 0.3s ease;
            white-space: nowrap;
        }

        .btn-verify:hover {
            background: #4CAF50;
            color: white;
            transform: translateY(-1px);
        }

        .otp-section-container {
            display: none;
            margin: 12px 0;
            padding: 10px;
            border-top: 1px solid rgba(255, 193, 7, 0.3);
            border-bottom: 1px solid rgba(255, 193, 7, 0.3);
            background: rgba(0, 0, 0, 0.2);
            border-radius: 16px;
            animation: fadeIn 0.4s ease;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-8px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .otp-email-info {
            display: flex;
            align-items: flex-start;
            gap: 8px;
            background: rgba(255, 193, 7, 0.1);
            padding: 8px 10px;
            border-radius: 12px;
            margin-bottom: 10px;
            border-left: 3px solid #ffc107;
        }

        .otp-email-info i {
            color: #ffc107;
            font-size: 14px;
            margin-top: 2px;
        }

        .otp-email-info span {
            color: #e0e0e0;
            font-size: 11px;
            line-height: 1.4;
        }

        .email-highlight {
            color: #ffc107;
            font-weight: 600;
        }

        .otp-input-group {
            display: flex;
            gap: 8px;
            align-items: center;
            flex-wrap: wrap;
        }

        .otp-input-group .input-box {
            flex: 2;
            min-width: 150px;
        }

        .otp-input-group .btn-verify {
            flex: 1;
            min-width: 90px;
        }

        .resend-section {
            text-align: center;
            margin-top: 10px;
            font-size: 11px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
            flex-wrap: wrap;
        }

        .sign-in-link {
            color: #ffc107;
            text-decoration: none;
            font-weight: 500;
            padding: 3px 10px;
            border-radius: 20px;
            background: rgba(255, 193, 7, 0.1);
            transition: all 0.3s ease;
            display: inline-block;
            font-size: 12px;
        }

        .sign-in-link:hover {
            background: rgba(255, 193, 7, 0.25);
            transform: translateY(-1px);
            text-decoration: none;
            color: #fff;
        }

        #timerDisplay {
            color: #ffc107;
            font-size: 11px;
        }

        .field-error {
            color: #ffae00 !important;
            font-size: 10px;
            text-align: left;
            padding-left: 12px;
            margin-top: 3px;
            display: block;
            font-weight: 500;
            min-height: 16px;
            background: rgba(255, 193, 7, 0.08);
            padding: 3px 8px;
            border-radius: 5px;
            border-left: 2px solid #ffc107;
        }

        .input-error {
            border: 1.5px solid #ffc107 !important;
            box-shadow: 0 0 6px rgba(255, 193, 7, 0.4) !important;
        }

        .extra-text {
            margin-top: 14px;
            font-size: 12px;
            color: #ddd;
        }

        .button-group {
            display: flex;
            justify-content: center;
            margin-top: 8px;
        }

        .hidden {
            display: none !important;
        }

        .success-box {
            background: rgba(76, 175, 80, 0.12);
            border: 1px solid #4CAF50;
            border-radius: 14px;
            padding: 10px;
            margin: 10px 0;
            text-align: center;
        }

        .success-box i {
            color: #4CAF50;
            font-size: 20px;
        }

        .success-box h4 {
            color: #4CAF50;
            font-size: 13px;
        }

        .validation-summary {
            background: rgba(255, 193, 7, 0.1);
            border: 1px solid #ffc107;
            border-radius: 12px;
            padding: 8px;
            margin: 10px 0;
            text-align: left;
        }

        .validation-summary h4 {
            color: #ffc107;
            font-size: 12px;
        }

        .validation-summary ul {
            margin-left: 18px;
            color: #ffc107;
            font-size: 11px;
        }

        .general-error {
            color: #ffc107 !important;
            font-size: 11px;
            text-align: center;
            background: rgba(255, 193, 7, 0.1);
            padding: 6px 10px;
            border-radius: 8px;
            margin: 6px 0;
        }

        .success-message {
            color: #4CAF50 !important;
            font-size: 11px;
            text-align: center;
            background: rgba(76, 175, 80, 0.1);
            padding: 6px 10px;
            border-radius: 8px;
            margin: 6px 0;
        }

        @media (max-width: 550px) {
            .register-card {
                max-width: 100%;
                padding: 16px 18px;
                border-radius: 24px;
            }
            
            .triple-row, .double-row {
                flex-direction: column;
                gap: 6px;
            }
            
            .triple-row .input-box, .double-row .input-box {
                min-width: 100%;
            }
            
            .gender-category-list {
                flex-direction: column;
                gap: 6px;
            }
            
            .otp-input-group {
                flex-direction: column;
                gap: 8px;
            }
            
            .otp-input-group .btn-verify {
                width: 100%;
                min-width: auto;
            }
            
            .resend-section {
                flex-direction: column;
                gap: 6px;
            }
            
            h2 {
                font-size: 1.3em;
                margin-bottom: 8px;
            }
            
            .logo img {
                width: 50px;
            }
            
            .back-button {
                width: 32px;
                height: 32px;
                font-size: 16px;
                left: -5px;
                top: -5px;
            }
            
            .section-title {
                font-size: 12px;
                margin: 8px 0 4px 0;
            }
            
            .input-box input, .input-box select {
                height: 40px;
                font-size: 12px;
            }
            
            .btn-register {
                padding: 6px 20px;
                font-size: 13px;
                min-width: 120px;
            }
            
            .form-container {
                max-height: 420px;
            }
            
            .privacy-notice-card {
                padding: 8px 12px;
                gap: 8px;
            }
            .privacy-notice-card i {
                font-size: 14px;
            }
        }

        @media (max-width: 380px) {
            .register-card {
                padding: 14px 14px;
            }
            
            .input-box input, .input-box select {
                height: 38px;
                font-size: 11px;
            }
            
            .mobile-prefix {
                font-size: 11px;
                left: 12px;
            }
            
            .gender-category-list label {
                padding: 6px 8px;
                font-size: 12px;
            }
            
            .privacy-notice-card span {
                font-size: 10px;
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
            
            <!-- PRIVACY NOTICE: Placed beautifully below the heading, compliments the design -->
            <div class="privacy-notice-card">
                <i class="fas fa-shield-alt"></i>
                <span>
                    <strong>Data Privacy Notice:</strong> The information/data you provided will strictly be used to provide, maintain, and improve our services, and to communicate with you regarding your account.
                </span>
            </div>
            
            <div class="form-container">
                <asp:Label ID="lblGeneralError" runat="server" CssClass="general-error" Visible="false"></asp:Label>
                <asp:Label ID="lblSuccess" runat="server" CssClass="success-message" Visible="false"></asp:Label>

                <div class="section-title">Personal Information</div>
                
                <div class="triple-row">
                    <div class="input-box">
                        <asp:TextBox ID="txtFirstName" runat="server" placeholder="First Name" />
                        <asp:Label ID="lblFirstNameError" runat="server" CssClass="field-error" Text="" Visible="false"></asp:Label>
                    </div>
                    <div class="input-box">
                        <asp:TextBox ID="txtMiddleInitial" runat="server" placeholder="Middle Initial" MaxLength="2" />
                        <asp:Label ID="lblMiddleInitialError" runat="server" CssClass="field-error" Text="" Visible="false"></asp:Label>
                    </div>
                    <div class="input-box">
                        <asp:TextBox ID="txtLastName" runat="server" placeholder="Last Name" />
                        <asp:Label ID="lblLastNameError" runat="server" CssClass="field-error" Text="" Visible="false"></asp:Label>
                    </div>
                </div>

                <div class="triple-row">
                    <div class="input-box">
                        <asp:TextBox ID="txtUsername" runat="server" placeholder="Username" />
                        <asp:Label ID="lblUsernameError" runat="server" CssClass="field-error" Text="" Visible="false"></asp:Label>
                    </div>
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

                <div class="gender-container">
                    <span class="gender-label">Gender</span>
                    <asp:RadioButtonList ID="rblGender" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow" CssClass="gender-category-list">
                        <asp:ListItem Text="Male" Value="Male"></asp:ListItem>
                        <asp:ListItem Text="Female" Value="Female"></asp:ListItem>
                    </asp:RadioButtonList>
                    <asp:Label ID="lblGenderError" runat="server" CssClass="field-error" Text="" Visible="false"></asp:Label>
                </div>

                <div class="section-title">Address Information</div>
                
                <div class="double-row">
                    <div class="input-box">
                        <asp:TextBox ID="txtHouseNo" runat="server" placeholder="House/Building No." />
                        <asp:Label ID="lblHouseNoError" runat="server" CssClass="field-error" Text="" Visible="false"></asp:Label>
                    </div>
                    <div class="input-box">
                        <asp:TextBox ID="txtStreet" runat="server" placeholder="Street" />
                        <asp:Label ID="lblStreetError" runat="server" CssClass="field-error" Text="" Visible="false"></asp:Label>
                    </div>
                </div>

                <div class="double-row">
                    <div class="input-box">
                        <asp:TextBox ID="txtBarangay" runat="server" placeholder="Barangay" />
                        <asp:Label ID="lblBarangayError" runat="server" CssClass="field-error" Text="" Visible="false"></asp:Label>
                    </div>
                    <div class="input-box">
                        <asp:HiddenField ID="hfDistrict" runat="server" Value="Dasmariñas" />
                        <asp:TextBox ID="txtDistrict" runat="server" placeholder="District" Text="Dasmariñas" ReadOnly="true" BackColor="#f0f0f0" style="background:#f5f3e8;" />
                        <asp:Label ID="lblDistrictError" runat="server" CssClass="field-error" Text="" Visible="false"></asp:Label>
                    </div>
                </div>
                <div class="district-info">
                    <i class="fas fa-info-circle"></i> Service area : Dasmariñas, Cavite
                </div>

                <div class="section-title">Security Information</div>
                
                <div class="double-row">
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

                <div id="otpSectionContainer" class="otp-section-container">
                    <div class="otp-email-info">
                        <i class="fas fa-envelope"></i>
                        <span>
                            <strong>OTP sent to</strong> 
                            <span class="email-highlight" id="emailDisplay"></span>
                            <span>. Enter 6-digit code.</span>
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
                        <asp:LinkButton ID="btnResendOTP" runat="server" Text="Resend OTP" CssClass="sign-in-link" OnClick="btnResendOTP_Click" style="font-size:11px;"></asp:LinkButton>
                        <span id="timerDisplay"></span>
                    </div>
                </div>
            </div>

            <div class="button-group">
                <asp:Button ID="btnCustomerRegister" runat="server" Text="REGISTER" CssClass="btn-register" OnClick="btnCustomerRegister_Click" />
            </div>

            <div id="validationSummary" class="validation-summary hidden">
                <h4><i class="fas fa-exclamation-triangle"></i> Please fix errors:</h4>
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
            return (cleaned.length === 10 && cleaned.startsWith('9'));
        }

        function formatMobileNumber(input) {
            let cleaned = input.value.replace(/\D/g, '');
            if (cleaned.length > 10) cleaned = cleaned.slice(0, 10);
            input.value = cleaned;
        }

        function validateMobile() {
            const mobileField = document.getElementById('<%= txtMobile.ClientID %>');
            const mobileNumber = mobileField.value.trim();
            const errorLabel = document.getElementById('<%= lblMobileError.ClientID %>');
            if (!mobileNumber) {
                if (errorLabel) { errorLabel.textContent = 'Mobile number required'; errorLabel.style.display = 'block'; }
                mobileField.classList.add('input-error');
                return false;
            }
            if (!validatePhilippineMobile(mobileNumber)) {
                if (errorLabel) { errorLabel.textContent = 'Enter valid 10-digit number starting with 9'; errorLabel.style.display = 'block'; }
                mobileField.classList.add('input-error');
                return false;
            }
            if (errorLabel) errorLabel.style.display = 'none';
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
                        if (errorLabel) { errorLabel.textContent = 'Use 10 digits starting with 9'; errorLabel.style.display = 'block'; }
                        this.classList.add('input-error');
                    } else {
                        if (errorLabel) errorLabel.style.display = 'none';
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
                emailDisplaySpan.textContent = email || 'your email';
            }
        }

        function startTimer(duration) {
            let timer = duration;
            const timerDisplay = document.getElementById('timerDisplay');
            const resendButton = document.getElementById('<%= btnResendOTP.ClientID %>');
            if(timerInterval) clearInterval(timerInterval);
            if(resendButton) { resendButton.style.pointerEvents = 'none'; resendButton.style.opacity = '0.5'; }
            timerInterval = setInterval(function() {
                const minutes = parseInt(timer / 60, 10);
                const seconds = parseInt(timer % 60, 10);
                const displayMinutes = minutes < 10 ? '0' + minutes : minutes;
                const displaySeconds = seconds < 10 ? '0' + seconds : seconds;
                if(timerDisplay) timerDisplay.textContent = 'Resend in ' + displayMinutes + ':' + displaySeconds;
                if(--timer < 0) {
                    clearInterval(timerInterval);
                    if(timerDisplay) timerDisplay.textContent = '';
                    if(resendButton) { resendButton.style.pointerEvents = 'auto'; resendButton.style.opacity = '1'; }
                }
            }, 1000);
        }

        function showOTPSection() {
            const otpSection = document.getElementById('otpSectionContainer');
            const registerBtn = document.getElementById('<%= btnCustomerRegister.ClientID %>');
            updateEmailDisplay();
            if(otpSection) { otpSection.style.display = 'block'; otpSection.scrollIntoView({ behavior: 'smooth', block: 'center' }); }
            if(registerBtn) { registerBtn.disabled = true; registerBtn.style.opacity = '0.5'; registerBtn.style.cursor = 'not-allowed'; }
            startTimer(300);
        }

        function hideOTPSection() {
            const otpSection = document.getElementById('otpSectionContainer');
            const registerBtn = document.getElementById('<%= btnCustomerRegister.ClientID %>');
            if(otpSection) otpSection.style.display = 'none';
            if(registerBtn) { registerBtn.disabled = false; registerBtn.style.opacity = '1'; registerBtn.style.cursor = 'pointer'; }
            if(timerInterval) clearInterval(timerInterval);
        }

        const togglePwd = document.getElementById("togglePwd");
        const pwd = document.getElementById('<%= txtPassword.ClientID %>');
        const toggleConfirmPwd = document.getElementById("toggleConfirmPwd");
        const confirmPwd = document.getElementById('<%= txtConfirmPassword.ClientID %>');
        if(togglePwd && pwd) {
            togglePwd.addEventListener("click", () => {
                if(pwd.type === "password") { pwd.type = "text"; togglePwd.classList.remove("fa-eye-slash"); togglePwd.classList.add("fa-eye"); }
                else { pwd.type = "password"; togglePwd.classList.remove("fa-eye"); togglePwd.classList.add("fa-eye-slash"); }
            });
        }
        if(toggleConfirmPwd && confirmPwd) {
            toggleConfirmPwd.addEventListener("click", () => {
                if(confirmPwd.type === "password") { confirmPwd.type = "text"; toggleConfirmPwd.classList.remove("fa-eye-slash"); toggleConfirmPwd.classList.add("fa-eye"); }
                else { confirmPwd.type = "password"; toggleConfirmPwd.classList.remove("fa-eye"); toggleConfirmPwd.classList.add("fa-eye-slash"); }
            });
        }

        document.addEventListener('DOMContentLoaded', function() {
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