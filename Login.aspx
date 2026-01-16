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
            background: radial-gradient(circle at top, #a00000, #000000);
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .login-card {
            width: 420px;
            background: #4b0000;
            padding: 40px 30px;
            border-radius: 25px;
            text-align: center;
            color: #fff;
            border: 2px solid #ffc107;
            box-shadow: 0 0 10px #ffc107, 
                        0 0 20px #ffc107, 
                        0 0 40px rgba(255, 193, 7, 0.3),
                        inset 0 0 10px rgba(255, 193, 7, 0.2);
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
            width: 110px;
            margin-bottom: 15px;
            border-radius: 50%;
            border: solid #FFD41D;
        }

        h2 {
            margin-top: 2px;
            margin-bottom: 25px;
            font-weight: 600;
        }

        .input-group {
            width: 100%;
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 15px;
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
            height: 48px;
            padding: 0 45px 0 20px;
            border-radius: 30px;
            border: none;
            outline: none;
            font-size: 14px;
            box-sizing: border-box;
            line-height: 48px;
        }

        .password-box {
            position: relative;
        }

        .password-box i {
            position: absolute;
            right: 18px;
            top: 50%;
            transform: translateY(-50%) scale(1);
            color: #777;
            cursor: pointer;
            transition: transform 0.25s ease, opacity 0.25s ease;
        }

        .password-box i.active {
            transform: translateY(-50%) scale(1.2);
            opacity: 0.85;
        }


        .btn-login {
            margin-top: 15px;
            background: linear-gradient(to right, #4b0000, #a10000);
            border: 2px solid rgba(255, 255, 255, 0.25);
            padding: 14px;
            width: 60%;
            color: #fff;
            font-size: 15px;
            border-radius: 30px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-login:hover {
            background: linear-gradient(to right, #6a0000, #c20000);
            box-shadow:
                0 0 8px #ffc107,
                0 0 16px #ffc107,
                0 0 32px rgba(255, 193, 7, 0.7);
            border-color: #ffc107;
            transform: translateY(-1px);
            animation: glowPulse 1.5s infinite alternate;
        }

        @keyframes glowPulse{
            from{
                box-shadow: 0 0 8px #ffc107;
            }
            to{
                box-shadow: 0 0 20px #ffc107, 0 0 40px rgba(255, 193, 7, 0.8);
            }
        }

        .extra-text {
            margin-top: 18px;
            font-size: 13px;
        }

        .create-account {
            color: #ffffff;
            text-decoration: none;
            font-weight: 600;
        }

        .create-account:hover {
            text-decoration: underline;
            color: #ffd6d6;
        }

        .social-login {
            margin-top: 15px;
        }

        .social-login i {
            width: 45px;
            height: 45px;
            line-height: 45px;
            border-radius: 50%;
            background: #fff;
            color: #000;
            font-size: 20px;
            margin: 0 6px;
            cursor: pointer;
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
