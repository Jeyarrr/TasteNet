<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/SuperAdmin.Master" AutoEventWireup="true" CodeBehind="Transactions.aspx.cs" Inherits="TasteNet.Users.SuperAdmin.Transactions" %>

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

        #transactions-wrapper {
            background: var(--soft-cream) !important;
            padding: 20px 30px;
            max-width: 1600px;
            margin: 0 auto;
            min-height: 100vh;
            box-sizing: border-box;
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            flex-wrap: wrap;
            gap: 15px;
        }

        .header-title h2 {
            color: var(--text-dark);
            font-weight: 700;
            margin: 0;
            font-size: 28px;
            letter-spacing: -0.5px;
        }

        .header-title p {
            color: var(--muted-text);
            margin: 5px 0 0 0;
            font-size: 14px;
            line-height: 1.5;
        }

        .header-actions {
            display: flex;
            gap: 10px;
            align-items: center;
            flex-wrap: wrap;
        }

        .export-buttons {
            display: flex;
            gap: 15px;
            align-items: center;
        }

        .export-btn {
            padding: 10px 20px;
            border-radius: var(--radius-lg);
            display: flex;
            align-items: center;
            justify-content: center;
            border: none;
            cursor: pointer;
            transition: all var(--transition-base);
            font-size: 14px;
            color: white;
            font-weight: 600;
            gap: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
            position: relative;
            overflow: hidden;
            font-family: 'Poppins', sans-serif;
        }

        .export-btn::before {
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
            transition: left 0.7s;
        }

        .export-btn:hover::before {
            left: 100%;
        }

        .export-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.25);
        }

        .export-btn:active {
            transform: translateY(-1px);
        }

        .export-btn.pdf {
            background: linear-gradient(135deg, var(--primary-maroon), var(--primary-maroon-dark));
        }

        .export-btn.excel {
            background: linear-gradient(135deg, #2d9d78, #1e7c5a);
        }

        .export-btn .btn-icon {
            font-size: 16px;
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
            border-radius: var(--radius-lg);
            box-shadow: var(--card-shadow);
            transition: transform var(--transition-base), box-shadow var(--transition-base);
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 30px rgba(107, 13, 30, 0.12);
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
            font-size: 16px;
            flex-shrink: 0;
            transition: all var(--transition-base);
            transform-origin: center;
        }

        .stat-card:hover .stat-card__icon {
            transform: scale(1.1) rotate(5deg);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
        }

        .stat-card__icon--total { background: var(--accent-pink); color: var(--primary-maroon); }
        .stat-card__icon--paid { background: var(--success-green-light); color: var(--success-green); }
        .stat-card__icon--pending { background: var(--warning-orange-light); color: var(--warning-orange); }
        .stat-card__icon--revenue { background: var(--accent-blue); color: var(--accent-blue-dark); }

        .stat-card__value {
            font-size: 26px;
            font-weight: 700;
            color: var(--primary-maroon);
            margin: 6px 0;
            line-height: 1;
        }

        .stat-card__value.revenue {
            color: var(--primary-maroon);
        }

        .stat-card__trend {
            font-size: 12px;
            font-weight: 600;
            color: var(--muted-text);
        }

        .filter-container {
            display: flex;
            gap: 8px;
            margin-bottom: 20px;
            align-items: center;
            flex-wrap: nowrap;
        }

        .inner-search {
            position: relative;
            min-width: 300px;
            flex: 0 0 auto;
        }

        .inner-search i {
            position: absolute;
            left: 12px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--muted-text);
            font-size: 14px;
            z-index: 2;
        }

        .inner-search input {
            width: 100%;
            padding: 8px 15px 8px 40px;
            border: 2px solid var(--border-light);
            border-radius: var(--radius-md);
            font-size: 13px;
            font-family: 'Poppins', sans-serif;
            background: white;
            color: var(--text-dark);
            transition: all var(--transition-base);
            outline: none;
            font-weight: 500;
            height: 38px;
            box-shadow: 0 2px 6px rgba(107, 13, 30, 0.05);
            box-sizing: border-box;
        }

        .inner-search input:hover {
            border-color: var(--border-hover);
            box-shadow: 0 4px 12px rgba(107, 13, 30, 0.08);
        }

        .inner-search input:focus {
            transform: translateY(-1px);
            border-color: var(--primary-maroon);
            box-shadow: 
                0 6px 16px rgba(107, 13, 30, 0.12),
                0 0 0 3px rgba(107, 13, 30, 0.1);
        }

        .inner-search input::placeholder {
            color: var(--muted-text);
            opacity: 0.7;
            font-size: 13px;
        }

        .filter-select {
            padding: 8px 35px 8px 15px;
            border: 2px solid var(--border-light);
            border-radius: var(--radius-md);
            background: white;
            color: var(--text-dark);
            font-size: 13px;
            font-family: 'Poppins', sans-serif;
            cursor: pointer;
            min-width: 80px;
            outline: none;
            font-weight: 500;
            transition: all var(--transition-base);
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='14' height='14' fill='%238a6d6d' viewBox='0 0 16 16'%3E%3Cpath d='M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 12px center;
            background-size: 10px;
            height: 38px;
            box-shadow: 0 2px 6px rgba(107, 13, 30, 0.05);
            box-sizing: border-box;
            flex: 0 0 auto;
            position: relative;
            z-index: 1;
        }

        .filter-select:hover {
            border-color: var(--primary-maroon);
            box-shadow: 0 4px 12px rgba(107, 13, 30, 0.1);
            transform: translateY(-1px);
        }

        .filter-select:focus {
            transform: translateY(0);
            border-color: var(--primary-maroon);
            box-shadow: 0 0 0 3px rgba(107, 13, 30, 0.15);
        }

        .filter-date {
            padding: 8px 12px;
            border: 2px solid var(--border-light);
            border-radius: var(--radius-md);
            background: white;
            color: var(--text-dark);
            font-size: 13px;
            font-family: 'Poppins', sans-serif;
            min-width: 120px;
            outline: none;
            font-weight: 500;
            transition: all var(--transition-base);
            height: 38px;
            box-shadow: 0 2px 6px rgba(107, 13, 30, 0.05);
            box-sizing: border-box;
            flex: 0 0 auto;
        }

        .filter-date:hover {
            border-color: var(--primary-maroon);
            box-shadow: 0 4px 12px rgba(107, 13, 30, 0.1);
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

        .custom-table {
            width: 100%;
            border-collapse: collapse;
            min-width: 100%;
            font-size: 13px;
        }

        .custom-table thead {
            background: white;
        }

        .custom-table th {
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

        .custom-table td {
            padding: 16px 10px;
            border-bottom: 1px solid var(--bg-lighter);
            font-size: 13px;
            color: maroon;  
            vertical-align: middle;
            text-align: center;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            height: 60px;
            position: relative;
            transition: all var(--transition-fast);
        }

        .custom-table tbody tr {
            transition: all var(--transition-base);
            position: relative;
            animation: tableRowFadeIn 0.5s ease-out;
            animation-fill-mode: both;
            border-left: 3px solid transparent;
        }

        .custom-table tbody tr:hover {
            background: linear-gradient(90deg, var(--bg-hover) 0%, white 100%);
            border-left: 3px solid var(--primary-maroon);
            transform: translateX(2px);
            box-shadow: 0 4px 12px rgba(107, 13, 30, 0.08);
        }

        .custom-table tbody tr:hover td {
            border-color: transparent;
        }

        .custom-table tbody tr:last-child td {
            border-bottom: none;
        }

        .transaction-id {
            color: var(--primary-maroon);
            font-weight: 700;
            font-size: 12px;
            font-family: 'Courier New', monospace;
            transition: all var(--transition-base);
            position: relative;
            display: inline-block;
            text-decoration: none;
        }

        .transaction-id:hover {
            color: var(--primary-maroon);
            animation: bounce 0.5s ease infinite alternate;
        }

        .transaction-id:hover::before {
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
            gap: 2px;
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

        .date-time {
            display: flex;
            flex-direction: column;
            gap: 2px;
            align-items: center;
        }

        .date-display {
            color: var(--text-dark);
            font-size: 13px;
            font-weight: 600;
            line-height: 1.2;
        }

        .time-display {
            color: var(--muted-text);
            font-size: 11px;
            font-weight: 500;
            line-height: 1.2;
        }

        .payment-badge {
            background: var(--bg-lighter);
            color: var(--text-dark);
            padding: 4px 12px;
            border-radius: var(--radius-sm);
            font-size: 11px;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 5px;
            border: 1px solid var(--border-light);
            transition: all var(--transition-fast);
            justify-content: center;
        }

        .payment-badge:hover {
            transform: translateY(-1px);
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .amount-display {
            font-weight: 700;
            font-size: 13px;
            color: var(--success-green);
        }

        .amount-display.failed {
            color: var(--danger-red);
        }

        .status-badge {
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

        .status-badge:hover {
            transform: translateY(-1px);
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .status-badge--paid {
            background: var(--success-green-light);
            color: var(--success-green);
            border-color: var(--success-green);
        }

        .status-badge--paid:hover {
            background: var(--success-green);
            color: white;
        }

        .status-badge--pending {
            background: var(--warning-orange-light);
            color: var(--warning-orange);
            border-color: var(--warning-orange);
        }

        .status-badge--pending:hover {
            background: var(--warning-orange);
            color: white;
        }

        .status-badge--failed {
            background: var(--danger-red-light);
            color: var(--danger-red);
            border-color: var(--danger-red);
        }

        .status-badge--failed:hover {
            background: var(--danger-red);
            color: white;
        }

        .action-btns {
            display: flex;
            gap: 6px;
            align-items: center;
            justify-content: center;
        }

        .action-icon {
            width: 26px;
            height: 26px;
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

        .action-icon.refund:hover {
            background: var(--warning-orange);
            color: white;
        }

        .action-icon.download:hover {
            background: var(--success-green);
            color: white;
        }

        .action-icon[title]:hover::after {
            content: attr(title);
            position: absolute;
            bottom: -30px;
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

        .bulk-actions {
            display: none;
            align-items: center;
            gap: 10px;
            margin-bottom: 20px;
            padding: 12px 20px;
            background: white;
            border-radius: var(--radius-md);
            box-shadow: var(--card-shadow);
            animation: fadeIn 0.3s ease;
        }

        .bulk-actions.show {
            display: flex;
        }

        .bulk-actions span {
            font-size: 13px;
            font-weight: 600;
            color: var(--text-dark);
        }

        .bulk-select {
            padding: 6px 12px;
            border: 2px solid var(--border-light);
            border-radius: var(--radius-sm);
            background: white;
            color: var(--text-dark);
            font-size: 12px;
            font-family: 'Poppins', sans-serif;
            cursor: pointer;
            outline: none;
            transition: all var(--transition-base);
        }

        .bulk-select:hover {
            border-color: var(--primary-maroon);
        }

        .btn {
            padding: 8px 16px;
            border-radius: var(--radius-md);
            font-weight: 600;
            font-size: 13px;
            cursor: pointer;
            transition: all var(--transition-base);
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 6px;
            border: 2px solid transparent;
            font-family: 'Poppins', sans-serif;
            text-decoration: none;
            white-space: nowrap;
            min-height: 36px;
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

        .btn--secondary {
            background: var(--accent-yellow);
            color: var(--text-dark);
            box-shadow: 0 4px 12px rgba(255, 204, 0, 0.2);
        }

        .btn--secondary:hover {
            background: var(--accent-yellow-dark);
            transform: translateY(-3px);
            box-shadow: 0 6px 18px rgba(255, 204, 0, 0.3);
        }

        .btn--primary {
            background: var(--primary-maroon);
            color: white;
            box-shadow: var(--button-shadow);
        }

        .btn--primary:hover {
            background: var(--primary-maroon-dark);
            transform: translateY(-3px);
            box-shadow: 
                0 8px 20px rgba(107, 13, 30, 0.25),
                0 0 0 1px rgba(107, 13, 30, 0.1);
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

        .btn--danger {
            background: var(--danger-red);
            color: white;
            box-shadow: 0 4px 12px rgba(185, 28, 28, 0.2);
        }

        .btn--danger:hover {
            background: #991b1b;
            transform: translateY(-3px);
            box-shadow: 0 6px 18px rgba(185, 28, 28, 0.3);
        }

        .no-results {
            text-align: center;
            padding: 40px;
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

        .inner-search.loading i {
            animation: spin 1s linear infinite;
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
            display: none;
        }

        .transaction-modal {
            background: white;
            border-radius: var(--radius-xl);
            max-width: 800px;
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

        .modal-header h3 .transaction-id {
            background: rgba(255,255,255,0.2);
            padding: 4px 12px;
            border-radius: var(--radius-sm);
            font-size: 14px;
            font-weight: 500;
            color: white;
            font-family: 'Poppins', sans-serif;
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

        .transaction-info-grid {
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

        .info-value.status-paid {
            background: var(--success-green-light);
            color: var(--success-green);
        }

        .info-value.status-pending {
            background: var(--warning-orange-light);
            color: var(--warning-orange);
        }

        .info-value.status-failed {
            background: var(--danger-red-light);
            color: var(--danger-red);
        }

        .payment-details {
            background: white;
            border-radius: var(--radius-lg);
            padding: 25px;
            border: 1px solid var(--border-light);
        }

        .details-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
            margin-top: 15px;
        }

        .detail-stat {
            text-align: center;
            padding: 20px;
            background: var(--soft-cream);
            border-radius: var(--radius-md);
            transition: all var(--transition-base);
        }

        .detail-stat:hover {
            transform: translateY(-5px);
            box-shadow: var(--card-shadow);
        }

        .detail-stat__value {
            font-size: 28px;
            font-weight: 700;
            color: var(--primary-maroon);
            margin-bottom: 5px;
        }

        .detail-stat__label {
            color: var(--muted-text);
            font-size: 12px;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .modal-footer {
            padding: 20px 30px;
            border-top: 1px solid var(--border-light);
            display: flex;
            justify-content: flex-end;
            gap: 12px;
            background: var(--soft-cream);
            border-radius: 0 0 var(--radius-xl) var(--radius-xl);
        }

        .refund-modal {
            background: white;
            border-radius: var(--radius-xl);
            max-width: 400px;
            width: 90%;
            padding: 30px;
            text-align: center;
            animation: slideUp 0.4s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .refund-modal i {
            font-size: 48px;
            color: var(--warning-orange);
            margin-bottom: 20px;
        }

        .refund-modal h3 {
            color: var(--text-dark);
            margin-top: 0;
            margin-bottom: 15px;
        }

        .refund-modal p {
            color: var(--muted-text);
            margin-bottom: 25px;
            font-size: 14px;
        }

        .refund-actions {
            display: flex;
            gap: 10px;
            justify-content: center;
        }

        .refund-actions .btn {
            min-width: 100px;
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
            to { width: 100%; }
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

        @media (max-width: 1400px) {
            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 1200px) {
            #transactions-wrapper {
                padding: 15px 20px;
            }
            
            .filter-container {
                flex-wrap: wrap;
                gap: 8px;
            }
            
            .inner-search {
                min-width: calc(100% - 10px);
                margin-bottom: 0;
            }
            
            .filter-select {
                min-width: calc(50% - 6px);
            }
            
            .custom-table {
                font-size: 12px;
            }
            
            .custom-table th {
                font-size: 10px;
                padding: 14px 8px;
            }
            
            .custom-table td {
                font-size: 12px;
                padding: 14px 8px;
            }

            .transaction-info-grid {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 992px) {
            .page-header {
                flex-direction: column;
                align-items: stretch;
                gap: 15px;
                margin-bottom: 20px;
            }
            
            .header-title h2 {
                font-size: 24px;
            }
            
            .header-actions {
                justify-content: flex-start;
                width: 100%;
            }
            
            .btn {
                width: 100%;
                justify-content: center;
            }
            
            .export-buttons {
                justify-content: flex-start;
                width: 100%;
            }
        }

        @media (max-width: 768px) {
            .stats-grid {
                grid-template-columns: 1fr;
            }
            
            .filter-container {
                flex-direction: column;
                width: 100%;
            }
            
            .inner-search {
                min-width: 100%;
                margin-bottom: 8px;
            }
            
            .filter-select {
                width: 100%;
                min-width: auto;
            }
            
            .table-container {
                border-radius: var(--radius-md);
            }
            
            .custom-table th,
            .custom-table td {
                padding: 12px 6px;
                font-size: 11px;
            }
            
            .action-btns {
                flex-wrap: wrap;
                justify-content: center;
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

            .details-grid {
                grid-template-columns: 1fr;
            }

            .refund-modal {
                padding: 20px;
            }
            
            .bulk-actions {
                flex-direction: column;
                align-items: stretch;
                gap: 10px;
            }
            
            .export-buttons {
                flex-direction: column;
                width: 100%;
            }
            
            .export-btn {
                width: 100%;
                justify-content: center;
            }
        }

        @media (max-width: 480px) {
            #transactions-wrapper {
                padding: 12px 15px;
            }
            
            .header-title h2 {
                font-size: 20px;
            }
            
            .header-title p {
                font-size: 13px;
            }
            
            .stat-card {
                padding: 15px;
            }

            .stat-card__value { 
                font-size: 22px;
            }
            
            .btn {
                padding: 6px 12px;
                font-size: 12px;
                min-height: 32px;
            }

            .modal-header h3 {
                font-size: 18px;
                flex-direction: column;
                align-items: flex-start;
                gap: 8px;
            }

            .modal-footer {
                flex-direction: column;
            }

            .modal-footer .btn {
                width: 100%;
            }

            .refund-actions {
                flex-direction: column;
            }

            .refund-actions .btn {
                width: 100%;
            }
            
            .export-buttons {
                gap: 10px;
            }
            
            .export-btn {
                padding: 8px 15px;
                font-size: 13px;
            }
            
            .export-btn .btn-icon {
                font-size: 14px;
            }
        }
    </style>

    <div id="transactions-wrapper">
        <div class="page-header">
            <div class="header-title">
                <h2>Transactions Management</h2>
                <p>Track and monitor all payment transactions</p>
            </div>
            <div class="header-actions">
                <div class="export-buttons">
                    <button type="button" class="export-btn pdf" onclick="exportToPDF()">
                        <i class="fas fa-file-pdf btn-icon"></i>
                        Export PDF
                    </button>
                    <button type="button" class="export-btn excel" onclick="exportToExcel()">
                        <i class="fas fa-file-excel btn-icon"></i>
                        Export Excel
                    </button>
                </div>
            </div>
        </div>

        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-card__header">
                    <span class="stat-card__label">Total Transactions</span>
                    <div class="stat-card__icon stat-card__icon--total">
                        <i class="fas fa-receipt"></i>
                    </div>
                </div>
                <div class="stat-card__value" id="totalTransactions">5</div>
                <div class="stat-card__trend">All transactions</div>
            </div>

            <div class="stat-card">
                <div class="stat-card__header">
                    <span class="stat-card__label">Paid Transactions</span>
                    <div class="stat-card__icon stat-card__icon--paid">
                        <i class="fas fa-check-circle"></i>
                    </div>
                </div>
                <div class="stat-card__value" id="paidTransactions">4</div>
                <div class="stat-card__trend">Successfully paid</div>
            </div>

            <div class="stat-card">
                <div class="stat-card__header">
                    <span class="stat-card__label">Pending</span>
                    <div class="stat-card__icon stat-card__icon--pending">
                        <i class="fas fa-clock"></i>
                    </div>
                </div>
                <div class="stat-card__value" id="pendingTransactions">1</div>
                <div class="stat-card__trend">Awaiting payment</div>
            </div>

            <div class="stat-card">
                <div class="stat-card__header">
                    <span class="stat-card__label">Total Revenue</span>
                    <div class="stat-card__icon stat-card__icon--revenue">
                        <i class="fas fa-peso-sign"></i>
                    </div>
                </div>
                <div class="stat-card__value revenue" id="totalRevenue">₱1,270</div>
                <div class="stat-card__trend">Total income</div>
            </div>
        </div>

        <div class="bulk-actions" id="bulkActionsPanel">
            <span id="selectedCount">0 transactions selected</span>
            <select class="bulk-select" id="bulkActionSelect">
                <option value="">Bulk Actions</option>
                <option value="mark_paid">Mark as Paid</option>
                <option value="mark_pending">Mark as Pending</option>
                <option value="mark_failed">Mark as Failed</option>
                <option value="delete">Delete Selected</option>
            </select>
            <button type="button" class="btn btn--primary" id="applyBulkAction" style="padding: 6px 12px; font-size: 12px;">
                Apply
            </button>
            <button type="button" class="btn btn--outline" id="clearSelection" style="padding: 6px 12px; font-size: 12px;">
                Clear All
            </button>
        </div>

        <div class="filter-container">
            <div class="inner-search" id="searchBox">
                <i class="fas fa-search"></i>
                <input type="text" id="searchInput" placeholder="Search by transaction ID, customer, or order ID...">
            </div>
            <select class="filter-select" id="statusFilter">
                <option value="all">All Status</option>
                <option value="paid">Paid</option>
                <option value="pending">Pending</option>
                <option value="failed">Failed</option>
            </select>
            <select class="filter-select" id="methodFilter">
                <option value="all">All Methods</option>
                <option value="gcash">GCash</option>
                <option value="cash">Cash on Delivery</option>
                <option value="card">Credit Card</option>
                <option value="paymaya">PayMaya</option>
                <option value="bank">Bank Transfer</option>
            </select>
            <input type="date" class="filter-date" id="dateFilter">
        </div>

        <div class="table-container">
            <div class="table-wrapper">
                <table class="custom-table">
                    <thead>
                        <tr>
                            <th style="width: 50px;">
                                <input type="checkbox" class="chubby-checkbox" id="selectAllCheckbox">
                            </th>
                            <th>Transaction ID</th>
                            <th>Order ID</th>
                            <th>Customer</th>
                            <th>Payment Method</th>
                            <th>Date & Time</th>
                            <th>Amount</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody id="transactionsTableBody">
                    </tbody>
                </table>
                <div class="no-results" id="noResultsMessage">
                    <i class="fas fa-search"></i>
                    <h3>No transactions found</h3>
                    <p>Try adjusting your search or filters</p>
                </div>
            </div>
        </div>
    </div>

    <div id="transactionModal" class="modal-overlay">
        <div class="transaction-modal">
            <div class="modal-header">
                <h3>
                    <i class="fas fa-receipt"></i>
                    Transaction Details
                    <span class="transaction-id" id="modalTransactionId">TXN-000000</span>
                </h3>
                <button class="close-modal" onclick="closeModal()">
                    <i class="fas fa-times"></i>
                </button>
            </div>
            <div class="modal-body">
                <div class="transaction-info-grid">
                    <div class="info-section">
                        <h4><i class="fas fa-user"></i> Customer Information</h4>
                        <div class="info-row">
                            <span class="info-label">Customer Name:</span>
                            <span class="info-value" id="modalCustomerName">Loading...</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Order ID:</span>
                            <span class="info-value" id="modalOrderId">Loading...</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Date & Time:</span>
                            <span class="info-value" id="modalDateTime">Loading...</span>
                        </div>
                    </div>
                    
                    <div class="info-section">
                        <h4><i class="fas fa-credit-card"></i> Payment Information</h4>
                        <div class="info-row">
                            <span class="info-label">Transaction ID:</span>
                            <span class="info-value" id="modalTransactionId2">Loading...</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Payment Method:</span>
                            <span class="info-value" id="modalPaymentMethod">Loading...</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Status:</span>
                            <span class="info-value status" id="modalStatus">Loading</span>
                        </div>
                    </div>
                </div>

                <div class="payment-details">
                    <h4><i class="fas fa-money-bill-wave"></i> Payment Details</h4>
                    <div class="details-grid">
                        <div class="detail-stat">
                            <div class="detail-stat__value" id="modalAmount">₱0</div>
                            <div class="detail-stat__label">Amount</div>
                        </div>
                        <div class="detail-stat">
                            <div class="detail-stat__value" id="modalFees">₱0</div>
                            <div class="detail-stat__label">Service Fees</div>
                        </div>
                        <div class="detail-stat">
                            <div class="detail-stat__value" id="modalTotal">₱0</div>
                            <div class="detail-stat__label">Total Paid</div>
                        </div>
                        <div class="detail-stat">
                            <div class="detail-stat__value" id="modalReference">-</div>
                            <div class="detail-stat__label">Reference No.</div>
                        </div>
                    </div>
                </div>

                <div class="payment-details" style="margin-top: 20px;">
                    <h4><i class="fas fa-history"></i> Transaction Timeline</h4>
                    <div id="transactionTimeline">
                        <p style="text-align: center; color: var(--muted-text); padding: 20px;">
                            Loading transaction history...
                        </p>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn--outline" onclick="closeModal()">
                    <i class="fas fa-times"></i> Close
                </button>
                <button class="btn btn--primary" id="modalActionButton" onclick="printReceipt()">
                    <i class="fas fa-print"></i> Print Receipt
                </button>
            </div>
        </div>
    </div>

    <div id="refundModal" class="modal-overlay" style="display: none;">
        <div class="refund-modal">
            <i class="fas fa-undo"></i>
            <h3>Process Refund</h3>
            <p id="refundConfirmationText">Are you sure you want to process a refund for this transaction?</p>
            <p style="color: var(--muted-text); font-size: 12px; margin-top: -10px;">This action will refund the payment to the customer.</p>
            <div class="refund-actions">
                <button id="confirmRefund" class="btn btn--primary" style="background: var(--warning-orange);">
                    Process Refund
                </button>
                <button id="cancelRefund" class="btn btn--outline">
                    Cancel
                </button>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        let allTransactions = [
            {
                TxnID: "TXN-001234",
                OrderID: "ORD-5678",
                Customer: "Jay-r Casano",
                Method: "GCash",
                Date: "2024-01-08T14:23:15",
                Amount: 435,
                Status: "Paid",
                MethodIcon: "fa-mobile-alt"
            },
            {
                TxnID: "TXN-001235",
                OrderID: "ORD-5679",
                Customer: "George Gonzaga",
                Method: "Cash on Delivery",
                Date: "2024-01-08T13:45:22",
                Amount: 280,
                Status: "Paid",
                MethodIcon: "fa-hand-holding-usd"
            },
            {
                TxnID: "TXN-001236",
                OrderID: "ORD-5680",
                Customer: "Zea Mae Sulit",
                Method: "GCash",
                Date: "2024-01-08T13:12:45",
                Amount: 520,
                Status: "Pending",
                MethodIcon: "fa-mobile-alt"
            },
            {
                TxnID: "TXN-001237",
                OrderID: "ORD-5681",
                Customer: "Lalaine Reyes",
                Method: "PayMaya",
                Date: "2024-01-08T12:34:18",
                Amount: 195,
                Status: "Paid",
                MethodIcon: "fa-wallet"
            },
            {
                TxnID: "TXN-001238",
                OrderID: "ORD-5682",
                Customer: "Bryle Andre Magallano",
                Method: "Cash on Delivery",
                Date: "2024-01-08T11:56:33",
                Amount: 360,
                Status: "Paid",
                MethodIcon: "fa-hand-holding-usd"
            }
        ];

        let currentTransactionId = null;
        let transactionToRefund = null;
        let selectedTransactions = new Set();

        function initializeTransactionTable() {
            const tbody = document.getElementById('transactionsTableBody');
            tbody.innerHTML = '';

            allTransactions.forEach(transaction => {
                const row = createTransactionRow(transaction);
                tbody.appendChild(row);
            });

            updateTransactionStats();
            setupEventListeners();
            setupBulkActionListeners();
        }

        function createTransactionRow(transaction) {
            const row = document.createElement('tr');
            row.setAttribute('data-txn-id', transaction.TxnID);
            row.setAttribute('data-status', transaction.Status.toLowerCase());

            const methodNormalized = transaction.Method.toLowerCase().replace(/ /g, '');
            row.setAttribute('data-method', methodNormalized);

            row.setAttribute('data-date', transaction.Date.split('T')[0]);
            row.setAttribute('data-amount', transaction.Amount);

            const formattedDate = new Date(transaction.Date);
            const dateStr = formattedDate.toLocaleDateString('en-US', {
                year: 'numeric',
                month: 'short',
                day: 'numeric'
            });
            const timeStr = formattedDate.toLocaleTimeString('en-US', {
                hour12: false,
                hour: '2-digit',
                minute: '2-digit',
                second: '2-digit'
            });

            const statusClass = transaction.Status.toLowerCase();

            row.innerHTML = `
                <td>
                    <input type="checkbox" class="chubby-checkbox row-checkbox" data-txn-id="${transaction.TxnID}">
                </td>
                <td>
                    <a href="javascript:void(0)" class="transaction-id" onclick="viewTransaction('${transaction.TxnID}')">
                        ${transaction.TxnID}
                    </a>
                </td>
                <td>${transaction.OrderID}</td>
                <td>
                    <div class="customer-info">
                        <span class="customer-name">${transaction.Customer}</span>
                    </div>
                </td>
                <td>
                    <span class="payment-badge">
                        <i class="fa ${transaction.MethodIcon}"></i>
                        ${transaction.Method}
                    </span>
                </td>
                <td>
                    <div class="date-time">
                        <span class="date-display">${dateStr}</span>
                        <span class="time-display">${timeStr}</span>
                    </div>
                </td>
                <td class="amount-display ${transaction.Status === 'Failed' ? 'failed' : ''}">
                    ₱${transaction.Amount.toLocaleString()}
                </td>
                <td>
                    <span class="status-badge status-badge--${statusClass}">
                        ${transaction.Status}
                    </span>
                </td>
                <td>
                    <div class="action-btns">
                        <button type="button" class="action-icon view" title="View Details" onclick="viewTransaction('${transaction.TxnID}')">
                            <i class="fas fa-eye"></i>
                        </button>
                    </div>
                </td>
            `;

            return row;
        }

        function setupBulkActionListeners() {
            const selectAllCheckbox = document.getElementById('selectAllCheckbox');
            const bulkActionsPanel = document.getElementById('bulkActionsPanel');
            const selectedCount = document.getElementById('selectedCount');
            const applyBulkAction = document.getElementById('applyBulkAction');
            const clearSelection = document.getElementById('clearSelection');
            const bulkActionSelect = document.getElementById('bulkActionSelect');

            selectAllCheckbox.addEventListener('change', function () {
                const rowCheckboxes = document.querySelectorAll('.row-checkbox');
                const visibleRows = Array.from(rowCheckboxes).filter(cb => {
                    const row = cb.closest('tr');
                    return row && row.style.display !== 'none';
                });

                if (this.checked) {
                    visibleRows.forEach(cb => {
                        cb.checked = true;
                        cb.style.transform = 'scale(1.1)';
                        selectedTransactions.add(cb.dataset.txnId);
                    });
                } else {
                    rowCheckboxes.forEach(cb => {
                        cb.checked = false;
                        cb.style.transform = 'scale(1)';
                        selectedTransactions.delete(cb.dataset.txnId);
                    });
                }

                updateSelectedCount();
            });

            document.addEventListener('change', function (e) {
                if (e.target.classList.contains('row-checkbox')) {
                    const txnId = e.target.dataset.txnId;
                    if (e.target.checked) {
                        selectedTransactions.add(txnId);
                        e.target.style.transform = 'scale(1.1)';
                    } else {
                        selectedTransactions.delete(txnId);
                        e.target.style.transform = 'scale(1)';
                        selectAllCheckbox.checked = false;
                    }
                    updateSelectedCount();
                }
            });

            clearSelection.addEventListener('click', function () {
                selectedTransactions.clear();
                const rowCheckboxes = document.querySelectorAll('.row-checkbox');
                rowCheckboxes.forEach(cb => {
                    cb.checked = false;
                    cb.style.transform = 'scale(1)';
                });
                selectAllCheckbox.checked = false;
                updateSelectedCount();
            });

            applyBulkAction.addEventListener('click', function () {
                const action = bulkActionSelect.value;
                if (!action) {
                    showNotification('Please select a bulk action first.', 'warning');
                    return;
                }

                if (selectedTransactions.size === 0) {
                    showNotification('No transactions selected.', 'warning');
                    return;
                }

                switch (action) {
                    case 'mark_paid':
                        updateSelectedTransactionsStatus('Paid');
                        break;
                    case 'mark_pending':
                        updateSelectedTransactionsStatus('Pending');
                        break;
                    case 'mark_failed':
                        updateSelectedTransactionsStatus('Failed');
                        break;
                    case 'delete':
                        deleteSelectedTransactions();
                        break;
                }

                bulkActionSelect.value = '';
            });
        }

        function updateSelectedCount() {
            const selectedCount = document.getElementById('selectedCount');
            const bulkActionsPanel = document.getElementById('bulkActionsPanel');

            selectedCount.textContent = `${selectedTransactions.size} transaction${selectedTransactions.size !== 1 ? 's' : ''} selected`;

            if (selectedTransactions.size > 0) {
                bulkActionsPanel.classList.add('show');
            } else {
                bulkActionsPanel.classList.remove('show');
            }
        }

        function updateSelectedTransactionsStatus(newStatus) {
            selectedTransactions.forEach(txnId => {
                const transaction = allTransactions.find(t => t.TxnID === txnId);
                if (transaction) {
                    transaction.Status = newStatus;

                    const row = document.querySelector(`tr[data-txn-id="${txnId}"]`);
                    if (row) {
                        row.setAttribute('data-status', newStatus.toLowerCase());
                        const statusBadge = row.querySelector('.status-badge');
                        if (statusBadge) {
                            statusBadge.textContent = newStatus;
                            statusBadge.className = `status-badge status-badge--${newStatus.toLowerCase()}`;
                        }

                        const amountCell = row.querySelector('.amount-display');
                        if (amountCell) {
                            if (newStatus === 'Failed') {
                                amountCell.classList.add('failed');
                            } else {
                                amountCell.classList.remove('failed');
                            }
                        }

                        const actionBtns = row.querySelector('.action-btns');
                        if (actionBtns) {
                            const refundButton = actionBtns.querySelector('.action-icon.refund');
                            if (refundButton) {
                                refundButton.remove();
                            }
                        }
                    }
                }
            });

            updateTransactionStats();
            showNotification(`Updated ${selectedTransactions.size} transaction${selectedTransactions.size !== 1 ? 's' : ''} to ${newStatus}`, 'success');
            selectedTransactions.clear();
            updateSelectedCount();
            document.getElementById('selectAllCheckbox').checked = false;
        }

        function deleteSelectedTransactions() {
            if (confirm(`Are you sure you want to delete ${selectedTransactions.size} transaction${selectedTransactions.size !== 1 ? 's' : ''}? This action cannot be undone.`)) {
                allTransactions = allTransactions.filter(t => !selectedTransactions.has(t.TxnID));

                selectedTransactions.forEach(txnId => {
                    const row = document.querySelector(`tr[data-txn-id="${txnId}"]`);
                    if (row) {
                        row.remove();
                    }
                });

                showNotification(`Deleted ${selectedTransactions.size} transaction${selectedTransactions.size !== 1 ? 's' : ''}`, 'success');
                selectedTransactions.clear();
                updateSelectedCount();
                updateTransactionStats();
                document.getElementById('selectAllCheckbox').checked = false;
            }
        }

        function updateTransactionStats() {
            const totalTransactions = allTransactions.length;
            const paidTransactions = allTransactions.filter(t => t.Status === 'Paid').length;
            const pendingTransactions = allTransactions.filter(t => t.Status === 'Pending').length;
            const totalRevenue = allTransactions
                .filter(t => t.Status === 'Paid')
                .reduce((sum, t) => sum + t.Amount, 0);

            document.getElementById('totalTransactions').textContent = totalTransactions;
            document.getElementById('paidTransactions').textContent = paidTransactions;
            document.getElementById('pendingTransactions').textContent = pendingTransactions;
            document.getElementById('totalRevenue').textContent = '₱' + totalRevenue.toLocaleString();
        }

        function setupEventListeners() {
            const searchInput = document.getElementById('searchInput');
            searchInput.addEventListener('input', handleSearch);

            const statusFilter = document.getElementById('statusFilter');
            statusFilter.addEventListener('change', handleFilter);

            const methodFilter = document.getElementById('methodFilter');
            methodFilter.addEventListener('change', handleFilter);

            const dateFilter = document.getElementById('dateFilter');
            dateFilter.addEventListener('change', handleFilter);
        }

        let searchTimeout;
        function handleSearch() {
            clearTimeout(searchTimeout);

            const searchBox = document.getElementById('searchBox');
            const searchInput = document.getElementById('searchInput');
            const searchTerm = searchInput.value.toLowerCase().trim();

            searchBox.classList.add('loading');

            searchTimeout = setTimeout(() => {
                applyFilters();
                searchBox.classList.remove('loading');
            }, 300);
        }

        function handleFilter() {
            applyFilters();
        }

        function applyFilters() {
            const searchInput = document.getElementById('searchInput');
            const searchTerm = searchInput.value.toLowerCase().trim();

            const statusFilter = document.getElementById('statusFilter');
            const methodFilter = document.getElementById('methodFilter');
            const dateFilter = document.getElementById('dateFilter');

            const selectedStatus = statusFilter.value;
            const selectedMethod = methodFilter.value;
            const selectedDate = dateFilter.value;

            let hasVisibleRows = false;
            allTransactions.forEach(transaction => {
                const row = document.querySelector(`tr[data-txn-id="${transaction.TxnID}"]`);
                if (!row) return;

                const searchMatches = searchTerm === '' ||
                    transaction.TxnID.toLowerCase().includes(searchTerm) ||
                    transaction.OrderID.toLowerCase().includes(searchTerm) ||
                    transaction.Customer.toLowerCase().includes(searchTerm);

                const statusMatch = selectedStatus === 'all' || transaction.Status.toLowerCase() === selectedStatus;

                let methodMatch = true;
                if (selectedMethod !== 'all') {
                    const transactionMethod = transaction.Method.toLowerCase().replace(/ /g, '');
                    const selectedMethodNormalized = selectedMethod.toLowerCase().replace(/ /g, '');

                    if (selectedMethodNormalized === 'cash') {
                        methodMatch = transactionMethod.includes('cash') && transactionMethod.includes('delivery');
                    } else if (selectedMethodNormalized === 'card') {
                        methodMatch = transactionMethod.includes('credit') && transactionMethod.includes('card');
                    } else {
                        methodMatch = transactionMethod.includes(selectedMethodNormalized);
                    }
                }

                const dateMatch = selectedDate === '' || transaction.Date.split('T')[0] === selectedDate;

                const shouldShow = searchMatches && statusMatch && methodMatch && dateMatch;

                row.style.display = shouldShow ? '' : 'none';
                if (shouldShow) hasVisibleRows = true;
            });

            const noResultsMessage = document.getElementById('noResultsMessage');
            if (!hasVisibleRows) {
                noResultsMessage.style.display = 'block';
            } else {
                noResultsMessage.style.display = 'none';
            }

            updateFilteredTransactionStats();
        }

        function updateFilteredTransactionStats() {
            const searchInput = document.getElementById('searchInput');
            const searchTerm = searchInput.value.toLowerCase().trim();
            const statusFilter = document.getElementById('statusFilter');
            const methodFilter = document.getElementById('methodFilter');
            const dateFilter = document.getElementById('dateFilter');

            const selectedStatus = statusFilter.value;
            const selectedMethod = methodFilter.value;
            const selectedDate = dateFilter.value;

            const filteredTransactions = allTransactions.filter(transaction => {
                const searchMatches = searchTerm === '' ||
                    transaction.TxnID.toLowerCase().includes(searchTerm) ||
                    transaction.OrderID.toLowerCase().includes(searchTerm) ||
                    transaction.Customer.toLowerCase().includes(searchTerm);

                const statusMatch = selectedStatus === 'all' || transaction.Status.toLowerCase() === selectedStatus;

                let methodMatch = true;
                if (selectedMethod !== 'all') {
                    const transactionMethod = transaction.Method.toLowerCase().replace(/ /g, '');
                    const selectedMethodNormalized = selectedMethod.toLowerCase().replace(/ /g, '');

                    if (selectedMethodNormalized === 'cash') {
                        methodMatch = transactionMethod.includes('cash') && transactionMethod.includes('delivery');
                    } else if (selectedMethodNormalized === 'card') {
                        methodMatch = transactionMethod.includes('credit') && transactionMethod.includes('card');
                    } else {
                        methodMatch = transactionMethod.includes(selectedMethodNormalized);
                    }
                }

                const dateMatch = selectedDate === '' || transaction.Date.split('T')[0] === selectedDate;

                return searchMatches && statusMatch && methodMatch && dateMatch;
            });

            const paidTransactions = filteredTransactions.filter(t => t.Status === 'Paid').length;
            const pendingTransactions = filteredTransactions.filter(t => t.Status === 'Pending').length;
            const totalRevenue = filteredTransactions
                .filter(t => t.Status === 'Paid')
                .reduce((sum, t) => sum + t.Amount, 0);

            document.getElementById('totalTransactions').textContent = filteredTransactions.length;
            document.getElementById('paidTransactions').textContent = paidTransactions;
            document.getElementById('pendingTransactions').textContent = pendingTransactions;
            document.getElementById('totalRevenue').textContent = '₱' + totalRevenue.toLocaleString();
        }

        function viewTransaction(txnId) {
            currentTransactionId = txnId;

            const transaction = allTransactions.find(t => t.TxnID === txnId);
            if (!transaction) {
                alert('Transaction not found!');
                return;
            }

            document.getElementById('modalTransactionId').textContent = transaction.TxnID;
            document.getElementById('modalTransactionId2').textContent = transaction.TxnID;
            document.getElementById('modalCustomerName').textContent = transaction.Customer;
            document.getElementById('modalOrderId').textContent = transaction.OrderID;

            const formattedDate = new Date(transaction.Date);
            const dateStr = formattedDate.toLocaleDateString('en-US', {
                year: 'numeric',
                month: 'short',
                day: 'numeric'
            });
            const timeStr = formattedDate.toLocaleTimeString('en-US', {
                hour12: false,
                hour: '2-digit',
                minute: '2-digit',
                second: '2-digit'
            });

            document.getElementById('modalDateTime').textContent = dateStr + ' ' + timeStr;
            document.getElementById('modalPaymentMethod').textContent = transaction.Method;

            document.getElementById('modalAmount').textContent = '₱' + transaction.Amount.toLocaleString();
            document.getElementById('modalFees').textContent = '₱' + (transaction.Amount * 0.02).toFixed(2);
            document.getElementById('modalTotal').textContent = '₱' + (transaction.Amount * 1.02).toFixed(2);
            document.getElementById('modalReference').textContent = 'REF-' + transaction.TxnID.replace('TXN-', '');

            const statusElement = document.getElementById('modalStatus');
            statusElement.textContent = transaction.Status;
            statusElement.className = 'info-value status ' +
                (transaction.Status === 'Paid' ? 'status-paid' :
                    transaction.Status === 'Pending' ? 'status-pending' : 'status-failed');

            loadTransactionTimeline(transaction);

            const modal = document.getElementById('transactionModal');
            modal.style.display = 'flex';
            document.body.style.overflow = 'hidden';

            document.addEventListener('keydown', handleModalKeydown);
        }

        function closeModal() {
            const modal = document.getElementById('transactionModal');
            const refundModal = document.getElementById('refundModal');
            modal.style.display = 'none';
            refundModal.style.display = 'none';
            document.body.style.overflow = 'auto';
            document.removeEventListener('keydown', handleModalKeydown);
            transactionToRefund = null;
        }

        function handleModalKeydown(e) {
            if (e.key === 'Escape') {
                closeModal();
            }
        }

        function processRefund(txnId) {
            transactionToRefund = txnId;
            const transaction = allTransactions.find(t => t.TxnID === txnId);

            if (!transaction) return;

            document.getElementById('refundConfirmationText').textContent =
                `Are you sure you want to process a refund of ₱${transaction.Amount.toLocaleString()} for transaction ${transaction.TxnID}?`;

            const modal = document.getElementById('refundModal');
            modal.style.display = 'flex';
            document.body.style.overflow = 'hidden';

            document.getElementById('confirmRefund').onclick = confirmRefund;
            document.getElementById('cancelRefund').onclick = closeModal;

            document.addEventListener('keydown', handleRefundModalKeydown);
        }

        function handleRefundModalKeydown(e) {
            if (e.key === 'Escape') {
                closeModal();
            }
        }

        function confirmRefund() {
            if (!transactionToRefund) return;

            const transaction = allTransactions.find(t => t.TxnID === transactionToRefund);
            if (!transaction) return;

            transaction.Status = 'Paid';

            const row = document.querySelector(`tr[data-txn-id="${transaction.TxnID}"]`);
            if (row) {
                row.setAttribute('data-status', 'paid');
                const statusBadge = row.querySelector('.status-badge');
                if (statusBadge) {
                    statusBadge.textContent = 'Paid';
                    statusBadge.className = 'status-badge status-badge--paid';
                }

                const amountCell = row.querySelector('.amount-display');
                if (amountCell && amountCell.classList.contains('failed')) {
                    amountCell.classList.remove('failed');
                }

                const refundButton = row.querySelector('.action-icon.refund');
                if (refundButton) {
                    refundButton.remove();
                }
            }

            updateTransactionStats();

            showNotification('Refund processed successfully!', 'success');
            closeModal();
        }

        function downloadReceipt(txnId) {
            const transaction = allTransactions.find(t => t.TxnID === txnId);
            if (!transaction) return;

            showNotification('Downloading receipt for ' + txnId, 'success');
        }

        function printReceipt() {
            if (!currentTransactionId) return;
            showNotification('Printing receipt...', 'success');
        }

        function loadTransactionTimeline(transaction) {
            const timelineDiv = document.getElementById('transactionTimeline');

            const timelineEvents = [
                { time: transaction.Date.split('T')[0], event: 'Transaction created', status: 'Created' },
                { time: transaction.Date.split('T')[0], event: 'Payment initiated', status: 'Processing' },
                { time: transaction.Date.split('T')[0], event: transaction.Status === 'Failed' ? 'Payment failed' : 'Payment completed', status: transaction.Status === 'Failed' ? 'Failed' : 'Completed' }
            ];

            let html = '<div style="padding: 15px;">';
            html += '<div style="position: relative; padding-left: 20px;">';

            timelineEvents.forEach((event, index) => {
                const isLast = index === timelineEvents.length - 1;
                const dotColor = event.status === 'Failed' ? 'var(--danger-red)' :
                    event.status === 'Completed' ? 'var(--success-green)' : 'var(--warning-orange)';

                html += '<div style="position: relative; margin-bottom: 20px;">';
                html += '<div style="position: absolute; left: -20px; top: 5px; width: 10px; height: 10px; border-radius: 50%; background: ' + dotColor + ';"></div>';
                if (!isLast) {
                    html += '<div style="position: absolute; left: -16px; top: 15px; width: 2px; height: 30px; background: var(--border-light);"></div>';
                }
                html += '<div style="font-weight: 600; color: var(--text-dark); font-size: 13px;">' + event.event + '</div>';
                html += '<div style="color: var(--muted-text); font-size: 11px; margin-top: 2px;">' + event.time + '</div>';
                html += '<div style="color: ' + dotColor + '; font-size: 10px; font-weight: 700; text-transform: uppercase; margin-top: 2px;">' + event.status + '</div>';
                html += '</div>';
            });

            html += '</div></div>';
            timelineDiv.innerHTML = html;
        }

        function showNotification(message, type) {
            const notification = document.createElement('div');
            notification.style.cssText = `
                position: fixed;
                top: 20px;
                right: 20px;
                padding: 15px 20px;
                background: ${type === 'success' ? 'var(--success-green)' : type === 'warning' ? 'var(--warning-orange)' : 'var(--danger-red)'};
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
                <i class="fas ${type === 'success' ? 'fa-check-circle' : type === 'warning' ? 'fa-exclamation-triangle' : 'fa-exclamation-circle'}"></i>
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

        function exportToPDF() {
            showNotification('Preparing PDF export...', 'success');
        }

        function exportToExcel() {
            showNotification('Preparing Excel export...', 'success');
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

        document.addEventListener('DOMContentLoaded', function () {
            console.log("Transactions page loaded");

            initializeTransactionTable();

            const modal = document.getElementById('transactionModal');
            const refundModal = document.getElementById('refundModal');

            modal.addEventListener('click', (e) => {
                if (e.target === modal) {
                    closeModal();
                }
            });

            refundModal.addEventListener('click', (e) => {
                if (e.target === refundModal) {
                    closeModal();
                }
            });
        });
    </script>
</asp:Content>