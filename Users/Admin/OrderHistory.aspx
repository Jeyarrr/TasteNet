<%@ Page Title="Order History | TasteNet" Language="C#" MasterPageFile="~/MasterPages/Admin.Master" AutoEventWireup="true" CodeBehind="OrderHistory.aspx.cs" Inherits="TasteNet.Users.Admin.OrderHistory" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        :root {
            --primary-maroon: #6b0d1e;
            --primary-maroon-dark: #5a0b19;
            --soft-cream: #fffaf3;
            --text-dark: #2c1810;
            --muted-text: #6b4c4c;
            --success-green: #2d9d78;
            --success-green-light: #e6f4f1;
            --warning-orange: #d97706;
            --warning-orange-light: #fff3e6;
            --danger-red: #b91c1c;
            --danger-red-light: #fee2e2;
            --info-blue: #3b82f6;
            --info-blue-light: #eff6ff;
            --border-light: #e2cfcf;
            --border-hover: #d0b6b6;
            --bg-hover: #fefaf5;
            --bg-lighter: #f9f4ee;
            --bg-light: #f3ebe0;
            --card-shadow: 0 10px 30px rgba(107, 13, 30, 0.08);
            --card-shadow-hover: 0 15px 40px rgba(107, 13, 30, 0.12);
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
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body, form, html {
            background-color: var(--soft-cream) !important;
            font-family: 'Poppins', sans-serif;
            color: var(--text-dark);
            min-height: 100vh;
        }

        .order-history-container {
            padding: 25px 35px;
            max-width: 1600px;
            margin: 0 auto;
            min-height: 100vh;
            transition: filter 0.3s ease;
        }

        .order-history-container.blur-background {
            filter: blur(4px);
            pointer-events: none;
            user-select: none;
        }

        .page-header-main {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            flex-wrap: wrap;
            gap: 15px;
            padding-bottom: 20px;
            border-bottom: 2px solid var(--border-light);
        }

        .header-title h1 {
            color: var(--text-dark);
            font-weight: 700;
            font-size: 28px;
            letter-spacing: -0.5px;
            margin: 0;
        }

        .header-title p {
            color: var(--muted-text);
            margin-top: 6px;
            font-size: 14px;
        }

        .admin-btn {
            padding: 10px 20px;
            border-radius: var(--radius-md);
            border: none;
            background: var(--primary-maroon);
            color: white;
            font-weight: 600;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: all var(--transition-base);
            font-family: 'Poppins', sans-serif;
            text-decoration: none;
            position: relative;
            overflow: hidden;
            font-size: 13px;
        }

        .admin-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.7s;
            z-index: -1;
        }

        .admin-btn:hover::before {
            left: 100%;
        }

        .admin-btn:hover {
            background: var(--primary-maroon-dark);
            transform: translateY(-3px);
            box-shadow: 0 6px 18px rgba(107, 13, 30, 0.3);
        }

        .admin-btn.reset-btn {
            background: var(--muted-text);
        }

        .admin-btn.reset-btn:hover {
            background: var(--text-dark);
        }

        .stat-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: white;
            padding: 20px;
            border-radius: 18px;
            box-shadow: var(--card-shadow);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--card-shadow-hover);
        }

        .stat-card__header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 10px;
        }

        .stat-card__label {
            font-size: 12px;
            font-weight: 500;
            color: var(--muted-text);
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .stat-card__icon {
            width: 36px;
            height: 36px;
            border-radius: var(--radius-md);
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all var(--transition-base);
            transform-origin: center;
        }

        .stat-card:hover .stat-card__icon {
            transform: scale(1.1) rotate(5deg);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
        }

        .stat-card__icon--total { background: var(--warning-orange-light); color: var(--warning-orange); }
        .stat-card__icon--completed { background: var(--success-green-light); color: var(--success-green); }
        .stat-card__icon--progress { background: var(--info-blue-light); color: var(--info-blue); }
        .stat-card__icon--revenue { background: #e8f5e9; color: #2e7d32; }

        .stat-card__value {
            font-size: 28px;
            font-weight: 700;
            color: var(--primary-maroon);
            margin: 6px 0;
            line-height: 1;
        }

        .stat-card__trend {
            font-size: 12px;
            font-weight: 500;
            color: var(--muted-text);
        }

        .filter-section {
            margin-bottom: 20px;
        }

        .filter-row {
            display: flex;
            gap: 10px;
            align-items: center;
            flex-wrap: wrap;
        }

        .search-box {
            position: relative;
            flex: 0 0 auto;
            min-width: 280px;
        }

        .search-box__icon {
            position: absolute;
            left: 12px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--muted-text);
            font-size: 14px;
            z-index: 2;
            transition: all var(--transition-fast);
        }

        .search-box.loading .search-box__icon {
            animation: spin 1s linear infinite;
        }

        .search-box__input {
            width: 100%;
            padding: 8px 15px 8px 40px;
            border: 2px solid var(--border-light);
            border-radius: var(--radius-md);
            font-family: 'Poppins', sans-serif;
            font-size: 13px;
            font-weight: 500;
            background: white;
            color: var(--text-dark);
            transition: all var(--transition-base);
            outline: none;
            height: 42px;
            box-sizing: border-box;
        }

        .search-box__input:hover {
            border-color: var(--border-hover);
            box-shadow: 0 4px 12px rgba(107, 13, 30, 0.08);
        }

        .search-box__input:focus {
            transform: translateY(-1px);
            border-color: var(--primary-maroon);
            box-shadow: 0 6px 16px rgba(107, 13, 30, 0.12), 0 0 0 3px rgba(107, 13, 30, 0.1);
        }

        .search-box__input::placeholder {
            color: #a08b8b;
            opacity: 0.7;
        }

        .filter-dropdown {
            padding: 8px 35px 8px 15px;
            border: 2px solid var(--border-light);
            border-radius: var(--radius-md);
            background: white;
            color: var(--text-dark);
            font-size: 13px;
            font-family: 'Poppins', sans-serif;
            cursor: pointer;
            min-width: 120px;
            outline: none;
            font-weight: 500;
            transition: all var(--transition-base);
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='14' height='14' fill='%236b4c4c' viewBox='0 0 16 16'%3E%3Cpath d='M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 12px center;
            background-size: 12px;
            height: 42px;
            box-sizing: border-box;
        }

        .filter-dropdown:hover {
            border-color: var(--primary-maroon);
            box-shadow: 0 4px 12px rgba(107, 13, 30, 0.1);
            transform: translateY(-1px);
        }

        .filter-dropdown:focus {
            border-color: var(--primary-maroon);
            box-shadow: 0 0 0 3px rgba(107, 13, 30, 0.15);
        }

        .orders-container {
            background: white;
            border-radius: var(--radius-lg);
            box-shadow: var(--card-shadow);
            overflow: hidden;
            margin-bottom: 20px;
            animation: fadeIn 0.5s ease-out;
        }

        .table-wrapper {
            overflow-x: auto;
        }

        .orders-table {
            width: 100%;
            border-collapse: collapse;
            min-width: 1000px;
            font-size: 13px;
        }

        .orders-table th {
            padding: 16px 12px;
            text-align: center;
            font-size: 11px;
            color: var(--muted-text);
            font-weight: 600;
            border-bottom: 2px solid var(--bg-light);
            letter-spacing: 0.5px;
            text-transform: uppercase;
            background: white;
        }

        .orders-table td {
            padding: 16px 12px;
            border-bottom: 1px solid var(--bg-lighter);
            vertical-align: middle;
            text-align: center;
            color: var(--text-dark);
            transition: all var(--transition-fast);
        }

        .order-row {
            cursor: pointer;
            transition: all var(--transition-base);
            border-left: 3px solid transparent;
        }

        .order-row:hover {
            background: linear-gradient(90deg, var(--bg-hover) 0%, white 100%);
            border-left: 3px solid var(--primary-maroon);
            transform: translateX(2px);
            box-shadow: 0 4px 12px rgba(107, 13, 30, 0.08);
        }

        .expand-icon {
            display: inline-block;
            transition: transform 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            font-size: 12px;
            color: var(--primary-maroon);
        }

        .expand-icon.expanded {
            transform: rotate(90deg);
        }

        .order-id {
            color: var(--primary-maroon);
            font-weight: 700;
            font-size: 13px;
            transition: all var(--transition-base);
            position: relative;
            display: inline-block;
        }

        .order-id:hover {
            animation: bounce 0.5s ease infinite alternate;
        }

        .customer-name {
            font-weight: 600;
            color: var(--text-dark);
            transition: color var(--transition-fast);
            font-size: 13px;
        }

        .order-row:hover .customer-name {
            color: var(--primary-maroon);
        }

        .order-total {
            font-weight: 700;
            color: var(--primary-maroon);
        }

        .order-status {
            display: inline-block;
            padding: 5px 12px;
            border-radius: var(--radius-sm);
            font-size: 10px;
            font-weight: 700;
            text-transform: uppercase;
            min-width: 95px;
            text-align: center;
            border: 1px solid transparent;
            transition: all var(--transition-fast);
        }

        .order-status:hover {
            transform: translateY(-1px);
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .status-open { background: var(--warning-orange-light); color: var(--warning-orange); border-color: var(--warning-orange); }
        .status-inprogress { background: var(--info-blue-light); color: var(--info-blue); border-color: var(--info-blue); }
        .status-completed { background: var(--success-green-light); color: var(--success-green); border-color: var(--success-green); }
        .status-cancelled { background: var(--danger-red-light); color: var(--danger-red); border-color: var(--danger-red); }

        .priority-rush {
            display: inline-block;
            padding: 3px 10px;
            border-radius: 12px;
            font-size: 10px;
            font-weight: 600;
            background: var(--danger-red-light);
            color: var(--danger-red);
            animation: pulse 1.5s ease infinite;
        }

        .priority-normal {
            color: var(--muted-text);
            font-size: 10px;
            font-weight: 500;
        }

        @keyframes pulse {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.7; }
        }

        .action-buttons {
            display: flex;
            gap: 8px;
            justify-content: center;
        }

        .action-button {
            width: 32px;
            height: 32px;
            border-radius: var(--radius-sm);
            display: inline-flex;
            align-items: center;
            justify-content: center;
            background: var(--bg-lighter);
            border: none;
            cursor: pointer;
            transition: all var(--transition-base);
            font-size: 13px;
            position: relative;
            overflow: hidden;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            color: var(--text-dark);
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

        .action-button.view { color: var(--primary-maroon); }
        .action-button.view:hover { background: var(--primary-maroon); color: white; transform: translateY(-3px) scale(1.1); box-shadow: 0 4px 12px rgba(107, 13, 30, 0.3); }
        
        .action-button.update { color: var(--info-blue); }
        .action-button.update:hover { background: var(--info-blue); color: white; transform: translateY(-3px) scale(1.1); box-shadow: 0 4px 12px rgba(59, 130, 246, 0.3); }

        .items-row {
            display: none;
            background: var(--bg-hover);
            animation: fadeIn 0.3s ease-out;
        }

        .items-row.show {
            display: table-row;
        }

        .items-container {
            padding: 20px;
        }

        .items-header h4 {
            color: var(--primary-maroon);
            font-size: 14px;
            font-weight: 600;
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 2px solid var(--border-light);
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .items-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 12px;
        }

        .items-table th {
            padding: 10px;
            text-align: left;
            background: white;
            border-bottom: 2px solid var(--border-light);
            color: var(--muted-text);
            font-weight: 600;
        }

        .items-table td {
            padding: 10px;
            border-bottom: 1px solid var(--border-light);
            color: var(--text-dark);
        }

        .modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0, 0, 0, 0.7);
            display: none;
            align-items: center;
            justify-content: center;
            z-index: 10000;
            backdrop-filter: blur(8px);
        }

        .customer-modal {
            background: white;
            border-radius: var(--radius-xl);
            width: 600px;
            max-width: 90%;
            max-height: 85vh;
            overflow-y: auto;
            box-shadow: 0 25px 50px rgba(0, 0, 0, 0.3);
            animation: slideUp 0.4s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .modal-header {
            padding: 18px 22px;
            background: linear-gradient(135deg, var(--primary-maroon), var(--primary-maroon-dark));
            color: white;
            border-radius: var(--radius-xl) var(--radius-xl) 0 0;
            position: sticky;
            top: 0;
            z-index: 1;
        }

        .modal-header h3 {
            margin: 0;
            font-size: 18px;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .close-modal {
            position: absolute;
            top: 16px;
            right: 20px;
            background: rgba(255, 255, 255, 0.2);
            border: none;
            width: 32px;
            height: 32px;
            border-radius: 50%;
            color: white;
            cursor: pointer;
            transition: all var(--transition-base);
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .close-modal:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: rotate(90deg);
        }

        .modal-body {
            padding: 20px 22px;
        }

        .status-order-info {
            background: var(--bg-lighter);
            padding: 12px 15px;
            border-radius: var(--radius-md);
            margin-bottom: 18px;
            text-align: center;
        }

        .status-order-info p {
            color: var(--muted-text);
            margin-bottom: 5px;
            font-size: 11px;
        }

        .status-order-info strong {
            font-size: 16px;
            color: var(--primary-maroon);
        }

        .status-options {
            display: flex;
            flex-direction: column;
            gap: 10px;
            margin: 18px 0;
        }

        .status-option {
            display: flex;
            align-items: center;
            padding: 12px 15px;
            background: var(--bg-lighter);
            border: 1.5px solid var(--border-light);
            border-radius: var(--radius-md);
            cursor: pointer;
            transition: all var(--transition-base);
        }

        .status-option:hover {
            transform: translateX(4px);
            border-color: var(--primary-maroon);
            background: white;
            box-shadow: var(--card-shadow);
        }

        .status-option.selected {
            border-color: var(--primary-maroon);
            background: var(--soft-cream);
            box-shadow: 0 2px 8px rgba(107, 13, 30, 0.1);
        }

        .status-indicator {
            width: 36px;
            height: 36px;
            border-radius: var(--radius-sm);
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 14px;
            font-size: 16px;
            flex-shrink: 0;
        }

        .status-indicator.open { background: var(--warning-orange-light); color: var(--warning-orange); }
        .status-indicator.inprogress { background: var(--info-blue-light); color: var(--info-blue); }
        .status-indicator.completed { background: var(--success-green-light); color: var(--success-green); }
        .status-indicator.cancelled { background: var(--danger-red-light); color: var(--danger-red); }

        .status-info h4 {
            margin: 0 0 4px 0;
            font-size: 13px;
            font-weight: 600;
            color: var(--text-dark);
        }

        .status-info p {
            margin: 0;
            font-size: 10px;
            color: var(--muted-text);
        }

        .modal-footer {
            padding: 14px 22px;
            border-top: 1px solid var(--border-light);
            display: flex;
            justify-content: flex-end;
            gap: 12px;
            background: white;
            border-radius: 0 0 var(--radius-xl) var(--radius-xl);
        }

        .btn {
            padding: 8px 20px;
            border-radius: var(--radius-md);
            font-weight: 600;
            font-size: 12px;
            cursor: pointer;
            transition: all var(--transition-base);
            display: inline-flex;
            align-items: center;
            gap: 8px;
            border: none;
            font-family: 'Poppins', sans-serif;
        }

        .btn--primary {
            background: var(--primary-maroon);
            color: white;
        }

        .btn--primary:hover {
            background: var(--primary-maroon-dark);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(107, 13, 30, 0.3);
        }

        .btn--secondary {
            background: var(--muted-text);
            color: white;
        }

        .btn--secondary:hover {
            background: var(--text-dark);
            transform: translateY(-2px);
        }

        .detail-section {
            margin-bottom: 18px;
        }

        .detail-section h4 {
            color: var(--primary-maroon);
            font-size: 14px;
            font-weight: 600;
            margin-bottom: 12px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .detail-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 12px;
        }

        .detail-item {
            background: var(--bg-lighter);
            padding: 10px 12px;
            border-radius: var(--radius-sm);
        }

        .detail-item strong {
            display: block;
            font-size: 10px;
            color: var(--muted-text);
            margin-bottom: 5px;
            text-transform: uppercase;
            letter-spacing: 0.3px;
        }

        .detail-item span {
            font-size: 13px;
            font-weight: 600;
            color: var(--text-dark);
        }

        .grand-total {
            text-align: right;
            padding-top: 12px;
            margin-top: 10px;
            border-top: 2px solid var(--border-light);
            font-size: 16px;
            font-weight: 700;
            color: var(--primary-maroon);
        }

        .no-results {
            text-align: center;
            padding: 60px 20px;
            color: var(--muted-text);
        }

        .pagination {
            display: flex;
            justify-content: center;
            gap: 8px;
            margin-top: 20px;
            padding-bottom: 20px;
        }

        .page-link {
            min-width: 36px;
            height: 36px;
            display: inline-flex;
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
        }

        .page-link:hover:not(.active) {
            transform: translateY(-2px);
            border-color: var(--primary-maroon);
            box-shadow: 0 4px 12px rgba(107, 13, 30, 0.15);
        }

        .page-link.active {
            background: var(--primary-maroon);
            color: white;
            border-color: var(--primary-maroon);
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes slideUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes bounce {
            from { transform: translateY(0); }
            to { transform: translateY(-3px); }
        }

        @keyframes spin {
            from { transform: translateY(-50%) rotate(0deg); }
            to { transform: translateY(-50%) rotate(360deg); }
        }

        @keyframes fadeOut {
            from { opacity: 1; }
            to { opacity: 0; }
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
            .stat-grid { grid-template-columns: repeat(2, 1fr); }
            .order-history-container { padding: 15px 20px; }
        }

        @media (max-width: 768px) {
            .stat-grid { grid-template-columns: 1fr; }
            .filter-row { flex-direction: column; }
            .search-box { min-width: 100%; width: 100%; }
            .filter-dropdown { width: 100%; }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Order Details Modal -->
    <div id="orderModal" class="modal-overlay">
        <div class="customer-modal">
            <div class="modal-header">
                <h3><i class="fas fa-receipt"></i> Order Details</h3>
                <button type="button" class="close-modal" onclick="closeModal('orderModal')"><i class="fas fa-times"></i></button>
            </div>
            <div class="modal-body" id="modalBody">
                <div style="text-align: center; padding: 40px;">
                    <i class="fas fa-spinner fa-spin" style="font-size: 40px; color: var(--primary-maroon);"></i>
                    <p style="margin-top: 15px; color: var(--text-dark);">Loading order details...</p>
                </div>
            </div>
        </div>
    </div>

    <!-- Status Update Modal -->
    <div id="statusModal" class="modal-overlay">
        <div class="customer-modal">
            <div class="modal-header">
                <h3><i class="fas fa-edit"></i> Update Order Status</h3>
                <button type="button" class="close-modal" onclick="closeModal('statusModal')"><i class="fas fa-times"></i></button>
            </div>
            <div class="modal-body">
                <div class="status-order-info">
                    <p><i class="fas fa-receipt"></i> Order Number</p>
                    <strong id="statusOrderNumber">ORD-000000</strong>
                </div>
                <div class="status-options" id="statusOptions">
                    <div class="status-option" data-status="Open" onclick="selectStatus(this, 'Open')">
                        <div class="status-indicator open"><i class="fas fa-clock"></i></div>
                        <div class="status-info"><h4>Open</h4><p>Order awaiting processing</p></div>
                    </div>
                    <div class="status-option" data-status="In Progress" onclick="selectStatus(this, 'In Progress')">
                        <div class="status-indicator inprogress"><i class="fas fa-spinner fa-pulse"></i></div>
                        <div class="status-info"><h4>In Progress</h4><p>Being prepared or cooked</p></div>
                    </div>
                    <div class="status-option" data-status="Completed" onclick="selectStatus(this, 'Completed')">
                        <div class="status-indicator completed"><i class="fas fa-check-circle"></i></div>
                        <div class="status-info"><h4>Completed</h4><p>Fulfilled and delivered</p></div>
                    </div>
                    <div class="status-option" data-status="Cancelled" onclick="selectStatus(this, 'Cancelled')">
                        <div class="status-indicator cancelled"><i class="fas fa-times-circle"></i></div>
                        <div class="status-info"><h4>Cancelled</h4><p>Order has been cancelled</p></div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn--secondary" onclick="closeModal('statusModal')"><i class="fas fa-times"></i> Cancel</button>
                <button type="button" class="btn btn--primary" id="confirmStatusUpdateBtn" onclick="confirmStatusUpdate()"><i class="fas fa-save"></i> Update</button>
            </div>
        </div>
    </div>

    <div class="order-history-container" id="orderHistoryContainer">
        <div class="page-header-main">
            <div class="header-title">
                <h1>Order History</h1>
                <p>View and manage all customer orders</p>
            </div>
            <div class="header-actions">
                <asp:LinkButton ID="btnExport" runat="server" CssClass="admin-btn" OnClick="btnExport_Click">
                    <i class="fas fa-download"></i> Export Report
                </asp:LinkButton>
                <asp:LinkButton ID="btnReset" runat="server" CssClass="admin-btn reset-btn" OnClick="btnReset_Click">
                    <i class="fas fa-undo"></i> Reset Filters
                </asp:LinkButton>
            </div>
        </div>

        <div class="stat-grid">
            <div class="stat-card">
                <div class="stat-card__header">
                    <span class="stat-card__label">Total Orders</span>
                    <div class="stat-card__icon stat-card__icon--total"><i class="fas fa-shopping-bag"></i></div>
                </div>
                <div class="stat-card__value"><asp:Label ID="lblTotalOrders" runat="server" Text="0"></asp:Label></div>
                <div class="stat-card__trend">All customer orders</div>
            </div>
            <div class="stat-card">
                <div class="stat-card__header">
                    <span class="stat-card__label">Completed</span>
                    <div class="stat-card__icon stat-card__icon--completed"><i class="fas fa-check-circle"></i></div>
                </div>
                <div class="stat-card__value"><asp:Label ID="lblCompletedOrders" runat="server" Text="0"></asp:Label></div>
                <div class="stat-card__trend">Successfully delivered</div>
            </div>
            <div class="stat-card">
                <div class="stat-card__header">
                    <span class="stat-card__label">In Progress</span>
                    <div class="stat-card__icon stat-card__icon--progress"><i class="fas fa-spinner"></i></div>
                </div>
                <div class="stat-card__value"><asp:Label ID="lblInProgressOrders" runat="server" Text="0"></asp:Label></div>
                <div class="stat-card__trend">Currently processing</div>
            </div>
            <div class="stat-card">
                <div class="stat-card__header">
                    <span class="stat-card__label">Total Revenue</span>
                    <div class="stat-card__icon stat-card__icon--revenue"><i class="fas fa-peso-sign"></i></div>
                </div>
                <div class="stat-card__value"><asp:Label ID="lblTotalRevenue" runat="server" Text="₱0"></asp:Label></div>
                <div class="stat-card__trend">From all orders</div>
            </div>
        </div>

        <div class="filter-section">
            <div class="filter-row">
                <div class="search-box" id="searchBox">
                    <div class="search-box__icon"><i class="fas fa-search"></i></div>
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="search-box__input" placeholder="Search by order #, customer, email, or menu item..."></asp:TextBox>
                </div>
                <asp:DropDownList ID="ddlStatus" runat="server" CssClass="filter-dropdown">
                    <asp:ListItem Text="All Status" Value=""></asp:ListItem>
                    <asp:ListItem Text="Open" Value="Open"></asp:ListItem>
                    <asp:ListItem Text="In Progress" Value="In Progress"></asp:ListItem>
                    <asp:ListItem Text="Completed" Value="Completed"></asp:ListItem>
                    <asp:ListItem Text="Cancelled" Value="Cancelled"></asp:ListItem>
                </asp:DropDownList>
                <asp:DropDownList ID="ddlOrderType" runat="server" CssClass="filter-dropdown">
                    <asp:ListItem Text="All Types" Value=""></asp:ListItem>
                    <asp:ListItem Text="Delivery" Value="Delivery"></asp:ListItem>
                    <asp:ListItem Text="Dine-In" Value="Dine-In"></asp:ListItem>
                    <asp:ListItem Text="Takeout" Value="Takeout"></asp:ListItem>
                </asp:DropDownList>
                <asp:DropDownList ID="ddlPriority" runat="server" CssClass="filter-dropdown">
                    <asp:ListItem Text="All Priority" Value=""></asp:ListItem>
                    <asp:ListItem Text="Normal" Value="Normal"></asp:ListItem>
                    <asp:ListItem Text="Rush" Value="Rush"></asp:ListItem>
                </asp:DropDownList>
                <asp:DropDownList ID="ddlDateFilter" runat="server" CssClass="filter-dropdown">
                    <asp:ListItem Text="All Time" Value="all"></asp:ListItem>
                    <asp:ListItem Text="Today" Value="today"></asp:ListItem>
                    <asp:ListItem Text="This Week" Value="week"></asp:ListItem>
                    <asp:ListItem Text="This Month" Value="month"></asp:ListItem>
                    <asp:ListItem Text="This Year" Value="year"></asp:ListItem>
                </asp:DropDownList>
            </div>
        </div>

        <asp:Button ID="btnHiddenSearch" runat="server" OnClick="btnSearch_Click" style="display: none;" />
        <asp:Button ID="btnHiddenStatusUpdate" runat="server" OnClick="btnUpdateStatus_Click" style="display: none;" />

        <div class="orders-container">
            <div class="table-wrapper">
                <asp:Repeater ID="rptOrders" runat="server" OnItemDataBound="rptOrders_ItemDataBound" OnItemCommand="rptOrders_ItemCommand">
                    <HeaderTemplate>
                        <table class="orders-table">
                            <thead>
                                <tr>
                                    <th style="width:30px;"></th>
                                    <th>ORDER #</th>
                                    <th>CUSTOMER</th>
                                    <th>TYPE</th>
                                    <th>DATE & TIME</th>
                                    <th>TOTAL</th>
                                    <th>STATUS</th>
                                    <th>PRIORITY</th>
                                    <th>ACTIONS</th>
                                </tr>
                            </thead>
                            <tbody>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr class="order-row" data-ticketid="<%# Eval("TicketID") %>" onclick="toggleOrderItems(<%# Eval("TicketID") %>)">
                            <td style="text-align:center;">
                                <i class="fas fa-chevron-right expand-icon" id="expandIcon_<%# Eval("TicketID") %>"></i>
                            </td>
                            <td>
                                <span class="order-id"><%# Eval("TicketNumber") %></span>
                            </td>
                            <td>
                                <div class="customer-name"><%# Eval("CustomerName") %></div>
                            </td>
                            <td>
                                <i class="fas <%# GetOrderTypeIcon(Eval("OrderType").ToString()) %>"></i> <%# Eval("OrderType") %>
                            </td>
                            <td>
                                <div><%# Convert.ToDateTime(Eval("CreatedAt")).ToString("MMM dd, yyyy") %></div>
                                <small style="color:var(--muted-text);"><%# Convert.ToDateTime(Eval("CreatedAt")).ToString("hh:mm tt") %></small>
                            </td>
                            <td class="order-total">₱<%# Convert.ToDecimal(Eval("TotalAmount")).ToString("N2") %></td>
                            <td>
                                <span class="order-status status-<%# GetStatusClass(Eval("Status").ToString()) %>"><%# Eval("Status") %></span>
                            </td>
                            <td>
                                <%# Eval("Priority").ToString() == "Rush" ? "<span class='priority-rush'><i class='fas fa-bolt'></i> Rush</span>" : "<span class='priority-normal'><i class='fas fa-clock'></i> Normal</span>" %>
                            </td>
                            <td>
                                <div class="action-buttons">
                                    <asp:LinkButton ID="btnView" runat="server" CommandName="View" CommandArgument='<%# Eval("TicketNumber") %>' CssClass="action-button view" ToolTip="View Details">
                                        <i class="fas fa-eye"></i>
                                    </asp:LinkButton>
                                    <button type="button" class="action-button update" onclick="openStatusModal('<%# Eval("TicketNumber") %>', '<%# Eval("Status").ToString().Replace("'", "\\'") %>')">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                </div>
                            </td>
                        </tr>
                        <tr class="items-row" id="itemsRow_<%# Eval("TicketID") %>">
                            <td colspan="9">
                                <div class="items-container">
                                    <div class="items-header">
                                        <h4><i class="fas fa-shopping-cart"></i> Order Items - <%# Eval("TicketNumber") %></h4>
                                    </div>
                                    <asp:PlaceHolder ID="phItems" runat="server"></asp:PlaceHolder>
                                </div>
                            </td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                            </tbody>
                        </table>
                    </FooterTemplate>
                </asp:Repeater>
                <asp:Panel ID="pnlEmptyData" runat="server" Visible="false" CssClass="no-results">
                    <i class="fas fa-inbox" style="font-size: 48px; margin-bottom: 15px;"></i>
                    <h3>No orders found</h3>
                    <p>Try adjusting your filters or search criteria</p>
                </asp:Panel>
            </div>
        </div>

        <div class="pagination">
            <asp:Repeater ID="rptPagination" runat="server" OnItemCommand="rptPagination_ItemCommand">
                <ItemTemplate>
                    <asp:LinkButton ID="btnPage" runat="server" CommandName="Page" CommandArgument='<%# Container.DataItem %>' CssClass='page-link'>
                        <%# Container.DataItem %>
                    </asp:LinkButton>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>

    <script type="text/javascript">
        let searchTimeout, currentStatusOrderNumber = null, selectedStatusValue = null;

        function toggleOrderItems(ticketId) {
            let row = document.getElementById('itemsRow_' + ticketId);
            let icon = document.getElementById('expandIcon_' + ticketId);
            if (!row) return;
            
            if (row.classList.contains('show')) {
                row.style.animation = 'fadeOut 0.2s ease';
                setTimeout(() => {
                    row.classList.remove('show');
                    if (icon) icon.classList.remove('expanded');
                    row.style.animation = '';
                }, 200);
            } else {
                document.querySelectorAll('.items-row.show').forEach(r => {
                    if (r.classList.contains('show')) r.classList.remove('show');
                });
                document.querySelectorAll('.expand-icon.expanded').forEach(i => i.classList.remove('expanded'));
                row.classList.add('show');
                if (icon) icon.classList.add('expanded');
                setTimeout(() => { row.scrollIntoView({ behavior: 'smooth', block: 'nearest' }); }, 100);
            }
        }

        function performSearch() { 
            let searchBox = document.getElementById('searchBox');
            if (searchBox) searchBox.classList.add('loading');
            setTimeout(() => { 
                document.getElementById('<%= btnHiddenSearch.ClientID %>').click();
                if (searchBox) setTimeout(() => searchBox.classList.remove('loading'), 500);
            }, 200); 
        }
        
        function setupEnterKeySearch() {
            let input = document.getElementById('<%= txtSearch.ClientID %>');
            if (input) { 
                input.addEventListener('keypress', e => { if (e.key === 'Enter') { e.preventDefault(); performSearch(); } }); 
                input.addEventListener('input', () => { clearTimeout(searchTimeout); searchTimeout = setTimeout(performSearch, 500); });
            }
        }
        
        function setupFilterListeners() {
            const filterIds = ['<%= ddlStatus.ClientID %>', '<%= ddlOrderType.ClientID %>', '<%= ddlPriority.ClientID %>', '<%= ddlDateFilter.ClientID %>'];
            filterIds.forEach(id => { 
                let el = document.getElementById(id); 
                if (el) el.addEventListener('change', function() { performSearch(); }); 
            });
        }
        
        function selectStatus(el, status) { 
            document.querySelectorAll('#statusOptions .status-option').forEach(opt => opt.classList.remove('selected')); 
            el.classList.add('selected'); 
            selectedStatusValue = status; 
        }
        
        function openStatusModal(orderNumber, currentStatus) {
            currentStatusOrderNumber = orderNumber; 
            selectedStatusValue = currentStatus;
            document.getElementById('statusOrderNumber').innerHTML = orderNumber;
            document.querySelectorAll('#statusOptions .status-option').forEach(opt => { 
                if (opt.getAttribute('data-status') === currentStatus) opt.classList.add('selected'); 
                else opt.classList.remove('selected'); 
            });
            document.getElementById('statusModal').style.display = 'flex';
            document.getElementById('orderHistoryContainer').classList.add('blur-background');
            document.body.style.overflow = 'hidden';
        }
        
        function confirmStatusUpdate() {
            if (!currentStatusOrderNumber || !selectedStatusValue) { 
                showNotification('Please select a status', 'error'); 
                return; 
            }
            closeModal('statusModal');
            let form = document.forms[0];
            let orderInput = document.createElement('input'); 
            orderInput.type = 'hidden'; 
            orderInput.name = 'hiddenOrderNumber'; 
            orderInput.value = currentStatusOrderNumber;
            let statusInput = document.createElement('input'); 
            statusInput.type = 'hidden'; 
            statusInput.name = 'hiddenNewStatus'; 
            statusInput.value = selectedStatusValue;
            form.appendChild(orderInput); 
            form.appendChild(statusInput);
            document.getElementById('<%= btnHiddenStatusUpdate.ClientID %>').click();
        }

        function showOrderDetailsModal(jsonData) {
            let modal = document.getElementById('orderModal');
            let body = document.getElementById('modalBody');
            let container = document.getElementById('orderHistoryContainer');

            if (!modal || !body) {
                console.error('Modal or body element not found');
                return;
            }

            container.classList.add('blur-background');
            document.body.style.overflow = 'hidden';

            try {
                let data = typeof jsonData === 'string' ? JSON.parse(jsonData) : jsonData;

                if (!data || !data.items) {
                    throw new Error('Invalid order data');
                }

                let itemsHtml = '<table class="items-table"><thead><tr><th>Item</th><th>Qty</th><th>Price</th><th>Subtotal</th><th>Status</th></tr></thead><tbody>';
                data.items.forEach(item => {
                    itemsHtml += `<tr>
                        <td><strong>${escapeHtml(item.FoodName)}</strong></td>
                        <td>${item.Quantity}</td>
                        <td>₱${parseFloat(item.UnitPrice).toFixed(2)}</td>
                        <td style="color:var(--primary-maroon);font-weight:600;">₱${parseFloat(item.SubTotal).toFixed(2)}</td>
                        <td><span class="order-status status-${getStatusClass(item.Status)}">${escapeHtml(item.Status || 'Pending')}</span></td>
                    </tr>`;
                });
                itemsHtml += '</tbody></table>';

                body.innerHTML = `
                    <div class="detail-section">
                        <h4><i class="fas fa-info-circle"></i> Order Information</h4>
                        <div class="detail-grid">
                            <div class="detail-item"><strong>ORDER #</strong><span>${escapeHtml(data.orderNumber)}</span></div>
                            <div class="detail-item"><strong>ORDER TYPE</strong><span>${escapeHtml(data.orderType)}</span></div>
                            <div class="detail-item"><strong>STATUS</strong><span><span class="order-status status-${getStatusClass(data.status)}">${escapeHtml(data.status)}</span></span></div>
                            <div class="detail-item"><strong>PRIORITY</strong><span>${data.priority === 'Rush' ? '<span class="priority-rush">Rush</span>' : '<span class="priority-normal">Normal</span>'}</span></div>
                            <div class="detail-item"><strong>DATE</strong><span>${escapeHtml(data.createdAt)}</span></div>
                            <div class="detail-item"><strong>TOTAL AMOUNT</strong><span style="font-size:18px;font-weight:700;color:var(--primary-maroon);">₱${parseFloat(data.totalAmount).toFixed(2)}</span></div>
                        </div>
                    </div>
                    <div class="detail-section">
                        <h4><i class="fas fa-user"></i> Customer Information</h4>
                        <div class="detail-grid">
                            <div class="detail-item"><strong>NAME</strong><span>${escapeHtml(data.customerName)}</span></div>
                            <div class="detail-item"><strong>PHONE</strong><span>${escapeHtml(data.customerPhone)}</span></div>
                            <div class="detail-item"><strong>EMAIL</strong><span>${escapeHtml(data.customerEmail)}</span></div>
                        </div>
                    </div>
                    <div class="detail-section">
                        <h4><i class="fas fa-receipt"></i> Order Items</h4>
                        ${itemsHtml}
                        <div class="grand-total">Grand Total: ₱${parseFloat(data.totalAmount).toFixed(2)}</div>
                    </div>
                `;
                modal.style.display = 'flex';
            } catch (e) {
                console.error('Error displaying modal:', e);
                body.innerHTML = `<div style="text-align:center;padding:40px;color:var(--danger-red);">
                    <i class="fas fa-exclamation-circle" style="font-size: 40px;"></i>
                    <p>Error loading order details</p>
                    <button class="btn btn--primary" onclick="closeModal('orderModal')">Close</button>
                </div>`;
                modal.style.display = 'flex';
            }
        }

        function closeModal(modalId) {
            let modal = document.getElementById(modalId);
            let container = document.getElementById('orderHistoryContainer');
            if (modal) { modal.style.display = 'none'; }
            if (container) container.classList.remove('blur-background');
            document.body.style.overflow = 'auto';
        }

        function getStatusClass(status) {
            let s = (status || '').toLowerCase();
            if (s === 'open') return 'open';
            if (s === 'in progress') return 'inprogress';
            if (s === 'completed') return 'completed';
            if (s === 'cancelled') return 'cancelled';
            return 'default';
        }

        function escapeHtml(str) {
            if (!str) return '';
            return String(str).replace(/[&<>]/g, function (m) {
                if (m === '&') return '&amp;';
                if (m === '<') return '&lt;';
                if (m === '>') return '&gt;';
                return m;
            });
        }

        function showNotification(message, type) {
            let notification = document.createElement('div');
            notification.style.cssText = `position:fixed;top:20px;right:20px;padding:10px 18px;background:${type === 'success' ? 'var(--success-green)' : 'var(--danger-red)'};color:white;border-radius:var(--radius-md);box-shadow:0 4px 12px rgba(0,0,0,0.15);z-index:10001;animation:slideInRight 0.3s ease;display:flex;align-items:center;gap:8px;font-family:'Poppins',sans-serif;font-size:12px;`;
            notification.innerHTML = `<i class="fas ${type === 'success' ? 'fa-check-circle' : 'fa-exclamation-circle'}"></i><span>${message}</span>`;
            document.body.appendChild(notification);
            setTimeout(() => {
                notification.style.animation = 'slideOutRight 0.3s ease';
                setTimeout(() => { if (notification.parentNode) notification.parentNode.removeChild(notification); }, 300);
            }, 3000);
        }

        // Make functions available globally
        window.showOrderDetailsModal = showOrderDetailsModal;
        window.closeModal = closeModal;
        window.openStatusModal = openStatusModal;
        window.selectStatus = selectStatus;
        window.confirmStatusUpdate = confirmStatusUpdate;
        window.toggleOrderItems = toggleOrderItems;
        window.showNotification = showNotification;

        document.addEventListener('DOMContentLoaded', function () {
            setupEnterKeySearch();
            setupFilterListeners();

            // Stop propagation on action buttons to prevent row click
            document.querySelectorAll('.action-button').forEach(btn => {
                btn.addEventListener('click', function (e) {
                    e.stopPropagation();
                });
            });

            // Close modals when clicking outside
            document.getElementById('orderModal')?.addEventListener('click', function (e) {
                if (e.target === this) closeModal('orderModal');
            });
            document.getElementById('statusModal')?.addEventListener('click', function (e) {
                if (e.target === this) closeModal('statusModal');
            });

            // Close modals with Escape key
            document.addEventListener('keydown', function (e) {
                if (e.key === 'Escape') {
                    closeModal('orderModal');
                    closeModal('statusModal');
                }
            });
        });
    </script>
</asp:Content>