<%@ Page Title="Customer Management | TasteNet" Language="C#" MasterPageFile="~/MasterPages/SuperAdmin.Master" AutoEventWireup="true" CodeBehind="CustomerManagement.aspx.cs" Inherits="TasteNet.Users.SuperAdmin.CustomerManagement" %>

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

        html, body {
            background-color: var(--soft-cream) !important;
            height: 100%;
            margin: 0;
            padding: 0;
        }

        body.customer-management-page {
            background-color: var(--soft-cream) !important;
            font-family: 'Poppins', sans-serif;
            color: var(--text-dark);
            min-height: 100vh;
        }

        #MainContent {
            background-color: var(--soft-cream) !important;
        }

        .dashboard-wrapper {
            padding: 20px 30px;
            max-width: 1600px;
            margin: 0 auto;
            background-color: var(--soft-cream) !important;
            min-height: 100vh;
            transition: filter 0.3s ease;
        }

        .dashboard-wrapper.blur-background {
            filter: blur(4px);
            pointer-events: none;
            user-select: none;
        }

        .dashboard-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            flex-wrap: wrap;
            gap: 15px;
        }

        .header-content h1 {
            font-size: 28px;
            font-weight: 700;
            margin: 0;
            color: var(--text-dark);
            letter-spacing: -0.5px;
        }

        .header-content p {
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

        .stat-card__icon--total { background: var(--accent-yellow-light); color: var(--warning-orange); }
        .stat-card__icon--active { background: var(--success-green-light); color: var(--success-green); }
        .stat-card__icon--blocked { background: var(--warning-orange-light); color: var(--warning-orange); }
        .stat-card__icon--revenue { background: var(--accent-pink); color: var(--primary-maroon); }

        .stat-card__value {
            font-size: 26px;
            font-weight: 700;
            color: var(--primary-maroon);
            margin: 6px 0;
            line-height: 1;
        }

        .stat-card__trend {
            font-size: 12px;
            font-weight: 600;
            color: var(--muted-text);
        }

        .filter-section {
            margin-bottom: 20px;
        }

        .filter-row {
            display: flex;
            gap: 8px;
            align-items: center;
            flex-wrap: nowrap;
        }

        .search-box {
            position: relative;
            min-width: 300px;
            flex: 0 0 auto;
        }

        .search-box__icon {
            position: absolute;
            left: 12px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--muted-text);
            font-size: 14px;
            z-index: 2;
        }

        .search-box__input {
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

        .search-box__input:hover {
            border-color: var(--border-hover);
            box-shadow: 0 4px 12px rgba(107, 13, 30, 0.08);
        }

        .search-box__input:focus {
            transform: translateY(-1px);
            border-color: var(--primary-maroon);
            box-shadow: 
                0 6px 16px rgba(107, 13, 30, 0.12),
                0 0 0 3px rgba(107, 13, 30, 0.1);
        }

        .search-box__input::placeholder {
            color: var(--muted-text);
            opacity: 0.7;
            font-size: 13px;
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

        .filter-dropdown:hover {
            border-color: var(--primary-maroon);
            box-shadow: 0 4px 12px rgba(107, 13, 30, 0.1);
            transform: translateY(-1px);
        }

        .filter-dropdown:focus {
            transform: translateY(0);
            border-color: var(--primary-maroon);
            box-shadow: 0 0 0 3px rgba(107, 13, 30, 0.15);
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

        .custom-table th:nth-child(1),
        .custom-table td:nth-child(1) {
            text-align: center;
            width: 100px;
            padding-left: 10px;
            padding-right: 10px;
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

        .custom-table tbody tr:hover td::before {
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

        .custom-table tbody tr:last-child td {
            border-bottom: none;
        }

        .custom-table th:nth-child(2),
        .custom-table td:nth-child(2) {
            width: 160px;
        }

        .custom-table th:nth-child(3),
        .custom-table td:nth-child(3) {
            width: 220px;
        }

        .custom-table th:nth-child(4),
        .custom-table td:nth-child(4) {
            width: 120px;
        }

        .custom-table th:nth-child(5),
        .custom-table td:nth-child(5) {
            width: 90px;
        }

        .custom-table th:nth-child(6),
        .custom-table td:nth-child(6) {
            width: 100px;
        }

        .custom-table th:nth-child(7),
        .custom-table td:nth-child(7) {
            width: 110px;
        }

        .custom-table th:nth-child(8),
        .custom-table td:nth-child(8) {
            width: 120px;
            padding-right: 20px;
        }

        .customer-id {
            color: var(--primary-maroon);
            font-weight: 700;
            font-size: 12px;
            font-family: 'Courier New', monospace;
            transition: all var(--transition-base);
            position: relative;
            display: inline-block;
        }

        .customer-id:hover {
            color: var(--primary-maroon);
            animation: bounce 0.5s ease infinite alternate;
        }

        .customer-id:hover::before {
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

        .customer-name {
            display: flex;
            flex-direction: column;
            gap: 2px;
            align-items: center;
        }

        .customer-name__primary {
            color: var(--text-dark);
            font-weight: 600;
            font-size: 13px;
            line-height: 1.2;
            position: relative;
            display: inline-block;
            transition: color var(--transition-fast);
        }

        .customer-name__primary:hover {
            color: var(--primary-maroon);
        }

        .customer-name__primary:hover::after {
            content: '';
            position: absolute;
            bottom: -2px;
            left: 0;
            width: 100%;
            height: 1px;
            background: var(--primary-maroon);
            animation: underlineExpand 0.3s ease forwards;
        }

        .customer-name__secondary {
            color: var(--muted-text);
            font-size: 11px;
            font-weight: 500;
            line-height: 1.2;
        }

        .customer-contact {
            display: flex;
            flex-direction: column;
            gap: 2px;
            align-items: center;
        }

        .customer-contact__email {
            color: var(--text-dark);
            font-size: 12px;
            font-weight: 500;
            line-height: 1.2;
        }

        .customer-contact__phone {
            color: var(--muted-text);
            font-size: 11px;
            line-height: 1.2;
        }

        .customer-stats {
            font-weight: 700;
            font-size: 13px;
        }

        .customer-stats--orders {
            color: var(--primary-maroon);
        }

        .customer-stats--spent {
            color: var(--success-green);
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

        .status-badge--active {
            background: var(--success-green-light);
            color: var(--success-green);
            border-color: var(--success-green);
        }

        .status-badge--active:hover {
            background: var(--success-green);
            color: white;
        }

        .status-badge--blocked {
            background: var(--danger-red-light);
            color: var(--danger-red);
            border-color: var(--danger-red);
        }

        .status-badge--blocked:hover {
            background: var(--danger-red);
            color: white;
        }

        .action-buttons {
            display: flex;
            gap: 6px;
            align-items: center;
            justify-content: center;
        }

        .action-button {
            width: 26px;
            height: 26px;
            border-radius: var(--radius-sm);
            display: flex;
            align-items: center;
            justify-content: center;
            background: var(--bg-lighter);
            border: none;
            cursor: pointer;
            transition: all var(--transition-base);
            font-size: 11px;
            position: relative;
            text-decoration: none;
            overflow: hidden;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .action-button--view {
            color: var(--primary-maroon);
        }

        .action-button--view:hover {
            background: var(--primary-maroon);
            color: white;
        }

        .action-button--edit {
            color: var(--muted-text);
        }

        .action-button--edit:hover {
            background: var(--success-green);
            color: white;
        }

        .action-button--block {
            color: var(--muted-text);
        }

        .action-button--block:hover {
            background: var(--warning-orange);
            color: white;
        }

        .action-button--delete {
            color: var(--muted-text);
        }

        .action-button--delete:hover {
            background: var(--danger-red);
            color: white;
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
        }

        .action-button[title]:hover::after {
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

        .action-button[title]:hover::before {
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

        .action-button {
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
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

        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 6px;
            margin-top: 20px;
            padding: 0 15px;
        }

        .pagination-item {
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

        .pagination-item:hover:not(.pagination-item--active, .pagination-item--disabled) {
            transform: translateY(-2px);
            border-color: var(--primary-maroon);
            box-shadow: 0 4px 12px rgba(107, 13, 30, 0.15);
        }

        .pagination-item--active {
            background: var(--primary-maroon);
            color: white;
            border-color: var(--primary-maroon);
            position: relative;
            overflow: hidden;
        }

        .pagination-item--active::after {
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

        .pagination-item--disabled {
            opacity: 0.5;
            cursor: not-allowed;
            pointer-events: none;
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
            backdrop-filter: blur(8px) saturate(180%);
            -webkit-backdrop-filter: blur(8px) saturate(180%);
            display: none;
        }

        @supports not (backdrop-filter: blur(8px)) {
            .modal-overlay {
                background: rgba(0, 0, 0, 0.85);
            }
        }

        .customer-modal {
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

        .modal-header h3 .customer-id {
            background: rgba(255,255,255,0.2);
            padding: 4px 12px;
            border-radius: var(--radius-sm);
            font-size: 14px;
            font-weight: 500;
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

        .customer-info-grid {
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

        .info-value.status-active {
            background: var(--success-green-light);
            color: var(--success-green);
        }

        .info-value.status-blocked {
            background: var(--danger-red-light);
            color: var(--danger-red);
        }

        .customer-activity {
            background: white;
            border-radius: var(--radius-lg);
            padding: 25px;
            border: 1px solid var(--border-light);
        }

        .activity-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            margin-top: 15px;
        }

        .activity-stat {
            text-align: center;
            padding: 20px;
            background: var(--soft-cream);
            border-radius: var(--radius-md);
            transition: all var(--transition-base);
        }

        .activity-stat:hover {
            transform: translateY(-5px);
            box-shadow: var(--card-shadow);
        }

        .activity-stat__value {
            font-size: 28px;
            font-weight: 700;
            color: var(--primary-maroon);
            margin-bottom: 5px;
        }

        .activity-stat__label {
            color: var(--muted-text);
            font-size: 12px;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        /* Style for recent orders table - Fix for Order ID spacing */
        .recent-orders-container {
            margin-top: 8px;
            overflow-x: auto;
        }

        .recent-orders-table {
            width: 100%;
            border-collapse: collapse;
        }

        .recent-orders-table th {
            padding: 6px 12px;
            text-align: left;
            border-bottom: 2px solid var(--border-light);
            color: var(--muted-text);
            font-size: 11px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.3px;
        }

        .recent-orders-table td {
            padding: 6px 12px;
            border-bottom: 1px solid var(--border-light);
            font-size: 12px;
            vertical-align: middle;
        }

        .recent-orders-table tr:last-child td {
            border-bottom: none;
        }

        .recent-orders-table strong {
            color: var(--text-dark);
            font-weight: 600;
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

        .filter-dropdown.active {
            border-color: var(--primary-maroon);
            background-color: var(--soft-cream);
            box-shadow: 0 0 0 3px rgba(107, 13, 30, 0.1);
        }

        .search-box.loading .search-box__icon {
            animation: spin 1s linear infinite;
        }

        .delete-confirm-modal {
            background: white;
            border-radius: var(--radius-xl);
            max-width: 400px;
            width: 90%;
            padding: 30px;
            text-align: center;
            animation: slideUp 0.4s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .delete-confirm-modal i {
            font-size: 48px;
            color: var(--danger-red);
            margin-bottom: 20px;
        }

        .delete-confirm-modal h3 {
            color: var(--text-dark);
            margin-top: 0;
            margin-bottom: 15px;
        }

        .delete-confirm-modal p {
            color: var(--muted-text);
            margin-bottom: 25px;
            font-size: 14px;
        }

        .delete-confirm-actions {
            display: flex;
            gap: 10px;
            justify-content: center;
        }

        .delete-confirm-actions .btn {
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

        @keyframes shimmer {
            0% { left: -100%; }
            100% { left: 100%; }
        }

        @keyframes ripple-animation {
            to {
                transform: scale(4);
                opacity: 0;
            }
        }

        @keyframes loadingShimmer {
            0% { left: -100%; }
            100% { left: 100%; }
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
            .stat-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 1200px) {
            .dashboard-wrapper {
                padding: 15px 20px;
            }
            
            .filter-row {
                flex-wrap: wrap;
                gap: 8px;
            }
            
            .search-box {
                min-width: calc(100% - 10px);
                margin-bottom: 0;
            }
            
            .filter-dropdown {
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
        }

        @media (max-width: 992px) {
            .dashboard-header {
                flex-direction: column;
                align-items: stretch;
                gap: 15px;
                margin-bottom: 20px;
            }
            
            .header-content h1 {
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

            .customer-info-grid {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 768px) {
            .stat-grid {
                grid-template-columns: 1fr;
            }
            
            .filter-row {
                flex-direction: column;
                width: 100%;
            }
            
            .search-box {
                min-width: 100%;
                margin-bottom: 8px;
            }
            
            .filter-dropdown {
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
            
            .action-buttons {
                flex-wrap: wrap;
                justify-content: center;
            }
            
            .pagination {
                flex-wrap: wrap;
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

            .activity-grid {
                grid-template-columns: 1fr;
            }

            .delete-confirm-modal {
                padding: 20px;
            }

            .delete-confirm-actions {
                flex-direction: column;
            }

            .delete-confirm-actions .btn {
                width: 100%;
            }
        }

        @media (max-width: 480px) {
            .dashboard-wrapper {
                padding: 12px 15px;
            }
            
            .header-content h1 {
                font-size: 20px;
            }
            
            .header-content p {
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
        }
    </style>

    <div class="dashboard-wrapper">
        <div class="dashboard-header">
            <div class="header-content">
                <h1>Customer Management</h1>
                <p>Monitor and manage all registered customers and their activities</p>
            </div>
            <div class="header-actions">
                <button type="button" class="btn btn--primary" onclick="return false;">
                    <i class="fas fa-download"></i>
                    Export Data
                </button>
            </div>
        </div>

        <div class="stat-grid">
            <div class="stat-card">
                <div class="stat-card__header">
                    <span class="stat-card__label">Total Customers</span>
                    <div class="stat-card__icon stat-card__icon--total">
                        <i class="fas fa-users"></i>
                    </div>
                </div>
                <div class="stat-card__value" id="totalCustomers">5</div>
                <div class="stat-card__trend">All registered accounts</div>
            </div>

            <div class="stat-card">
                <div class="stat-card__header">
                    <span class="stat-card__label">Active Customers</span>
                    <div class="stat-card__icon stat-card__icon--active">
                        <i class="fas fa-user-check"></i>
                    </div>
                </div>
                <div class="stat-card__value" id="activeCustomers">4</div>
                <div class="stat-card__trend">Currently active users</div>
            </div>

            <div class="stat-card">
                <div class="stat-card__header">
                    <span class="stat-card__label">Blocked</span>
                    <div class="stat-card__icon stat-card__icon--blocked">
                        <i class="fas fa-ban"></i>
                    </div>
                </div>
                <div class="stat-card__value" id="blockedCustomers">1</div>
                <div class="stat-card__trend">Suspended accounts</div>
            </div>

            <div class="stat-card">
                <div class="stat-card__header">
                    <span class="stat-card__label">Total Revenue</span>
                    <div class="stat-card__icon stat-card__icon--revenue">
                        <i class="fas fa-peso-sign"></i>
                    </div>
                </div>
                <div class="stat-card__value">₱33,680</div>
                <div class="stat-card__trend">From all customer orders</div>
            </div>
        </div>

        <div class="filter-section">
            <div class="filter-row">
                <div class="search-box" id="searchBox">
                    <div class="search-box__icon">
                        <i class="fas fa-search"></i>
                    </div>
                    <input type="text" class="search-box__input" id="searchInput" 
                           placeholder="Search by name, ID, email, or phone...">
                </div>
                <select class="filter-dropdown" id="statusFilter">
                    <option value="all">All Status</option>
                    <option value="active">Active</option>
                    <option value="blocked">Blocked</option>
                </select>
                <select class="filter-dropdown" id="sortFilter">
                    <option value="rating">Sort by: Rating</option>
                    <option value="name-asc">Sort by: Name (A-Z)</option>
                    <option value="name-desc">Sort by: Name (Z-A)</option>
                    <option value="date-desc">Sort by: Date Registered (Newest)</option>
                    <option value="date-asc">Sort by: Date Registered (Oldest)</option>
                    <option value="orders-desc">Sort by: Total Orders (High to Low)</option>
                    <option value="orders-asc">Sort by: Total Orders (Low to High)</option>
                    <option value="spent-desc">Sort by: Total Spent (High to Low)</option>
                    <option value="spent-asc">Sort by: Total Spent (Low to High)</option>
                </select>
            </div>
        </div>

        <div class="table-container">
            <div class="table-wrapper">
                <table class="custom-table">
                    <thead>
                        <tr>
                            <th>Customer ID</th>
                            <th>Full Name</th>
                            <th>Contact Info</th>
                            <th>Date Registered</th>
                            <th>Status</th>
                            <th>Total Orders</th>
                            <th>Total Spent</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody id="customersTableBody">
                        <asp:Repeater ID="rptCustomers" runat="server">
                            <ItemTemplate>
                                <tr data-customer-id='<%# Eval("CustomerID").ToString().Replace("CUST-", "") %>' 
                                    data-status='<%# Eval("Status").ToString().ToLower() %>' 
                                    data-orders='<%# Eval("TotalOrders") %>' 
                                    data-spent='<%# Eval("TotalSpent") %>' 
                                    data-date='<%# ((DateTime)Eval("DateRegistered")).ToString("yyyy-MM-dd") %>' 
                                    data-rating='<%# new Random().Next(1, 6) %>'>
                                    <td>
                                        <span class="customer-id"><%# Eval("CustomerID") %></span>
                                    </td>
                                    <td>
                                        <div class="customer-name">
                                            <span class="customer-name__primary"><%# Eval("FullName") %></span>
                                            <span class="customer-name__secondary"><%# Eval("Username") %></span>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="customer-contact">
                                            <span class="customer-contact__email"><%# Eval("Email") %></span>
                                            <span class="customer-contact__phone"><%# Eval("Contact") %></span>
                                        </div>
                                    </td>
                                    <td><%# ((DateTime)Eval("DateRegistered")).ToString("MMM dd, yyyy") %></td>
                                    <td>
                                        <span class='status-badge <%# Eval("Status").ToString() == "ACTIVE" ? "status-badge--active" : "status-badge--blocked" %>'>
                                            <%# Eval("Status") %>
                                        </span>
                                    </td>
                                    <td class="customer-stats customer-stats--orders"><%# Eval("TotalOrders") %></td>
                                    <td class="customer-stats customer-stats--spent">₱<%# ((decimal)Eval("TotalSpent")).ToString("N0") %></td>
                                    <td>
                                        <div class="action-buttons">
                                            <button type="button" class="action-button action-button--view" title="View Details" onclick='viewCustomer("<%# Eval("CustomerID").ToString().Replace("CUST-", "") %>")'>
                                                <i class="fas fa-eye"></i>
                                            </button>
                                            <button type="button" class="action-button action-button--block" title="Block/Unblock" onclick='toggleBlockCustomer("<%# Eval("CustomerID").ToString().Replace("CUST-", "") %>")'>
                                                <i class="fas fa-ban"></i>
                                            </button>
                                            <button type="button" class="action-button action-button--delete" title="Delete Customer" onclick='showDeleteConfirmation("<%# Eval("CustomerID").ToString().Replace("CUST-", "") %>")'>
                                                <i class="fas fa-trash"></i>
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
                    <h3>No results found</h3>
                    <p>Try searching with different keywords</p>
                </div>
            </div>
        </div>

        <div class="pagination">
            <a href="#" class="pagination-item pagination-item--disabled">
                <i class="fas fa-chevron-left"></i>
            </a>
            <a href="#" class="pagination-item pagination-item--active">1</a>
            <a href="#" class="pagination-item">2</a>
            <a href="#" class="pagination-item">3</a>
            <a href="#" class="pagination-item">
                <i class="fas fa-chevron-right"></i>
            </a>
        </div>
    </div>

    <div id="customerModal" class="modal-overlay" style="display: none;">
        <div class="customer-modal">
            <div class="modal-header">
                <h3>
                    <i class="fas fa-user-circle"></i>
                    Customer Details
                    <span class="customer-id" id="modalCustomerId">CUST#-000</span>
                </h3>
                <button class="close-modal" onclick="closeModal()">
                    <i class="fas fa-times"></i>
                </button>
            </div>
            <div class="modal-body">
                <div class="customer-info-grid">
                    <div class="info-section">
                        <h4><i class="fas fa-id-card"></i> Personal Information</h4>
                        <div class="info-row">
                            <span class="info-label">Full Name:</span>
                            <span class="info-value" id="modalFullName">Loading...</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Username:</span>
                            <span class="info-value" id="modalUsername">Loading...</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Email Address:</span>
                            <span class="info-value" id="modalEmail">Loading...</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Phone Number:</span>
                            <span class="info-value" id="modalPhone">Loading...</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Date Registered:</span>
                            <span class="info-value" id="modalDateRegistered">Loading...</span>
                        </div>
                    </div>
                    
                    <div class="info-section">
                        <h4><i class="fas fa-chart-line"></i> Account Status</h4>
                        <div class="info-row">
                            <span class="info-label">Customer ID:</span>
                            <span class="info-value" id="modalCustomerId2">Loading...</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Status:</span>
                            <span class="info-value status" id="modalStatus">Loading</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Last Login:</span>
                            <span class="info-value" id="modalLastLogin">Today, 10:30 AM</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Account Type:</span>
                            <span class="info-value">Regular Customer</span>
                        </div>
                    </div>
                </div>

                <div class="customer-activity">
                    <h4><i class="fas fa-shopping-cart"></i> Shopping Activity</h4>
                    <div class="activity-grid">
                        <div class="activity-stat">
                            <div class="activity-stat__value" id="modalTotalOrders">0</div>
                            <div class="activity-stat__label">Total Orders</div>
                        </div>
                        <div class="activity-stat">
                            <div class="activity-stat__value" id="modalTotalSpent">₱0</div>
                            <div class="activity-stat__label">Total Spent</div>
                        </div>
                        <div class="activity-stat">
                            <div class="activity-stat__value" id="modalAvgOrder">₱0</div>
                            <div class="activity-stat__label">Avg. Order Value</div>
                        </div>
                    </div>
                </div>

                <div class="customer-activity" style="margin-top: 20px;">
                    <h4><i class="fas fa-history"></i> Recent Orders</h4>
                    <div id="recentOrders">
                        <p style="text-align: center; color: var(--muted-text); padding: 20px;">
                            Loading order history...
                        </p>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn--outline" onclick="closeModal()">
                    <i class="fas fa-times"></i> Close
                </button>
                <button class="btn btn--primary" id="modalActionButton" onclick="handleModalAction()">
                    <i class="fas fa-ban"></i> Block Customer
                </button>
            </div>
        </div>
    </div>

    <div id="deleteConfirmModal" class="modal-overlay" style="display: none;">
        <div class="delete-confirm-modal">
            <i class="fas fa-exclamation-triangle"></i>
            <h3>Delete Customer</h3>
            <p id="deleteConfirmationText">Are you sure you want to delete this customer?</p>
            <p style="color: var(--muted-text); font-size: 12px; margin-top: -10px;">This action cannot be undone.</p>
            <div class="delete-confirm-actions">
                <button id="confirmDelete" class="btn btn--primary" style="background: var(--danger-red);">
                    Delete
                </button>
                <button id="cancelDelete" class="btn btn--outline">
                    Cancel
                </button>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        let allCustomers = [];
        let currentCustomerId = null;
        let customerToDelete = null;

        function initializeCustomerData() {
            const rows = document.querySelectorAll('#customersTableBody tr');
            allCustomers = Array.from(rows).map(row => {
                const cells = row.querySelectorAll('td');
                const id = row.dataset.customerId;
                const fullName = cells[1].querySelector('.customer-name__primary').textContent;
                const username = cells[1].querySelector('.customer-name__secondary')?.textContent || '';
                const email = cells[2].querySelector('.customer-contact__email').textContent;
                const phone = cells[2].querySelector('.customer-contact__phone').textContent;
                const dateRegistered = cells[3].textContent;
                const status = row.dataset.status || 'active';
                const totalOrders = parseInt(row.dataset.orders) || 0;
                const totalSpent = parseFloat(row.dataset.spent) || 0;
                const rating = parseInt(row.dataset.rating) || 5;

                return {
                    element: row,
                    id: id,
                    fullName: fullName,
                    username: username,
                    email: email,
                    phone: phone,
                    dateRegistered: dateRegistered,
                    status: status,
                    totalOrders: totalOrders,
                    totalSpent: totalSpent,
                    rating: rating,
                    lastLogin: 'Today, 10:30 AM'
                };
            });
            updateStats();
        }

        let searchTimeout;
        function handleSearch() {
            clearTimeout(searchTimeout);

            const searchBox = document.getElementById('searchBox');
            const searchInput = document.getElementById('searchInput');
            const searchTerm = searchInput.value.toLowerCase().trim();

            searchBox.classList.add('loading');

            searchTimeout = setTimeout(() => {
                let hasVisibleRows = false;

                allCustomers.forEach(customer => {
                    const matches = searchTerm === '' ||
                        customer.id.toLowerCase().includes(searchTerm) ||
                        customer.fullName.toLowerCase().includes(searchTerm) ||
                        customer.username.toLowerCase().includes(searchTerm) ||
                        customer.email.toLowerCase().includes(searchTerm) ||
                        customer.phone.toLowerCase().includes(searchTerm);

                    customer.element.style.display = matches ? '' : 'none';
                    if (matches) hasVisibleRows = true;
                });

                const noResultsMessage = document.getElementById('noResultsMessage');
                if (!hasVisibleRows && searchTerm !== '') {
                    noResultsMessage.style.display = 'block';
                } else {
                    noResultsMessage.style.display = 'none';
                }

                searchBox.classList.remove('loading');
            }, 300);
        }

        function handleFilter() {
            const statusFilter = document.getElementById('statusFilter');
            const selectedStatus = statusFilter.value;

            document.querySelectorAll('.filter-dropdown').forEach(dropdown => {
                dropdown.classList.remove('active');
            });
            statusFilter.classList.add('active');

            let hasVisibleRows = false;
            allCustomers.forEach(customer => {
                if (selectedStatus === 'all') {
                    customer.element.style.display = '';
                    hasVisibleRows = true;
                } else {
                    const shouldShow = customer.status === selectedStatus;
                    customer.element.style.display = shouldShow ? '' : 'none';
                    if (shouldShow) hasVisibleRows = true;
                }
            });

            const noResultsMessage = document.getElementById('noResultsMessage');
            if (!hasVisibleRows && selectedStatus !== 'all') {
                noResultsMessage.innerHTML = `
                    <i class="fas fa-filter"></i>
                    <h3>No ${selectedStatus} customers</h3>
                    <p>Try selecting a different status filter</p>
                `;
                noResultsMessage.style.display = 'block';
            } else {
                noResultsMessage.style.display = 'none';
            }

            updateStats();
        }

        function handleSort() {
            const sortFilter = document.getElementById('sortFilter');
            const sortBy = sortFilter.value;

            document.querySelectorAll('.filter-dropdown').forEach(dropdown => {
                dropdown.classList.remove('active');
            });
            sortFilter.classList.add('active');

            const tbody = document.querySelector('#customersTableBody');
            const rows = Array.from(tbody.querySelectorAll('tr'));

            rows.sort((a, b) => {
                const aData = allCustomers.find(c => c.element === a);
                const bData = allCustomers.find(c => c.element === b);

                if (!aData || !bData) return 0;

                switch (sortBy) {
                    case 'name-asc':
                        return aData.fullName.localeCompare(bData.fullName);
                    case 'name-desc':
                        return bData.fullName.localeCompare(aData.fullName);
                    case 'date-desc':
                        return new Date(bData.dateRegistered) - new Date(aData.dateRegistered);
                    case 'date-asc':
                        return new Date(aData.dateRegistered) - new Date(bData.dateRegistered);
                    case 'orders-desc':
                        return bData.totalOrders - aData.totalOrders;
                    case 'orders-asc':
                        return aData.totalOrders - bData.totalOrders;
                    case 'spent-desc':
                        return bData.totalSpent - aData.totalSpent;
                    case 'spent-asc':
                        return aData.totalSpent - bData.totalSpent;
                    case 'rating':
                        return bData.rating - aData.rating;
                    default:
                        return 0;
                }
            });

            rows.forEach((row, index) => {
                row.style.animation = 'none';
                void row.offsetWidth;
                row.style.animation = `tableRowFadeIn 0.3s ease ${index * 0.05}s`;
                tbody.appendChild(row);
            });
        }

        function viewCustomer(customerId) {
            currentCustomerId = customerId;
            const customer = allCustomers.find(c => c.id === customerId);

            if (!customer) {
                alert('Customer not found!');
                return;
            }

            document.getElementById('modalCustomerId').textContent = `CUST-${customer.id.padStart(3, '0')}`;
            document.getElementById('modalCustomerId2').textContent = `CUST-${customer.id.padStart(3, '0')}`;
            document.getElementById('modalFullName').textContent = customer.fullName;
            document.getElementById('modalUsername').textContent = customer.username || customer.email.split('@')[0];
            document.getElementById('modalEmail').textContent = customer.email;
            document.getElementById('modalPhone').textContent = customer.phone;
            document.getElementById('modalDateRegistered').textContent = customer.dateRegistered;
            document.getElementById('modalLastLogin').textContent = customer.lastLogin;

            const statusElement = document.getElementById('modalStatus');
            statusElement.textContent = customer.status.charAt(0).toUpperCase() + customer.status.slice(1);
            statusElement.className = customer.status === 'active'
                ? 'info-value status status-active'
                : 'info-value status status-blocked';

            document.getElementById('modalTotalOrders').textContent = customer.totalOrders;
            document.getElementById('modalTotalSpent').textContent = `₱${customer.totalSpent.toLocaleString()}`;
            document.getElementById('modalAvgOrder').textContent = customer.totalOrders > 0
                ? `₱${Math.round(customer.totalSpent / customer.totalOrders).toLocaleString()}`
                : '₱0';

            const actionButton = document.getElementById('modalActionButton');
            if (customer.status === 'active') {
                actionButton.innerHTML = '<i class="fas fa-ban"></i> Block Customer';
                actionButton.className = 'btn btn--primary';
                actionButton.onclick = function () {
                    if (confirm('Are you sure you want to block this customer?')) {
                        toggleBlockCustomer(customerId);
                        closeModal();
                    }
                };
            } else {
                actionButton.innerHTML = '<i class="fas fa-check"></i> Unblock Customer';
                actionButton.className = 'btn btn--success';
                actionButton.onclick = function () {
                    if (confirm('Are you sure you want to unblock this customer?')) {
                        toggleBlockCustomer(customerId);
                        closeModal();
                    }
                };
            }

            loadRecentOrders(customerId);

            const modal = document.getElementById('customerModal');
            modal.style.display = 'flex';
            const wrapper = document.querySelector('.dashboard-wrapper');
            wrapper.classList.add('blur-background');
            document.body.style.overflow = 'hidden';

            document.addEventListener('keydown', handleModalKeydown);
        }

        function closeModal() {
            const modal = document.getElementById('customerModal');
            const deleteModal = document.getElementById('deleteConfirmModal');
            modal.style.display = 'none';
            deleteModal.style.display = 'none';

            const wrapper = document.querySelector('.dashboard-wrapper');
            wrapper.classList.remove('blur-background');

            document.body.style.overflow = 'auto';
            document.removeEventListener('keydown', handleModalKeydown);
            document.removeEventListener('keydown', handleDeleteModalKeydown);
            customerToDelete = null;
        }

        function handleModalKeydown(e) {
            if (e.key === 'Escape') {
                closeModal();
            }
        }

        function handleDeleteModalKeydown(e) {
            if (e.key === 'Escape') {
                closeModal();
            }
        }

        function handleModalAction() {
        }

        function loadRecentOrders(customerId) {
            const recentOrdersDiv = document.getElementById('recentOrders');

            const recentOrders = [
                { id: `ORD#${customerId}-2024-001`, date: 'Today', amount: '₱1,250', status: 'Delivered' },
                { id: `ORD#${customerId}-2024-002`, date: 'Yesterday', amount: '₱850', status: 'Processing' },
                { id: `ORD#${customerId}-2024-003`, date: '2 days ago', amount: '₱2,150', status: 'Delivered' }
            ];

            let html = '<div class="recent-orders-container">';
            html += '<table class="recent-orders-table">';
            html += '<thead><tr>';
            html += '<th>Order ID</th>';
            html += '<th>Date</th>';
            html += '<th>Amount</th>';
            html += '<th>Status</th>';
            html += '</tr></thead>';
            html += '<tbody>';

            recentOrders.forEach(order => {
                const statusClass = order.status === 'Delivered' ? 'status-active' : 'status-blocked';
                html += `<tr>`;
                html += `<td><strong>${order.id}</strong></td>`;
                html += `<td>${order.date}</td>`;
                html += `<td style="font-weight: 600;">${order.amount}</td>`;
                html += `<td><span class="info-value status ${statusClass}">${order.status}</span></td>`;
                html += `</tr>`;
            });

            html += '</tbody></table></div>';
            recentOrdersDiv.innerHTML = html;
        }

        function showDeleteConfirmation(customerId) {
            customerToDelete = customerId;
            const customer = allCustomers.find(c => c.id === customerId);

            if (!customer) return;

            document.getElementById('deleteConfirmationText').textContent =
                `Are you sure you want to delete customer ${customer.fullName} (CUST-${customer.id.padStart(3, '0')})?`;

            const modal = document.getElementById('deleteConfirmModal');
            modal.style.display = 'flex';

            const wrapper = document.querySelector('.dashboard-wrapper');
            wrapper.classList.add('blur-background');

            document.body.style.overflow = 'hidden';

            document.getElementById('confirmDelete').onclick = confirmDelete;
            document.getElementById('cancelDelete').onclick = closeModal;

            document.addEventListener('keydown', handleDeleteModalKeydown);
        }

        function confirmDelete() {
            if (!customerToDelete) return;

            const customerIndex = allCustomers.findIndex(c => c.id === customerToDelete);
            if (customerIndex === -1) return;

            const customer = allCustomers[customerIndex];
            const row = customer.element;

            row.style.transition = 'all 0.5s cubic-bezier(0.4, 0, 0.2, 1)';
            row.style.opacity = '0';
            row.style.transform = 'translateX(100px) rotate(5deg)';
            row.style.height = '0';
            row.style.padding = '0';
            row.style.margin = '0';
            row.style.border = 'none';

            setTimeout(() => {
                row.remove();
                allCustomers.splice(customerIndex, 1);

                updateStats();
                handleFilter();

                closeModal();

                showNotification('Customer deleted successfully!', 'success');
            }, 500);
        }

        function toggleBlockCustomer(customerId) {
            const customer = allCustomers.find(c => c.id === customerId);
            if (!customer) return;

            const row = customer.element;
            const statusBadge = row.querySelector('.status-badge');
            const blockButton = row.querySelector('.action-button--block');

            row.style.animation = 'shake 0.5s ease';

            setTimeout(() => {
                if (customer.status === 'active') {
                    customer.status = 'blocked';
                    row.dataset.status = 'blocked';
                    statusBadge.textContent = 'Blocked';
                    statusBadge.className = 'status-badge status-badge--blocked';
                    blockButton.innerHTML = '<i class="fas fa-check"></i>';
                    blockButton.title = 'Unblock Customer';
                    row.style.animation = 'pulseRed 0.5s ease';
                } else {
                    customer.status = 'active';
                    row.dataset.status = 'active';
                    statusBadge.textContent = 'Active';
                    statusBadge.className = 'status-badge status-badge--active';
                    blockButton.innerHTML = '<i class="fas fa-ban"></i>';
                    blockButton.title = 'Block Customer';
                    row.style.animation = 'pulseGreen 0.5s ease';
                }

                setTimeout(() => {
                    row.style.animation = '';
                    updateStats();
                    handleFilter();

                    const action = customer.status === 'active' ? 'unblocked' : 'blocked';
                    showNotification(`Customer ${action} successfully!`, 'success');
                }, 500);
            }, 500);
        }

        function updateStats() {
            const activeCustomers = allCustomers.filter(c => c.status === 'active').length;
            const blockedCustomers = allCustomers.filter(c => c.status === 'blocked').length;
            const totalCustomers = activeCustomers + blockedCustomers;

            document.getElementById('totalCustomers').textContent = totalCustomers;
            document.getElementById('activeCustomers').textContent = activeCustomers;
            document.getElementById('blockedCustomers').textContent = blockedCustomers;
        }

        function showNotification(message, type) {
            const notification = document.createElement('div');
            notification.style.cssText = `
                position: fixed;
                top: 20px;
                right: 20px;
                padding: 15px 20px;
                background: ${type === 'success' ? 'var(--success-green)' : 'var(--danger-red)'};
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
                <i class="fas ${type === 'success' ? 'fa-check-circle' : 'fa-exclamation-circle'}"></i>
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
            
            @keyframes shake {
                0%, 100% { transform: translateX(0); }
                10%, 30%, 50%, 70%, 90% { transform: translateX(-2px); }
                20%, 40%, 60%, 80% { transform: translateX(2px); }
            }
            
            @keyframes pulseRed {
                0%, 100% { background-color: transparent; }
                50% { background-color: rgba(185, 28, 28, 0.1); }
            }
            
            @keyframes pulseGreen {
                0%, 100% { background-color: transparent; }
                50% { background-color: rgba(45, 157, 120, 0.1); }
            }
        `;
        document.head.appendChild(style);

        document.addEventListener('DOMContentLoaded', function () {
            initializeCustomerData();

            const searchInput = document.getElementById('searchInput');
            searchInput.addEventListener('input', handleSearch);

            const statusFilter = document.getElementById('statusFilter');
            statusFilter.addEventListener('change', handleFilter);

            const sortFilter = document.getElementById('sortFilter');
            sortFilter.addEventListener('change', handleSort);

            const modal = document.getElementById('customerModal');
            modal.addEventListener('click', (e) => {
                if (e.target === modal) {
                    closeModal();
                }
            });

            const deleteModal = document.getElementById('deleteConfirmModal');
            deleteModal.addEventListener('click', (e) => {
                if (e.target === deleteModal) {
                    closeModal();
                }
            });
        });
    </script>
</asp:Content>