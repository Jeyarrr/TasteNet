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
            padding: 20px;
        }

        .register-card {
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

        .logo img {
            width: 110px;
            margin-bottom: 5px;
            border-radius: 50%;
            border: solid #FFD41D;
        }

        h2 {
            margin-top: 2px;
            margin-bottom: 25px;
            font-weight: 600;
        }

        .input-row {
            display: flex;
            gap: 15px;
            margin-bottom: 14px;
        }

        .input-box {
            flex: 1;
            position: relative;
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
        }

        .gender-container {
            text-align: left;
            margin: 20px 0;
        }

        .gender-label {
            display: block;
            margin-bottom: 10px;
            font-size: 13px;
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
            transition: all 0.3s ease;
            background: rgba(255, 255, 255, 0.05);
        }

        .gender-category-list label:hover {
            border-color: #FFD41D;
            background: rgba(255, 212, 29, 0.1);
        }

        .gender-category-list input[type="radio"]:checked + label {
            background: #FFD41D;
            color: #4b0000;
            border-color: #FFD41D;
            font-weight: 600;
        }

        .password-box i {
            position: absolute;
            right: 18px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: #777;
            transition: 0.25s;
        }

        .btn-register {
            margin-top: 10px;
            background: linear-gradient(to right, #4b0000, #a10000);
            border: 2px solid rgba(255,255,255,0.25);
            padding: 14px;
            width: 60%;
            color: #fff;
            font-size: 15px;
            border-radius: 30px;
            cursor: pointer;
            transition: 0.3s;
        }

        .btn-register:hover {
            background: linear-gradient(to right, #6a0000, #c20000);
            box-shadow:
                0 0 8px #ffc107,
                0 0 16px #ffc107,
                0 0 32px rgba(255, 193, 7, 0.7);
            border-color: #ffc107;
            transform: translateY(-1px);
            animation: glowPulse 1.5s infinite alternate;
        }

        @keyframes glowPulse {
            from {
                box-shadow: 0 0 8px #ffc107;
            }
            to {
                box-shadow: 0 0 20px #ffc107, 0 0 40px rgba(255, 193, 7, 0.8);
            }
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
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">

        <div class="register-card">

            <div class="logo">
                <img src="Images/logo.png" alt="Logo" />
            </div>

            <h2>Create Account</h2>

            <div class="input-row">
                <div class="input-box">
                    <asp:TextBox ID="txtFullName" runat="server" placeholder="Full Name" />
                </div>
                <div class="input-box">
                    <asp:TextBox ID="txtUsername" runat="server" placeholder="Username" />
                </div>
            </div>

            <div class="input-row">
                <div class="input-box">
                    <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" placeholder="Email" />
                </div>
                <div class="input-box">
                    <asp:TextBox ID="txtMobile" runat="server" placeholder="Mobile Number (+63)" />
                </div>
            </div>

            <div class="input-row">
                <div class="input-box password-box">
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Password" />
                    <i id="togglePwd" class="fa fa-eye-slash"></i>
                </div>
                <div class="input-box">
                    <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" placeholder="Confirm Password" />
                </div>
            </div>

            <div class="gender-container">
                <span class="gender-label">Gender</span>
                <asp:RadioButtonList ID="rblGender" runat="server" 
                    RepeatDirection="Horizontal" 
                    RepeatLayout="Flow" 
                    CssClass="gender-category-list">
                    <asp:ListItem Text="Male" Value="Male"></asp:ListItem>
                    <asp:ListItem Text="Female" Value="Female"></asp:ListItem>
                    <asp:ListItem Text="Rather not say" Value="Rather not say" Selected="True"></asp:ListItem>
                </asp:RadioButtonList>
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
            if (pwd.type === "password") {
                pwd.type = "text";
                toggle.classList.replace("fa-eye-slash", "fa-eye");
            } else {
                pwd.type = "password";
                toggle.classList.replace("fa-eye", "fa-eye-slash");
            }
        });
    </script>

</body>
</html>