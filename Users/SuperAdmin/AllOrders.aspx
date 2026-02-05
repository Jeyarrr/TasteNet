<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/SuperAdmin.Master" AutoEventWireup="true" CodeBehind="AllOrders.aspx.cs" Inherits="TasteNet.Users.SuperAdmin.AllOrders" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
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
            --error-red: #b91c1c;
            --error-red-light: #fee2e2;
            --info-blue: #3182CE;
            --info-blue-light: #e1f0f7;
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

        body, form { 
            background-color: var(--soft-cream) !important; 
            font-family: 'Poppins', sans-serif !important;
            margin: 0 !important;
            padding: 0 !important;
            min-height: 100vh;
        }

        .page-container {
            padding: 30px 40px;
            max-width: 1800px;
            margin: 0 auto;
            min-height: 100vh;
            box-sizing: border-box;
        }

        .header-section {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 35px;
            flex-wrap: wrap;
            gap: 20px;
        }

        .header-title h1 { 
            font-size: 32px; 
            color: var(--text-dark); 
            font-weight: 700; 
            margin: 0;
            letter-spacing: -0.5px;
        }

        .header-title p {
            color: var(--muted-text);
            margin: 8px 0 0 0;
            font-size: 16px;
            max-width: 600px;
            line-height: 1.5;
        }

        .header-actions {
            display: flex;
            gap: 15px;
            align-items: center;
            flex-wrap: wrap;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: white;
            padding: 20px;
            border-radius: var(--radius-xl);
            box-shadow: var(--card-shadow);
            transition: all var(--transition-base);
            position: relative;
            overflow: hidden;
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
            font-size: 13px;
            font-weight: 500;
            color: var(--muted-text);
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .stat-card__icon {
            width: 40px;
            height: 40px;
            border-radius: var(--radius-lg);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 18px;
            transition: all var(--transition-base);
            transform-origin: center;
        }

        .stat-card:hover .stat-card__icon {
            transform: scale(1.1) rotate(5deg);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        }

        .stat-card__icon--all { background: var(--accent-blue); color: var(--accent-blue-dark); }
        .stat-card__icon--active { background: var(--warning-orange-light); color: var(--warning-orange); }
        .stat-card__icon--completed { background: var(--success-green-light); color: var(--success-green); }
        .stat-card__icon--cancelled { background: var(--error-red-light); color: var(--error-red); }

        .stat-card__value {
            font-size: 28px;
            font-weight: 700;
            color: var(--primary-maroon);
            margin: 8px 0;
            line-height: 1;
        }

        .stat-card__trend {
            font-size: 12px;
            font-weight: 600;
            color: var(--muted-text);
        }

        .filter-container { 
            display: flex; 
            gap: 12px; 
            margin-bottom: 25px; 
            align-items: center;
            flex-wrap: nowrap;
        }

        .search-wrapper { 
            position: relative; 
            min-width: 350px;
            flex: 0 0 auto;
        }

        .search-wrapper i { 
            position: absolute; 
            left: 15px;
            top: 50%; 
            transform: translateY(-50%);
            color: var(--muted-text); 
            font-size: 14px;
            z-index: 2;
        }

        .search-wrapper input { 
            width: 100%; 
            padding: 10px 20px 10px 40px; 
            border: 2px solid var(--border-light); 
            border-radius: var(--radius-md); 
            outline: none; 
            font-size: 14px;
            box-sizing: border-box;
            background: white;
            color: var(--text-dark);
            font-weight: 500;
            transition: all var(--transition-base);
            height: 40px;
        }

        .search-wrapper input:hover {
            border-color: var(--border-hover);
            box-shadow: 0 4px 12px rgba(107, 13, 30, 0.08);
        }

        .search-wrapper input:focus {
            transform: translateY(-1px);
            border-color: var(--primary-maroon);
            box-shadow: 0 6px 16px rgba(107, 13, 30, 0.12),
                        0 0 0 3px rgba(107, 13, 30, 0.1);
        }

        .search-wrapper input::placeholder {
            color: var(--muted-text);
            opacity: 0.7;
            font-size: 13px;
        }

        .filter-select { 
            padding: 10px 35px 10px 15px; 
            border: 2px solid var(--border-light); 
            border-radius: var(--radius-md); 
            color: var(--text-dark); 
            background: white; 
            min-width: 150px;
            font-size: 13px;
            outline: none;
            font-weight: 500;
            cursor: pointer;
            transition: all var(--transition-base);
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='14' height='14' fill='%238a6d6d' viewBox='0 0 16 16'%3E%3Cpath d='M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 12px center;
            background-size: 10px;
            height: 40px;
            box-shadow: 0 2px 6px rgba(107, 13, 30, 0.05);
            box-sizing: border-box;
            flex: 0 0 auto;
        }

        .filter-select:hover {
            border-color: var(--primary-maroon);
            box-shadow: 0 4px 12px rgba(107, 13, 30, 0.1);
            transform: translateY(-1px);
        }

        .filter-select:focus {
            border-color: var(--primary-maroon);
            box-shadow: 0 0 0 3px rgba(107, 13, 30, 0.15);
        }

        .tabs-container {
            background: white;
            border-radius: var(--radius-lg) var(--radius-lg) 0 0;
            box-shadow: var(--card-shadow);
            padding: 0;
            margin-bottom: 0;
            position: relative;
            z-index: 2;
        }

        .tabs {
            display: flex;
            gap: 0; 
            padding: 0 20px;
        }

        .tab-item { 
            padding: 20px 25px;
            cursor: pointer;
            color: var(--muted-text);
            font-weight: 500; 
            font-size: 14px; 
            position: relative; 
            transition: all var(--transition-base);
            border-bottom: 3px solid transparent;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .tab-item:hover {
            color: var(--primary-maroon);
            background: var(--bg-lighter);
        }

        .tab-item.active { 
            color: var(--primary-maroon);
            border-bottom-color: var(--primary-maroon); 
            font-weight: 600; 
            background: white;
        }

        .tab-count { 
            background: var(--bg-lighter); 
            font-size: 11px; 
            padding: 4px 8px; 
            border-radius: var(--radius-sm); 
            font-weight: 700; 
            color: var(--muted-text);
            transition: all var(--transition-base);
        }

        .tab-item.active .tab-count {
            background: var(--primary-maroon);
            color: white;
        }

        .orders-card { 
            background: white; 
            border-radius: 0 0 var(--radius-xl) var(--radius-xl); 
            box-shadow: var(--card-shadow); 
            overflow: hidden;
            animation: fadeIn 0.5s ease-out;
            margin-top: -1px;
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
            background: white; 
            padding: 15px 10px;
            color: var(--muted-text); 
            font-size: 11px;
            font-weight: 600; 
            border-bottom: 2px solid var(--bg-light); 
            letter-spacing: 0.3px;
            text-transform: uppercase;
            text-align: center;
            white-space: nowrap;
        }

        .orders-table td {
            padding: 15px 10px;
            border-bottom: 1px solid var(--bg-lighter); 
            font-size: 13px; 
            vertical-align: middle;
            text-align: center;
            transition: all var(--transition-fast);
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            max-width: 150px;
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

        .orders-table tbody tr:last-child td {
            border-bottom: none;
        }

        .order-id { 
            color: var(--primary-maroon); 
            font-weight: 700; 
            text-decoration: none; 
            font-size: 13px;
            padding: 0;
            transition: all var(--transition-base);
            position: relative;
            display: inline-block;
            font-family: 'Courier New', monospace;
        }

        .order-id:hover {
            color: var(--primary-maroon-dark);
            text-decoration: none;
            animation: bounce 0.5s ease infinite alternate;
        }

        .order-id:hover::before {
            content: '';
            position: absolute;
            left: 50%;
            transform: translateX(-50%);
            bottom: -3px;
            width: 30px;
            height: 2px;
            background: var(--primary-maroon);
            animation: underlineExpand 0.3s ease forwards;
        }

        .order-date {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 2px;
        }

        .date-main {
            font-weight: 600;
            color: var(--text-dark);
            font-size: 12px;
        }

        .date-time {
            color: var(--muted-text);
            font-size: 10px;
            font-weight: 500;
        }

        .customer-name {
            font-weight: 600;
            color: var(--text-dark);
            font-size: 12px;
            transition: color var(--transition-fast);
        }

        .customer-name:hover {
            color: var(--primary-maroon);
        }

        .customer-phone {
            color: var(--muted-text);
            font-size: 10px;
            font-weight: 500;
        }

        .amount-text { 
            font-weight: 700; 
            color: var(--primary-maroon);
            font-size: 15px;
        }

        .payment-badge {
            background: var(--bg-lighter);
            color: var(--text-dark);
            padding: 4px 8px;
            border-radius: var(--radius-sm);
            font-size: 11px;
            font-weight: 600;
            display: inline-block;
            transition: all var(--transition-fast);
            max-width: 90px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .status-badge { 
            padding: 6px 12px;
            border-radius: var(--radius-sm);
            font-size: 10px;
            font-weight: 700;
            text-transform: uppercase;
            display: inline-block;
            border: 1px solid transparent;
            transition: all var(--transition-base);
            min-width: 65px;
            max-width: 80px;
            text-align: center;
            position: relative;
            overflow: hidden;
            line-height: 1.2;
            letter-spacing: 0.3px;
        }

        .status-badge:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
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

        .status-active { 
            background: var(--info-blue-light); 
            color: var(--info-blue);
            border-color: var(--info-blue);
        }

        .status-active:hover {
            background: var(--info-blue);
            color: white;
        }

        .status-cancelled { 
            background: var(--error-red-light); 
            color: var(--error-red);
            border-color: var(--error-red);
        }

        .status-cancelled:hover {
            background: var(--error-red);
            color: white;
        }

        .status-pending { 
            background: var(--warning-orange-light); 
            color: var(--warning-orange);
            border-color: var(--warning-orange);
        }

        .status-pending:hover {
            background: var(--warning-orange);
            color: white;
        }

        .action-btns {
            display: flex;
            gap: 6px;
            align-items: center;
            justify-content: center;
            flex-wrap: nowrap;
            width: 100%;
        }

        .action-icon {
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
            font-size: 14px;
            position: relative;
            text-decoration: none;
            overflow: hidden;
            flex-shrink: 0;
            margin: 0 auto;
        }

        .action-icon::before {
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

        .action-icon:active::before {
            width: 200px;
            height: 200px;
        }

        .action-icon:hover {
            transform: translateY(-2px) scale(1.1);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
        }

        .action-icon.view:hover {
            background: var(--primary-maroon);
            color: white;
        }

        .action-icon[title]:hover::after {
            content: attr(title);
            position: absolute;
            bottom: -35px;
            left: 50%;
            transform: translateX(-50%) translateY(-5px);
            background: var(--text-dark);
            color: white;
            padding: 6px 10px;
            border-radius: var(--radius-sm);
            font-size: 11px;
            font-weight: 500;
            white-space: nowrap;
            z-index: 100;
            opacity: 0;
            animation: tooltipFadeIn 0.3s ease forwards;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        }

        .action-icon[title]:hover::before {
            content: '';
            position: absolute;
            bottom: -20px;
            left: 50%;
            transform: translateX(-50%);
            border: 5px solid transparent;
            border-bottom-color: var(--text-dark);
            z-index: 101;
            opacity: 0;
            animation: tooltipFadeIn 0.3s ease forwards;
        }

        .chubby-checkbox {
            width: 18px;
            height: 18px;
            border-radius: var(--radius-sm);
            border: 2px solid var(--border-light);
            background: white;
            cursor: pointer;
            appearance: none;
            position: relative;
            transition: all var(--transition-base);
            margin: 0 auto;
            display: block;
        }

        .chubby-checkbox:checked {
            background: var(--primary-maroon);
            border-color: var(--primary-maroon);
            transform: scale(1.1);
        }

        .chubby-checkbox:checked::after {
            content: '✓';
            position: absolute;
            color: white;
            font-size: 12px;
            font-weight: bold;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
        }

        .orders-table th:nth-child(8),
        .orders-table td:nth-child(8) {
            width: 100px;
            min-width: 100px;
            max-width: 100px;
        }

        .orders-table th:nth-child(9),
        .orders-table td:nth-child(9) {
            width: 70px;
            min-width: 70px;
            max-width: 70px;
        }

        .orders-table th:nth-child(6),
        .orders-table td:nth-child(6) {
            width: 90px;
            min-width: 90px;
            max-width: 90px;
        }

        .orders-table th:nth-child(7),
        .orders-table td:nth-child(7) {
            width: 100px;
            min-width: 100px;
            max-width: 100px;
        }

        @media (max-width: 576px) {
            .status-badge {
                min-width: 65px;
                max-width: 70px;
                font-size: 8px;
                padding: 3px 6px;
            }
            
            .action-icon {
                width: 24px;
                height: 24px;
                font-size: 10px;
            }
            
            .orders-table th:nth-child(8),
            .orders-table td:nth-child(8) {
                width: 75px;
                min-width: 75px;
                max-width: 75px;
            }
            
            .orders-table th:nth-child(9),
            .orders-table td:nth-child(9) {
                width: 50px;
                min-width: 50px;
                max-width: 50px;
            }
        }

        .btn {
            padding: 10px 20px;
            border-radius: var(--radius-md);
            font-weight: 600;
            font-size: 14px;
            cursor: pointer;
            transition: all var(--transition-base);
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            border: 2px solid transparent;
            font-family: 'Poppins', sans-serif;
            text-decoration: none;
            white-space: nowrap;
            min-height: 40px;
            line-height: 1.2;
            position: relative;
            overflow: hidden;
            z-index: 1;
        }

        .btn::before {
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

        .btn:hover::before {
            left: 100%;
        }

        .btn--primary {
            background: var(--primary-maroon);
            color: white;
            box-shadow: var(--button-shadow);
        }

        .btn--primary:hover {
            background: var(--primary-maroon-dark);
            transform: translateY(-3px);
            box-shadow: var(--button-shadow-hover);
        }

        .btn--outline {
            background: white;
            color: var(--primary-maroon);
            border-color: var(--border-light);
            box-shadow: 0 2px 8px rgba(107, 13, 30, 0.1);
        }

        .btn--outline:hover {
            background: var(--soft-cream);
            border-color: var(--primary-maroon);
            transform: translateY(-3px);
        }

        .pagination-container { 
            display: flex; 
            justify-content: space-between; 
            align-items: center; 
            margin-top: 30px; 
            padding: 20px 0;
        }

        .pagination-text {
            color: var(--muted-text);
            font-size: 14px;
            font-weight: 500;
        }

        .pagination-buttons {
            display: flex;
            gap: 8px;
        }

        .page-btn { 
            padding: 10px 16px; 
            border: 2px solid var(--border-light); 
            background: white; 
            border-radius: var(--radius-md); 
            cursor: pointer; 
            font-family: 'Poppins';
            font-weight: 600;
            font-size: 14px;
            color: var(--text-dark);
            transition: all var(--transition-base);
            min-width: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            overflow: hidden;
        }

        .page-btn:hover:not(.active) {
            border-color: var(--primary-maroon);
            background: var(--soft-cream);
            transform: translateY(-2px);
        }

        .page-btn.active { 
            background: var(--primary-maroon); 
            color: white; 
            border-color: var(--primary-maroon);
            box-shadow: var(--button-shadow);
        }

        .page-btn.active:hover {
            background: var(--primary-maroon-dark);
            transform: translateY(-2px);
            box-shadow: var(--button-shadow-hover);
        }

        .no-results {
            text-align: center;
            padding: 60px 20px;
            color: var(--muted-text);
            display: none;
        }

        .no-results i {
            font-size: 48px;
            margin-bottom: 15px;
            color: var(--border-light);
        }

        .filter-select.active {
            border-color: var(--primary-maroon);
            background-color: var(--soft-cream);
            box-shadow: 0 0 0 3px rgba(107, 13, 30, 0.1);
        }

        .search-wrapper.loading i {
            animation: spin 1s linear infinite;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
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
            to { width: 30px; }
        }

        @keyframes tooltipFadeIn {
            from {
                opacity: 0;
                transform: translateX(-50%) translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateX(-50%) translateY(0);
            }
        }

        @keyframes spin {
            from { transform: translateY(-50%) rotate(0deg); }
            to { transform: translateY(-50%) rotate(360deg); }
        }

        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0,0,0,0.7);
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 10000;
            animation: fadeIn 0.3s ease;
            backdrop-filter: blur(5px);
        }

        .order-modal {
            background: white;
            border-radius: var(--radius-xl);
            max-width: 900px;
            width: 90%;
            max-height: 90vh;
            overflow-y: auto;
            box-shadow: 0 25px 50px rgba(0,0,0,0.25);
            animation: slideUp 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
        }

        .modal-header {
            padding: 25px 30px;
            border-bottom: 1px solid var(--border-light);
            background: linear-gradient(135deg, var(--primary-maroon), var(--primary-maroon-dark));
            color: white;
            border-radius: var(--radius-xl) var(--radius-xl) 0 0;
            position: relative;
        }

        .modal-header h3 {
            margin: 0;
            font-size: 22px;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .close-modal {
            position: absolute;
            top: 25px;
            right: 30px;
            background: rgba(255,255,255,0.2);
            border: none;
            width: 36px;
            height: 36px;
            border-radius: 50%;
            color: white;
            cursor: pointer;
            transition: all var(--transition-base);
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .close-modal:hover {
            background: rgba(255,255,255,0.3);
            transform: rotate(90deg);
        }

        .modal-body {
            padding: 30px;
        }

        .order-details-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 25px;
            margin-bottom: 30px;
        }

        .info-section {
            background: var(--soft-cream);
            padding: 20px;
            border-radius: var(--radius-lg);
            border: 1px solid var(--border-light);
        }

        .info-section h4 {
            margin: 0 0 15px 0;
            color: var(--primary-maroon);
            font-size: 16px;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .info-section h4 i {
            color: var(--muted-text);
        }

        .info-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 0;
            border-bottom: 1px dashed var(--border-light);
        }

        .info-row:last-child {
            border-bottom: none;
        }

        .info-label {
            color: var(--muted-text);
            font-size: 13px;
            font-weight: 500;
        }

        .info-value {
            color: var(--text-dark);
            font-weight: 600;
            font-size: 14px;
            text-align: right;
        }

        .info-value.status {
            display: inline-flex;
            padding: 4px 12px;
            border-radius: var(--radius-sm);
            font-size: 12px;
            font-weight: 700;
            text-transform: uppercase;
        }

        .info-value.status-completed {
            background: var(--success-green-light);
            color: var(--success-green);
        }

        .info-value.status-active {
            background: var(--info-blue-light);
            color: var(--info-blue);
        }

        .info-value.status-cancelled {
            background: var(--error-red-light);
            color: var(--error-red);
        }

        .info-value.status-pending {
            background: var(--warning-orange-light);
            color: var(--warning-orange);
        }

        @media (max-width: 1400px) {
            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
            }
            
            .filter-container {
                flex-wrap: wrap;
            }
            
            .search-wrapper {
                min-width: 100%;
            }
        }

        @media (max-width: 1200px) {
            .page-container {
                padding: 20px 30px;
            }
            
            .order-details-grid {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 992px) {
            .header-section {
                flex-direction: column;
                align-items: stretch;
                gap: 20px;
            }
            
            .header-title h1 {
                font-size: 28px;
            }
            
            .tabs {
                overflow-x: auto;
                padding: 0 15px;
            }
            
            .tab-item {
                padding: 15px 20px;
                font-size: 13px;
                white-space: nowrap;
            }
        }

        @media (max-width: 768px) {
            .stats-grid {
                grid-template-columns: 1fr;
            }
            
            .page-container {
                padding: 15px 20px;
            }
            
            .filter-container {
                flex-direction: column;
                width: 100%;
            }
            
            .filter-select {
                width: 100%;
                min-width: auto;
            }
            
            .orders-table th,
            .orders-table td {
                padding: 12px 8px;
                font-size: 12px;
            }
            
            .status-badge {
                padding: 4px 8px;
                font-size: 9px;
                min-width: 70px;
                max-width: 75px;
            }
            
            .action-icon {
                width: 28px;
                height: 28px;
                font-size: 12px;
            }
            
            .orders-table th:nth-child(9),
            .orders-table td:nth-child(9) {
                width: 60px;
                min-width: 60px;
                max-width: 60px;
            }
            
            .pagination-container {
                flex-direction: column;
                gap: 15px;
                align-items: stretch;
            }
            
            .pagination-buttons {
                justify-content: center;
                flex-wrap: wrap;
            }
        }

        @media (max-width: 480px) {
            .page-container {
                padding: 12px 15px;
            }
            
            .header-title h1 {
                font-size: 24px;
            }
            
            .stat-card {
                padding: 15px;
            }

            .stat-card__value { 
                font-size: 24px;
            }
            
            .btn {
                padding: 8px 16px;
                font-size: 13px;
                min-height: 36px;
            }
            
            .tab-item {
                padding: 12px 15px;
                font-size: 12px;
            }
            
            .modal-header h3 {
                font-size: 18px;
                flex-direction: column;
                align-items: flex-start;
                gap: 8px;
            }
            
            .modal-body {
                padding: 20px;
            }
        }
    </style>

    <script runat="server">
        protected string GetCustomerPhone(string customerName)
        {
            var phoneNumbers = new Dictionary<string, string>
            {
                { "Jay-r Casano", "0918-222-3333" },
                { "George Gonzaga", "0919-333-4444" },
                { "Zea Mae Sulit", "0917-111-2222" },
                { "Lalaine Reyes", "0920-444-5555" },
                { "Bryle Magallano", "0921-555-6666" },
            };
            
            return phoneNumbers.ContainsKey(customerName) ? phoneNumbers[customerName] : "N/A";
        }
        
        protected string GetStatusClass(string status)
        {
            switch (status.ToLower())
            {
                case "completed": return "status-completed";
                case "active": return "status-active";
                case "cancelled": return "status-cancelled";
                case "pending": return "status-pending";
                default: return "status-pending";
            }
        }
    </script>

    <div class="page-container">
        <div class="header-section">
            <div class="header-title">
                <h1>Orders Management</h1>
                <p>View, manage, and track all customer orders in real-time</p>
            </div>
            <div class="header-actions">
                <button type="button" class="btn btn--outline" id="refreshOrders">
                    <i class="fas fa-sync-alt"></i>
                    Refresh
                </button>
                <button type="button" class="btn btn--primary" id="exportOrders">
                    <i class="fas fa-download"></i>
                    Export Orders
                </button>
            </div>
        </div>

        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-card__header">
                    <span class="stat-card__label">Total Orders</span>
                    <div class="stat-card__icon stat-card__icon--all">
                        <i class="fas fa-shopping-bag"></i>
                    </div>
                </div>
                <div class="stat-card__value" id="totalOrders">0</div>
                <div class="stat-card__trend">All-time orders</div>
            </div>

            <div class="stat-card">
                <div class="stat-card__header">
                    <span class="stat-card__label">Active Orders</span>
                    <div class="stat-card__icon stat-card__icon--active">
                        <i class="fas fa-clock"></i>
                    </div>
                </div>
                <div class="stat-card__value" id="activeOrders">0</div>
                <div class="stat-card__trend">Currently being processed</div>
            </div>

            <div class="stat-card">
                <div class="stat-card__header">
                    <span class="stat-card__label">Completed Today</span>
                    <div class="stat-card__icon stat-card__icon--completed">
                        <i class="fas fa-check-circle"></i>
                    </div>
                </div>
                <div class="stat-card__value" id="completedOrders">0</div>
                <div class="stat-card__trend">Successful deliveries</div>
            </div>

            <div class="stat-card">
                <div class="stat-card__header">
                    <span class="stat-card__label">Cancelled</span>
                    <div class="stat-card__icon stat-card__icon--cancelled">
                        <i class="fas fa-times-circle"></i>
                    </div>
                </div>
                <div class="stat-card__value" id="cancelledOrders">0</div>
                <div class="stat-card__trend">Cancelled orders</div>
            </div>
        </div>

        <div class="filter-container">
            <div class="search-wrapper" id="searchBox">
                <i class="fas fa-search"></i>
                <input type="text" id="searchInput" placeholder="Search by order ID, customer, restaurant, or item...">
            </div>
            <input type="date" class="filter-select" id="dateFilter">
            <select class="filter-select" id="statusFilter">
                <option value="all">All Status</option>
                <option value="pending">Pending</option>
                <option value="active">Active</option>
                <option value="completed">Completed</option>
                <option value="cancelled">Cancelled</option>
            </select>
            <select class="filter-select" id="paymentFilter">
                <option value="all">All Payment Methods</option>
                <option value="cod">Cash On Delivery</option>
                <option value="gcash">GCash</option>
                <option value="paypal">PayPal</option>
                <option value="gotyme">GoTyme</option>
                <option value="credit">Credit Card</option>
            </select>
        </div>

        <div class="tabs-container">
            <div class="tabs" id="orderTabs">
                <div class="tab-item active" data-tab="all">
                    <i class="fas fa-list"></i>
                    All Orders
                    <span class="tab-count" id="allCount">0</span>
                </div>
                <div class="tab-item" data-tab="active">
                    <i class="fas fa-clock"></i>
                    Active
                    <span class="tab-count" id="activeCount">0</span>
                </div>
                <div class="tab-item" data-tab="completed">
                    <i class="fas fa-check-circle"></i>
                    Completed
                    <span class="tab-count" id="completedCount">0</span>
                </div>
                <div class="tab-item" data-tab="cancelled">
                    <i class="fas fa-times-circle"></i>
                    Cancelled
                    <span class="tab-count" id="cancelledCount">0</span>
                </div>
                <div class="tab-item" data-tab="pending">
                    <i class="fas fa-hourglass-half"></i>
                    Pending
                    <span class="tab-count" id="pendingCount">0</span>
                </div>
            </div>
        </div>

        <div class="orders-card">
            <div class="table-wrapper">
                <table class="orders-table">
                    <thead>
                        <tr>
                            <th style="width: 50px;">
                                <input type="checkbox" class="chubby-checkbox" id="selectAll">
                            </th>
                            <th>Order ID</th>
                            <th>Date & Time</th>
                            <th>Customer</th>
                            <th>Items</th>
                            <th>Amount</th>
                            <th>Payment</th>
                            <th>Status</th>
                            <th style="width: 70px;">Action</th>
                        </tr>
                    </thead>
                    <tbody id="ordersTableBody">
                        <asp:Repeater ID="rptOrders" runat="server">
                            <ItemTemplate>
                                <tr>
                                    <td><input type="checkbox" class="chubby-checkbox" data-order-id='<%# Container.ItemIndex %>'></td>
                                    <td>
                                        <a href="#" class="order-id" onclick="viewOrder('<%# Container.ItemIndex %>'); return false;">
                                            <%# Eval("OrderNumber") %>
                                        </a>
                                    </td>
                                    <td>
                                        <div class="order-date">
                                            <span class="date-main"><%# ((DateTime)Eval("OrderDate")).ToString("MMM dd, yyyy") %></span>
                                            <span class="date-time"><%# ((DateTime)Eval("OrderDate")).ToString("h:mm tt") %></span>
                                        </div>
                                    </td>
                                    <td>
                                        <div style="display: flex; flex-direction: column; align-items: center; gap: 2px;">
                                            <span class="customer-name"><%# Eval("CustomerName") %></span>
                                            <span class="customer-phone"><%# GetCustomerPhone((string)Eval("CustomerName")) %></span>
                                        </div>
                                    </td>
                                    <td style="color: var(--text-dark); font-size: 13px; max-width: 200px; overflow: hidden; text-overflow: ellipsis;">
                                        <%# Eval("ItemsSummary") %>
                                    </td>
                                    <td class="amount-text">₱<%# Eval("TotalAmount") %></td>
                                    <td>
                                        <span class="payment-badge"><%# Eval("PaymentMethod") %></span>
                                    </td>
                                    <td>
                                        <span class='status-badge <%# GetStatusClass((string)Eval("OrderStatus")) %>'>
                                            <%# Eval("OrderStatus") %>
                                        </span>
                                    </td>
                                    <td>
                                        <div class="action-btns">
                                            <button type="button" class="action-icon view" title="View Details" onclick="viewOrder('<%# Container.ItemIndex %>')">
                                                <i class="fas fa-eye"></i>
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>
                <div class="no-results" id="noResultsMessage">
                    <i class="fas fa-search"></i>
                    <h3>No orders found</h3>
                    <p>Try adjusting your search or filters</p>
                </div>
            </div>
        </div>

        <div class="pagination-container">
            <span class="pagination-text" id="paginationText">Showing 0 of 0 orders</span>
            <div class="pagination-buttons" id="paginationButtons">
            </div>
        </div>
    </div>

    <div id="orderModal" class="modal-overlay" style="display: none;">
        <div class="order-modal">
            <div class="modal-header">
                <h3>
                    <i class="fas fa-receipt"></i>
                    Order Details
                    <span class="order-id" id="modalOrderId">#000000</span>
                </h3>
                <button class="close-modal" onclick="closeModal()">
                    <i class="fas fa-times"></i>
                </button>
            </div>
            <div class="modal-body">
            </div>
        </div>
    </div>

    <script type="text/javascript">
        let ordersData = [];
        let allOrders = [];
        let currentPage = 1;
        const itemsPerPage = 10;
        let filteredOrders = [];
        let currentTab = 'all';

        document.addEventListener('DOMContentLoaded', function () {
            extractDataFromTable();
            initializeOrdersData();
            setupEventListeners();
            applyFilters();
            updateTabCountsFromData();
        });

        function extractDataFromTable() {
            const rows = document.querySelectorAll('#ordersTableBody tr');
            ordersData = [];

            rows.forEach((row, index) => {
                const cells = row.querySelectorAll('td');
                if (cells.length >= 8) {
                    const orderNumber = cells[1].querySelector('.order-id').textContent.trim();
                    const dateTime = cells[2].querySelector('.order-date');
                    const dateParts = dateTime.querySelector('.date-main').textContent.trim();
                    const timeParts = dateTime.querySelector('.date-time').textContent.trim();
                    const customerName = cells[3].querySelector('.customer-name').textContent.trim();
                    const customerPhone = cells[3].querySelector('.customer-phone').textContent.trim();
                    const items = cells[4].textContent.trim();
                    const amount = parseFloat(cells[5].textContent.replace('₱', '').trim());
                    const payment = cells[6].querySelector('.payment-badge').textContent.trim();
                    const statusBadge = cells[7].querySelector('.status-badge');
                    const status = getStatusFromBadge(statusBadge);

                    ordersData.push({
                        id: index.toString(),
                        orderNumber: orderNumber,
                        date: formatDateString(dateParts),
                        time: timeParts,
                        customer: {
                            name: customerName,
                            phone: customerPhone,
                            email: `${customerName.toLowerCase().replace(/\s+/g, '.')}@gmail.com`
                        },
                        restaurant: "TasteNet Restaurant",
                        items: items,
                        amount: amount,
                        payment: payment,
                        status: status,
                        address: getDasmariñasAddress(customerName),
                        rider: getMockRider(customerName),
                        notes: "No special instructions"
                    });
                }
            });
        }

        function getDasmariñasAddress(customerName) {
            const dasmariñasAddresses = {
                "Jay-r Casano": "123 Aguinaldo Highway, Dasmariñas City, Cavite",
                "George Gonzaga": "456 Pala-pala, Dasmariñas City, Cavite",
                "Zea Mae Sulit": "789 Salawag, Dasmariñas City, Cavite",
                "Lalaine Reyes": "321 Langkaan, Dasmariñas City, Cavite",
                "Bryle Magallano": "654 Sabang, Dasmariñas City, Cavite"
            };
            return dasmariñasAddresses[customerName] || "Sample Address, Dasmariñas City, Cavite";
        }

        function getStatusFromBadge(badge) {
            if (!badge) return 'pending';
            const badgeClass = badge.className;
            if (badgeClass.includes('status-completed')) return 'completed';
            if (badgeClass.includes('status-active')) return 'active';
            if (badgeClass.includes('status-cancelled')) return 'cancelled';
            if (badgeClass.includes('status-pending')) return 'pending';
            return 'pending';
        }

        function formatDateString(dateStr) {
            const months = {
                'Jan': '01', 'Feb': '02', 'Mar': '03', 'Apr': '04',
                'May': '05', 'Jun': '06', 'Jul': '07', 'Aug': '08',
                'Sep': '09', 'Oct': '10', 'Nov': '11', 'Dec': '12'
            };

            const parts = dateStr.replace(',', '').split(' ');
            if (parts.length === 3) {
                const month = months[parts[0]];
                const day = parts[1].padStart(2, '0');
                const year = parts[2];
                return `${year}-${month}-${day}`;
            }
            return dateStr;
        }

        function getMockRider(customerName) {
            const riders = {
                "Jay-r Casano": "RDR-001 (Zea Mae Sulit)",
                "George Gonzaga": "RDR-002 (Jay-r Casano)",
                "Zea Mae Sulit": "RDR-003 (George Gonzaga)",
                "Lalaine Reyes": "RDR-004 (Bryle Magallano)",
                "Bryle Magallano": "RDR-001 (Zea Mae Sulit)"
            };
            return riders[customerName] || "Not assigned";
        }

        function initializeOrdersData() {
            const rows = document.querySelectorAll('#ordersTableBody tr');
            allOrders = [];

            rows.forEach((row, index) => {
                const cells = row.querySelectorAll('td');
                if (cells.length >= 8) {
                    const orderNumber = cells[1].querySelector('.order-id').textContent.trim();
                    const dateTime = cells[2].querySelector('.order-date');
                    const dateParts = dateTime.querySelector('.date-main').textContent.trim();
                    const customerName = cells[3].querySelector('.customer-name').textContent.trim();
                    const items = cells[4].textContent.trim();
                    const amount = parseFloat(cells[5].textContent.replace('₱', '').trim());
                    const payment = cells[6].querySelector('.payment-badge').textContent.trim();
                    const statusBadge = cells[7].querySelector('.status-badge');
                    const status = getStatusFromBadge(statusBadge);

                    allOrders.push({
                        element: row,
                        id: index.toString(),
                        orderNumber: orderNumber,
                        date: dateParts,
                        customer: {
                            name: customerName
                        },
                        items: items,
                        amount: amount,
                        payment: payment,
                        status: status
                    });
                }
            });

            filteredOrders = [...allOrders];
        }

        function setupEventListeners() {
            let searchTimeout;
            document.getElementById('searchInput').addEventListener('input', function () {
                clearTimeout(searchTimeout);
                document.getElementById('searchBox').classList.add('loading');

                searchTimeout = setTimeout(() => {
                    applyFilters();
                    document.getElementById('searchBox').classList.remove('loading');
                }, 300);
            });

            document.getElementById('statusFilter').addEventListener('change', applyFilters);
            document.getElementById('paymentFilter').addEventListener('change', applyFilters);
            document.getElementById('dateFilter').addEventListener('change', applyFilters);

            document.querySelectorAll('.tab-item').forEach(tab => {
                tab.addEventListener('click', function () {
                    document.querySelectorAll('.tab-item').forEach(t => t.classList.remove('active'));
                    this.classList.add('active');
                    currentTab = this.dataset.tab;
                    applyFilters();
                });
            });

            document.getElementById('selectAll').addEventListener('change', function () {
                const isChecked = this.checked;
                document.querySelectorAll('tbody .chubby-checkbox').forEach(checkbox => {
                    checkbox.checked = isChecked;
                    checkbox.style.transform = isChecked ? 'scale(1.1)' : 'scale(1)';
                });
            });

            document.getElementById('exportOrders').addEventListener('click', exportOrders);
            document.getElementById('refreshOrders').addEventListener('click', refreshOrders);

            document.getElementById('orderModal').addEventListener('click', function (e) {
                if (e.target === this) {
                    closeModal();
                }
            });

            document.querySelectorAll('tbody .chubby-checkbox').forEach(checkbox => {
                checkbox.addEventListener('change', function () {
                    this.style.transform = this.checked ? 'scale(1.1)' : 'scale(1)';
                });
            });
        }

        function applyFilters() {
            const searchTerm = document.getElementById('searchInput').value.toLowerCase().trim();
            const statusFilter = document.getElementById('statusFilter').value;
            const paymentFilter = document.getElementById('paymentFilter').value;
            const dateFilter = document.getElementById('dateFilter').value;

            filteredOrders = allOrders.filter(order => {
                const searchMatches = searchTerm === '' ||
                    order.orderNumber.toLowerCase().includes(searchTerm) ||
                    order.customer.name.toLowerCase().includes(searchTerm) ||
                    order.items.toLowerCase().includes(searchTerm);

                const tabMatch = currentTab === 'all' || order.status === currentTab;

                const statusMatch = statusFilter === 'all' || order.status === statusFilter;

                const paymentMatch = paymentFilter === 'all' ||
                    order.payment.toLowerCase().replace(/\s+/g, '-') === paymentFilter;

                const dateMatch = !dateFilter || order.date === dateFilter;

                return searchMatches && tabMatch && statusMatch && paymentMatch && dateMatch;
            });

            updateTableDisplay();
            updatePagination();
            updateStats();
        }

        function updateTableDisplay() {
            const tbody = document.querySelector('#ordersTableBody');
            const allRows = Array.from(tbody.querySelectorAll('tr'));

            allRows.forEach((row, index) => {
                const order = filteredOrders.find(o => o.id === index.toString());
                row.style.display = order ? '' : 'none';
            });

            const noResults = document.getElementById('noResultsMessage');
            if (filteredOrders.length === 0) {
                noResults.style.display = 'block';
            } else {
                noResults.style.display = 'none';
            }

            updatePagination();
        }

        function updatePagination() {
            const totalPages = Math.ceil(filteredOrders.length / itemsPerPage);
            const paginationButtons = document.getElementById('paginationButtons');
            const paginationText = document.getElementById('paginationText');

            const startIndex = (currentPage - 1) * itemsPerPage + 1;
            const endIndex = Math.min(currentPage * itemsPerPage, filteredOrders.length);
            paginationText.textContent = `Showing ${startIndex}-${endIndex} of ${filteredOrders.length} orders`;

            paginationButtons.innerHTML = '';

            if (filteredOrders.length === 0) {
                return;
            }

            const prevButton = document.createElement('button');
            prevButton.className = 'page-btn';
            prevButton.innerHTML = '<i class="fas fa-chevron-left"></i>';
            prevButton.disabled = currentPage === 1;
            prevButton.onclick = () => {
                if (currentPage > 1) {
                    currentPage--;
                    updateTableDisplay();
                    updatePagination();
                }
            };
            paginationButtons.appendChild(prevButton);

            const maxVisiblePages = 5;
            let startPage = Math.max(1, currentPage - Math.floor(maxVisiblePages / 2));
            let endPage = Math.min(totalPages, startPage + maxVisiblePages - 1);

            if (endPage - startPage + 1 < maxVisiblePages) {
                startPage = Math.max(1, endPage - maxVisiblePages + 1);
            }

            for (let i = startPage; i <= endPage; i++) {
                const pageButton = document.createElement('button');
                pageButton.className = `page-btn ${i === currentPage ? 'active' : ''}`;
                pageButton.textContent = i;
                pageButton.onclick = () => {
                    currentPage = i;
                    updateTableDisplay();
                    updatePagination();
                };
                paginationButtons.appendChild(pageButton);
            }

            const nextButton = document.createElement('button');
            nextButton.className = 'page-btn';
            nextButton.innerHTML = '<i class="fas fa-chevron-right"></i>';
            nextButton.disabled = currentPage === totalPages;
            nextButton.onclick = () => {
                if (currentPage < totalPages) {
                    currentPage++;
                    updateTableDisplay();
                    updatePagination();
                }
            };
            paginationButtons.appendChild(nextButton);
        }

        function updateStats() {
            const totalOrders = filteredOrders.length;
            const activeOrders = filteredOrders.filter(o => o.status === 'active').length;
            const completedOrders = filteredOrders.filter(o => o.status === 'completed').length;
            const cancelledOrders = filteredOrders.filter(o => o.status === 'cancelled').length;
            const pendingOrders = filteredOrders.filter(o => o.status === 'pending').length;

            document.getElementById('totalOrders').textContent = totalOrders;
            document.getElementById('activeOrders').textContent = activeOrders;
            document.getElementById('completedOrders').textContent = completedOrders;
            document.getElementById('cancelledOrders').textContent = cancelledOrders;
        }

        function updateTabCountsFromData() {
            const allCount = allOrders.length;
            const activeCount = allOrders.filter(o => o.status === 'active').length;
            const completedCount = allOrders.filter(o => o.status === 'completed').length;
            const cancelledCount = allOrders.filter(o => o.status === 'cancelled').length;
            const pendingCount = allOrders.filter(o => o.status === 'pending').length;

            document.getElementById('allCount').textContent = allCount;
            document.getElementById('activeCount').textContent = activeCount;
            document.getElementById('completedCount').textContent = completedCount;
            document.getElementById('cancelledCount').textContent = cancelledCount;
            document.getElementById('pendingCount').textContent = pendingCount;
        }

        function viewOrder(orderId) {
            const order = ordersData[parseInt(orderId)];
            if (!order) {
                showNotification('Order not found!', 'error');
                return;
            }

            document.getElementById('modalOrderId').textContent = order.orderNumber;

            const modalBody = document.querySelector('#orderModal .modal-body');
            modalBody.innerHTML = `
                <div class="order-details-grid">
                    <div class="info-section">
                        <h4><i class="fas fa-user-circle"></i> Customer Information</h4>
                        <div class="info-row">
                            <span class="info-label">Name:</span>
                            <span class="info-value">${order.customer.name}</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Phone:</span>
                            <span class="info-value">${order.customer.phone}</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Email:</span>
                            <span class="info-value">${order.customer.email}</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Delivery Address:</span>
                            <span class="info-value">${order.address}</span>
                        </div>
                    </div>
                    
                    <div class="info-section">
                        <h4><i class="fas fa-receipt"></i> Order Information</h4>
                        <div class="info-row">
                            <span class="info-label">Restaurant:</span>
                            <span class="info-value">${order.restaurant}</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Items:</span>
                            <span class="info-value">${order.items}</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Total Amount:</span>
                            <span class="info-value" style="color: var(--primary-maroon); font-weight: 700;">₱${order.amount.toFixed(2)}</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Payment Method:</span>
                            <span class="info-value">${order.payment}</span>
                        </div>
                    </div>
                </div>
                
                <div class="info-section" style="margin-top: 20px;">
                    <h4><i class="fas fa-info-circle"></i> Status & Tracking</h4>
                    <div class="info-row">
                        <span class="info-label">Status:</span>
                        <span class="info-value status status-${order.status}" style="display: inline-block;">
                            ${order.status.charAt(0).toUpperCase() + order.status.slice(1)}
                        </span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Assigned Rider:</span>
                        <span class="info-value">${order.rider}</span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Order Notes:</span>
                        <span class="info-value">${order.notes}</span>
                    </div>
                </div>
                
                <div style="display: flex; gap: 12px; margin-top: 30px; justify-content: flex-end;">
                    <button class="btn btn--primary" onclick="closeModal()">
                        <i class="fas fa-times"></i> Close
                    </button>
                </div>
            `;

            document.getElementById('orderModal').style.display = 'flex';
            document.body.style.overflow = 'hidden';
        }

        function closeModal() {
            document.getElementById('orderModal').style.display = 'none';
            document.body.style.overflow = 'auto';
        }

        function exportOrders() {
            const selectedOrders = Array.from(document.querySelectorAll('tbody .chubby-checkbox:checked'))
                .map(checkbox => checkbox.dataset.orderId);

            if (selectedOrders.length === 0) {
                showNotification('Please select at least one order to export', 'warning');
                return;
            }

            showNotification(`Exporting ${selectedOrders.length} orders...`, 'success');
        }

        function refreshOrders() {
            document.getElementById('searchBox').classList.add('loading');
            setTimeout(() => {
                document.getElementById('searchBox').classList.remove('loading');
                showNotification('Orders refreshed successfully!', 'success');
            }, 1000);
        }

        function showNotification(message, type) {
            const notification = document.createElement('div');
            notification.style.cssText = `
                position: fixed;
                top: 20px;
                right: 20px;
                padding: 15px 20px;
                background: ${type === 'success' ? 'var(--success-green)' :
                    type === 'error' ? 'var(--error-red)' :
                        type === 'warning' ? 'var(--warning-orange)' :
                            'var(--info-blue)'};
                color: white;
                border-radius: var(--radius-md);
                box-shadow: 0 4px 12px rgba(0,0,0,0.15);
                z-index: 10001;
                animation: slideInRight 0.3s ease;
                display: flex;
                align-items: center;
                gap: 10px;
                max-width: 300px;
            `;

            notification.innerHTML = `
                <i class="fas ${type === 'success' ? 'fa-check-circle' :
                    type === 'error' ? 'fa-exclamation-circle' :
                        type === 'warning' ? 'fa-exclamation-triangle' :
                            'fa-info-circle'}"></i>
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
                from {
                    transform: translateX(100%);
                    opacity: 0;
                }
                to {
                    transform: translateX(0);
                    opacity: 1;
                }
            }
            
            @keyframes slideOutRight {
                from {
                    transform: translateX(0);
                    opacity: 1;
                }
                to {
                    transform: translateX(100%);
                    opacity: 0;
                }
            }
        `;
        document.head.appendChild(style);
    </script>
</asp:Content>