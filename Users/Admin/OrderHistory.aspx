<%@ Page Title="Order History | TasteNet" Language="C#" MasterPageFile="~/MasterPages/Admin.Master" AutoEventWireup="true" CodeBehind="OrderHistory.aspx.cs" Inherits="TasteNet.Users.Admin.OrderHistory" %>
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
            --info-blue: #3b82f6;
            --info-blue-light: #eff6ff;
            --border-light: #e2d1d1;
            --border-hover: #d4b8b8;
            --bg-hover: #fefaf5;
            --bg-lighter: #f9f4ee;
            --card-shadow: 0 10px 30px rgba(107, 13, 30, 0.05);
            --card-shadow-hover: 0 15px 40px rgba(107, 13, 30, 0.12);
            --button-shadow: 0 4px 12px rgba(107, 13, 30, 0.2);
            --radius-sm: 8px;
            --radius-md: 10px;
            --radius-lg: 12px;
            --radius-xl: 16px;
            --transition-fast: 0.2s ease;
            --transition-base: 0.3s ease;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        html, body, form {
            margin: 0;
            padding: 0;
            background-color: var(--soft-cream);
            width: 100%;
            font-family: 'Poppins', sans-serif;
            color: var(--text-dark);
            min-height: 100vh;
        }

        .order-history-container {
            background: var(--soft-cream);
            padding: 25px 35px;
            max-width: 1600px;
            margin: 0 auto;
            min-height: 100vh;
            width: 100%;
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
            margin: 0;
            letter-spacing: -0.5px;
        }

        .header-title p {
            color: var(--muted-text);
            margin: 6px 0 0;
            font-size: 14px;
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
            display: inline-flex;
            align-items: center;
            gap: 8px;
            text-decoration: none;
            box-shadow: var(--button-shadow);
        }

        .admin-btn:hover {
            background: var(--primary-maroon-dark);
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(107, 13, 30, 0.25);
        }

        /* Statistics Grid */
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
            transition: all var(--transition-base);
            transform-origin: center;
        }

        .stat-card:hover .stat-card__icon {
            transform: scale(1.1) rotate(5deg);
        }

        .stat-card__icon--total { background: var(--warning-orange-light); color: var(--warning-orange); }
        .stat-card__icon--completed { background: var(--success-green-light); color: var(--success-green); }
        .stat-card__icon--progress { background: var(--info-blue-light); color: var(--info-blue); }
        .stat-card__icon--revenue { background: #e8f5e9; color: #2e7d32; }

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

        /* Filter Section */
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
            box-sizing: border-box;
        }

        .search-box__input:focus {
            border-color: var(--primary-maroon);
            box-shadow: 0 0 0 3px rgba(107, 13, 30, 0.1);
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
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='14' height='14' fill='%238a6d6d' viewBox='0 0 16 16'%3E%3Cpath d='M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 12px center;
            background-size: 10px;
            height: 38px;
            box-sizing: border-box;
        }

        .filter-dropdown:hover {
            border-color: var(--primary-maroon);
            transform: translateY(-1px);
        }

        /* Orders Container */
        .orders-container {
            background: white;
            border-radius: var(--radius-lg);
            box-shadow: var(--card-shadow);
            overflow: hidden;
            margin-bottom: 20px;
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
            text-transform: uppercase;
            background: white;
        }

        .orders-table td {
            padding: 16px 12px;
            border-bottom: 1px solid var(--bg-lighter);
            font-size: 13px;
            vertical-align: middle;
            color: var(--text-dark);
            text-align: center;
        }

        .orders-table tbody tr {
            transition: all var(--transition-base);
            border-left: 3px solid transparent;
        }

        .orders-table tbody tr:hover {
            background: linear-gradient(90deg, var(--bg-hover) 0%, white 100%);
            border-left: 3px solid var(--primary-maroon);
            transform: translateX(2px);
        }

        .order-id {
            color: var(--primary-maroon);
            font-weight: 700;
            font-family: 'Courier New', monospace;
        }

        .customer-name {
            font-weight: 600;
            color: var(--text-dark);
        }

        .customer-contact {
            font-size: 11px;
            color: var(--muted-text);
            margin-top: 4px;
        }

        .order-total {
            font-weight: 700;
            color: var(--primary-maroon);
        }

        .order-status {
            display: inline-block;
            padding: 4px 12px;
            border-radius: var(--radius-sm);
            font-size: 10px;
            font-weight: 700;
            text-transform: uppercase;
            min-width: 90px;
            text-align: center;
        }

        .status-open { background: var(--warning-orange-light); color: var(--warning-orange); }
        .status-inprogress { background: var(--info-blue-light); color: var(--info-blue); }
        .status-completed { background: var(--success-green-light); color: var(--success-green); }
        .status-cancelled { background: var(--danger-red-light); color: var(--danger-red); }

        .priority-rush {
            display: inline-block;
            padding: 2px 8px;
            border-radius: 12px;
            font-size: 10px;
            font-weight: 600;
            background: var(--danger-red-light);
            color: var(--danger-red);
        }

        .action-buttons {
            display: flex;
            gap: 6px;
            align-items: center;
            justify-content: center;
        }

        .action-button {
            width: 28px;
            height: 28px;
            border-radius: var(--radius-sm);
            display: inline-flex;
            align-items: center;
            justify-content: center;
            background: var(--bg-lighter);
            border: none;
            cursor: pointer;
            transition: all var(--transition-base);
            text-decoration: none;
            color: var(--text-dark);
        }

        .action-button:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        }

        .action-button.view:hover { background: var(--primary-maroon); color: white; }
        .action-button.update:hover { background: var(--success-green); color: white; }

        /* Items Row */
        .items-row {
            display: none;
            background: #fefaf5;
        }

        .items-row.show {
            display: table-row;
        }

        .items-container {
            padding: 20px;
        }

        .items-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 2px solid var(--border-light);
        }

        .items-header h4 {
            color: var(--primary-maroon);
            font-size: 14px;
            font-weight: 600;
            margin: 0;
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
        }

        .items-table td {
            padding: 10px;
            border-bottom: 1px solid var(--border-light);
        }

        /* Pagination */
        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 6px;
            margin-top: 20px;
            padding: 20px;
        }

        .page-link {
            min-width: 34px;
            height: 34px;
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
            text-decoration: none;
        }

        .page-link:hover {
            border-color: var(--primary-maroon);
            color: var(--primary-maroon);
            transform: translateY(-2px);
        }

        .page-link.active {
            background: var(--primary-maroon);
            color: white;
            border-color: var(--primary-maroon);
        }

        /* Modal */
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
            backdrop-filter: blur(8px);
            display: none;
        }

        .customer-modal {
            background: white;
            border-radius: var(--radius-xl);
            max-width: 800px;
            width: 90%;
            max-height: 90vh;
            overflow-y: auto;
            box-shadow: 0 25px 50px rgba(0,0,0,0.25);
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
        }

        .close-modal:hover {
            transform: rotate(90deg);
        }

        .modal-body {
            padding: 30px;
        }

        .no-results {
            text-align: center;
            padding: 60px 20px;
            color: var(--muted-text);
        }

        .no-results i {
            font-size: 64px;
            margin-bottom: 20px;
            color: var(--border-light);
        }

        /* Responsive */
        @media (max-width: 1400px) {
            .stat-grid { grid-template-columns: repeat(2, 1fr); }
        }

        @media (max-width: 1200px) {
            .order-history-container { padding: 15px 20px; }
            .filter-row { flex-wrap: wrap; }
            .search-box { min-width: 100%; }
            .filter-dropdown { min-width: calc(50% - 4px); }
        }

        @media (max-width: 768px) {
            .stat-grid { grid-template-columns: 1fr; }
            .filter-row { flex-direction: column; }
            .filter-dropdown { width: 100%; }
            .orders-table th, .orders-table td { padding: 12px 8px; font-size: 11px; }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Order Details Modal -->
    <div id="orderModal" class="modal-overlay" style="display: none;">
        <div class="customer-modal">
            <div class="modal-header">
                <h3>
                    <i class="fas fa-receipt"></i>
                    Order Details
                </h3>
                <button class="close-modal" onclick="closeModal()">
                    <i class="fas fa-times"></i>
                </button>
            </div>
            <div class="modal-body" id="modalBody">
                <div style="text-align: center; padding: 40px;">
                    <i class="fas fa-spinner fa-spin" style="font-size: 48px; color: var(--primary-maroon);"></i>
                    <p style="margin-top: 20px;">Loading order details...</p>
                </div>
            </div>
        </div>
    </div>

    <div class="order-history-container">
        <!-- Page Header -->
        <div class="page-header-main">
            <div class="header-title">
                <h1>Order History</h1>
                <p>View and manage all customer orders</p>
            </div>
            <div>
                <asp:LinkButton ID="btnExport" runat="server" CssClass="admin-btn" OnClick="btnExport_Click">
                    <i class="fas fa-download"></i> Export Report
                </asp:LinkButton>
                <asp:LinkButton ID="btnReset" runat="server" CssClass="admin-btn" OnClick="btnReset_Click" style="background: var(--muted-text); margin-left: 10px;">
                    <i class="fas fa-undo"></i> Reset Filters
                </asp:LinkButton>
            </div>
        </div>

        <!-- Statistics Grid -->
        <div class="stat-grid">
            <div class="stat-card">
                <div class="stat-card__header">
                    <span class="stat-card__label">Total Orders</span>
                    <div class="stat-card__icon stat-card__icon--total">
                        <i class="fas fa-shopping-bag"></i>
                    </div>
                </div>
                <div class="stat-card__value">
                    <asp:Label ID="lblTotalOrders" runat="server" Text="0"></asp:Label>
                </div>
                <div class="stat-card__trend">All customer orders</div>
            </div>

            <div class="stat-card">
                <div class="stat-card__header">
                    <span class="stat-card__label">Completed</span>
                    <div class="stat-card__icon stat-card__icon--completed">
                        <i class="fas fa-check-circle"></i>
                    </div>
                </div>
                <div class="stat-card__value">
                    <asp:Label ID="lblCompletedOrders" runat="server" Text="0"></asp:Label>
                </div>
                <div class="stat-card__trend">Successfully delivered</div>
            </div>

            <div class="stat-card">
                <div class="stat-card__header">
                    <span class="stat-card__label">In Progress</span>
                    <div class="stat-card__icon stat-card__icon--progress">
                        <i class="fas fa-spinner"></i>
                    </div>
                </div>
                <div class="stat-card__value">
                    <asp:Label ID="lblInProgressOrders" runat="server" Text="0"></asp:Label>
                </div>
                <div class="stat-card__trend">Currently processing</div>
            </div>

            <div class="stat-card">
                <div class="stat-card__header">
                    <span class="stat-card__label">Total Revenue</span>
                    <div class="stat-card__icon stat-card__icon--revenue">
                        <i class="fas fa-peso-sign"></i>
                    </div>
                </div>
                <div class="stat-card__value">
                    <asp:Label ID="lblTotalRevenue" runat="server" Text="₱0"></asp:Label>
                </div>
                <div class="stat-card__trend">From all orders</div>
            </div>
        </div>

        <!-- Filter Section -->
        <div class="filter-section">
            <div class="filter-row">
                <div class="search-box">
                    <div class="search-box__icon">
                        <i class="fas fa-search"></i>
                    </div>
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="search-box__input" 
                        placeholder="Search by order #, customer, email, or phone..."></asp:TextBox>
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

        <!-- Hidden button for search postback -->
        <asp:Button ID="btnHiddenSearch" runat="server" OnClick="btnSearch_Click" style="display: none;" />

        <!-- Orders Repeater -->
        <div class="orders-container">
            <div class="table-wrapper">
                <asp:Repeater ID="rptOrders" runat="server" OnItemDataBound="rptOrders_ItemDataBound" OnItemCommand="rptOrders_ItemCommand">
                    <HeaderTemplate>
                        <table class="orders-table">
                            <thead>
                                <tr>
                                    <th>Order #</th>
                                    <th>Customer</th>
                                    <th>Type</th>
                                    <th>Date & Time</th>
                                    <th>Total</th>
                                    <th>Status</th>
                                    <th>Priority</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td><span class="order-id"><%# Eval("TicketNumber") %></span></td>
                            <td>
                                <div class="customer-name"><%# Eval("CustomerName") %></div>
                                <div class="customer-contact"><i class="fas fa-phone-alt"></i> <%# Eval("CustomerPhone") %></div>
                            </div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></td>
                            <td><i class="fas <%# GetOrderTypeIcon(Eval("OrderType").ToString()) %>"></i> <%# Eval("OrderType") %></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></td>
                            <td>
                                <div><%# Convert.ToDateTime(Eval("CreatedAt")).ToString("MMM dd, yyyy") %></div>
                                <small style="color: var(--muted-text);"><%# Convert.ToDateTime(Eval("CreatedAt")).ToString("hh:mm tt") %></small>
                             </div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></td>
                            <td class="order-total">₱<%# Convert.ToDecimal(Eval("TotalAmount")).ToString("N2") %></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></td>
                            <td><span class="order-status status-<%# GetStatusClass(Eval("Status").ToString()) %>"><%# Eval("Status") %></span></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></td>
                            <td>
                                <%# Eval("Priority").ToString() == "Rush" ? "<span class='priority-rush'><i class='fas fa-bolt'></i> Rush</span>" : "<span style='color: var(--muted-text);'><i class='fas fa-clock'></i> Normal</span>" %>
                             </div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></td>
                            <td>
                                <div class="action-buttons">
                                    <asp:LinkButton ID="btnView" runat="server" CommandName="View" CommandArgument='<%# Eval("TicketNumber") %>' CssClass="action-button view" ToolTip="View Details">
                                        <i class="fas fa-eye"></i>
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnUpdateStatus" runat="server" CommandName="UpdateStatus" CommandArgument='<%# Eval("TicketNumber") %>' CssClass="action-button update" ToolTip="Update Status">
                                        <i class="fas fa-edit"></i>
                                    </asp:LinkButton>
                                </div>
                             </div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></td>
                        </tr>
                        <tr id="trItems_<%# Eval("TicketID") %>" class="items-row">
                            <td colspan="8">
                                <div class="items-container">
                                    <div class="items-header">
                                        <h4><i class="fas fa-shopping-cart"></i> Order Items - <%# Eval("TicketNumber") %></h4>
                                    </div>
                                    <asp:PlaceHolder ID="phItems" runat="server"></asp:PlaceHolder>
                                </div>
                             </div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                            </tbody>
                         </div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div>
                    </FooterTemplate>
                </asp:Repeater>
                
                <!-- Empty Data Panel -->
                <asp:Panel ID="pnlEmptyData" runat="server" Visible="false" CssClass="no-results">
                    <i class="fas fa-inbox"></i>
                    <h3>No orders found</h3>
                    <p>No orders match your search criteria.</p>
                    <p style="font-size: 12px;">Try adjusting your filters or clearing the search</p>
                </asp:Panel>
            </div>
        </div>

        <!-- Record Count Label -->
        <asp:Label ID="lblRecordCount" runat="server" Visible="false" Text="0"></asp:Label>

        <!-- Pagination -->
        <div class="pagination">
            <asp:Repeater ID="rptPagination" runat="server" OnItemCommand="rptPagination_ItemCommand">
                <ItemTemplate>
                    <asp:LinkButton ID="btnPage" runat="server" CommandName="Page" CommandArgument='<%# Container.DataItem %>' 
                        CssClass='page-link <%# Convert.ToInt32(Container.DataItem) == CurrentPage ? "active" : "" %>'>
                        <%# Container.DataItem %>
                    </asp:LinkButton>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>

    <script type="text/javascript">
        function performSearch() {
            const hiddenBtn = document.getElementById('<%= btnHiddenSearch.ClientID %>');
            if (hiddenBtn) hiddenBtn.click();
        }

        function setupEnterKeySearch() {
            const searchBox = document.getElementById('<%= txtSearch.ClientID %>');
            if (searchBox) {
                searchBox.addEventListener('keypress', function(e) {
                    if (e.key === 'Enter') {
                        e.preventDefault();
                        performSearch();
                    }
                });
            }
        }

        function setupFilterListeners() {
            const filters = [
                '<%= ddlStatus.ClientID %>',
                '<%= ddlOrderType.ClientID %>',
                '<%= ddlPriority.ClientID %>',
                '<%= ddlDateFilter.ClientID %>'
            ];
            
            filters.forEach(filterId => {
                const filter = document.getElementById(filterId);
                if (filter) {
                    filter.addEventListener('change', function() {
                        performSearch();
                    });
                }
            });
        }

        function openModal(orderDataJson) {
            const modal = document.getElementById('orderModal');
            const modalBody = document.getElementById('modalBody');
            const container = document.querySelector('.order-history-container');
            
            if (!modal || !modalBody) return;
            
            try {
                const data = typeof orderDataJson === 'string' ? JSON.parse(orderDataJson) : orderDataJson;
                
                let itemsHtml = '';
                if (data.items && data.items.length > 0) {
                    itemsHtml = `
                        <table class="items-table">
                            <thead>
                                <tr><th>Item</th><th>Qty</th><th>Price</th><th>Subtotal</th><th>Status</th></tr>
                            </thead>
                            <tbody>
                                ${data.items.map(item => `
                                    <tr>
                                        <td><strong>${escapeHtml(item.FoodName)}</strong></td>
                                        <td>${item.Quantity}</td>
                                        <td>₱${parseFloat(item.UnitPrice).toFixed(2)}</div></td>
                                        <td style="color: var(--primary-maroon); font-weight: 600;">₱${parseFloat(item.SubTotal).toFixed(2)}</div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></td>
                                        <td><span class="order-status status-${getStatusClass(item.Status)}">${escapeHtml(item.Status || 'Pending')}</span></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></td>
                                    </tr>
                                `).join('')}
                            </tbody>
                         </div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div>
                    `;
                } else {
                    itemsHtml = '<p style="text-align: center; padding: 20px;">No items found</p>';
                }

                modalBody.innerHTML = `
                    <div style="margin-bottom: 20px;">
                        <h4 style="color: var(--primary-maroon); margin-bottom: 15px;"><i class="fas fa-info-circle"></i> Order Information</h4>
                        <div style="display: grid; grid-template-columns: repeat(2, 1fr); gap: 15px;">
                            <div><span style="color: var(--muted-text);">Order #:</span><br><strong>${escapeHtml(data.orderNumber)}</strong></div>
                            <div><span style="color: var(--muted-text);">Order Type:</span><br>${escapeHtml(data.orderType)}</div>
                            <div><span style="color: var(--muted-text);">Status:</span><br><span class="order-status status-${getStatusClass(data.status)}">${escapeHtml(data.status)}</span></div>
                            <div><span style="color: var(--muted-text);">Priority:</span><br>${data.priority === 'Rush' ? '<span class="priority-rush">Rush</span>' : 'Normal'}</div>
                            <div><span style="color: var(--muted-text);">Date:</span><br>${escapeHtml(data.createdAt)}</div>
                            <div><span style="color: var(--muted-text);">Total:</span><br><span style="font-size: 20px; font-weight: 700; color: var(--primary-maroon);">₱${parseFloat(data.totalAmount).toFixed(2)}</span></div>
                        </div>
                    </div>
                    
                    <div style="margin-bottom: 20px;">
                        <h4 style="color: var(--primary-maroon); margin-bottom: 15px;"><i class="fas fa-user"></i> Customer Information</h4>
                        <div style="display: grid; grid-template-columns: repeat(2, 1fr); gap: 15px;">
                            <div><span style="color: var(--muted-text);">Name:</span><br><strong>${escapeHtml(data.customerName)}</strong></div>
                            <div><span style="color: var(--muted-text);">Phone:</span><br>${escapeHtml(data.customerPhone)}</div>
                            <div><span style="color: var(--muted-text);">Email:</span><br>${escapeHtml(data.customerEmail)}</div>
                        </div>
                    </div>
                    
                    <div>
                        <h4 style="color: var(--primary-maroon); margin-bottom: 15px;"><i class="fas fa-receipt"></i> Order Items</h4>
                        ${itemsHtml}
                        <div style="margin-top: 20px; text-align: right; padding-top: 15px; border-top: 2px solid var(--border-light);">
                            <strong>Grand Total: ₱${parseFloat(data.totalAmount).toFixed(2)}</strong>
                        </div>
                    </div>
                `;

                modal.style.display = 'flex';
                if (container) container.classList.add('blur-background');
                document.body.style.overflow = 'hidden';
                
            } catch (error) {
                console.error('Error:', error);
                modalBody.innerHTML = '<div style="text-align: center; padding: 40px;"><i class="fas fa-exclamation-triangle"></i><p>Error loading order details</p></div>';
                modal.style.display = 'flex';
            }
        }

        function closeModal() {
            const modal = document.getElementById('orderModal');
            const container = document.querySelector('.order-history-container');
            if (modal) {
                modal.style.display = 'none';
                if (container) container.classList.remove('blur-background');
                document.body.style.overflow = 'auto';
            }
        }

        function getStatusClass(status) {
            if (!status) return 'default';
            const s = status.toLowerCase();
            if (s === 'open') return 'open';
            if (s === 'in progress') return 'inprogress';
            if (s === 'completed') return 'completed';
            if (s === 'cancelled') return 'cancelled';
            return 'default';
        }

        function escapeHtml(str) {
            if (!str) return '';
            return String(str).replace(/[&<>]/g, function(m) {
                if (m === '&') return '&amp;';
                if (m === '<') return '&lt;';
                if (m === '>') return '&gt;';
                return m;
            });
        }

        document.addEventListener('DOMContentLoaded', function() {
            setupEnterKeySearch();
            setupFilterListeners();
            
            const modal = document.getElementById('orderModal');
            if (modal) {
                modal.addEventListener('click', function(e) {
                    if (e.target === modal) closeModal();
                });
            }
            
            document.addEventListener('keydown', function(e) {
                if (e.key === 'Escape') closeModal();
            });
        });
    </script>
</asp:Content>