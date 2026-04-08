<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="TasteNet.Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login | TasteNet</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet" />
    <style>
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

        .login-card {
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

        .card-content {
            display: flex;
            flex-direction: column;
            align-items: center;
            width: 100%;
        }

        .logo img {
            width: 80px;
            margin-bottom: 8px;
            border-radius: 50%;
            border: solid #FFD41D;
        }

        h2 {
            margin-top: 0;
            margin-bottom: 18px;
            font-weight: 600;
            font-size: 1.6em;
            font-family: 'Poppins', sans-serif;
            letter-spacing: 0.5px;
        }

        .input-group {
            width: 100%;
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 10px;
        }

        .input-box-wrapper {
            position: relative;
            width: 85%;
        }

        .input-box {
            width: 85%;
            margin: 0 auto 15px auto;
            position: relative;
        }

        .input-box input {
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
            background: #fff;
            transition: all 0.3s ease;
        }

        .input-box input:focus {
            box-shadow: 0 0 0 2px #ffc107, 0 0 10px rgba(255, 193, 7, 0.5);
        }

        .input-box input::placeholder {
            font-family: 'Poppins', sans-serif;
            font-size: 14px;
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
            font-size: 1.1em;
        }

        .password-box i.active {
            transform: translateY(-50%) scale(1.05);
            opacity: 0.85;
        }

        .remember-forgot {
            width: 85%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin: 8px auto 15px auto;
            font-size: 13.5px;
            font-family: 'Poppins', sans-serif;
        }

        .remember-me {
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .remember-me input[type="checkbox"] {
            width: 16px;
            height: 16px;
            cursor: pointer;
            accent-color: #ffc107;
            transform: scale(1);
            transition: all 0.2s ease;
        }

        .remember-me input[type="checkbox"]:hover {
            transform: scale(1.05);
            filter: brightness(1.2);
        }

        .remember-me label {
            cursor: pointer;
            color: #fff;
            font-weight: 500;
            transition: color 0.3s ease;
            font-size: 13.5px;
            font-family: 'Poppins', sans-serif;
        }

        .remember-me:hover label {
            color: #ffd6d6;
        }

        .forgot-password,
        .create-account {
            color: #ffc107;
            text-decoration: none;
            font-weight: 500;
            padding: 4px 10px;
            border-radius: 18px;
            background: rgba(255, 193, 7, 0.1);
            transition: all 0.3s ease;
            display: inline-block;
            font-size: 13px;
            font-family: 'Poppins', sans-serif;
        }

        .forgot-password:hover,
        .create-account:hover {
            background: rgba(255, 193, 7, 0.2);
            text-decoration: none;
            color: #fff;
            transform: translateY(-1px);
            box-shadow: 0 2px 5px rgba(255, 193, 7, 0.3);
        }

        .btn-login {
            margin-top: 10px;
            background: transparent;
            border: 2px solid #ffc107;
            padding: 8px 10px;
            width: 45%;
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

        .btn-login:hover {
            background: #ffc107;
            color: #4b0000;
            border-color: #ffc107;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 193, 7, 0.4);
        }

        .btn-login:active {
            transform: translateY(0);
            box-shadow: 0 2px 5px rgba(255, 193, 7, 0.4);
        }

        @keyframes glowPulse{
            from{
                box-shadow: 0 0 5px #ffc107;
            }
            to{
                box-shadow: 0 0 12px #ffc107, 0 0 24px rgba(255, 193, 7, 0.8);
            }
        }
        
        .error-message {
            color: #ffc107 !important; 
            background-color: transparent !important; 
            padding: 0px 0 !important;
            border-radius: 0 !important;
            margin: 6px 0 !important;
            display: block;
            font-weight: 500;
            text-shadow: 0 0 5px rgba(0, 0, 0, 0.5);
            border: none !important;
            font-size: 14px;
            font-family: 'Poppins', sans-serif;
        }

        .extra-text {
            margin-top: 15px;
            font-size: 13px;
            color: #fff;
            font-family: 'Poppins', sans-serif;
            line-height: 1.8;
        }

        .extra-text br {
            display: block;
        }

        .social-login {
            margin-top: 12px;
            display: flex;
            justify-content: center;
            gap: 12px;
        }

        .social-login i {
            width: 38px;
            height: 38px;
            line-height: 38px;
            border-radius: 50%;
            background: #fff;
            color: #000;
            font-size: 18px;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .social-login i:hover {
            transform: scale(1.1) translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 193, 7, 0.3);
        }

        .social-login .fa-facebook-f {
            color: #1877F2;
        }

        .social-login .fa-google {
            color: #DB4437;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="login-card">

            <div class="logo">
                <img src="Images/LOGO.png" alt="Logo" />
            </div>

            <h2>Sign In</h2>

            <div class="input-box">
                <asp:TextBox ID="txtUsername" runat="server" placeholder="Username"></asp:TextBox>
            </div>

            <div class="input-box password-box">
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Password"></asp:TextBox>
                <i id="togglePwd" class="fa fa-eye-slash"></i>
            </div>

            <asp:Label ID="lblError" runat="server" CssClass="error-message" 
               Visible="false"></asp:Label>

            <div class="remember-forgot">
                <div class="remember-me">
                    <asp:CheckBox ID="chkRemember" runat="server" />
                    <asp:Label ID="lblRemember" runat="server" Text="Remember me" AssociatedControlID="chkRemember"></asp:Label>
                </div>
                <asp:HyperLink 
                    ID="lnkForgot" 
                    runat="server" 
                    NavigateUrl="~/ForgotPassword.aspx"
                    CssClass="forgot-password">
                    Forgot Password?
                </asp:HyperLink>
            </div>

            <asp:Button ID="btnLogin" runat="server" Text="LOGIN" CssClass="btn-login" OnClick="btnLogin_Click" />

            <div class="extra-text">
                <asp:HyperLink 
                    ID="lnkRegister" 
                    runat="server" 
                    NavigateUrl="~/Register.aspx"
                    CssClass="create-account">
                    Create your account
                </asp:HyperLink>
                <br />
                Or Sign In with
            </div>

            <div class="social-login">
                <i class="fab fa-facebook-f"></i>
                <i class="fab fa-google"></i>
            </div>

        </div>
    </form>

    <script>
        const toggle = document.getElementById("togglePwd");
        const pwd = document.getElementById('<%= txtPassword.ClientID %>');

        toggle.addEventListener("click", () => {
            toggle.classList.add("active");

            if (pwd.type === "password") {
                pwd.type = "text";
                toggle.classList.replace("fa-eye-slash", "fa-eye");
            } else {
                pwd.type = "password";
                toggle.classList.replace("fa-eye", "fa-eye-slash");
            }

            setTimeout(() => toggle.classList.remove("active"), 200);
        });
    </script>
</body>
</html>