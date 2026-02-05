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
            grid-template-columns: repeat(3, 1fr);
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
        .summary-card:nth-child(3) { animation-delay: 0.3s; }

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
            background: linear-gradient(
                90deg,
                transparent,
                rgba(255, 255, 255, 0.2),
                transparent
            );
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

        .summary-value.cancelled {
            color: var(--danger-red);
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
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
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

        .delivery-card:nth-child(1) { animation-delay: 0.1s; }
        .delivery-card:nth-child(2) { animation-delay: 0.2s; }
        .delivery-card:nth-child(3) { animation-delay: 0.3s; }
        .delivery-card:nth-child(4) { animation-delay: 0.4s; }

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
            background: linear-gradient(
                90deg,
                transparent,
                rgba(255, 255, 255, 0.1),
                transparent
            );
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

        .delivery-info {
            flex: 1;
        }

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

        .delivery-time i {
            font-size: 11px;
        }

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

        .status-cancelled {
            background: var(--danger-red-light);
            color: var(--danger-red);
            border-color: var(--danger-red);
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

        .location-text {
            flex: 1;
        }

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

        .metric-stars {
            color: var(--warning-orange);
            font-size: 11px;
            display: flex;
            align-items: center;
            gap: 3px;
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
            background: linear-gradient(
                90deg,
                transparent,
                rgba(255, 255, 255, 0.2),
                transparent
            );
            transition: left 0.7s;
        }

        .action-btn:hover::before {
            left: 100%;
        }

        .action-btn:hover {
            transform: translateY(-2px);
        }

        .btn-view {
            background: var(--primary-maroon);
            color: white;
            box-shadow: var(--button-shadow);
        }

        .btn-view:hover {
            background: var(--primary-maroon-dark);
            box-shadow: var(--button-shadow-hover);
        }

        .btn-repeat {
            background: var(--accent-blue);
            color: var(--accent-blue-dark);
            border: 1px solid var(--accent-blue-dark);
        }

        .btn-repeat:hover {
            background: var(--accent-blue-dark);
            color: white;
        }

        .btn-repeat:disabled {
            opacity: 0.5;
            cursor: not-allowed;
            pointer-events: none;
        }

        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 8px;
            margin-top: 30px;
            padding-top: 25px;
            border-top: 1px solid var(--border-light);
            position: relative;
            z-index: 1;
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

        .page-btn:hover {
            background: var(--primary-maroon);
            color: white;
            border-color: var(--primary-maroon);
            transform: translateY(-2px);
        }

        .page-btn.active {
            background: var(--primary-maroon);
            color: white;
            border-color: var(--primary-maroon);
        }

        .page-btn.disabled {
            opacity: 0.5;
            cursor: not-allowed;
            pointer-events: none;
        }

        .modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            display: none;
            justify-content: center;
            align-items: center;
            z-index: 10000;
            animation: fadeIn 0.3s ease;
        }

        .modal-overlay.active {
            display: flex;
        }

        .modal-content {
            background: white;
            border-radius: var(--radius-xl);
            padding: 30px;
            width: 90%;
            max-width: 500px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
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

        .modal-section-title i {
            font-size: 14px;
        }

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

        .detail-row:last-child {
            border-bottom: none;
        }

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

        .modal-map {
            width: 100%;
            height: 200px;
            background: var(--accent-blue);
            border-radius: var(--radius-md);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--accent-blue-dark);
            font-weight: 600;
            border: 2px dashed var(--accent-blue-dark);
            margin: 10px 0;
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

        .modal-btn-primary {
            background: var(--primary-maroon);
            color: white;
            box-shadow: var(--button-shadow);
        }

        .modal-btn-primary:hover {
            background: var(--primary-maroon-dark);
            transform: translateY(-2px);
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

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        @keyframes slideUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @media (max-width: 1200px) {
            .stats-summary {
                grid-template-columns: repeat(2, 1fr);
            }
            
            .deliveries-grid {
                gap: 18px;
            }
        }

        @media (max-width: 992px) {
            .history-wrapper {
                padding: 20px;
            }
            
            .page-header-main {
                flex-direction: column;
                align-items: stretch;
                gap: 15px;
            }
            
            .deliveries-grid {
                grid-template-columns: 1fr;
            }
            
            .delivery-actions {
                flex-direction: column;
            }
            
            .action-btn {
                width: 100%;
            }
            
            .modal-content {
                width: 95%;
                padding: 20px;
            }
        }

        @media (max-width: 768px) {
            .stats-summary {
                grid-template-columns: 1fr;
            }
            
            .filter-bar {
                flex-direction: column;
                align-items: stretch;
            }
            
            .delivery-header {
                flex-direction: column;
                gap: 10px;
            }
            
            .delivery-status {
                align-self: flex-start;
            }
            
            .section-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 10px;
            }
            
            .header-title h1 {
                font-size: 24px;
            }
            
            .delivery-metrics {
                grid-template-columns: 1fr;
            }
            
            .metric-row {
                flex-direction: row;
                justify-content: space-between;
                align-items: center;
                padding-bottom: 10px;
                border-bottom: 1px dashed var(--border-light);
            }
            
            .metric-row:last-child {
                border-bottom: none;
            }
            
            .modal-details {
                gap: 10px;
            }
            
            .detail-row {
                flex-direction: column;
                align-items: flex-start;
                gap: 5px;
            }
            
            .detail-value {
                text-align: left;
            }
            
            .modal-actions {
                flex-direction: column;
            }
        }

        @media (max-width: 480px) {
            .history-wrapper {
                padding: 15px;
            }
            
            .summary-value {
                font-size: 28px;
            }
            
            .summary-icon {
                width: 48px;
                height: 48px;
                font-size: 18px;
            }
            
            .delivery-card {
                padding: 18px;
            }
            
            .location-row {
                flex-direction: column;
                gap: 8px;
            }
            
            .location-icon {
                align-self: flex-start;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="modal-overlay" id="deliveryModal">
        <div class="modal-content">
            <div class="modal-header">
                <h2 class="modal-title" id="modalDeliveryId">#DL-0000</h2>
                <button class="close-modal" id="closeModal">
                    <i class="fas fa-times"></i>
                </button>
            </div>
            <div class="modal-body">
                <div class="modal-section">
                    <h3 class="modal-section-title">
                        <i class="fas fa-info-circle"></i>
                        Delivery Information
                    </h3>
                    <div class="modal-details">
                        <div class="detail-row">
                            <span class="detail-label">Status:</span>
                            <span class="detail-value" id="modalStatus">Completed</span>
                        </div>
                        <div class="detail-row">
                            <span class="detail-label">Date & Time:</span>
                            <span class="detail-value" id="modalDateTime">Jan 26, 2026 at 14:30</span>
                        </div>
                        <div class="detail-row">
                            <span class="detail-label">Delivery ID:</span>
                            <span class="detail-value" id="modalFullId">DL-4567</span>
                        </div>
                    </div>
                </div>

                <div class="modal-section">
                    <h3 class="modal-section-title">
                        <i class="fas fa-route"></i>
                        Delivery Route
                    </h3>
                    <div class="modal-details">
                        <div class="detail-row">
                            <span class="detail-label">Pickup Location:</span>
                            <span class="detail-value" id="modalPickup">Caballeros Restaurants</span>
                        </div>
                        <div class="detail-row">
                            <span class="detail-label">Drop-off Location:</span>
                            <span class="detail-value" id="modalDropoff">123 Main Street, Dasma</span>
                        </div>
                        <div class="modal-map">
                            <i class="fas fa-map-marked-alt"></i>
                            <span>Delivery Route Map</span>
                        </div>
                        <div class="detail-row">
                            <span class="detail-label">Distance:</span>
                            <span class="detail-value" id="modalDistance">3.2 km</span>
                        </div>
                        <div class="detail-row">
                            <span class="detail-label">Delivery Time:</span>
                            <span class="detail-value" id="modalDeliveryTime">18 minutes</span>
                        </div>
                    </div>
                </div>

                <div class="modal-section">
                    <h3 class="modal-section-title">
                        <i class="fas fa-chart-line"></i>
                        Performance Metrics
                    </h3>
                    <div class="modal-details">
                        <div class="detail-row">
                            <span class="detail-label">Earnings:</span>
                            <span class="detail-value" id="modalEarnings">₱85.00</span>
                        </div>
                        <div class="detail-row">
                            <span class="detail-label">Rating:</span>
                            <span class="detail-value" id="modalRating">4.8/5</span>
                        </div>
                        <div class="detail-row">
                            <span class="detail-label">Customer Tip:</span>
                            <span class="detail-value" id="modalTip">₱15.00</span>
                        </div>
                        <div class="detail-row">
                            <span class="detail-label">Platform Fee:</span>
                            <span class="detail-value" id="modalFee">₱10.00</span>
                        </div>
                        <div class="detail-row">
                            <span class="detail-label">Net Earnings:</span>
                            <span class="detail-value" style="color: var(--success-green); font-weight: 700;" id="modalNetEarnings">₱90.00</span>
                        </div>
                    </div>
                </div>

                <div class="modal-section">
                    <h3 class="modal-section-title">
                        <i class="fas fa-user"></i>
                        Customer Information
                    </h3>
                    <div class="modal-details">
                        <div class="detail-row">
                            <span class="detail-label">Customer Name:</span>
                            <span class="detail-value" id="modalCustomer">Jayr Casano</span>
                        </div>
                        <div class="detail-row">
                            <span class="detail-label">Contact Number:</span>
                            <span class="detail-value" id="modalContact">0917-123-4567</span>
                        </div>
                        <div class="detail-row">
                            <span class="detail-label">Special Instructions:</span>
                            <span class="detail-value" id="modalInstructions">Leave at the gate</span>
                        </div>
                    </div>
                </div>

                <div class="modal-actions">
                    <button class="modal-btn modal-btn-primary" id="modalRepeatBtn">
                        <i class="fas fa-redo"></i>
                        Repeat Delivery
                    </button>
                    <button class="modal-btn modal-btn-secondary" id="modalReportBtn">
                        <i class="fas fa-flag"></i>
                        Report Issue
                    </button>
                </div>
            </div>
        </div>
    </div>

    <div class="history-wrapper">
        <div class="page-header-main">
            <div class="header-title">
                <h1>Delivery History</h1>
                <p>Review your past deliveries and track your performance</p>
            </div>
            
            <div class="filter-bar">
                <select class="filter-select" id="statusFilter">
                    <option value="all">All Status</option>
                    <option value="completed">Completed</option>
                    <option value="cancelled">Cancelled</option>
                </select>
            </div>
        </div>

        <div class="stats-summary">
            <div class="summary-card">
                <div class="summary-content">
                    <div class="summary-label">Total Deliveries</div>
                    <div class="summary-value">156</div>
                </div>
                <div class="summary-icon">
                    <i class="fas fa-box"></i>
                </div>
            </div>
            
            <div class="summary-card">
                <div class="summary-content">
                    <div class="summary-label">Completed</div>
                    <div class="summary-value completed">152</div>
                </div>
                <div class="summary-icon" style="background: var(--success-green-light); color: var(--success-green);">
                    <i class="fas fa-check-circle"></i>
                </div>
            </div>
            
            <div class="summary-card">
                <div class="summary-content">
                    <div class="summary-label">Cancelled</div>
                    <div class="summary-value cancelled">4</div>
                </div>
                <div class="summary-icon" style="background: var(--danger-red-light); color: var(--danger-red);">
                    <i class="fas fa-times-circle"></i>
                </div>
            </div>
        </div>

        <div class="deliveries-container">
            <div class="section-header">
                <h2 class="section-title">Recent Deliveries</h2>
                <span class="results-count" id="resultsCount">Showing 4 of 156 deliveries</span>
            </div>
            
            <div class="deliveries-grid" id="deliveriesGrid">
                <div class="delivery-card" data-status="completed">
                    <div class="delivery-header">
                        <div class="delivery-info">
                            <span class="delivery-id">#DL-4567</span>
                            <div class="delivery-time">
                                <i class="far fa-calendar"></i>
                                Jan 26, 2026 at 14:30
                            </div>
                        </div>
                        <span class="delivery-status status-completed">Completed</span>
                    </div>
                    
                    <div class="delivery-content">
                        <div class="location-info">
                            <div class="location-row">
                                <div class="location-icon">
                                    <i class="fas fa-map-marker-alt"></i>
                                </div>
                                <div class="location-text">
                                    <div class="location-label">PICKUP LOCATION</div>
                                    <div class="location-address">Caballeros Restaurants</div>
                                </div>
                            </div>
                            
                            <div class="location-row">
                                <div class="location-icon" style="background: var(--success-green-light); color: var(--success-green);">
                                    <i class="fas fa-flag-checkered"></i>
                                </div>
                                <div class="location-text">
                                    <div class="location-label">DROP-OFF LOCATION</div>
                                    <div class="location-address">123 Main Street, Dasma</div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="delivery-metrics">
                            <div class="metric-row">
                                <span class="metric-label">Distance</span>
                                <span class="metric-value">3.2 km</span>
                            </div>
                            <div class="metric-row">
                                <span class="metric-label">Time</span>
                                <span class="metric-value">18 min</span>
                            </div>
                            <div class="metric-row">
                                <span class="metric-label">Earnings</span>
                                <span class="metric-value highlight">₱85</span>
                            </div>
                            <div class="metric-row">
                                <span class="metric-label">Rating</span>
                                <span class="metric-value">
                                    <span class="metric-stars">
                                        <i class="fas fa-star"></i>
                                        4.8/5
                                    </span>
                                </span>
                            </div>
                        </div>
                    </div>
                    
                    <div class="delivery-actions">
                        <button type="button" class="action-btn btn-view" data-delivery-id="DL-4567">
                            <i class="fas fa-eye"></i>
                            View Details
                        </button>
                        <button type="button" class="action-btn btn-repeat">
                            <i class="fas fa-redo"></i>
                            Repeat Route
                        </button>
                    </div>
                </div>

                <div class="delivery-card" data-status="completed">
                    <div class="delivery-header">
                        <div class="delivery-info">
                            <span class="delivery-id">#DL-4568</span>
                            <div class="delivery-time">
                                <i class="far fa-calendar"></i>
                                Jan 29, 2026 at 12:15
                            </div>
                        </div>
                        <span class="delivery-status status-completed">Completed</span>
                    </div>
                    
                    <div class="delivery-content">
                        <div class="location-info">
                            <div class="location-row">
                                <div class="location-icon">
                                    <i class="fas fa-map-marker-alt"></i>
                                </div>
                                <div class="location-text">
                                    <div class="location-label">PICKUP LOCATION</div>
                                    <div class="location-address">Caballeros Restaurants</div>
                                </div>
                            </div>
                            
                            <div class="location-row">
                                <div class="location-icon" style="background: var(--success-green-light); color: var(--success-green);">
                                    <i class="fas fa-flag-checkered"></i>
                                </div>
                                <div class="location-text">
                                    <div class="location-label">DROP-OFF LOCATION</div>
                                    <div class="location-address">456 Oak Street, Dasma</div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="delivery-metrics">
                            <div class="metric-row">
                                <span class="metric-label">Distance</span>
                                <span class="metric-value">2.8 km</span>
                            </div>
                            <div class="metric-row">
                                <span class="metric-label">Time</span>
                                <span class="metric-value">15 min</span>
                            </div>
                            <div class="metric-row">
                                <span class="metric-label">Earnings</span>
                                <span class="metric-value highlight">₱75</span>
                            </div>
                            <div class="metric-row">
                                <span class="metric-label">Rating</span>
                                <span class="metric-value">
                                    <span class="metric-stars">
                                        <i class="fas fa-star"></i>
                                        5.0/5
                                    </span>
                                </span>
                            </div>
                        </div>
                    </div>
                    
                    <div class="delivery-actions">
                        <button type="button" class="action-btn btn-view" data-delivery-id="DL-4568">
                            <i class="fas fa-eye"></i>
                            View Details
                        </button>
                        <button type="button" class="action-btn btn-repeat">
                            <i class="fas fa-redo"></i>
                            Repeat Route
                        </button>
                    </div>
                </div>

                <div class="delivery-card" data-status="cancelled">
                    <div class="delivery-header">
                        <div class="delivery-info">
                            <span class="delivery-id">#DL-4569</span>
                            <div class="delivery-time">
                                <i class="far fa-calendar"></i>
                                Jan 28, 2026 at 19:45
                            </div>
                        </div>
                        <span class="delivery-status status-cancelled">Cancelled</span>
                    </div>
                    
                    <div class="delivery-content">
                        <div class="location-info">
                            <div class="location-row">
                                <div class="location-icon">
                                    <i class="fas fa-map-marker-alt"></i>
                                </div>
                                <div class="location-text">
                                    <div class="location-label">PICKUP LOCATION</div>
                                    <div class="location-address">Caballeros Restaurants</div>
                                </div>
                            </div>
                            
                            <div class="location-row">
                                <div class="location-icon" style="background: var(--danger-red-light); color: var(--danger-red);">
                                    <i class="fas fa-flag-checkered"></i>
                                </div>
                                <div class="location-text">
                                    <div class="location-label">DROP-OFF LOCATION</div>
                                    <div class="location-address">789 Pine Street, Dasma</div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="delivery-metrics">
                            <div class="metric-row">
                                <span class="metric-label">Distance</span>
                                <span class="metric-value">1.5 km</span>
                            </div>
                            <div class="metric-row">
                                <span class="metric-label">Status</span>
                                <span class="metric-value" style="color: var(--danger-red);">Cancelled</span>
                            </div>
                            <div class="metric-row">
                                <span class="metric-label">Earnings</span>
                                <span class="metric-value" style="color: var(--muted-text);">₱0</span>
                            </div>
                            <div class="metric-row">
                                <span class="metric-label">Reason</span>
                                <span class="metric-value">Customer</span>
                            </div>
                        </div>
                    </div>
                    
                    <div class="delivery-actions">
                        <button type="button" class="action-btn btn-view" data-delivery-id="DL-4569">
                            <i class="fas fa-eye"></i>
                            View Details
                        </button>
                        <button type="button" class="action-btn btn-repeat" disabled>
                            <i class="fas fa-redo"></i>
                            Repeat Route
                        </button>
                    </div>
                </div>

                <div class="delivery-card" data-status="completed">
                    <div class="delivery-header">
                        <div class="delivery-info">
                            <span class="delivery-id">#DL-4570</span>
                            <div class="delivery-time">
                                <i class="far fa-calendar"></i>
                                Jan 28, 2026 at 16:20
                            </div>
                        </div>
                        <span class="delivery-status status-completed">Completed</span>
                    </div>
                    
                    <div class="delivery-content">
                        <div class="location-info">
                            <div class="location-row">
                                <div class="location-icon">
                                    <i class="fas fa-map-marker-alt"></i>
                                </div>
                                <div class="location-text">
                                    <div class="location-label">PICKUP LOCATION</div>
                                    <div class="location-address">Caballeros Restaurants</div>
                                </div>
                            </div>
                            
                            <div class="location-row">
                                <div class="location-icon" style="background: var(--success-green-light); color: var(--success-green);">
                                    <i class="fas fa-flag-checkered"></i>
                                </div>
                                <div class="location-text">
                                    <div class="location-label">DROP-OFF LOCATION</div>
                                    <div class="location-address">101 Maple Street, Dasma</div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="delivery-metrics">
                            <div class="metric-row">
                                <span class="metric-label">Distance</span>
                                <span class="metric-value">3.5 km</span>
                            </div>
                            <div class="metric-row">
                                <span class="metric-label">Time</span>
                                <span class="metric-value">22 min</span>
                            </div>
                            <div class="metric-row">
                                <span class="metric-label">Earnings</span>
                                <span class="metric-value highlight">₱95</span>
                            </div>
                            <div class="metric-row">
                                <span class="metric-label">Rating</span>
                                <span class="metric-value">
                                    <span class="metric-stars">
                                        <i class="fas fa-star"></i>
                                        4.5/5
                                    </span>
                                </span>
                            </div>
                        </div>
                    </div>
                    
                    <div class="delivery-actions">
                        <button type="button" class="action-btn btn-view" data-delivery-id="DL-4570">
                            <i class="fas fa-eye"></i>
                            View Details
                        </button>
                        <button type="button" class="action-btn btn-repeat">
                            <i class="fas fa-redo"></i>
                            Repeat Route
                        </button>
                    </div>
                </div>
            </div>

            <div class="pagination">
                <button class="page-btn disabled">
                    <i class="fas fa-chevron-left"></i>
                </button>
                <button class="page-btn active">1</button>
                <button class="page-btn">2</button>
                <button class="page-btn">3</button>
                <span style="color: var(--muted-text); padding: 0 8px;">...</span>
                <button class="page-btn">12</button>
                <button class="page-btn">
                    <i class="fas fa-chevron-right"></i>
                </button>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const statusFilter = document.getElementById('statusFilter');
            const deliveryCards = document.querySelectorAll('.delivery-card');
            const resultsCount = document.getElementById('resultsCount');
            const modal = document.getElementById('deliveryModal');
            const closeModalBtn = document.getElementById('closeModal');
            const modalRepeatBtn = document.getElementById('modalRepeatBtn');
            const modalReportBtn = document.getElementById('modalReportBtn');

            const deliveryData = {
                'DL-4567': {
                    id: 'DL-4567',
                    status: 'Completed',
                    dateTime: 'Jan 26, 2026 at 14:30',
                    pickup: 'Caballeros Restaurants',
                    dropoff: '123 Main Street, Dasma',
                    distance: '3.2 km',
                    deliveryTime: '18 minutes',
                    earnings: '₱85.00',
                    rating: '4.8/5',
                    tip: '₱15.00',
                    fee: '₱10.00',
                    netEarnings: '₱90.00',
                    customer: 'Jayr Casano',
                    contact: '0917-123-4567',
                    instructions: 'Leave at the gate'
                },
                'DL-4568': {
                    id: 'DL-4568',
                    status: 'Completed',
                    dateTime: 'Jan 29, 2026 at 12:15',
                    pickup: 'Caballeros Restaurants',
                    dropoff: '456 Oak Street, Dasma',
                    distance: '2.8 km',
                    deliveryTime: '15 minutes',
                    earnings: '₱75.00',
                    rating: '5.0/5',
                    tip: '₱10.00',
                    fee: '₱8.00',
                    netEarnings: '₱77.00',
                    customer: 'George Gonzaga',
                    contact: '0918-987-6543',
                    instructions: 'Call upon arrival'
                },
                'DL-4569': {
                    id: 'DL-4569',
                    status: 'Cancelled',
                    dateTime: 'Jan 28, 2026 at 19:45',
                    pickup: 'Caballeros Restaurants',
                    dropoff: '789 Pine Street, Dasma',
                    distance: '1.5 km',
                    deliveryTime: 'N/A',
                    earnings: '₱0.00',
                    rating: 'N/A',
                    tip: '₱0.00',
                    fee: '₱0.00',
                    netEarnings: '₱0.00',
                    customer: 'Zea May Sulit',
                    contact: '0919-555-1234',
                    instructions: 'Customer cancelled order'
                },
                'DL-4570': {
                    id: 'DL-4570',
                    status: 'Completed',
                    dateTime: 'Jan 28, 2026 at 16:20',
                    pickup: 'Caballeros Restaurants',
                    dropoff: '101 Maple Street, Dasma',
                    distance: '3.5 km',
                    deliveryTime: '22 minutes',
                    earnings: '₱95.00',
                    rating: '4.5/5',
                    tip: '₱20.00',
                    fee: '₱12.00',
                    netEarnings: '₱103.00',
                    customer: 'Lalaine Reyes',
                    contact: '0916-777-8888',
                    instructions: 'Ring doorbell twice'
                }
            };

            function filterDeliveries() {
                const status = statusFilter.value;
                let visibleCount = 0;
                let totalCount = 0;

                deliveryCards.forEach(card => {
                    const cardStatus = card.dataset.status;

                    if (status === 'all' || cardStatus === status) {
                        card.style.display = 'flex';
                        visibleCount++;
                        setTimeout(() => {
                            card.style.opacity = '1';
                            card.style.transform = 'translateY(0)';
                        }, 10);
                    } else {
                        card.style.opacity = '0';
                        card.style.transform = 'translateY(10px)';
                        setTimeout(() => {
                            card.style.display = 'none';
                        }, 300);
                    }
                });

                if (status === 'all') {
                    totalCount = 156;
                    visibleCount = 4;
                } else if (status === 'completed') {
                    totalCount = 152;
                    visibleCount = Math.min(visibleCount, 4);
                } else if (status === 'cancelled') {
                    totalCount = 4;
                    visibleCount = Math.min(visibleCount, 4);
                }

                resultsCount.textContent = `Showing ${visibleCount} of ${totalCount} deliveries`;
            }

            function openModal(deliveryId) {
                const data = deliveryData[deliveryId];
                if (!data) return;

                document.getElementById('modalDeliveryId').textContent = '#' + data.id;
                document.getElementById('modalStatus').textContent = data.status;
                document.getElementById('modalDateTime').textContent = data.dateTime;
                document.getElementById('modalFullId').textContent = data.id;
                document.getElementById('modalPickup').textContent = data.pickup;
                document.getElementById('modalDropoff').textContent = data.dropoff;
                document.getElementById('modalDistance').textContent = data.distance;
                document.getElementById('modalDeliveryTime').textContent = data.deliveryTime;
                document.getElementById('modalEarnings').textContent = data.earnings;
                document.getElementById('modalRating').textContent = data.rating;
                document.getElementById('modalTip').textContent = data.tip;
                document.getElementById('modalFee').textContent = data.fee;
                document.getElementById('modalNetEarnings').textContent = data.netEarnings;
                document.getElementById('modalCustomer').textContent = data.customer;
                document.getElementById('modalContact').textContent = data.contact;
                document.getElementById('modalInstructions').textContent = data.instructions;

                const statusElement = document.getElementById('modalStatus');
                if (data.status === 'Completed') {
                    statusElement.style.color = 'var(--success-green)';
                    statusElement.style.fontWeight = '700';
                } else {
                    statusElement.style.color = 'var(--danger-red)';
                    statusElement.style.fontWeight = '700';
                }

                modal.classList.add('active');
                document.body.style.overflow = 'hidden';
            }

            function closeModal() {
                modal.classList.remove('active');
                document.body.style.overflow = 'auto';
            }

            statusFilter.addEventListener('change', filterDeliveries);

            document.addEventListener('click', function (e) {
                if (e.target.closest('.btn-view')) {
                    const btn = e.target.closest('.btn-view');
                    const deliveryId = btn.dataset.deliveryId;
                    openModal(deliveryId);
                }

                if (e.target.closest('.btn-repeat')) {
                    const btn = e.target.closest('.btn-repeat');
                    if (!btn.disabled) {
                        const card = btn.closest('.delivery-card');
                        const pickup = card.querySelector('.location-row:nth-child(1) .location-address').textContent;
                        const dropoff = card.querySelector('.location-row:nth-child(2) .location-address').textContent;
                        showNotification(`Repeating route from ${pickup} to ${dropoff}`, 'info');
                    }
                }

                if (e.target.closest('.page-btn') && !e.target.closest('.page-btn.disabled')) {
                    const pageBtn = e.target.closest('.page-btn');
                    const allPageBtns = document.querySelectorAll('.page-btn');

                    allPageBtns.forEach(btn => btn.classList.remove('active'));
                    pageBtn.classList.add('active');

                    showNotification('Loading page ' + pageBtn.textContent.trim() + '...', 'info');
                }
            });

            closeModalBtn.addEventListener('click', closeModal);

            modalRepeatBtn.addEventListener('click', function () {
                const deliveryId = document.getElementById('modalFullId').textContent;
                const pickup = document.getElementById('modalPickup').textContent;
                const dropoff = document.getElementById('modalDropoff').textContent;
                showNotification(`Repeating delivery ${deliveryId} from ${pickup} to ${dropoff}`, 'success');
                closeModal();
            });

            modalReportBtn.addEventListener('click', function () {
                const deliveryId = document.getElementById('modalFullId').textContent;
                showNotification(`Reporting issue with delivery ${deliveryId}`, 'info');
                closeModal();
            });

            modal.addEventListener('click', function (e) {
                if (e.target === modal) {
                    closeModal();
                }
            });

            document.addEventListener('keydown', function (e) {
                if (e.key === 'Escape' && modal.classList.contains('active')) {
                    closeModal();
                }
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
                            'var(--warning-orange)'};
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

            const style = document.createElement('style');
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

            filterDeliveries();
        });
    </script>
</asp:Content>