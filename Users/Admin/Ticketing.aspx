<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Admin.Master" AutoEventWireup="true" CodeBehind="Ticketing.aspx.cs" Inherits="TasteNet.Users.Admin.Ticketing" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        :root {
            --primary-maroon: #6b0d1e;
            --primary-maroon-dark: #5a0b19;
            --primary-maroon-light: rgba(107, 13, 30, 0.1);
            --soft-cream: #fffaf3;
            --text-dark: #4a0e0e;
            --muted-text: #8a6d6d;
            --success-green: #2d9d78;
            --success-green-light: #e6f4f1;
            --success-green-dark: #1e7d5f;
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
            --accent-teal: #14b8a6;
            --accent-teal-light: #f0fdfa;
            --accent-purple: #8b5cf6;
            --accent-purple-light: #f5f3ff;
            
            --border-light: #e2d1d1;
            --border-hover: #d4b8b8;
            --bg-hover: #fefaf5;
            --bg-light: #f3ebe0;
            --bg-lighter: #f9f4ee;
            --bg-column: #f8f3ed;
            
            --card-shadow: 0 10px 30px rgba(107, 13, 30, 0.05);
            --card-shadow-hover: 0 15px 40px rgba(107, 13, 30, 0.12);
            --card-shadow-lifted: 0 20px 50px rgba(107, 13, 30, 0.15);
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

        * {
            box-sizing: border-box;
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

        .ticketing-container {
            background: var(--soft-cream) !important;
            padding: 25px 35px;
            max-width: 1400px;
            margin: 0 auto;
            min-height: 100vh;
            box-sizing: border-box;
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
            animation: fadeIn 0.5s ease-out;
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

        .status-tabs-container {
            display: flex;
            gap: 10px;
            align-items: center;
            background: white;
            padding: 4px;
            border-radius: var(--radius-md);
            box-shadow: var(--card-shadow);
            border: 1px solid var(--border-light);
        }

        .status-tab {
            padding: 10px 20px;
            border-radius: var(--radius-sm);
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            transition: all var(--transition-base);
            display: flex;
            align-items: center;
            gap: 8px;
            position: relative;
            overflow: hidden;
        }

        .status-tab::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: var(--primary-maroon);
            opacity: 0;
            transition: opacity var(--transition-base);
            z-index: -1;
        }

        .status-tab.active {
            background: var(--primary-maroon);
            color: white;
            box-shadow: var(--button-shadow);
        }

        .status-tab:not(.active):hover {
            background: var(--bg-hover);
            transform: translateY(-1px);
        }

        .status-badge {
            background: rgba(255, 255, 255, 0.2);
            padding: 2px 8px;
            border-radius: 12px;
            font-size: 11px;
            font-weight: 600;
            min-width: 24px;
            text-align: center;
        }

        .status-tab.active .status-badge {
            background: rgba(255, 255, 255, 0.3);
        }

        .tickets-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 25px;
            margin-top: 20px;
            animation: fadeIn 0.6s ease-out;
        }

        .ticket-card {
            background: white;
            border-radius: var(--radius-lg);
            overflow: hidden;
            box-shadow: var(--card-shadow);
            transition: all var(--transition-base);
            position: relative;
            border: 1px solid var(--border-light);
            animation: slideInUp 0.4s ease-out;
            animation-fill-mode: both;
        }

        .ticket-card:nth-child(1) { animation-delay: 0.1s; }
        .ticket-card:nth-child(2) { animation-delay: 0.2s; }
        .ticket-card:nth-child(3) { animation-delay: 0.3s; }
        .ticket-card:nth-child(4) { animation-delay: 0.4s; }
        .ticket-card:nth-child(5) { animation-delay: 0.5s; }

        .ticket-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--card-shadow-lifted);
            border-color: var(--primary-maroon-light);
        }

        .ticket-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 4px;
            height: 100%;
            background: var(--primary-maroon);
            opacity: 0;
            transition: opacity var(--transition-base);
        }

        .ticket-card:hover::before {
            opacity: 1;
        }

        .ticket-header {
            background: linear-gradient(135deg, var(--primary-maroon) 0%, var(--primary-maroon-dark) 100%);
            color: white;
            padding: 18px;
            position: relative;
            overflow: hidden;
        }

        .ticket-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(
                45deg,
                transparent 30%,
                rgba(255, 255, 255, 0.1) 50%,
                transparent 70%
            );
            animation: shimmer 3s infinite linear;
        }

        .ticket-title {
            font-size: 16px;
            font-weight: 700;
            margin-bottom: 4px;
            display: flex;
            align-items: center;
            gap: 8px;
            position: relative;
            z-index: 1;
        }

        .ticket-time {
            font-size: 12px;
            opacity: 0.9;
            font-weight: 400;
            margin: 0;
            position: relative;
            z-index: 1;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .ticket-time i {
            font-size: 11px;
        }

        .ticket-action {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            background: rgba(255, 255, 255, 0.2);
            width: 30px;
            height: 30px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all var(--transition-base);
            z-index: 2;
        }

        .ticket-action:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: translateY(-50%) scale(1.1);
        }

        .ticket-body {
            padding: 20px;
            background: var(--bg-lighter);
        }

        .ticket-info {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
            padding-bottom: 12px;
            border-bottom: 1px solid var(--border-light);
        }

        .order-type {
            background: var(--accent-purple-light);
            color: var(--accent-purple);
            padding: 6px 12px;
            border-radius: var(--radius-sm);
            font-size: 12px;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .customer-name {
            font-weight: 600;
            font-size: 14px;
            color: var(--text-dark);
        }

        .ticket-items {
            margin-bottom: 20px;
            font-size: 13px;
            color: var(--text-dark);
            line-height: 1.6;
        }

        .item-row {
            display: flex;
            justify-content: space-between;
            padding: 8px 0;
            border-bottom: 1px dashed var(--border-light);
        }

        .item-row:last-child {
            border-bottom: none;
        }

        .item-name {
            font-weight: 500;
        }

        .item-quantity {
            color: var(--primary-maroon);
            font-weight: 700;
            background: var(--accent-pink);
            padding: 2px 8px;
            border-radius: 10px;
            min-width: 24px;
            text-align: center;
        }

        .ticket-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-top: 15px;
            border-top: 1px solid var(--border-light);
        }

        .ticket-actions {
            display: flex;
            gap: 10px;
        }

        .action-btn {
            padding: 10px 20px;
            border-radius: var(--radius-md);
            border: none;
            font-family: 'Poppins', sans-serif;
            font-weight: 600;
            font-size: 13px;
            cursor: pointer;
            transition: all var(--transition-base);
            display: flex;
            align-items: center;
            gap: 8px;
            position: relative;
            overflow: hidden;
            z-index: 1;
            min-width: 120px;
            justify-content: center;
        }

        .action-btn::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 0;
            height: 0;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.3);
            transform: translate(-50%, -50%);
            transition: width 0.6s, height 0.6s;
            z-index: -1;
        }

        .action-btn:active::before {
            width: 200px;
            height: 200px;
        }

        .btn-start {
            background: var(--accent-teal);
            color: white;
            box-shadow: 0 4px 12px rgba(20, 184, 166, 0.25);
        }

        .btn-start:hover {
            background: #0da594;
            transform: translateY(-2px);
            box-shadow: 0 6px 18px rgba(20, 184, 166, 0.35);
        }

        .btn-done {
            background: var(--success-green);
            color: white;
            box-shadow: 0 4px 12px rgba(45, 157, 120, 0.25);
        }

        .btn-done:hover {
            background: var(--success-green-dark);
            transform: translateY(-2px);
            box-shadow: 0 6px 18px rgba(45, 157, 120, 0.35);
        }

        .btn-delete {
            background: white;
            color: var(--danger-red);
            border: 1px solid var(--danger-red);
        }

        .btn-delete:hover {
            background: var(--danger-red);
            color: white;
        }

        .rush-badge {
            background: var(--danger-red-light);
            color: var(--danger-red);
            padding: 4px 10px;
            border-radius: 12px;
            font-size: 10px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            display: inline-flex;
            align-items: center;
            gap: 4px;
            margin-left: 8px;
            animation: pulse 2s infinite;
        }

        .delivery-badge {
            background: var(--accent-blue);
            color: var(--accent-blue-dark);
        }

        .table-badge {
            background: var(--accent-yellow-light);
            color: var(--accent-yellow-dark);
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        @keyframes slideInUp {
            from {
                opacity: 0;
                transform: translateY(10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes shimmer {
            0% { transform: translateX(-100%); }
            100% { transform: translateX(100%); }
        }

        @keyframes pulse {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.7; }
        }

        @media (max-width: 1200px) {
            .ticketing-container {
                padding: 20px;
            }
            
            .tickets-grid {
                grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            }
        }

        @media (max-width: 992px) {
            .page-header-main {
                flex-direction: column;
                align-items: stretch;
                gap: 15px;
            }
            
            .status-tabs-container {
                width: 100%;
                justify-content: center;
            }
            
            .ticket-footer {
                flex-direction: column;
                gap: 15px;
                align-items: stretch;
            }
            
            .ticket-actions {
                width: 100%;
            }
            
            .action-btn {
                width: 100%;
            }
        }

        @media (max-width: 768px) {
            .ticketing-container {
                padding: 15px;
            }
            
            .header-title h1 {
                font-size: 24px;
            }
            
            .tickets-grid {
                grid-template-columns: 1fr;
            }
            
            .ticket-info {
                flex-direction: column;
                gap: 10px;
                align-items: flex-start;
            }
        }

        @media (max-width: 480px) {
            .ticketing-container {
                padding: 12px;
            }
            
            .status-tab {
                padding: 8px 15px;
                font-size: 12px;
            }
            
            .ticket-header {
                padding: 15px;
            }
            
            .ticket-body {
                padding: 15px;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="ticketing-container">
        <div class="page-header-main">
            <div class="header-title">
                <h1>Ticket Management</h1>
                <p>Manage and track order tickets in real-time</p>
            </div>
            
            <div class="status-tabs-container">
                <div class="status-tab active">
                    <i class="fas fa-inbox"></i>
                    Open Tickets
                    <span class="status-badge">4</span>
                </div>
                <div class="status-tab">
                    <i class="fas fa-check-circle"></i>
                    Complete
                    <span class="status-badge">2</span>
                </div>
                <div class="status-tab">
                    <i class="fas fa-history"></i>
                    All Tickets
                    <span class="status-badge">6</span>
                </div>
            </div>
        </div>

        <div class="tickets-grid">
            <div class="ticket-card">
                <div class="ticket-header">
                    <div class="ticket-title">
                        <i class="fas fa-receipt"></i>
                        Order #001
                        <span class="rush-badge">
                            <i class="fas fa-bolt"></i>
                            RUSH
                        </span>
                    </div>
                    <div class="ticket-time">
                        <i class="far fa-clock"></i>
                        1:00 PM
                    </div>
                    <div class="ticket-action" onclick="deleteTicket(this)">
                        <i class="fas fa-trash-alt"></i>
                    </div>
                </div>
                
                <div class="ticket-body">
                    <div class="ticket-info">
                        <span class="order-type delivery-badge">
                            <i class="fas fa-motorcycle"></i>
                            Delivery
                        </span>
                        <span class="customer-name">Jay-r Reyes</span>
                    </div>
                    
                    <div class="ticket-items">
                        <div class="item-row">
                            <span class="item-name">Tofu Sisig</span>
                            <span class="item-quantity">1</span>
                        </div>
                        <div class="item-row">
                            <span class="item-name">Pork Sisig</span>
                            <span class="item-quantity">1</span>
                        </div>
                        <div class="item-row">
                            <span class="item-name">Coke (500ml)</span>
                            <span class="item-quantity">1</span>
                        </div>
                    </div>
                    
                    <div class="ticket-footer">
                        <div class="ticket-actions">
                            <button type="button" class="action-btn btn-done">
                                <i class="fas fa-check-double"></i>
                                Mark as Done
                            </button>
                        </div>
                    </div>
                </div>
            </div>

            <div class="ticket-card">
                <div class="ticket-header">
                    <div class="ticket-title">
                        <i class="fas fa-receipt"></i>
                        Order #002
                    </div>
                    <div class="ticket-time">
                        <i class="far fa-clock"></i>
                        2:00 PM
                    </div>
                    <div class="ticket-action" onclick="deleteTicket(this)">
                        <i class="fas fa-trash-alt"></i>
                    </div>
                </div>
                
                <div class="ticket-body">
                    <div class="ticket-info">
                        <span class="order-type table-badge">
                            <i class="fas fa-utensils"></i>
                            Table 001
                        </span>
                        <span class="customer-name">George Luna</span>
                    </div>
                    
                    <div class="ticket-items">
                        <div class="item-row">
                            <span class="item-name">Tofu Sisig</span>
                            <span class="item-quantity">1</span>
                        </div>
                        <div class="item-row">
                            <span class="item-name">Goto</span>
                            <span class="item-quantity">1</span>
                        </div>
                        <div class="item-row">
                            <span class="item-name">Coke</span>
                            <span class="item-quantity">1</span>
                        </div>
                    </div>
                    
                    <div class="ticket-footer">
                        <div class="ticket-actions">
                            <button type="button" class="action-btn btn-done">
                                <i class="fas fa-check-double"></i>
                                Mark as Done
                            </button>
                        </div>
                    </div>
                </div>
            </div>

            <div class="ticket-card">
                <div class="ticket-header">
                    <div class="ticket-title">
                        <i class="fas fa-receipt"></i>
                        Order #003
                        <span class="rush-badge">
                            <i class="fas fa-bolt"></i>
                            RUSH
                        </span>
                    </div>
                    <div class="ticket-time">
                        <i class="far fa-clock"></i>
                        3:00 PM
                    </div>
                    <div class="ticket-action" onclick="deleteTicket(this)">
                        <i class="fas fa-trash-alt"></i>
                    </div>
                </div>
                
                <div class="ticket-body">
                    <div class="ticket-info">
                        <span class="order-type table-badge">
                            <i class="fas fa-utensils"></i>
                            Table 002
                        </span>
                        <span class="customer-name">Bryle Andres</span>
                    </div>
                    
                    <div class="ticket-items">
                        <div class="item-row">
                            <span class="item-name">Pares</span>
                            <span class="item-quantity">1</span>
                        </div>
                        <div class="item-row">
                            <span class="item-name">Mami</span>
                            <span class="item-quantity">1</span>
                        </div>
                        <div class="item-row">
                            <span class="item-name">Coke</span>
                            <span class="item-quantity">2</span>
                        </div>
                    </div>
                    
                    <div class="ticket-footer">
                        <div class="ticket-actions">
                            <button type="button" class="action-btn btn-start">
                                <i class="fas fa-play"></i>
                                Start Preparation
                            </button>
                        </div>
                    </div>
                </div>
            </div>

            <div class="ticket-card">
                <div class="ticket-header">
                    <div class="ticket-title">
                        <i class="fas fa-receipt"></i>
                        Order #004
                    </div>
                    <div class="ticket-time">
                        <i class="far fa-clock"></i>
                        1:00 PM
                    </div>
                    <div class="ticket-action" onclick="deleteTicket(this)">
                        <i class="fas fa-trash-alt"></i>
                    </div>
                </div>
                
                <div class="ticket-body">
                    <div class="ticket-info">
                        <span class="order-type delivery-badge">
                            <i class="fas fa-motorcycle"></i>
                            Delivery
                        </span>
                        <span class="customer-name">Lalaine Gomez</span>
                    </div>
                    
                    <div class="ticket-items">
                        <div class="item-row">
                            <span class="item-name">Tofu Sisig</span>
                            <span class="item-quantity">1</span>
                        </div>
                        <div class="item-row">
                            <span class="item-name">Pork Sisig</span>
                            <span class="item-quantity">1</span>
                        </div>
                        <div class="item-row">
                            <span class="item-name">Coke</span>
                            <span class="item-quantity">1</span>
                        </div>
                        <div class="item-row">
                            <span class="item-name">Extra Rice</span>
                            <span class="item-quantity">2</span>
                        </div>
                    </div>
                    
                    <div class="ticket-footer">
                        <div class="ticket-actions">
                            <button type="button" class="action-btn btn-start">
                                <i class="fas fa-play"></i>
                                Start Preparation
                            </button>
                        </div>
                    </div>
                </div>
            </div>

            <div class="ticket-card">
                <div class="ticket-header">
                    <div class="ticket-title">
                        <i class="fas fa-receipt"></i>
                        Order #005
                    </div>
                    <div class="ticket-time">
                        <i class="far fa-clock"></i>
                        1:00 PM
                    </div>
                    <div class="ticket-action" onclick="deleteTicket(this)">
                        <i class="fas fa-trash-alt"></i>
                    </div>
                </div>
                
                <div class="ticket-body">
                    <div class="ticket-info">
                        <span class="order-type table-badge">
                            <i class="fas fa-utensils"></i>
                            Table 003
                        </span>
                        <span class="customer-name">Lalaine Gomez</span>
                    </div>
                    
                    <div class="ticket-items">
                        <div class="item-row">
                            <span class="item-name">Pork Sisig</span>
                            <span class="item-quantity">1</span>
                        </div>
                        <div class="item-row">
                            <span class="item-name">Extra Rice</span>
                            <span class="item-quantity">2</span>
                        </div>
                    </div>
                    
                    <div class="ticket-footer">
                        <div class="ticket-actions">
                            <button type="button" class="action-btn btn-start">
                                <i class="fas fa-play"></i>
                                Start Preparation
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const statusTabs = document.querySelectorAll('.status-tab');
            const startButtons = document.querySelectorAll('.btn-start');
            const doneButtons = document.querySelectorAll('.btn-done');
            const deleteButtons = document.querySelectorAll('.ticket-action');

            function showNotification(message, type) {
                const notification = document.createElement('div');
                notification.style.cssText = `
                    position: fixed;
                    top: 20px;
                    right: 20px;
                    padding: 15px 20px;
                    background: ${type === 'success' ? 'var(--success-green)' :
                        type === 'info' ? 'var(--accent-blue-dark)' :
                            type === 'warning' ? 'var(--warning-orange)' :
                                'var(--danger-red)'};
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
                    font-weight: 500;
                `;
                notification.innerHTML = `
                    <i class="fas ${type === 'success' ? 'fa-check-circle' :
                        type === 'info' ? 'fa-info-circle' :
                            type === 'warning' ? 'fa-exclamation-circle' :
                                'fa-times-circle'}"></i>
                    <span>${message}</span>
                `;

                document.body.appendChild(notification);

                setTimeout(() => {
                    notification.style.animation = 'slideInRight 0.3s ease reverse';
                    setTimeout(() => {
                        if (notification.parentNode) {
                            document.body.removeChild(notification);
                        }
                    }, 300);
                }, 3000);

                const style = document.createElement('style');
                style.textContent = `
                    @keyframes slideInRight {
                        from { transform: translateX(100%); opacity: 0; }
                        to { transform: translateX(0); opacity: 1; }
                    }
                `;
                document.head.appendChild(style);
            }

            function startTicketPreparation(ticketCard) {
                const orderId = ticketCard.querySelector('.ticket-title').textContent.trim();
                const btn = ticketCard.querySelector('.btn-start');
                
                btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Starting...';
                btn.disabled = true;
                
                setTimeout(() => {
                    btn.innerHTML = '<i class="fas fa-check"></i> Started';
                    btn.className = 'action-btn btn-done';
                    btn.onclick = () => completeTicket(ticketCard);
                    
                    showNotification(`${orderId} preparation started`, 'success');
                }, 1500);
            }

            function completeTicket(ticketCard) {
                const orderId = ticketCard.querySelector('.ticket-title').textContent.trim();
                const btn = ticketCard.querySelector('.btn-done');
                
                btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Completing...';
                btn.disabled = true;
                
                setTimeout(() => {
                    ticketCard.style.animation = 'slideInRight 0.3s ease reverse';
                    setTimeout(() => {
                        ticketCard.remove();
                        
                        const openBadge = document.querySelector('.status-tab.active .status-badge');
                        openBadge.textContent = parseInt(openBadge.textContent) - 1;
                        
                        const completeTab = document.querySelectorAll('.status-tab')[1];
                        const completeBadge = completeTab.querySelector('.status-badge');
                        completeBadge.textContent = parseInt(completeBadge.textContent) + 1;
                        
                        showNotification(`${orderId} marked as completed`, 'success');
                    }, 300);
                }, 1500);
            }

            function deleteTicket(ticketCard) {
                const orderId = ticketCard.querySelector('.ticket-title').textContent.trim();
                
                if (confirm(`Are you sure you want to delete ${orderId}?`)) {
                    ticketCard.style.animation = 'slideInRight 0.3s ease reverse';
                    setTimeout(() => {
                        ticketCard.remove();
                        
                        const openBadge = document.querySelector('.status-tab.active .status-badge');
                        openBadge.textContent = parseInt(openBadge.textContent) - 1;
                        
                        showNotification(`${orderId} deleted successfully`, 'info');
                    }, 300);
                }
            }

            statusTabs.forEach(tab => {
                tab.addEventListener('click', function () {
                    statusTabs.forEach(t => t.classList.remove('active'));
                    this.classList.add('active');
                    showNotification(`Showing ${this.textContent.trim()} tickets`, 'info');
                });
            });

            startButtons.forEach(btn => {
                btn.addEventListener('click', function () {
                    const ticketCard = this.closest('.ticket-card');
                    startTicketPreparation(ticketCard);
                });
            });

            doneButtons.forEach(btn => {
                btn.addEventListener('click', function () {
                    const ticketCard = this.closest('.ticket-card');
                    completeTicket(ticketCard);
                });
            });

            setInterval(() => {
                const timeElements = document.querySelectorAll('.ticket-time');
                timeElements.forEach(timeEl => {
                    const timeText = timeEl.textContent;
                    if (timeText.includes('min')) {
                        const minutes = parseInt(timeText.match(/\d+/)[0]);
                        timeEl.innerHTML = `<i class="far fa-clock"></i> ${minutes + 1} min ago`;
                    }
                });
            }, 60000);
        });
    </script>
</asp:Content>