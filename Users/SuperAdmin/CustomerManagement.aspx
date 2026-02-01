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
            
            --radius-sm: 10px;
            --radius-md: 12px;
            --radius-lg: 16px;
            --radius-xl: 20px;
            --radius-2xl: 25px;
            
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
            padding: 25px 35px;
            max-width: 1600px;
            margin: 0 auto;
            background-color: var(--soft-cream) !important;
            min-height: 100vh;
        }

        .dashboard-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 35px;
            flex-wrap: wrap;
            gap: 20px;
        }

        .header-content h1 {
            font-size: 32px;
            font-weight: 700;
            margin: 0;
            color: var(--text-dark);
            letter-spacing: -0.5px;
        }

        .header-content p {
            color: var(--muted-text);
            margin: 8px 0 0 0;
            font-size: 16px;
            line-height: 1.5;
        }

        .header-actions {
            display: flex;
            gap: 12px;
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
            padding: 25px;
            border-radius: var(--radius-xl);
            box-shadow: var(--card-shadow);
            transition: transform var(--transition-base), box-shadow var(--transition-base);
            border: 2px solid transparent;
            cursor: pointer;
            position: relative;
            overflow: hidden;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--card-shadow-hover);
            border-color: var(--border-light);
        }

        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
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
            margin-bottom: 15px;
        }

        .stat-card__label {
            font-size: 14px;
            font-weight: 500;
            color: var(--muted-text);
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .stat-card__icon {
            width: 48px;
            height: 48px;
            border-radius: var(--radius-md);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
            flex-shrink: 0;
        }

        .stat-card__icon--total { background: var(--accent-yellow-light); color: var(--warning-orange); }
        .stat-card__icon--active { background: var(--success-green-light); color: var(--success-green); }
        .stat-card__icon--blocked { background: var(--warning-orange-light); color: var(--warning-orange); }
        .stat-card__icon--revenue { background: var(--accent-pink); color: var(--primary-maroon); }

        .stat-card__value {
            font-size: 36px;
            font-weight: 700;
            color: var(--primary-maroon);
            margin: 10px 0;
            line-height: 1;
        }

        .stat-card__trend {
            font-size: 13px;
            font-weight: 600;
            color: var(--muted-text);
        }

        .filter-container {
            background: white;
            border-radius: var(--radius-xl);
            padding: 25px;
            box-shadow: var(--card-shadow);
            margin-bottom: 30px;
            display: grid;
            grid-template-columns: 1fr auto;
            gap: 30px;
            align-items: center;
        }

        .search-box {
            position: relative;
            max-width: 500px;
        }

        .search-box__icon {
            position: absolute;
            left: 20px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--muted-text);
            font-size: 16px;
            z-index: 2;
        }

        .search-box__input {
            width: 100%;
            padding: 16px 20px 16px 50px;
            border: 2px solid var(--border-light);
            border-radius: var(--radius-lg);
            font-size: 15px;
            font-family: 'Poppins', sans-serif;
            background: white;
            color: var(--text-dark);
            transition: all var(--transition-base);
            outline: none;
            font-weight: 500;
        }

        .search-box__input:focus {
            border-color: var(--primary-maroon);
            box-shadow: 0 0 0 4px rgba(107, 13, 30, 0.08);
        }

        .search-box__input::placeholder {
            color: var(--muted-text);
            opacity: 0.7;
        }

        .filter-group {
            display: flex;
            gap: 15px;
            align-items: center;
        }

        .filter-dropdown {
            padding: 14px 20px;
            border: 2px solid var(--border-light);
            border-radius: var(--radius-lg);
            background: white;
            color: var(--text-dark);
            font-size: 15px;
            font-family: 'Poppins', sans-serif;
            cursor: pointer;
            min-width: 180px;
            outline: none;
            font-weight: 500;
            transition: all var(--transition-base);
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='%238a6d6d' viewBox='0 0 16 16'%3E%3Cpath d='M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 15px center;
            background-size: 12px;
            padding-right: 40px;
        }

        .filter-dropdown:hover {
            border-color: var(--border-hover);
        }

        .filter-dropdown:focus {
            border-color: var(--primary-maroon);
            box-shadow: 0 0 0 3px rgba(107, 13, 30, 0.05);
        }

        .table-section {
            background: white;
            border-radius: var(--radius-2xl);
            padding: 5px 5px 25px 5px;
            box-shadow: var(--card-shadow);
            overflow: hidden;
            margin-bottom: 30px;
        }

        .table-section__header {
            padding: 25px 30px 15px;
            border-bottom: 1px solid var(--bg-light);
            margin-bottom: 10px;
        }

        .table-section__title {
            font-size: 20px;
            font-weight: 700;
            color: var(--primary-maroon);
            margin: 0;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .custom-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            min-width: 1200px;
        }

        .custom-table thead {
            background: var(--soft-cream);
        }

        .custom-table th {
            padding: 20px 16px;
            text-align: left;
            font-size: 14px;
            color: var(--muted-text);
            font-weight: 600;
            border-bottom: 2px solid var(--bg-light);
            letter-spacing: 0.3px;
            text-transform: uppercase;
            white-space: nowrap;
        }

        .custom-table th:first-child {
            padding-left: 30px;
            border-radius: var(--radius-md) 0 0 0;
        }

        .custom-table th:last-child {
            padding-right: 30px;
            border-radius: 0 var(--radius-md) 0 0;
        }

        .custom-table td {
            padding: 22px 16px;
            border-bottom: 1px solid var(--bg-lighter);
            font-size: 15px;
            vertical-align: middle;
            color: var(--text-dark);
            text-align: left;
        }

        .custom-table td:first-child {
            padding-left: 30px;
        }

        .custom-table td:last-child {
            padding-right: 30px;
        }

        .custom-table tbody tr {
            transition: all var(--transition-base);
            position: relative;
        }

        .custom-table tbody tr:hover {
            background-color: var(--bg-hover);
            transform: translateX(4px);
        }

        .custom-table tbody tr:last-child td {
            border-bottom: none;
        }

        .customer-id {
            color: var(--primary-maroon);
            font-weight: 700;
            font-size: 15px;
            font-family: 'Courier New', monospace;
        }

        .customer-name {
            display: flex;
            flex-direction: column;
            gap: 4px;
        }

        .customer-name__primary {
            color: var(--text-dark);
            font-weight: 600;
            font-size: 16px;
        }

        .customer-name__secondary {
            color: var(--muted-text);
            font-size: 13px;
            font-weight: 500;
        }

        .customer-contact {
            display: flex;
            flex-direction: column;
            gap: 2px;
        }

        .customer-contact__email {
            color: var(--text-dark);
            font-size: 14px;
            font-weight: 500;
        }

        .customer-contact__phone {
            color: var(--muted-text);
            font-size: 13px;
        }

        .customer-stats {
            font-weight: 700;
            font-size: 16px;
        }

        .customer-stats--orders {
            color: var(--primary-maroon);
        }

        .customer-stats--spent {
            color: var(--success-green);
        }

        .status-badge {
            padding: 8px 16px;
            border-radius: var(--radius-md);
            font-size: 12px;
            font-weight: 700;
            display: inline-block;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            min-width: 80px;
            text-align: center;
        }

        .status-badge--active {
            background: var(--success-green-light);
            color: var(--success-green);
        }

        .status-badge--blocked {
            background: var(--danger-red-light);
            color: var(--danger-red);
        }

        .action-buttons {
            display: flex;
            gap: 12px;
            align-items: center;
        }

        .action-button {
            width: 40px;
            height: 40px;
            border-radius: var(--radius-md);
            display: flex;
            align-items: center;
            justify-content: center;
            background: var(--bg-lighter);
            color: var(--muted-text);
            border: none;
            cursor: pointer;
            transition: all var(--transition-fast);
            font-size: 14px;
            position: relative;
        }

        .action-button:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
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
            bottom: -30px;
            left: 50%;
            transform: translateX(-50%);
            background: var(--text-dark);
            color: white;
            padding: 4px 8px;
            border-radius: var(--radius-sm);
            font-size: 11px;
            white-space: nowrap;
            z-index: 10;
            pointer-events: none;
        }

        .btn {
            padding: 10px 20px;
            border-radius: var(--radius-lg);
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
            gap: 8px;
            margin-top: 30px;
            padding: 0 20px;
        }

        .pagination-item {
            min-width: 40px;
            height: 40px;
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
            font-size: 14px;
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

        @media (max-width: 1400px) {
            .stat-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 1200px) {
            .filter-container {
                grid-template-columns: 1fr;
                gap: 20px;
            }
            
            .filter-group {
                justify-content: flex-start;
            }
        }

        @media (max-width: 992px) {
            .dashboard-wrapper {
                padding: 20px;
            }
            
            .dashboard-header {
                flex-direction: column;
                align-items: stretch;
                gap: 20px;
            }
            
            .header-actions {
                justify-content: flex-start;
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
            
            .filter-group {
                flex-direction: column;
                width: 100%;
            }
            
            .filter-dropdown {
                width: 100%;
                min-width: auto;
            }
            
            .table-section {
                border-radius: var(--radius-lg);
                padding: 15px;
            }
            
            .custom-table th,
            .custom-table td {
                padding: 15px 10px;
                font-size: 14px;
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
                padding: 15px;
            }
            
            .header-content h1 {
                font-size: 24px;
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

            .stat-label {
                font-size: 14px;
                font-weight: 500;
                color: var(--muted-text);
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 12px;
            }

            .stat-value { 
                font-size: 32px;
                font-weight: 700; 
                color: var(--primary-maroon); 
                margin: 8px 0;
                line-height: 1;
            }

            .stat-trend { 
                font-size: 13px;
                font-weight: 600; 
                margin-top: 10px;
            }
            
            .btn {
                padding: 8px 16px;
                font-size: 13px;
                min-height: 36px;
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
            .filter-container,
            .action-buttons,
            .pagination {
                display: none !important;
            }
            
            .table-section {
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
        .table-section {
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
                <button type="button" class="btn btn--secondary">
                    <i class="fas fa-plus"></i>
                    Add Customer
                </button>
                <button type="button" class="btn btn--primary">
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

        <div class="filter-container">
            <div class="search-box">
                <div class="search-box__icon">
                    <i class="fas fa-search"></i>
                </div>
                <input type="text" class="search-box__input" placeholder="Search by name, ID, email, or contact number...">
            </div>
            <div class="filter-group">
                <select class="filter-dropdown">
                    <option>All Status</option>
                    <option>Active</option>
                    <option>Blocked</option>
                </select>
                <select class="filter-dropdown">
                    <option>Sort by: Name (A-Z)</option>
                    <option>Sort by: Name (Z-A)</option>
                    <option>Sort by: Date Registered</option>
                    <option>Sort by: Total Orders</option>
                    <option>Sort by: Total Spent</option>
                </select>
            </div>
        </div>

        <div class="table-section">
            <div class="table-section__header">
                <h3 class="table-section__title">
                    <i class="fas fa-users"></i>
                    Customer Directory
                </h3>
            </div>
            
            <div style="overflow-x: auto;">
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
                                    <td class="customer-id">#<%# Eval("CustomerID") %></td>
                                    <td>
                                        <div class="customer-name">
                                            <span class="customer-name__primary"><%# Eval("FullName") %></span>
                                            <span class="customer-name__secondary">@<%# Eval("Username") %></span>
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
                                            <button class="action-button action-button--view" title="View Details">
                                                <i class="fas fa-eye"></i>
                                            </button>
                                            <button class="action-button action-button--edit" title="Edit Customer">
                                                <i class="fas fa-edit"></i>
                                            </button>
                                            <button class="action-button action-button--block" title="Block/Unblock">
                                                <i class="fas fa-ban"></i>
                                            </button>
                                            <button class="action-button action-button--delete" title="Delete Customer">
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
            <button class="pagination-item pagination-item--disabled">
                <i class="fas fa-chevron-left"></i>
            </button>
            <button class="pagination-item pagination-item--active">1</button>
            <button class="pagination-item">2</button>
            <button class="pagination-item">3</button>
            <button class="pagination-item">
                <i class="fas fa-chevron-right"></i>
            </button>
        </div>
    </div>
</asp:Content>