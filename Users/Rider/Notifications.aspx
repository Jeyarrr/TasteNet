<%@ Page Title="Notifications" Language="C#" MasterPageFile="~/MasterPages/Rider.Master" AutoEventWireup="true" CodeBehind="Notifications.aspx.cs" Inherits="TasteNet.Users.Rider.Notifications" %>

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
            --warning-orange-light: #fff3e6;
            --danger-red: #b91c1c;
            --danger-red-light: #fee2e2;
            --accent-pink: #f9ecee;
            --accent-blue: #eff6ff;
            --accent-blue-dark: #3b82f6;
            --accent-yellow: #ffcc00;
            --accent-yellow-light: #fff9e6;
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

        .notifications-wrapper {
            background: var(--soft-cream) !important;
            padding: 20px 30px;
            max-width: 1400px;
            margin: 0 auto;
            min-height: 100vh;
            box-sizing: border-box;
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

        .header-actions {
            display: flex;
            gap: 12px;
            align-items: center;
        }

        .btn-mark-read {
            background: var(--primary-maroon);
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: var(--radius-md);
            cursor: pointer;
            font-size: 13px;
            font-weight: 600;
            font-family: 'Poppins', sans-serif;
            transition: all var(--transition-base);
            display: flex;
            align-items: center;
            gap: 8px;
            box-shadow: var(--button-shadow);
        }

        .btn-mark-read:hover {
            background: var(--primary-maroon-dark);
            transform: translateY(-2px);
        }

        .btn-filter {
            background: white;
            color: var(--primary-maroon);
            border: 1px solid var(--border-light);
            padding: 9px 18px;
            border-radius: var(--radius-md);
            cursor: pointer;
            font-size: 13px;
            font-weight: 500;
            font-family: 'Poppins', sans-serif;
            transition: all var(--transition-base);
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .btn-filter:hover {
            background: var(--accent-pink);
            border-color: var(--primary-maroon);
        }

        /* Stats Cards - matching dashboard stat-card style exactly */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: white;
            padding: 25px;
            border-radius: var(--radius-xl);
            box-shadow: var(--card-shadow);
            transition: all var(--transition-base);
            border: 1px solid var(--border-light);
            animation: fadeIn 0.5s ease-out;
            animation-fill-mode: both;
        }

        .stat-card:nth-child(1) { animation-delay: 0.1s; }
        .stat-card:nth-child(2) { animation-delay: 0.2s; }
        .stat-card:nth-child(3) { animation-delay: 0.3s; }
        .stat-card:nth-child(4) { animation-delay: 0.4s; }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--card-shadow-hover);
        }

        .stat-card__content {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 10px;
        }

        .stat-label {
            font-size: 12px;
            font-weight: 500;
            color: var(--muted-text);
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 8px;
        }

        .stat-value {
            font-size: 32px;
            font-weight: 700;
            color: var(--primary-maroon);
            margin: 0;
            line-height: 1;
        }

        .icon-circle {
            width: 48px;
            height: 48px;
            border-radius: var(--radius-lg);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 18px;
            background: var(--accent-pink);
            color: var(--primary-maroon);
            transition: all var(--transition-base);
            flex-shrink: 0;
        }

        .stat-card:hover .icon-circle {
            transform: scale(1.1) rotate(5deg);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
        }

        .stat-meta {
            margin-top: 12px;
            padding-top: 12px;
            border-top: 1px dashed var(--border-light);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .stat-subtext {
            color: var(--muted-text);
            font-size: 11px;
            font-weight: 500;
        }

        .stat-trend {
            font-size: 11px;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 4px;
            padding: 3px 8px;
            border-radius: var(--radius-sm);
        }

        .stat-trend.up {
            background: var(--success-green-light);
            color: var(--success-green);
        }

        .stat-trend.down {
            background: var(--danger-red-light);
            color: var(--danger-red);
        }

        .stat-trend.neutral {
            background: var(--accent-blue);
            color: var(--accent-blue-dark);
        }

        /* Filter Toggle */
        .filter-toggle {
            display: inline-flex;
            background: transparent;
            border-radius: var(--radius-lg);
            padding: 4px;
            margin-bottom: 25px;
            gap: 8px;
            flex-wrap: wrap;
        }

        .filter-toggle-btn {
            padding: 10px 22px;
            border: 1px solid var(--border-light);
            border-radius: var(--radius-md);
            background: white;
            color: var(--muted-text);
            cursor: pointer;
            font-family: 'Poppins', sans-serif;
            font-size: 13px;
            font-weight: 500;
            transition: all var(--transition-base);
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .filter-toggle-btn:hover {
            background: var(--accent-pink);
            color: var(--primary-maroon);
            border-color: var(--primary-maroon);
        }

        .filter-toggle-btn.active {
            background: var(--primary-maroon);
            color: white;
            border-color: var(--primary-maroon);
        }

        /* Notifications List */
        .notifications-list {
            display: flex;
            flex-direction: column;
            gap: 15px;
            margin-bottom: 30px;
        }

        /* Notification Cards - matching dashboard card style */
        .notification-card {
            background: white;
            padding: 25px;
            border-radius: var(--radius-xl);
            box-shadow: var(--card-shadow);
            transition: all var(--transition-base);
            border: 1px solid var(--border-light);
            display: flex;
            align-items: flex-start;
            gap: 20px;
            position: relative;
            animation: slideUp 0.4s ease-out;
            animation-fill-mode: both;
        }

        .notification-card:nth-child(1) { animation-delay: 0.1s; }
        .notification-card:nth-child(2) { animation-delay: 0.2s; }
        .notification-card:nth-child(3) { animation-delay: 0.3s; }
        .notification-card:nth-child(4) { animation-delay: 0.4s; }
        .notification-card:nth-child(5) { animation-delay: 0.5s; }

        .notification-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--card-shadow-hover);
            border-color: var(--border-hover);
        }

        /* Unread state - matches dashboard active delivery card style */
        .notification-card.unread {
            background: var(--accent-pink);
            border-left: 4px solid var(--primary-maroon);
        }

        .notification-icon {
            width: 50px;
            height: 50px;
            min-width: 50px;
            border-radius: var(--radius-lg);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 18px;
            color: white;
            transition: all var(--transition-base);
        }

        .notification-icon.order { background: var(--primary-maroon); }
        .notification-icon.payment { background: var(--success-green); }
        .notification-icon.alert { background: var(--warning-orange); }
        .notification-icon.completed { background: var(--accent-blue-dark); }
        .notification-icon.system { background: var(--accent-purple); }

        .notification-card:hover .notification-icon {
            transform: scale(1.1);
        }

        .notification-content {
            flex: 1;
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .notification-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 15px;
            margin-bottom: 5px;
        }

        .notification-title {
            font-size: 16px;
            font-weight: 600;
            color: var(--text-dark);
            margin: 0;
        }

        .notification-time {
            font-size: 11px;
            color: var(--muted-text);
            font-weight: 500;
            white-space: nowrap;
        }

        .notification-message {
            color: var(--muted-text);
            font-size: 13px;
            line-height: 1.5;
            margin: 0;
        }

        .notification-meta {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-top: 5px;
            flex-wrap: wrap;
        }

        .notification-badge {
            padding: 4px 10px;
            border-radius: var(--radius-sm);
            font-size: 10px;
            font-weight: 600;
            text-transform: uppercase;
            display: inline-flex;
            align-items: center;
            gap: 5px;
            border: 1px solid transparent;
        }

        .badge-new {
            background: var(--danger-red-light);
            color: var(--danger-red);
            border-color: var(--danger-red);
        }

        .badge-important {
            background: var(--warning-orange-light);
            color: var(--warning-orange);
            border-color: var(--warning-orange);
        }

        .badge-success {
            background: var(--success-green-light);
            color: var(--success-green);
            border-color: var(--success-green);
        }

        .badge-info {
            background: var(--accent-blue);
            color: var(--accent-blue-dark);
            border-color: var(--accent-blue-dark);
        }

        .notification-actions {
            display: flex;
            gap: 8px;
            opacity: 0;
            transform: translateX(10px);
            transition: all var(--transition-base);
        }

        .notification-card:hover .notification-actions {
            opacity: 1;
            transform: translateX(0);
        }

        .btn-notification-action {
            width: 34px;
            height: 34px;
            border-radius: var(--radius-md);
            border: 1px solid var(--border-light);
            background: white;
            color: var(--muted-text);
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all var(--transition-base);
        }

        .btn-notification-action:hover {
            background: var(--primary-maroon);
            color: white;
            border-color: var(--primary-maroon);
            transform: translateY(-2px);
        }

        .btn-notification-action.read:hover {
            background: var(--success-green);
            border-color: var(--success-green);
        }

        .btn-notification-action.delete:hover {
            background: var(--danger-red);
            border-color: var(--danger-red);
        }

        .unread-indicator {
            width: 8px;
            height: 8px;
            background: var(--primary-maroon);
            border-radius: 50%;
            position: absolute;
            top: 20px;
            right: 20px;
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0% { box-shadow: 0 0 0 0 rgba(107, 13, 30, 0.7); }
            70% { box-shadow: 0 0 0 6px rgba(107, 13, 30, 0); }
            100% { box-shadow: 0 0 0 0 rgba(107, 13, 30, 0); }
        }

        /* Load More Button */
        .load-more-container {
            text-align: center;
            margin-top: 20px;
        }

        .btn-load-more {
            background: white;
            color: var(--primary-maroon);
            border: 1px solid var(--border-light);
            padding: 12px 30px;
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

        .btn-load-more:hover {
            background: var(--accent-pink);
            border-color: var(--primary-maroon);
            transform: translateY(-2px);
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 60px 40px;
            background: white;
            border-radius: var(--radius-xl);
            border: 1px solid var(--border-light);
            box-shadow: var(--card-shadow);
        }

        .empty-state-icon {
            font-size: 64px;
            color: var(--border-light);
            margin-bottom: 20px;
        }

        .empty-state-title {
            font-size: 20px;
            color: var(--text-dark);
            margin-bottom: 10px;
            font-weight: 600;
        }

        .empty-state-message {
            color: var(--muted-text);
            font-size: 13px;
            max-width: 400px;
            margin: 0 auto 20px;
            line-height: 1.5;
        }

        /* Toast Notification */
        .toast-notification {
            position: fixed;
            top: 20px;
            right: 20px;
            background: var(--success-green);
            color: white;
            padding: 14px 20px;
            border-radius: var(--radius-lg);
            box-shadow: 0 8px 30px rgba(45, 157, 120, 0.3);
            z-index: 10001;
            animation: slideInRight 0.3s ease;
            display: flex;
            align-items: center;
            gap: 12px;
            max-width: 350px;
            font-family: 'Poppins', sans-serif;
            border: none;
        }

        .toast-notification.info {
            background: var(--accent-blue-dark);
            box-shadow: 0 8px 30px rgba(59, 130, 246, 0.3);
        }

        .toast-notification.warning {
            background: var(--warning-orange);
            box-shadow: 0 8px 30px rgba(217, 119, 6, 0.3);
        }

        .toast-notification.error {
            background: var(--danger-red);
            box-shadow: 0 8px 30px rgba(185, 28, 28, 0.3);
        }

        .toast-close {
            background: transparent;
            border: none;
            color: white;
            cursor: pointer;
            width: 24px;
            height: 24px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .toast-close:hover {
            background: rgba(255, 255, 255, 0.2);
        }

        /* Animations */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes slideUp {
            from { opacity: 0; transform: translateY(30px); }
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
        @media (max-width: 1200px) {
            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 992px) {
            .notifications-wrapper {
                padding: 20px;
            }
            
            .page-header {
                flex-direction: column;
                align-items: stretch;
                gap: 15px;
            }
            
            .header-actions {
                flex-direction: column;
                align-items: stretch;
            }
            
            .btn-mark-read, .btn-filter {
                width: 100%;
                justify-content: center;
            }
        }

        @media (max-width: 768px) {
            .stats-grid {
                grid-template-columns: 1fr;
            }
            
            .header-title h1 {
                font-size: 24px;
            }
            
            .notification-card {
                flex-direction: column;
                gap: 15px;
            }
            
            .notification-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 5px;
            }
            
            .notification-actions {
                opacity: 1;
                transform: translateX(0);
                align-self: flex-end;
            }
            
            .filter-toggle {
                width: 100%;
                overflow-x: auto;
                flex-wrap: nowrap;
                padding-bottom: 5px;
            }
            
            .filter-toggle-btn {
                white-space: nowrap;
            }
        }

        @media (max-width: 576px) {
            .notifications-wrapper {
                padding: 15px;
            }
            
            .stat-value {
                font-size: 28px;
            }
            
            .icon-circle {
                width: 40px;
                height: 40px;
                font-size: 16px;
            }
            
            .notification-card {
                padding: 18px;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="notifications-wrapper">
        <div class="page-header">
            <div class="header-title">
                <h1>Notifications</h1>
                <p>Stay updated with your delivery activities, earnings, and important alerts</p>
            </div>
            
            <div class="header-actions">
                <button type="button" class="btn-mark-read" id="markAllRead">
                    <i class="fas fa-check-double"></i>
                    Mark All as Read
                </button>
                <button type="button" class="btn-filter" id="filterNotifications">
                    <i class="fas fa-filter"></i>
                    Filter
                </button>
            </div>
        </div>

        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-card__content">
                    <div>
                        <div class="stat-label">UNREAD</div>
                        <div class="stat-value" id="unreadCount">2</div>
                    </div>
                    <div class="icon-circle">
                        <i class="fas fa-bell"></i>
                    </div>
                </div>
                <div class="stat-meta">
                    <span class="stat-subtext">Requires attention</span>
                    <span class="stat-trend up">
                        <i class="fas fa-arrow-up"></i> New
                    </span>
                </div>
            </div>
            
            <div class="stat-card">
                <div class="stat-card__content">
                    <div>
                        <div class="stat-label">TODAY</div>
                        <div class="stat-value" id="todayCount">5</div>
                    </div>
                    <div class="icon-circle">
                        <i class="fas fa-calendar-day"></i>
                    </div>
                </div>
                <div class="stat-meta">
                    <span class="stat-subtext">Since midnight</span>
                    <span class="stat-trend neutral">
                        <i class="fas fa-minus"></i> Steady
                    </span>
                </div>
            </div>
            
            <div class="stat-card">
                <div class="stat-card__content">
                    <div>
                        <div class="stat-label">THIS WEEK</div>
                        <div class="stat-value" id="weekCount">12</div>
                    </div>
                    <div class="icon-circle">
                        <i class="fas fa-calendar-week"></i>
                    </div>
                </div>
                <div class="stat-meta">
                    <span class="stat-subtext">Past 7 days</span>
                    <span class="stat-trend down">
                        <i class="fas fa-arrow-down"></i> 18%
                    </span>
                </div>
            </div>
            
            <div class="stat-card">
                <div class="stat-card__content">
                    <div>
                        <div class="stat-label">TOTAL</div>
                        <div class="stat-value" id="totalCount">47</div>
                    </div>
                    <div class="icon-circle">
                        <i class="fas fa-layer-group"></i>
                    </div>
                </div>
                <div class="stat-meta">
                    <span class="stat-subtext">All notifications</span>
                    <span class="stat-trend up">
                        <i class="fas fa-arrow-up"></i> 32%
                    </span>
                </div>
            </div>
        </div>

        <div class="filter-toggle">
            <button type="button" class="filter-toggle-btn active" data-filter="all">
                <i class="fas fa-globe"></i> All
            </button>
            <button type="button" class="filter-toggle-btn" data-filter="unread">
                <i class="fas fa-bell"></i> Unread
            </button>
            <button type="button" class="filter-toggle-btn" data-filter="orders">
                <i class="fas fa-shopping-bag"></i> Orders
            </button>
            <button type="button" class="filter-toggle-btn" data-filter="payments">
                <i class="fas fa-money-bill-wave"></i> Payments
            </button>
            <button type="button" class="filter-toggle-btn" data-filter="system">
                <i class="fas fa-cog"></i> System
            </button>
        </div>

        <div class="notifications-list" id="notificationsList">
            <div class="notification-card unread" data-type="order" data-category="orders">
                <div class="notification-icon order"><i class="fas fa-shopping-bag"></i></div>
                <div class="notification-content">
                    <div class="notification-header">
                        <h3 class="notification-title">New Order Available for Pickup</h3>
                        <span class="notification-time">2 minutes ago</span>
                    </div>
                    <p class="notification-message">
                        Order <strong>#ORD-12345</strong> from <strong>Caballeros</strong> is waiting for acceptance. 
                        Estimated delivery distance: 2.3km. Estimated earnings: ₱85.50
                    </p>
                    <div class="notification-meta">
                        <span class="notification-badge badge-new"><i class="fas fa-star"></i> New</span>
                        <span class="notification-badge badge-important"><i class="fas fa-bolt"></i> Urgent</span>
                    </div>
                </div>
                <div class="notification-actions">
                    <button class="btn-notification-action read" title="Mark as read"><i class="fas fa-check"></i></button>
                    <button class="btn-notification-action delete" title="Delete"><i class="fas fa-trash"></i></button>
                </div>
                <div class="unread-indicator"></div>
            </div>

            <div class="notification-card unread" data-type="payment" data-category="payments">
                <div class="notification-icon payment"><i class="fas fa-money-bill-wave"></i></div>
                <div class="notification-content">
                    <div class="notification-header">
                        <h3 class="notification-title">Payment Received Successfully</h3>
                        <span class="notification-time">1 hour ago</span>
                    </div>
                    <p class="notification-message">
                        Your weekly earnings of <strong>₱982.50</strong> have been processed and transferred to your 
                        GCash account <strong>0917***1234</strong>. Transaction ID: TXN-789012
                    </p>
                    <div class="notification-meta">
                        <span class="notification-badge badge-success"><i class="fas fa-check-circle"></i> Completed</span>
                    </div>
                </div>
                <div class="notification-actions">
                    <button class="btn-notification-action read"><i class="fas fa-check"></i></button>
                    <button class="btn-notification-action delete"><i class="fas fa-trash"></i></button>
                </div>
                <div class="unread-indicator"></div>
            </div>

            <div class="notification-card" data-type="alert" data-category="system">
                <div class="notification-icon alert"><i class="fas fa-bullhorn"></i></div>
                <div class="notification-content">
                    <div class="notification-header">
                        <h3 class="notification-title">Peak Hour Alert - High Demand Area</h3>
                        <span class="notification-time">2 hours ago</span>
                    </div>
                    <p class="notification-message">
                        High delivery demand detected in <strong>Dasma Pala Pala area</strong>. 
                        Surge pricing active: +25% bonus on all orders.
                    </p>
                    <div class="notification-meta">
                        <span class="notification-badge badge-info"><i class="fas fa-info-circle"></i> Alert</span>
                    </div>
                </div>
                <div class="notification-actions">
                    <button class="btn-notification-action read"><i class="fas fa-check"></i></button>
                    <button class="btn-notification-action delete"><i class="fas fa-trash"></i></button>
                </div>
            </div>

            <div class="notification-card" data-type="completed" data-category="orders">
                <div class="notification-icon completed"><i class="fas fa-check-circle"></i></div>
                <div class="notification-content">
                    <div class="notification-header">
                        <h3 class="notification-title">Delivery Successfully Completed</h3>
                        <span class="notification-time">3 hours ago</span>
                    </div>
                    <p class="notification-message">
                        Order <strong>#ORD-12344</strong> delivered to <strong>Greensborough Dasma</strong>. 
                        Customer rating: ⭐⭐⭐⭐⭐ (5 stars).
                    </p>
                    <div class="notification-meta">
                        <span class="notification-badge badge-success"><i class="fas fa-award"></i> Rated</span>
                    </div>
                </div>
                <div class="notification-actions">
                    <button class="btn-notification-action read"><i class="fas fa-check"></i></button>
                    <button class="btn-notification-action delete"><i class="fas fa-trash"></i></button>
                </div>
            </div>

            <div class="notification-card" data-type="system" data-category="system">
                <div class="notification-icon system"><i class="fas fa-cog"></i></div>
                <div class="notification-content">
                    <div class="notification-header">
                        <h3 class="notification-title">System Maintenance Notice</h3>
                        <span class="notification-time">5 hours ago</span>
                    </div>
                    <p class="notification-message">
                        Scheduled system maintenance will occur tonight from <strong>1:00 AM to 3:00 AM</strong>. 
                        The app will be temporarily unavailable.
                    </p>
                    <div class="notification-meta">
                        <span class="notification-badge badge-info"><i class="fas fa-tools"></i> Maintenance</span>
                    </div>
                </div>
                <div class="notification-actions">
                    <button class="btn-notification-action read"><i class="fas fa-check"></i></button>
                    <button class="btn-notification-action delete"><i class="fas fa-trash"></i></button>
                </div>
            </div>
        </div>

        <div class="load-more-container">
            <button type="button" class="btn-load-more" id="loadMore">
                <i class="fas fa-redo"></i> Load More Notifications
            </button>
        </div>

        <div class="empty-state" id="emptyState" style="display: none;">
            <div class="empty-state-icon"><i class="far fa-bell-slash"></i></div>
            <h3 class="empty-state-title">No Notifications Found</h3>
            <p class="empty-state-message">You're all caught up! When you have new orders, payments, or alerts, they will appear here.</p>
            <button type="button" class="btn-mark-read" onclick="location.reload()"><i class="fas fa-sync"></i> Refresh Page</button>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const markAllReadBtn = document.getElementById('markAllRead');
            const filterBtns = document.querySelectorAll('.filter-toggle-btn');
            const readBtns = document.querySelectorAll('.btn-notification-action.read');
            const deleteBtns = document.querySelectorAll('.btn-notification-action.delete');
            const loadMoreBtn = document.getElementById('loadMore');
            const notificationsList = document.getElementById('notificationsList');
            const emptyState = document.getElementById('emptyState');
            let unreadCount = 2, todayCount = 5, weekCount = 12, totalCount = 47;
            const unreadEl = document.getElementById('unreadCount');
            const todayEl = document.getElementById('todayCount');
            const weekEl = document.getElementById('weekCount');
            const totalEl = document.getElementById('totalCount');

            function updateCounters() {
                if (unreadEl) unreadEl.textContent = unreadCount;
                if (todayEl) todayEl.textContent = todayCount;
                if (weekEl) weekEl.textContent = weekCount;
                if (totalEl) totalEl.textContent = totalCount;
            }

            function showToast(msg, type = 'success') {
                let oldToast = document.querySelector('.toast-notification');
                if (oldToast) oldToast.remove();
                let toast = document.createElement('div');
                toast.className = `toast-notification ${type}`;
                toast.innerHTML = `<div class="toast-content"><i class="fas ${type === 'success' ? 'fa-check-circle' : type === 'info' ? 'fa-info-circle' : 'fa-exclamation-triangle'}"></i><span>${msg}</span></div><button class="toast-close"><i class="fas fa-times"></i></button>`;
                document.body.appendChild(toast);
                toast.querySelector('.toast-close').onclick = () => { toast.style.animation = 'slideOutRight 0.3s ease'; setTimeout(() => toast.remove(), 300); };
                setTimeout(() => { if (toast.parentNode) { toast.style.animation = 'slideOutRight 0.3s ease'; setTimeout(() => toast.remove(), 300); } }, 4000);
            }

            function filterNotifications(filter) {
                let visible = 0;
                document.querySelectorAll('.notification-card').forEach(card => {
                    let cat = card.getAttribute('data-category');
                    let isUnread = card.classList.contains('unread');
                    let show = filter === 'all' ? true : filter === 'unread' ? isUnread : filter === 'orders' ? cat === 'orders' : filter === 'payments' ? cat === 'payments' : filter === 'system' ? cat === 'system' : true;
                    card.style.display = show ? 'flex' : 'none';
                    if (show) visible++;
                });
                if (visible === 0) { notificationsList.style.display = 'none'; emptyState.style.display = 'block'; loadMoreBtn.style.display = 'none'; }
                else { notificationsList.style.display = 'flex'; emptyState.style.display = 'none'; loadMoreBtn.style.display = 'block'; }
                showToast(`Showing ${filter} notifications`, 'info');
            }

            filterBtns.forEach(btn => btn.addEventListener('click', function () {
                filterBtns.forEach(b => b.classList.remove('active'));
                this.classList.add('active');
                filterNotifications(this.getAttribute('data-filter'));
            }));

            if (markAllReadBtn) markAllReadBtn.addEventListener('click', () => {
                let unreads = document.querySelectorAll('.notification-card.unread');
                unreads.forEach(n => { n.classList.remove('unread'); let ind = n.querySelector('.unread-indicator'); if (ind) ind.remove(); });
                unreadCount = 0; updateCounters(); showToast(`Marked ${unreads.length} as read`, 'success');
            });

            readBtns.forEach(btn => btn.addEventListener('click', (e) => {
                e.stopPropagation();
                let card = btn.closest('.notification-card');
                if (card && card.classList.contains('unread')) {
                    card.classList.remove('unread');
                    let ind = card.querySelector('.unread-indicator');
                    if (ind) ind.remove();
                    unreadCount = Math.max(0, unreadCount - 1);
                    updateCounters();
                    showToast('Marked as read', 'success');
                } else showToast('Already read', 'info');
            }));

            deleteBtns.forEach(btn => btn.addEventListener('click', (e) => {
                e.stopPropagation();
                let card = btn.closest('.notification-card');
                let wasUnread = card.classList.contains('unread');
                card.style.animation = 'slideOutRight 0.3s ease';
                setTimeout(() => {
                    card.remove();
                    if (wasUnread) unreadCount = Math.max(0, unreadCount - 1);
                    todayCount = Math.max(0, todayCount - 1);
                    weekCount = Math.max(0, weekCount - 1);
                    totalCount = Math.max(0, totalCount - 1);
                    updateCounters();
                    if (document.querySelectorAll('.notification-card').length === 0) {
                        notificationsList.style.display = 'none';
                        emptyState.style.display = 'block';
                        loadMoreBtn.style.display = 'none';
                    }
                    showToast('Notification deleted', 'success');
                }, 300);
            }));

            if (loadMoreBtn) loadMoreBtn.addEventListener('click', function () {
                let orig = this.innerHTML;
                this.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Loading...';
                this.disabled = true;
                setTimeout(() => {
                    let newCards = [
                        { type: 'order', category: 'orders', icon: 'shopping-bag', iconClass: 'order', title: 'Order Updated', time: '6 hours ago', message: 'Order #ORD-12343 has updated delivery instructions.', badges: ['info'], unread: false },
                        { type: 'payment', category: 'payments', icon: 'money-check', iconClass: 'payment', title: 'Bonus Payment', time: 'Yesterday', message: 'Performance bonus of ₱250 added to your balance.', badges: ['success'], unread: false }
                    ];
                    newCards.forEach((d) => {
                        let card = document.createElement('div');
                        card.className = `notification-card ${d.unread ? 'unread' : ''}`;
                        card.setAttribute('data-type', d.type);
                        card.setAttribute('data-category', d.category);
                        let badgeHtml = d.badges.map(b => `<span class="notification-badge badge-${b}"><i class="fas fa-${b === 'new' ? 'star' : b === 'important' ? 'bolt' : b === 'success' ? 'check-circle' : 'info-circle'}"></i> ${b === 'new' ? 'New' : b === 'important' ? 'Urgent' : b === 'success' ? 'Completed' : 'Info'}</span>`).join('');
                        card.innerHTML = `<div class="notification-icon ${d.iconClass}"><i class="fas fa-${d.icon}"></i></div><div class="notification-content"><div class="notification-header"><h3 class="notification-title">${d.title}</h3><span class="notification-time">${d.time}</span></div><p class="notification-message">${d.message}</p><div class="notification-meta">${badgeHtml}</div></div><div class="notification-actions"><button class="btn-notification-action read"><i class="fas fa-check"></i></button><button class="btn-notification-action delete"><i class="fas fa-trash"></i></button></div>${d.unread ? '<div class="unread-indicator"></div>' : ''}`;
                        notificationsList.appendChild(card);
                        card.querySelector('.read')?.addEventListener('click', (e) => { e.stopPropagation(); if (card.classList.contains('unread')) { card.classList.remove('unread'); card.querySelector('.unread-indicator')?.remove(); unreadCount = Math.max(0, unreadCount - 1); updateCounters(); showToast('Marked as read', 'success'); } });
                        card.querySelector('.delete')?.addEventListener('click', (e) => { e.stopPropagation(); let wasUnread = card.classList.contains('unread'); card.style.animation = 'slideOutRight 0.3s ease'; setTimeout(() => { card.remove(); if (wasUnread) unreadCount = Math.max(0, unreadCount - 1); todayCount = Math.max(0, todayCount - 1); weekCount = Math.max(0, weekCount - 1); totalCount = Math.max(0, totalCount - 1); updateCounters(); if (document.querySelectorAll('.notification-card').length === 0) { notificationsList.style.display = 'none'; emptyState.style.display = 'block'; loadMoreBtn.style.display = 'none'; } showToast('Deleted', 'success'); }, 300); });
                        card.addEventListener('click', (e) => { if (!e.target.closest('.btn-notification-action')) { showToast(`View: ${d.title}`, 'info'); if (card.classList.contains('unread')) { card.classList.remove('unread'); card.querySelector('.unread-indicator')?.remove(); unreadCount = Math.max(0, unreadCount - 1); updateCounters(); } } });
                    });
                    totalCount += newCards.length;
                    weekCount += newCards.length;
                    updateCounters();
                    this.innerHTML = orig;
                    this.disabled = false;
                    showToast('Loaded 2 more', 'success');
                }, 1500);
            });

            document.querySelectorAll('.notification-card').forEach(card => {
                card.addEventListener('click', function (e) {
                    if (!e.target.closest('.btn-notification-action')) {
                        let title = this.querySelector('.notification-title')?.textContent || '';
                        showToast(`Viewing: ${title}`, 'info');
                        if (this.classList.contains('unread')) {
                            this.classList.remove('unread');
                            this.querySelector('.unread-indicator')?.remove();
                            unreadCount = Math.max(0, unreadCount - 1);
                            updateCounters();
                        }
                    }
                });
            });

            updateCounters();
        });
    </script>
</asp:Content>