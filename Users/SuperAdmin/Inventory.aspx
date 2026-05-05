<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/SuperAdmin.Master" AutoEventWireup="true" CodeBehind="Inventory.aspx.cs" Inherits="TasteNet.Users.SuperAdmin.Inventory" %>
<%@ Register TagPrefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <asp:HiddenField ID="hfInventoryID" runat="server" />
    
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

        #full-page-wrapper {
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

        .header-actions {
            display: flex;
            gap: 10px;
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

        .stat-icon {
            width: 36px;
            height: 36px;
            border-radius: var(--radius-md);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 16px;
            transition: transform var(--transition-base);
        }

        .stat-card:hover .stat-icon {
            transform: scale(1.1);
        }

        .icon-items { 
            background: #f9ecee; 
            color: var(--primary-maroon); 
        }
        .icon-low { 
            background: var(--warning-orange-light); 
            color: var(--warning-orange); 
        }
        .icon-out { 
            background: var(--danger-red-light); 
            color: var(--danger-red); 
        }
        .icon-value { 
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

        .search-wrapper {
            position: relative;
            flex: 1;
            max-width: 300px;
        }

        .search-wrapper input {
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

        .search-wrapper input:focus {
            border-color: var(--primary-maroon);
            box-shadow: 0 0 0 3px rgba(107, 13, 30, 0.1);
        }

        .search-wrapper i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--muted-text);
            font-size: 14px;
        }

        .filter-dropdown {
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

        .filter-dropdown:focus {
            border-color: var(--primary-maroon);
            box-shadow: 0 0 0 3px rgba(107, 13, 30, 0.1);
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
            border: none;
            font-family: 'Poppins', sans-serif;
            text-decoration: none;
            white-space: nowrap;
            min-height: 36px;
        }

        .btn--secondary {
            background: #ffcc00;
            color: var(--text-dark);
        }

        .btn--secondary:hover {
            background: #e6b800;
            transform: translateY(-2px);
            box-shadow: var(--button-shadow);
        }

        .btn--primary {
            background: var(--primary-maroon);
            color: white;
        }

        .btn--primary:hover {
            background: var(--primary-maroon-dark);
            transform: translateY(-2px);
            box-shadow: var(--button-shadow);
        }

        .btn--outline {
            background: transparent;
            color: var(--primary-maroon);
            border: 2px solid var(--border-light);
        }

        .btn--outline:hover {
            background: var(--bg-lighter);
            border-color: var(--primary-maroon);
            transform: translateY(-2px);
        }

        .btn--danger {
            background: var(--danger-red);
            color: white;
        }

        .btn--danger:hover {
            background: #991b1b;
            transform: translateY(-2px);
            box-shadow: var(--button-shadow);
        }

        .table-wrapper {
            background: white;
            border-radius: var(--radius-lg);
            box-shadow: var(--card-shadow);
            overflow: hidden;
            margin-bottom: 20px;
        }

        .table-inner-wrapper {
            overflow-x: auto;
        }

        .full-table {
            width: 100%;
            border-collapse: collapse;
            min-width: 1100px;
        }

        .full-table thead {
            background: white;
            border-bottom: 2px solid var(--bg-light);
        }

        .full-table th {
            padding: 16px 12px;
            text-align: center;
            font-size: 12px;
            color: var(--muted-text);
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .full-table td {
            padding: 16px 12px;
            text-align: center;
            border-bottom: 1px solid var(--bg-lighter);
            font-size: 13px;
            color: var(--text-dark);
            vertical-align: middle;
        }

        .full-table tbody tr {
            transition: all var(--transition-base);
            border-left: 3px solid transparent;
        }

        .full-table tbody tr:hover {
            background: var(--bg-hover);
            border-left-color: var(--primary-maroon);
            transform: translateX(2px);
        }

        .item-name {
            font-weight: 600;
            font-size: 13px;
            color: var(--text-dark);
            margin-bottom: 2px;
            display: block;
            transition: color var(--transition-base);
        }

        .full-table tbody tr:hover .item-name {
            color: var(--primary-maroon);
        }

        .item-category {
            font-size: 11px;
            color: var(--muted-text);
            display: block;
        }

        .stock-badge {
            padding: 4px 12px;
            border-radius: var(--radius-sm);
            font-size: 11px;
            font-weight: 700;
            display: inline-block;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .stock-badge.in-stock {
            background: var(--success-green-light);
            color: var(--success-green);
        }

        .stock-badge.low-stock {
            background: var(--warning-orange-light);
            color: var(--warning-orange);
        }

        .stock-badge.out-of-stock {
            background: var(--danger-red-light);
            color: var(--danger-red);
        }

        .quantity-controls {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .qty-btn {
            width: 28px;
            height: 28px;
            border-radius: var(--radius-sm);
            background: var(--bg-lighter);
            border: none;
            cursor: pointer;
            transition: all var(--transition-base);
            font-size: 14px;
            font-weight: 700;
            color: var(--primary-maroon);
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        .qty-btn:hover {
            background: var(--primary-maroon);
            color: white;
            transform: translateY(-2px);
        }

        .quantity-value {
            font-weight: 700;
            color: var(--primary-maroon);
            font-size: 15px;
            min-width: 35px;
            text-align: center;
        }

        .unit-price, .total-price {
            font-weight: 700;
            font-size: 13px;
        }

        .unit-price {
            color: var(--primary-maroon);
        }

        .total-price {
            color: var(--success-green);
        }

        .supplier-info {
            display: flex;
            flex-direction: column;
            gap: 2px;
        }

        .supplier-name {
            font-size: 12px;
            color: var(--text-dark);
            font-weight: 500;
        }

        .supplier-contact {
            font-size: 10px;
            color: var(--muted-text);
        }

        .switch {
            position: relative;
            display: inline-block;
            width: 50px;
            height: 24px;
        }

        .switch input {
            opacity: 0;
            width: 0;
            height: 0;
        }

        .slider {
            position: absolute;
            cursor: pointer;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: var(--border-light);
            transition: var(--transition-base);
            border-radius: 34px;
        }

        .slider:before {
            position: absolute;
            content: "";
            height: 16px;
            width: 16px;
            left: 4px;
            bottom: 4px;
            background-color: white;
            transition: var(--transition-base);
            border-radius: 50%;
        }

        input:checked + .slider {
            background-color: var(--success-green);
        }

        input:checked + .slider:before {
            transform: translateX(26px);
        }

        .action-icons {
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
            font-size: 14px;
            color: var(--muted-text);
            display: inline-flex;
            align-items: center;
            justify-content: center;
            text-decoration: none;
        }

        .action-icon i {
            font-size: 14px;
        }

        .action-icon.edit:hover {
            background: var(--success-green);
            color: white;
            transform: translateY(-2px);
        }

        .action-icon.delete:hover {
            background: var(--danger-red);
            color: white;
            transform: translateY(-2px);
        }

        .no-results {
            text-align: center;
            padding: 60px;
            color: var(--muted-text);
        }

        .no-results i {
            font-size: 48px;
            margin-bottom: 15px;
            color: var(--border-light);
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

        .modal-content {
            background: white;
            border-radius: var(--radius-xl);
            max-width: 600px;
            width: 90%;
            max-height: 90vh;
            overflow-y: auto;
            animation: slideUp 0.3s ease;
            box-shadow: 0 20px 60px rgba(107, 13, 30, 0.3);
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

        .modal-close {
            background: rgba(255, 255, 255, 0.2);
            border: none;
            width: 32px;
            height: 32px;
            border-radius: 50%;
            color: white;
            cursor: pointer;
            font-size: 18px;
            transition: all var(--transition-base);
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .modal-close:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: rotate(90deg);
        }

        .modal-body {
            padding: 25px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: var(--text-dark);
            font-size: 13px;
        }

        .form-control {
            width: 100%;
            padding: 10px 15px;
            border: 2px solid var(--border-light);
            border-radius: var(--radius-md);
            font-family: 'Poppins', sans-serif;
            font-size: 13px;
            color: var(--text-dark);
            transition: all var(--transition-base);
            background: white;
            box-sizing: border-box;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--primary-maroon);
            box-shadow: 0 0 0 3px rgba(107, 13, 30, 0.1);
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
        }

        .modal-footer {
            padding: 20px 25px;
            border-top: 2px solid var(--bg-light);
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            background: var(--bg-lighter);
            border-radius: 0 0 var(--radius-xl) var(--radius-xl);
        }

        .delete-modal-header {
            padding: 30px 30px 0;
            text-align: center;
        }

        .delete-modal-header h3 {
            margin: 0;
            font-size: 22px;
            color: var(--text-dark);
            background: none;
            -webkit-text-fill-color: var(--text-dark);
        }

        .delete-modal-body {
            padding: 20px 30px;
            text-align: center;
        }

        .delete-icon {
            font-size: 60px;
            color: var(--danger-red);
            margin-bottom: 20px;
        }

        .delete-message {
            font-size: 16px;
            color: var(--text-dark);
            margin-bottom: 15px;
        }

        .delete-ingredient-name {
            font-weight: 700;
            color: var(--primary-maroon);
            background: var(--danger-red-light);
            padding: 2px 8px;
            border-radius: var(--radius-sm);
            display: inline-block;
        }

        .delete-warning {
            font-size: 13px;
            color: var(--muted-text);
        }

        .delete-modal-footer {
            padding: 0 30px 30px;
            display: flex;
            justify-content: center;
            gap: 15px;
            border-top: none;
            background: transparent;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

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

        .toast-notification {
            position: fixed;
            top: 20px;
            right: 20px;
            padding: 15px 20px;
            border-radius: var(--radius-md);
            color: white;
            z-index: 10001;
            animation: slideInRight 0.3s ease;
            display: flex;
            align-items: center;
            gap: 10px;
            max-width: 300px;
            box-shadow: var(--card-shadow-hover);
        }

        @media (max-width: 1200px) {
            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 768px) {
            #full-page-wrapper {
                padding: 15px;
            }
            .stats-grid {
                grid-template-columns: 1fr;
            }
            .filter-container {
                flex-direction: column;
            }
            .search-wrapper {
                max-width: 100%;
                width: 100%;
            }
            .filter-dropdown {
                width: 100%;
            }
            .page-header {
                flex-direction: column;
                align-items: stretch;
            }
            .header-actions {
                justify-content: stretch;
            }
            .header-actions .btn {
                flex: 1;
                text-align: center;
            }
            .form-row {
                grid-template-columns: 1fr;
            }
            .delete-modal-footer {
                flex-direction: column;
            }
            .delete-modal-footer .btn {
                width: 100%;
                justify-content: center;
            }
        }

        @media (max-width: 480px) {
            .stat-card__value {
                font-size: 22px;
            }
            .full-table th,
            .full-table td {
                padding: 10px 8px;
                font-size: 11px;
            }
            .quantity-value {
                font-size: 13px;
                min-width: 25px;
            }
            .qty-btn {
                width: 24px;
                height: 24px;
                font-size: 12px;
            }
        }
    </style>

    <div id="full-page-wrapper">
        <div class="page-header">
            <div class="header-title">
                <h2>Inventory Management</h2>
                <p>Manage ingredient stock and suppliers</p>
            </div>
            <div class="header-actions">
                <asp:Button ID="btnAddIngredient" runat="server" Text="Add New Ingredient" CssClass="btn btn--secondary" OnClick="btnAddIngredient_Click" />
                <asp:Button ID="btnBulkRestock" runat="server" Text="Bulk Restock" CssClass="btn btn--primary" OnClick="btnBulkRestock_Click" />
            </div>
        </div>

        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-card__header">
                    <span class="stat-card__label">Total Ingredients</span>
                    <div class="stat-icon icon-items"><i class="fas fa-apple-alt"></i></div>
                </div>
                <div class="stat-card__value">
                    <asp:Label ID="lblTotalIngredients" runat="server" Text="0" />
                </div>
                <div class="stat-card__trend">All categories</div>
            </div>
            <div class="stat-card">
                <div class="stat-card__header">
                    <span class="stat-card__label">Low Stock Alerts</span>
                    <div class="stat-icon icon-low"><i class="fas fa-exclamation-triangle"></i></div>
                </div>
                <div class="stat-card__value">
                    <asp:Label ID="lblLowStockCount" runat="server" Text="0" />
                </div>
                <div class="stat-card__trend">Needs restocking</div>
            </div>
            <div class="stat-card">
                <div class="stat-card__header">
                    <span class="stat-card__label">Out of Stock</span>
                    <div class="stat-icon icon-out"><i class="fas fa-times-circle"></i></div>
                </div>
                <div class="stat-card__value">
                    <asp:Label ID="lblOutOfStockCount" runat="server" Text="0" />
                </div>
                <div class="stat-card__trend">Currently unavailable</div>
            </div>
            <div class="stat-card">
                <div class="stat-card__header">
                    <span class="stat-card__label">Inventory Value</span>
                    <div class="stat-icon icon-value"><i class="fas fa-peso-sign"></i></div>
                </div>
                <div class="stat-card__value">
                    <asp:Label ID="lblInventoryValue" runat="server" Text="₱0" />
                </div>
                <div class="stat-card__trend">Total stock value</div>
            </div>
        </div>

        <div class="filter-container">
            <div class="search-wrapper">
                <i class="fas fa-search"></i>
                <asp:TextBox ID="txtSearch" runat="server" placeholder="Search by ingredient name or description..." AutoPostBack="true" OnTextChanged="txtSearch_TextChanged" />
            </div>
            <asp:DropDownList ID="ddlCategoryFilter" runat="server" CssClass="filter-dropdown" AutoPostBack="true" OnSelectedIndexChanged="ddlFilter_SelectedIndexChanged">
                <asp:ListItem Text="All Categories" Value="all" />
                <asp:ListItem Text="Protein" Value="1" />
                <asp:ListItem Text="Produce" Value="2" />
                <asp:ListItem Text="Grains & Starches" Value="3" />
                <asp:ListItem Text="Spices & Seasonings" Value="4" />
                <asp:ListItem Text="Cooking Essentials" Value="5" />
            </asp:DropDownList>
            <asp:DropDownList ID="ddlStatusFilter" runat="server" CssClass="filter-dropdown" AutoPostBack="true" OnSelectedIndexChanged="ddlFilter_SelectedIndexChanged">
                <asp:ListItem Text="All Stock Status" Value="all" />
                <asp:ListItem Text="In Stock" Value="in-stock" />
                <asp:ListItem Text="Low Stock" Value="low-stock" />
                <asp:ListItem Text="Out of Stock" Value="out-of-stock" />
            </asp:DropDownList>
        </div>

        <div class="table-wrapper">
            <div class="table-inner-wrapper">
                <asp:Repeater ID="rptInventory" runat="server" OnItemCommand="rptInventory_ItemCommand" OnItemDataBound="rptInventory_ItemDataBound">
                    <HeaderTemplate>
                        <table class="full-table">
                            <thead>
                                <tr>
                                    <th>Ingredient Name</th>
                                    <th>Category</th>
                                    <th>Stock Status</th>
                                    <th>Quantity</th>
                                    <th>Unit Price</th>
                                    <th>Total Price</th>
                                    <th>Supplier</th>
                                    <th>Available</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td>
                                <span class="item-name"><%# Eval("ItemName") %></span>
                                <span class="item-category"><%# Eval("Description") %></span>
                            </span>
                            <td><span class="item-category"><%# Eval("CategoryName") %></span></span>
                            <td>
                                <span class="stock-badge <%# GetStockStatusClass(Eval("StockStatus").ToString()) %>">
                                    <%# GetStockStatusText(Eval("StockStatus").ToString()) %>
                                </span>
                            </span>
                            <td>
                                <div class="quantity-controls">
                                    <asp:LinkButton ID="btnMinus" runat="server" CssClass="qty-btn" CommandName="DecreaseQuantity" 
                                        CommandArgument='<%# Eval("InventoryID") %>' Text="-" />
                                    <span class="quantity-value"><%# Eval("Quantity") %></span>
                                    <asp:LinkButton ID="btnPlus" runat="server" CssClass="qty-btn" CommandName="IncreaseQuantity" 
                                        CommandArgument='<%# Eval("InventoryID") %>' Text="+" />
                                </div>
                            </span>
                            <td>
                                <span class="unit-price">₱<%# string.Format("{0:N2}", Eval("UnitPrice")) %></span>
                            </span>
                            <td>
                                <span class="total-price">₱<%# string.Format("{0:N2}", Convert.ToDecimal(Eval("Quantity")) * Convert.ToDecimal(Eval("UnitPrice"))) %></span>
                            </span>
                            <td>
                                <div class="supplier-info">
                                    <span class="supplier-name"><%# Eval("SupplierName") %></span>
                                    <span class="supplier-contact"><%# Eval("SupplierContact") %></span>
                                </div>
                            </span>
                            <td>
                                <label class="switch">
                                    <asp:CheckBox ID="chkAvailable" runat="server" Checked='<%# Eval("Available") %>' 
                                        AutoPostBack="true" OnCheckedChanged="chkAvailable_CheckedChanged" />
                                    <span class="slider"></span>
                                </label>
                            </span>
                            <td>
                                <div class="action-icons">
                                    <asp:LinkButton ID="btnEdit" runat="server" CssClass="action-icon edit" CommandName="EditItem" 
                                        CommandArgument='<%# Eval("InventoryID") %>' ToolTip="Edit Ingredient">
                                        <i class="fas fa-edit"></i>
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnDelete" runat="server" CssClass="action-icon delete" CommandName="DeleteItem" 
                                        CommandArgument='<%# Eval("InventoryID") %>' ToolTip="Delete Ingredient">
                                        <i class="fas fa-trash"></i>
                                    </asp:LinkButton>
                                </div>
                            </span>
                        </span>
                    </ItemTemplate>
                    <AlternatingItemTemplate>
                        <tr style="background-color: #fefaf5;">
                            <td>
                                <span class="item-name"><%# Eval("ItemName") %></span>
                                <span class="item-category"><%# Eval("Description") %></span>
                            </span>
                            <td><span class="item-category"><%# Eval("CategoryName") %></span></span>
                            <td>
                                <span class="stock-badge <%# GetStockStatusClass(Eval("StockStatus").ToString()) %>">
                                    <%# GetStockStatusText(Eval("StockStatus").ToString()) %>
                                </span>
                            </span>
                            <td>
                                <div class="quantity-controls">
                                    <asp:LinkButton ID="btnMinus" runat="server" CssClass="qty-btn" CommandName="DecreaseQuantity" 
                                        CommandArgument='<%# Eval("InventoryID") %>' Text="-" />
                                    <span class="quantity-value"><%# Eval("Quantity") %></span>
                                    <asp:LinkButton ID="btnPlus" runat="server" CssClass="qty-btn" CommandName="IncreaseQuantity" 
                                        CommandArgument='<%# Eval("InventoryID") %>' Text="+" />
                                </div>
                            </span>
                            <td>
                                <span class="unit-price">₱<%# string.Format("{0:N2}", Eval("UnitPrice")) %></span>
                            </span>
                            <td>
                                <span class="total-price">₱<%# string.Format("{0:N2}", Convert.ToDecimal(Eval("Quantity")) * Convert.ToDecimal(Eval("UnitPrice"))) %></span>
                            </span>
                            <td>
                                <div class="supplier-info">
                                    <span class="supplier-name"><%# Eval("SupplierName") %></span>
                                    <span class="supplier-contact"><%# Eval("SupplierContact") %></span>
                                </div>
                            </span>
                            <td>
                                <label class="switch">
                                    <asp:CheckBox ID="chkAvailable" runat="server" Checked='<%# Eval("Available") %>' 
                                        AutoPostBack="true" OnCheckedChanged="chkAvailable_CheckedChanged" />
                                    <span class="slider"></span>
                                </label>
                            </span>
                            <td>
                                <div class="action-icons">
                                    <asp:LinkButton ID="btnEdit" runat="server" CssClass="action-icon edit" CommandName="EditItem" 
                                        CommandArgument='<%# Eval("InventoryID") %>' ToolTip="Edit Ingredient">
                                        <i class="fas fa-edit"></i>
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnDelete" runat="server" CssClass="action-icon delete" CommandName="DeleteItem" 
                                        CommandArgument='<%# Eval("InventoryID") %>' ToolTip="Delete Ingredient">
                                        <i class="fas fa-trash"></i>
                                    </asp:LinkButton>
                                </div>
                            </span>
                        </span>
                    </AlternatingItemTemplate>
                    <FooterTemplate>
                            </tbody>
                        </table>
                    </FooterTemplate>
                </asp:Repeater>
                <div class="no-results" id="noResultsMessage" runat="server" visible="false">
                    <i class="fas fa-search"></i>
                    <h3>No ingredients found</h3>
                    <p>Try adjusting your search or filters</p>
                </div>
            </div>
        </div>
    </div>

    <div class="modal-overlay" id="editModal">
        <div class="modal-content">
            <div class="modal-header">
                <h3><i class="fas fa-edit"></i> Edit Ingredient</h3>
                <button type="button" class="modal-close" onclick="closeModal('editModal')">&times;</button>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label>Ingredient Name</label>
                    <asp:TextBox ID="txtItemName" runat="server" CssClass="form-control" />
                </div>
                <div class="form-group">
                    <label>Description</label>
                    <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" />
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label>Category</label>
                        <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control" />
                    </div>
                    <div class="form-group">
                        <label>Quantity</label>
                        <asp:TextBox ID="txtQuantity" runat="server" CssClass="form-control" TextMode="Number" Step="1" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label>Low Stock Threshold</label>
                        <asp:TextBox ID="txtLowStockThreshold" runat="server" CssClass="form-control" TextMode="Number" Step="1" />
                    </div>
                    <div class="form-group">
                        <label>Unit of Measure</label>
                        <asp:DropDownList ID="ddlUnitOfMeasure" runat="server" CssClass="form-control">
                            <asp:ListItem Text="Pieces (pcs)" Value="pcs" />
                            <asp:ListItem Text="Kilograms (kg)" Value="kg" />
                            <asp:ListItem Text="Grams (g)" Value="g" />
                            <asp:ListItem Text="Liters (L)" Value="L" />
                            <asp:ListItem Text="Milliliters (ml)" Value="ml" />
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label>Unit Cost (₱)</label>
                        <asp:TextBox ID="txtUnitCost" runat="server" CssClass="form-control" TextMode="Number" Step="0.01" />
                    </div>
                    <div class="form-group">
                        <label>Unit Price (₱)</label>
                        <asp:TextBox ID="txtUnitPrice" runat="server" CssClass="form-control" TextMode="Number" Step="0.01" />
                    </div>
                </div>
                <div class="form-group">
                    <label>Supplier</label>
                    <asp:DropDownList ID="ddlSupplier" runat="server" CssClass="form-control" />
                </div>
                <div class="form-group">
                    <label><asp:CheckBox ID="chkIsAvailable" runat="server" /> Available</label>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn--outline" onclick="closeModal('editModal')">Cancel</button>
                <asp:Button ID="btnSave" runat="server" Text="Save Changes" CssClass="btn btn--primary" OnClick="btnSave_Click" />
            </div>
        </div>
    </div>

    <div class="modal-overlay" id="deleteModal">
        <div class="modal-content">
            <div class="delete-modal-header">
                <h3>Delete Ingredient</h3>
            </div>
            <div class="delete-modal-body">
                <div class="delete-icon">
                    <i class="fas fa-trash-alt"></i>
                </div>
                <div class="delete-message">
                    Are you sure you want to delete <span class="delete-ingredient-name" id="deleteIngredientName"></span>?
                </div>
                <div class="delete-warning">
                    This action cannot be undone.
                </div>
            </div>
            <div class="delete-modal-footer">
                <button type="button" class="btn btn--danger" id="confirmDelete">Delete</button>
                <button type="button" class="btn btn--outline" id="cancelDelete">Cancel</button>
            </div>
        </div>
    </div>

    <asp:Label ID="lblMessage" runat="server" Style="display: none;" />
    
    <script type="text/javascript">
        function showModal(modalId) {
            document.getElementById(modalId).style.display = 'flex';
            document.body.style.overflow = 'hidden';
        }
        
        function closeModal(modalId) {
            document.getElementById(modalId).style.display = 'none';
            document.body.style.overflow = 'auto';
        }
        
        function showToast(message, type) {
            var toast = document.createElement('div');
            toast.className = 'toast-notification';
            toast.style.backgroundColor = type === 'success' ? '#2d9d78' : type === 'error' ? '#b91c1c' : '#d97706';
            toast.innerHTML = '<i class="fas ' + (type === 'success' ? 'fa-check-circle' : type === 'error' ? 'fa-exclamation-circle' : 'fa-info-circle') + '"></i><span>' + message + '</span>';
            document.body.appendChild(toast);
            
            setTimeout(function() {
                toast.style.animation = 'slideOutRight 0.3s ease';
                setTimeout(function() {
                    document.body.removeChild(toast);
                }, 300);
            }, 3000);
        }
        
        window.onload = function() {
            var messageLabel = document.getElementById('<%= lblMessage.ClientID %>');
            if (messageLabel && messageLabel.innerText) {
                var parts = messageLabel.innerText.split('|');
                if (parts.length === 2) {
                    showToast(parts[0], parts[1]);
                    messageLabel.innerText = '';
                }
            }
        }

        window.onclick = function (event) {
            var editModal = document.getElementById('editModal');
            var deleteModal = document.getElementById('deleteModal');
            if (event.target === editModal) closeModal('editModal');
            if (event.target === deleteModal) closeModal('deleteModal');
        }

        document.addEventListener('keydown', function (e) {
            if (e.key === 'Escape') {
                closeModal('editModal');
                closeModal('deleteModal');
            }
        });

        document.addEventListener('DOMContentLoaded', function () {
            var confirmDeleteBtn = document.getElementById('confirmDelete');
            var cancelDeleteBtn = document.getElementById('cancelDelete');

            if (confirmDeleteBtn) {
                confirmDeleteBtn.addEventListener('click', function () {
                    var deleteButton = document.querySelector('.action-icon.delete[data-delete-id]');
                    if (deleteButton) {
                        __doPostBack(deleteButton.getAttribute('data-target'), deleteButton.getAttribute('data-delete-id'));
                    }
                    closeModal('deleteModal');
                });
            }

            if (cancelDeleteBtn) {
                cancelDeleteBtn.addEventListener('click', function () {
                    closeModal('deleteModal');
                });
            }
        });
    </script>
</asp:Content>