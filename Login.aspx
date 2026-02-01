<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="TasteNet.Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login | TasteNet</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', sans-serif;
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
            font-size: 1.4em;
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
            margin: 0 auto 10px auto;
            position: relative;
        }

        .input-box input {
            width: 100%;
            height: 38px;
            padding: 0 35px 0 12px;
            border-radius: 20px;
            border: none;
            outline: none;
            font-size: 11.5px;
            box-sizing: border-box;
            line-height: 38px;
        }

        .password-box {
            position: relative;
        }

        .password-box i {
            position: absolute;
            right: 12px;
            top: 50%;
            transform: translateY(-50%) scale(1);
            color: #777;
            cursor: pointer;
            transition: transform 0.25s ease, opacity 0.25s ease;
            font-size: 0.85em;
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
            margin: 6px auto 12px auto;
            font-size: 12.5px;
        }

        .remember-me {
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .remember-me input[type="checkbox"] {
            width: 14px;
            height: 14px;
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
        }

        .remember-me:hover label {
            color: #ffd6d6;
        }

        .forgot-password,
        .create-account {
            color: #ffc107;
            text-decoration: none;
            font-weight: 600;
            padding: 3px 8px;
            border-radius: 16px;
            background: rgba(255, 193, 7, 0.1);
            transition: all 0.3s ease;
            display: inline-block;
            font-size: 0.85em;
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
            background: linear-gradient(to right, #4b0000, #a10000);
            border: 1.5px solid rgba(255, 255, 255, 0.25);
            padding: 10px;
            width: 45%;
            color: #fff;
            font-size: 13px;
            border-radius: 20px;
            cursor: pointer;
            transition: all 0.3s ease;
            font-weight: 600;
            letter-spacing: 0.5px;
        }

        .btn-login:hover {
            background: linear-gradient(to right, #6a0000, #c20000);
            box-shadow:
                0 0 5px #ffc107,
                0 0 10px #ffc107,
                0 0 20px rgba(255, 193, 7, 0.7);
            border-color: #ffc107;
            transform: translateY(-1px) scale(1.02);
            animation: glowPulse 1.5s infinite alternate;
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
            margin: 4px 0 !important;
            display: block;
            font-weight: 600;
            text-shadow: 0 0 5px rgba(0, 0, 0, 0.5);
            border: none !important;
            font-size: 0.85em;
        }

        .extra-text {
            margin-top: 12px;
            font-size: 11.5px;
            color: #fff;
        }

        .social-login {
            margin-top: 10px;
        }

        .social-login i {
            width: 36px;
            height: 36px;
            line-height: 36px;
            border-radius: 50%;
            background: #fff;
            color: #000;
            font-size: 16px;
            margin: 0 4px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .social-login i:hover {
            transform: scale(1.05) translateY(-1px);
            box-shadow: 0 3px 10px rgba(255, 255, 255, 0.3);
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

            <asp:Button ID="btnLogin" runat="server" Text="Log In" CssClass="btn-login" OnClick="btnLogin_Click" />

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