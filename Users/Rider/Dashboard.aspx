<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Rider.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="TasteNet.Users.Rider.Dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        
        html, body, form {
         margin: 0;
         padding: 0;
         background: #fffaf3;
         font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

/* ===== CENTERED PAGE WRAPPER ===== */
        .history-container {
         max-width: 1200px;        /* 🔥 controls UI size */
         margin: 0 auto;           /* 🔥 center horizontally */
         padding: 24px 20px;
       }

/* ===== HEADER ===== */
         .page-header {
          display: flex;
          justify-content: space-between;
          align-items: center;
          margin-bottom: 18px;
          color :#ffffff;
         }

        .page-header h2 {
            font-size: 20px;
            font-weight: 600;
            margin: 0;
        }
        :root {
            --primary-dark: #1a1a1a;         /* Sidebar color */
            --primary-maroon: #8b0000;       /* Main brand color (from TasteNet) */
            --primary-maroon-dark: #660000;  /* Darker maroon */
            --background-light: #f5f5f5;     /* Page background */
            --card-white: #ffffff;           /* Card background */
            --text-dark: #333333;            /* Main text */
            --text-muted: #666666;           /* Secondary text */
            --text-light: #888888;           /* Tertiary text */
            --success-green: #28a745;        /* Success/positive */
            --warning-orange: #ff9800;       /* Warning/alert */
            --danger-red: #dc3545;           /* Danger/error */
            --border-color: #e0e0e0;         /* Borders */
            --sidebar-hover: #2a2a2a;        /* Sidebar hover */
            --card-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
            --card-shadow-hover: 0 4px 12px rgba(0, 0, 0, 0.12);
            --radius-sm: 8px;
            --radius-md: 12px;
            --radius-lg: 16px;
        }

        body {
            background-color: var(--background-light) !important;
            font-family: 'Poppins', sans-serif;
            color: var(--text-dark);
        }

        /* Main Container */
        .dashboard-container {
            padding: 20px 30px;
            max-width: 100%;
            margin: 0 auto;
            background: #fffaf3;
        }

        /* Top Bar - Simpler, cleaner version */
        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 1px solid var(--border-color);
        }

        .top-bar h1 {
            font-size: 24px;
            color: var(--primary-maroon);
            font-weight: 600;
            margin: 0;
        }

        .top-actions {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .notification-icon {
            position: relative;
            width: 40px;
            height: 40px;
            background: var(--card-white);
            border-radius: var(--radius-md);
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            box-shadow: var(--card-shadow);
            color: var(--text-muted);
            border: 1px solid var(--border-color);
        }

        .notification-badge {
            position: absolute;
            top: -5px;
            right: -5px;
            background: var(--danger-red);
            color: white;
            border-radius: 50%;
            width: 18px;
            height: 18px;
            font-size: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
            border: 2px solid var(--card-white);
        }

        /* Status Card - Cleaner design */
        .status-card {
            background: var(--card-white);
            border-radius: 12px;
            padding: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: var(--card-shadow);
            margin-bottom: 25px;
            border: 1px solid var(--border-color);
        }

        .status-info strong {
            font-size: 16px;
            display: block;
            color: var(--text-dark);
            font-weight: 600;
            margin-bottom: 4px;
        }

        .status-info small {
            color: var(--text-light);
            font-size: 13px;
            font-weight: 400;
        }

        /* Toggle Switch - Clean version */
        .toggle-switch {
            width: 60px;
            height: 28px;
            background-color: #e0e0e0;
            border-radius: 14px;
            position: relative;
            cursor: pointer;
            transition: all 0.2s ease;
            border: 1px solid #d0d0d0;
        }

        .toggle-switch.active {
            background-color: var(--success-green);
            border-color: var(--success-green);
        }

        .toggle-knob {
            width: 22px;
            height: 22px;
            background: white;
            border-radius: 50%;
            position: absolute;
            top: 2px;
            left: 3px;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 1px 3px rgba(0,0,0,0.2);
            transition: all 0.2s ease;
        }

        .toggle-switch.active .toggle-knob {
            left: calc(100% - 25px);
        }

        .toggle-knob i {
            font-size: 9px;
            color: #999;
        }

        .toggle-switch.active .toggle-knob i {
            color: var(--success-green);
        }

        /* Stats Grid - Clean cards */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            margin-bottom: 25px;
        }

        .stat-card {
            background: var(--card-white);
            border-radius: var(--radius-lg);
            padding: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: var(--card-shadow);
            border: 1px solid var(--border-color);
            transition: all 0.2s ease;
        }

        .stat-card:hover {
            box-shadow: var(--card-shadow-hover);
            transform: translateY(-2px);
        }

        .stat-label {
            font-size: 13px;
            color: var(--text-light);
            margin-bottom: 6px;
            font-weight: 400;
        }

        .stat-value {
            font-size: 28px;
            font-weight: 600;
            margin: 0;
            color: var(--primary-maroon);
            line-height: 1;
        }

        .icon-circle {
            width: 40px;
            height: 40px;
            border-radius: var(--radius-md);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 16px;
            background: rgba(139, 0, 0, 0.08);
            color: var(--primary-maroon);
        }

        /* Hero Section - When offline */
        .offline-hero {
            background: var(--card-white);
            border-radius: var(--radius-lg);
            padding: 40px 30px;
            text-align: center;
            box-shadow: var(--card-shadow);
            border: 1px solid var(--border-color);
            margin-top: 20px;
        }

        .offline-hero .icon-lg {
            font-size: 48px;
            margin-bottom: 15px;
            display: inline-block;
            width: 80px;
            height: 80px;
            background: rgba(139, 0, 0, 0.08);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            color: var(--primary-maroon);
        }

        .offline-hero h2 {
            font-size: 22px;
            margin: 10px 0;
            color: var(--text-dark);
            font-weight: 600;
        }

        .offline-hero p {
            color: var(--text-muted);
            font-size: 14px;
            margin-bottom: 25px;
            max-width: 400px;
            margin-left: auto;
            margin-right: auto;
            line-height: 1.5;
        }

        .btn-online {
            background: var(--primary-maroon);
            color: white;
            border: none;
            padding: 12px 30px;
            border-radius: var(--radius-md);
            font-weight: 500;
            cursor: pointer;
            font-size: 14px;
            transition: all 0.2s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn-online:hover {
            background: var(--primary-maroon-dark);
            transform: translateY(-1px);
        }

        /* Online Hero Section */
        .online-hero {
            background: linear-gradient(135deg, #ffffff 0%, #f8f9fa 100%);
            border-radius: var(--radius-lg);
            padding: 30px;
            box-shadow: var(--card-shadow);
            border: 1px solid var(--border-color);
            margin-top: 20px;
        }

        .online-hero .icon-lg {
            color: var(--success-green);
            background: rgba(40, 167, 69, 0.1);
        }

        .online-hero h2 {
            color: var(--success-green);
        }

        /* Delivery Cards - When online */
        .deliveries-section {
            margin-top: 25px;
        }

        .section-title {
            font-size: 18px;
            color: var(--text-dark);
            font-weight: 600;
            margin-bottom: 15px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .view-all-link {
            font-size: 13px;
            color: var(--primary-maroon);
            text-decoration: none;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 4px;
        }

        .deliveries-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }

        .delivery-card {
            background: var(--card-white);
            border-radius: var(--radius-lg);
            padding: 20px;
            box-shadow: var(--card-shadow);
            border: 1px solid var(--border-color);
            transition: all 0.2s ease;
        }

        .delivery-card:hover {
            box-shadow: var(--card-shadow-hover);
            transform: translateY(-2px);
        }

        .delivery-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }

        .delivery-id {
            font-size: 14px;
            font-weight: 600;
            color: var(--primary-maroon);
        }

        .delivery-status {
            padding: 4px 10px;
            border-radius: 12px;
            font-size: 11px;
            font-weight: 600;
            text-transform: uppercase;
        }

        .status-pending {
            background: rgba(255, 152, 0, 0.1);
            color: var(--warning-orange);
            border: 1px solid rgba(255, 152, 0, 0.2);
        }

        .status-active {
            background: rgba(40, 167, 69, 0.1);
            color: var(--success-green);
            border: 1px solid rgba(40, 167, 69, 0.2);
        }

        .delivery-info {
            margin: 15px 0;
        }

        .info-row {
            display: flex;
            justify-content: space-between;
            padding: 8px 0;
            border-bottom: 1px solid #f5f5f5;
        }

        .info-label {
            color: var(--text-light);
            font-size: 13px;
        }

        .info-value {
            color: var(--text-dark);
            font-weight: 500;
            font-size: 13px;
        }

        .delivery-actions {
            display: flex;
            gap: 10px;
            margin-top: 15px;
        }

        .btn-action {
            flex: 1;
            padding: 10px;
            border-radius: var(--radius-md);
            border: none;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s ease;
            font-size: 13px;
        }

        .btn-accept {
            background: var(--success-green);
            color: white;
        }

        .btn-accept:hover {
            background: #218838;
        }

        .btn-decline {
            background: rgba(220, 53, 69, 0.1);
            color: var(--danger-red);
            border: 1px solid rgba(220, 53, 69, 0.2);
        }

        .btn-decline:hover {
            background: rgba(220, 53, 69, 0.2);
        }

        .btn-view {
            background: rgba(139, 0, 0, 0.08);
            color: var(--primary-maroon);
        }

        .btn-view:hover {
            background: rgba(139, 0, 0, 0.15);
        }

        /* Responsive Design */
        @media (max-width: 1200px) {
            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
            }
            .deliveries-grid {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 768px) {
            .dashboard-container {
                padding: 15px;
            }
            
            .top-bar {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }
            
            .top-actions {
                width: 100%;
                justify-content: space-between;
            }
            
            .stats-grid {
                grid-template-columns: 1fr;
                gap: 15px;
            }
            
            .status-card {
                flex-direction: column;
                gap: 15px;
                text-align: center;
            }
        }

        @media (max-width: 480px) {
            .btn-online {
                width: 100%;
                justify-content: center;
            }
            
            .delivery-actions {
                flex-direction: column;
            }
        }

        /* Accessibility */
        .btn-online:focus,
        .logout-btn:focus,
        .toggle-switch:focus,
        .btn-action:focus {
            outline: 2px solid var(--primary-maroon);
            outline-offset: 2px;
        }

        /* Status indicators */
        .trend-up {
            color: var(--success-green);
            font-size: 12px;
            font-weight: 500;
        }

        .trend-down {
            color: var(--danger-red);
            font-size: 12px;
            font-weight: 500;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="dashboard-container">
        <!-- Top Bar -->
        <div class="top-bar">
            <h1>Delivery Dashboard</h1>
        </div>

        <!-- Availability Status Card -->
        <div class="status-card">
            <div class="status-info">
                <strong>Availability Status</strong>
                <small id="statusText">You are currently offline</small>
            </div>
            <div class="toggle-switch" id="availabilityToggle">
                <div class="toggle-knob">
                    <i class="fas fa-times"></i>
                </div>
            </div>
        </div>

        <!-- Stats Grid -->
        <div class="stats-grid">
            <div class="stat-card">
                <div>
                    <div class="stat-label">Total Deliveries</div>
                    <div class="stat-value">156</div>
                    <div class="trend-up">↑ +12% from yesterday</div>
                </div>
                <div class="icon-circle">
                    <i class="fas fa-box"></i>
                </div>
            </div>

            <div class="stat-card">
                <div>
                    <div class="stat-label">Earnings Today</div>
                    <div class="stat-value">₱2,450</div>
                    <div class="trend-up">↑ +8% from yesterday</div>
                </div>
                <div class="icon-circle">
                    <i class="fas fa-peso-sign"></i>
                </div>
            </div>

            <div class="stat-card">
                <div>
                    <div class="stat-label">Completed</div>
                    <div class="stat-value">148</div>
                    <div>+23 new today</div>
                </div>
                <div class="icon-circle">
                    <i class="fas fa-check-circle"></i>
                </div>
            </div>

            <div class="stat-card">
                <div>
                    <div class="stat-label">Avg. Time</div>
                    <div class="stat-value">18 min</div>
                    <div>Action required</div>
                </div>
                <div class="icon-circle">
                    <i class="fas fa-clock"></i>
                </div>
            </div>
        </div>

        <!-- Hero Section - Changes based on status -->
        <div class="offline-hero" id="heroSection">
            <div class="icon-lg">
                <i class="fas fa-clock"></i>
            </div>
            <h2 id="heroTitle">You're Offline</h2>
            <p id="heroText">Turn on your availability to start receiving delivery requests</p>
            <button type="button" class="btn-online" id="goOnlineBtn">
                <i class="fas fa-power-off"></i>
                <span id="btnText">Go Online</span>
            </button>
        </div>

        <!-- Deliveries Section (Hidden when offline) -->
        <div class="deliveries-section" id="deliveriesSection" style="display: none;">
            <div class="section-title">
                <span>Available Deliveries</span>
                <a href="#" class="view-all-link">View All <i class="fas fa-arrow-right"></i></a>
            </div>
            
            <div class="deliveries-grid">
                <!-- Delivery Card 1 -->
                <div class="delivery-card">
                    <div class="delivery-header">
                        <span class="delivery-id">#DL-4567</span>
                        <span class="delivery-status status-pending">Pending</span>
                    </div>
                    <div class="delivery-info">
                        <div class="info-row">
                            <span class="info-label">Customer Name:</span>
                            <span class="info-value">Jester Parker</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Delivery:</span>
                            <span class="info-value">2.5 km</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Items:</span>
                            <span class="info-value">3 meals</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Earnings:</span>
                            <span class="info-value" style="color:var(--primary-maroon); font-weight:600;">₱85</span>
                        </div>
                    </div>
                    <div class="delivery-actions">
                        <button type="button" class="btn-action btn-accept">Accept</button>
                        <button type="button" class="btn-action btn-decline">Decline</button>
                    </div>
                </div>

                <!-- Delivery Card 2 -->
                <div class="delivery-card">
                    <div class="delivery-header">
                        <span class="delivery-id">#DL-4568</span>
                        <span class="delivery-status status-active">Active</span>
                    </div>
                    <div class="delivery-info">
                        <div class="info-row">
                            <span class="info-label">Customer Name:</span>
                            <span class="info-value">Syren mukang kambing</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Delivery:</span>
                            <span class="info-value">1.8 km</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Items:</span>
                            <span class="info-value">2 meals</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Earnings:</span>
                            <span class="info-value" style="color:var(--primary-maroon); font-weight:600;">₱65</span>
                        </div>
                    </div>
                    <div class="delivery-actions">
                         <button type="button" class="btn-action btn-accept">Accept</button>
                          <button type="button" class="btn-action btn-decline">Decline</button>
                        </div>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const toggleSwitch = document.getElementById('availabilityToggle');
            const goOnlineBtn = document.getElementById('goOnlineBtn');
            const heroSection = document.getElementById('heroSection');
            const deliveriesSection = document.getElementById('deliveriesSection');
            const statusText = document.getElementById('statusText');
            const heroTitle = document.getElementById('heroTitle');
            const heroText = document.getElementById('heroText');
            const btnText = document.getElementById('btnText');

            let isOnline = false;

            // Toggle switch click handler
            toggleSwitch.addEventListener('click', function () {
                isOnline = !isOnline;
                updateUI();
            });

            // Go Online button click handler
            goOnlineBtn.addEventListener('click', function () {
                isOnline = true;
                updateUI();
            });

            function updateUI() {
                if (isOnline) {
                    // Update status
                    statusText.textContent = 'You are currently online';
                    statusText.style.color = 'var(--success-green)';

                    // Update toggle
                    toggleSwitch.classList.add('active');
                    toggleSwitch.querySelector('.toggle-knob i').className = 'fas fa-check';
                    toggleSwitch.querySelector('.toggle-knob i').style.color = 'var(--success-green)';

                    // Update hero section
                    heroSection.className = 'online-hero';
                    heroSection.querySelector('.icon-lg').innerHTML = '<i class="fas fa-bolt"></i>';
                    heroSection.querySelector('.icon-lg').style.background = 'rgba(40, 167, 69, 0.1)';
                    heroSection.querySelector('.icon-lg').style.color = 'var(--success-green)';
                    heroTitle.textContent = "You're Online!";
                    heroText.textContent = "You're now receiving delivery requests. Stay alert for new orders!";
                    btnText.textContent = "Go Offline";
                    goOnlineBtn.querySelector('i').className = 'fas fa-power-off';

                    // Show deliveries
                    deliveriesSection.style.display = 'block';

                    // Show notification
                    showNotification('You are now online and receiving orders', 'success');
                } else {
                    // Update status
                    statusText.textContent = 'You are currently offline';
                    statusText.style.color = 'var(--text-light)';

                    // Update toggle
                    toggleSwitch.classList.remove('active');
                    toggleSwitch.querySelector('.toggle-knob i').className = 'fas fa-times';
                    toggleSwitch.querySelector('.toggle-knob i').style.color = '#999';

                    // Update hero section
                    heroSection.className = 'offline-hero';
                    heroSection.querySelector('.icon-lg').innerHTML = '<i class="fas fa-clock"></i>';
                    heroSection.querySelector('.icon-lg').style.background = 'rgba(139, 0, 0, 0.08)';
                    heroSection.querySelector('.icon-lg').style.color = 'var(--primary-maroon)';
                    heroTitle.textContent = "You're Offline";
                    heroText.textContent = "Turn on your availability to start receiving delivery requests";
                    btnText.textContent = "Go Online";
                    goOnlineBtn.querySelector('i').className = 'fas fa-power-off';

                    // Hide deliveries
                    deliveriesSection.style.display = 'none';

                    // Show notification
                    showNotification('You are now offline', 'info');
                }
            }

            function showNotification(message, type) {
                // Create notification element
                const notification = document.createElement('div');
                notification.style.cssText = `
                    position: fixed;
                    top: 20px;
                    right: 20px;
                    background: ${type === 'success' ? 'var(--success-green)' : 'var(--warning-orange)'};
                    color: white;
                    padding: 12px 20px;
                    border-radius: var(--radius-md);
                    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                    z-index: 1000;
                    animation: slideIn 0.3s ease;
                    font-size: 14px;
                    display: flex;
                    align-items: center;
                    gap: 8px;
                `;
                notification.innerHTML = `
                    <i class="fas fa-${type === 'success' ? 'check-circle' : 'info-circle'}"></i>
                    ${message}
                `;

                document.body.appendChild(notification);

                // Remove after 3 seconds
                setTimeout(() => {
                    notification.style.animation = 'slideOut 0.3s ease';
                    setTimeout(() => notification.remove(), 300);
                }, 3000);
            }

            // Add CSS for animations
            const style = document.createElement('style');
            style.textContent = `
                @keyframes slideIn {
                    from { transform: translateX(100%); opacity: 0; }
                    to { transform: translateX(0); opacity: 1; }
                }
                @keyframes slideOut {
                    from { transform: translateX(0); opacity: 1; }
                    to { transform: translateX(100%); opacity: 0; }
                }
            `;
            document.head.appendChild(style);

            // Delivery actions
            document.querySelectorAll('.btn-accept').forEach(btn => {
                btn.addEventListener('click', function () {
                    const card = this.closest('.delivery-card');
                    card.querySelector('.delivery-status').className = 'delivery-status status-active';
                    card.querySelector('.delivery-status').textContent = 'Accepted';
                    this.textContent = 'On Delivery';
                    this.style.background = 'var(--primary-maroon)';

                    showNotification('Delivery accepted successfully', 'success');
                });
            });

            document.querySelectorAll('.btn-decline').forEach(btn => {
                btn.addEventListener('click', function () {
                    const card = this.closest('.delivery-card');
                    card.style.opacity = '0.5';
                    card.style.pointerEvents = 'none';

                    setTimeout(() => {
                        card.style.display = 'none';
                    }, 300);

                    showNotification('Delivery declined', 'info');
                });
            });
        });
    </script>
</asp:Content>