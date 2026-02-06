<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Admin.Master" AutoEventWireup="true" CodeBehind="Ticketing.aspx.cs" Inherits="TasteNet.Users.Admin.Ticketing" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        body.ticketing-page,
        body.ticketing-page form,
        body.ticketing-page .ticketing-container {
            --primary-maroon: #6b0d1e !important;
            --primary-maroon-dark: #5a0b19 !important;
            --primary-maroon-light: rgba(107, 13, 30, 0.1) !important;
            --soft-cream: #fffaf3 !important;
            --text-dark: #4a0e0e !important;
            --muted-text: #8a6d6d !important;
            --success-green: #2d9d78 !important;
            --success-green-light: #e6f4f1 !important;
            --success-green-dark: #1e7d5f !important;
            --warning-orange: #d97706 !important;
            --warning-orange-light: #fff3e6 !important;
            --danger-red: #b91c1c !important;
            --danger-red-light: #fee2e2 !important;
            --accent-yellow: #ffcc00 !important;
            --accent-yellow-dark: #e6b800 !important;
            --accent-yellow-light: #fff9e6 !important;
            --accent-pink: #f9ecee !important;
            --accent-blue: #eff6ff !important;
            --accent-blue-dark: #3b82f6 !important;
            --accent-teal: #14b8a6 !important;
            --accent-teal-light: #f0fdfa !important;
            --accent-purple: #8b5cf6 !important;
            --accent-purple-light: #f5f3ff !important;
            
            --border-light: #e2d1d1 !important;
            --border-hover: #d4b8b8 !important;
            --bg-hover: #fefaf5 !important;
            --bg-light: #f3ebe0 !important;
            --bg-lighter: #f9f4ee !important;
            --bg-column: #f8f3ed !important;
            
            --card-shadow: 0 10px 30px rgba(107, 13, 30, 0.05) !important;
            --card-shadow-hover: 0 15px 40px rgba(107, 13, 30, 0.12) !important;
            --card-shadow-lifted: 0 20px 50px rgba(107, 13, 30, 0.15) !important;
            --button-shadow: 0 4px 12px rgba(107, 13, 30, 0.2) !important;
            --button-shadow-hover: 0 6px 18px rgba(107, 13, 30, 0.3) !important;
            
            --radius-sm: 8px !important;
            --radius-md: 10px !important;
            --radius-lg: 12px !important;
            --radius-xl: 16px !important;
            --radius-2xl: 20px !important;
            
            --transition-fast: 0.2s ease !important;
            --transition-base: 0.3s ease !important;
            --transition-slow: 0.4s ease !important;
            
            background-color: var(--soft-cream) !important;
            font-family: 'Poppins', sans-serif !important;
            color: var(--text-dark) !important;
        }

        body.ticketing-page,
        body.ticketing-page form {
            margin: 0 !important;
            padding: 0 !important;
            width: 100% !important;
            min-height: 100vh !important;
        }

        .ticketing-container,
        .ticketing-container * {
            box-sizing: border-box !important;
            font-family: 'Poppins', sans-serif !important;
        }

        .ticketing-container {
            background: var(--soft-cream) !important;
            padding: 25px 35px !important;
            max-width: 1400px !important;
            margin: 0 auto !important;
            min-height: 100vh !important;
            animation: fadeIn 0.5s ease-out !important;
        }

        .page-header-main {
            display: flex !important;
            justify-content: space-between !important;
            align-items: center !important;
            margin-bottom: 30px !important;
            flex-wrap: wrap !important;
            gap: 15px !important;
            padding-bottom: 20px !important;
            border-bottom: 1px solid var(--border-light) !important;
            animation: fadeIn 0.5s ease-out !important;
        }

        .header-title h1 {
            color: var(--text-dark) !important;
            font-weight: 700 !important;
            margin: 0 !important;
            font-size: 28px !important;
            letter-spacing: -0.5px !important;
        }

        .header-title p {
            color: var(--muted-text) !important;
            margin: 6px 0 0 0 !important;
            font-size: 14px !important;
            line-height: 1.5 !important;
        }

        .status-tabs-container {
            display: flex !important;
            gap: 10px !important;
            align-items: center !important;
            background: white !important;
            padding: 4px !important;
            border-radius: var(--radius-md) !important;
            box-shadow: var(--card-shadow) !important;
            border: 1px solid var(--border-light) !important;
        }

        .status-tab {
            padding: 10px 20px !important;
            border-radius: var(--radius-sm) !important;
            font-size: 13px !important;
            font-weight: 600 !important;
            cursor: pointer !important;
            transition: all var(--transition-base) !important;
            display: flex !important;
            align-items: center !important;
            gap: 8px !important;
            position: relative !important;
            overflow: hidden !important;
            background: transparent !important;
            color: var(--text-dark) !important;
            border: none !important;
        }

        .status-tab::before {
            content: '' !important;
            position: absolute !important;
            top: 0 !important;
            left: 0 !important;
            width: 100% !important;
            height: 100% !important;
            background: var(--primary-maroon) !important;
            opacity: 0 !important;
            transition: opacity var(--transition-base) !important;
            z-index: -1 !important;
        }

        .status-tab.active {
            background: var(--primary-maroon) !important;
            color: white !important;
            box-shadow: var(--button-shadow) !important;
        }

        .status-tab:not(.active):hover {
            background: var(--bg-hover) !important;
            transform: translateY(-1px) !important;
        }

        .status-badge {
            background: rgba(255, 255, 255, 0.2) !important;
            padding: 2px 8px !important;
            border-radius: 12px !important;
            font-size: 11px !important;
            font-weight: 600 !important;
            min-width: 24px !important;
            text-align: center !important;
        }

        .status-tab.active .status-badge {
            background: rgba(255, 255, 255, 0.3) !important;
        }

        .tickets-grid {
            display: grid !important;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)) !important;
            gap: 25px !important;
            margin-top: 20px !important;
            animation: fadeIn 0.6s ease-out !important;
        }

        .ticket-card {
            background: white !important;
            border-radius: var(--radius-lg) !important;
            overflow: hidden !important;
            box-shadow: var(--card-shadow) !important;
            transition: all var(--transition-base) !important;
            position: relative !important;
            border: 1px solid var(--border-light) !important;
            animation: slideInUp 0.4s ease-out !important;
            animation-fill-mode: both !important;
        }

        .ticket-card:nth-child(1) { animation-delay: 0.1s !important; }
        .ticket-card:nth-child(2) { animation-delay: 0.2s !important; }
        .ticket-card:nth-child(3) { animation-delay: 0.3s !important; }
        .ticket-card:nth-child(4) { animation-delay: 0.4s !important; }
        .ticket-card:nth-child(5) { animation-delay: 0.5s !important; }

        .ticket-card:hover {
            transform: translateY(-5px) !important;
            box-shadow: var(--card-shadow-lifted) !important;
            border-color: var(--primary-maroon-light) !important;
        }

        .ticket-card::before {
            content: '' !important;
            position: absolute !important;
            top: 0 !important;
            left: 0 !important;
            width: 4px !important;
            height: 100% !important;
            background: var(--primary-maroon) !important;
            opacity: 0 !important;
            transition: opacity var(--transition-base) !important;
        }

        .ticket-card:hover::before {
            opacity: 1 !important;
        }

        .ticket-header {
            background: linear-gradient(135deg, var(--primary-maroon) 0%, var(--primary-maroon-dark) 100%) !important;
            color: white !important;
            padding: 18px !important;
            position: relative !important;
            overflow: hidden !important;
        }

        .ticket-header::before {
            content: '' !important;
            position: absolute !important;
            top: 0 !important;
            left: 0 !important;
            right: 0 !important;
            bottom: 0 !important;
            background: linear-gradient(
                45deg,
                transparent 30%,
                rgba(255, 255, 255, 0.1) 50%,
                transparent 70%
            ) !important;
            animation: shimmer 3s infinite linear !important;
        }

        .ticket-title {
            font-size: 16px !important;
            font-weight: 700 !important;
            margin-bottom: 4px !important;
            display: flex !important;
            align-items: center !important;
            gap: 8px !important;
            position: relative !important;
            z-index: 1 !important;
        }

        .ticket-time {
            font-size: 12px !important;
            opacity: 0.9 !important;
            font-weight: 400 !important;
            margin: 0 !important;
            position: relative !important;
            z-index: 1 !important;
            display: flex !important;
            align-items: center !important;
            gap: 6px !important;
        }

        .ticket-time i {
            font-size: 11px !important;
        }

        .ticket-action {
            position: absolute !important;
            right: 15px !important;
            top: 50% !important;
            transform: translateY(-50%) !important;
            background: rgba(255, 255, 255, 0.2) !important;
            width: 30px !important;
            height: 30px !important;
            border-radius: 50% !important;
            display: flex !important;
            align-items: center !important;
            justify-content: center !important;
            cursor: pointer !important;
            transition: all var(--transition-base) !important;
            z-index: 2 !important;
        }

        .ticket-action:hover {
            background: rgba(255, 255, 255, 0.3) !important;
            transform: translateY(-50%) scale(1.1) !important;
        }

        .ticket-body {
            padding: 20px !important;
            background: var(--bg-lighter) !important;
        }

        .ticket-info {
            display: flex !important;
            justify-content: space-between !important;
            align-items: center !important;
            margin-bottom: 15px !important;
            padding-bottom: 12px !important;
            border-bottom: 1px solid var(--border-light) !important;
        }

        .order-type {
            background: var(--accent-purple-light) !important;
            color: var(--accent-purple) !important;
            padding: 6px 12px !important;
            border-radius: var(--radius-sm) !important;
            font-size: 12px !important;
            font-weight: 600 !important;
            display: flex !important;
            align-items: center !important;
            gap: 6px !important;
        }

        .customer-name {
            font-weight: 600 !important;
            font-size: 14px !important;
            color: var(--text-dark) !important;
        }

        .ticket-items {
            margin-bottom: 20px !important;
            font-size: 13px !important;
            color: var(--text-dark) !important;
            line-height: 1.6 !important;
        }

        .item-row {
            display: flex !important;
            justify-content: space-between !important;
            padding: 8px 0 !important;
            border-bottom: 1px dashed var(--border-light) !important;
        }

        .item-row:last-child {
            border-bottom: none !important;
        }

        .item-name {
            font-weight: 500 !important;
        }

        .item-quantity {
            color: var(--primary-maroon) !important;
            font-weight: 700 !important;
            background: var(--accent-pink) !important;
            padding: 2px 8px !important;
            border-radius: 10px !important;
            min-width: 24px !important;
            text-align: center !important;
        }

        .ticket-footer {
            display: flex !important;
            justify-content: space-between !important;
            align-items: center !important;
            padding-top: 15px !important;
            border-top: 1px solid var(--border-light) !important;
        }

        .ticket-actions {
            display: flex !important;
            gap: 10px !important;
        }

        .action-btn {
            padding: 10px 20px !important;
            border-radius: var(--radius-md) !important;
            border: none !important;
            font-family: 'Poppins', sans-serif !important;
            font-weight: 600 !important;
            font-size: 13px !important;
            cursor: pointer !important;
            transition: all var(--transition-base) !important;
            display: flex !important;
            align-items: center !important;
            gap: 8px !important;
            position: relative !important;
            overflow: hidden !important;
            z-index: 1 !important;
            min-width: 120px !important;
            justify-content: center !important;
        }

        .action-btn::before {
            content: '' !important;
            position: absolute !important;
            top: 50% !important;
            left: 50% !important;
            width: 0 !important;
            height: 0 !important;
            border-radius: 50% !important;
            background: rgba(255, 255, 255, 0.3) !important;
            transform: translate(-50%, -50%) !important;
            transition: width 0.6s, height 0.6s !important;
            z-index: -1 !important;
        }

        .action-btn:active::before {
            width: 200px !important;
            height: 200px !important;
        }

        .btn-start {
            background: var(--accent-teal) !important;
            color: white !important;
            box-shadow: 0 4px 12px rgba(20, 184, 166, 0.25) !important;
        }

        .btn-start:hover {
            background: #0da594 !important;
            transform: translateY(-2px) !important;
            box-shadow: 0 6px 18px rgba(20, 184, 166, 0.35) !important;
        }

        .btn-done {
            background: var(--success-green) !important;
            color: white !important;
            box-shadow: 0 4px 12px rgba(45, 157, 120, 0.25) !important;
        }

        .btn-done:hover {
            background: var(--success-green-dark) !important;
            transform: translateY(-2px) !important;
            box-shadow: 0 6px 18px rgba(45, 157, 120, 0.35) !important;
        }

        .btn-delete {
            background: white !important;
            color: var(--danger-red) !important;
            border: 1px solid var(--danger-red) !important;
        }

        .btn-delete:hover {
            background: var(--danger-red) !important;
            color: white !important;
        }

        .rush-badge {
            background: var(--danger-red-light) !important;
            color: var(--danger-red) !important;
            padding: 4px 10px !important;
            border-radius: 12px !important;
            font-size: 10px !important;
            font-weight: 700 !important;
            text-transform: uppercase !important;
            letter-spacing: 0.5px !important;
            display: inline-flex !important;
            align-items: center !important;
            gap: 4px !important;
            margin-left: 8px !important;
            animation: pulse 2s infinite !important;
        }

        .delivery-badge {
            background: var(--accent-blue) !important;
            color: var(--accent-blue-dark) !important;
        }

        .table-badge {
            background: var(--accent-yellow-light) !important;
            color: var(--accent-yellow-dark) !important;
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
                padding: 20px !important;
            }
            
            .tickets-grid {
                grid-template-columns: repeat(auto-fill, minmax(280px, 1fr)) !important;
            }
        }

        @media (max-width: 992px) {
            .page-header-main {
                flex-direction: column !important;
                align-items: stretch !important;
                gap: 15px !important;
            }
            
            .status-tabs-container {
                width: 100% !important;
                justify-content: center !important;
            }
            
            .ticket-footer {
                flex-direction: column !important;
                gap: 15px !important;
                align-items: stretch !important;
            }
            
            .ticket-actions {
                width: 100% !important;
            }
            
            .action-btn {
                width: 100% !important;
            }
        }

        @media (max-width: 768px) {
            .ticketing-container {
                padding: 15px !important;
            }
            
            .header-title h1 {
                font-size: 24px !important;
            }
            
            .tickets-grid {
                grid-template-columns: 1fr !important;
            }
            
            .ticket-info {
                flex-direction: column !important;
                gap: 10px !important;
                align-items: flex-start !important;
            }
        }

        @media (max-width: 480px) {
            .ticketing-container {
                padding: 12px !important;
            }
            
            .status-tab {
                padding: 8px 15px !important;
                font-size: 12px !important;
            }
            
            .ticket-header {
                padding: 15px !important;
            }
            
            .ticket-body {
                padding: 15px !important;
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
                        <span class="customer-name">Jay-r Casano</span>
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
                        <span class="customer-name">George Gonzaga</span>
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
                        <span class="customer-name">Bryle Magallano</span>
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
                        <span class="customer-name">Lalaine Reyes</span>
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
                        <span class="customer-name">Zea Sulit</span>
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
        // Add class to body for more specific CSS targeting
        document.body.classList.add('ticketing-page');

        document.addEventListener('DOMContentLoaded', function () {
            const statusTabs = document.querySelectorAll('.status-tab');
            const startButtons = document.querySelectorAll('.btn-start');
            const doneButtons = document.querySelectorAll('.btn-done');
            const deleteButtons = document.querySelectorAll('.ticket-action');

            function showNotification(message, type) {
                const notification = document.createElement('div');
                notification.style.cssText = `
                    position: fixed !important;
                    top: 20px !important;
                    right: 20px !important;
                    padding: 15px 20px !important;
                    background: ${type === 'success' ? 'var(--success-green)' :
                        type === 'info' ? 'var(--accent-blue-dark)' :
                            type === 'warning' ? 'var(--warning-orange)' :
                                'var(--danger-red)'} !important;
                    color: white !important;
                    border-radius: var(--radius-md) !important;
                    box-shadow: 0 4px 12px rgba(0,0,0,0.15) !important;
                    z-index: 10001 !important;
                    animation: slideInRight 0.3s ease !important;
                    display: flex !important;
                    align-items: center !important;
                    gap: 10px !important;
                    max-width: 300px !important;
                    font-family: 'Poppins', sans-serif !important;
                    font-weight: 500 !important;
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
                    notification.style.animation = 'slideInRight 0.3s ease reverse !important';
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
                    ticketCard.style.animation = 'slideInRight 0.3s ease reverse !important';
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
                    ticketCard.style.animation = 'slideInRight 0.3s ease reverse !important';
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