<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Rider.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="TasteNet.Users.Rider.Profile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        :root {
            --primary-maroon: #6b0d1e;
            --primary-maroon-dark: #5a0b19;
            --primary-maroon-light: #f9ecee;
            --soft-cream: #fffaf3;
            --text-dark: #4a0e0e;
            --muted-text: #8a6d6d;
            --success-green: #2d9d78;
            --success-green-light: #e6f4f1;
            --success-green-dark: #1f7a5e;
            --warning-orange: #d97706;
            --warning-orange-light: #fff3e6;
            --danger-red: #b91c1c;
            --danger-red-light: #fee2e2;
            --accent-yellow: #ffcc00;
            --accent-yellow-dark: #e6b800;
            --accent-yellow-light: #fff9e6;
            --accent-pink: #f9ecee;
            --accent-blue: #eff6ff;
            --accent-blue-dark: #3b82f6;
            --accent-purple: #7c3aed;
            --accent-purple-light: #f3e8ff;
            --border-light: #e2d1d1;
            --border-hover: #d4b8b8;
            --bg-hover: #fefaf5;
            --bg-light: #f3ebe0;
            --bg-lighter: #f9f4ee;
            --card-shadow: 0 10px 30px rgba(107, 13, 30, 0.05);
            --card-shadow-hover: 0 15px 40px rgba(107, 13, 30, 0.12);
            --button-shadow: 0 4px 12px rgba(107, 13, 30, 0.2);
            --button-shadow-hover: 0 6px 18px rgba(107, 13, 30, 0.3);
            --radius-sm: 8px;
            --radius-md: 10px;
            --radius-lg: 12px;
            --radius-xl: 16px;
            --radius-2xl: 20px;
            --transition-fast: 0.2s ease;
            --transition-base: 0.3s ease;
            --transition-slow: 0.4s ease;
        }

        html, body, form {
            margin: 0 !important;
            padding: 0 !important;
            background-color: var(--soft-cream) !important;
            width: 100%;
            font-family: 'Poppins', sans-serif;
            color: var(--text-dark);
            min-height: 100vh;
        }

        .profile-wrapper {
            background: var(--soft-cream) !important;
            padding: 25px 35px;
            max-width: 1100px;
            margin: 0 auto;
            min-height: 100vh;
            box-sizing: border-box;
        }

        .page-header-main {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            flex-wrap: wrap;
            gap: 15px;
            padding-bottom: 20px;
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
            margin: 6px 0 0 0;
            font-size: 14px;
            line-height: 1.5;
        }

        .profile-header-card {
            background: white;
            padding: 28px;
            border-radius: var(--radius-xl);
            margin-bottom: 25px;
            box-shadow: var(--card-shadow);
            border: 1px solid var(--border-light);
            transition: all var(--transition-base);
            animation: fadeIn 0.5s ease-out;
        }

        .profile-header-card:hover {
            border-color: var(--border-hover);
            box-shadow: var(--card-shadow-hover);
        }

        .profile-header-content {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .profile-avatar {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--primary-maroon), var(--primary-maroon-dark));
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            font-size: 24px;
            box-shadow: 0 4px 12px rgba(107, 13, 30, 0.2);
            border: 3px solid white;
            position: relative;
            overflow: hidden;
        }

        .profile-avatar::after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(135deg, rgba(255,255,255,0.1), transparent);
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
            font-size: 14px;
            margin-bottom: 8px;
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
            padding: 6px 12px;
            background: var(--success-green-light);
            color: var(--success-green);
            border-radius: var(--radius-sm);
            font-size: 12px;
            font-weight: 600;
            border: 1px solid var(--success-green);
        }

        .content-section {
            background: white;
            padding: 28px;
            border-radius: var(--radius-xl);
            margin-bottom: 25px;
            box-shadow: var(--card-shadow);
            border: 1px solid var(--border-light);
            transition: all var(--transition-base);
            animation: fadeIn 0.5s ease-out;
        }

        .content-section:nth-child(2) { animation-delay: 0.1s; }
        .content-section:nth-child(3) { animation-delay: 0.2s; }
        .content-section:nth-child(4) { animation-delay: 0.3s; }
        .content-section:nth-child(5) { animation-delay: 0.4s; }

        .content-section:hover {
            border-color: var(--border-hover);
            box-shadow: var(--card-shadow-hover);
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
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
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 25px;
            margin-bottom: 20px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .form-group.full {
            grid-column: 1 / -1;
        }

        .form-label {
            font-size: 13px;
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
            width: 90%;
            padding: 14px 16px;
            border-radius: var(--radius-md);
            border: 1px solid var(--border-light);
            background: white;
            color: var(--text-dark);
            font-family: 'Poppins', sans-serif;
            font-size: 14px;
            transition: all var(--transition-base);
            margin-top: 5px;
        }

        .form-input:hover {
            border-color: var(--border-hover);
        }

        .form-input:focus {
            outline: none;
            border-color: var(--primary-maroon);
            box-shadow: 0 0 0 3px rgba(107, 13, 30, 0.1);
        }

        .form-input::placeholder {
            color: var(--muted-text);
            font-weight: 400;
        }

        .section-actions {
            display: flex;
            justify-content: flex-end;
            gap: 15px;
            margin-top: 25px;
            padding-top: 20px;
            border-top: 1px solid var(--border-light);
        }

        .btn-primary {
            background: var(--primary-maroon);
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: var(--radius-md);
            cursor: pointer;
            font-family: 'Poppins', sans-serif;
            font-size: 14px;
            font-weight: 600;
            transition: all var(--transition-base);
            box-shadow: var(--button-shadow);
            display: inline-flex;
            align-items: center;
            gap: 8px;
            min-width: 140px;
            justify-content: center;
        }

        .btn-primary:hover {
            background: var(--primary-maroon-dark);
            transform: translateY(-2px);
            box-shadow: var(--button-shadow-hover);
        }

        .btn-secondary {
            background: transparent;
            color: var(--primary-maroon);
            border: 1px solid var(--primary-maroon);
            padding: 12px 24px;
            border-radius: var(--radius-md);
            cursor: pointer;
            font-family: 'Poppins', sans-serif;
            font-size: 14px;
            font-weight: 600;
            transition: all var(--transition-base);
            min-width: 140px;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            justify-content: center;
        }

        .btn-secondary:hover {
            background: var(--primary-maroon-light);
        }

        .documents-list {
            display: flex;
            flex-direction: column;
            gap: 12px;
            margin-bottom: 20px;
        }

        .document-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 16px 20px;
            border-radius: var(--radius-lg);
            background: var(--bg-lighter);
            border: 1px solid transparent;
            transition: all var(--transition-base);
            animation: slideUp 0.3s ease-out;
            animation-fill-mode: both;
        }

        .document-item:nth-child(1) { animation-delay: 0.1s; }
        .document-item:nth-child(2) { animation-delay: 0.2s; }
        .document-item:nth-child(3) { animation-delay: 0.3s; }
        .document-item:nth-child(4) { animation-delay: 0.4s; }

        .document-item:hover {
            background: var(--bg-hover);
            border-color: var(--border-light);
            transform: translateX(5px);
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
            font-size: 13px;
        }

        .document-status {
            padding: 6px 12px;
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

        .upload-area {
            border: 2px dashed var(--border-light);
            border-radius: var(--radius-lg);
            padding: 30px 20px;
            text-align: center;
            background: var(--bg-lighter);
            cursor: pointer;
            transition: all var(--transition-base);
            margin-top: 20px;
        }

        .upload-area:hover {
            border-color: var(--primary-maroon);
            background: var(--primary-maroon-light);
        }

        .upload-content {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 10px;
        }

        .upload-icon {
            width: 48px;
            height: 48px;
            background: var(--primary-maroon);
            color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 18px;
        }

        .upload-text {
            color: var(--muted-text);
            font-size: 14px;
            font-weight: 500;
        }

        .upload-subtext {
            color: var(--muted-text);
            font-size: 12px;
        }

        .password-form {
            max-width: 400px;
            margin: 0 auto;
        }

        .password-note {
            color: var(--muted-text);
            font-size: 12px;
            margin-top: 4px;
            font-style: italic;
        }

        .form-section-spacing {
            margin-bottom: 35px;
        }

        .form-row-spacing {
            margin-bottom: 8px;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        @keyframes slideUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @media (max-width: 992px) {
            .profile-wrapper {
                padding: 20px;
            }
            .profile-header-content {
                flex-direction: column;
                text-align: center;
                gap: 15px;
            }
            .form-grid {
                grid-template-columns: 1fr;
                gap: 20px;
            }
        }

        @media (max-width: 768px) {
            .header-title h1 {
                font-size: 24px;
            }
            .content-section {
                padding: 20px;
            }
            .section-actions {
                flex-direction: column;
            }
            .btn-primary, .btn-secondary {
                width: 100%;
            }
            .profile-avatar {
                width: 70px;
                height: 70px;
                font-size: 20px;
            }
        }

        @media (max-width: 480px) {
            .profile-wrapper {
                padding: 15px;
            }
            .document-item {
                flex-direction: column;
                align-items: flex-start;
                gap: 10px;
            }
            .document-status {
                align-self: flex-end;
            }
            .form-grid {
                gap: 15px;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="profile-wrapper">
        <div class="page-header-main">
            <div class="header-title">
                <h1>Profile & Account Settings</h1>
                <p>Manage your personal information, vehicle details, and account security</p>
            </div>
        </div>

        <div class="profile-header-card">
            <div class="profile-header-content">
                <div class="profile-avatar">
                    BM
                </div>
                <div class="profile-info">
                    <div class="profile-name">Bryle Andre Magallano</div>
                    <div class="profile-id">
                        <i class="fas fa-id-card"></i>
                        Rider ID: RDR-2024-012
                    </div>
                    <span class="profile-status">
                        <i class="fas fa-check-circle"></i>
                        Verified Rider
                    </span>
                </div>
            </div>
        </div>

        <div class="content-section">
            <div class="section-header">
                <h3 class="section-title">
                    <i class="fas fa-user"></i>
                    Personal Information
                </h3>
            </div>
            
            <div class="form-grid">
                <div class="form-group">
                    <label class="form-label">
                        <i class="fas fa-user-circle"></i>
                        Full Name
                    </label>
                    <input type="text" class="form-input" value="Bryle Andre Magallano" />
                </div>

                <div class="form-group">
                    <label class="form-label">
                        <i class="fas fa-envelope"></i>
                        Email Address
                    </label>
                    <input type="email" class="form-input" value="brylem@gmail.com" />
                </div>

                <div class="form-group">
                    <label class="form-label">
                        <i class="fas fa-phone"></i>
                        Phone Number
                    </label>
                    <input type="tel" class="form-input" value="(+63) 912 345 6789" />
                </div>

                <div class="form-group">
                    <label class="form-label">
                        <i class="fas fa-calendar-alt"></i>
                        Date of Birth
                    </label>
                    <input type="date" class="form-input" value="2003-06-15" />
                </div>

                <div class="form-group full">
                    <label class="form-label">
                        <i class="fas fa-home"></i>
                        Address
                    </label>
                    <input type="text" class="form-input" value="Greenside, Malagasang, Imus, Cavite" />
                </div>
            </div>

            <div class="section-actions">
                <button class="btn-primary">
                    <i class="fas fa-save"></i>
                    Save Changes
                </button>
            </div>
        </div>

        <div class="content-section">
            <div class="section-header">
                <h3 class="section-title">
                    <i class="fas fa-motorcycle"></i>
                    Vehicle Details
                </h3>
            </div>
            
            <div class="form-grid">
                <div class="form-group">
                    <label class="form-label">
                        <i class="fas fa-car"></i>
                        Vehicle Type
                    </label>
                    <input type="text" class="form-input" value="Motorcycle" />
                </div>

                <div class="form-group">
                    <label class="form-label">
                        <i class="fas fa-industry"></i>
                        Make & Model
                    </label>
                    <input type="text" class="form-input" value="Honda Click 125" />
                </div>

                <div class="form-group">
                    <label class="form-label">
                        <i class="fas fa-id-badge"></i>
                        License Plate
                    </label>
                    <input type="text" class="form-input" value="ABC-1234" />
                </div>

                <div class="form-group">
                    <label class="form-label">
                        <i class="fas fa-calendar"></i>
                        Year
                    </label>
                    <input type="text" class="form-input" value="2022" />
                </div>

                <div class="form-group">
                    <label class="form-label">
                        <i class="fas fa-palette"></i>
                        Color
                    </label>
                    <input type="text" class="form-input" value="Black" />
                </div>

                <div class="form-group">
                    <label class="form-label">
                        <i class="fas fa-shield-alt"></i>
                        Insurance
                    </label>
                    <input type="text" class="form-input" value="INS-987654" />
                </div>
            </div>

            <div class="section-actions">
                <button class="btn-primary">
                    <i class="fas fa-sync-alt"></i>
                    Update Vehicle Info
                </button>
            </div>
        </div>

        <div class="content-section">
            <div class="section-header">
                <h3 class="section-title">
                    <i class="fas fa-file-alt"></i>
                    Uploaded Documents
                </h3>
            </div>
            
            <div class="documents-list">
                <div class="document-item">
                    <div class="document-name">
                        <i class="fas fa-id-card"></i>
                        Driver's License
                    </div>
                    <span class="document-status status-verified">
                        Verified
                    </span>
                </div>

                <div class="document-item">
                    <div class="document-name">
                        <i class="fas fa-file-contract"></i>
                        Vehicle Registration
                    </div>
                    <span class="document-status status-verified">
                        Verified
                    </span>
                </div>

                <div class="document-item">
                    <div class="document-name">
                        <i class="fas fa-shield-alt"></i>
                        Insurance Certificate
                    </div>
                    <span class="document-status status-pending">
                        Pending Review
                    </span>
                </div>

                <div class="document-item">
                    <div class="document-name">
                        <i class="fas fa-user-check"></i>
                        Background Check
                    </div>
                    <span class="document-status status-verified">
                        Verified
                    </span>
                </div>
            </div>

            <div class="upload-area">
                <div class="upload-content">
                    <div class="upload-icon">
                        <i class="fas fa-cloud-upload-alt"></i>
                    </div>
                    <div class="upload-text">Upload New Document</div>
                    <div class="upload-subtext">PDF, JPG, or PNG up to 5MB</div>
                </div>
            </div>
        </div>

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
                    <input type="password" class="form-input" placeholder="Enter current password" />
                </div>

                <div class="form-group">
                    <label class="form-label">
                        <i class="fas fa-key"></i>
                        New Password
                    </label>
                    <input type="password" class="form-input" placeholder="Enter new password" />
                    <div class="password-note">Must be at least 8 characters with letters and numbers</div>
                </div>

                <div class="form-group">
                    <label class="form-label">
                        <i class="fas fa-key"></i>
                        Confirm New Password
                    </label>
                    <input type="password" class="form-input" placeholder="Confirm new password" />
                </div>

                <div class="section-actions">
                    <button class="btn-primary">
                        <i class="fas fa-lock"></i>
                        Update Password
                    </button>
                </div>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const saveButtons = document.querySelectorAll('.btn-primary');

            saveButtons.forEach(button => {
                button.addEventListener('click', function (e) {
                    e.preventDefault();

                    const originalText = this.innerHTML;
                    this.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Saving...';
                    this.disabled = true;

                    setTimeout(() => {
                        this.innerHTML = originalText;
                        this.disabled = false;
                        showNotification('Changes saved successfully!', 'success');
                    }, 1500);
                });
            });

            const uploadArea = document.querySelector('.upload-area');
            uploadArea.addEventListener('click', function () {
                const fileInput = document.createElement('input');
                fileInput.type = 'file';
                fileInput.accept = '.pdf,.jpg,.jpeg,.png';
                fileInput.style.display = 'none';

                fileInput.addEventListener('change', function (e) {
                    if (this.files.length > 0) {
                        const file = this.files[0];
                        const fileSize = (file.size / 1024 / 1024).toFixed(2);

                        if (fileSize > 5) {
                            showNotification('File size must be less than 5MB', 'warning');
                            return;
                        }

                        showNotification(`Uploading ${file.name}...`, 'info');

                        setTimeout(() => {
                            showNotification('Document uploaded successfully! It will be reviewed shortly.', 'success');
                        }, 2000);
                    }
                });

                document.body.appendChild(fileInput);
                fileInput.click();
                document.body.removeChild(fileInput);
            });

            function showNotification(message, type) {
                const notification = document.createElement('div');
                notification.style.cssText = `
                    position: fixed;
                    top: 20px;
                    right: 20px;
                    padding: 15px 20px;
                    background: ${type === 'success' ? 'var(--success-green)' :
                        type === 'info' ? 'var(--accent-blue-dark)' :
                            type === 'warning' ? 'var(--warning-orange)' : 'var(--danger-red)'};
                    color: white;
                    border-radius: var(--radius-md);
                    box-shadow: 0 4px 12px rgba(0,0,0,0.15);
                    z-index: 10001;
                    animation: slideInRight 0.3s ease;
                    display: flex;
                    align-items: center;
                    gap: 10px;
                    max-width: 300px;
                    font-family: 'Poppins', sans-serif;
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
                        document.body.removeChild(notification);
                    }, 300);
                }, 3000);
            }

            if (!document.querySelector('#notification-styles')) {
                const style = document.createElement('style');
                style.id = 'notification-styles';
                style.textContent = `
                    @keyframes slideInRight {
                        from { transform: translateX(100%); opacity: 0; }
                        to { transform: translateX(0); opacity: 1; }
                    }
                    @keyframes slideOutRight {
                        from { transform: translateX(0); opacity: 1; }
                        to { transform: translateX(100%); opacity: 0; }
                    }
                `;
                document.head.appendChild(style);
            }
        });
    </script>
</asp:Content>