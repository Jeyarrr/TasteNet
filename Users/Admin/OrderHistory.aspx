<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Admin.Master" AutoEventWireup="true" CodeBehind="OrderHistory.aspx.cs" Inherits="TasteNet.Users.Admin.OrderHistory" %>
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

        .order-history-container {
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

        .filter-bar {
            display: flex;
            gap: 15px;
            align-items: center;
            flex-wrap: wrap;
            margin-bottom: 30px;
            animation: fadeIn 0.6s ease-out;
        }

        .filter-select, .filter-input {
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

        .filter-input {
            min-width: 250px;
            cursor: text;
        }

        .filter-select:hover, .filter-input:hover {
            border-color: var(--primary-maroon);
            transform: translateY(-1px);
            box-shadow: var(--card-shadow-hover);
        }

        .filter-input::placeholder {
            color: var(--muted-text);
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
            border-radius: 18px;
            box-shadow: var(--card-shadow);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
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
            box-shadow: 0 12px 30px rgba(107, 13, 30, 0.12);
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

        .orders-container {
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

        .table-container {
            background: white;
            border-radius: var(--radius-lg);
            box-shadow: var(--card-shadow);
            overflow: hidden;
            margin-bottom: 20px;
            animation: fadeIn 0.5s ease-out;
        }

        .table-wrapper {
            overflow-x: auto;
            padding: 0;
        }

        .orders-table {
            width: 100%;
            border-collapse: collapse;
            min-width: 100%;
            font-size: 13px;
        }

        .orders-table thead {
            background: white;
        }

        .orders-table th {
            padding: 16px 10px;
            text-align: center;
            font-size: 11px;
            color: var(--muted-text);
            font-weight: 600;
            border-bottom: 2px solid var(--bg-light);
            letter-spacing: 0.3px;
            text-transform: uppercase;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            background: white;
        }

        .orders-table td {
            padding: 16px 10px;
            border-bottom: 1px solid var(--bg-lighter);
            font-size: 13px;
            vertical-align: middle;
            color: var(--text-dark);
            text-align: center;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            height: 60px;
            position: relative;
            transition: all var(--transition-fast);
        }

        .orders-table tbody tr {
            transition: all var(--transition-base);
            position: relative;
            animation: tableRowFadeIn 0.5s ease-out;
            animation-fill-mode: both;
            border-left: 3px solid transparent;
        }

        .orders-table tbody tr:hover {
            background: linear-gradient(90deg, var(--bg-hover) 0%, white 100%);
            border-left: 3px solid var(--primary-maroon);
            transform: translateX(2px);
            box-shadow: 0 4px 12px rgba(107, 13, 30, 0.08);
        }

        .orders-table tbody tr:hover td {
            border-color: transparent;
        }

        .orders-table tbody tr:hover td::before {
            content: '';
            position: absolute;
            top: 0;
            left: -2px;
            right: -2px;
            bottom: 0;
            background: var(--bg-hover);
            z-index: -1;
            opacity: 0.3;
        }

        .orders-table tbody tr:last-child td {
            border-bottom: none;
        }

        .orders-table th:nth-child(1),
        .orders-table td:nth-child(1) {
            width: 100px;
        }

        .orders-table th:nth-child(2),
        .orders-table td:nth-child(2) {
            width: 180px;
        }

        .orders-table th:nth-child(3),
        .orders-table td:nth-child(3) {
            width: 150px;
        }

        .orders-table th:nth-child(4),
        .orders-table td:nth-child(4) {
            width: 120px;
        }

        .orders-table th:nth-child(5),
        .orders-table td:nth-child(5) {
            width: 100px;
        }

        .orders-table th:nth-child(6),
        .orders-table td:nth-child(6) {
            width: 100px;
            padding-right: 20px;
        }

        .order-id {
            color: var(--primary-maroon);
            font-weight: 700;
            font-size: 12px;
            font-family: 'Courier New', monospace;
            transition: all var(--transition-base);
            position: relative;
            display: inline-block;
        }

        .order-id:hover {
            color: var(--primary-maroon);
            animation: bounce 0.5s ease infinite alternate;
        }

        .order-id:hover::before {
            content: '';
            position: absolute;
            left: 50%;
            transform: translateX(-50%);
            bottom: -5px;
            width: 30px;
            height: 2px;
            background: var(--primary-maroon);
            animation: underlineExpand 0.3s ease forwards;
        }

        .customer-info {
            display: flex;
            flex-direction: column;
            gap: 4px;
            align-items: center;
        }

        .customer-name {
            color: var(--text-dark);
            font-weight: 600;
            font-size: 13px;
            line-height: 1.2;
            position: relative;
            display: inline-block;
            transition: color var(--transition-fast);
        }

        .customer-name:hover {
            color: var(--primary-maroon);
        }

        .customer-name:hover::after {
            content: '';
            position: absolute;
            bottom: -2px;
            left: 0;
            width: 100%;
            height: 1px;
            background: var(--primary-maroon);
            animation: underlineExpand 0.3s ease forwards;
        }

        .customer-contact {
            color: var(--muted-text);
            font-size: 11px;
            font-weight: 500;
            line-height: 1.2;
        }

        .order-total {
            font-weight: 700;
            color: var(--primary-maroon);
            font-size: 15px;
        }

        .order-status {
            padding: 4px 8px;
            border-radius: var(--radius-sm);
            font-size: 10px;
            font-weight: 700;
            display: inline-block;
            text-transform: uppercase;
            letter-spacing: 0.3px;
            min-width: 60px;
            text-align: center;
            line-height: 1.2;
            border: 1px solid transparent;
            transition: all var(--transition-fast);
            position: relative;
            overflow: hidden;
        }

        .order-status:hover {
            transform: translateY(-1px);
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .status-completed {
            background: var(--success-green-light);
            color: var(--success-green);
            border-color: var(--success-green);
        }

        .status-completed:hover {
            background: var(--success-green);
            color: white;
        }

        .status-cancelled {
            background: var(--danger-red-light);
            color: var(--danger-red);
            border-color: var(--danger-red);
        }

        .status-cancelled:hover {
            background: var(--danger-red);
            color: white;
        }

        .action-button {
            width: 32px;
            height: 32px;
            border-radius: var(--radius-sm);
            display: flex;
            align-items: center;
            justify-content: center;
            background: var(--bg-lighter);
            color: var(--muted-text);
            border: none;
            cursor: pointer;
            transition: all var(--transition-base);
            font-size: 11px;
            position: relative;
            text-decoration: none;
            overflow: hidden;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            margin: 0 auto;
        }

        .action-button::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 0;
            height: 0;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.2);
            transform: translate(-50%, -50%);
            transition: width 0.6s, height 0.6s;
        }

        .action-button:active::before {
            width: 200px;
            height: 200px;
        }

        .action-button:hover {
            transform: translateY(-2px) scale(1.1);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
            background: var(--primary-maroon);
            color: white;
        }

        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 6px;
            margin-top: 20px;
            padding: 0 15px;
        }

        .page-btn {
            min-width: 34px;
            height: 34px;
            display: flex;
            align-items: center;
            justify-content: center;
            border: 2px solid var(--border-light);
            border-radius: var(--radius-md);
            background: white;
            color: var(--text-dark);
            font-weight: 600;
            cursor: pointer;
            transition: all var(--transition-base);
            font-size: 13px;
            text-decoration: none;
            position: relative;
            overflow: hidden;
        }

        .page-btn:hover:not(.page-btn--active, .page-btn--disabled) {
            transform: translateY(-2px);
            border-color: var(--primary-maroon);
            box-shadow: 0 4px 12px rgba(107, 13, 30, 0.15);
        }

        .page-btn.active {
            background: var(--primary-maroon);
            color: white;
            border-color: var(--primary-maroon);
            position: relative;
            overflow: hidden;
        }

        .page-btn.active::after {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(
                90deg,
                transparent,
                rgba(255, 255, 255, 0.3),
                transparent
            );
            animation: shimmer 2s infinite;
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
            max-width: 700px;
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
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 15px;
        }

        .detail-item {
            display: flex;
            flex-direction: column;
            gap: 4px;
        }

        .detail-label {
            color: var(--muted-text);
            font-size: 12px;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.3px;
        }

        .detail-value {
            color: var(--text-dark);
            font-weight: 600;
            font-size: 14px;
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

        .modal-btn-danger {
            background: var(--danger-red-light);
            color: var(--danger-red);
            border: 1px solid var(--danger-red);
        }

        .modal-btn-danger:hover {
            background: var(--danger-red);
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

        @keyframes tableRowFadeIn {
            from {
                opacity: 0;
                transform: translateY(10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes bounce {
            from { transform: translateY(0); }
            to { transform: translateY(-3px); }
        }

        @keyframes underlineExpand {
            from { width: 0; }
            to { width: 100%; }
        }

        @keyframes shimmer {
            0% { left: -100%; }
            100% { left: 100%; }
        }

        @media (max-width: 1200px) {
            .stats-summary {
                grid-template-columns: repeat(2, 1fr);
            }
            
            .modal-details {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 992px) {
            .order-history-container {
                padding: 20px;
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
            
            .filter-bar {
                flex-direction: column;
                align-items: stretch;
            }
            
            .filter-select, .filter-input {
                width: 100%;
            }
            
            .orders-table {
                font-size: 12px;
            }
            
            .orders-table th,
            .orders-table td {
                padding: 14px 8px;
                font-size: 11px;
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
            
            .section-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 10px;
            }
            
            .header-title h1 {
                font-size: 24px;
            }
            
            .orders-table {
                display: block;
                overflow-x: auto;
            }
            
            .modal-details {
                gap: 12px;
            }
            
            .detail-item {
                flex-direction: row;
                justify-content: space-between;
                align-items: center;
            }
            
            .modal-actions {
                flex-direction: column;
            }
        }

        @media (max-width: 480px) {
            .order-history-container {
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
            
            .admin-btn {
                padding: 8px 15px;
                font-size: 13px;
            }
            
            .modal-content {
                padding: 15px;
            }
            
            .modal-section {
                padding: 15px;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="modal-overlay" id="orderModal">
        <div class="modal-content">
            <div class="modal-header">
                <h2 class="modal-title" id="modalOrderId">#00123</h2>
                <button type="button" class="close-modal" id="closeModal">
                    <i class="fas fa-times"></i>
                </button>
            </div>
            <div class="modal-body">
                <div class="modal-section">
                    <h3 class="modal-section-title">
                        <i class="fas fa-info-circle"></i>
                        Order Information
                    </h3>
                    <div class="modal-details">
                        <div class="detail-item">
                            <span class="detail-label">Order ID:</span>
                            <span class="detail-value" id="modalOrderIdText">#00123</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">Status:</span>
                            <span class="detail-value" id="modalStatus">Completed</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">Date & Time:</span>
                            <span class="detail-value" id="modalDateTime">Feb 2, 2026 at 14:30</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">Payment Method:</span>
                            <span class="detail-value" id="modalPayment">Credit Card</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">Order Total:</span>
                            <span class="detail-value" style="color: var(--primary-maroon); font-weight: 700;" id="modalTotal">₱350.00</span>
                        </div>
                    </div>
                </div>

                <div class="modal-section">
                    <h3 class="modal-section-title">
                        <i class="fas fa-user"></i>
                        Customer Information
                    </h3>
                    <div class="modal-details">
                        <div class="detail-item">
                            <span class="detail-label">Customer Name:</span>
                            <span class="detail-value" id="modalCustomer">Jayr Casano</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">Contact Number:</span>
                            <span class="detail-value" id="modalContact">0917-123-4567</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">Email:</span>
                            <span class="detail-value" id="modalEmail">jayr.casano@example.com</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">Address:</span>
                            <span class="detail-value" id="modalAddress">123 Main Street, Dasma</span>
                        </div>
                    </div>
                </div>

                <div class="modal-section">
                    <h3 class="modal-section-title">
                        <i class="fas fa-receipt"></i>
                        Order Items
                    </h3>
                    <div id="modalItems"></div>
                </div>

                <div class="modal-actions">
                    <button type="button" class="modal-btn modal-btn-primary" id="modalPrintBtn">
                        <i class="fas fa-print"></i>
                        Print Receipt
                    </button>
                    <button type="button" class="modal-btn modal-btn-secondary" id="modalCloseBtn">
                        <i class="fas fa-times"></i>
                        Close
                    </button>
                </div>
            </div>
        </div>
    </div>

    <div class="order-history-container">
        <div class="page-header-main">
            <div class="header-title">
                <h1>Order History</h1>
                <p>View past orders and analytics</p>
            </div>
            
            <div class="admin-controls">
                <button type="button" class="admin-btn" id="exportReportBtn">
                    <i class="fas fa-download"></i>
                    Export Report
                </button>
            </div>
        </div>

        <div class="stats-summary">
            <div class="summary-card">
                <div class="summary-content">
                    <div class="summary-label">Total Orders</div>
                    <div class="summary-value">8</div>
                </div>
                <div class="summary-icon">
                    <i class="fas fa-shopping-bag"></i>
                </div>
            </div>
            
            <div class="summary-card">
                <div class="summary-content">
                    <div class="summary-label">Completed</div>
                    <div class="summary-value completed">6</div>
                </div>
                <div class="summary-icon" style="background: var(--success-green-light); color: var(--success-green);">
                    <i class="fas fa-check-circle"></i>
                </div>
            </div>
            
            <div class="summary-card">
                <div class="summary-content">
                    <div class="summary-label">Cancelled</div>
                    <div class="summary-value cancelled">2</div>
                </div>
                <div class="summary-icon" style="background: var(--danger-red-light); color: var(--danger-red);">
                    <i class="fas fa-times-circle"></i>
                </div>
            </div>
        </div>

        <div class="filter-bar">
            <input type="text" class="filter-input" id="searchInput" placeholder="Search Order ID, Customer Name, or Phone...">
            <select class="filter-select" id="statusFilter">
                <option value="all">All Status</option>
                <option value="completed">Completed</option>
                <option value="cancelled">Cancelled</option>
            </select>
            
            <select class="filter-select" id="timeFilter">
                <option value="all">All Time</option>
                <option value="today">Today</option>
                <option value="week">This Week</option>
                <option value="month" selected>This Month</option>
                <option value="year">This Year</option>
            </select>
        </div>

        <div class="orders-container">
            <div class="section-header">
                <h2 class="section-title">Recent Orders</h2>
                <span class="results-count" id="resultsCount">Showing 8 orders</span>
            </div>
            
            <div class="table-container">
                <div class="table-wrapper">
                    <table class="orders-table">
                        <thead>
                            <tr>
                                <th>Order ID</th>
                                <th>Customer</th>
                                <th>Date & Time</th>
                                <th>Total</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody id="ordersTableBody"></tbody>
                    </table>
                </div>
            </div>

            <div class="pagination">
                <button type="button" class="page-btn disabled" id="prevPageBtn">
                    <i class="fas fa-chevron-left"></i>
                </button>
                <button type="button" class="page-btn active">1</button>
                <button type="button" class="page-btn">2</button>
                <span style="color: var(--muted-text); padding: 0 8px;">...</span>
                <button type="button" class="page-btn">2</button>
                <button type="button" class="page-btn" id="nextPageBtn">
                    <i class="fas fa-chevron-right"></i>
                </button>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const statusFilter = document.getElementById('statusFilter');
            const timeFilter = document.getElementById('timeFilter');
            const searchInput = document.getElementById('searchInput');
            const exportReportBtn = document.getElementById('exportReportBtn');
            const ordersTableBody = document.getElementById('ordersTableBody');
            const resultsCount = document.getElementById('resultsCount');
            const modal = document.getElementById('orderModal');
            const closeModalBtn = document.getElementById('closeModal');
            const modalCloseBtn = document.getElementById('modalCloseBtn');
            const modalPrintBtn = document.getElementById('modalPrintBtn');
            const modalItems = document.getElementById('modalItems');
            const prevPageBtn = document.getElementById('prevPageBtn');
            const nextPageBtn = document.getElementById('nextPageBtn');
            const pageBtns = document.querySelectorAll('.page-btn:not(#prevPageBtn):not(#nextPageBtn):not(.disabled)');

            const allOrders = [
                {
                    id: '00123',
                    customer: 'Jayr Casano',
                    contact: '0917-123-4567',
                    date: 'Feb 2, 2026',
                    time: '14:30 PM',
                    total: '₱350.00',
                    status: 'completed',
                    payment: 'Credit Card',
                    email: 'jayr.casano@example.com',
                    address: '123 Main Street, Dasma',
                    items: [
                        { name: 'Grilled Chicken', quantity: 2, price: '₱120.00', total: '₱240.00' },
                        { name: 'Garlic Rice', quantity: 2, price: '₱30.00', total: '₱60.00' },
                        { name: 'Iced Tea', quantity: 2, price: '₱25.00', total: '₱50.00' }
                    ]
                },
                {
                    id: '00124',
                    customer: 'George Gonzaga',
                    contact: '0918-987-6543',
                    date: 'Feb 2, 2026',
                    time: '12:15 PM',
                    total: '₱420.00',
                    status: 'completed',
                    payment: 'Cash',
                    email: 'george.gonzaga@example.com',
                    address: '456 Oak Street, Dasma',
                    items: [
                        { name: 'Beef Steak', quantity: 1, price: '₱250.00', total: '₱250.00' },
                        { name: 'Vegetable Salad', quantity: 1, price: '₱120.00', total: '₱120.00' },
                        { name: 'Iced Tea', quantity: 2, price: '₱25.00', total: '₱50.00' }
                    ]
                },
                {
                    id: '00125',
                    customer: 'Zea May Sulit',
                    contact: '0919-555-1234',
                    date: 'Feb 1, 2026',
                    time: '19:45 PM',
                    total: '₱280.00',
                    status: 'cancelled',
                    payment: 'Credit Card',
                    email: 'zeamay.sulit@example.com',
                    address: '789 Pine Street, Dasma',
                    items: [
                        { name: 'Pork Adobo', quantity: 2, price: '₱140.00', total: '₱280.00' }
                    ]
                },
                {
                    id: '00126',
                    customer: 'Lalaine Reyes',
                    contact: '0920-777-8888',
                    date: 'Feb 1, 2026',
                    time: '16:20 PM',
                    total: '₱520.00',
                    status: 'completed',
                    payment: 'Online Payment',
                    email: 'lalaine.reyes@example.com',
                    address: '101 Maple Street, Dasma',
                    items: [
                        { name: 'Seafood Platter', quantity: 1, price: '₱350.00', total: '₱350.00' },
                        { name: 'French Fries', quantity: 2, price: '₱65.00', total: '₱130.00' },
                        { name: 'Soft Drinks', quantity: 2, price: '₱20.00', total: '₱40.00' }
                    ]
                },
                {
                    id: '00127',
                    customer: 'Bryle Andre Magallano',
                    contact: '0916-444-5555',
                    date: 'Jan 31, 2026',
                    time: '11:30 AM',
                    total: '₱195.00',
                    status: 'completed',
                    payment: 'Cash',
                    email: 'bryle.magallano@example.com',
                    address: '202 Elm Street, Dasma',
                    items: [
                        { name: 'Chicken Sandwich', quantity: 1, price: '₱120.00', total: '₱120.00' },
                        { name: 'Fries', quantity: 1, price: '₱75.00', total: '₱75.00' }
                    ]
                },
                {
                    id: '00128',
                    customer: 'Jayr Casano',
                    contact: '0915-666-7777',
                    date: 'Jan 30, 2026',
                    time: '18:45 PM',
                    total: '₱890.00',
                    status: 'cancelled',
                    payment: 'Credit Card',
                    email: 'jayr.casano2@example.com',
                    address: '303 Cedar Street, Dasma',
                    items: [
                        { name: 'Family Platter', quantity: 1, price: '₱750.00', total: '₱750.00' },
                        { name: 'Garlic Bread', quantity: 2, price: '₱70.00', total: '₱140.00' }
                    ]
                },
                {
                    id: '00129',
                    customer: 'George Gonzaga',
                    contact: '0914-888-9999',
                    date: 'Jan 29, 2026',
                    time: '13:20 PM',
                    total: '₱310.00',
                    status: 'completed',
                    payment: 'Online Payment',
                    email: 'george.gonzaga2@example.com',
                    address: '404 Birch Street, Dasma',
                    items: [
                        { name: 'Spaghetti', quantity: 1, price: '₱180.00', total: '₱180.00' },
                        { name: 'Caesar Salad', quantity: 1, price: '₱130.00', total: '₱130.00' }
                    ]
                },
                {
                    id: '00130',
                    customer: 'Zea May Sulit',
                    contact: '0913-111-2222',
                    date: 'Jan 28, 2026',
                    time: '20:15 PM',
                    total: '₱550.00',
                    status: 'completed',
                    payment: 'Cash',
                    email: 'zeamay.sulit2@example.com',
                    address: '505 Walnut Street, Dasma',
                    items: [
                        { name: 'Steak Dinner', quantity: 1, price: '₱450.00', total: '₱450.00' },
                        { name: 'Red Wine', quantity: 1, price: '₱100.00', total: '₱100.00' }
                    ]
                }
            ];

            let filteredOrders = [...allOrders];
            let currentPage = 1;
            const ordersPerPage = 4;

            function initializeTable() {
                renderTable();
                updateResultsCount();
            }

            function renderTable() {
                ordersTableBody.innerHTML = '';

                const startIndex = (currentPage - 1) * ordersPerPage;
                const endIndex = startIndex + ordersPerPage;
                const pageOrders = filteredOrders.slice(startIndex, endIndex);

                pageOrders.forEach(order => {
                    const row = document.createElement('tr');
                    row.dataset.orderId = order.id;

                    const statusClass = order.status === 'completed' ? 'status-completed' : 'status-cancelled';
                    const statusText = order.status === 'completed' ? 'COMPLETED' : 'CANCELLED';

                    row.innerHTML = `
                        <td><span class="order-id">#${order.id}</span></td>
                        <td>
                            <div class="customer-info">
                                <span class="customer-name">${order.customer}</span>
                                <span class="customer-contact">${order.contact}</span>
                            </div>
                        </td>
                        <td>${order.date}<br><small style="color: var(--muted-text);">${order.time}</small></td>
                        <td class="order-total">${order.total}</td>
                        <td><span class="order-status ${statusClass}">${statusText}</span></td>
                        <td>
                            <button type="button" class="action-button" title="View Details">
                                <i class="fas fa-eye"></i>
                            </button>
                        </td>
                    `;

                    ordersTableBody.appendChild(row);
                });

                updatePagination();
            }

            function updateResultsCount() {
                resultsCount.textContent = `Showing ${filteredOrders.length} of ${allOrders.length} orders`;
            }

            function updatePagination() {
                const totalPages = Math.ceil(filteredOrders.length / ordersPerPage);

                pageBtns.forEach((btn, index) => {
                    if (index === currentPage - 1) {
                        btn.classList.add('active');
                    } else {
                        btn.classList.remove('active');
                    }

                    if (btn.textContent !== '...') {
                        const pageNum = index + 1;
                        if (pageNum <= totalPages) {
                            btn.textContent = pageNum;
                            btn.style.display = 'flex';
                        } else {
                            btn.style.display = 'none';
                        }
                    }
                });

                prevPageBtn.disabled = currentPage === 1;
                prevPageBtn.classList.toggle('disabled', currentPage === 1);

                nextPageBtn.disabled = currentPage === totalPages;
                nextPageBtn.classList.toggle('disabled', currentPage === totalPages);
            }

            function filterOrders() {
                const status = statusFilter.value;
                const time = timeFilter.value;
                const search = searchInput.value.toLowerCase();

                filteredOrders = allOrders.filter(order => {
                    if (status !== 'all' && order.status !== status) {
                        return false;
                    }

                    if (time !== 'all') {
                        if (time === 'today') {
                            return order.date === 'Feb 2, 2026';
                        } else if (time === 'week') {
                            return order.date >= 'Jan 29, 2026';
                        } else if (time === 'month') {
                            return order.date >= 'Jan 28, 2026';
                        } else if (time === 'year') {
                            return true;
                        }
                    }

                    if (search) {
                        const searchLower = search.toLowerCase();
                        return order.id.includes(search) ||
                            order.customer.toLowerCase().includes(searchLower) ||
                            order.contact.includes(search);
                    }

                    return true;
                });

                currentPage = 1;
                renderTable();
                updateResultsCount();
            }

            function openModal(orderId) {
                const order = allOrders.find(o => o.id === orderId);
                if (!order) return;

                document.getElementById('modalOrderId').textContent = '#' + order.id;
                document.getElementById('modalOrderIdText').textContent = '#' + order.id;
                document.getElementById('modalStatus').textContent = order.status === 'completed' ? 'COMPLETED' : 'CANCELLED';
                document.getElementById('modalDateTime').textContent = `${order.date} at ${order.time}`;
                document.getElementById('modalPayment').textContent = order.payment;
                document.getElementById('modalCustomer').textContent = order.customer;
                document.getElementById('modalContact').textContent = order.contact;
                document.getElementById('modalEmail').textContent = order.email;
                document.getElementById('modalAddress').textContent = order.address;
                document.getElementById('modalTotal').textContent = order.total;

                const statusElement = document.getElementById('modalStatus');
                if (order.status === 'completed') {
                    statusElement.style.color = 'var(--success-green)';
                    statusElement.style.fontWeight = '700';
                } else {
                    statusElement.style.color = 'var(--danger-red)';
                    statusElement.style.fontWeight = '700';
                }

                const subtotal = order.items.reduce((sum, item) => {
                    const price = parseFloat(item.total.replace('₱', '').replace(',', ''));
                    return sum + price;
                }, 0);

                modalItems.innerHTML = `
                    <div style="margin-bottom: 20px;">
                        <div style="display: grid; grid-template-columns: 2fr 1fr 1fr 1fr; gap: 10px; margin-bottom: 10px; padding-bottom: 10px; border-bottom: 1px solid var(--border-light); font-weight: 600; color: var(--muted-text); font-size: 12px; text-transform: uppercase;">
                            <div>Item</div>
                            <div>Quantity</div>
                            <div>Price</div>
                            <div>Total</div>
                        </div>
                        ${order.items.map(item => `
                            <div style="display: grid; grid-template-columns: 2fr 1fr 1fr 1fr; gap: 10px; padding: 8px 0; border-bottom: 1px dashed var(--border-light);">
                                <div style="font-weight: 500;">${item.name}</div>
                                <div>${item.quantity}</div>
                                <div>${item.price}</div>
                                <div style="font-weight: 600; color: var(--primary-maroon);">${item.total}</div>
                            </div>
                        `).join('')}
                        <div style="display: grid; grid-template-columns: 3fr 1fr; gap: 10px; padding: 15px 0; margin-top: 10px; border-top: 2px solid var(--border-light);">
                            <div style="font-weight: 700; color: var(--text-dark);">Subtotal:</div>
                            <div style="font-weight: 700; color: var(--primary-maroon);">₱${subtotal.toFixed(2)}</div>
                        </div>
                        <div style="display: grid; grid-template-columns: 3fr 1fr; gap: 10px; padding: 5px 0;">
                            <div style="font-weight: 700; color: var(--text-dark);">Total Amount:</div>
                            <div style="font-weight: 700; color: var(--primary-maroon); font-size: 18px;">${order.total}</div>
                        </div>
                    </div>
                `;

                modal.classList.add('active');
                document.body.style.overflow = 'hidden';
            }

            function closeModal() {
                modal.classList.remove('active');
                document.body.style.overflow = 'auto';
            }

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
                    notification.style.animation = 'slideOutRight 0.3s ease';
                    setTimeout(() => {
                        document.body.removeChild(notification);
                    }, 300);
                }, 3000);
            }

            function exportReport(e) {
                e.preventDefault();

                showNotification('Exporting order history report...', 'info');

                setTimeout(() => {
                    showNotification('Report exported successfully!', 'success');

                    let csv = 'Order ID,Customer Name,Contact,Date,Time,Total,Status\n';
                    allOrders.forEach(order => {
                        csv += `${order.id},${order.customer},${order.contact},${order.date},${order.time},${order.total},${order.status}\n`;
                    });

                    const blob = new Blob([csv], { type: 'text/csv' });
                    const url = window.URL.createObjectURL(blob);
                    const a = document.createElement('a');
                    a.href = url;
                    a.download = `order_history_${new Date().toISOString().split('T')[0]}.csv`;
                    document.body.appendChild(a);
                    a.click();
                    document.body.removeChild(a);
                    window.URL.revokeObjectURL(url);
                }, 1500);
            }

            function printReceipt(e) {
                e.preventDefault();

                const orderId = document.getElementById('modalOrderId').textContent;
                showNotification(`Printing receipt for ${orderId}`, 'info');

                const printContent = document.querySelector('.modal-content').innerHTML;
                const originalContent = document.body.innerHTML;
                document.body.innerHTML = printContent;
                window.print();
                document.body.innerHTML = originalContent;
                location.reload();
            }

            statusFilter.addEventListener('change', filterOrders);
            timeFilter.addEventListener('change', filterOrders);
            searchInput.addEventListener('input', filterOrders);

            exportReportBtn.addEventListener('click', function (e) {
                e.preventDefault();
                exportReport(e);
            });

            ordersTableBody.addEventListener('click', function (e) {
                e.preventDefault();
                if (e.target.closest('.action-button')) {
                    const row = e.target.closest('tr');
                    const orderId = row.dataset.orderId;
                    openModal(orderId);
                }
            });

            prevPageBtn.addEventListener('click', function (e) {
                e.preventDefault();
                if (currentPage > 1) {
                    currentPage--;
                    renderTable();
                }
            });

            nextPageBtn.addEventListener('click', function (e) {
                e.preventDefault();
                const totalPages = Math.ceil(filteredOrders.length / ordersPerPage);
                if (currentPage < totalPages) {
                    currentPage++;
                    renderTable();
                }
            });

            pageBtns.forEach(btn => {
                btn.addEventListener('click', function (e) {
                    e.preventDefault();
                    if (this.textContent !== '...') {
                        currentPage = parseInt(this.textContent);
                        renderTable();
                    }
                });
            });

            closeModalBtn.addEventListener('click', closeModal);
            modalCloseBtn.addEventListener('click', closeModal);

            modalPrintBtn.addEventListener('click', function (e) {
                e.preventDefault();
                printReceipt(e);
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

            initializeTable();
        });
    </script>
</asp:Content>