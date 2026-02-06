<%@ Page Title="Notifications" Language="C#" MasterPageFile="~/MasterPages/Rider.Master" AutoEventWireup="true" CodeBehind="Notifications.aspx.cs" Inherits="TasteNet.Users.Rider.Notifications" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        :root {
            --primary-maroon: #6b0d1e;
            --primary-maroon-dark: #5a0b19;
            --primary-maroon-light: #f9ecee;
            --primary-dark: #1a1a1a;
            --sidebar-hover: #2a2a2a;
            --soft-cream: #fffaf3;
            --bg-lighter: #f9f4ee;
            --bg-hover: #fefaf5;
            --card-white: #ffffff;
            --text-dark: #4a0e0e;
            --text-muted: #8a6d6d;
            --text-light: #a89696;
            --success-green: #2d9d78;
            --success-green-light: #e6f4f1;
            --success-green-dark: #1f7a5e;
            --warning-orange: #d97706;
            --warning-orange-light: #fff3e6;
            --danger-red: #b91c1c;
            --danger-red-light: #fee2e2;
            --info-blue: #3b82f6;
            --info-blue-light: #eff6ff;
            --accent-red: #ff6b6b;
            --accent-red-light: #ffeaea;
            --accent-green: #10b981;
            --accent-green-light: #d1fae5;
            --accent-yellow: #ffcc00;
            --accent-yellow-light: #fff9e6;
            --accent-purple: #7c3aed;
            --accent-purple-light: #f3e8ff;
            --accent-blue: #60a5fa;
            --accent-blue-light: #dbeafe;
            --border-light: #e2d1d1;
            --border-hover: #d4b8b8;
            --card-shadow: 0 10px 30px rgba(107, 13, 30, 0.05);
            --card-shadow-hover: 0 15px 40px rgba(107, 13, 30, 0.12);
            --button-shadow: 0 4px 12px rgba(107, 13, 30, 0.2);
            --button-shadow-hover: 0 6px 18px rgba(107, 13, 30, 0.3);
            --notification-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            --notification-shadow-hover: 0 6px 25px rgba(0, 0, 0, 0.12);
            --radius-sm: 8px;
            --radius-md: 10px;
            --radius-lg: 12px;
            --radius-xl: 16px;
            --radius-2xl: 20px;
            --radius-full: 9999px;
            --transition-fast: 0.2s ease;
            --transition-base: 0.3s ease;
            --transition-slow: 0.4s ease;
            --z-dropdown: 1000;
            --z-sticky: 1020;
            --z-fixed: 1030;
            --z-modal-backdrop: 1040;
            --z-modal: 1050;
            --z-popover: 1060;
            --z-tooltip: 1070;
        }

        html, body, form {
            margin: 0 !important;
            padding: 0 !important;
            background-color: var(--soft-cream) !important;
            width: 100%;
            font-family: 'Poppins', sans-serif;
            color: var(--text-dark);
            min-height: 100vh;
            scroll-behavior: smooth;
        }

        * {
            box-sizing: border-box;
        }

        .notifications-wrapper {
            background: var(--soft-cream) !important;
            padding: 30px 40px;
            max-width: 1200px;
            margin: 0 auto;
            min-height: 100vh;
            box-sizing: border-box;
            position: relative;
        }

        .page-header-main {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 35px;
            flex-wrap: wrap;
            gap: 20px;
            padding-bottom: 25px;
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
            color: var(--text-muted);
            margin: 8px 0 0 0;
            font-size: 14px;
            line-height: 1.5;
        }

        .header-actions {
            display: flex;
            gap: 15px;
            align-items: center;
        }

        .btn-mark-read {
            background: var(--primary-maroon);
            color: white;
            border: none;
            padding: 12px 24px;
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

        .btn-mark-read:hover {
            background: var(--primary-maroon-dark);
            transform: translateY(-2px);
            box-shadow: var(--button-shadow-hover);
        }

        .btn-mark-read:active {
            transform: translateY(0);
        }

        .btn-mark-read i {
            font-size: 13px;
        }

        .btn-filter {
            background: transparent;
            color: var(--primary-maroon);
            border: 1px solid var(--primary-maroon);
            padding: 11px 20px;
            border-radius: var(--radius-md);
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            font-family: 'Poppins', sans-serif;
            transition: all var(--transition-base);
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .btn-filter:hover {
            background: var(--primary-maroon);
            color: white;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 25px;
            margin-bottom: 40px;
            animation: fadeIn 0.5s ease-out;
        }

        .stat-card {
            background: var(--card-white);
            padding: 20px;
            border-radius: var(--radius-xl);
            box-shadow: var(--card-shadow);
            transition: all var(--transition-base);
            border: 1px solid var(--border-light);
            display: flex;
            flex-direction: column;
            animation: fadeIn 0.5s ease-out;
            animation-fill-mode: both;
            position: relative;
            overflow: hidden;
            min-height: 140px;
        }

        .stat-card:nth-child(1) { animation-delay: 0.1s; }
        .stat-card:nth-child(2) { animation-delay: 0.2s; }
        .stat-card:nth-child(3) { animation-delay: 0.3s; }
        .stat-card:nth-child(4) { animation-delay: 0.4s; }

        .stat-card:hover {
            transform: translateY(-3px);
            box-shadow: var(--card-shadow-hover);
            border-color: var(--border-hover);
        }

        .stat-label {
            font-size: 13px;
            font-weight: 500;
            color: var(--text-muted);
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .stat-label i {
            font-size: 14px;
        }

        .stat-value {
            font-size: 36px;
            font-weight: 700;
            color: var(--text-dark);
            margin: 5px 0 15px 0;
            line-height: 1;
        }

        .stat-value.danger {
            color: var(--danger-red);
        }

        .stat-value.warning {
            color: var(--warning-orange);
        }

        .stat-value.success {
            color: var(--success-green);
        }

        .stat-value.info {
            color: var(--info-blue);
        }

        .stat-meta {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: auto;
            padding-top: 15px;
            border-top: 1px dashed var(--border-light);
        }

        .stat-subtext {
            color: var(--text-muted);
            font-size: 13px;
            font-weight: 400;
        }

        .stat-trend {
            display: flex;
            align-items: center;
            gap: 4px;
            font-size: 12px;
            font-weight: 600;
            padding: 3px 8px;
            border-radius: var(--radius-sm);
            background: var(--success-green-light);
            color: var(--success-green);
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
            background: var(--info-blue-light);
            color: var(--info-blue);
        }

        .filter-toggle {
            display: inline-flex;
            background: var(--bg-lighter);
            border-radius: var(--radius-lg);
            padding: 4px;
            border: 1px solid var(--border-light);
            margin-bottom: 30px;
            box-shadow: var(--card-shadow);
        }

        .filter-toggle-btn {
            padding: 10px 24px;
            border: none;
            border-radius: var(--radius-md);
            background: transparent;
            color: var(--text-muted);
            cursor: pointer;
            font-family: 'Poppins', sans-serif;
            font-size: 14px;
            font-weight: 500;
            transition: all var(--transition-base);
            min-width: 100px;
            text-align: center;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .filter-toggle-btn:hover {
            color: var(--text-dark);
            background: var(--bg-hover);
        }

        .filter-toggle-btn.active {
            background: var(--primary-maroon);
            color: white;
            box-shadow: 0 2px 8px rgba(107, 13, 30, 0.15);
        }

        .notifications-list {
            display: flex;
            flex-direction: column;
            gap: 15px;
            margin-bottom: 40px;
        }

        .notification-card {
            background: var(--card-white);
            padding: 25px;
            border-radius: var(--radius-xl);
            box-shadow: var(--notification-shadow);
            transition: all var(--transition-base);
            border: 1px solid var(--border-light);
            display: flex;
            align-items: flex-start;
            gap: 20px;
            position: relative;
            overflow: hidden;
            animation: slideUp 0.4s ease-out;
            animation-fill-mode: both;
        }

        .notification-card:nth-child(1) { animation-delay: 0.1s; }
        .notification-card:nth-child(2) { animation-delay: 0.2s; }
        .notification-card:nth-child(3) { animation-delay: 0.3s; }
        .notification-card:nth-child(4) { animation-delay: 0.4s; }
        .notification-card:nth-child(5) { animation-delay: 0.5s; }

        .notification-card:hover {
            transform: translateX(5px);
            box-shadow: var(--notification-shadow-hover);
            border-color: var(--border-hover);
        }

        .notification-card.unread {
            background: var(--primary-maroon-light);
            border-color: var(--primary-maroon);
            border-left: 4px solid var(--primary-maroon);
        }

        .notification-card.unread::before {
            content: '';
            position: absolute;
            left: 0;
            top: 0;
            bottom: 0;
            width: 4px;
            background: var(--primary-maroon);
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

        .notification-icon.order {
            background: var(--accent-red);
            box-shadow: 0 4px 12px rgba(255, 107, 107, 0.2);
        }

        .notification-icon.payment {
            background: var(--accent-green);
            box-shadow: 0 4px 12px rgba(16, 185, 129, 0.2);
        }

        .notification-icon.alert {
            background: var(--accent-yellow);
            box-shadow: 0 4px 12px rgba(255, 204, 0, 0.2);
        }

        .notification-icon.completed {
            background: var(--accent-blue);
            box-shadow: 0 4px 12px rgba(96, 165, 250, 0.2);
        }

        .notification-icon.system {
            background: var(--accent-purple);
            box-shadow: 0 4px 12px rgba(124, 58, 237, 0.2);
        }

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
            line-height: 1.4;
        }

        .notification-time {
            font-size: 12px;
            color: var(--text-muted);
            font-weight: 500;
            white-space: nowrap;
        }

        .notification-message {
            color: var(--text-muted);
            font-size: 14px;
            line-height: 1.5;
            margin: 0;
        }

        .notification-meta {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-top: 5px;
        }

        .notification-badge {
            padding: 4px 10px;
            border-radius: var(--radius-sm);
            font-size: 11px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.3px;
            display: inline-flex;
            align-items: center;
            gap: 4px;
        }

        .badge-new {
            background: var(--accent-red-light);
            color: var(--danger-red);
            border: 1px solid var(--accent-red);
        }

        .badge-important {
            background: var(--warning-orange-light);
            color: var(--warning-orange);
            border: 1px solid var(--warning-orange);
        }

        .badge-success {
            background: var(--success-green-light);
            color: var(--success-green);
            border: 1px solid var(--success-green);
        }

        .badge-info {
            background: var(--info-blue-light);
            color: var(--info-blue);
            border: 1px solid var(--info-blue);
        }

        .notification-actions {
            display: flex;
            gap: 10px;
            opacity: 0;
            transform: translateX(10px);
            transition: all var(--transition-base);
        }

        .notification-card:hover .notification-actions {
            opacity: 1;
            transform: translateX(0);
        }

        .btn-notification-action {
            width: 36px;
            height: 36px;
            border-radius: var(--radius-md);
            border: none;
            background: var(--bg-lighter);
            color: var(--text-muted);
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all var(--transition-base);
        }

        .btn-notification-action:hover {
            background: var(--primary-maroon);
            color: white;
            transform: translateY(-2px);
        }

        .btn-notification-action.read:hover {
            background: var(--success-green);
        }

        .btn-notification-action.delete:hover {
            background: var(--danger-red);
        }

        .unread-indicator {
            width: 10px;
            height: 10px;
            background: var(--primary-maroon);
            border-radius: var(--radius-full);
            position: absolute;
            top: 25px;
            right: 25px;
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0% { box-shadow: 0 0 0 0 rgba(107, 13, 30, 0.7); }
            70% { box-shadow: 0 0 0 6px rgba(107, 13, 30, 0); }
            100% { box-shadow: 0 0 0 0 rgba(107, 13, 30, 0); }
        }

        .load-more-container {
            text-align: center;
            margin-top: 30px;
        }

        .btn-load-more {
            background: transparent;
            color: var(--primary-maroon);
            border: 2px solid var(--primary-maroon);
            padding: 12px 30px;
            border-radius: var(--radius-md);
            cursor: pointer;
            font-family: 'Poppins', sans-serif;
            font-size: 14px;
            font-weight: 600;
            transition: all var(--transition-base);
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn-load-more:hover {
            background: var(--primary-maroon);
            color: white;
            transform: translateY(-2px);
            box-shadow: var(--button-shadow);
        }

        .empty-state {
            text-align: center;
            padding: 60px 40px;
            background: var(--card-white);
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
            color: var(--text-muted);
            font-size: 14px;
            max-width: 400px;
            margin: 0 auto 20px;
            line-height: 1.5;
        }

        .toast-notification {
            position: fixed;
            top: 30px;
            right: 30px;
            background: var(--success-green);
            color: white;
            padding: 16px 24px;
            border-radius: var(--radius-lg);
            box-shadow: 0 8px 30px rgba(45, 157, 120, 0.3);
            z-index: var(--z-tooltip);
            animation: slideInRight 0.3s ease;
            display: flex;
            align-items: center;
            gap: 12px;
            max-width: 350px;
            font-family: 'Poppins', sans-serif;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .toast-notification.info {
            background: var(--info-blue);
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

        .toast-content {
            flex: 1;
            display: flex;
            align-items: center;
            gap: 12px;
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
            transition: all var(--transition-fast);
        }

        .toast-close:hover {
            background: rgba(255, 255, 255, 0.2);
        }

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

        @media (max-width: 992px) {
            .notifications-wrapper {
                padding: 25px 30px;
            }
            
            .page-header-main {
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
            
            .stat-card {
                min-height: 130px;
            }
        }

        @media (max-width: 768px) {
            .notifications-wrapper {
                padding: 20px;
            }
            
            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
            }
            
            .filter-toggle {
                width: 100%;
                overflow-x: auto;
                padding: 4px 8px;
            }
            
            .filter-toggle-btn {
                min-width: auto;
                padding: 10px 15px;
                font-size: 13px;
            }
            
            .notification-card {
                flex-direction: column;
                gap: 15px;
                padding: 20px;
            }
            
            .notification-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 5px;
            }
            
            .notification-icon {
                align-self: flex-start;
            }
            
            .notification-actions {
                opacity: 1;
                transform: translateX(0);
                align-self: flex-end;
            }
            
            .unread-indicator {
                top: 20px;
                right: 20px;
            }
            
            .toast-notification {
                top: 20px;
                right: 20px;
                left: 20px;
                max-width: none;
            }
        }

        @media (max-width: 576px) {
            .stats-grid {
                grid-template-columns: 1fr;
            }
            
            .header-title h1 {
                font-size: 24px;
            }
            
            .stat-value {
                font-size: 32px;
            }
            
            .notification-card {
                padding: 18px;
            }
            
            .stat-card {
                min-height: 120px;
                padding: 18px;
            }
        }

        @media (max-width: 480px) {
            .notifications-wrapper {
                padding: 15px;
            }
            
            .stat-card {
                padding: 16px;
            }
            
            .notification-meta {
                flex-direction: column;
                align-items: flex-start;
                gap: 8px;
            }
            
            .filter-toggle {
                padding: 4px;
            }
            
            .filter-toggle-btn {
                padding: 8px 12px;
                font-size: 12px;
            }
        }

        @media (prefers-reduced-motion: reduce) {
            * {
                animation-duration: 0.01ms !important;
                animation-iteration-count: 1 !important;
                transition-duration: 0.01ms !important;
            }
        }

        button:focus,
        .btn-mark-read:focus,
        .btn-filter:focus,
        .filter-toggle-btn:focus,
        .btn-notification-action:focus,
        .btn-load-more:focus {
            outline: 2px solid var(--primary-maroon);
            outline-offset: 2px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="notifications-wrapper">
        <div class="page-header-main">
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
                <div class="stat-label">
                    <i class="fas fa-bell"></i>
                    UNREAD
                </div>
                <div class="stat-value danger" id="unreadCount">2</div>
                <div class="stat-meta">
                    <span class="stat-subtext">Requires attention</span>
                    <span class="stat-trend up">
                        <i class="fas fa-arrow-up"></i>
                        New
                    </span>
                </div>
            </div>
            
            <div class="stat-card">
                <div class="stat-label">
                    <i class="fas fa-calendar-day"></i>
                    TODAY
                </div>
                <div class="stat-value info" id="todayCount">5</div>
                <div class="stat-meta">
                    <span class="stat-subtext">Since midnight</span>
                    <span class="stat-trend neutral">
                        <i class="fas fa-minus"></i>
                        Steady
                    </span>
                </div>
            </div>
            
            <div class="stat-card">
                <div class="stat-label">
                    <i class="fas fa-calendar-week"></i>
                    THIS WEEK
                </div>
                <div class="stat-value warning" id="weekCount">12</div>
                <div class="stat-meta">
                    <span class="stat-subtext">Past 7 days</span>
                    <span class="stat-trend down">
                        <i class="fas fa-arrow-down"></i>
                        18%
                    </span>
                </div>
            </div>
            
            <div class="stat-card">
                <div class="stat-label">
                    <i class="fas fa-layer-group"></i>
                    TOTAL
                </div>
                <div class="stat-value success" id="totalCount">47</div>
                <div class="stat-meta">
                    <span class="stat-subtext">All notifications</span>
                    <span class="stat-trend up">
                        <i class="fas fa-arrow-up"></i>
                        32%
                    </span>
                </div>
            </div>
        </div>

        <div class="filter-toggle">
            <button type="button" class="filter-toggle-btn active" data-filter="all">
                <i class="fas fa-globe"></i>
                All
            </button>
            <button type="button" class="filter-toggle-btn" data-filter="unread">
                <i class="fas fa-bell"></i>
                Unread
            </button>
            <button type="button" class="filter-toggle-btn" data-filter="orders">
                <i class="fas fa-shopping-bag"></i>
                Orders
            </button>
            <button type="button" class="filter-toggle-btn" data-filter="payments">
                <i class="fas fa-money-bill-wave"></i>
                Payments
            </button>
            <button type="button" class="filter-toggle-btn" data-filter="system">
                <i class="fas fa-cog"></i>
                System
            </button>
        </div>

        <div class="notifications-list" id="notificationsList">
            <div class="notification-card unread" data-type="order" data-category="orders">
                <div class="notification-icon order">
                    <i class="fas fa-shopping-bag"></i>
                </div>
                <div class="notification-content">
                    <div class="notification-header">
                        <h3 class="notification-title">New Order Available for Pickup</h3>
                        <span class="notification-time">2 minutes ago</span>
                    </div>
                    <p class="notification-message">
                        Order <strong>#ORD-12345</strong> from <strong>Starbucks - Paseo Center</strong> is waiting for acceptance. 
                        Estimated delivery distance: 2.3km. Estimated earnings: ₱85.50
                    </p>
                    <div class="notification-meta">
                        <span class="notification-badge badge-new">
                            <i class="fas fa-star"></i>
                            New
                        </span>
                        <span class="notification-badge badge-important">
                            <i class="fas fa-bolt"></i>
                            Urgent
                        </span>
                    </div>
                </div>
                <div class="notification-actions">
                    <button type="button" class="btn-notification-action read" title="Mark as read">
                        <i class="fas fa-check"></i>
                    </button>
                    <button type="button" class="btn-notification-action delete" title="Delete">
                        <i class="fas fa-trash"></i>
                    </button>
                </div>
                <div class="unread-indicator"></div>
            </div>

            <div class="notification-card unread" data-type="payment" data-category="payments">
                <div class="notification-icon payment">
                    <i class="fas fa-money-bill-wave"></i>
                </div>
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
                        <span class="notification-badge badge-success">
                            <i class="fas fa-check-circle"></i>
                            Completed
                        </span>
                    </div>
                </div>
                <div class="notification-actions">
                    <button type="button" class="btn-notification-action read" title="Mark as read">
                        <i class="fas fa-check"></i>
                    </button>
                    <button type="button" class="btn-notification-action delete" title="Delete">
                        <i class="fas fa-trash"></i>
                    </button>
                </div>
                <div class="unread-indicator"></div>
            </div>

            <div class="notification-card" data-type="alert" data-category="system">
                <div class="notification-icon alert">
                    <i class="fas fa-bullhorn"></i>
                </div>
                <div class="notification-content">
                    <div class="notification-header">
                        <h3 class="notification-title">Peak Hour Alert - High Demand Area</h3>
                        <span class="notification-time">2 hours ago</span>
                    </div>
                    <p class="notification-message">
                        High delivery demand detected in <strong>Makati CBD area</strong>. 
                        Surge pricing active: +25% bonus on all orders. Estimated waiting time: 15-20 minutes.
                    </p>
                    <div class="notification-meta">
                        <span class="notification-badge badge-info">
                            <i class="fas fa-info-circle"></i>
                            Alert
                        </span>
                    </div>
                </div>
                <div class="notification-actions">
                    <button type="button" class="btn-notification-action read" title="Mark as read">
                        <i class="fas fa-check"></i>
                    </button>
                    <button type="button" class="btn-notification-action delete" title="Delete">
                        <i class="fas fa-trash"></i>
                    </button>
                </div>
            </div>

            <div class="notification-card" data-type="completed" data-category="orders">
                <div class="notification-icon completed">
                    <i class="fas fa-check-circle"></i>
                </div>
                <div class="notification-content">
                    <div class="notification-header">
                        <h3 class="notification-title">Delivery Successfully Completed</h3>
                        <span class="notification-time">3 hours ago</span>
                    </div>
                    <p class="notification-message">
                        Order <strong>#ORD-12344</strong> delivered to <strong>Greensborough Dasma</strong>. 
                        Customer rating: ⭐⭐⭐⭐⭐ (5 stars). You earned <strong>₱85.00</strong> including bonus.
                    </p>
                    <div class="notification-meta">
                        <span class="notification-badge badge-success">
                            <i class="fas fa-award"></i>
                            Rated
                        </span>
                    </div>
                </div>
                <div class="notification-actions">
                    <button type="button" class="btn-notification-action read" title="Mark as read">
                        <i class="fas fa-check"></i>
                    </button>
                    <button type="button" class="btn-notification-action delete" title="Delete">
                        <i class="fas fa-trash"></i>
                    </button>
                </div>
            </div>

            <div class="notification-card" data-type="system" data-category="system">
                <div class="notification-icon system">
                    <i class="fas fa-cog"></i>
                </div>
                <div class="notification-content">
                    <div class="notification-header">
                        <h3 class="notification-title">System Maintenance Notice</h3>
                        <span class="notification-time">5 hours ago</span>
                    </div>
                    <p class="notification-message">
                        Scheduled system maintenance will occur tonight from <strong>1:00 AM to 3:00 AM</strong>. 
                        The app will be temporarily unavailable. Please complete all ongoing deliveries before this time.
                    </p>
                    <div class="notification-meta">
                        <span class="notification-badge badge-info">
                            <i class="fas fa-tools"></i>
                            Maintenance
                        </span>
                    </div>
                </div>
                <div class="notification-actions">
                    <button type="button" class="btn-notification-action read" title="Mark as read">
                        <i class="fas fa-check"></i>
                    </button>
                    <button type="button" class="btn-notification-action delete" title="Delete">
                        <i class="fas fa-trash"></i>
                    </button>
                </div>
            </div>
        </div>

        <div class="load-more-container">
            <button type="button" class="btn-load-more" id="loadMore">
                <i class="fas fa-redo"></i>
                Load More Notifications
            </button>
        </div>

        <div class="empty-state" id="emptyState" style="display: none;">
            <div class="empty-state-icon">
                <i class="far fa-bell-slash"></i>
            </div>
            <h3 class="empty-state-title">No Notifications Found</h3>
            <p class="empty-state-message">
                You're all caught up! When you have new orders, payments, or alerts, 
                they will appear here.
            </p>
            <button type="button" class="btn-mark-read" onclick="location.reload()">
                <i class="fas fa-sync"></i>
                Refresh Page
            </button>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const markAllReadBtn = document.getElementById('markAllRead');
            const filterToggleBtns = document.querySelectorAll('.filter-toggle-btn');
            const notificationCards = document.querySelectorAll('.notification-card');
            const readButtons = document.querySelectorAll('.btn-notification-action.read');
            const deleteButtons = document.querySelectorAll('.btn-notification-action.delete');
            const loadMoreBtn = document.getElementById('loadMore');
            const notificationsList = document.getElementById('notificationsList');
            const emptyState = document.getElementById('emptyState');
            const unreadCountElement = document.getElementById('unreadCount');
            const todayCountElement = document.getElementById('todayCount');
            const weekCountElement = document.getElementById('weekCount');
            const totalCountElement = document.getElementById('totalCount');

            let unreadCount = parseInt(unreadCountElement.textContent);
            let todayCount = parseInt(todayCountElement.textContent);
            let weekCount = parseInt(weekCountElement.textContent);
            let totalCount = parseInt(totalCountElement.textContent);

            if (markAllReadBtn) {
                markAllReadBtn.addEventListener('click', function () {
                    const unreadNotifications = document.querySelectorAll('.notification-card.unread');

                    if (unreadNotifications.length === 0) {
                        showToastNotification('All notifications are already marked as read', 'info');
                        return;
                    }

                    unreadNotifications.forEach(notification => {
                        notification.classList.remove('unread');
                        const indicator = notification.querySelector('.unread-indicator');
                        if (indicator) indicator.remove();
                    });

                    unreadCount = 0;
                    todayCount = Math.max(0, todayCount - unreadNotifications.length);
                    weekCount = Math.max(0, weekCount - unreadNotifications.length);
                    updateCounts();

                    showToastNotification(`Marked ${unreadNotifications.length} notifications as read`, 'success');
                });
            }

            filterToggleBtns.forEach(button => {
                button.addEventListener('click', function () {
                    filterToggleBtns.forEach(btn => btn.classList.remove('active'));
                    this.classList.add('active');

                    const filter = this.getAttribute('data-filter');
                    filterNotifications(filter);
                });
            });

            function filterNotifications(filter) {
                let visibleCount = 0;

                notificationCards.forEach(card => {
                    const type = card.getAttribute('data-type');
                    const category = card.getAttribute('data-category');
                    const isUnread = card.classList.contains('unread');

                    switch (filter) {
                        case 'all':
                            card.style.display = 'flex';
                            visibleCount++;
                            break;
                        case 'unread':
                            card.style.display = isUnread ? 'flex' : 'none';
                            if (isUnread) visibleCount++;
                            break;
                        case 'orders':
                            card.style.display = category === 'orders' ? 'flex' : 'none';
                            if (category === 'orders') visibleCount++;
                            break;
                        case 'payments':
                            card.style.display = category === 'payments' ? 'flex' : 'none';
                            if (category === 'payments') visibleCount++;
                            break;
                        case 'system':
                            card.style.display = category === 'system' ? 'flex' : 'none';
                            if (category === 'system') visibleCount++;
                            break;
                        default:
                            card.style.display = 'flex';
                            visibleCount++;
                    }
                });

                if (visibleCount === 0) {
                    notificationsList.style.display = 'none';
                    emptyState.style.display = 'block';
                    loadMoreBtn.style.display = 'none';
                } else {
                    notificationsList.style.display = 'flex';
                    emptyState.style.display = 'none';
                    loadMoreBtn.style.display = 'flex';
                }

                showToastNotification(`Showing ${filter} notifications`, 'info');
            }

            readButtons.forEach(button => {
                button.addEventListener('click', function (e) {
                    e.stopPropagation();
                    const notification = this.closest('.notification-card');

                    if (notification.classList.contains('unread')) {
                        notification.classList.remove('unread');
                        const indicator = notification.querySelector('.unread-indicator');
                        if (indicator) indicator.remove();

                        unreadCount = Math.max(0, unreadCount - 1);
                        updateCounts();

                        showToastNotification('Notification marked as read', 'success');
                    } else {
                        showToastNotification('Notification is already read', 'info');
                    }
                });
            });

            deleteButtons.forEach(button => {
                button.addEventListener('click', function (e) {
                    e.stopPropagation();
                    const notification = this.closest('.notification-card');
                    const isUnread = notification.classList.contains('unread');

                    showToastNotification('Deleting notification...', 'info');

                    notification.style.animation = 'slideOutRight 0.3s ease';
                    notification.style.opacity = '0';

                    setTimeout(() => {
                        notification.remove();

                        if (isUnread) {
                            unreadCount = Math.max(0, unreadCount - 1);
                        }
                        todayCount = Math.max(0, todayCount - 1);
                        weekCount = Math.max(0, weekCount - 1);
                        totalCount = Math.max(0, totalCount - 1);
                        updateCounts();

                        if (document.querySelectorAll('.notification-card').length === 0) {
                            notificationsList.style.display = 'none';
                            emptyState.style.display = 'block';
                            loadMoreBtn.style.display = 'none';
                        }

                        showToastNotification('Notification deleted', 'success');
                    }, 300);
                });
            });

            notificationCards.forEach(card => {
                card.addEventListener('click', function (e) {
                    if (e.target.closest('.btn-notification-action')) {
                        return;
                    }

                    const title = this.querySelector('.notification-title').textContent;

                    showToastNotification(`Viewing: ${title}`, 'info');

                    if (this.classList.contains('unread')) {
                        this.classList.remove('unread');
                        const indicator = this.querySelector('.unread-indicator');
                        if (indicator) indicator.remove();

                        unreadCount = Math.max(0, unreadCount - 1);
                        updateCounts();
                    }
                });
            });

            if (loadMoreBtn) {
                loadMoreBtn.addEventListener('click', function () {
                    const originalText = this.innerHTML;
                    this.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Loading...';
                    this.disabled = true;

                    setTimeout(() => {
                        const sampleNotifications = [
                            {
                                type: 'order',
                                category: 'orders',
                                icon: 'shopping-bag',
                                iconClass: 'order',
                                title: 'Order Updated - New Instructions',
                                time: '6 hours ago',
                                message: 'Order #ORD-12343 has updated delivery instructions. Please check the updated address and contact details.',
                                badges: ['info'],
                                unread: false
                            },
                            {
                                type: 'payment',
                                category: 'payments',
                                icon: 'money-check',
                                iconClass: 'payment',
                                title: 'Bonus Payment Processed',
                                time: 'Yesterday',
                                message: 'Weekly performance bonus of ₱250.00 has been added to your balance for completing 15+ peak hour deliveries.',
                                badges: ['success'],
                                unread: false
                            }
                        ];

                        sampleNotifications.forEach((note, index) => {
                            const newCard = createNotificationCard(note, index);
                            notificationsList.appendChild(newCard);

                            addEventListenersToCard(newCard);
                        });

                        totalCount += sampleNotifications.length;
                        weekCount += sampleNotifications.length;
                        updateCounts();

                        this.innerHTML = originalText;
                        this.disabled = false;

                        showToastNotification(`Loaded ${sampleNotifications.length} more notifications`, 'success');
                    }, 1500);
                });
            }

            function createNotificationCard(data, index) {
                const card = document.createElement('div');
                card.className = `notification-card ${data.unread ? 'unread' : ''}`;
                card.setAttribute('data-type', data.type);
                card.setAttribute('data-category', data.category);
                card.style.animationDelay = `${0.5 + (index * 0.1)}s`;

                const badgeHTML = data.badges.map(badge => {
                    const badgeText = badge === 'new' ? 'New' :
                        badge === 'important' ? 'Urgent' :
                            badge === 'success' ? 'Completed' : 'Info';
                    const badgeIcon = badge === 'new' ? 'star' :
                        badge === 'important' ? 'bolt' :
                            badge === 'success' ? 'check-circle' : 'info-circle';

                    return `<span class="notification-badge badge-${badge}">
                                <i class="fas fa-${badgeIcon}"></i>
                                ${badgeText}
                            </span>`;
                }).join('');

                const unreadIndicator = data.unread ? '<div class="unread-indicator"></div>' : '';

                card.innerHTML = `
                    <div class="notification-icon ${data.iconClass}">
                        <i class="fas fa-${data.icon}"></i>
                    </div>
                    <div class="notification-content">
                        <div class="notification-header">
                            <h3 class="notification-title">${data.title}</h3>
                            <span class="notification-time">${data.time}</span>
                        </div>
                        <p class="notification-message">${data.message}</p>
                        <div class="notification-meta">
                            ${badgeHTML}
                        </div>
                    </div>
                    <div class="notification-actions">
                        <button type="button" class="btn-notification-action read" title="Mark as read">
                            <i class="fas fa-check"></i>
                        </button>
                        <button type="button" class="btn-notification-action delete" title="Delete">
                            <i class="fas fa-trash"></i>
                        </button>
                    </div>
                    ${unreadIndicator}
                `;

                return card;
            }

            function addEventListenersToCard(card) {
                const readBtn = card.querySelector('.btn-notification-action.read');
                const deleteBtn = card.querySelector('.btn-notification-action.delete');

                if (readBtn) {
                    readBtn.addEventListener('click', function (e) {
                        e.stopPropagation();
                        if (card.classList.contains('unread')) {
                            card.classList.remove('unread');
                            const indicator = card.querySelector('.unread-indicator');
                            if (indicator) indicator.remove();

                            unreadCount = Math.max(0, unreadCount - 1);
                            updateCounts();
                            showToastNotification('Notification marked as read', 'success');
                        }
                    });
                }

                if (deleteBtn) {
                    deleteBtn.addEventListener('click', function (e) {
                        e.stopPropagation();

                        showToastNotification('Deleting notification...', 'info');

                        card.style.animation = 'slideOutRight 0.3s ease';
                        card.style.opacity = '0';

                        setTimeout(() => {
                            card.remove();
                            totalCount = Math.max(0, totalCount - 1);
                            weekCount = Math.max(0, weekCount - 1);
                            updateCounts();
                            showToastNotification('Notification deleted', 'success');
                        }, 300);
                    });
                }

                card.addEventListener('click', function (e) {
                    if (!e.target.closest('.btn-notification-action')) {
                        const title = this.querySelector('.notification-title').textContent;
                        showToastNotification(`Viewing: ${title}`, 'info');

                        if (this.classList.contains('unread')) {
                            this.classList.remove('unread');
                            const indicator = this.querySelector('.unread-indicator');
                            if (indicator) indicator.remove();

                            unreadCount = Math.max(0, unreadCount - 1);
                            updateCounts();
                        }
                    }
                });
            }

            function updateCounts() {
                if (unreadCountElement) unreadCountElement.textContent = unreadCount;
                if (todayCountElement) todayCountElement.textContent = todayCount;
                if (weekCountElement) weekCountElement.textContent = weekCount;
                if (totalCountElement) totalCountElement.textContent = totalCount;

                updateStatCardValues();
            }

            function updateStatCardValues() {
                const unreadValue = document.querySelector('.stat-card:nth-child(1) .stat-value');
                const todayValue = document.querySelector('.stat-card:nth-child(2) .stat-value');
                const weekValue = document.querySelector('.stat-card:nth-child(3) .stat-value');
                const totalValue = document.querySelector('.stat-card:nth-child(4) .stat-value');

                if (unreadValue) {
                    if (unreadCount === 0) {
                        unreadValue.classList.remove('danger');
                        unreadValue.classList.add('success');
                    } else if (!unreadValue.classList.contains('danger')) {
                        unreadValue.classList.remove('success');
                        unreadValue.classList.add('danger');
                    }
                }
            }

            function showToastNotification(message, type = 'success') {
                const existingToast = document.querySelector('.toast-notification');
                if (existingToast) {
                    existingToast.style.animation = 'slideOutRight 0.3s ease';
                    setTimeout(() => {
                        if (existingToast.parentNode) {
                            existingToast.parentNode.removeChild(existingToast);
                        }
                    }, 300);
                }

                const toast = document.createElement('div');
                toast.className = `toast-notification ${type}`;
                toast.innerHTML = `
                    <div class="toast-content">
                        <i class="fas ${type === 'success' ? 'fa-check-circle' :
                        type === 'info' ? 'fa-info-circle' :
                            type === 'warning' ? 'fa-exclamation-triangle' :
                                'fa-exclamation-circle'}"></i>
                        <span>${message}</span>
                    </div>
                    <button type="button" class="toast-close">
                        <i class="fas fa-times"></i>
                    </button>
                `;

                document.body.appendChild(toast);

                toast.querySelector('.toast-close').addEventListener('click', function () {
                    toast.style.animation = 'slideOutRight 0.3s ease';
                    setTimeout(() => {
                        if (toast.parentNode) {
                            toast.parentNode.removeChild(toast);
                        }
                    }, 300);
                });

                setTimeout(() => {
                    if (toast.parentNode) {
                        toast.style.animation = 'slideOutRight 0.3s ease';
                        setTimeout(() => {
                            if (toast.parentNode) {
                                toast.parentNode.removeChild(toast);
                            }
                        }, 300);
                    }
                }, 4000);
            }

            updateStatCardValues();
        });
    </script>
</asp:Content>