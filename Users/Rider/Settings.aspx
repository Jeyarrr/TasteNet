<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Rider.Master" AutoEventWireup="true" CodeBehind="Settings.aspx.cs" Inherits="TasteNet.Users.Rider.settings" %>
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

        .settings-wrapper {
            background: var(--soft-cream) !important;
            padding: 30px 35px;
            max-width: 1200px;
            margin: 0 auto;
            min-height: calc(100vh - 80px);
            box-sizing: border-box;
            position: relative;
            animation: fadeIn 0.5s ease-out;
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
            animation: slideUp 0.5s ease-out;
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

        .settings-grid {
            display: grid;
            grid-template-columns: 1fr;
            gap: 25px;
            margin-bottom: 35px;
            animation: fadeIn 0.6s ease-out;
        }

        .settings-card {
            background: white;
            padding: 28px;
            border-radius: var(--radius-xl);
            box-shadow: var(--card-shadow);
            transition: all var(--transition-base);
            border: 1px solid var(--border-light);
            animation: slideUp 0.5s ease-out;
            animation-fill-mode: both;
            position: relative;
            overflow: hidden;
        }

        .settings-card:nth-child(1) { animation-delay: 0.1s; }
        .settings-card:nth-child(2) { animation-delay: 0.2s; }
        .settings-card:nth-child(3) { animation-delay: 0.3s; }

        .settings-card:hover {
            transform: translateY(-3px);
            box-shadow: var(--card-shadow-hover);
            border-color: var(--border-hover);
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
            background: var(--primary-maroon-light);
            width: 36px;
            height: 36px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .section-subtitle {
            font-size: 14px;
            color: var(--muted-text);
            font-weight: 400;
            margin-top: 4px;
            line-height: 1.5;
        }

        .settings-list {
            display: flex;
            flex-direction: column;
            gap: 0;
        }

        .settings-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 18px 20px;
            border-radius: var(--radius-lg);
            background: var(--bg-lighter);
            border: 1px solid transparent;
            transition: all var(--transition-base);
            animation: slideUp 0.3s ease-out;
            animation-fill-mode: both;
            margin-bottom: 8px;
        }

        .settings-row:nth-child(1) { animation-delay: 0.1s; }
        .settings-row:nth-child(2) { animation-delay: 0.2s; }
        .settings-row:nth-child(3) { animation-delay: 0.3s; }
        .settings-row:nth-child(4) { animation-delay: 0.4s; }

        .settings-row:hover {
            background: var(--bg-hover);
            border-color: var(--border-light);
            transform: translateX(5px);
        }

        .settings-row:last-child {
            margin-bottom: 0;
        }

        .row-info {
            flex: 1;
            display: flex;
            flex-direction: column;
            gap: 4px;
        }

        .row-title {
            font-size: 15px;
            font-weight: 600;
            color: var(--text-dark);
            margin-bottom: 0;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .row-title i {
            color: var(--primary-maroon);
            font-size: 14px;
            width: 20px;
        }

        .row-description {
            color: var(--muted-text);
            font-size: 13px;
            font-weight: 400;
            line-height: 1.5;
            max-width: 600px;
        }

        .toggle-switch {
            position: relative;
            display: inline-block;
            width: 54px;
            height: 28px;
        }

        .toggle-switch input {
            opacity: 0;
            width: 0;
            height: 0;
        }

        .toggle-slider {
            position: absolute;
            cursor: pointer;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: var(--border-light);
            border-radius: 34px;
            transition: var(--transition-base);
            border: 2px solid transparent;
        }

        .toggle-slider:before {
            position: absolute;
            content: "";
            height: 20px;
            width: 20px;
            left: 3px;
            bottom: 2px;
            background-color: white;
            border-radius: 50%;
            transition: var(--transition-base);
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
        }

        .toggle-switch input:checked + .toggle-slider {
            background-color: var(--success-green);
            border-color: var(--success-green);
        }

        .toggle-switch input:checked + .toggle-slider:before {
            transform: translateX(26px);
        }

        .toggle-switch input:focus + .toggle-slider {
            box-shadow: 0 0 0 3px rgba(107, 13, 30, 0.1);
        }

        .toggle-switch input:disabled + .toggle-slider {
            opacity: 0.5;
            cursor: not-allowed;
        }

        .toggle-status {
            font-size: 12px;
            font-weight: 600;
            margin-left: 10px;
            color: var(--muted-text);
        }

        .toggle-switch input:checked ~ .toggle-status {
            color: var(--success-green);
        }

        .action-buttons {
            display: flex;
            gap: 15px;
            margin-top: 30px;
            padding-top: 25px;
            border-top: 1px solid var(--border-light);
        }

        .btn-save {
            background: var(--primary-maroon);
            color: white;
            border: none;
            padding: 12px 28px;
            border-radius: var(--radius-md);
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            font-family: 'Poppins', sans-serif;
            transition: all var(--transition-base);
            box-shadow: var(--button-shadow);
            display: flex;
            align-items: center;
            gap: 8px;
            letter-spacing: 0.3px;
        }

        .btn-save:hover {
            background: var(--primary-maroon-dark);
            transform: translateY(-2px);
            box-shadow: var(--button-shadow-hover);
        }

        .btn-save:disabled {
            opacity: 0.6;
            cursor: not-allowed;
            transform: none;
        }

        .btn-reset {
            background: transparent;
            color: var(--muted-text);
            border: 1px solid var(--border-light);
            padding: 12px 24px;
            border-radius: var(--radius-md);
            cursor: pointer;
            font-family: 'Poppins', sans-serif;
            font-size: 14px;
            font-weight: 500;
            transition: all var(--transition-base);
        }

        .btn-reset:hover {
            border-color: var(--primary-maroon);
            color: var(--primary-maroon);
        }

        .confirmation-modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 1000;
            justify-content: center;
            align-items: center;
            animation: fadeIn 0.3s ease;
        }

        .modal-content {
            background: white;
            padding: 30px;
            border-radius: var(--radius-xl);
            width: 90%;
            max-width: 450px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            animation: slideUp 0.3s ease;
        }

        .modal-header {
            margin-bottom: 20px;
            text-align: center;
        }

        .modal-icon {
            font-size: 48px;
            color: var(--warning-orange);
            margin-bottom: 15px;
        }

        .modal-title {
            font-size: 20px;
            color: var(--text-dark);
            font-weight: 600;
            margin-bottom: 8px;
        }

        .modal-message {
            color: var(--muted-text);
            font-size: 14px;
            line-height: 1.5;
        }

        .modal-actions {
            display: flex;
            gap: 15px;
            margin-top: 25px;
        }

        .btn-modal-confirm {
            flex: 1;
            background: var(--primary-maroon);
            color: white;
            border: none;
            padding: 12px;
            border-radius: var(--radius-md);
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            font-family: 'Poppins', sans-serif;
            transition: all var(--transition-base);
        }

        .btn-modal-confirm:hover {
            background: var(--primary-maroon-dark);
        }

        .btn-modal-cancel {
            flex: 1;
            background: transparent;
            color: var(--muted-text);
            border: 1px solid var(--border-light);
            padding: 12px;
            border-radius: var(--radius-md);
            cursor: pointer;
            font-size: 14px;
            font-weight: 500;
            font-family: 'Poppins', sans-serif;
            transition: all var(--transition-base);
        }

        .btn-modal-cancel:hover {
            border-color: var(--primary-maroon);
            color: var(--primary-maroon);
        }

        .toast-notification {
            position: fixed;
            top: 20px;
            right: 20px;
            padding: 15px 20px;
            border-radius: var(--radius-md);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
            z-index: 999;
            display: flex;
            align-items: center;
            gap: 12px;
            max-width: 350px;
            animation: slideInRight 0.3s ease;
            transform: translateX(0);
        }

        .toast-success {
            background: var(--success-green);
            color: white;
        }

        .toast-warning {
            background: var(--warning-orange);
            color: white;
        }

        .toast-info {
            background: var(--accent-blue-dark);
            color: white;
        }

        .toast-error {
            background: var(--danger-red);
            color: white;
        }

        .toast-icon {
            font-size: 18px;
        }

        .toast-message {
            flex: 1;
            font-size: 14px;
        }

        .toast-close {
            background: transparent;
            border: none;
            color: white;
            cursor: pointer;
            opacity: 0.8;
            transition: opacity var(--transition-fast);
        }

        .toast-close:hover {
            opacity: 1;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        @keyframes slideUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes slideInRight {
            from { transform: translateX(100%); opacity: 0; }
            to { transform: translateX(0); opacity: 1; }
        }

        @keyframes slideOutRight {
            from { transform: translateX(0); opacity: 1; }
            to { transform: translateX(100%); opacity: 0; }
        }

        @media (max-width: 992px) {
            .settings-wrapper {
                padding: 20px;
            }
            
            .page-header-main {
                flex-direction: column;
                align-items: stretch;
                gap: 15px;
            }
            
            .header-title h1 {
                font-size: 24px;
            }
            
            .settings-card {
                padding: 22px;
            }
            
            .modal-content {
                padding: 25px;
                max-width: 400px;
            }
        }

        @media (max-width: 768px) {
            .settings-wrapper {
                padding: 15px;
            }
            
            .settings-row {
                flex-direction: column;
                align-items: stretch;
                gap: 15px;
                padding: 16px;
            }
            
            .row-info {
                margin-bottom: 5px;
            }
            
            .toggle-switch {
                align-self: flex-start;
            }
            
            .action-buttons {
                flex-direction: column;
            }
            
            .btn-save, .btn-reset {
                width: 100%;
                justify-content: center;
            }
            
            .modal-content {
                padding: 20px;
                margin: 15px;
            }
            
            .modal-actions {
                flex-direction: column;
            }
        }

        @media (max-width: 480px) {
            .settings-wrapper {
                padding: 12px;
            }
            
            .settings-card {
                padding: 18px;
                border-radius: var(--radius-lg);
            }
            
            .section-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 10px;
            }
            
            .section-title {
                font-size: 16px;
            }
            
            .section-title i {
                width: 32px;
                height: 32px;
                font-size: 14px;
            }
            
            .toast-notification {
                left: 15px;
                right: 15px;
                max-width: none;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="settings-wrapper">
        <div class="page-header-main">
            <div class="header-title">
                <h1>Settings & Preferences</h1>
                <p>Manage your notification preferences and account settings</p>
            </div>
        </div>

        <div class="settings-grid">
            <div class="settings-card">
                <div class="section-header">
                    <div>
                        <h3 class="section-title">
                            <i class="fas fa-bell"></i>
                            Notification Preferences
                        </h3>
                        <p class="section-subtitle">Control how you receive updates and alerts from the system</p>
                    </div>
                </div>
                
                <div class="settings-list">
                    <div class="settings-row">
                        <div class="row-info">
                            <div class="row-title">
                                <i class="fas fa-mobile-alt"></i>
                                Push Notifications
                            </div>
                            <p class="row-description">
                                Receive instant delivery updates, new order alerts, and system notifications on your device
                            </p>
                        </div>
                        <div>
                            <label class="toggle-switch" data-setting="push_notifications">
                                <input type="checkbox" checked />
                                <span class="toggle-slider"></span>
                                <span class="toggle-status">ON</span>
                            </label>
                        </div>
                    </div>
                    
                    <div class="settings-row">
                        <div class="row-info">
                            <div class="row-title">
                                <i class="fas fa-envelope"></i>
                                Email Notifications
                            </div>
                            <p class="row-description">
                                Get weekly earnings reports, promo updates, and important announcements via email
                            </p>
                        </div>
                        <div>
                            <label class="toggle-switch" data-setting="email_notifications">
                                <input type="checkbox" checked />
                                <span class="toggle-slider"></span>
                                <span class="toggle-status">ON</span>
                            </label>
                        </div>
                    </div>
                    
                    <div class="settings-row">
                        <div class="row-info">
                            <div class="row-title">
                                <i class="fas fa-sms"></i>
                                SMS Notifications
                            </div>
                            <p class="row-description">
                                Receive text message alerts for urgent delivery updates and verification codes
                            </p>
                        </div>
                        <div>
                            <label class="toggle-switch" data-setting="sms_notifications">
                                <input type="checkbox" />
                                <span class="toggle-slider"></span>
                                <span class="toggle-status">OFF</span>
                            </label>
                        </div>
                    </div>
                    
                    <div class="settings-row">
                        <div class="row-info">
                            <div class="row-title">
                                <i class="fas fa-volume-up"></i>
                                Sound Alerts
                            </div>
                            <p class="row-description">
                                Play notification sounds for new orders and important alerts
                            </p>
                        </div>
                        <div>
                            <label class="toggle-switch" data-setting="sound_notifications">
                                <input type="checkbox" checked />
                                <span class="toggle-slider"></span>
                                <span class="toggle-status">ON</span>
                            </label>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="settings-card">
                <div class="section-header">
                    <div>
                        <h3 class="section-title">
                            <i class="fas fa-shield-alt"></i>
                            Privacy & Security
                        </h3>
                        <p class="section-subtitle">Manage your privacy settings and data preferences</p>
                    </div>
                </div>
                
                <div class="settings-list">
                    <div class="settings-row">
                        <div class="row-info">
                            <div class="row-title">
                                <i class="fas fa-map-marker-alt"></i>
                                Real-time Location Sharing
                            </div>
                            <p class="row-description">
                                Share your location during active deliveries for better customer tracking
                            </p>
                        </div>
                        <div>
                            <label class="toggle-switch" data-setting="location_sharing">
                                <input type="checkbox" checked />
                                <span class="toggle-slider"></span>
                                <span class="toggle-status">ON</span>
                            </label>
                        </div>
                    </div>
                    
                    <div class="settings-row">
                        <div class="row-info">
                            <div class="row-title">
                                <i class="fas fa-database"></i>
                                Performance Data Collection
                            </div>
                            <p class="row-description">
                                Allow collection of delivery data to improve your experience and earn bonuses
                            </p>
                        </div>
                        <div>
                            <label class="toggle-switch" data-setting="data_collection">
                                <input type="checkbox" checked />
                                <span class="toggle-slider"></span>
                                <span class="toggle-status">ON</span>
                            </label>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="settings-card">
                <div class="section-header">
                    <div>
                        <h3 class="section-title">
                            <i class="fas fa-cog"></i>
                            App Settings
                        </h3>
                        <p class="section-subtitle">Customize your app experience and display preferences</p>
                    </div>
                </div>
                
                <div class="settings-list">
                    <div class="settings-row">
                        <div class="row-info">
                            <div class="row-title">
                                <i class="fas fa-bolt"></i>
                                Quick Accept
                            </div>
                            <p class="row-description">
                                Automatically accept deliveries within your preferred range and price
                            </p>
                        </div>
                        <div>
                            <label class="toggle-switch" data-setting="auto_accept">
                                <input type="checkbox" />
                                <span class="toggle-slider"></span>
                                <span class="toggle-status">OFF</span>
                            </label>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="action-buttons">
            <button type="button" class="btn-save" id="saveSettings">
                <i class="fas fa-save"></i>
                Save Changes
            </button>
            <button type="button" class="btn-reset" id="resetSettings">
                Reset to Default
            </button>
        </div>
    </div>

    <div class="confirmation-modal" id="confirmationModal">
        <div class="modal-content">
            <div class="modal-header">
                <div class="modal-icon">
                    <i class="fas fa-exclamation-triangle"></i>
                </div>
                <h3 class="modal-title">Reset Settings?</h3>
                <p class="modal-message">Are you sure you want to reset all settings to their default values? This action cannot be undone.</p>
            </div>
            <div class="modal-actions">
                <button type="button" class="btn-modal-cancel" id="modalCancel">Cancel</button>
                <button type="button" class="btn-modal-confirm" id="modalConfirm">Reset Settings</button>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            console.log('Settings page loaded');

            const saveButton = document.getElementById('saveSettings');
            const resetButton = document.getElementById('resetSettings');
            const toggleSwitches = document.querySelectorAll('.toggle-switch input');
            const confirmationModal = document.getElementById('confirmationModal');
            const modalCancel = document.getElementById('modalCancel');
            const modalConfirm = document.getElementById('modalConfirm');

            let hasChanges = false;
            const originalState = {};

            toggleSwitches.forEach(switchEl => {
                const settingName = switchEl.closest('.toggle-switch').getAttribute('data-setting');
                originalState[settingName] = switchEl.checked;
            });

            toggleSwitches.forEach(switchEl => {
                switchEl.addEventListener('change', function () {
                    const toggleSwitch = this.closest('.toggle-switch');
                    const settingName = toggleSwitch.getAttribute('data-setting');
                    const statusSpan = toggleSwitch.querySelector('.toggle-status');

                    statusSpan.textContent = this.checked ? 'ON' : 'OFF';
                    statusSpan.style.color = this.checked ? 'var(--success-green)' : 'var(--muted-text)';

                    checkForChanges();

                    showToast(`${toggleSwitch.closest('.row-title').textContent.trim()} ${this.checked ? 'enabled' : 'disabled'}`, 'info');
                });
            });

            function checkForChanges() {
                hasChanges = false;

                toggleSwitches.forEach(switchEl => {
                    const settingName = switchEl.closest('.toggle-switch').getAttribute('data-setting');
                    if (originalState[settingName] !== switchEl.checked) {
                        hasChanges = true;
                    }
                });

                saveButton.disabled = !hasChanges;
                saveButton.style.opacity = hasChanges ? '1' : '0.6';
            }

            if (saveButton) {
                saveButton.addEventListener('click', function () {
                    if (!hasChanges) return;

                    const originalText = saveButton.innerHTML;
                    saveButton.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Saving...';
                    saveButton.disabled = true;

                    const settings = {};
                    toggleSwitches.forEach(switchEl => {
                        const settingName = switchEl.closest('.toggle-switch').getAttribute('data-setting');
                        settings[settingName] = switchEl.checked;
                    });

                    console.log('Saving settings:', settings);

                    setTimeout(() => {
                        Object.keys(settings).forEach(key => {
                            originalState[key] = settings[key];
                        });

                        hasChanges = false;
                        saveButton.disabled = true;
                        saveButton.style.opacity = '0.6';
                        saveButton.innerHTML = originalText;

                        showToast('Settings saved successfully!', 'success');

                    }, 800);
                });
            }

            if (resetButton) {
                resetButton.addEventListener('click', function () {
                    showConfirmationModal();
                });
            }

            function showConfirmationModal() {
                confirmationModal.style.display = 'flex';
            }

            function hideConfirmationModal() {
                confirmationModal.style.display = 'none';
            }

            if (modalCancel) {
                modalCancel.addEventListener('click', hideConfirmationModal);
            }

            if (modalConfirm) {
                modalConfirm.addEventListener('click', function () {
                    hideConfirmationModal();
                    performReset();
                });
            }

            confirmationModal.addEventListener('click', function (e) {
                if (e.target === confirmationModal) {
                    hideConfirmationModal();
                }
            });

            function performReset() {
                showToast('Resetting settings...', 'info');

                toggleSwitches.forEach(switchEl => {
                    const settingName = switchEl.closest('.toggle-switch').getAttribute('data-setting');
                    const statusSpan = switchEl.closest('.toggle-switch').querySelector('.toggle-status');

                    const defaultValue = !['sms_notifications', 'auto_accept'].includes(settingName);
                    switchEl.checked = defaultValue;
                    statusSpan.textContent = defaultValue ? 'ON' : 'OFF';
                    statusSpan.style.color = defaultValue ? 'var(--success-green)' : 'var(--muted-text)';
                });

                toggleSwitches.forEach(switchEl => {
                    const settingName = switchEl.closest('.toggle-switch').getAttribute('data-setting');
                    originalState[settingName] = switchEl.checked;
                });

                checkForChanges();
                showToast('Settings reset to default values successfully!', 'success');
            }

            function showToast(message, type = 'info', duration = 4000) {
                const toast = document.createElement('div');
                toast.className = `toast-notification toast-${type}`;

                const icons = {
                    success: 'fa-check-circle',
                    warning: 'fa-exclamation-triangle',
                    info: 'fa-info-circle',
                    error: 'fa-exclamation-circle'
                };

                toast.innerHTML = `
                    <i class="fas ${icons[type] || 'fa-info-circle'} toast-icon"></i>
                    <span class="toast-message">${message}</span>
                    <button class="toast-close">
                        <i class="fas fa-times"></i>
                    </button>
                `;

                document.body.appendChild(toast);

                const closeBtn = toast.querySelector('.toast-close');
                closeBtn.addEventListener('click', function () {
                    removeToast(toast);
                });

                setTimeout(() => {
                    removeToast(toast);
                }, duration);

                const allToasts = document.querySelectorAll('.toast-notification');
                if (allToasts.length > 3) {
                    removeToast(allToasts[0]);
                }
            }

            function removeToast(toast) {
                toast.style.animation = 'slideOutRight 0.3s ease';
                setTimeout(() => {
                    if (toast.parentNode) {
                        document.body.removeChild(toast);
                    }
                }, 300);
            }

            checkForChanges();
        });
    </script>
</asp:Content>