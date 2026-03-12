<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="TasteNet.Register" %>

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

        .user-type-card {
            width: 360px;
            background: #4b0000;
            padding: 25px 20px;
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

        h3 {
            margin: 15px 0 25px 0;
            font-weight: 500;
            font-size: 1.2em;
            color: #ffc107;
            font-family: 'Poppins', sans-serif;
        }

        .user-type-buttons {
            display: flex;
            gap: 15px;
            margin-bottom: 20px;
        }

        .user-type-btn {
            flex: 1;
            padding: 18px 10px;
            border: 2px solid rgba(255, 212, 29, 0.3);
            border-radius: 18px;
            background: rgba(255, 255, 255, 0.05);
            color: white;
            font-size: 15px;
            font-family: 'Poppins', sans-serif;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }

        .user-type-btn i {
            font-size: 28px;
            color: #ffc107;
        }

        .user-type-btn:hover {
            border-color: #FFD41D;
            background: rgba(255, 212, 29, 0.1);
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(255, 193, 7, 0.3);
        }

        .user-type-btn.selected {
            background: #FFD41D;
            color: #4b0000;
            border-color: #FFD41D;
            font-weight: 600;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(255, 193, 7, 0.5);
        }

        .user-type-btn.selected i {
            color: #4b0000;
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

        .back-btn {
            margin-top: 15px;
            background: transparent;
            border: 1.5px solid rgba(255, 255, 255, 0.25);
            padding: 8px 20px;
            color: #fff;
            font-size: 14px;
            font-family: 'Poppins', sans-serif;
            border-radius: 30px;
            cursor: pointer;
            transition: all 0.3s ease;
            font-weight: 500;
        }

        .back-btn:hover {
            background: rgba(255, 255, 255, 0.1);
            border-color: #ffc107;
            transform: translateY(-1px);
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

        .section-title {
            text-align: left;
            color: #ffc107;
            font-size: 15px;
            font-family: 'Poppins', sans-serif;
            font-weight: 500;
            margin: 20px 0 12px 0;
            padding-bottom: 5px;
            border-bottom: 1px solid rgba(255, 193, 7, 0.3);
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .section-title i {
            font-size: 18px;
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

        .general-error, .success-message {
            padding: 12px 15px !important;
            border-radius: 10px !important;
            margin: 15px 0 !important;
            text-align: center;
            animation: fadeIn 0.5s ease;
            font-family: 'Poppins', sans-serif;
            font-size: 14px;
        }

        .general-error {
            background: rgba(255, 193, 7, 0.1) !important;
            border: 1px solid #ffc107 !important;
            color: #ffc107 !important;
        }

        .success-message {
            background: rgba(76, 175, 80, 0.1) !important;
            border: 1px solid #4CAF50 !important;
            color: #4CAF50 !important;
        }

        .hidden {
            display: none !important;
        }

        .file-upload-box {
            text-align: left;
            margin: 15px 0;
        }

        .file-upload-label {
            display: block;
            font-size: 14px;
            font-family: 'Poppins', sans-serif;
            color: #ccc;
            margin-bottom: 6px;
            padding-left: 12px;
        }

        .file-upload-input {
            width: 100%;
            padding: 12px 15px;
            border-radius: 25px;
            border: 1px dashed rgba(255, 193, 7, 0.5);
            background: rgba(255, 255, 255, 0.05);
            color: white;
            font-size: 14px;
            font-family: 'Poppins', sans-serif;
            cursor: pointer;
            transition: all 0.3s ease;
            box-sizing: border-box;
        }

        .file-upload-input:hover {
            border-color: #ffc107;
            background: rgba(255, 193, 7, 0.1);
        }

        .file-upload-input:focus {
            outline: none;
            border-color: #ffc107;
            box-shadow: 0 0 6px rgba(255, 193, 7, 0.5);
        }

        .info-text {
            font-size: 12px;
            font-family: 'Poppins', sans-serif;
            color: #aaa;
            text-align: left;
            padding-left: 12px;
            margin-top: 5px;
            font-style: italic;
        }

        .form-container {
            max-height: 500px;
            overflow-y: auto;
            padding-right: 8px;
            margin: 15px 0;
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

        .success-box {
            background: rgba(76, 175, 80, 0.1);
            border: 1px solid #4CAF50;
            border-radius: 10px;
            padding: 18px;
            margin: 15px 0;
            text-align: center;
        }

        .success-box i {
            color: #4CAF50;
            font-size: 28px;
            margin-bottom: 10px;
        }

        .success-box h4 {
            color: #4CAF50;
            margin: 8px 0;
            font-size: 16px;
            font-family: 'Poppins', sans-serif;
            font-weight: 600;
        }

        .success-box p {
            color: #4CAF50;
            margin: 0;
            font-size: 14px;
            font-family: 'Poppins', sans-serif;
        }

        .required-field::after {
            content: " *";
            color: #ffc107;
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
    </style>
</head>

<body>
    <form id="form1" runat="server">
        <asp:HiddenField ID="hdnUserType" runat="server" Value="" />
        
        <div id="userTypeCard" class="user-type-card">
            <div class="logo">
                <img src="Images/logo.png" alt="Logo" />
            </div>
            
            <h2>Join TasteNet</h2>
            <h3>Select your role to continue</h3>
            
            <div class="user-type-buttons">
                <div class="user-type-btn" onclick="selectUserType('customer')">
                    <i class="fas fa-user"></i>
                    <span>Customer</span>
                </div>
                <div class="user-type-btn" onclick="selectUserType('rider')">
                    <i class="fas fa-motorcycle"></i>
                    <span>Rider</span>
                </div>
            </div>
            
            <asp:Label ID="lblUserTypeError" runat="server" CssClass="general-error" Text="" Visible="false"></asp:Label>
            
            <button type="button" class="btn-register" onclick="continueToRegister()">Continue</button>
            
            <div class="extra-text">
                Already have an account?
                <a href="Login.aspx" class="sign-in-link">Sign In</a>
            </div>
        </div>
        
        <div id="customerRegisterCard" class="register-card hidden">
            <div class="logo">
                <img src="Images/logo.png" alt="Logo" />
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
                    <div class="input-box">
                        <asp:TextBox ID="txtMobile" runat="server" placeholder="Mobile Number (+63)" />
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
                        <asp:ListItem Text="Rather not say" Value="Rather not say" Selected="True"></asp:ListItem>
                    </asp:RadioButtonList>
                    <asp:Label ID="lblGenderError" runat="server" CssClass="field-error" Text="" Visible="false"></asp:Label>
                </div>
            </div>

            <div class="button-group">
                <button type="button" class="back-btn" onclick="goBackToUserType()">
                    <i class="fas fa-arrow-left"></i> Back
                </button>
                <asp:Button ID="btnCustomerRegister" runat="server" Text="Register" CssClass="btn-register" OnClick="btnCustomerRegister_Click" />
            </div>

            <div id="customerValidationSummary" class="validation-summary hidden">
                <h4><i class="fas fa-exclamation-triangle"></i> Please fix the following errors:</h4>
                <ul id="customerErrorList"></ul>
            </div>

            <div id="customerSuccessBox" class="success-box hidden">
                <i class="fas fa-check-circle"></i>
                <h4>Registration Successful!</h4>
                <p>You can now login to your account.</p>
            </div>

            <div class="extra-text">
                Already have an account?
                <a href="Login.aspx" class="sign-in-link">Sign In</a>
            </div>
        </div>
        
        <div id="riderRegisterCard" class="register-card hidden">
            <div class="logo">
                <img src="Images/logo.png" alt="Logo" />
            </div>

            <h2>Create Rider Account</h2>
            
            <div class="form-container">
                <asp:Label ID="lblRiderGeneralError" runat="server" CssClass="general-error" Visible="false"></asp:Label>
                <asp:Label ID="lblRiderSuccess" runat="server" CssClass="success-message" Visible="false"></asp:Label>

                <div class="section-title">
                    <i class="fas fa-user"></i>
                    Personal Information
                </div>

                <div class="input-row">
                    <div class="input-box">
                        <asp:TextBox ID="txtRiderFullName" runat="server" placeholder="Full Name" />
                        <asp:Label ID="lblRiderFullNameError" runat="server" CssClass="field-error" Text="" Visible="false"></asp:Label>
                    </div>
                    <div class="input-box">
                        <asp:TextBox ID="txtRiderUsername" runat="server" placeholder="Username" />
                        <asp:Label ID="lblRiderUsernameError" runat="server" CssClass="field-error" Text="" Visible="false"></asp:Label>
                    </div>
                </div>

                <div class="input-row">
                    <div class="input-box">
                        <asp:TextBox ID="txtRiderEmail" runat="server" TextMode="Email" placeholder="Email" />
                        <asp:Label ID="lblRiderEmailError" runat="server" CssClass="field-error" Text="" Visible="false"></asp:Label>
                    </div>
                    <div class="input-box">
                        <asp:TextBox ID="txtRiderMobile" runat="server" placeholder="Mobile Number (+63)" />
                        <asp:Label ID="lblRiderMobileError" runat="server" CssClass="field-error" Text="" Visible="false"></asp:Label>
                    </div>
                </div>

                <div class="input-row">
                    <div class="input-box">
                        <asp:TextBox ID="txtDriverLicense" runat="server" placeholder="Driver's License Number" />
                        <asp:Label ID="lblDriverLicenseError" runat="server" CssClass="field-error" Text="" Visible="false"></asp:Label>
                    </div>
                    <div class="input-box">
                        <asp:TextBox ID="txtNBIClearance" runat="server" placeholder="NBI Clearance Number" />
                        <asp:Label ID="lblNBIClearanceError" runat="server" CssClass="field-error" Text="" Visible="false"></asp:Label>
                    </div>
                </div>

                <div class="input-row">
                    <div class="input-box password-box">
                        <asp:TextBox ID="txtRiderPassword" runat="server" TextMode="Password" placeholder="Password" />
                        <i id="toggleRiderPwd" class="fa fa-eye-slash"></i>
                        <asp:Label ID="lblRiderPasswordError" runat="server" CssClass="field-error" Text="" Visible="false"></asp:Label>
                    </div>
                    <div class="input-box password-box">
                        <asp:TextBox ID="txtRiderConfirmPassword" runat="server" TextMode="Password" placeholder="Confirm Password" />
                        <i id="toggleRiderConfirmPwd" class="fa fa-eye-slash"></i>
                        <asp:Label ID="lblRiderConfirmPasswordError" runat="server" CssClass="field-error" Text="" Visible="false"></asp:Label>
                    </div>
                </div>

                <div class="gender-container">
                    <span class="gender-label">Gender</span>
                    <asp:RadioButtonList ID="rblRiderGender" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow" CssClass="gender-category-list">
                        <asp:ListItem Text="Male" Value="Male"></asp:ListItem>
                        <asp:ListItem Text="Female" Value="Female"></asp:ListItem>
                        <asp:ListItem Text="Rather not say" Value="Rather not say" Selected="True"></asp:ListItem>
                    </asp:RadioButtonList>
                    <asp:Label ID="lblRiderGenderError" runat="server" CssClass="field-error" Text="" Visible="false"></asp:Label>
                </div>

                <div class="section-title">
                    <i class="fas fa-motorcycle"></i>
                    Vehicle Information
                </div>

                <div class="input-row">
                    <div class="input-box">
                        <asp:DropDownList ID="ddlVehicleType" runat="server">
                            <asp:ListItem Value="" Text="Vehicle Type" Selected="True"></asp:ListItem>
                            <asp:ListItem Value="Motorcycle" Text="Motorcycle"></asp:ListItem>
                            <asp:ListItem Value="Bicycle" Text="Bicycle"></asp:ListItem>
                            <asp:ListItem Value="Scooter" Text="Scooter"></asp:ListItem>
                            <asp:ListItem Value="Car" Text="Car"></asp:ListItem>
                        </asp:DropDownList>
                        <asp:Label ID="lblVehicleTypeError" runat="server" CssClass="field-error" Text="" Visible="false"></asp:Label>
                    </div>
                    <div class="input-box">
                        <asp:TextBox ID="txtMakeModel" runat="server" placeholder="Make & Model" />
                        <asp:Label ID="lblMakeModelError" runat="server" CssClass="field-error" Text="" Visible="false"></asp:Label>
                    </div>
                </div>

                <div class="input-row">
                    <div class="input-box">
                        <asp:TextBox ID="txtYear" runat="server" placeholder="Year" TextMode="Number" min="2000" max="2024" />
                        <asp:Label ID="lblYearError" runat="server" CssClass="field-error" Text="" Visible="false"></asp:Label>
                    </div>
                    <div class="input-box">
                        <asp:TextBox ID="txtLicensePlate" runat="server" placeholder="License Plate Number" />
                        <asp:Label ID="lblLicensePlateError" runat="server" CssClass="field-error" Text="" Visible="false"></asp:Label>
                    </div>
                </div>

                <div class="input-row">
                    <div class="input-box">
                        <asp:TextBox ID="txtVehicleColor" runat="server" placeholder="Vehicle Color" />
                        <asp:Label ID="lblVehicleColorError" runat="server" CssClass="field-error" Text="" Visible="false"></asp:Label>
                    </div>
                    <div class="input-box">
                        <asp:TextBox ID="txtORCR" runat="server" placeholder="OR/CR Number" />
                        <asp:Label ID="lblORCRError" runat="server" CssClass="field-error" Text="" Visible="false"></asp:Label>
                    </div>
                </div>

                <div class="section-title">
                    <i class="fas fa-shield-alt"></i>
                    Insurance Information
                </div>

                <div class="input-row">
                    <div class="input-box">
                        <asp:TextBox ID="txtInsurancePolicy" runat="server" placeholder="Insurance Policy Number" />
                        <asp:Label ID="lblInsurancePolicyError" runat="server" CssClass="field-error" Text="" Visible="false"></asp:Label>
                    </div>
                    <div class="input-box">
                        <asp:TextBox ID="txtInsuranceExpiry" runat="server" TextMode="Date" placeholder="Insurance Expiry Date" />
                        <asp:Label ID="lblInsuranceExpiryError" runat="server" CssClass="field-error" Text="" Visible="false"></asp:Label>
                    </div>
                </div>

                <div class="section-title">
                    <i class="fas fa-file-upload"></i>
                    Required Documents
                </div>

                <div class="file-upload-box">
                    <span class="file-upload-label">Driver's License</span>
                    <asp:FileUpload ID="fuDriverLicense" runat="server" CssClass="file-upload-input" />
                    <asp:Label ID="lblDriverLicenseFileError" runat="server" CssClass="field-error" Text="" Visible="false"></asp:Label>
                    <div class="info-text">Upload clear photo or scanned copy</div>
                </div>

                <div class="file-upload-box">
                    <span class="file-upload-label">Vehicle Registration (OR/CR)</span>
                    <asp:FileUpload ID="fuVehicleRegistration" runat="server" CssClass="file-upload-input" />
                    <asp:Label ID="lblVehicleRegistrationError" runat="server" CssClass="field-error" Text="" Visible="false"></asp:Label>
                    <div class="info-text">Upload clear photo or scanned copy</div>
                </div>

                <div class="file-upload-box">
                    <span class="file-upload-label">Insurance Certificate</span>
                    <asp:FileUpload ID="fuInsurance" runat="server" CssClass="file-upload-input" />
                    <asp:Label ID="lblInsuranceFileError" runat="server" CssClass="field-error" Text="" Visible="false"></asp:Label>
                    <div class="info-text">Must be valid and active</div>
                </div>

                <div class="file-upload-box">
                    <span class="file-upload-label">NBI Clearance</span>
                    <asp:FileUpload ID="fuNBIClearance" runat="server" CssClass="file-upload-input" />
                    <asp:Label ID="lblNBIClearanceFileError" runat="server" CssClass="field-error" Text="" Visible="false"></asp:Label>
                    <div class="info-text">Upload clear photo or scanned copy</div>
                </div>
            </div>

            <div class="button-group">
                <button type="button" class="back-btn" onclick="goBackToUserType()">
                    <i class="fas fa-arrow-left"></i> Back
                </button>
                <asp:Button ID="btnRiderRegister" runat="server" Text="Submit Application" CssClass="btn-register" OnClick="btnRiderRegister_Click" />
            </div>

            <div id="riderValidationSummary" class="validation-summary hidden">
                <h4><i class="fas fa-exclamation-triangle"></i> Please fix the following errors:</h4>
                <ul id="riderErrorList"></ul>
            </div>

            <div id="riderSuccessBox" class="success-box hidden">
                <i class="fas fa-check-circle"></i>
                <h4>Application Submitted!</h4>
                <p>We will review your documents and contact you soon.</p>
            </div>

            <div class="extra-text">
                Already have an account?
                <a href="Login.aspx" class="sign-in-link">Sign In</a>
            </div>
        </div>
    </form>

    <script>
        let selectedUserType = '';

        function selectUserType(type) {
            selectedUserType = type;

            document.querySelectorAll('.user-type-btn').forEach(btn => {
                btn.classList.remove('selected');
            });

            document.querySelector(`.user-type-btn[onclick="selectUserType('${type}')"]`).classList.add('selected');

            document.getElementById('<%= hdnUserType.ClientID %>').value = type;

            document.getElementById('<%= lblUserTypeError.ClientID %>').style.display = 'none';
        }

        function continueToRegister() {
            if (!selectedUserType) {
                const errorLabel = document.getElementById('<%= lblUserTypeError.ClientID %>');
                errorLabel.textContent = 'Please select your role (Customer or Rider)';
                errorLabel.style.display = 'block';
                errorLabel.style.visibility = 'visible';

                document.querySelectorAll('.user-type-btn').forEach(btn => {
                    btn.classList.add('input-error');
                });

                return;
            }

            document.getElementById('userTypeCard').classList.add('hidden');

            if (selectedUserType === 'customer') {
                document.getElementById('customerRegisterCard').classList.remove('hidden');
                document.getElementById('customerValidationSummary').classList.add('hidden');
                document.getElementById('customerSuccessBox').classList.add('hidden');
            } else if (selectedUserType === 'rider') {
                document.getElementById('riderRegisterCard').classList.remove('hidden');
                document.getElementById('riderValidationSummary').classList.add('hidden');
                document.getElementById('riderSuccessBox').classList.add('hidden');
            }
        }

        function goBackToUserType() {
            document.getElementById('customerRegisterCard').classList.add('hidden');
            document.getElementById('riderRegisterCard').classList.add('hidden');

            document.getElementById('userTypeCard').classList.remove('hidden');
        }

        // Password toggle functionality
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
        
        const toggleRiderPwd = document.getElementById("toggleRiderPwd");
        const riderPwd = document.getElementById('<%= txtRiderPassword.ClientID %>');
        const toggleRiderConfirmPwd = document.getElementById("toggleRiderConfirmPwd");
        const riderConfirmPwd = document.getElementById('<%= txtRiderConfirmPassword.ClientID %>');

        if (toggleRiderPwd && riderPwd) {
            toggleRiderPwd.addEventListener("click", () => {
                toggleRiderPwd.classList.add("active");
                if (riderPwd.type === "password") {
                    riderPwd.type = "text";
                    toggleRiderPwd.classList.replace("fa-eye-slash", "fa-eye");
                } else {
                    riderPwd.type = "password";
                    toggleRiderPwd.classList.replace("fa-eye", "fa-eye-slash");
                }
                setTimeout(() => toggleRiderPwd.classList.remove("active"), 200);
            });
        }

        if (toggleRiderConfirmPwd && riderConfirmPwd) {
            toggleRiderConfirmPwd.addEventListener("click", () => {
                toggleRiderConfirmPwd.classList.add("active");
                if (riderConfirmPwd.type === "password") {
                    riderConfirmPwd.type = "text";
                    toggleRiderConfirmPwd.classList.replace("fa-eye-slash", "fa-eye");
                } else {
                    riderConfirmPwd.type = "password";
                    toggleRiderConfirmPwd.classList.replace("fa-eye", "fa-eye-slash");
                }
                setTimeout(() => toggleRiderConfirmPwd.classList.remove("active"), 200);
            });
        }

        function showValidationSummary(formType, errors) {
            const validationDiv = document.getElementById(formType + 'ValidationSummary');
            const errorList = document.getElementById(formType + 'ErrorList');
            const successBox = document.getElementById(formType + 'SuccessBox');

            errorList.innerHTML = '';

            if (errors.length > 0) {
                errors.forEach(error => {
                    const li = document.createElement('li');
                    li.textContent = error;
                    errorList.appendChild(li);
                });

                validationDiv.classList.remove('hidden');
                if (successBox) successBox.classList.add('hidden');

                highlightErrorFields(formType);

                document.getElementById(formType + 'RegisterCard').scrollTop = 0;
            } else {
                validationDiv.classList.add('hidden');
            }
        }

        function showSuccessMessage(formType) {
            const validationDiv = document.getElementById(formType + 'ValidationSummary');
            const successBox = document.getElementById(formType + 'SuccessBox');

            validationDiv.classList.add('hidden');
            if (successBox) {
                successBox.classList.remove('hidden');
                successBox.scrollIntoView({ behavior: 'smooth', block: 'start' });
            }
        }

        function highlightErrorFields(formType) {
            document.querySelectorAll('.input-error').forEach(el => {
                el.classList.remove('input-error');
            });

            document.querySelectorAll('.field-error').forEach(errorLabel => {
                if (errorLabel.textContent.trim() !== '' && errorLabel.style.display !== 'none') {
                    const inputId = errorLabel.id.replace('Error', '');
                    const input = document.getElementById(inputId);
                    if (input) {
                        input.classList.add('input-error');
                    }
                }
            });
        }

        function setupRealTimeValidation() {
            const customerInputs = document.querySelectorAll('#customerRegisterCard input, #customerRegisterCard select');
            customerInputs.forEach(input => {
                input.addEventListener('blur', function () {
                    validateField(this);
                });
            });

            const riderInputs = document.querySelectorAll('#riderRegisterCard input, #riderRegisterCard select, #riderRegisterCard .file-upload-input');
            riderInputs.forEach(input => {
                input.addEventListener('blur', function () {
                    validateField(this);
                });
            });
        }

        function validateField(field) {
            const value = field.value.trim();
            const fieldName = field.placeholder || field.name || field.id;

            if (field.hasAttribute('required') && !value) {
                field.classList.add('input-error');
                return false;
            }

            if (field.type === 'email' && value) {
                const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (!emailRegex.test(value)) {
                    field.classList.add('input-error');
                    return false;
                }
            }

            if (field.type === 'password' && value && value.length < 6) {
                field.classList.add('input-error');
                return false;
            }

            field.classList.remove('input-error');
            return true;
        }

        document.addEventListener('DOMContentLoaded', function () {
            setupRealTimeValidation();
        });
    </script>
</body>
</html>