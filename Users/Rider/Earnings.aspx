<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Rider.Master" AutoEventWireup="true" CodeBehind="Earnings.aspx.cs" Inherits="TasteNet.Users.Rider.Earnings" %>
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
            --success-green-dark: #1f7a5e;
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

        body.modal-open {
            overflow: hidden !important;
            position: fixed;
            width: 100%;
            height: 100%;
        }

        .earnings-wrapper {
            background: var(--soft-cream) !important;
            padding: 25px 35px;
            max-width: 1400px;
            margin: 0 auto;
            min-height: 100vh;
            box-sizing: border-box;
            position: relative;
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

        .btn-payout {
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

        .btn-payout:hover {
            background: var(--primary-maroon-dark);
            transform: translateY(-2px);
            box-shadow: var(--button-shadow-hover);
        }

        .btn-payout i {
            font-size: 13px;
        }

        .time-toggle {
            display: inline-flex;
            background: var(--bg-lighter);
            border-radius: var(--radius-lg);
            padding: 4px;
            border: 1px solid var(--border-light);
            margin-bottom: 25px;
            box-shadow: var(--card-shadow);
        }

        .time-toggle-btn {
            padding: 8px 20px;
            border: none;
            border-radius: var(--radius-md);
            background: transparent;
            color: var(--muted-text);
            cursor: pointer;
            font-family: 'Poppins', sans-serif;
            font-size: 13px;
            font-weight: 500;
            transition: all var(--transition-base);
            min-width: 80px;
            text-align: center;
        }

        .time-toggle-btn:hover {
            color: var(--text-dark);
            background: var(--bg-hover);
        }

        .time-toggle-btn.active {
            background: var(--primary-maroon);
            color: white;
            box-shadow: 0 2px 8px rgba(107, 13, 30, 0.15);
        }

        .summary-grid {
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
            flex-direction: column;
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

        .card-label {
            font-size: 12px;
            font-weight: 500;
            color: var(--muted-text);
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 8px;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .card-label i {
            font-size: 11px;
        }

        .card-value {
            font-size: 32px;
            font-weight: 700;
            color: var(--text-dark);
            margin: 0 0 10px 0;
            line-height: 1;
        }

        .card-meta {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: auto;
            padding-top: 15px;
            border-top: 1px dashed var(--border-light);
        }

        .card-subtext {
            color: var(--muted-text);
            font-size: 13px;
            font-weight: 400;
        }

        .card-trend {
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

        .card-trend.down {
            background: var(--danger-red-light);
            color: var(--danger-red);
        }

        .content-section {
            background: white;
            padding: 28px;
            border-radius: var(--radius-xl);
            margin-bottom: 25px;
            box-shadow: var(--card-shadow);
            border: 1px solid var(--border-light);
            transition: all var(--transition-base);
        }

        .content-section:hover {
            border-color: var(--border-hover);
            box-shadow: var(--card-shadow-hover);
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
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
        }

        .section-actions {
            display: flex;
            gap: 10px;
        }

        .btn-secondary {
            background: transparent;
            color: var(--primary-maroon);
            border: 1px solid var(--primary-maroon);
            padding: 8px 16px;
            border-radius: var(--radius-md);
            cursor: pointer;
            font-family: 'Poppins', sans-serif;
            font-size: 12px;
            font-weight: 500;
            transition: all var(--transition-base);
        }

        .btn-secondary:hover {
            background: var(--primary-maroon);
            color: white;
        }

        .data-list {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .data-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 16px;
            border-radius: var(--radius-lg);
            background: var(--bg-lighter);
            border: 1px solid transparent;
            transition: all var(--transition-base);
            animation: slideUp 0.3s ease-out;
            animation-fill-mode: both;
        }

        .data-row:nth-child(1) { animation-delay: 0.1s; }
        .data-row:nth-child(2) { animation-delay: 0.2s; }
        .data-row:nth-child(3) { animation-delay: 0.3s; }
        .data-row:nth-child(4) { animation-delay: 0.4s; }
        .data-row:nth-child(5) { animation-delay: 0.5s; }

        .data-row:hover {
            background: var(--bg-hover);
            border-color: var(--border-light);
            transform: translateX(5px);
        }

        .row-info {
            flex: 1;
            display: flex;
            flex-direction: column;
            gap: 4px;
        }

        .row-title {
            font-size: 14px;
            font-weight: 600;
            color: var(--text-dark);
            margin-bottom: 0;
        }

        .row-meta {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .row-subtitle {
            color: var(--muted-text);
            font-size: 12px;
            font-weight: 500;
        }

        .row-time {
            color: var(--muted-text);
            font-size: 11px;
            font-weight: 400;
            font-style: italic;
        }

        .row-badge {
            padding: 2px 8px;
            border-radius: var(--radius-sm);
            font-size: 10px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.3px;
        }

        .badge-active {
            background: var(--success-green-light);
            color: var(--success-green);
            border: 1px solid var(--success-green);
        }

        .badge-pending {
            background: var(--warning-orange-light);
            color: var(--warning-orange);
            border: 1px solid var(--warning-orange);
        }

        .badge-completed {
            background: var(--success-green-light);
            color: var(--success-green);
            border: 1px solid var(--success-green);
        }

        .badge-cancelled {
            background: var(--danger-red-light);
            color: var(--danger-red);
            border: 1px solid var(--danger-red);
        }

        .row-amount {
            font-size: 16px;
            font-weight: 700;
            color: var(--success-green);
            text-align: right;
            min-width: 80px;
        }

        .row-amount.negative {
            color: var(--danger-red);
        }

        .modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0, 0, 0, 0.5);
            backdrop-filter: blur(8px);
            -webkit-backdrop-filter: blur(8px);
            display: none;
            justify-content: center;
            align-items: flex-start;
            z-index: 10000;
            padding: 40px 20px 20px 20px;
            animation: fadeIn 0.3s ease;
            opacity: 0;
            transition: opacity 0.3s ease, display 0.3s ease;
            overflow-y: auto;
        }

        .modal-overlay.active {
            display: flex !important;
            opacity: 1;
            z-index: 99999 !important;
            top: 0 !important;
            position: fixed !important;
        }

        .modal-container {
            background: white;
            border-radius: var(--radius-xl);
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            width: 100%;
            max-width: 500px;
            overflow: hidden;
            animation: slideDown 0.3s ease;
            border: 1px solid var(--border-light);
            margin-top: 0;
            max-height: calc(100vh - 60px);
            overflow-y: auto;
            position: relative;
        }

        .modal-header {
            padding: 24px 28px;
            background: var(--primary-maroon);
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: sticky;
            top: 0;
            z-index: 1;
        }

        .modal-title {
            font-size: 20px;
            font-weight: 600;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .modal-title i {
            font-size: 18px;
        }

        .modal-close {
            background: rgba(255, 255, 255, 0.2);
            border: none;
            width: 32px;
            height: 32px;
            border-radius: 50%;
            color: white;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all var(--transition-base);
        }

        .modal-close:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: rotate(90deg);
        }

        .modal-body {
            padding: 28px;
        }

        .modal-summary {
            background: var(--bg-lighter);
            border-radius: var(--radius-lg);
            padding: 20px;
            margin-bottom: 25px;
            border: 1px solid var(--border-light);
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 0;
        }

        .summary-label {
            color: var(--muted-text);
            font-size: 14px;
            font-weight: 500;
        }

        .summary-value {
            font-size: 18px;
            font-weight: 700;
            color: var(--text-dark);
        }

        .summary-value.highlight {
            color: var(--success-green);
            font-size: 20px;
        }

        .modal-form {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .form-label {
            font-size: 14px;
            font-weight: 600;
            color: var(--text-dark);
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .form-label i {
            color: var(--primary-maroon);
            font-size: 12px;
        }

        .form-select {
            padding: 12px 16px;
            border-radius: var(--radius-md);
            border: 1px solid var(--border-light);
            background: white;
            color: var(--text-dark);
            font-family: 'Poppins', sans-serif;
            font-size: 14px;
            transition: all var(--transition-base);
            cursor: pointer;
        }

        .form-select:hover {
            border-color: var(--primary-maroon);
        }

        .form-select:focus {
            outline: none;
            border-color: var(--primary-maroon);
            box-shadow: 0 0 0 3px rgba(107, 13, 30, 0.1);
        }

        .amount-input {
            padding: 12px 16px;
            border-radius: var(--radius-md);
            border: 1px solid var(--border-light);
            background: white;
            color: var(--text-dark);
            font-family: 'Poppins', sans-serif;
            font-size: 16px;
            font-weight: 600;
            transition: all var(--transition-base);
            text-align: right;
        }

        .amount-input:focus {
            outline: none;
            border-color: var(--primary-maroon);
            box-shadow: 0 0 0 3px rgba(107, 13, 30, 0.1);
        }

        .amount-input::placeholder {
            color: var(--muted-text);
            font-weight: 400;
        }

        .form-note {
            color: var(--muted-text);
            font-size: 12px;
            font-style: italic;
            margin-top: 4px;
        }

        .form-actions {
            display: flex;
            gap: 15px;
            margin-top: 10px;
        }

        .btn-modal-primary {
            flex: 1;
            background: var(--primary-maroon);
            color: white;
            border: none;
            padding: 14px;
            border-radius: var(--radius-md);
            cursor: pointer;
            font-family: 'Poppins', sans-serif;
            font-size: 15px;
            font-weight: 600;
            transition: all var(--transition-base);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .btn-modal-primary:hover {
            background: var(--primary-maroon-dark);
            transform: translateY(-2px);
            box-shadow: var(--button-shadow-hover);
        }

        .btn-modal-secondary {
            flex: 1;
            background: transparent;
            color: var(--muted-text);
            border: 1px solid var(--border-light);
            padding: 14px;
            border-radius: var(--radius-md);
            cursor: pointer;
            font-family: 'Poppins', sans-serif;
            font-size: 15px;
            font-weight: 500;
            transition: all var(--transition-base);
        }

        .btn-modal-secondary:hover {
            border-color: var(--primary-maroon);
            color: var(--primary-maroon);
        }

        .modal-footer {
            padding: 20px 28px;
            background: var(--bg-lighter);
            border-top: 1px solid var(--border-light);
            font-size: 12px;
            color: var(--muted-text);
            text-align: center;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        @keyframes slideUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes slideDown {
            from { 
                opacity: 0; 
                transform: translateY(-30px); 
            }
            to { 
                opacity: 1; 
                transform: translateY(0); 
            }
        }

        @keyframes slideInRight {
            from { transform: translateX(100%); opacity: 0; }
            to { transform: translateX(0); opacity: 1; }
        }
        
        @keyframes slideOutRight {
            from { transform: translateX(0); opacity: 1; }
            to { transform: translateX(100%); opacity: 0; }
        }

        @media (max-width: 1200px) {
            .summary-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 992px) {
            .earnings-wrapper {
                padding: 20px;
            }
            
            .page-header-main {
                flex-direction: column;
                align-items: stretch;
                gap: 15px;
            }
            
            .btn-payout {
                align-self: flex-start;
            }
            
            .modal-container {
                max-width: 90%;
            }
        }

        @media (max-width: 768px) {
            .summary-grid {
                grid-template-columns: 1fr;
            }
            
            .data-row {
                flex-direction: column;
                align-items: flex-start;
                gap: 10px;
            }
            
            .row-amount {
                align-self: flex-end;
            }
            
            .header-title h1 {
                font-size: 24px;
            }
            
            .card-value {
                font-size: 28px;
            }
            
            .form-actions {
                flex-direction: column;
            }
            
            .modal-overlay {
                padding: 20px 10px 10px 10px;
                align-items: flex-start;
            }
            
            .modal-container {
                max-height: calc(100vh - 30px);
                margin-top: 0;
            }
        }

        @media (max-height: 700px) {
            .modal-container {
                max-height: 85vh;
            }
        }

        @media (max-width: 480px) {
            .earnings-wrapper {
                padding: 15px;
            }
            
            .content-section {
                padding: 20px;
            }
            
            .summary-card {
                padding: 20px;
            }
            
            .time-toggle {
                width: 100%;
            }
            
            .time-toggle-btn {
                flex: 1;
                padding: 8px 12px;
                min-width: auto;
            }
            
            .modal-body {
                padding: 20px;
            }
            
            .modal-header {
                padding: 20px;
            }
            
            .modal-footer {
                padding: 15px 20px;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="modal-overlay" id="payoutModal">
        <div class="modal-container">
            <div class="modal-header">
                <h3 class="modal-title">
                    <i class="fas fa-wallet"></i>
                    Request Payout
                </h3>
                <button type="button" class="modal-close" id="closeModal">
                    <i class="fas fa-times"></i>
                </button>
            </div>
            
            <div class="modal-body">
                <div class="modal-summary">
                    <div class="summary-row">
                        <span class="summary-label">Available Balance</span>
                        <span class="summary-value highlight" id="modalBalance">₱1,250.75</span>
                    </div>
                    <div class="summary-row">
                        <span class="summary-label">Minimum Payout</span>
                        <span class="summary-value">₱500.00</span>
                    </div>
                    <div class="summary-row">
                        <span class="summary-label">Next Processing</span>
                        <span class="summary-value">Within 24-48 hours</span>
                    </div>
                </div>
                
                <div class="modal-form" id="payoutForm">
                    <div class="form-group">
                        <label class="form-label">
                            <i class="fas fa-credit-card"></i>
                            Payout Method
                        </label>
                        <select class="form-select" id="payoutMethod">
                            <option value="">Select payout method</option>
                            <option value="gcash">GCash</option>
                            <option value="paymaya">PayMaya</option>
                            <option value="bank">Bank Transfer</option>
                            <option value="cash">Cash Pickup</option>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">
                            <i class="fas fa-money-bill-wave"></i>
                            Payout Amount
                        </label>
                        <input type="text" 
                               class="amount-input" 
                               id="payoutAmount" 
                               placeholder="Enter amount"
                               value="₱1,250.75">
                        <div class="form-note">
                            You can withdraw any amount between ₱500.00 and your available balance
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">
                            <i class="fas fa-comment-alt"></i>
                            Notes (Optional)
                        </label>
                        <textarea class="form-select" 
                                  id="payoutNotes" 
                                  rows="3" 
                                  placeholder="Add any special instructions or notes..."></textarea>
                    </div>
                    
                    <div class="form-actions">
                        <button type="button" class="btn-modal-primary" id="submitPayout">
                            <i class="fas fa-paper-plane"></i>
                            Submit Payout Request
                        </button>
                        <button type="button" class="btn-modal-secondary" id="cancelPayout">
                            Cancel
                        </button>
                    </div>
                </div>
            </div>
            
            <div class="modal-footer">
                <p><i class="fas fa-info-circle"></i> Payouts are processed on business days (Mon-Fri) within 24-48 hours</p>
            </div>
        </div>
    </div>

    <div class="earnings-wrapper">
        <div class="page-header-main">
            <div class="header-title">
                <h1>Earnings & Wallet</h1>
                <p>Track your earnings, bonuses, and manage your wallet balance</p>
            </div>
            
            <button type="button" class="btn-payout" id="openPayoutModal">
                <i class="fas fa-wallet"></i>
                Request Payout
            </button>
        </div>

        <div class="time-toggle">
            <button type="button" class="time-toggle-btn active">Daily</button>
            <button type="button" class="time-toggle-btn">Weekly</button>
            <button type="button" class="time-toggle-btn">Monthly</button>
            <button type="button" class="time-toggle-btn">Yearly</button>
        </div>

        <div class="summary-grid">
            <div class="summary-card">
                <div class="card-label">
                    <i class="fas fa-money-bill-wave"></i>
                    Total Earnings
                </div>
                <div class="card-value">₱4,850.50</div>
                <div class="card-meta">
                    <span class="card-subtext">156 deliveries</span>
                    <span class="card-trend">
                        <i class="fas fa-arrow-up"></i>
                        12% from last week
                    </span>
                </div>
            </div>
            
            <div class="summary-card">
                <div class="card-label">
                    <i class="fas fa-chart-line"></i>
                    Average per Delivery
                </div>
                <div class="card-value">₱31.09</div>
                <div class="card-meta">
                    <span class="card-subtext">Per successful delivery</span>
                    <span class="card-trend">
                        <i class="fas fa-arrow-up"></i>
                        8% increase
                    </span>
                </div>
            </div>
            
            <div class="summary-card">
                <div class="card-label">
                    <i class="fas fa-piggy-bank"></i>
                    Available Balance
                </div>
                <div class="card-value">₱1,250.75</div>
                <div class="card-meta">
                    <span class="card-subtext">Ready for withdrawal</span>
                    <span class="card-trend">
                        <i class="fas fa-clock"></i>
                        Next payout: Feb 5
                    </span>
                </div>
            </div>
        </div>

        <div class="content-section">
            <div class="section-header">
                <h3 class="section-title">
                    <i class="fas fa-gift"></i>
                    Incentives & Bonuses
                </h3>
            </div>
            
            <div class="data-list">
                <div class="data-row">
                    <div class="row-info">
                        <div class="row-title">Peak Hour Bonus</div>
                        <div class="row-meta">
                            <span class="row-subtitle">Weekdays 6-9 PM</span>
                            <span class="row-badge badge-active">Active</span>
                        </div>
                    </div>
                    <div class="row-amount">+₱120.00</div>
                </div>
                
                <div class="data-row">
                    <div class="row-info">
                        <div class="row-title">Weekend Boost</div>
                        <div class="row-meta">
                            <span class="row-subtitle">Sat-Sun all day</span>
                            <span class="row-badge badge-pending">Pending</span>
                        </div>
                    </div>
                    <div class="row-amount">+₱85.50</div>
                </div>
                
                <div class="data-row">
                    <div class="row-info">
                        <div class="row-title">Referral Bonus</div>
                        <div class="row-meta">
                            <span class="row-subtitle">2 new riders referred</span>
                            <span class="row-badge badge-active">Active</span>
                        </div>
                    </div>
                    <div class="row-amount">+₱200.00</div>
                </div>
            </div>
        </div>

        <div class="content-section">
            <div class="section-header">
                <h3 class="section-title">
                    <i class="fas fa-history"></i>
                    Recent Earnings
                </h3>
                <div class="section-actions">
                    <button type="button" class="btn-secondary" id="viewAllEarnings">
                        View All
                    </button>
                </div>
            </div>
            
            <div class="data-list">
                <div class="data-row">
                    <div class="row-info">
                        <div class="row-title">Parklane</div>
                        <div class="row-meta">
                            <span class="row-subtitle">Order #PL-45678</span>
                            <span class="row-time">Today, 3:45 PM</span>
                            <span class="row-badge badge-completed">Completed</span>
                        </div>
                    </div>
                    <div class="row-amount">+₱42.50</div>
                </div>
                
                <div class="data-row">
                    <div class="row-info">
                        <div class="row-title">Greensborough</div>
                        <div class="row-meta">
                            <span class="row-subtitle">Order #GB-12345</span>
                            <span class="row-time">Today, 2:30 PM</span>
                        </div>
                    </div>
                    <div class="row-amount">+₱38.75</div>
                </div>
                
                <div class="data-row">
                    <div class="row-info">
                        <div class="row-title">San Jose Dasma</div>
                        <div class="row-meta">
                            <span class="row-subtitle">Order #SJD-78901</span>
                            <span class="row-time">Today, 1:15 PM</span>
                            <span class="row-badge badge-completed">Completed</span>
                        </div>
                    </div>
                    <div class="row-amount">+₱55.00</div>
                </div>
                
                <div class="data-row">
                    <div class="row-info">
                        <div class="row-title">Sunrise Hills</div>
                        <div class="row-meta">
                            <span class="row-subtitle">Order #SH-23456</span>
                            <span class="row-time">Yesterday, 7:30 PM</span>
                        </div>
                    </div>
                    <div class="row-amount">+₱47.25</div>
                </div>
                
                <div class="data-row">
                    <div class="row-info">
                        <div class="row-title">Burol Main Dasma</div>
                        <div class="row-meta">
                            <span class="row-subtitle">Order #BMD-34567</span>
                            <span class="row-time">Yesterday, 6:15 PM</span>
                            <span class="row-badge badge-cancelled">Cancelled</span>
                        </div>
                    </div>
                    <div class="row-amount negative">-₱15.00</div>
                </div>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const payoutModal = document.getElementById('payoutModal');
            const openPayoutBtn = document.getElementById('openPayoutModal');
            const closeModalBtn = document.getElementById('closeModal');
            const cancelPayoutBtn = document.getElementById('cancelPayout');
            const submitPayoutBtn = document.getElementById('submitPayout');

            const balanceElement = document.querySelector('.summary-card:nth-child(3) .card-value');
            const availableBalance = balanceElement ? balanceElement.textContent : '₱1,250.75';

            const modalBalance = document.getElementById('modalBalance');
            const payoutAmountInput = document.getElementById('payoutAmount');

            if (modalBalance) modalBalance.textContent = availableBalance;
            if (payoutAmountInput) payoutAmountInput.value = availableBalance;

            if (openPayoutBtn) {
                openPayoutBtn.addEventListener('click', function (e) {
                    e.preventDefault();
                    e.stopPropagation();

                    if (payoutModal) {
                        payoutModal.classList.add('active');
                        document.body.classList.add('modal-open');

                        payoutModal.scrollTop = 0;
                        document.querySelector('.modal-container').scrollTop = 0;

                        setTimeout(() => {
                            if (payoutAmountInput) {
                                payoutAmountInput.focus();
                                payoutAmountInput.select();
                            }
                        }, 100);
                    }
                });
            }

            function closeModal() {
                if (payoutModal) {
                    payoutModal.classList.remove('active');
                    document.body.classList.remove('modal-open');
                }
            }

            if (closeModalBtn) {
                closeModalBtn.addEventListener('click', closeModal);
            }

            if (cancelPayoutBtn) {
                cancelPayoutBtn.addEventListener('click', closeModal);
            }

            if (payoutModal) {
                payoutModal.addEventListener('click', function (e) {
                    if (e.target === payoutModal) {
                        closeModal();
                    }
                });
            }

            document.addEventListener('keydown', function (e) {
                if (e.key === 'Escape' && payoutModal && payoutModal.classList.contains('active')) {
                    closeModal();
                }
            });

            if (submitPayoutBtn) {
                submitPayoutBtn.addEventListener('click', function (e) {
                    e.preventDefault();

                    const payoutMethod = document.getElementById('payoutMethod')?.value;
                    const payoutAmount = payoutAmountInput?.value;
                    const payoutNotes = document.getElementById('payoutNotes')?.value;

                    if (!payoutMethod) {
                        showNotification('Please select a payout method', 'warning');
                        return;
                    }

                    if (!payoutAmount) {
                        showNotification('Please enter an amount', 'warning');
                        return;
                    }

                    const amount = parseFloat(payoutAmount.replace('₱', '').replace(/,/g, ''));
                    const minAmount = 500;
                    const maxAmount = parseFloat(availableBalance.replace('₱', '').replace(/,/g, ''));

                    if (isNaN(amount)) {
                        showNotification('Please enter a valid amount', 'warning');
                        return;
                    }

                    if (amount < minAmount) {
                        showNotification(`Minimum payout amount is ₱${minAmount.toFixed(2)}`, 'warning');
                        return;
                    }

                    if (amount > maxAmount) {
                        showNotification(`Amount cannot exceed available balance of ${availableBalance}`, 'warning');
                        return;
                    }

                    const originalText = submitPayoutBtn.innerHTML;
                    submitPayoutBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Processing...';
                    submitPayoutBtn.disabled = true;

                    setTimeout(() => {
                        showNotification(`Payout request for ${payoutAmount} submitted successfully!`, 'success');
                        closeModal();

                        document.getElementById('payoutMethod').value = '';
                        document.getElementById('payoutNotes').value = '';
                        if (payoutAmountInput) payoutAmountInput.value = availableBalance;

                        submitPayoutBtn.innerHTML = originalText;
                        submitPayoutBtn.disabled = false;

                    }, 1500);
                });
            }

            if (payoutAmountInput) {
                payoutAmountInput.addEventListener('input', function (e) {
                    let value = this.value.replace(/[^0-9.]/g, '');

                    if (value) {
                        const number = parseFloat(value);
                        if (!isNaN(number)) {
                            this.value = '₱' + number.toLocaleString('en-PH', {
                                minimumFractionDigits: 2,
                                maximumFractionDigits: 2
                            });
                        }
                    }
                });
            }

            const viewAllEarningsBtn = document.getElementById('viewAllEarnings');
            if (viewAllEarningsBtn) {
                viewAllEarningsBtn.addEventListener('click', function () {
                    showNotification('Loading all earnings history...', 'info');
                });
            }

            const recentEarningsRows = document.querySelectorAll('.content-section:last-child .data-row');
            recentEarningsRows.forEach(row => {
                row.addEventListener('click', function () {
                    const locationTitle = this.querySelector('.row-title').textContent;
                    const orderAmount = this.querySelector('.row-amount').textContent;
                    const orderStatus = this.querySelector('.row-badge')?.textContent || 'Completed';

                    showNotification(`Delivery details: ${locationTitle} - ${orderAmount} (${orderStatus})`, 'info');
                });
            });

            const toggleButtons = document.querySelectorAll('.time-toggle-btn');

            toggleButtons.forEach(button => {
                button.addEventListener('click', function () {
                    toggleButtons.forEach(btn => btn.classList.remove('active'));
                    this.classList.add('active');

                    const period = this.textContent.toLowerCase();
                    updateRecentEarnings(period);

                    showNotification(`Showing ${this.textContent} earnings`, 'info');
                });
            });

            function updateRecentEarnings(period) {
                const earningsData = {
                    daily: [
                        { title: "Parklane", subtitle: "Order #PL-45678", time: "Today, 3:45 PM", amount: "+₱42.50", status: "Completed" },
                        { title: "Greensborough", subtitle: "Order #GB-12345", time: "Today, 2:30 PM", amount: "+₱38.75", status: "" },
                        { title: "San Jose Dasma", subtitle: "Order #SJD-78901", time: "Today, 1:15 PM", amount: "+₱55.00", status: "Completed" },
                        { title: "Sunrise Hills", subtitle: "Order #SH-23456", time: "Yesterday, 7:30 PM", amount: "+₱47.25", status: "" },
                        { title: "Burol Main Dasma", subtitle: "Order #BMD-34567", time: "Yesterday, 6:15 PM", amount: "-₱15.00", status: "Cancelled" }
                    ],
                    weekly: [
                        { title: "Parklane", subtitle: "Order #PL-89012", time: "Mon, 4:30 PM", amount: "+₱45.50", status: "Completed" },
                        { title: "Greensborough", subtitle: "Order #GB-56789", time: "Sat, 1:45 PM", amount: "+₱40.25", status: "" },
                        { title: "San Jose Dasma", subtitle: "Order #SJD-12345", time: "Fri, 6:15 PM", amount: "+₱58.00", status: "Completed" },
                        { title: "Sunrise Hills", subtitle: "Order #SH-67890", time: "Thu, 8:30 PM", amount: "+₱49.75", status: "" },
                        { title: "Burol Main Dasma", subtitle: "Order #BMD-23456", time: "Wed, 5:45 PM", amount: "+₱52.50", status: "Completed" }
                    ],
                    monthly: [
                        { title: "Parklane", subtitle: "Monthly Bonus - 50+ deliveries", time: "This month", amount: "+₱500.00", status: "Bonus" },
                        { title: "Greensborough", subtitle: "Order #GB-90123", time: "Feb 25, 2:15 PM", amount: "+₱42.75", status: "Completed" },
                        { title: "San Jose Dasma", subtitle: "Peak Hour Bonus", time: "Monthly incentive", amount: "+₱300.00", status: "Bonus" },
                        { title: "Sunrise Hills", subtitle: "Order #SH-45678", time: "Feb 20, 7:45 PM", amount: "+₱48.50", status: "" },
                        { title: "Burol Main Dasma", subtitle: "Consistency Award", time: "Monthly achievement", amount: "+₱200.00", status: "Award" }
                    ],
                    yearly: [
                        { title: "Parklane", subtitle: "Annual Loyalty - 500+ deliveries", time: "Yearly bonus", amount: "+₱2,500.00", status: "Bonus" },
                        { title: "Greensborough", subtitle: "Top Performer Award", time: "Annual recognition", amount: "+₱1,500.00", status: "Award" },
                        { title: "San Jose Dasma", subtitle: "Safety Excellence Award", time: "Yearly achievement", amount: "+₱1,200.00", status: "Award" },
                        { title: "Sunrise Hills", subtitle: "Referral Program Earnings", time: "Yearly total", amount: "+₱800.00", status: "Bonus" },
                        { title: "Burol Main Dasma", subtitle: "Consistency Excellence", time: "Annual award", amount: "+₱600.00", status: "Award" }
                    ]
                };

                const data = earningsData[period] || earningsData.daily;
                const recentEarningsSection = document.querySelector('.content-section:last-child .data-list');

                if (recentEarningsSection) {
                    recentEarningsSection.innerHTML = '';

                    data.forEach(item => {
                        const row = document.createElement('div');
                        row.className = 'data-row';

                        let badgeHTML = '';
                        if (item.status) {
                            const badgeClass = item.status === 'Cancelled' ? 'badge-cancelled' :
                                item.status === 'Bonus' ? 'badge-active' :
                                    item.status === 'Award' ? 'badge-pending' : 'badge-completed';
                            badgeHTML = `<span class="row-badge ${badgeClass}">${item.status}</span>`;
                        }

                        const isNegative = item.amount.startsWith('-');
                        const amountClass = isNegative ? 'row-amount negative' : 'row-amount';

                        row.innerHTML = `
                            <div class="row-info">
                                <div class="row-title">${item.title}</div>
                                <div class="row-meta">
                                    <span class="row-subtitle">${item.subtitle}</span>
                                    <span class="row-time">${item.time}</span>
                                    ${badgeHTML}
                                </div>
                            </div>
                            <div class="${amountClass}">${item.amount}</div>
                        `;

                        recentEarningsSection.appendChild(row);

                        row.addEventListener('click', function () {
                            showNotification(`Delivery details: ${item.title} - ${item.amount}`, 'info');
                        });
                    });
                }
            }

            function showNotification(message, type) {
                const notification = document.createElement('div');
                notification.className = 'notification';
                notification.style.cssText = `
                    position: fixed;
                    top: 20px;
                    right: 20px;
                    padding: 15px 20px;
                    background: ${type === 'success' ? 'var(--success-green)' :
                        type === 'info' ? 'var(--accent-blue-dark)' :
                            type === 'warning' ? 'var(--warning-orange)' : 'var(--danger-red)'};
                    color: white;
                    border-radius: var(--radius-md);
                    box-shadow: 0 4px 12px rgba(0,0,0,0.15);
                    z-index: 100000;
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
                            type === 'warning' ? 'fa-exclamation-triangle' :
                                'fa-exclamation-circle'}"></i>
                    <span>${message}</span>
                `;

                document.body.appendChild(notification);

                setTimeout(() => {
                    notification.style.animation = 'slideOutRight 0.3s ease';
                    setTimeout(() => {
                        if (notification.parentNode) {
                            document.body.removeChild(notification);
                        }
                    }, 300);
                }, 3000);
            }
        });
    </script>
</asp:Content>