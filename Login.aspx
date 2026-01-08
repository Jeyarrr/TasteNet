<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="TasteNet.Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Caballeros - Sign In</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Fredoka', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #6B1515 0%, #A0826D 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .login-container {
            background: #6B1515;
            border-radius: 20px;
            padding: 40px;
            width: 100%;
            max-width: 400px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.4);
        }

        .logo-container {
            text-align: center;
            margin-bottom: 30px;
        }

        .logo {
            width: 120px;
            height: 120px;
            margin: 0 auto;
            background: #8B1E1E;
            border-radius: 50%;
            border: 4px solid #D4AF37;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.3);
        }

        .logo-text {
            color: #D4AF37;
            font-size: 14px;
            font-weight: bold;
            text-transform: uppercase;
            letter-spacing: 2px;
        }

        h2 {
            color: white;
            text-align: center;
            margin: 20px 0 30px;
            font-size: 28px;
            font-weight: 600;
        }

        .input-group {
            margin-bottom: 20px;
        }

        .form-control {
            width: 100%;
            padding: 15px 20px;
            border: none;
            border-radius: 25px;
            font-size: 15px;
            background: white;
            color: #333;
            outline: none;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            box-shadow: 0 0 0 3px rgba(212, 175, 55, 0.3);
        }

        .form-control::placeholder {
            color: #999;
        }

        .password-wrapper {
            position: relative;
        }

        .toggle-password {
            position: absolute;
            right: 20px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: #999;
            font-size: 12px;
            user-select: none;
        }

        .btn-login {
            width: 100%;
            padding: 15px;
            background: #2C0A0A;
            color: white;
            border: none;
            border-radius: 25px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 10px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .btn-login:hover {
            background: #1A0505;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
        }

        .btn-login:active {
            transform: translateY(0);
        }

        .divider {
            text-align: center;
            margin: 25px 0;
            color: rgba(255, 255, 255, 0.7);
            font-size: 14px;
        }

        .create-account {
            text-align: center;
            color: white;
            font-size: 14px;
            margin-bottom: 10px;
        }

        .social-signin {
            text-align: center;
            color: rgba(255, 255, 255, 0.8);
            font-size: 13px;
            margin-bottom: 15px;
        }

        .social-buttons {
            display: flex;
            gap: 15px;
            justify-content: center;
        }

        .social-btn {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            border: none;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
        }

        .social-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
        }

        .btn-facebook {
            background: #1877F2;
        }

        .btn-google {
            background: white;
        }

        .social-icon {
            width: 24px;
            height: 24px;
        }

        .error-message {
            color: #FFD700;
            background: rgba(255, 215, 0, 0.1);
            padding: 10px;
            border-radius: 10px;
            margin-bottom: 15px;
            font-size: 14px;
            text-align: center;
            display: none;
        }

        .error-message.show {
            display: block;
        }

        @media (max-width: 480px) {
            .login-container {
                padding: 30px 20px;
            }

            .logo {
                width: 100px;
                height: 100px;
            }

            h2 {
                font-size: 24px;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="login-container">
            <div class="logo-container">
                <div class="logo">
                    <div class="logo-text">CABALLEROS<br/>EST. 2021</div>
                </div>
            </div>

            <h2>Sign In</h2>

            <asp:Panel ID="pnlError" runat="server" CssClass="error-message">
                <asp:Label ID="lblError" runat="server" Text=""></asp:Label>
            </asp:Panel>

            <div class="input-group">
                <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" 
                    placeholder="Username" MaxLength="50"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvUsername" runat="server" 
                    ControlToValidate="txtUsername" 
                    ErrorMessage="Username is required" 
                    ForeColor="#FFD700" 
                    Display="Dynamic">
                </asp:RequiredFieldValidator>
            </div>

            <div class="input-group">
                <div class="password-wrapper">
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" 
                        TextMode="Password" placeholder="Password" MaxLength="100"></asp:TextBox>
                    <span class="toggle-password" onclick="togglePassword()">👁️</span>
                </div>
                <asp:RequiredFieldValidator ID="rfvPassword" runat="server" 
                    ControlToValidate="txtPassword" 
                    ErrorMessage="Password is required" 
                    ForeColor="#FFD700" 
                    Display="Dynamic">
                </asp:RequiredFieldValidator>
            </div>

            <asp:Button ID="btnLogin" runat="server" CssClass="btn-login" 
                Text="Log In" OnClick="btnLogin_Click" />

            <div class="divider">
                <div class="create-account">Create your account</div>
                <div class="social-signin">Or Sign In with</div>
            </div>

            <div class="social-buttons">
                <asp:Button ID="btnFacebook" runat="server" CssClass="social-btn btn-facebook" 
                    Text="f" OnClick="btnFacebook_Click" CausesValidation="false" />
                <asp:Button ID="btnGoogle" runat="server" CssClass="social-btn btn-google" 
                    Text="G" OnClick="btnGoogle_Click" CausesValidation="false" />
            </div>
        </div>
    </form>

    <script type="text/javascript">
        function togglePassword() {
            var passwordField = document.getElementById('<%= txtPassword.ClientID %>');
            var toggleIcon = document.querySelector('.toggle-password');
            
            if (passwordField.type === 'password') {
                passwordField.type = 'text';
                toggleIcon.textContent = '🙈';
            } else {
                passwordField.type = 'password';
                toggleIcon.textContent = '👁️';
            }
        }
    </script>
</body>
</html>
