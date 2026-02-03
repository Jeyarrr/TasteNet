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
            gap: 15px;
            margin-bottom: 25px;
        }

        .stat-card {
            background: white;
            padding: 18px;
            border-radius: var(--radius-lg);
            box-shadow: var(--card-shadow);
            transition: transform var(--transition-base), box-shadow var(--transition-base);
            border: 2px solid transparent;
            cursor: pointer;
            position: relative;
            overflow: hidden;
        }

        .stat-card:hover {
            transform: translateY(-3px);
            box-shadow: var(--card-shadow-hover);
            border-color: var(--border-light);
        }

        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 3px;
            background: linear-gradient(90deg, var(--primary-maroon), transparent);
            opacity: 0;
            transition: opacity var(--transition-base);
        }

        .stat-card:hover::before {
            opacity: 1;
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

        .search-box__input:focus {
            border-color: var(--primary-maroon);
            box-shadow: 0 0 0 3px rgba(107, 13, 30, 0.08);
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
            min-width: 180px;
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
        }

        .filter-dropdown:hover {
            border-color: var(--border-hover);
        }

        .filter-dropdown:focus {
            border-color: var(--primary-maroon);
            box-shadow: 0 0 0 3px rgba(107, 13, 30, 0.05);
        }

        .table-container {
            background: white;
            border-radius: var(--radius-lg);
            box-shadow: var(--card-shadow);
            overflow: hidden;
            margin-bottom: 20px;
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
        }

        .custom-table th:nth-child(1),
        .custom-table td:nth-child(1) {
            text-align: left;
        }

        .custom-table tbody tr {
            transition: all var(--transition-base);
            position: relative;
        }

        .custom-table tbody tr:hover {
            background-color: var(--bg-hover);
        }

        .custom-table tbody tr:last-child td {
            border-bottom: none;
        }

        .custom-table th:nth-child(1),
        .custom-table td:nth-child(1) {
            width: 100px;
            padding-left: 20px;
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
        }

        .status-badge--active {
            background: var(--success-green-light);
            color: var(--success-green);
            border-color: var(--success-green);
        }

        .status-badge--blocked {
            background: var(--danger-red-light);
            color: var(--danger-red);
            border-color: var(--danger-red);
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
            color: var(--muted-text);
            border: none;
            cursor: pointer;
            transition: all var(--transition-fast);
            font-size: 11px;
            position: relative;
            text-decoration: none;
        }

        .action-button {
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        .action-button:hover {
            transform: translateY(-1px);
            box-shadow: 0 3px 6px rgba(0, 0, 0, 0.1);
        }

        .action-button--view:hover {
            background: var(--primary-maroon);
            color: white;
        }

        .action-button--edit:hover {
            background: var(--success-green);
            color: white;
        }

        .action-button--block:hover {
            background: var(--warning-orange);
            color: white;
        }

        .action-button--delete:hover {
            background: var(--danger-red);
            color: white;
        }

        .action-button[title]:hover::after {
            content: attr(title);
            position: absolute;
            bottom: -22px;
            left: 50%;
            transform: translateX(-50%);
            background: var(--text-dark);
            color: white;
            padding: 3px 6px;
            border-radius: var(--radius-sm);
            font-size: 10px;
            white-space: nowrap;
            z-index: 10;
            pointer-events: none;
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
        }

        .btn--primary {
            background: var(--primary-maroon);
            color: white;
            box-shadow: var(--button-shadow);
        }

        .btn--primary:hover {
            background: var(--primary-maroon-dark);
            transform: translateY(-2px);
            box-shadow: var(--button-shadow-hover);
        }

        .btn--primary:focus {
            outline: 2px solid var(--primary-maroon);
            outline-offset: 2px;
        }

        .btn--secondary {
            background: var(--accent-yellow);
            color: var(--text-dark);
            box-shadow: 0 4px 12px rgba(255, 204, 0, 0.2);
        }

        .btn--secondary:hover {
            background: var(--accent-yellow-dark);
            transform: translateY(-2px);
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
            transform: translateY(-2px);
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
            transition: all var(--transition-fast);
            font-size: 13px;
            text-decoration: none;
        }

        .pagination-item:hover:not(.pagination-item--active) {
            border-color: var(--primary-maroon);
            background: var(--soft-cream);
            color: var(--primary-maroon);
        }

        .pagination-item--active {
            background: var(--primary-maroon);
            color: white;
            border-color: var(--primary-maroon);
        }

        .pagination-item--disabled {
            opacity: 0.5;
            cursor: not-allowed;
            pointer-events: none;
        }

        .section-header {
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 2px solid var(--bg-light);
        }

        .section-header h2 {
            font-size: 16px;
            font-weight: 600;
            color: var(--text-dark);
            margin: 0;
        }

        button.action-button-fix {
            type: button;
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
            
            .custom-table th:nth-child(1),
            .custom-table td:nth-child(1) {
                padding-left: 15px;
            }
            
            .custom-table th:nth-child(8),
            .custom-table td:nth-child(8) {
                padding-right: 15px;
            }
            
            .action-buttons {
                flex-wrap: wrap;
                justify-content: center;
            }
            
            .pagination {
                flex-wrap: wrap;
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
        }

        .text-maroon { color: var(--primary-maroon); }
        .text-success { color: var(--success-green); }
        .text-muted { color: var(--muted-text); }
        .text-center { text-align: center; }
        .text-right { text-align: right; }
        .font-bold { font-weight: 700; }
        .font-semibold { font-weight: 600; }
        .mt-20 { margin-top: 20px; }
        .mb-20 { margin-bottom: 20px; }
        .p-0 { padding: 0; }
        .w-100 { width: 100%; }

        @media print {
            .header-actions,
            .filter-section,
            .action-buttons,
            .pagination {
                display: none !important;
            }
            
            .table-container {
                box-shadow: none;
                border: 1px solid #ddd;
            }
            
            body {
                background: white !important;
            }
            
            .stat-card {
                break-inside: avoid;
                page-break-inside: avoid;
            }
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .stat-card,
        .table-container {
            animation: fadeIn 0.5s ease-out;
        }

        .custom-table tbody tr {
            animation: fadeIn 0.3s ease-out;
        }

        .loading {
            position: relative;
            overflow: hidden;
        }

        .loading::after {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.4), transparent);
            animation: loadingShimmer 1.5s infinite;
        }

        @keyframes loadingShimmer {
            0% { left: -100%; }
            100% { left: 100%; }
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
                <div class="stat-card__value">8</div>
                <div class="stat-card__trend">All registered accounts</div>
            </div>

            <div class="stat-card">
                <div class="stat-card__header">
                    <span class="stat-card__label">Active Customers</span>
                    <div class="stat-card__icon stat-card__icon--active">
                        <i class="fas fa-user-check"></i>
                    </div>
                </div>
                <div class="stat-card__value">7</div>
                <div class="stat-card__trend">Currently active users</div>
            </div>

            <div class="stat-card">
                <div class="stat-card__header">
                    <span class="stat-card__label">Blocked</span>
                    <div class="stat-card__icon stat-card__icon--blocked">
                        <i class="fas fa-ban"></i>
                    </div>
                </div>
                <div class="stat-card__value">1</div>
                <div class="stat-card__trend">Suspended accounts</div>
            </div>

            <div class="stat-card">
                <div class="stat-card__header">
                    <span class="stat-card__label">Total Revenue</span>
                    <div class="stat-card__icon stat-card__icon--revenue">
                        <i class="fas fa-peso-sign"></i>
                    </div>
                </div>
                <div class="stat-card__value">₱59,035</div>
                <div class="stat-card__trend">From all customer orders</div>
            </div>
        </div>

        <div class="filter-section">
            <div class="filter-row">
                <div class="search-box">
                    <div class="search-box__icon">
                        <i class="fas fa-search"></i>
                    </div>
                    <input type="text" class="search-box__input" placeholder="Search by name, ID, or contact...">
                </div>
                <select class="filter-dropdown">
                    <option>All Status</option>
                    <option>Active</option>
                    <option>Blocked</option>
                </select>
                <select class="filter-dropdown">
                    <option>Sort by: Rating</option>
                    <option>Sort by: Name (A-Z)</option>
                    <option>Sort by: Name (Z-A)</option>
                    <option>Sort by: Date Registered</option>
                    <option>Sort by: Total Orders</option>
                    <option>Sort by: Total Spent</option>
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
                    <tbody>
                        <asp:Repeater ID="rptCustomers" runat="server">
                            <ItemTemplate>
                                <tr>
                                    <td class="customer-id">CUST#-<%# Eval("CustomerID") %></td>
                                    <td>
                                        <div class="customer-name">
                                            <span class="customer-name__primary"><%# Eval("FullName") %></span>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="customer-contact">
                                            <span class="customer-contact__email"><%# Eval("Email") %></span>
                                            <span class="customer-contact__phone"><%# Eval("Contact") %></span>
                                        </div>
                                    </td>
                                    <td><%# Eval("DateRegistered", "{0:MMM dd, yyyy}") %></td>
                                    <td>
                                        <span class='status-badge status-badge--<%# Eval("Status").ToString().ToLower() %>'>
                                            <%# Eval("Status") %>
                                        </span>
                                    </td>
                                    <td class="customer-stats customer-stats--orders"><%# Eval("TotalOrders") %></td>
                                    <td class="customer-stats customer-stats--spent">₱<%# Eval("TotalSpent", "{0:N0}") %></td>
                                    <td>
                                        <div class="action-buttons">
                                            <button type="button" class="action-button action-button--view" title="View Details" onclick="viewCustomer('<%# Eval("CustomerID") %>'); return false;">
                                                <i class="fas fa-eye"></i>
                                            </button>
                                            <button type="button" class="action-button action-button--block" title="Block/Unblock" onclick="toggleBlockCustomer('<%# Eval("CustomerID") %>'); return false;">
                                                <i class="fas fa-ban"></i>
                                            </button>
                                            <button type="button" class="action-button action-button--delete" title="Delete Customer" onclick="deleteCustomer('<%# Eval("CustomerID") %>'); return false;">
                                                <i class="fas fa-trash"></i>
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>
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

    <script type="text/javascript">
        document.addEventListener('DOMContentLoaded', function () {
            var actionButtons = document.querySelectorAll('.action-button');
            actionButtons.forEach(function (button) {
                button.addEventListener('click', function (e) {
                    e.preventDefault();
                    e.stopPropagation();
                    return false;
                });
            });

            var headerButtons = document.querySelectorAll('.header-actions .btn');
            headerButtons.forEach(function (button) {
                button.addEventListener('click', function (e) {
                    e.preventDefault();
                    console.log('Button clicked:', this.textContent.trim());
                    return false;
                });
            });

            var paginationItems = document.querySelectorAll('.pagination-item:not(.pagination-item--disabled)');
            paginationItems.forEach(function (item) {
                item.addEventListener('click', function (e) {
                    e.preventDefault();
                    console.log('Page clicked');
                    return false;
                });
            });
        });

        function viewCustomer(customerId) {
            console.log('View customer:', customerId);
            alert('View customer: ' + customerId);
        }

        function toggleBlockCustomer(customerId) {
            console.log('Toggle block customer:', customerId);
            alert('Toggle block customer: ' + customerId);
        }

        function deleteCustomer(customerId) {
            console.log('Delete customer:', customerId);
            if (confirm('Are you sure you want to delete customer ' + customerId + '?')) {
                alert('Delete customer: ' + customerId);
            }
        }
    </script>
</asp:Content>