<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Admin.Master" AutoEventWireup="true" CodeBehind="AcceptOrder.aspx.cs" Inherits="TasteNet.Users.Admin.AcceptOrder" %>
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

        html, body, form {
            margin: 0 !important;
            padding: 0 !important;
            background-color: var(--soft-cream) !important;
            width: 100%;
            font-family: 'Poppins', sans-serif;
            color: var(--text-dark);
            min-height: 100vh;
        }

        .workflow-container {
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

        .admin-controls {
            display: flex;
            gap: 15px;
            align-items: center;
        }

        .admin-btn {
            padding: 10px 20px;
            border-radius: var(--radius-md);
            border: none;
            background: var(--primary-maroon);
            color: white;
            font-family: 'Poppins', sans-serif;
            font-weight: 600;
            font-size: 14px;
            cursor: pointer;
            transition: all var(--transition-base);
            display: flex;
            align-items: center;
            gap: 8px;
            box-shadow: var(--button-shadow);
            position: relative;
            overflow: hidden;
            z-index: 1;
        }

        .admin-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(
                90deg,
                transparent,
                rgba(255, 255, 255, 0.2),
                transparent
            );
            transition: left 0.7s;
            z-index: -1;
        }

        .admin-btn:hover::before {
            left: 100%;
        }

        .admin-btn:hover {
            background: var(--primary-maroon-dark);
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(107, 13, 30, 0.25);
        }

        .admin-btn-secondary {
            background: white;
            color: var(--primary-maroon);
            border: 1px solid var(--primary-maroon);
            box-shadow: none;
        }

        .admin-btn-secondary:hover {
            background: var(--primary-maroon);
            color: white;
        }

        .stats-summary {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            margin-bottom: 35px;
            animation: fadeIn 0.5s ease-out;
        }

        .summary-card {
            background: white;
            padding: 25px;
            border-radius: var(--radius-xl);
            box-shadow: var(--card-shadow);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            display: flex;
            justify-content: space-between;
            align-items: center;
            animation: fadeIn 0.5s ease-out;
            animation-fill-mode: both;
            position: relative;
            overflow: hidden;
            border: 1px solid var(--border-light);
        }

        .summary-card:nth-child(1) { animation-delay: 0.1s; }
        .summary-card:nth-child(2) { animation-delay: 0.2s; }
        .summary-card:nth-child(3) { animation-delay: 0.3s; }
        .summary-card:nth-child(4) { animation-delay: 0.4s; }

        .summary-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--card-shadow-lifted);
            border-color: var(--primary-maroon-light);
        }

        .summary-content {
            flex: 1;
            position: relative;
            z-index: 2;
        }

        .summary-label {
            font-size: 12px;
            font-weight: 500;
            color: var(--muted-text);
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 6px;
        }

        .summary-value {
            font-size: 32px;
            font-weight: 700;
            color: var(--primary-maroon);
            margin: 0;
            line-height: 1;
        }

        .summary-value.new {
            color: var(--warning-orange);
        }

        .summary-value.preparing {
            color: var(--accent-teal);
        }

        .summary-value.time {
            color: var(--accent-blue-dark);
        }

        .summary-value.today {
            color: var(--success-green);
        }

        .summary-icon {
            width: 56px;
            height: 56px;
            border-radius: var(--radius-md);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 22px;
            background: var(--accent-pink);
            color: var(--primary-maroon);
            transition: all var(--transition-base);
            flex-shrink: 0;
            margin-left: 15px;
            position: relative;
            z-index: 2;
            transform-origin: center;
        }

        .summary-card:hover .summary-icon {
            transform: scale(1.1) rotate(5deg);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
        }

        .workflow-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 25px;
            margin-top: 20px;
            animation: fadeIn 0.6s ease-out;
        }

        .workflow-column {
            background: white;
            border-radius: var(--radius-lg);
            overflow: hidden;
            box-shadow: var(--card-shadow);
            transition: transform var(--transition-base), box-shadow var(--transition-base);
            display: flex;
            flex-direction: column;
            max-height: 600px;
        }

        .workflow-column:hover {
            transform: translateY(-5px);
            box-shadow: var(--card-shadow-hover);
        }

        .column-header {
            background: linear-gradient(135deg, var(--primary-maroon) 0%, var(--primary-maroon-dark) 100%);
            color: white;
            padding: 20px;
            font-size: 14px;
            font-weight: 600;
            border-bottom: 1px solid var(--border-light);
            position: relative;
            overflow: hidden;
        }

        .column-header::before {
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

        .column-title {
            font-size: 16px;
            font-weight: 700;
            margin-bottom: 4px;
            display: flex;
            align-items: center;
            gap: 8px;
            position: relative;
            z-index: 1;
        }

        .column-subtitle {
            font-size: 12px;
            opacity: 0.9;
            font-weight: 400;
            margin: 0;
            position: relative;
            z-index: 1;
        }

        .order-count-badge {
            background: rgba(255, 255, 255, 0.2);
            padding: 2px 8px;
            border-radius: 20px;
            font-size: 12px;
            margin-left: 8px;
        }

        .column-body {
            padding: 20px;
            background: var(--bg-column);
            flex: 1;
            overflow-y: auto;
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        .order-card {
            background: white;
            border-radius: var(--radius-md);
            padding: 20px;
            border: 1px solid var(--border-light);
            transition: all var(--transition-base);
            position: relative;
            overflow: hidden;
            animation: slideInUp 0.4s ease-out;
            animation-fill-mode: both;
            height: 300px;
        }

        .order-card:nth-child(1) { animation-delay: 0.1s; }
        .order-card:nth-child(2) { animation-delay: 0.2s; }
        .order-card:nth-child(3) { animation-delay: 0.3s; }

        .order-card:hover {
            transform: translateY(-3px);
            box-shadow: var(--card-shadow-hover);
            border-color: var(--primary-maroon-light);
        }

        .order-card::before {
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

        .order-card:hover::before {
            opacity: 1;
        }

        .order-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 12px;
            padding-bottom: 10px;
            border-bottom: 1px solid var(--bg-lighter);
        }

        .order-info {
            display: flex;
            flex-direction: column;
            gap: 4px;
        }

        .order-id {
            color: var(--primary-maroon);
            font-weight: 700;
            font-size: 14px;
            font-family: 'Courier New', monospace;
            letter-spacing: 0.5px;
        }

        .order-customer {
            color: var(--text-dark);
            font-weight: 600;
            font-size: 13px;
        }

        .order-time {
            color: var(--muted-text);
            font-size: 11px;
            font-weight: 500;
            background: var(--bg-lighter);
            padding: 4px 8px;
            border-radius: var(--radius-sm);
            display: inline-block;
            white-space: nowrap;
        }

        .order-items {
            margin-bottom: 15px;
            font-size: 12px;
            color: var(--text-dark);
            line-height: 1.6;
        }

        .item-row {
            display: flex;
            justify-content: space-between;
            padding: 4px 0;
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
            font-weight: 600;
        }

        .order-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-top: 15px;
            border-top: 1px solid var(--border-light);
        }

        .order-total {
            font-weight: 700;
            color: var(--primary-maroon);
            font-size: 16px;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .order-total::before {
            content: '₱';
            font-size: 14px;
            opacity: 0.8;
        }

        .action-buttons {
            display: flex;
            gap: 10px;
        }

        .action-btn {
            padding: 8px 16px;
            border-radius: var(--radius-md);
            border: none;
            font-family: 'Poppins', sans-serif;
            font-weight: 600;
            font-size: 12px;
            cursor: pointer;
            transition: all var(--transition-base);
            display: flex;
            align-items: center;
            gap: 6px;
            position: relative;
            overflow: hidden;
            z-index: 1;
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

        .btn-accept {
            background: var(--success-green);
            color: white;
            box-shadow: 0 4px 12px rgba(10, 143, 60, 0.25);
        }

        .btn-accept:hover {
            background: var(--success-green-dark);
            transform: translateY(-2px);
            box-shadow: 0 6px 18px rgba(10, 143, 60, 0.35);
        }

        .btn-complete {
            background: var(--accent-teal);
            color: white;
            box-shadow: 0 4px 12px rgba(20, 184, 166, 0.25);
        }

        .btn-complete:hover {
            background: #0da594;
            transform: translateY(-2px);
            box-shadow: 0 6px 18px rgba(20, 184, 166, 0.35);
        }

        .btn-details {
            background: var(--accent-blue);
            color: var(--accent-blue-dark);
            border: 1px solid var(--accent-blue-dark);
        }

        .btn-details:hover {
            background: var(--accent-blue-dark);
            color: white;
        }

        .empty-state {
            text-align: center;
            padding: 40px 20px;
            color: var(--muted-text);
            font-size: 14px;
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 10px;
        }

        .empty-state i {
            font-size: 32px;
            opacity: 0.5;
            margin-bottom: 10px;
        }

        .time-indicator {
            display: flex;
            align-items: center;
            gap: 6px;
            font-size: 11px;
            color: var(--warning-orange);
            font-weight: 500;
            margin-top: 5px;
        }

        .time-indicator i {
            font-size: 10px;
            animation: pulse 2s infinite;
        }

        .priority-badge {
            background: var(--danger-red-light);
            color: var(--danger-red);
            padding: 2px 8px;
            border-radius: 10px;
            font-size: 10px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-left: 8px;
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
            50% { opacity: 0.5; }
        }

        @keyframes slideInRight {
            from { transform: translateX(20px); opacity: 0; }
            to { transform: translateX(0); opacity: 1; }
        }

        @media (max-width: 1200px) {
            .workflow-container {
                padding: 20px;
            }
            
            .stats-summary {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 992px) {
            .workflow-grid {
                grid-template-columns: 1fr;
                gap: 20px;
            }
            
            .page-header-main {
                flex-direction: column;
                align-items: stretch;
                gap: 15px;
            }
            
            .admin-controls {
                width: 100%;
                justify-content: flex-end;
            }
            
            .order-card {
                padding: 15px;
            }
            
            .action-buttons {
                flex-direction: column;
                width: 100%;
            }
            
            .action-btn {
                width: 100%;
                justify-content: center;
            }
        }

        @media (max-width: 768px) {
            .workflow-container {
                padding: 15px;
            }
            
            .stats-summary {
                grid-template-columns: 1fr;
            }
            
            .header-title h1 {
                font-size: 24px;
            }
            
            .summary-value {
                font-size: 28px;
            }
            
            .summary-icon {
                width: 48px;
                height: 48px;
                font-size: 18px;
            }
            
            .order-header {
                flex-direction: column;
                gap: 8px;
            }
            
            .order-time {
                align-self: flex-start;
            }
        }

        @media (max-width: 480px) {
            .workflow-container {
                padding: 12px;
            }
            
            .admin-btn {
                padding: 8px 15px;
                font-size: 13px;
            }
            
            .column-header {
                padding: 15px;
            }
            
            .order-footer {
                flex-direction: column;
                gap: 10px;
                align-items: stretch;
            }
            
            .action-buttons {
                flex-direction: column;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="workflow-container">
        <div class="page-header-main">
            <div class="header-title">
                <h1>Order Workflow</h1>
                <p>Manage incoming orders and track preparation status in real-time</p>
            </div>
            
            <div class="admin-controls">
                <button type="button" class="admin-btn admin-btn-secondary" id="refreshBtn">
                    <i class="fas fa-sync-alt"></i>
                    Refresh
                </button>
            </div>
        </div>

        <div class="stats-summary">
            <div class="summary-card">
                <div class="summary-content">
                    <div class="summary-label">New Orders</div>
                    <div class="summary-value new">2</div>
                    <div class="time-indicator">
                        <i class="fas fa-clock"></i>
                        <span>Pending acceptance</span>
                    </div>
                </div>
                <div class="summary-icon" style="background: var(--warning-orange-light); color: var(--warning-orange);">
                    <i class="fas fa-inbox"></i>
                </div>
            </div>
            
            <div class="summary-card">
                <div class="summary-content">
                    <div class="summary-label">Preparing</div>
                    <div class="summary-value preparing">1</div>
                    <div class="time-indicator">
                        <i class="fas fa-fire"></i>
                        <span>In progress</span>
                    </div>
                </div>
                <div class="summary-icon" style="background: var(--accent-teal-light); color: var(--accent-teal);">
                    <i class="fas fa-blender"></i>
                </div>
            </div>
            
            <div class="summary-card">
                <div class="summary-content">
                    <div class="summary-label">Avg. Waiting Time</div>
                    <div class="summary-value time">12 min</div>
                    <div style="font-size: 11px; color: var(--muted-text); margin-top: 4px;">
                        Below target: 15min
                    </div>
                </div>
                <div class="summary-icon" style="background: var(--accent-blue); color: var(--accent-blue-dark);">
                    <i class="fas fa-stopwatch"></i>
                </div>
            </div>
            
            <div class="summary-card">
                <div class="summary-content">
                    <div class="summary-label">Today's Orders</div>
                    <div class="summary-value today">42</div>
                    <div style="font-size: 11px; color: var(--muted-text); margin-top: 4px;">
                        +8% from yesterday
                    </div>
                </div>
                <div class="summary-icon" style="background: var(--success-green-light); color: var(--success-green);">
                    <i class="fas fa-chart-line"></i>
                </div>
            </div>
        </div>

        <div class="workflow-grid">
            <div class="workflow-column">
                <div class="column-header">
                    <div class="column-title">
                        <i class="fas fa-clock"></i>
                        New Orders
                        <span class="order-count-badge">2</span>
                    </div>
                    <p class="column-subtitle">Orders waiting to be accepted</p>
                </div>
                
                <div class="column-body">
                    <div class="order-card">
                        <div class="order-header">
                            <div class="order-info">
                                <span class="order-id">#001</span>
                                <span class="order-customer">Jay-r Casano</span>
                                <span class="time-indicator">
                                    <i class="fas fa-clock"></i>
                                    Waiting 5min
                                </span>
                            </div>
                            <span class="order-time">1:00 PM</span>
                        </div>
                        
                        <div class="order-items">
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
                        
                        <div class="order-footer">
                            <div class="order-total">350</div>
                            <div class="action-buttons">
                                <button type="button" class="action-btn btn-details">
                                    <i class="fas fa-info-circle"></i>
                                    Details
                                </button>
                                <button type="button" class="action-btn btn-accept">
                                    <i class="fas fa-check"></i>
                                    Accept Order
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="workflow-column">
                <div class="column-header">
                    <div class="column-title">
                        <i class="fas fa-blender"></i>
                        Preparing
                        <span class="order-count-badge">1</span>
                    </div>
                    <p class="column-subtitle">Orders currently being prepared</p>
                </div>
                
                <div class="column-body">
                    <div class="order-card">
                        <div class="order-header">
                            <div class="order-info">
                                <span class="order-id">#003</span>
                                <span class="order-customer">Zea Sulit</span>
                                <span class="time-indicator" style="color: var(--accent-teal);">
                                    <i class="fas fa-fire"></i>
                                    Started 8min ago
                                </span>
                            </div>
                            <span class="order-time">12:45 PM</span>
                        </div>
                        
                        <div class="order-items">
                            <div class="item-row">
                                <span class="item-name">Crispy Pata</span>
                                <span class="item-quantity">1</span>
                            </div>
                            <div class="item-row">
                                <span class="item-name">Rice</span>
                                <span class="item-quantity">3</span>
                            </div>
                            <div class="item-row">
                                <span class="item-name">Iced Tea</span>
                                <span class="item-quantity">2</span>
                            </div>
                        </div>
                        
                        <div class="order-footer">
                            <div class="order-total">580</div>
                            <div class="action-buttons">
                                <button type="button" class="action-btn btn-details">
                                    <i class="fas fa-info-circle"></i>
                                    Details
                                </button>
                                <button type="button" class="action-btn btn-complete">
                                    <i class="fas fa-check-double"></i>
                                    Mark Complete
                                </button>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const refreshBtn = document.getElementById('refreshBtn');
            const kitchenViewBtn = document.getElementById('kitchenViewBtn');
            const acceptButtons = document.querySelectorAll('.btn-accept');
            const completeButtons = document.querySelectorAll('.btn-complete');
            const detailButtons = document.querySelectorAll('.btn-details');

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

            function simulateOrderAcceptance(orderCard) {
                const orderId = orderCard.querySelector('.order-id').textContent;
                const customerName = orderCard.querySelector('.order-customer').textContent;
                
                const acceptBtn = orderCard.querySelector('.btn-accept');
                const originalText = acceptBtn.innerHTML;
                acceptBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Processing...';
                acceptBtn.disabled = true;
                
                setTimeout(() => {
                    orderCard.style.animation = 'slideInRight 0.3s ease reverse';
                    setTimeout(() => {
                        orderCard.remove();
                        
                        const newOrdersCount = document.querySelector('.order-count-badge');
                        const currentCount = parseInt(newOrdersCount.textContent);
                        newOrdersCount.textContent = currentCount - 1;
                        
                        const newOrdersValue = document.querySelector('.summary-value.new');
                        newOrdersValue.textContent = currentCount - 1;
                        
                        const preparingCount = document.querySelectorAll('.workflow-column')[1]
                            .querySelector('.order-count-badge');
                        const preparingValue = parseInt(preparingCount.textContent);
                        preparingCount.textContent = preparingValue + 1;
                        
                        const preparingValueEl = document.querySelector('.summary-value.preparing');
                        preparingValueEl.textContent = preparingValue + 1;
                        
                        showNotification(`Order ${orderId} accepted and moved to preparation`, 'success');
                    }, 300);
                }, 1500);
            }

            function simulateOrderCompletion(orderCard) {
                const orderId = orderCard.querySelector('.order-id').textContent;
                
                const completeBtn = orderCard.querySelector('.btn-complete');
                const originalText = completeBtn.innerHTML;
                completeBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Completing...';
                completeBtn.disabled = true;
                
                setTimeout(() => {
                    orderCard.style.animation = 'slideInRight 0.3s ease reverse';
                    setTimeout(() => {
                        orderCard.remove();
                        
                        const preparingCount = document.querySelectorAll('.workflow-column')[1]
                            .querySelector('.order-count-badge');
                        const currentCount = parseInt(preparingCount.textContent);
                        preparingCount.textContent = currentCount - 1;
                        
                        const preparingValueEl = document.querySelector('.summary-value.preparing');
                        preparingValueEl.textContent = currentCount - 1;
                        
                        const todayValue = document.querySelector('.summary-value.today');
                        todayValue.textContent = parseInt(todayValue.textContent) + 1;
                        
                        showNotification(`Order ${orderId} marked as completed!`, 'success');
                    }, 300);
                }, 1500);
            }

            function showOrderDetails(orderCard) {
                const orderId = orderCard.querySelector('.order-id').textContent;
                const customerName = orderCard.querySelector('.order-customer').textContent;
                const orderTime = orderCard.querySelector('.order-time').textContent;
                const orderTotal = orderCard.querySelector('.order-total').textContent;
                
                showNotification(`Showing details for ${orderId} - ${customerName}`, 'info');
                
                orderCard.style.boxShadow = '0 0 0 2px var(--accent-blue-dark)';
                orderCard.style.transform = 'scale(1.02)';
                
                setTimeout(() => {
                    orderCard.style.boxShadow = '';
                    orderCard.style.transform = '';
                }, 2000);
            }

            refreshBtn.addEventListener('click', function () {
                refreshBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Refreshing...';
                refreshBtn.disabled = true;
                
                setTimeout(() => {
                    refreshBtn.innerHTML = '<i class="fas fa-sync-alt"></i> Refresh';
                    refreshBtn.disabled = false;
                    showNotification('Order list refreshed', 'info');
                }, 1000);
            });

            kitchenViewBtn.addEventListener('click', function () {
                showNotification('Switching to kitchen view...', 'info');
            });

            acceptButtons.forEach(btn => {
                btn.addEventListener('click', function () {
                    const orderCard = this.closest('.order-card');
                    simulateOrderAcceptance(orderCard);
                });
            });

            completeButtons.forEach(btn => {
                btn.addEventListener('click', function () {
                    const orderCard = this.closest('.order-card');
                    simulateOrderCompletion(orderCard);
                });
            });

            detailButtons.forEach(btn => {
                btn.addEventListener('click', function () {
                    const orderCard = this.closest('.order-card');
                    showOrderDetails(orderCard);
                });
            });

            setInterval(() => {
                const waitingIndicators = document.querySelectorAll('.time-indicator');
                waitingIndicators.forEach(indicator => {
                    if (indicator.textContent.includes('Waiting')) {
                        const minutes = parseInt(indicator.textContent.match(/\d+/)[0]);
                        indicator.innerHTML = `<i class="fas fa-clock"></i> Waiting ${minutes + 1}min`;
                    }
                });
            }, 60000); 
        });
    </script>
</asp:Content>