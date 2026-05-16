<%@ Page Title="Customer Management | TasteNet" Language="C#" MasterPageFile="~/MasterPages/SuperAdmin.Master" AutoEventWireup="true" CodeBehind="CustomerManagement.aspx.cs" Inherits="TasteNet.Users.SuperAdmin.CustomerManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" />
    
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

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
            --border-light: #e2d1d1;
            --border-hover: #d4b8b8;
            --bg-hover: #fefaf5;
            --bg-light: #f3ebe0;
            --bg-lighter: #f9f4ee;
            --card-shadow: 0 10px 30px rgba(107, 13, 30, 0.05);
            --card-shadow-hover: 0 15px 40px rgba(107, 13, 30, 0.12);
            --button-shadow: 0 4px 12px rgba(107, 13, 30, 0.2);
            --radius-sm: 8px;
            --radius-md: 10px;
            --radius-lg: 12px;
            --radius-xl: 16px;
            --transition-base: 0.3s ease;
        }

        body, form {
            background: var(--soft-cream) !important;
            font-family: 'Poppins', sans-serif;
        }

        #customer-wrapper {
            background: var(--soft-cream);
            padding: 20px 30px;
            max-width: 1600px;
            margin: 0 auto;
            min-height: 100vh;
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
            margin: 5px 0 0;
            font-size: 14px;
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
            font-size: 16px;
            transition: transform var(--transition-base);
        }

        .stat-card__icon--total { 
            background: #f9ecee; 
            color: var(--primary-maroon); 
        }
        .stat-card__icon--active { 
            background: var(--success-green-light); 
            color: var(--success-green); 
        }
        .stat-card__icon--blocked { 
            background: var(--warning-orange-light); 
            color: var(--warning-orange); 
        }
        .stat-card__icon--revenue { 
            background: #eff6ff; 
            color: #3b82f6; 
        }

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
            margin-top: 5px;
        }

        .filter-container {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
            flex-wrap: wrap;
            align-items: center;
        }

        .search-box {
            position: relative;
            flex: 1;
            max-width: 300px;
        }

        .search-box input {
            width: 100%;
            padding: 10px 15px 10px 40px;
            border: 2px solid var(--border-light);
            border-radius: var(--radius-md);
            font-family: 'Poppins', sans-serif;
            font-size: 13px;
            background: white;
            transition: all var(--transition-base);
            outline: none;
        }

        .search-box input:focus {
            border-color: var(--primary-maroon);
            box-shadow: 0 0 0 3px rgba(107, 13, 30, 0.1);
        }

        .search-box i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--muted-text);
            font-size: 14px;
        }

        .filter-select {
            padding: 10px 15px;
            border: 2px solid var(--border-light);
            border-radius: var(--radius-md);
            font-family: 'Poppins', sans-serif;
            font-size: 13px;
            background: white;
            cursor: pointer;
            transition: all var(--transition-base);
            outline: none;
            min-width: 130px;
        }

        .filter-select:focus {
            border-color: var(--primary-maroon);
            box-shadow: 0 0 0 3px rgba(107, 13, 30, 0.1);
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
        }

        .custom-table {
            width: 100%;
            border-collapse: collapse;
            min-width: 1000px;
        }

        .custom-table thead {
            background: white;
            border-bottom: 2px solid var(--bg-light);
        }

        .custom-table th {
            padding: 16px 12px;
            text-align: center;
            font-size: 12px;
            color: var(--muted-text);
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .custom-table td {
            padding: 16px 12px;
            text-align: center;
            border-bottom: 1px solid var(--bg-lighter);
            font-size: 13px;
            color: var(--text-dark);
            vertical-align: middle;
        }

        .custom-table tbody tr {
            transition: all var(--transition-base);
            border-left: 3px solid transparent;
        }

        .custom-table tbody tr:hover {
            background: var(--bg-hover);
            border-left-color: var(--primary-maroon);
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
        }

        .customer-name__secondary {
            color: var(--muted-text);
            font-size: 11px;
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
        }

        .customer-contact__phone {
            color: var(--muted-text);
            font-size: 11px;
        }

        .status-badge {
            padding: 4px 12px;
            border-radius: var(--radius-sm);
            font-size: 11px;
            font-weight: 700;
            display: inline-block;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .status-badge--active {
            background: var(--success-green-light);
            color: var(--success-green);
        }

        .status-badge--blocked {
            background: var(--danger-red-light);
            color: var(--danger-red);
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

        /* Action Buttons */
        .action-btns {
            display: flex;
            gap: 8px;
            justify-content: center;
        }

        .action-icon {
            width: 32px;
            height: 32px;
            border-radius: var(--radius-sm);
            background: var(--bg-lighter);
            border: none;
            cursor: pointer;
            transition: all var(--transition-base);
            font-size: 16px;
            color: var(--muted-text);
            display: inline-flex;
            align-items: center;
            justify-content: center;
            text-decoration: none;
        }

        .action-icon i {
            font-size: 16px;
        }

        .action-icon:hover {
            transform: translateY(-2px);
            background: var(--primary-maroon);
            color: white;
        }

        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 8px;
            margin-top: 20px;
        }

        .pagination-item {
            min-width: 36px;
            height: 36px;
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
            text-decoration: none;
        }

        .pagination-item:hover:not(.pagination-item--active, .pagination-item--disabled) {
            transform: translateY(-2px);
            border-color: var(--primary-maroon);
        }

        .pagination-item--active {
            background: var(--primary-maroon);
            color: white;
            border-color: var(--primary-maroon);
        }

        .pagination-item--disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }

        .modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0, 0, 0, 0.7);
            backdrop-filter: blur(5px);
            display: none;
            justify-content: center;
            align-items: center;
            z-index: 10000;
        }

        .customer-modal {
            background: white;
            border-radius: var(--radius-xl);
            max-width: 700px;
            width: 90%;
            max-height: 90vh;
            overflow-y: auto;
            animation: slideUp 0.3s ease;
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

        .modal-header {
            padding: 20px 25px;
            background: linear-gradient(135deg, var(--primary-maroon), var(--primary-maroon-dark));
            color: white;
            border-radius: var(--radius-xl) var(--radius-xl) 0 0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .modal-header h3 {
            margin: 0;
            font-size: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .modal-header .customer-id {
            background: rgba(255, 255, 255, 0.2);
            padding: 4px 12px;
            border-radius: var(--radius-sm);
            font-size: 13px;
        }

        .close-modal {
            background: rgba(255, 255, 255, 0.2);
            border: none;
            width: 32px;
            height: 32px;
            border-radius: 50%;
            color: white;
            cursor: pointer;
            font-size: 18px;
            transition: all var(--transition-base);
        }

        .close-modal:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: rotate(90deg);
        }

        .modal-body {
            padding: 25px;
        }

        .info-section {
            background: var(--soft-cream);
            border-radius: var(--radius-lg);
            padding: 20px;
            margin-bottom: 20px;
        }

        .info-section h4 {
            color: var(--primary-maroon);
            margin-bottom: 15px;
            font-size: 16px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .info-row {
            display: flex;
            justify-content: space-between;
            padding: 12px 0;
            border-bottom: 1px dashed var(--border-light);
        }

        .info-row:last-child {
            border-bottom: none;
        }

        .info-label {
            color: var(--muted-text);
            font-weight: 500;
            font-size: 13px;
        }

        .info-value {
            color: var(--text-dark);
            font-weight: 600;
            font-size: 13px;
            text-align: right;
        }

        .info-value.status-active {
            background: var(--success-green-light);
            color: var(--success-green);
            padding: 4px 12px;
            border-radius: var(--radius-sm);
        }

        .info-value.status-blocked {
            background: var(--danger-red-light);
            color: var(--danger-red);
            padding: 4px 12px;
            border-radius: var(--radius-sm);
        }

        .activity-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 15px;
            margin-top: 15px;
        }

        .activity-stat {
            text-align: center;
            padding: 15px;
            background: white;
            border-radius: var(--radius-md);
            transition: all var(--transition-base);
        }

        .activity-stat:hover {
            transform: translateY(-5px);
            box-shadow: var(--card-shadow);
        }

        .activity-stat__value {
            font-size: 24px;
            font-weight: 700;
            color: var(--primary-maroon);
        }

        .activity-stat__label {
            font-size: 11px;
            color: var(--muted-text);
            margin-top: 5px;
        }

        .recent-orders-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        .recent-orders-table th {
            padding: 10px;
            text-align: left;
            border-bottom: 2px solid var(--border-light);
            color: var(--muted-text);
            font-size: 11px;
            font-weight: 600;
        }

        .recent-orders-table td {
            padding: 10px;
            border-bottom: 1px solid var(--border-light);
            font-size: 12px;
        }

        .modal-footer {
            padding: 15px 25px;
            border-top: 1px solid var(--border-light);
            display: flex;
            gap: 10px;
            justify-content: flex-end;
        }

        .btn {
            padding: 8px 16px;
            border-radius: var(--radius-md);
            font-weight: 600;
            font-size: 12px;
            cursor: pointer;
            transition: all var(--transition-base);
            border: none;
            font-family: 'Poppins', sans-serif;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .btn--primary {
            background: var(--primary-maroon);
            color: white;
        }

        .btn--primary:hover {
            background: var(--primary-maroon-dark);
            transform: translateY(-2px);
        }

        .btn--outline {
            background: white;
            color: var(--primary-maroon);
            border: 2px solid var(--border-light);
        }

        .btn--outline:hover {
            border-color: var(--primary-maroon);
            background: var(--soft-cream);
        }

        .btn--success {
            background: var(--success-green);
            color: white;
        }

        .btn--success:hover {
            background: #1e7c5a;
            transform: translateY(-2px);
        }

        .no-results {
            text-align: center;
            padding: 60px;
            color: var(--muted-text);
            display: none;
        }

        .no-results i {
            font-size: 48px;
            margin-bottom: 15px;
            color: var(--border-light);
        }

        .delete-confirm-modal {
            background: white;
            border-radius: var(--radius-xl);
            max-width: 400px;
            width: 90%;
            padding: 30px;
            text-align: center;
            animation: slideUp 0.3s ease;
        }

        .delete-confirm-modal i {
            font-size: 48px;
            color: var(--danger-red);
            margin-bottom: 20px;
        }

        .delete-confirm-modal h3 {
            color: var(--text-dark);
            margin: 0 0 10px;
        }

        .delete-confirm-actions {
            display: flex;
            gap: 10px;
            justify-content: center;
            margin-top: 20px;
        }

        @media (max-width: 1200px) {
            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 768px) {
            #customer-wrapper {
                padding: 15px;
            }
            .stats-grid {
                grid-template-columns: 1fr;
            }
            .filter-container {
                flex-direction: column;
            }
            .search-box {
                max-width: 100%;
                width: 100%;
            }
            .filter-select {
                width: 100%;
            }
            .page-header {
                flex-direction: column;
                align-items: stretch;
            }
            .activity-grid {
                grid-template-columns: 1fr;
            }
            .modal-footer {
                flex-direction: column;
            }
            .modal-footer .btn {
                width: 100%;
                justify-content: center;
            }
        }

        @media (max-width: 480px) {
            .stat-card__value {
                font-size: 22px;
            }
            .custom-table th,
            .custom-table td {
                padding: 10px 8px;
                font-size: 11px;
            }
        }
    </style>

    <div id="customer-wrapper">
        <div class="page-header">
            <div class="header-title">
                <h2>Customer Management</h2>
                <p>Monitor and manage all registered customers and their activities</p>
            </div>
        </div>

        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-card__header">
                    <span class="stat-card__label">Total Customers</span>
                    <div class="stat-card__icon stat-card__icon--total">
                        <i class="fas fa-users"></i>
                    </div>
                </div>
                <div class="stat-card__value"><asp:Label ID="lblTotalCustomers" runat="server" Text="0" /></div>
                <div class="stat-card__trend">All registered accounts</div>
            </div>

            <div class="stat-card">
                <div class="stat-card__header">
                    <span class="stat-card__label">Active Customers</span>
                    <div class="stat-card__icon stat-card__icon--active">
                        <i class="fas fa-user-check"></i>
                    </div>
                </div>
                <div class="stat-card__value"><asp:Label ID="lblActiveCustomers" runat="server" Text="0" /></div>
                <div class="stat-card__trend">Currently active users</div>
            </div>

            <div class="stat-card">
                <div class="stat-card__header">
                    <span class="stat-card__label">Blocked</span>
                    <div class="stat-card__icon stat-card__icon--blocked">
                        <i class="fas fa-ban"></i>
                    </div>
                </div>
                <div class="stat-card__value"><asp:Label ID="lblBlockedCustomers" runat="server" Text="0" /></div>
                <div class="stat-card__trend">Suspended accounts</div>
            </div>

            <div class="stat-card">
                <div class="stat-card__header">
                    <span class="stat-card__label">Total Revenue</span>
                    <div class="stat-card__icon stat-card__icon--revenue">
                        <i class="fas fa-peso-sign"></i>
                    </div>
                </div>
                <div class="stat-card__value"><asp:Label ID="lblTotalRevenue" runat="server" Text="₱0" /></div>
                <div class="stat-card__trend">From all customer orders</div>
            </div>
        </div>

        <div class="filter-container">
            <div class="search-box">
                <i class="fas fa-search"></i>
                <input type="text" id="searchInput" placeholder="Search by name, ID, email, or phone...">
            </div>
            <select class="filter-select" id="statusFilter">
                <option value="all">All Status</option>
                <option value="active">Active</option>
                <option value="blocked">Blocked</option>
            </select>
            <select class="filter-select" id="sortFilter">
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

        <div class="table-container">
            <div class="table-wrapper">
                <asp:Repeater ID="rptCustomers" runat="server">
                    <HeaderTemplate>
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
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td><span class="customer-id"><%# Eval("CustomerID") %></span></td>
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
                                <div class="action-btns">
                                    <button type="button" class="action-icon" title="View Details" onclick='viewCustomer("<%# Eval("CustomerID").ToString().Replace("CUST-", "") %>")'>
                                        <i class="fas fa-eye"></i>
                                    </button>

                                    <asp:LinkButton ID="btnBlock" runat="server" CssClass="action-icon" 
                                        CommandName='<%# Eval("Status").ToString() == "ACTIVE" ? "BLOCK" : "UNBLOCK" %>'
                                        CommandArgument='<%# Eval("RawUserID") %>'
                                        ToolTip='<%# Eval("Status").ToString() == "ACTIVE" ? "Block Customer" : "Unblock Customer" %>'
                                        OnClick="btnToggleBlock_Click"
                                        OnClientClick="return confirm('Change this customer\'s status?');">
                                        <i class='<%# "fas " + (Eval("Status").ToString() == "ACTIVE" ? "fa-ban" : "fa-check") %>'></i>
                                    </asp:LinkButton>

                                    <asp:LinkButton ID="btnDelete" runat="server" CssClass="action-icon" 
                                        CommandArgument='<%# Eval("RawUserID") %>'
                                        ToolTip="Delete Customer"
                                        OnClick="btnDelete_Click"
                                        OnClientClick="return confirm('Permanently delete this customer? This cannot be undone.');">
                                        <i class="fas fa-trash-alt"></i>
                                    </asp:LinkButton>
                                </div>
                             </td>
                         </tr>
                    </ItemTemplate>
                    <AlternatingItemTemplate>
                        <tr style="background-color: #fefaf5;">
                            <td><span class="customer-id"><%# Eval("CustomerID") %></span></td>
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
                                <div class="action-btns">
                                    <button type="button" class="action-icon" title="View Details" onclick='viewCustomer("<%# Eval("CustomerID").ToString().Replace("CUST-", "") %>")'>
                                        <i class="fas fa-eye"></i>
                                    </button>

                                    <asp:LinkButton ID="LinkButton1" runat="server" CssClass="action-icon" 
                                        CommandName='<%# Eval("Status").ToString() == "ACTIVE" ? "BLOCK" : "UNBLOCK" %>'
                                        CommandArgument='<%# Eval("RawUserID") %>'
                                        ToolTip='<%# Eval("Status").ToString() == "ACTIVE" ? "Block Customer" : "Unblock Customer" %>'
                                        OnClick="btnToggleBlock_Click"
                                        OnClientClick="return confirm('Change this customer\'s status?');">
                                        <i class='<%# "fas " + (Eval("Status").ToString() == "ACTIVE" ? "fa-ban" : "fa-check") %>'></i>
                                    </asp:LinkButton>

                                    <asp:LinkButton ID="LinkButton2" runat="server" CssClass="action-icon" 
                                        CommandArgument='<%# Eval("RawUserID") %>'
                                        ToolTip="Delete Customer"
                                        OnClick="btnDelete_Click"
                                        OnClientClick="return confirm('Permanently delete this customer? This cannot be undone.');">
                                        <i class="fas fa-trash-alt"></i>
                                    </asp:LinkButton>
                                </div>
                             </td>
                         </tr>
                    </AlternatingItemTemplate>
                    <FooterTemplate>
                            </tbody>
                        </table>
                    </FooterTemplate>
                </asp:Repeater>
                <div class="no-results" id="noResultsMessage">
                    <i class="fas fa-search"></i>
                    <h3>No customers found</h3>
                    <p>Try adjusting your search or filters</p>
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
                    <span class="customer-id" id="modalCustomerId">CUST-000</span>
                </h3>
                <button class="close-modal" onclick="closeModal()">
                    <i class="fas fa-times"></i>
                </button>
            </div>
            <div class="modal-body">
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
                        <span class="info-value" id="modalStatus">Loading</span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Last Login:</span>
                        <span class="info-value" id="modalLastLogin">Today, 10:30 AM</span>
                    </div>
                </div>

                <div class="info-section">
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

                <div class="info-section">
                    <h4><i class="fas fa-history"></i> Recent Orders</h4>
                    <div id="recentOrders">
                        <p style="text-align: center; color: var(--muted-text); padding: 20px;">
                            <i class="fas fa-spinner fa-pulse"></i> Loading order history...
                        </p>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn--outline" onclick="closeModal()">
                    <i class="fas fa-times"></i> Close
                </button>
                <button class="btn btn--primary" id="modalActionButton">
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
            const rows = document.querySelectorAll('#customer-wrapper .custom-table tbody tr');
            allCustomers = Array.from(rows).map(row => {
                const cells = row.querySelectorAll('td');
                const id = row.getAttribute('data-customer-id') || cells[0]?.querySelector('.customer-id')?.textContent.replace('CUST-', '') || '';
                const fullName = cells[1]?.querySelector('.customer-name__primary')?.textContent || '';
                const username = cells[1]?.querySelector('.customer-name__secondary')?.textContent || '';
                const email = cells[2]?.querySelector('.customer-contact__email')?.textContent || '';
                const phone = cells[2]?.querySelector('.customer-contact__phone')?.textContent || '';
                const dateRegistered = cells[3]?.textContent || '';
                const statusText = cells[4]?.querySelector('.status-badge')?.textContent || '';
                const status = statusText.toLowerCase();
                const totalOrders = parseInt(cells[5]?.textContent) || 0;
                const totalSpent = parseFloat(cells[6]?.textContent.replace('₱', '').replace(/,/g, '')) || 0;

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
                    lastLogin: 'Today, 10:30 AM'
                };
            });
            updateStats();
        }

        let searchTimeout;
        function handleSearch() {
            clearTimeout(searchTimeout);
            const searchInput = document.getElementById('searchInput');
            const searchTerm = searchInput.value.toLowerCase().trim();

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
            }, 300);
        }

        function handleFilter() {
            const statusFilter = document.getElementById('statusFilter');
            const selectedStatus = statusFilter.value;

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
                    <h3>No ${selectedStatus} customers found</h3>
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

            const tbody = document.querySelector('#customer-wrapper .custom-table tbody');
            const rows = Array.from(tbody.querySelectorAll('tr'));

            rows.sort((a, b) => {
                const aData = allCustomers.find(c => c.element === a);
                const bData = allCustomers.find(c => c.element === b);

                if (!aData || !bData) return 0;

                switch (sortBy) {
                    case 'name-asc': return aData.fullName.localeCompare(bData.fullName);
                    case 'name-desc': return bData.fullName.localeCompare(aData.fullName);
                    case 'date-desc': return new Date(bData.dateRegistered) - new Date(aData.dateRegistered);
                    case 'date-asc': return new Date(aData.dateRegistered) - new Date(bData.dateRegistered);
                    case 'orders-desc': return bData.totalOrders - aData.totalOrders;
                    case 'orders-asc': return aData.totalOrders - bData.totalOrders;
                    case 'spent-desc': return bData.totalSpent - aData.totalSpent;
                    case 'spent-asc': return aData.totalSpent - bData.totalSpent;
                    default: return 0;
                }
            });

            rows.forEach((row, index) => {
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
            document.getElementById('modalUsername').textContent = customer.username;
            document.getElementById('modalEmail').textContent = customer.email;
            document.getElementById('modalPhone').textContent = customer.phone;
            document.getElementById('modalDateRegistered').textContent = customer.dateRegistered;
            document.getElementById('modalLastLogin').textContent = customer.lastLogin;

            const statusElement = document.getElementById('modalStatus');
            const statusText = customer.status.charAt(0).toUpperCase() + customer.status.slice(1);
            statusElement.textContent = statusText;
            statusElement.className = customer.status === 'active'
                ? 'info-value status-active'
                : 'info-value status-blocked';

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
            document.body.style.overflow = 'hidden';

            document.addEventListener('keydown', handleModalKeydown);
        }

        function closeModal() {
            const modal = document.getElementById('customerModal');
            const deleteModal = document.getElementById('deleteConfirmModal');
            modal.style.display = 'none';
            deleteModal.style.display = 'none';
            document.body.style.overflow = 'auto';
            document.removeEventListener('keydown', handleModalKeydown);
            document.removeEventListener('keydown', handleDeleteModalKeydown);
            customerToDelete = null;
        }

        function handleModalKeydown(e) {
            if (e.key === 'Escape') closeModal();
        }

        function handleDeleteModalKeydown(e) {
            if (e.key === 'Escape') closeModal();
        }

        function loadRecentOrders(customerId) {
            const recentOrdersDiv = document.getElementById('recentOrders');
            const recentOrders = [
                { id: `ORD-${customerId}-001`, date: 'Today', amount: '₱1,250', status: 'Delivered' },
                { id: `ORD-${customerId}-002`, date: 'Yesterday', amount: '₱850', status: 'Processing' },
                { id: `ORD-${customerId}-003`, date: '2 days ago', amount: '₱2,150', status: 'Delivered' }
            ];

            let html = '<table class="recent-orders-table">';
            html += '<thead><tr><th>Order ID</th><th>Date</th><th>Amount</th><th>Status</th></tr></thead><tbody>';
            recentOrders.forEach(order => {
                html += `<tr>`;
                html += `<td><strong>${order.id}</strong></td>`;
                html += `<td>${order.date}</td>`;
                html += `<td style="color: var(--primary-maroon); font-weight: 600;">${order.amount}</td>`;
                html += `<td><span class="status-badge status-badge--active">${order.status}</span></td>`;
                html += `</tr>`;
            });
            html += '</tbody></table>';
            recentOrdersDiv.innerHTML = html;
        }

        function toggleBlockCustomer(customerId) {
            const customer = allCustomers.find(c => c.id === customerId);
            if (!customer) return;

            const row = customer.element;
            const statusBadge = row.querySelector('.status-badge');

            if (customer.status === 'active') {
                customer.status = 'blocked';
                statusBadge.textContent = 'Blocked';
                statusBadge.className = 'status-badge status-badge--blocked';
            } else {
                customer.status = 'active';
                statusBadge.textContent = 'Active';
                statusBadge.className = 'status-badge status-badge--active';
            }

            updateStats();
            handleFilter();
            showNotification(`Customer ${customer.status === 'active' ? 'unblocked' : 'blocked'} successfully!`, 'success');
        }

        function updateStats() {
            const activeCustomers = allCustomers.filter(c => c.status === 'active').length;
            const blockedCustomers = allCustomers.filter(c => c.status === 'blocked').length;
            const totalCustomers = activeCustomers + blockedCustomers;

            const totalElement = document.getElementById('lblTotalCustomers');
            const activeElement = document.getElementById('lblActiveCustomers');
            const blockedElement = document.getElementById('lblBlockedCustomers');

            if (totalElement) totalElement.textContent = totalCustomers;
            if (activeElement) activeElement.textContent = activeCustomers;
            if (blockedElement) blockedElement.textContent = blockedCustomers;
        }

        function showNotification(message, type) {
            const notification = document.createElement('div');
            notification.style.cssText = `
                position: fixed; top: 20px; right: 20px; padding: 15px 20px;
                background: ${type === 'success' ? 'var(--success-green)' : 'var(--danger-red)'};
                color: white; border-radius: var(--radius-md); z-index: 10001;
                animation: slideInRight 0.3s ease; font-family: 'Poppins', sans-serif;
                box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            `;
            notification.innerHTML = `<i class="fas ${type === 'success' ? 'fa-check-circle' : 'fa-exclamation-circle'}"></i> ${message}`;
            document.body.appendChild(notification);

            setTimeout(() => {
                notification.style.opacity = '0';
                notification.style.transition = 'opacity 0.3s ease';
                setTimeout(() => notification.remove(), 300);
            }, 3000);
        }

        const style = document.createElement('style');
        style.textContent = `
            @keyframes slideInRight {
                from { transform: translateX(100%); opacity: 0; }
                to { transform: translateX(0); opacity: 1; }
            }
        `;
        document.head.appendChild(style);

        document.addEventListener('DOMContentLoaded', function () {
            initializeCustomerData();

            document.getElementById('searchInput')?.addEventListener('input', handleSearch);
            document.getElementById('statusFilter')?.addEventListener('change', handleFilter);
            document.getElementById('sortFilter')?.addEventListener('change', handleSort);

            const modal = document.getElementById('customerModal');
            if (modal) modal.addEventListener('click', (e) => { if (e.target === modal) closeModal(); });

            const deleteModal = document.getElementById('deleteConfirmModal');
            if (deleteModal) deleteModal.addEventListener('click', (e) => { if (e.target === deleteModal) closeModal(); });
        });
    </script>
</asp:Content>