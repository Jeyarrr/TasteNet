<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="TasteNet.Register" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Register | TasteNet</title>

    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />

    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background: radial-gradient(circle at top, #a00000, #000000);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .register-card {
            width: 450px;
            background: #4b0000;
            border-radius: 25px;
            padding: 40px 30px;
            text-align: center;
            box-shadow: 0 15px 30px rgba(0,0,0,.4);
            color: #fff;
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

        .input-box {
            margin-bottom: 14px;
        }

        .input-box input {
            width: 100%;
            height: 48px;
            padding: 0 20px;
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
            transform: translateY(-50%);
            cursor: pointer;
            color: #777;
            transition: transform 0.25s ease;
        }

        .password-box i.active {
            transform: translateY(-50%) scale(1.2);
            color: #a10000;
        }

        .btn-register {
            margin-top: 15px;
            background: linear-gradient(to right, #4b0000, #a10000);
            border: 2px solid rgba(255,255,255,0.25);
            padding: 14px;
            width: 65%;
            color: #fff;
            font-size: 15px;
            border-radius: 30px;
            cursor: pointer;
            transition: 0.3s;
        }

        .btn-register:hover {
            box-shadow: 0 0 12px rgba(255, 0, 0, 0.6);
        }

        .extra-text {
            margin-top: 18px;
            font-size: 13px;
        }

        .extra-text a {
            color: #fff;
            font-weight: 600;
            text-decoration: none;
        }

        .extra-text a:hover {
            text-decoration: underline;
            color: #ffd6d6;
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">

        <div class="register-card">

            <div class="logo">
                <!-- Replace with your logo -->
                <img src="Images/logo.png" alt="Logo" />
            </div>

            <h2>Create Account</h2>

            <div class="input-box">
                <asp:TextBox ID="txtFullName" runat="server" placeholder="Full Name" />
            </div>

            <div class="input-box">
                <asp:TextBox ID="txtUsername" runat="server" placeholder="Username" />
            </div>

            <div class="input-box">
                <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" placeholder="Email" />
            </div>

            <div class="input-box password-box">
                <asp:TextBox ID="txtPassword" runat="server"
                    TextMode="Password" placeholder="Password" />
                <i id="togglePwd" class="fa fa-eye-slash"></i>
            </div>

            <div class="input-box">
                <asp:TextBox ID="txtConfirmPassword" runat="server"
                    TextMode="Password" placeholder="Confirm Password" />
            </div>

            <asp:Button ID="btnRegister" runat="server"
                Text="Register"
                CssClass="btn-register"
                OnClick="btnRegister_Click" />

            <div class="extra-text">
                Already have an account?
                <a href="Login.aspx">Sign In</a>
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
