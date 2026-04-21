<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="TasteNet.Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login | TasteNet</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet" />
    <script src="https://accounts.google.com/gsi/client" async defer></script>
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
            padding: 10px 10px;
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

        .google-btn {
            margin-top: 5px;
            background: #fff;
            border: 2px solid #ffc107;
            padding: 10px 16px;
            width: auto;
            min-width: 220px;
            font-size: 14px;
            font-family: 'Poppins', sans-serif;
            font-weight: 500;
            letter-spacing: 0.3px;
            border-radius: 30px;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
            color: #333;
            white-space: nowrap;
        }

        .google-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 193, 7, 0.4);
            background: #fff;
        }

        .google-btn:active {
            transform: translateY(0);
            box-shadow: 0 2px 5px rgba(255, 193, 7, 0.4);
        }

        .google-btn:disabled {
            opacity: 0.6;
            cursor: not-allowed;
            transform: none;
        }

        .google-icon-svg {
            width: 20px;
            height: 20px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        @keyframes glowPulse{
            from{ box-shadow: 0 0 5px #ffc107; }
            to{ box-shadow: 0 0 12px #ffc107, 0 0 24px rgba(255, 193, 7, 0.8); }
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
            margin-top: 8px;
            font-size: 13px;
            color: #fff;
            font-family: 'Poppins', sans-serif;
            line-height: 1.4;
        }

        .extra-text br { display: block; }

        .or-text {
            margin: 4px 0;
            font-size: 12px;
            color: #ffc107;
            font-weight: 500;
        }

        .social-login {
            margin-top: 0px;
            display: flex;
            justify-content: center;
        }

        @media (max-width: 400px) {
            .btn-login, .google-btn { width: 70%; }
            .google-btn { font-size: 12px; gap: 8px; }
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

            <asp:Label ID="lblError" runat="server" CssClass="error-message" Visible="false"></asp:Label>

            <div class="remember-forgot">
                <div class="remember-me">
                    <asp:CheckBox ID="chkRemember" runat="server" />
                    <asp:Label ID="lblRemember" runat="server" Text="Remember me" AssociatedControlID="chkRemember"></asp:Label>
                </div>
                <asp:HyperLink ID="lnkForgot" runat="server" NavigateUrl="~/ForgotPassword.aspx" CssClass="forgot-password">Forgot Password?</asp:HyperLink>
            </div>

            <asp:Button ID="btnLogin" runat="server" Text="LOGIN" CssClass="btn-login" OnClick="btnLogin_Click" />

            <div class="extra-text">
                <asp:HyperLink ID="lnkRegister" runat="server" NavigateUrl="~/Register.aspx" CssClass="create-account">Create your account</asp:HyperLink>
            </div>

            <div class="or-text">or</div>

            <div class="social-login">
                <button type="button" class="google-btn" id="googleSignInBtn">
                    <span class="google-icon-svg">
                        <svg width="20" height="20" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                            <path d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z" fill="#4285F4"/>
                            <path d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z" fill="#34A853"/>
                            <path d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z" fill="#FBBC05"/>
                            <path d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z" fill="#EA4335"/>
                        </svg>
                    </span>
                    <span>Sign in with Google</span>
                </button>
            </div>
        </div>
    </form>

    <script>
        window.googleClientId = '212574206218-1q5521s82manegu756dr108a7n6eck0s.apps.googleusercontent.com';

        const toggle = document.getElementById("togglePwd");
        const pwd = document.getElementById('<%= txtPassword.ClientID %>');
        if (toggle && pwd) {
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
        }

        const googleBtn = document.getElementById("googleSignInBtn");
        if (googleBtn) {
            googleBtn.addEventListener("click", function (e) {
                e.preventDefault();
                googleBtn.disabled = true;
                googleBtn.innerHTML = '<i class="fa fa-spinner fa-spin"></i> Redirecting...';

                const redirectUri = encodeURIComponent(window.location.href);
                const authUrl = `https://accounts.google.com/o/oauth2/v2/auth?` +
                    `client_id=${window.googleClientId}&` +
                    `redirect_uri=${redirectUri}&` +
                    `response_type=code&` +
                    `scope=openid%20email%20profile&` +
                    `state=google-login&access_type=offline&prompt=consent`;

                window.location.href = authUrl;
            });
        }

        window.onload = function () {
            const urlParams = new URLSearchParams(window.location.search);
            const code = urlParams.get('code');
            if (code && urlParams.get('state') === 'google-login') {
                handleGoogleCallback(code);
            }
        };

        function handleGoogleCallback(code) {
            fetch('GoogleAuth.ashx', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ code: code })
            })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        window.location.href = data.redirectUrl;
                    } else {
                        alert('Google login failed: ' + data.error);
                        googleBtn.disabled = false;
                        googleBtn.innerHTML = '<span class="google-icon-svg">...</span><span>Sign in with Google</span>';
                    }
                })
                .catch(error => {
                    alert('Error: ' + error);
                    googleBtn.disabled = false;
                    googleBtn.innerHTML = '<span class="google-icon-svg">...</span><span>Sign in with Google</span>';
                });
        }
    </script>
</body>
</html>