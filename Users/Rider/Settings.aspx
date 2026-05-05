<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Rider.Master" AutoEventWireup="true" CodeBehind="Settings.aspx.cs" Inherits="TasteNet.Users.Rider.settings" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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
            --danger-red: #b91c1c;
            --danger-red-light: #fee2e2;
            --accent-pink: #f9ecee;
            --accent-blue: #eff6ff;
            --accent-blue-dark: #3b82f6;
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

        .settings-wrapper {
            background: var(--soft-cream) !important;
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

        /* Settings Grid */
        .settings-grid {
            display: grid;
            grid-template-columns: 1fr;
            gap: 25px;
            margin-bottom: 30px;
        }

        /* Settings Card - matching dashboard card style */
        .settings-card {
            background: white;
            padding: 25px;
            border-radius: var(--radius-xl);
            box-shadow: var(--card-shadow);
            transition: all var(--transition-base);
            border: 1px solid var(--border-light);
            animation: fadeIn 0.5s ease-out;
        }

        .settings-card:hover {
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
            gap: 12px;
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

        .section-subtitle {
            font-size: 13px;
            color: var(--muted-text);
            font-weight: 400;
            margin-top: 6px;
        }

        /* Settings List */
        .settings-list {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        /* Settings Row - matching dashboard row style */
        .settings-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 16px 20px;
            border-radius: var(--radius-lg);
            background: var(--bg-lighter);
            transition: all var(--transition-base);
        }

        .settings-row:hover {
            background: var(--bg-hover);
            transform: translateX(5px);
        }

        .row-info {
            flex: 1;
        }

        .row-title {
            font-size: 15px;
            font-weight: 600;
            color: var(--text-dark);
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 4px;
        }

        .row-title i {
            color: var(--primary-maroon);
            font-size: 14px;
            width: 20px;
        }

        .row-description {
            color: var(--muted-text);
            font-size: 12px;
            line-height: 1.4;
            max-width: 500px;
        }

        /* Toggle Switch - matching dashboard style */
        .toggle-switch {
            position: relative;
            display: inline-block;
            width: 52px;
            height: 26px;
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
        }

        .toggle-slider:before {
            position: absolute;
            content: "";
            height: 20px;
            width: 20px;
            left: 3px;
            bottom: 3px;
            background-color: white;
            border-radius: 50%;
            transition: var(--transition-base);
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .toggle-switch input:checked + .toggle-slider {
            background-color: var(--success-green);
        }

        .toggle-switch input:checked + .toggle-slider:before {
            transform: translateX(26px);
        }

        .toggle-status {
            font-size: 11px;
            font-weight: 600;
            margin-left: 12px;
            color: var(--muted-text);
        }

        .toggle-switch input:checked ~ .toggle-status {
            color: var(--success-green);
        }

        /* Action Buttons - matching dashboard button style */
        .action-buttons {
            display: flex;
            gap: 15px;
            margin-top: 10px;
            padding-top: 20px;
            border-top: 1px solid var(--border-light);
        }

        .btn-save {
            background: var(--primary-maroon);
            color: white;
            border: none;
            padding: 12px 28px;
            border-radius: var(--radius-md);
            cursor: pointer;
            font-size: 13px;
            font-weight: 600;
            font-family: 'Poppins', sans-serif;
            transition: all var(--transition-base);
            box-shadow: var(--button-shadow);
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .btn-save:hover:not(:disabled) {
            background: var(--primary-maroon-dark);
            transform: translateY(-2px);
        }

        .btn-save:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }

        .btn-reset {
            background: transparent;
            color: var(--muted-text);
            border: 1px solid var(--border-light);
            padding: 12px 24px;
            border-radius: var(--radius-md);
            cursor: pointer;
            font-size: 13px;
            font-weight: 500;
            font-family: 'Poppins', sans-serif;
            transition: all var(--transition-base);
        }

        .btn-reset:hover {
            border-color: var(--primary-maroon);
            color: var(--primary-maroon);
            background: var(--accent-pink);
        }

        /* Modal - matching dashboard style */
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
            backdrop-filter: blur(3px);
        }

        .modal-content {
            background: white;
            padding: 30px;
            border-radius: var(--radius-xl);
            width: 90%;
            max-width: 420px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            border: 1px solid var(--border-light);
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
            margin-bottom: 10px;
        }

        .modal-message {
            color: var(--muted-text);
            font-size: 13px;
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
            font-size: 13px;
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
            font-size: 13px;
            font-weight: 500;
            font-family: 'Poppins', sans-serif;
            transition: all var(--transition-base);
        }

        .btn-modal-cancel:hover {
            border-color: var(--primary-maroon);
            color: var(--primary-maroon);
        }

        /* Toast Notifications */
        .toast-notification {
            position: fixed;
            top: 20px;
            right: 20px;
            padding: 14px 20px;
            border-radius: var(--radius-lg);
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.15);
            z-index: 1001;
            display: flex;
            align-items: center;
            gap: 12px;
            max-width: 350px;
            animation: slideInRight 0.3s ease;
        }

        .toast-success {
            background: var(--success-green);
            color: white;
        }

        .toast-info {
            background: var(--accent-blue-dark);
            color: white;
        }

        .toast-warning {
            background: var(--warning-orange);
            color: white;
        }

        .toast-message {
            flex: 1;
            font-size: 13px;
        }

        .toast-close {
            background: transparent;
            border: none;
            color: white;
            cursor: pointer;
            opacity: 0.8;
            transition: opacity var(--transition-base);
        }

        .toast-close:hover {
            opacity: 1;
        }

        /* Animations */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
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

        /* Responsive - matching dashboard */
        @media (max-width: 992px) {
            .settings-wrapper {
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
        }

        @media (max-width: 768px) {
            .settings-wrapper {
                padding: 15px;
            }
            
            .settings-card {
                padding: 20px;
            }
            
            .settings-row {
                flex-direction: column;
                align-items: stretch;
                gap: 12px;
                padding: 16px;
            }
            
            .row-info {
                margin-bottom: 4px;
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
        }

        @media (max-width: 480px) {
            .settings-wrapper {
                padding: 12px;
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
        <div class="page-header">
            <div class="header-title">
                <h1>Settings & Preferences</h1>
                <p>Manage your notification preferences and account settings</p>
            </div>
        </div>

        <div class="settings-grid">
            <!-- Notification Preferences Card -->
            <div class="settings-card">
                <div class="section-header">
                    <div>
                        <h3 class="section-title">
                            <i class="fas fa-bell"></i>
                            Notification Preferences
                        </h3>
                        <div class="section-subtitle">Control how you receive updates and alerts from the system</div>
                    </div>
                </div>
                
                <div class="settings-list">
                    <div class="settings-row">
                        <div class="row-info">
                            <div class="row-title">
                                <i class="fas fa-mobile-alt"></i>
                                Push Notifications
                            </div>
                            <div class="row-description">Receive instant delivery updates, new order alerts, and system notifications on your device</div>
                        </div>
                        <div>
                            <label class="toggle-switch" data-setting="push_notifications">
                                <input type="checkbox" checked>
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
                            <div class="row-description">Get weekly earnings reports, promo updates, and important announcements via email</div>
                        </div>
                        <div>
                            <label class="toggle-switch" data-setting="email_notifications">
                                <input type="checkbox" checked>
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
                            <div class="row-description">Receive text message alerts for urgent delivery updates and verification codes</div>
                        </div>
                        <div>
                            <label class="toggle-switch" data-setting="sms_notifications">
                                <input type="checkbox">
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
                            <div class="row-description">Play notification sounds for new orders and important alerts</div>
                        </div>
                        <div>
                            <label class="toggle-switch" data-setting="sound_alerts">
                                <input type="checkbox" checked>
                                <span class="toggle-slider"></span>
                                <span class="toggle-status">ON</span>
                            </label>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Privacy & Security Card -->
            <div class="settings-card">
                <div class="section-header">
                    <div>
                        <h3 class="section-title">
                            <i class="fas fa-shield-alt"></i>
                            Privacy & Security
                        </h3>
                        <div class="section-subtitle">Manage your privacy settings and data preferences</div>
                    </div>
                </div>
                
                <div class="settings-list">
                    <div class="settings-row">
                        <div class="row-info">
                            <div class="row-title">
                                <i class="fas fa-map-marker-alt"></i>
                                Real-time Location Sharing
                            </div>
                            <div class="row-description">Share your location during active deliveries for better customer tracking</div>
                        </div>
                        <div>
                            <label class="toggle-switch" data-setting="location_sharing">
                                <input type="checkbox" checked>
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
                            <div class="row-description">Allow collection of delivery data to improve your experience and earn bonuses</div>
                        </div>
                        <div>
                            <label class="toggle-switch" data-setting="data_collection">
                                <input type="checkbox" checked>
                                <span class="toggle-slider"></span>
                                <span class="toggle-status">ON</span>
                            </label>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- App Settings Card -->
            <div class="settings-card">
                <div class="section-header">
                    <div>
                        <h3 class="section-title">
                            <i class="fas fa-cog"></i>
                            App Settings
                        </h3>
                        <div class="section-subtitle">Customize your app experience and display preferences</div>
                    </div>
                </div>
                
                <div class="settings-list">
                    <div class="settings-row">
                        <div class="row-info">
                            <div class="row-title">
                                <i class="fas fa-bolt"></i>
                                Quick Accept
                            </div>
                            <div class="row-description">Automatically accept deliveries within your preferred range and price</div>
                        </div>
                        <div>
                            <label class="toggle-switch" data-setting="quick_accept">
                                <input type="checkbox">
                                <span class="toggle-slider"></span>
                                <span class="toggle-status">OFF</span>
                            </label>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Action Buttons -->
        <div class="action-buttons">
            <button type="button" class="btn-save" id="saveSettings">
                <i class="fas fa-save"></i> Save Changes
            </button>
            <button type="button" class="btn-reset" id="resetSettings">
                <i class="fas fa-undo-alt"></i> Reset to Default
            </button>
        </div>
    </div>

    <!-- Confirmation Modal -->
    <div class="confirmation-modal" id="confirmationModal">
        <div class="modal-content">
            <div class="modal-icon">
                <i class="fas fa-exclamation-triangle"></i>
            </div>
            <h3 class="modal-title">Reset Settings?</h3>
            <p class="modal-message">Are you sure you want to reset all settings to their default values? This action cannot be undone.</p>
            <div class="modal-actions">
                <button type="button" class="btn-modal-cancel" id="modalCancel">Cancel</button>
                <button type="button" class="btn-modal-confirm" id="modalConfirm">Reset Settings</button>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const saveButton = document.getElementById('saveSettings');
            const resetButton = document.getElementById('resetSettings');
            const toggleSwitches = document.querySelectorAll('.toggle-switch input');
            const confirmationModal = document.getElementById('confirmationModal');
            const modalCancel = document.getElementById('modalCancel');
            const modalConfirm = document.getElementById('modalConfirm');

            let hasChanges = false;
            const originalState = {};

            // Store original state
            toggleSwitches.forEach(switchEl => {
                const settingName = switchEl.closest('.toggle-switch').getAttribute('data-setting');
                originalState[settingName] = switchEl.checked;
                updateToggleStatus(switchEl);
            });

            // Update toggle status text
            function updateToggleStatus(switchEl) {
                const toggleSwitch = switchEl.closest('.toggle-switch');
                const statusSpan = toggleSwitch.querySelector('.toggle-status');
                if (statusSpan) {
                    statusSpan.textContent = switchEl.checked ? 'ON' : 'OFF';
                }
            }

            // Check for changes
            function checkForChanges() {
                hasChanges = false;
                toggleSwitches.forEach(switchEl => {
                    const settingName = switchEl.closest('.toggle-switch').getAttribute('data-setting');
                    if (originalState[settingName] !== switchEl.checked) {
                        hasChanges = true;
                    }
                });
                if (saveButton) {
                    saveButton.disabled = !hasChanges;
                }
            }

            // Toggle change handler
            toggleSwitches.forEach(switchEl => {
                switchEl.addEventListener('change', function () {
                    updateToggleStatus(this);
                    checkForChanges();

                    const title = this.closest('.settings-row')?.querySelector('.row-title')?.textContent?.trim() || 'Setting';
                    showToast(`${title} ${this.checked ? 'enabled' : 'disabled'}`, 'info');
                });
            });

            // Save settings
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
                        saveButton.innerHTML = originalText;
                        showToast('Settings saved successfully!', 'success');
                    }, 800);
                });
            }

            // Show confirmation modal
            if (resetButton) {
                resetButton.addEventListener('click', function () {
                    confirmationModal.style.display = 'flex';
                    document.body.style.overflow = 'hidden';
                });
            }

            // Hide modal
            function hideModal() {
                confirmationModal.style.display = 'none';
                document.body.style.overflow = '';
            }

            if (modalCancel) {
                modalCancel.addEventListener('click', hideModal);
            }

            if (modalConfirm) {
                modalConfirm.addEventListener('click', function () {
                    hideModal();
                    resetToDefaults();
                });
            }

            // Close modal when clicking outside
            confirmationModal.addEventListener('click', function (e) {
                if (e.target === confirmationModal) {
                    hideModal();
                }
            });

            // Escape key closes modal
            document.addEventListener('keydown', function (e) {
                if (e.key === 'Escape' && confirmationModal.style.display === 'flex') {
                    hideModal();
                }
            });

            // Reset to defaults
            function resetToDefaults() {
                showToast('Resetting settings...', 'info');

                toggleSwitches.forEach(switchEl => {
                    const settingName = switchEl.closest('.toggle-switch').getAttribute('data-setting');
                    const defaultValue = !['sms_notifications', 'quick_accept'].includes(settingName);
                    switchEl.checked = defaultValue;
                    updateToggleStatus(switchEl);
                });

                toggleSwitches.forEach(switchEl => {
                    const settingName = switchEl.closest('.toggle-switch').getAttribute('data-setting');
                    originalState[settingName] = switchEl.checked;
                });

                checkForChanges();
                showToast('Settings reset to default values!', 'success');
            }

            // Toast notification
            function showToast(message, type = 'info', duration = 3000) {
                const existingToasts = document.querySelectorAll('.toast-notification');
                existingToasts.forEach(toast => {
                    toast.style.animation = 'slideOutRight 0.3s ease';
                    setTimeout(() => toast.remove(), 300);
                });

                const toast = document.createElement('div');
                toast.className = `toast-notification toast-${type}`;
                toast.innerHTML = `
                    <i class="fas ${type === 'success' ? 'fa-check-circle' : type === 'info' ? 'fa-info-circle' : 'fa-exclamation-triangle'}"></i>
                    <span class="toast-message">${message}</span>
                    <button class="toast-close"><i class="fas fa-times"></i></button>
                `;

                document.body.appendChild(toast);

                const closeBtn = toast.querySelector('.toast-close');
                closeBtn.addEventListener('click', () => {
                    toast.style.animation = 'slideOutRight 0.3s ease';
                    setTimeout(() => toast.remove(), 300);
                });

                setTimeout(() => {
                    if (toast.parentNode) {
                        toast.style.animation = 'slideOutRight 0.3s ease';
                        setTimeout(() => toast.remove(), 300);
                    }
                }, duration);
            }

            // Initial check
            checkForChanges();
        });
    </script>
</asp:Content>