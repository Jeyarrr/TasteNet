<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Rider.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="TasteNet.Users.Rider.Profile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        :root {
            --primary-maroon: #6b0d1e;
            --primary-maroon-dark: #5a0b19;
            --soft-cream: #fffaf3;
            --text-dark: #4a0e0e;
            --muted-text: #8a6d6d;
            --success-green: #2d9d78;
            --success-green-light: #e6f4f1;
            --warning-orange: #d97706;
            --warning-orange-light: #fff3e6;
            --danger-red: #b91c1c;
            --danger-red-light: #fee2e2;
            --accent-pink: #f9ecee;
            --accent-blue: #eff6ff;
            --accent-blue-dark: #3b82f6;
            --accent-purple: #7c3aed;
            --accent-purple-light: #f3e8ff;
            --border-light: #e2d1d1;
            --border-hover: #d4b8b8;
            --bg-hover: #fefaf5;
            --bg-lighter: #f9f4ee;
            --card-shadow: 0 10px 30px rgba(107, 13, 30, 0.05);
            --card-shadow-hover: 0 15px 40px rgba(107, 13, 30, 0.12);
            --button-shadow: 0 4px 12px rgba(107, 13, 30, 0.2);
            --radius-sm: 8px;
            --radius-md: 10px;
            --radius-lg: 12px;
            --radius-xl: 16px;
            --transition-base: 0.3s ease;
        }

        /* Match dashboard cream background exactly */
        html, body, form {
            margin: 0 !important;
            padding: 0 !important;
            background-color: var(--soft-cream) !important;
            width: 100%;
            font-family: 'Poppins', sans-serif;
            color: var(--text-dark);
            min-height: 100vh;
        }

        * {
            box-sizing: border-box;
        }

        .profile-wrapper {
            padding: 20px 30px;
            max-width: 1400px;
            margin: 0 auto;
            min-height: 100vh;
        }

        /* Header - matching dashboard exactly */
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            flex-wrap: wrap;
            gap: 15px;
            padding-bottom: 15px;
            border-bottom: 1px solid var(--border-light);
        }

        .header-title h1 {
            color: var(--text-dark);
            font-weight: 700;
            margin: 0;
            font-size: 28px;
            letter-spacing: -0.5px;
        }

        .header-title p {
            color: var(--muted-text);
            margin: 5px 0 0 0;
            font-size: 14px;
            line-height: 1.5;
        }

        /* Profile Header Card - matching dashboard card style */
        .profile-header-card {
            background: white;
            padding: 25px;
            border-radius: var(--radius-xl);
            margin-bottom: 25px;
            box-shadow: var(--card-shadow);
            border: 1px solid var(--border-light);
            transition: all var(--transition-base);
        }

        .profile-header-card:hover {
            transform: translateY(-3px);
            box-shadow: var(--card-shadow-hover);
            border-color: var(--border-hover);
        }

        .profile-header-content {
            display: flex;
            align-items: center;
            gap: 25px;
        }

        .profile-avatar {
            width: 90px;
            height: 90px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--primary-maroon), var(--primary-maroon-dark));
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            font-size: 28px;
            box-shadow: 0 4px 12px rgba(107, 13, 30, 0.2);
            border: 3px solid white;
            position: relative;
            overflow: hidden;
        }
        
        .profile-avatar img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .profile-info {
            flex: 1;
        }

        .profile-name {
            font-size: 22px;
            font-weight: 700;
            color: var(--text-dark);
            margin-bottom: 5px;
        }

        .profile-id {
            color: var(--muted-text);
            font-size: 13px;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .profile-id i {
            color: var(--primary-maroon);
            font-size: 12px;
        }

        .profile-status {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 5px 12px;
            background: var(--success-green-light);
            color: var(--success-green);
            border-radius: var(--radius-sm);
            font-size: 12px;
            font-weight: 600;
            border: 1px solid var(--success-green);
        }

        /* Content Sections - matching dashboard card style */
        .content-section {
            background: white;
            padding: 25px;
            border-radius: var(--radius-xl);
            margin-bottom: 25px;
            box-shadow: var(--card-shadow);
            border: 1px solid var(--border-light);
            transition: all var(--transition-base);
        }

        .content-section:hover {
            transform: translateY(-3px);
            box-shadow: var(--card-shadow-hover);
            border-color: var(--border-hover);
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 1px solid var(--border-light);
        }

        .section-title {
            font-size: 18px;
            color: var(--text-dark);
            font-weight: 600;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .section-title i {
            color: var(--primary-maroon);
            font-size: 16px;
            background: var(--accent-pink);
            width: 36px;
            height: 36px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        /* Form Grids */
        .personal-info-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
            margin-bottom: 20px;
        }
        
        .form-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 20px;
            margin-bottom: 20px;
        }

        .full-width {
            grid-column: span 2;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .form-label {
            font-size: 12px;
            font-weight: 600;
            color: var(--text-dark);
            display: flex;
            align-items: center;
            gap: 6px;
            text-transform: uppercase;
            letter-spacing: 0.3px;
        }

        .form-label i {
            color: var(--primary-maroon);
            font-size: 11px;
        }

        .form-input {
            width: 100%;
            padding: 12px 14px;
            border-radius: var(--radius-md);
            border: 1px solid var(--border-light);
            background: white;
            color: var(--text-dark);
            font-family: 'Poppins', sans-serif;
            font-size: 14px;
            transition: all var(--transition-base);
        }

        .form-input:hover {
            border-color: var(--border-hover);
        }

        .form-input:focus {
            outline: none;
            border-color: var(--primary-maroon);
            box-shadow: 0 0 0 3px rgba(107, 13, 30, 0.1);
        }

        .form-input:disabled {
            background: var(--bg-lighter);
            cursor: not-allowed;
        }

        /* Section Actions - Buttons */
        .section-actions {
            display: flex;
            justify-content: flex-end;
            gap: 15px;
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid var(--border-light);
        }

        .btn-primary {
            background: var(--primary-maroon);
            color: white;
            border: none;
            padding: 12px 28px;
            border-radius: var(--radius-md);
            cursor: pointer;
            font-family: 'Poppins', sans-serif;
            font-size: 13px;
            font-weight: 600;
            transition: all var(--transition-base);
            box-shadow: var(--button-shadow);
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn-primary:hover {
            background: var(--primary-maroon-dark);
            transform: translateY(-2px);
        }

        .btn-secondary {
            background: transparent;
            color: var(--primary-maroon);
            border: 1px solid var(--primary-maroon);
            padding: 12px 28px;
            border-radius: var(--radius-md);
            cursor: pointer;
            font-family: 'Poppins', sans-serif;
            font-size: 13px;
            font-weight: 600;
            transition: all var(--transition-base);
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn-secondary:hover {
            background: var(--accent-pink);
        }

        /* Documents List */
        .documents-list {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .document-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 16px 20px;
            border-radius: var(--radius-lg);
            background: var(--bg-lighter);
            border: 1px solid var(--border-light);
            transition: all var(--transition-base);
            flex-wrap: wrap;
            gap: 15px;
        }

        .document-item:hover {
            background: var(--bg-hover);
            border-color: var(--border-hover);
        }

        .document-info {
            display: flex;
            align-items: center;
            gap: 15px;
            flex: 1;
        }

        .document-name {
            font-size: 14px;
            font-weight: 600;
            color: var(--text-dark);
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .document-name i {
            color: var(--primary-maroon);
            font-size: 16px;
        }

        .document-status {
            padding: 4px 10px;
            border-radius: var(--radius-sm);
            font-size: 11px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.3px;
        }

        .status-verified {
            background: var(--success-green-light);
            color: var(--success-green);
            border: 1px solid var(--success-green);
        }

        .status-pending {
            background: var(--warning-orange-light);
            color: var(--warning-orange);
            border: 1px solid var(--warning-orange);
        }

        .status-rejected {
            background: var(--danger-red-light);
            color: var(--danger-red);
            border: 1px solid var(--danger-red);
        }

        .btn-file-reupload {
            background: var(--danger-red-light) !important;
            color: var(--danger-red) !important;
            border: 1px solid var(--danger-red) !important;
            animation: pulse-red 1.5s infinite;
        }

        @keyframes pulse-red {
            0%   { box-shadow: 0 0 0 0 rgba(220,53,69,0.4); }
            70%  { box-shadow: 0 0 0 6px rgba(220,53,69,0); }
            100% { box-shadow: 0 0 0 0 rgba(220,53,69,0); }
        }

        .document-actions {
            display: flex;
            gap: 10px;
            align-items: center;
            flex-wrap: wrap;
        }

        .btn-icon {
            padding: 8px 16px;
            border-radius: var(--radius-md);
            font-size: 12px;
            font-weight: 500;
            cursor: pointer;
            transition: all var(--transition-base);
            display: inline-flex;
            align-items: center;
            gap: 8px;
            border: none;
            font-family: 'Poppins', sans-serif;
        }

        .btn-view {
            background: var(--accent-blue);
            color: var(--accent-blue-dark);
            border: 1px solid var(--accent-blue-dark);
        }

        .btn-view:hover {
            background: var(--accent-blue-dark);
            color: white;
        }

        .btn-upload {
            background: var(--primary-maroon);
            color: white;
        }

        .btn-upload:hover {
            background: var(--primary-maroon-dark);
            transform: translateY(-1px);
        }

        .btn-file {
            background: var(--bg-light);
            color: var(--text-dark);
            border: 1px solid var(--border-light);
            padding: 8px 16px;
            border-radius: var(--radius-md);
            font-size: 12px;
            font-weight: 500;
            cursor: pointer;
            transition: all var(--transition-base);
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn-file:hover {
            background: var(--border-light);
        }

        /* Password Form */
        .password-form {
            max-width: 450px;
            margin: 0 auto;
        }
        
        .password-wrapper {
            position: relative;
            display: flex;
            align-items: center;
        }
        
        .password-wrapper .form-input {
            flex: 1;
            padding-right: 45px;
        }
        
        .toggle-password {
            position: absolute;
            right: 15px;
            cursor: pointer;
            color: var(--muted-text);
            font-size: 16px;
            transition: all var(--transition-base);
            z-index: 10;
        }
        
        .toggle-password:hover {
            color: var(--primary-maroon);
        }

        .password-note {
            color: var(--muted-text);
            font-size: 11px;
            margin-top: 5px;
        }

        /* Modal Styles */
        .modal {
            display: none;
            position: fixed;
            z-index: 10000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.8);
            animation: fadeIn 0.3s ease;
        }

        .modal-content {
            position: relative;
            background-color: white;
            margin: 5% auto;
            padding: 25px;
            width: 90%;
            max-width: 800px;
            border-radius: var(--radius-xl);
            box-shadow: 0 5px 30px rgba(0,0,0,0.3);
            border: 1px solid var(--border-light);
            animation: slideDown 0.3s ease;
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-bottom: 15px;
            border-bottom: 1px solid var(--border-light);
            margin-bottom: 20px;
        }

        .modal-header h3 {
            margin: 0;
            color: var(--text-dark);
            font-size: 18px;
        }

        .close-modal {
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
            color: var(--muted-text);
            transition: all var(--transition-base);
        }

        .close-modal:hover {
            color: var(--danger-red);
        }

        .modal-body {
            text-align: center;
        }

        .modal-body img {
            max-width: 100%;
            max-height: 500px;
            border-radius: var(--radius-lg);
        }

        .modal-body iframe {
            width: 100%;
            height: 500px;
            border: none;
            border-radius: var(--radius-lg);
        }

        /* Animations */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes slideDown {
            from {
                transform: translateY(-50px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        @keyframes slideInRight {
            from { transform: translateX(100%); opacity: 0; }
            to { transform: translateX(0); opacity: 1; }
        }

        @keyframes slideOutRight {
            from { transform: translateX(0); opacity: 1; }
            to { transform: translateX(100%); opacity: 0; }
        }

        /* ── Responsive ── */

        /* Tablet (≤992px) */
        @media (max-width: 992px) {
            .profile-wrapper {
                padding: 20px;
            }

            .page-header {
                flex-direction: column;
                align-items: stretch;
                gap: 15px;
            }

            .header-title h1 {
                font-size: 24px;
            }

            .profile-header-content {
                flex-direction: column;
                text-align: center;
                gap: 15px;
            }

            .profile-id {
                justify-content: center;
            }

            .profile-status {
                margin: 0 auto;
            }

            .personal-info-grid {
                grid-template-columns: 1fr;
            }

            .full-width {
                grid-column: span 1;
            }

            .form-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        /* Mobile (≤768px) */
        @media (max-width: 768px) {
            .profile-wrapper {
                padding: 12px;
            }

            /* Viewport meta safety: make inputs not cause auto-zoom on iOS */
            .form-input {
                font-size: 16px;
            }

            .profile-header-card,
            .content-section {
                padding: 18px 16px;
                border-radius: var(--radius-lg);
            }

            /* Profile avatar centered with touch-friendly sizing */
            .profile-avatar {
                width: 80px;
                height: 80px;
                font-size: 24px;
                margin: 0 auto;
            }

            .profile-name {
                font-size: 18px;
            }

            /* Section header stacks on small screens */
            .section-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 10px;
            }

            .section-title {
                font-size: 15px;
            }

            .section-title i {
                width: 32px;
                height: 32px;
                font-size: 13px;
            }

            /* Grids collapse to single column */
            .personal-info-grid,
            .form-grid {
                grid-template-columns: 1fr;
                gap: 14px;
            }

            .full-width {
                grid-column: span 1;
            }

            /* Buttons full-width & touch-friendly */
            .section-actions {
                flex-direction: column;
                gap: 10px;
            }

            .btn-primary,
            .btn-secondary {
                width: 100%;
                justify-content: center;
                padding: 14px 20px;
                font-size: 14px;
            }

            /* Document items stack */
            .document-item {
                flex-direction: column;
                align-items: flex-start;
                gap: 12px;
                padding: 14px;
            }

            .document-info {
                flex-wrap: wrap;
                gap: 8px;
            }

            .document-name {
                font-size: 13px;
            }

            .document-actions {
                width: 100%;
                justify-content: flex-start;
                flex-wrap: wrap;
                gap: 8px;
            }

            /* Make action buttons touch-friendly */
            .btn-icon {
                padding: 10px 14px;
                font-size: 12px;
            }

            .btn-file {
                padding: 10px 14px;
            }

            /* Password form full width */
            .password-form {
                max-width: 100%;
            }

            /* Modal fits mobile screen */
            .modal-content {
                margin: 10% auto;
                width: 95%;
                padding: 18px 14px;
            }

            .modal-body iframe {
                height: 300px;
            }

            .modal-body img {
                max-height: 300px;
            }

            /* Toast notifications stay in viewport */
            div[style*="position: fixed"][style*="top: 20px"] {
                right: 10px !important;
                left: 10px !important;
                max-width: calc(100vw - 20px) !important;
            }
        }

        /* Small phones (≤480px) */
        @media (max-width: 480px) {
            .profile-wrapper {
                padding: 10px 8px;
            }

            .page-header {
                margin-bottom: 16px;
            }

            .header-title h1 {
                font-size: 20px;
            }

            .header-title p {
                font-size: 12px;
            }

            .profile-header-card,
            .content-section {
                padding: 14px 12px;
                margin-bottom: 14px;
                border-radius: var(--radius-md);
            }

            .profile-avatar {
                width: 70px;
                height: 70px;
                font-size: 20px;
            }

            .profile-name {
                font-size: 16px;
            }

            .profile-id {
                font-size: 12px;
            }

            .profile-status {
                font-size: 11px;
                padding: 4px 10px;
            }

            .form-input {
                padding: 11px 12px;
            }

            .form-label {
                font-size: 11px;
            }

            .section-title {
                font-size: 14px;
                gap: 8px;
            }

            .section-title i {
                width: 28px;
                height: 28px;
                font-size: 12px;
            }

            /* Document status badge wraps gracefully */
            .document-status {
                font-size: 10px;
                padding: 3px 8px;
            }

            /* Stack document actions vertically if really tight */
            .document-actions {
                flex-direction: column;
                align-items: stretch;
            }

            .btn-icon,
            .btn-file {
                width: 100%;
                justify-content: center;
            }

            /* Password toggle easier to tap */
            .toggle-password {
                font-size: 18px;
                right: 12px;
            }

            /* Password note font */
            .password-note {
                font-size: 10px;
            }

            /* Modal */
            .modal-content {
                margin: 5% auto;
                width: 98%;
                padding: 14px 10px;
            }

            .modal-header h3 {
                font-size: 15px;
            }

            .modal-body iframe {
                height: 240px;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="profile-wrapper">
        <div class="page-header">
            <div class="header-title">
                <h1>Profile & Account Settings</h1>
                <p>Manage your personal information, vehicle details, and account security</p>
            </div>
        </div>

        <!-- Profile Header Card - REPEATER PRESERVED -->
        <asp:Repeater ID="rptPersonalInfo" runat="server">
            <ItemTemplate>
                <div class="profile-header-card">
                    <div class="profile-header-content">
                        <div class="profile-avatar">
                            <asp:Image ID="imgProfile" runat="server" ImageUrl='<%# GetProfilePhotoUrl(Eval("ProfilePhoto")) %>' Visible='<%# GetProfilePhotoUrl(Eval("ProfilePhoto")) != null %>' AlternateText="Profile Photo" />
                            <asp:Label ID="lblInitials" runat="server" Text='<%# GetInitials(Eval("FullName")) %>' Visible='<%# GetProfilePhotoUrl(Eval("ProfilePhoto")) == null %>' Font-Size="24px" Font-Bold="true" />
                        </div>
                        <div class="profile-info">
                            <div class="profile-name"><%# Eval("FullName") %></div>
                            <div class="profile-id">
                                <i class="fas fa-id-card"></i>
                                Rider ID: RDR-<%# Eval("UserID").ToString().PadLeft(4, '0') %>
                            </div>
                            <span class="profile-status">
                                <i class="fas fa-check-circle"></i>
                                <%# (Eval("RiderStatus") as string) == "available" ? "Available Rider" : "Active Rider" %>
                            </span>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>

        <!-- Personal Information Section - REPEATER PRESERVED -->
        <div class="content-section">
            <div class="section-header">
                <h3 class="section-title">
                    <i class="fas fa-user"></i>
                    Personal Information
                </h3>
            </div>
            
            <asp:Repeater ID="rptPersonalInfoForm" runat="server">
                <ItemTemplate>
                    <div class="personal-info-grid">
                        <div class="form-group">
                            <label class="form-label">
                                <i class="fas fa-user-circle"></i>
                                Full Name
                            </label>
                            <asp:TextBox ID="txtFullName" runat="server" CssClass="form-input" Text='<%# Eval("FullName") %>' />
                        </div>

                        <div class="form-group">
                            <label class="form-label">
                                <i class="fas fa-envelope"></i>
                                Email Address
                            </label>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-input" Text='<%# Eval("Email") %>' TextMode="Email" />
                        </div>

                        <div class="form-group">
                            <label class="form-label">
                                <i class="fas fa-phone"></i>
                                Phone Number
                            </label>
                            <asp:TextBox ID="txtPhone" runat="server" CssClass="form-input" Text='<%# Eval("Phone") %>' />
                        </div>

                        <div class="form-group">
                            <label class="form-label">
                                <i class="fas fa-calendar-alt"></i>
                                Date Joined
                            </label>
                            <asp:TextBox ID="txtDateJoined" runat="server" CssClass="form-input" Text='<%# Eval("JoinDate") %>' Enabled="false" />
                        </div>

                        <div class="form-group full-width">
                            <label class="form-label">
                                <i class="fas fa-home"></i>
                                Address
                            </label>
                            <asp:TextBox ID="txtAddress" runat="server" CssClass="form-input" Text='<%# Eval("Address") %>' />
                        </div>
                    </div>

                    <div class="section-actions">
                        <asp:Button ID="btnSavePersonalInfo" runat="server" CssClass="btn-primary" Text="Save Changes" OnClick="btnSavePersonalInfo_Click" />
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>

        <!-- Vehicle Details Section - REPEATER PRESERVED -->
        <div class="content-section">
            <div class="section-header">
                <h3 class="section-title">
                    <i class="fas fa-motorcycle"></i>
                    Vehicle Details
                </h3>
            </div>
            
            <asp:Repeater ID="rptVehicleDetails" runat="server">
                <ItemTemplate>
                    <div class="form-grid">
                        <div class="form-group">
                            <label class="form-label">
                                <i class="fas fa-car"></i>
                                Vehicle Type
                            </label>
                            <asp:TextBox ID="txtVehicle" runat="server" CssClass="form-input" Text='<%# Eval("Vehicle") %>' />
                        </div>

                        <div class="form-group">
                            <label class="form-label">
                                <i class="fas fa-industry"></i>
                                Brand & Model
                            </label>
                            <asp:TextBox ID="txtVehicleModel" runat="server" CssClass="form-input" Text='<%# Eval("VehicleModel") %>' />
                        </div>

                        <div class="form-group">
                            <label class="form-label">
                                <i class="fas fa-id-badge"></i>
                                License Plate
                            </label>
                            <asp:TextBox ID="txtLicensePlate" runat="server" CssClass="form-input" Text='<%# Eval("LicensePlate") %>' />
                        </div>

                        <div class="form-group">
                            <label class="form-label">
                                <i class="fas fa-calendar"></i>
                                Year
                            </label>
                            <asp:TextBox ID="txtVehicleYear" runat="server" CssClass="form-input" Text='<%# Eval("VehicleYear") %>' />
                        </div>

                        <div class="form-group">
                            <label class="form-label">
                                <i class="fas fa-palette"></i>
                                Color
                            </label>
                            <asp:TextBox ID="txtVehicleColor" runat="server" CssClass="form-input" Text='<%# Eval("VehicleColor") %>' />
                        </div>

                        <div class="form-group">
                            <label class="form-label">
                                <i class="fas fa-file-contract"></i>
                                OR/CR Number
                            </label>
                            <asp:TextBox ID="txtORCRNumber" runat="server" CssClass="form-input" Text='<%# Eval("ORCRNumber") %>' />
                        </div>

                        <div class="form-group">
                            <label class="form-label">
                                <i class="fas fa-shield-alt"></i>
                                Insurance Policy
                            </label>
                            <asp:TextBox ID="txtInsurancePolicy" runat="server" CssClass="form-input" Text='<%# Eval("InsurancePolicy") %>' />
                        </div>

                        <div class="form-group">
                            <label class="form-label">
                                <i class="fas fa-calendar-alt"></i>
                                Insurance Date
                            </label>
                            <asp:TextBox ID="txtInsuranceDate" runat="server" CssClass="form-input" Text='<%# Eval("InsuranceDate", "{0:yyyy-MM-dd}") %>' TextMode="Date" />
                        </div>
                    </div>

                    <div class="section-actions">
                        <asp:Button ID="btnSaveVehicleInfo" runat="server" CssClass="btn-primary" Text="Update Vehicle Info" OnClick="btnSaveVehicleInfo_Click" />
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>

        <!-- Documents Section - REPEATER PRESERVED -->
        <div class="content-section">
            <div class="section-header">
                <h3 class="section-title">
                    <i class="fas fa-file-alt"></i>
                    Uploaded Documents
                </h3>
            </div>
            
            <div class="documents-list">
                <asp:Repeater ID="rptDocuments" runat="server" OnItemDataBound="rptDocuments_ItemDataBound">
                    <ItemTemplate>
                        <div class="document-item">
                            <div class="document-info">
                                <div class="document-name">
                                    <i class='<%# "fas " + GetDocumentIcon(Eval("DocumentName").ToString()) %>'></i>
                                    <%# Eval("DocumentName") %>
                                </div>
                                <span class='<%# "document-status " + GetStatusClass(Eval("Status").ToString()) %>'>
                                    <i class='<%# "fas " + GetStatusIcon(Eval("Status").ToString()) %>'></i>
                                    <%# GetStatusLabel(Eval("Status").ToString()) %>
                                </span>
                            </div>
                            <div class="document-actions">
                                <asp:Literal ID="litViewBtn" runat="server" />
                                
                                <div class="file-input-wrapper">
                                    <asp:FileUpload ID="fuDocument" runat="server" CssClass="hidden-file-input" Style="display:none;" accept=".jpg,.jpeg,.png,.pdf" />
                                    <asp:Literal ID="litChooseBtn" runat="server" />
                                </div>
                                <asp:Button ID="btnUpload" runat="server" Text="Upload" CssClass="btn-icon btn-upload" CommandArgument='<%# Eval("DocumentColumn") %>' OnClick="UploadDocument" />
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>

        <!-- Change Password Section -->
        <div class="content-section">
            <div class="section-header">
                <h3 class="section-title">
                    <i class="fas fa-lock"></i>
                    Change Password
                </h3>
            </div>
            
            <div class="password-form">
                <div class="form-group">
                    <label class="form-label">
                        <i class="fas fa-key"></i>
                        Current Password
                    </label>
                    <div class="password-wrapper">
                        <asp:TextBox ID="txtCurrentPassword" runat="server" CssClass="form-input" TextMode="Password" placeholder="Enter current password" ClientIDMode="Static" />
                        <i class="fas fa-eye toggle-password" data-target="txtCurrentPassword"></i>
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label">
                        <i class="fas fa-key"></i>
                        New Password
                    </label>
                    <div class="password-wrapper">
                        <asp:TextBox ID="txtNewPassword" runat="server" CssClass="form-input" TextMode="Password" placeholder="Enter new password" ClientIDMode="Static" />
                        <i class="fas fa-eye toggle-password" data-target="txtNewPassword"></i>
                    </div>
                    <div class="password-note">
                        <i class="fas fa-info-circle"></i> Must be at least 8 characters with letters and numbers
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label">
                        <i class="fas fa-key"></i>
                        Confirm New Password
                    </label>
                    <div class="password-wrapper">
                        <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-input" TextMode="Password" placeholder="Confirm new password" ClientIDMode="Static" />
                        <i class="fas fa-eye toggle-password" data-target="txtConfirmPassword"></i>
                    </div>
                </div>

                <div class="section-actions">
                    <asp:Button ID="btnChangePassword" runat="server" CssClass="btn-primary" Text="Update Password" OnClick="btnChangePassword_Click" />
                </div>
            </div>
        </div>
    </div>

    <!-- Document Viewer Modal -->
    <div id="documentModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h3 id="modalTitle">Document Viewer</h3>
                <span class="close-modal" onclick="closeModal()">&times;</span>
            </div>
            <div class="modal-body" id="modalBody">
                <p>Loading...</p>
            </div>
        </div>
    </div>

    <script>
        function showNotification(message, type) {
            const notification = document.createElement('div');
            const isMobile = window.innerWidth <= 600;
            notification.style.cssText = `
                position: fixed;
                top: ${isMobile ? '10px' : '20px'};
                right: ${isMobile ? '10px' : '20px'};
                ${isMobile ? 'left: 10px;' : ''}
                padding: 14px 20px;
                background: ${type === 'success' ? '#2d9d78' :
                    type === 'info' ? '#3b82f6' :
                        type === 'warning' ? '#d97706' : '#b91c1c'};
                color: white;
                border-radius: 12px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.15);
                z-index: 10001;
                animation: slideInRight 0.3s ease;
                display: flex;
                align-items: center;
                gap: 10px;
                max-width: ${isMobile ? 'calc(100vw - 20px)' : '350px'};
                font-family: 'Poppins', sans-serif;
                font-size: 14px;
            `;
            notification.innerHTML = `
                <i class="fas ${type === 'success' ? 'fa-check-circle' :
                    type === 'info' ? 'fa-info-circle' :
                        type === 'warning' ? 'fa-exclamation-triangle' :
                            'fa-exclamation-circle'}"></i>
                <span>${message}</span>
            `;
            document.body.appendChild(notification);
            setTimeout(() => {
                notification.style.animation = 'slideOutRight 0.3s ease';
                setTimeout(() => {
                    if (notification.parentNode) {
                        document.body.removeChild(notification);
                    }
                }, 300);
            }, 3000);
        }

        function initializePasswordToggles() {
            setTimeout(function () {
                const toggleIcons = document.querySelectorAll('.toggle-password');
                toggleIcons.forEach(function (icon) {
                    const newIcon = icon.cloneNode(true);
                    if (icon.parentNode) {
                        icon.parentNode.replaceChild(newIcon, icon);
                    }

                    newIcon.addEventListener('click', function (e) {
                        e.preventDefault();
                        e.stopPropagation();
                        const targetId = this.getAttribute('data-target');
                        const passwordInput = document.getElementById(targetId);

                        if (passwordInput) {
                            const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
                            passwordInput.setAttribute('type', type);
                            this.classList.toggle('fa-eye');
                            this.classList.toggle('fa-eye-slash');
                        }
                    });
                });
            }, 100);
        }

        function triggerAspFileUpload(documentColumn, chooseBtn) {
            // Find the asp:FileUpload input inside the same file-input-wrapper div
            const wrapper = chooseBtn.closest('.file-input-wrapper');
            const fileInput = wrapper ? wrapper.querySelector('input[type="file"]') : null;
            if (!fileInput) return;

            fileInput.onchange = function () {
                if (this.files && this.files[0]) {
                    const fileName = this.files[0].name;
                    chooseBtn.innerHTML = '<i class="fas fa-check"></i> ' +
                        fileName.substring(0, 20) + (fileName.length > 20 ? '...' : '');

                    // Highlight the Upload button
                    const uploadBtn = wrapper.parentElement.querySelector('.btn-upload');
                    if (uploadBtn) {
                        uploadBtn.style.opacity = '1';
                        uploadBtn.style.transform = 'scale(1.05)';
                        setTimeout(() => { uploadBtn.style.transform = 'scale(1)'; }, 200);
                    }
                }
            };

            fileInput.click();
        }

        function viewDocument(filePath, documentName) {
            const modal = document.getElementById('documentModal');
            const modalTitle = document.getElementById('modalTitle');
            const modalBody = document.getElementById('modalBody');

            if (!modal || !modalBody) {
                showNotification('Error opening document viewer', 'error');
                return;
            }

            modalTitle.textContent = documentName || 'Document Viewer';

            if (!filePath) {
                modalBody.innerHTML = '<div style="padding:40px;text-align:center;color:#8a6d6d;">' +
                    '<i class="fas fa-exclamation-triangle" style="font-size:48px;color:#d97706;margin-bottom:15px;display:block;"></i>' +
                    '<p style="font-size:15px;font-weight:600;">File not available</p>' +
                    '<p style="font-size:13px;">This document was uploaded on another device and is not accessible here.</p></div>';
                modal.style.display = 'block';
                return;
            }

            const fileExtension = filePath.split('.').pop().toLowerCase();

            if (fileExtension === 'jpg' || fileExtension === 'jpeg' || fileExtension === 'png' || fileExtension === 'gif') {
                modalBody.innerHTML = `<img src="${filePath}" alt="${documentName}" style="max-width:100%; max-height:500px; border-radius:12px;"
                    onerror="this.outerHTML='<div style=\'padding:40px;text-align:center;color:#8a6d6d;\'>' +
                        '<i class=\'fas fa-exclamation-triangle\' style=\'font-size:48px;color:#d97706;margin-bottom:15px;display:block;\'></i>' +
                        '<p style=\'font-size:15px;font-weight:600;\'>Image not found</p>' +
                        '<p style=\'font-size:13px;\'>The file may have been uploaded on another machine.</p></div>'" />`;
            } else if (fileExtension === 'pdf') {
                modalBody.innerHTML = `<iframe src="${filePath}" style="width:100%; height:500px; border:none; border-radius:12px;"></iframe>`;
            } else {
                modalBody.innerHTML = `<p>Unable to preview this file type. <a href="${filePath}" target="_blank" style="color:var(--primary-maroon);">Click here to download</a></p>`;
            }

            modal.style.display = 'block';
        }

        function closeModal() {
            const modal = document.getElementById('documentModal');
            const modalBody = document.getElementById('modalBody');
            if (modal) modal.style.display = 'none';
            if (modalBody) modalBody.innerHTML = '<p>Loading...</p>';
        }

        window.onclick = function (event) {
            const modal = document.getElementById('documentModal');
            if (event.target === modal) {
                closeModal();
            }
        }

        document.addEventListener('DOMContentLoaded', function () {
            initializePasswordToggles();
        });

        function pageLoad() {
            initializePasswordToggles();
        }
    </script>
</asp:Content>