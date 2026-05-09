<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Rider.Master" AutoEventWireup="true" CodeBehind="DeliveryHistory.aspx.cs" Inherits="TasteNet.Users.Rider.DeliveryHistory" %>
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

        .history-wrapper {
            background: var(--soft-cream) !important;
            padding: 25px 35px;
            max-width: 1400px;
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

        .filter-bar {
            display: flex;
            gap: 15px;
            align-items: center;
            flex-wrap: wrap;
        }

        .filter-select {
            padding: 10px 16px;
            border-radius: var(--radius-md);
            border: 1px solid var(--border-light);
            background: white;
            color: var(--text-dark);
            font-family: 'Poppins', sans-serif;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            transition: all var(--transition-base);
            min-width: 160px;
            box-shadow: var(--card-shadow);
        }

        .filter-select:hover {
            border-color: var(--primary-maroon);
            transform: translateY(-1px);
            box-shadow: var(--card-shadow-hover);
        }

        .stats-summary {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
            margin-bottom: 35px;
            animation: fadeIn 0.5s ease-out;
        }

        .summary-card {
            background: white;
            padding: 25px;
            border-radius: var(--radius-xl);
            box-shadow: var(--card-shadow);
            transition: all var(--transition-base);
            border: 1px solid var(--border-light);
            display: flex;
            justify-content: space-between;
            align-items: center;
            animation: fadeIn 0.5s ease-out;
            animation-fill-mode: both;
            position: relative;
            overflow: hidden;
        }

        .summary-card:nth-child(1) { animation-delay: 0.1s; }
        .summary-card:nth-child(2) { animation-delay: 0.2s; }

        .summary-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--card-shadow-hover);
            border-color: var(--border-hover);
        }

        .summary-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: left 0.7s;
            z-index: 1;
        }

        .summary-card:hover::before {
            left: 100%;
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

        .summary-value.completed {
            color: var(--success-green);
        }

        .summary-icon {
            width: 56px;
            height: 56px;
            border-radius: var(--radius-lg);
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
        }

        .summary-card:hover .summary-icon {
            transform: scale(1.1) rotate(5deg);
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }

        .deliveries-container {
            margin-top: 10px;
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }

        .section-title {
            font-size: 20px;
            color: var(--text-dark);
            font-weight: 600;
            margin: 0;
        }

        .results-count {
            color: var(--muted-text);
            font-size: 14px;
            font-weight: 500;
        }

        .deliveries-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
            margin-bottom: 30px;
        }

        .delivery-card {
            background: white;
            border-radius: var(--radius-xl);
            padding: 20px;
            box-shadow: var(--card-shadow);
            border: 1px solid var(--border-light);
            transition: all var(--transition-base);
            animation: slideUp 0.4s ease-out;
            animation-fill-mode: both;
            position: relative;
            overflow: hidden;
            display: flex;
            flex-direction: column;
            height: 100%;
            box-sizing: border-box;
        }

        .delivery-card:hover {
            transform: translateY(-3px);
            box-shadow: var(--card-shadow-hover);
            border-color: var(--border-hover);
        }

        .delivery-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.1), transparent);
            transition: left 0.7s;
        }

        .delivery-card:hover::before {
            left: 100%;
        }

        .delivery-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 15px;
            position: relative;
            z-index: 1;
        }

        .delivery-info { flex: 1; }

        .delivery-id {
            font-size: 14px;
            font-weight: 700;
            color: var(--primary-maroon);
            font-family: 'Courier New', monospace;
            background: var(--accent-pink);
            padding: 4px 10px;
            border-radius: var(--radius-sm);
            display: inline-block;
            margin-bottom: 6px;
        }

        .delivery-time {
            color: var(--muted-text);
            font-size: 12px;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .delivery-time i { font-size: 11px; }

        .delivery-status {
            padding: 4px 10px;
            border-radius: var(--radius-sm);
            font-size: 10px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.3px;
            min-width: 80px;
            text-align: center;
            border: 1px solid transparent;
            align-self: flex-start;
        }

        .status-completed {
            background: var(--success-green-light);
            color: var(--success-green);
            border-color: var(--success-green);
        }

        .delivery-content {
            flex: 1;
            display: flex;
            flex-direction: column;
            gap: 15px;
            margin-bottom: 15px;
            position: relative;
            z-index: 1;
        }

        .location-info {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .location-row {
            display: flex;
            align-items: flex-start;
            gap: 10px;
        }

        .location-icon {
            width: 30px;
            height: 30px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            background: var(--accent-pink);
            color: var(--primary-maroon);
            font-size: 12px;
            flex-shrink: 0;
            margin-top: 2px;
        }

        .location-text { flex: 1; }

        .location-label {
            font-size: 10px;
            font-weight: 600;
            color: var(--muted-text);
            text-transform: uppercase;
            letter-spacing: 0.4px;
            margin-bottom: 3px;
        }

        .location-address {
            font-size: 13px;
            font-weight: 600;
            color: var(--text-dark);
            line-height: 1.3;
        }

        .delivery-metrics {
            background: var(--bg-lighter);
            border-radius: var(--radius-lg);
            padding: 15px;
            border: 1px solid var(--border-light);
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 10px;
            margin-top: 10px;
        }

        .metric-row {
            display: flex;
            flex-direction: column;
            gap: 4px;
            padding-bottom: 8px;
            border-bottom: 1px dashed var(--border-light);
        }

        .metric-row:nth-child(3),
        .metric-row:nth-child(4) {
            border-bottom: none;
            padding-bottom: 0;
        }

        .metric-label {
            color: var(--muted-text);
            font-size: 10px;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.3px;
        }

        .metric-value {
            color: var(--text-dark);
            font-weight: 600;
            font-size: 12px;
            white-space: nowrap;
        }

        .metric-value.highlight {
            color: var(--success-green);
            font-size: 13px;
        }

        .delivery-actions {
            display: flex;
            gap: 10px;
            margin-top: 15px;
            position: relative;
            z-index: 1;
        }

        .action-btn {
            padding: 10px 15px;
            border-radius: var(--radius-md);
            font-weight: 600;
            font-size: 13px;
            cursor: pointer;
            border: none;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 6px;
            transition: all var(--transition-base);
            font-family: 'Poppins', sans-serif;
            flex: 1;
            position: relative;
            overflow: hidden;
        }

        .action-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: left 0.7s;
        }

        .action-btn:hover::before { left: 100%; }
        .action-btn:hover { transform: translateY(-2px); }

        .btn-view {
            background: var(--primary-maroon);
            color: white;
            box-shadow: var(--button-shadow);
        }

        .btn-view:hover {
            background: var(--primary-maroon-dark);
            box-shadow: var(--button-shadow-hover);
        }

        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 8px;
            margin-top: 30px;
            padding-top: 25px;
            border-top: 1px solid var(--border-light);
        }

        .page-btn {
            width: 36px;
            height: 36px;
            border-radius: var(--radius-sm);
            display: flex;
            align-items: center;
            justify-content: center;
            background: white;
            border: 1px solid var(--border-light);
            color: var(--text-dark);
            font-weight: 600;
            font-size: 13px;
            cursor: pointer;
            transition: all var(--transition-base);
        }

        .page-btn:hover, .page-btn.active {
            background: var(--primary-maroon);
            color: white;
            border-color: var(--primary-maroon);
        }

        .page-btn:hover { transform: translateY(-2px); }

        /* Modal */
        .modal-overlay {
            position: fixed;
            top: 0; left: 0;
            width: 100%; height: 100%;
            background: rgba(0,0,0,0.5);
            display: none;
            justify-content: center;
            align-items: center;
            z-index: 10000;
            animation: fadeIn 0.3s ease;
        }

        .modal-overlay.active { display: flex; }

        .modal-content {
            background: white;
            border-radius: var(--radius-xl);
            padding: 30px;
            width: 90%;
            max-width: 500px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            position: relative;
            animation: slideUp 0.4s ease;
            max-height: 90vh;
            overflow-y: auto;
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 1px solid var(--border-light);
        }

        .modal-title {
            font-size: 22px;
            color: var(--primary-maroon);
            font-weight: 700;
            margin: 0;
        }

        .close-modal {
            background: none;
            border: none;
            font-size: 20px;
            color: var(--muted-text);
            cursor: pointer;
            width: 36px;
            height: 36px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all var(--transition-base);
        }

        .close-modal:hover {
            background: var(--bg-lighter);
            color: var(--primary-maroon);
            transform: rotate(90deg);
        }

        .modal-body {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .modal-section {
            background: var(--bg-lighter);
            border-radius: var(--radius-lg);
            padding: 20px;
            border: 1px solid var(--border-light);
        }

        .modal-section-title {
            font-size: 16px;
            color: var(--primary-maroon);
            font-weight: 600;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .modal-section-title i { font-size: 14px; }

        .modal-details {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .detail-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 8px 0;
            border-bottom: 1px dashed var(--border-light);
        }

        .detail-row:last-child { border-bottom: none; }

        .detail-label {
            color: var(--muted-text);
            font-size: 13px;
            font-weight: 500;
            min-width: 120px;
        }

        .detail-value {
            color: var(--text-dark);
            font-weight: 600;
            font-size: 14px;
            text-align: right;
            flex: 1;
        }

        .modal-actions {
            display: flex;
            gap: 15px;
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid var(--border-light);
        }

        .modal-btn {
            padding: 12px 20px;
            border-radius: var(--radius-md);
            font-weight: 600;
            font-size: 14px;
            cursor: pointer;
            border: none;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            transition: all var(--transition-base);
            font-family: 'Poppins', sans-serif;
            flex: 1;
        }

        .modal-btn-secondary {
            background: var(--accent-blue);
            color: var(--accent-blue-dark);
            border: 1px solid var(--accent-blue-dark);
        }

        .modal-btn-secondary:hover {
            background: var(--accent-blue-dark);
            color: white;
        }

        .modal-btn-reroute {
            background: var(--success-green-light);
            color: var(--success-green);
            border: 1px solid var(--success-green);
        }

        .modal-btn-reroute:hover {
            background: var(--success-green);
            color: white;
        }

        .btn-reroute {
            background: var(--success-green-light);
            color: var(--success-green);
            border: 1px solid var(--success-green);
        }

        .btn-reroute:hover {
            background: var(--success-green);
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(45, 157, 120, 0.3);
        }

        /* Empty state */
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: var(--muted-text);
        }

        .empty-state i {
            font-size: 48px;
            margin-bottom: 16px;
            color: var(--border-light);
        }

        .empty-state p { font-size: 16px; margin: 0; }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
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
            .history-wrapper { padding: 20px; }
            .page-header-main { flex-direction: column; align-items: stretch; gap: 15px; }
            .deliveries-grid { grid-template-columns: 1fr; }
            .delivery-actions { flex-direction: column; }
            .action-btn { width: 100%; }
            .modal-content { width: 95%; padding: 20px; }
        }

        @media (max-width: 768px) {
            .stats-summary { grid-template-columns: 1fr; }
            .filter-bar { flex-direction: column; align-items: stretch; }
            .delivery-header { flex-direction: column; gap: 10px; }
            .delivery-status { align-self: flex-start; }
            .section-header { flex-direction: column; align-items: flex-start; gap: 10px; }
            .header-title h1 { font-size: 24px; }
            .delivery-metrics { grid-template-columns: 1fr; }
            .modal-details { gap: 10px; }
            .detail-row { flex-direction: column; align-items: flex-start; gap: 5px; }
            .detail-value { text-align: left; }
            .modal-actions { flex-direction: column; }
        }

        @media (max-width: 480px) {
            .history-wrapper { padding: 15px; }
            .summary-value { font-size: 28px; }
            .summary-icon { width: 48px; height: 48px; font-size: 18px; }
            .delivery-card { padding: 18px; }
        }
    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <%-- Detail Modal (populated via JS from hidden fields in Repeater) --%>
    <div class="modal-overlay" id="deliveryModal">
        <div class="modal-content">
            <div class="modal-header">
                <h2 class="modal-title" id="modalTicketNumber">#TK-0000</h2>
                <button class="close-modal" id="closeModal"><i class="fas fa-times"></i></button>
            </div>
            <div class="modal-body">
                <div class="modal-section">
                    <h3 class="modal-section-title"><i class="fas fa-info-circle"></i> Delivery Information</h3>
                    <div class="modal-details">
                        <div class="detail-row">
                            <span class="detail-label">Ticket #:</span>
                            <span class="detail-value" id="modalTicketNum"></span>
                        </div>
                        <div class="detail-row">
                            <span class="detail-label">Order #:</span>
                            <span class="detail-value" id="modalOrderNum"></span>
                        </div>
                        <div class="detail-row">
                            <span class="detail-label">Status:</span>
                            <span class="detail-value" id="modalStatus" style="color: var(--success-green); font-weight: 700;">Completed</span>
                        </div>
                        <div class="detail-row">
                            <span class="detail-label">Priority:</span>
                            <span class="detail-value" id="modalPriority"></span>
                        </div>
                        <div class="detail-row">
                            <span class="detail-label">Created:</span>
                            <span class="detail-value" id="modalCreatedAt"></span>
                        </div>
                        <div class="detail-row">
                            <span class="detail-label">Started:</span>
                            <span class="detail-value" id="modalStartedAt"></span>
                        </div>
                        <div class="detail-row">
                            <span class="detail-label">Completed:</span>
                            <span class="detail-value" id="modalCompletedAt"></span>
                        </div>
                    </div>
                </div>

                <div class="modal-section">
                    <h3 class="modal-section-title"><i class="fas fa-map-marker-alt"></i> Delivery Address</h3>
                    <div class="modal-details">
                        <div class="detail-row">
                            <span class="detail-label">Address:</span>
                            <span class="detail-value" id="modalAddress"></span>
                        </div>
                    </div>
                </div>

                <div class="modal-section">
                    <h3 class="modal-section-title"><i class="fas fa-receipt"></i> Order Summary</h3>
                    <div class="modal-details">
                        <div class="detail-row">
                            <span class="detail-label">Total Amount:</span>
                            <span class="detail-value" id="modalTotal" style="color: var(--success-green); font-weight: 700;"></span>
                        </div>
                        <div class="detail-row">
                            <span class="detail-label">Created By:</span>
                            <span class="detail-value" id="modalCreatedBy"></span>
                        </div>
                    </div>
                </div>

                <div class="modal-section">
                    <h3 class="modal-section-title"><i class="fas fa-user"></i> Customer Information</h3>
                    <div class="modal-details">
                        <div class="detail-row">
                            <span class="detail-label">Full Name:</span>
                            <span class="detail-value" id="modalFullName"></span>
                        </div>
                        <div class="detail-row">
                            <span class="detail-label">Phone:</span>
                            <span class="detail-value" id="modalPhone"></span>
                        </div>
                    </div>
                </div>

                <div class="modal-actions">
                    <button class="modal-btn modal-btn-reroute" id="modalRerouteBtn">
                        <i class="fas fa-map-marked-alt"></i> Reroute
                    </button>
                    <button class="modal-btn modal-btn-secondary" id="modalReportBtn">
                        <i class="fas fa-flag"></i> Report Issue
                    </button>
                </div>
            </div>
        </div>
    </div>

    <div class="history-wrapper">
        <div class="page-header-main">
            <div class="header-title">
                <h1>Delivery History</h1>
                <p>Review your completed deliveries</p>
            </div>
        </div>

        <%-- Summary Stats --%>
        <div class="stats-summary">
            <div class="summary-card">
                <div class="summary-content">
                    <div class="summary-label">Total Deliveries</div>
                    <div class="summary-value">
                        <asp:Label ID="lblTotalDeliveries" runat="server" Text="0" />
                    </div>
                </div>
                <div class="summary-icon">
                    <i class="fas fa-box"></i>
                </div>
            </div>

            <div class="summary-card">
                <div class="summary-content">
                    <div class="summary-label">Total Amount Delivered</div>
                    <div class="summary-value completed">
                        <asp:Label ID="lblTotalAmount" runat="server" Text="₱0.00" />
                    </div>
                </div>
                <div class="summary-icon" style="background: var(--success-green-light); color: var(--success-green);">
                    <i class="fas fa-check-circle"></i>
                </div>
            </div>
        </div>

        <div class="deliveries-container">
            <div class="section-header">
                <h2 class="section-title">Completed Deliveries</h2>
                <span class="results-count" id="resultsCount">
                    Showing <asp:Label ID="lblResultsCount" runat="server" Text="0" /> deliveries
                </span>
            </div>

            <div class="deliveries-grid" id="deliveriesGrid">
                <asp:Repeater ID="rptDeliveries" runat="server">
                    <ItemTemplate>
                        <%-- Hidden fields for modal data --%>
                        <div class="delivery-card"
                             data-ticket-id='<%# Eval("TicketID") %>'
                             data-ticket-number='<%# Eval("TicketNumber") %>'
                             data-order-number='<%# Eval("OrderNumber") %>'
                             data-address='<%# Eval("DeliveryAddress") %>'
                             data-status='<%# Eval("Status") %>'
                             data-priority='<%# Eval("Priority") %>'
                             data-total='<%# String.Format("₱{0:N2}", Eval("TotalAmount")) %>'
                             data-created-at='<%# Eval("CreatedAt") != DBNull.Value ? Convert.ToDateTime(Eval("CreatedAt")).ToString("MMM dd, yyyy hh:mm tt") : "—" %>'
                             data-started-at='<%# Eval("StartedAt") != DBNull.Value ? Convert.ToDateTime(Eval("StartedAt")).ToString("MMM dd, yyyy hh:mm tt") : "—" %>'
                             data-completed-at='<%# Eval("CompletedAt") != DBNull.Value ? Convert.ToDateTime(Eval("CompletedAt")).ToString("MMM dd, yyyy hh:mm tt") : "—" %>'
                             data-created-by='<%# Eval("CreatedBy") %>'
                             data-fullname='<%# Eval("FullName") %>'
                             data-phone='<%# Eval("Phone") %>'>

                            <div class="delivery-header">
                                <div class="delivery-info">
                                    <span class="delivery-id">#<%# Eval("TicketNumber") %></span>
                                    <div class="delivery-time">
                                        <i class="far fa-calendar"></i>
                                        <%# Eval("CompletedAt") != DBNull.Value ? Convert.ToDateTime(Eval("CompletedAt")).ToString("MMM dd, yyyy hh:mm tt") : "—" %>
                                    </div>
                                </div>
                                <span class="delivery-status status-completed">Completed</span>
                            </div>

                            <div class="delivery-content">
                                <div class="location-info">
                                    <div class="location-row">
                                        <div class="location-icon" style="background: var(--success-green-light); color: var(--success-green);">
                                            <i class="fas fa-flag-checkered"></i>
                                        </div>
                                        <div class="location-text">
                                            <div class="location-label">DELIVERY ADDRESS</div>
                                            <div class="location-address"><%# Eval("DeliveryAddress") %></div>
                                        </div>
                                    </div>
                                </div>

                                <div class="delivery-metrics">
                                    <div class="metric-row">
                                        <span class="metric-label">Order #</span>
                                        <span class="metric-value"><%# Eval("OrderNumber") %></span>
                                    </div>
                                    <div class="metric-row">
                                        <span class="metric-label">Priority</span>
                                        <span class="metric-value"><%# Eval("Priority") %></span>
                                    </div>
                                    <div class="metric-row">
                                        <span class="metric-label">Total Amount</span>
                                        <span class="metric-value highlight"><%# String.Format("₱{0:N2}", Eval("TotalAmount")) %></span>
                                    </div>
                                    <div class="metric-row">
                                        <span class="metric-label">Order Type</span>
                                        <span class="metric-value"><%# Eval("OrderType") %></span>
                                    </div>
                                    <div class="metric-row">
                                        <span class="metric-label">Customer</span>
                                        <span class="metric-value"><%# Eval("FullName") %></span>
                                    </div>
                                    <div class="metric-row">
                                        <span class="metric-label">Phone</span>
                                        <span class="metric-value"><%# Eval("Phone") %></span>
                                    </div>
                                </div>
                            </div>

                            <div class="delivery-actions">
                                <button type="button" class="action-btn btn-view"
                                        onclick="openModal(this.closest('.delivery-card'))">
                                    <i class="fas fa-eye"></i> View Details
                                </button>
                                <button type="button" class="action-btn btn-reroute"
                                        onclick="rerouteToGoogleMaps(this.closest('.delivery-card').dataset.address)">
                                    <i class="fas fa-map-marked-alt"></i> Reroute
                                </button>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>

                <%-- Empty state shown when no records --%>
                <asp:Panel ID="pnlEmpty" runat="server" Visible="false" style="grid-column: 1 / -1;">
                    <div class="empty-state">
                        <i class="fas fa-box-open"></i>
                        <p>No completed deliveries found.</p>
                    </div>
                </asp:Panel>
            </div>
        </div>
    </div>

    <script>
        const modal = document.getElementById('deliveryModal');
        const closeModalBtn = document.getElementById('closeModal');
        const modalReportBtn = document.getElementById('modalReportBtn');

        function openModal(card) {
            document.getElementById('modalTicketNumber').textContent = '#' + card.dataset.ticketNumber;
            document.getElementById('modalTicketNum').textContent = card.dataset.ticketNumber;
            document.getElementById('modalOrderNum').textContent = card.dataset.orderNumber;
            document.getElementById('modalStatus').textContent = card.dataset.status;
            document.getElementById('modalPriority').textContent = card.dataset.priority;
            document.getElementById('modalAddress').textContent = card.dataset.address;
            document.getElementById('modalTotal').textContent = card.dataset.total;
            document.getElementById('modalCreatedAt').textContent = card.dataset.createdAt;
            document.getElementById('modalStartedAt').textContent = card.dataset.startedAt;
            document.getElementById('modalCompletedAt').textContent = card.dataset.completedAt;
            document.getElementById('modalCreatedBy').textContent = card.dataset.createdBy;
            document.getElementById('modalFullName').textContent = card.dataset.fullname;
            document.getElementById('modalPhone').textContent = card.dataset.phone;

            modal.classList.add('active');
            document.body.style.overflow = 'hidden';
        }

        function closeModal() {
            modal.classList.remove('active');
            document.body.style.overflow = 'auto';
        }

        function rerouteToGoogleMaps(address) {
            if (!address) {
                showNotification('No address available for this delivery.', 'warning');
                return;
            }
            const encoded = encodeURIComponent(address);
            window.open('https://www.google.com/maps/dir/?api=1&destination=' + encoded, '_blank');
        }

        closeModalBtn.addEventListener('click', closeModal);
        modal.addEventListener('click', function (e) { if (e.target === modal) closeModal(); });
        document.addEventListener('keydown', function (e) { if (e.key === 'Escape') closeModal(); });

        const modalRerouteBtn = document.getElementById('modalRerouteBtn');

        modalRerouteBtn.addEventListener('click', function () {
            const address = document.getElementById('modalAddress').textContent;
            rerouteToGoogleMaps(address);
        });

        modalReportBtn.addEventListener('click', function () {
            const ticketNum = document.getElementById('modalTicketNum').textContent;
            showNotification('Reporting issue with ticket ' + ticketNum, 'info');
            closeModal();
        });

        function showNotification(message, type) {
            const notification = document.createElement('div');
            notification.style.cssText = `
                position: fixed; top: 20px; right: 20px; padding: 15px 20px;
                background: ${type === 'success' ? 'var(--success-green)' : type === 'info' ? 'var(--accent-blue-dark)' : 'var(--warning-orange)'};
                color: white; border-radius: var(--radius-md);
                box-shadow: 0 4px 12px rgba(0,0,0,0.15); z-index: 10001;
                animation: slideInRight 0.3s ease; display: flex; align-items: center;
                gap: 10px; max-width: 300px; font-family: 'Poppins', sans-serif;
            `;
            notification.innerHTML = `
                <i class="fas ${type === 'success' ? 'fa-check-circle' : type === 'info' ? 'fa-info-circle' : 'fa-exclamation-circle'}"></i>
                <span>${message}</span>
            `;
            document.body.appendChild(notification);
            setTimeout(() => {
                notification.style.animation = 'slideOutRight 0.3s ease';
                setTimeout(() => document.body.removeChild(notification), 300);
            }, 3000);
        }
    </script>
</asp:Content>
