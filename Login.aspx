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
            background: #d9d9d9;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .login-card {
            width: 420px;
            background: #7b0000;
            border-radius: 25px;
            padding: 40px 30px;
            text-align: center;
            box-shadow: 0 10px 25px rgba(0,0,0,.3);
            color: #fff;
        }

        .logo img {
            width: 110px;
            margin-bottom: 15px;
            border-radius: 50%;
        }

        h2 {
            margin-bottom: 25px;
            font-weight: 600;
        }

        .input-box {
            width: 100%;
            margin-bottom: 15px;
        }

        .input-box input {
            width: 100%;
            padding: 14px 20px;
            border-radius: 30px;
            border: none;
            outline: none;
            font-size: 14px;
        }

        .password-box {
            position: relative;
        }

        .password-box i {
            position: absolute;
            right: 18px;
            top: 50%;
            transform: translateY(-50%);
            color: #777;
            cursor: pointer;
        }

        .btn-login {
            margin-top: 15px;
            background: linear-gradient(to right, #4b0000, #a10000);
            border: none;
            padding: 14px;
            width: 60%;
            color: #fff;
            font-size: 15px;
            border-radius: 30px;
            cursor: pointer;
        }

        .btn-login:hover {
            opacity: 0.9;
        }

        .extra-text {
            margin-top: 18px;
            font-size: 13px;
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
                <i class="fa fa-eye-slash" onclick="togglePassword()"></i>
            </div>

            <asp:Button ID="btnLogin" runat="server" Text="Log In" CssClass="btn-login" OnClick="btnLogin_Click" />

            <div class="extra-text">
                Create your account <br />
                Or Sign In with
            </div>

            <div class="social-login">
                <i class="fab fa-facebook-f"></i>
                <i class="fab fa-google"></i>
            </div>

        </div>
    </form>

    <script>
        function togglePassword() {
            var pwd = document.getElementById('<%= txtPassword.ClientID %>');
            pwd.type = pwd.type === "password" ? "text" : "password";
        }
    </script>
</body>
</html>
