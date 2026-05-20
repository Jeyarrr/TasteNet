<%@ Page Title="Transactions Management" Language="C#" MasterPageFile="~/MasterPages/SuperAdmin.Master" AutoEventWireup="true" CodeBehind="Transactions.aspx.cs" Inherits="TasteNet.Users.SuperAdmin.Transactions" %>

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

        #transactions-wrapper {
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

        .stat-card__icon--total { background: #f9ecee; color: var(--primary-maroon); }
        .stat-card__icon--sales { background: var(--success-green-light); color: var(--success-green); }
        .stat-card__icon--purchases { background: var(--warning-orange-light); color: var(--warning-orange); }
        .stat-card__icon--value { background: #eff6ff; color: #3b82f6; }

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

        .filter-date {
            padding: 10px 15px;
            border: 2px solid var(--border-light);
            border-radius: var(--radius-md);
            font-family: 'Poppins', sans-serif;
            font-size: 13px;
            background: white;
            transition: all var(--transition-base);
            outline: none;
        }

        .filter-date:focus {
            border-color: var(--primary-maroon);
            box-shadow: 0 0 0 3px rgba(107, 13, 30, 0.1);
        }

        .export-section {
            display: flex;
            gap: 10px;
            align-items: center;
        }

        .export-btn {
            padding: 10px 20px;
            border-radius: var(--radius-md);
            border: none;
            cursor: pointer;
            font-weight: 600;
            font-size: 13px;
            color: white;
            transition: all var(--transition-base);
        }

        .export-btn.pdf {
            background: linear-gradient(135deg, var(--primary-maroon), var(--primary-maroon-dark));
        }

        .export-btn.excel {
            background: linear-gradient(135deg, var(--success-green), #1e7c5a);
        }

        .export-btn:hover {
            transform: translateY(-2px);
            box-shadow: var(--button-shadow);
        }

        .export-btn:disabled {
            opacity: 0.5;
            cursor: not-allowed;
            transform: none;
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
            transform: translateX(2px);
        }

        .transaction-checkbox {
            width: 18px;
            height: 18px;
            cursor: pointer;
            accent-color: var(--primary-maroon);
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

        .status-badge--completed {
            background: var(--success-green-light);
            color: var(--success-green);
        }

        .status-badge--adjust {
            background: var(--warning-orange-light);
            color: var(--warning-orange);
        }
        .type-badge {
            padding: 4px 12px;
            border-radius: var(--radius-sm);
            font-size: 11px;
            font-weight: 600;
            display: inline-block;
            background: var(--bg-lighter);
            color: var(--text-dark);
        }

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

        .transaction-modal {
            background: white;
            border-radius: var(--radius-xl);
            max-width: 600px;
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

        .selected-bar {
            background: white;
            padding: 12px 20px;
            border-radius: var(--radius-md);
            margin-bottom: 20px;
            display: none;
            align-items: center;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 10px;
            box-shadow: var(--card-shadow);
        }

        .selected-bar.show {
            display: flex;
        }

        .selected-count {
            font-weight: 600;
            color: var(--primary-maroon);
        }

        .selected-actions {
            display: flex;
            gap: 10px;
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

        @media (max-width: 1200px) {
            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 768px) {
            #transactions-wrapper {
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
            .filter-select, .filter-date {
                width: 100%;
            }
            .page-header {
                flex-direction: column;
                align-items: stretch;
            }
            .export-section {
                justify-content: stretch;
            }
            .export-btn {
                flex: 1;
                text-align: center;
            }
            .selected-bar {
                flex-direction: column;
            }
            .selected-actions {
                width: 100%;
            }
            .selected-actions .btn {
                flex: 1;
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

    <div id="transactions-wrapper">
        <div class="page-header">
            <div class="header-title">
                <h2>Transactions Management</h2>
                <p>Track and monitor all inventory transactions</p>
            </div>
            <div class="export-section">
               
                <button type="button" id="exportAllBtn" class="export-btn excel" onclick="exportAll()">
                    <i class="fas fa-file-excel"></i> Export All
                </button>
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
                <div class="stat-card__value"><asp:Label ID="lblTotalTransactions" runat="server" Text="0" /></div>
                <div class="stat-card__trend">All transactions</div>
            </div>
            <div class="stat-card">
                <div class="stat-card__header">
                    <span class="stat-card__label">Sales/Income</span>
                    <div class="stat-card__icon stat-card__icon--sales">
                        <i class="fas fa-shopping-cart"></i>
                    </div>
                </div>
                <div class="stat-card__value"><asp:Label ID="lblSales" runat="server" Text="0" /></div>
                <div class="stat-card__trend">Completed sales</div>
            </div>
            <div class="stat-card">
                <div class="stat-card__header">
                    <span class="stat-card__label">Purchases</span>
                    <div class="stat-card__icon stat-card__icon--purchases">
                        <i class="fas fa-truck"></i>
                    </div>
                </div>
                <div class="stat-card__value"><asp:Label ID="lblPurchases" runat="server" Text="0" /></div>
                <div class="stat-card__trend">Stock purchases</div>
            </div>
            <div class="stat-card">
                <div class="stat-card__header">
                    <span class="stat-card__label">Total Value</span>
                    <div class="stat-card__icon stat-card__icon--value">
                        <i class="fas fa-peso-sign"></i>
                    </div>
                </div>
                <div class="stat-card__value"><asp:Label ID="lblTotalValue" runat="server" Text="₱0" /></div>
                <div class="stat-card__trend">Transaction volume</div>
            </div>
        </div>

        <div class="selected-bar" id="selectedBar">
            <span class="selected-count" id="selectedCount">0 transactions selected</span>
            <div class="selected-actions">
                <button type="button" class="btn btn--primary" onclick="exportSelected()">
                    <i class="fas fa-download"></i> Export Selected
                </button>
                <button type="button" class="btn btn--outline" onclick="clearAllSelections()">
                    <i class="fas fa-times"></i> Clear All
                </button>
            </div>
        </div>

        <div class="filter-container">
            <div class="search-box">
                <i class="fas fa-search"></i>
                <asp:TextBox ID="txtSearch" runat="server" placeholder="Search by transaction ID, item, or reference..." AutoPostBack="true" OnTextChanged="txtSearch_TextChanged" />
            </div>
            <asp:DropDownList ID="ddlStatus" runat="server" CssClass="filter-select" AutoPostBack="true" OnSelectedIndexChanged="ddlStatus_SelectedIndexChanged">
                <asp:ListItem Text="All Status" Value="all" />
                <asp:ListItem Text="Completed" Value="completed" />
                <asp:ListItem Text="Adjust" Value="pending" />

            </asp:DropDownList>
            <asp:DropDownList ID="ddlType" runat="server" CssClass="filter-select" AutoPostBack="true" OnSelectedIndexChanged="ddlType_SelectedIndexChanged">
                <asp:ListItem Text="All Types" Value="all" />
                <asp:ListItem Text="Purchase" Value="Purchase" />
                <asp:ListItem Text="Sale" Value="Sale" />

                <asp:ListItem Text="Adjustment" Value="Adjustment" />
            </asp:DropDownList>
            <asp:TextBox ID="txtDate" runat="server" TextMode="Date" CssClass="filter-date" AutoPostBack="true" OnTextChanged="txtDate_TextChanged" />
        </div>

        <div class="table-container">
            <div class="table-wrapper">
                <asp:Repeater ID="rptTransactions" runat="server" OnItemCommand="rptTransactions_ItemCommand">
                    <HeaderTemplate>
                        <table class="custom-table">
                            <thead>
                                <tr>
                                    <th style="width: 40px;">
                                        <input type="checkbox" id="selectAllCheckbox" onclick="toggleSelectAll(this)" class="transaction-checkbox">
                                    </th>
                                    <th>Transaction ID</th>
                                    <th>Item Name</th>
                                    <th>Type</th>
                                    <th>Date & Time</th>
                                    <th>Quantity</th>
                                    <th>Value</th>
                                    <th>Status</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td style="text-align: center;">
                                <input type="checkbox" class="transaction-checkbox row-checkbox" data-id='<%# Eval("TransactionID") %>' onclick="updateSelectedCount()">
                            </td>
                            <td><strong>TXN-<%# Eval("TransactionID").ToString().PadLeft(6, '0') %></strong></td>
                            <td><%# Eval("ItemName") %></td>
                            <td><span class="type-badge"><%# Eval("TransactionType") %></span></td>
                            <td><%# Convert.ToDateTime(Eval("TransactionDate")).ToString("MMM dd, yyyy HH:mm:ss") %></td>
                            <td><%# Eval("Quantity") %> <%# Eval("UnitOfMeasure") %></td>
                            <td>₱<%# string.Format("{0:N2}", Eval("TotalValue")) %></td>
                            <td><span class="status-badge status-badge--<%# GetStatusClass(Eval("TransactionType").ToString()) %>"><%# GetStatus(Eval("TransactionType").ToString()) %></span></td>
                            <td>
                                <div class="action-btns">
                                    <asp:LinkButton ID="btnView" runat="server" CommandName="View" CommandArgument='<%# Eval("TransactionID") %>' CssClass="action-icon" ToolTip="View Details">
                                        <i class="fas fa-eye"></i>
                                    </asp:LinkButton>
                                </div>
                            </td>
                        </tr>
                    </ItemTemplate>
                    <AlternatingItemTemplate>
                        <tr style="background-color: #fefaf5;">
                            <td style="text-align: center;">
                                <input type="checkbox" class="transaction-checkbox row-checkbox" data-id='<%# Eval("TransactionID") %>' onclick="updateSelectedCount()">
                            </td>
                            <td><strong>TXN-<%# Eval("TransactionID").ToString().PadLeft(6, '0') %></strong></td>
                            <td><%# Eval("ItemName") %></td>
                            <td><span class="type-badge"><%# Eval("TransactionType") %></span></td>
                            <td><%# Convert.ToDateTime(Eval("TransactionDate")).ToString("MMM dd, yyyy HH:mm:ss") %></td>
                            <td><%# Eval("Quantity") %> <%# Eval("UnitOfMeasure") %></td>
                            <td>₱<%# string.Format("{0:N2}", Eval("TotalValue")) %></td>
                            <td><span class="status-badge status-badge--<%# GetStatusClass(Eval("TransactionType").ToString()) %>"><%# GetStatus(Eval("TransactionType").ToString()) %></span></td>
                            <td>
                                <div class="action-btns">
                                    <asp:LinkButton ID="btnView" runat="server" CommandName="View" CommandArgument='<%# Eval("TransactionID") %>' CssClass="action-icon" ToolTip="View Details">
                                        <i class="fas fa-eye"></i>
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
                <div class="no-results" id="noResults" runat="server" visible="false">
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
                <h3><i class="fas fa-info-circle"></i> Transaction Details</h3>
                <button class="close-modal" onclick="closeModal()">&times;</button>
            </div>
            <div class="modal-body">
                <asp:Label ID="lblModalContent" runat="server" />
            </div>
        </div>
    </div>

    <script type="text/javascript">
        let selectedTransactions = new Set();

        function showModal() {
            document.getElementById('transactionModal').style.display = 'flex';
            document.body.style.overflow = 'hidden';
        }

        function closeModal() {
            document.getElementById('transactionModal').style.display = 'none';
            document.body.style.overflow = 'auto';
        }

        function toggleSelectAll(source) {
            var checkboxes = document.getElementsByClassName('row-checkbox');
            for (var i = 0; i < checkboxes.length; i++) {
                checkboxes[i].checked = source.checked;
                if (source.checked) {
                    selectedTransactions.add(checkboxes[i].getAttribute('data-id'));
                } else {
                    selectedTransactions.delete(checkboxes[i].getAttribute('data-id'));
                }
            }
            updateSelectedCount();
        }

        function updateSelectedCount() {
            var checkboxes = document.getElementsByClassName('row-checkbox');
            selectedTransactions.clear();

            for (var i = 0; i < checkboxes.length; i++) {
                if (checkboxes[i].checked) {
                    selectedTransactions.add(checkboxes[i].getAttribute('data-id'));
                }
            }

            var count = selectedTransactions.size;
            var selectedBar = document.getElementById('selectedBar');
            var selectedCountSpan = document.getElementById('selectedCount');
            var exportSelectedBtn = document.getElementById('exportSelectedBtn');

            if (count > 0) {
                selectedBar.classList.add('show');
                selectedCountSpan.innerHTML = count + ' transaction(s) selected';
                if (exportSelectedBtn) exportSelectedBtn.disabled = false;
            } else {
                selectedBar.classList.remove('show');
                if (exportSelectedBtn) exportSelectedBtn.disabled = true;
            }

            var selectAllCheckbox = document.getElementById('selectAllCheckbox');
            if (selectAllCheckbox) {
                var totalCheckboxes = checkboxes.length;
                var checkedCheckboxes = document.querySelectorAll('.row-checkbox:checked').length;
                selectAllCheckbox.checked = totalCheckboxes > 0 && checkedCheckboxes === totalCheckboxes;
                selectAllCheckbox.indeterminate = checkedCheckboxes > 0 && checkedCheckboxes < totalCheckboxes;
            }
        }

        function clearAllSelections() {
            var checkboxes = document.getElementsByClassName('row-checkbox');
            for (var i = 0; i < checkboxes.length; i++) {
                checkboxes[i].checked = false;
            }
            selectedTransactions.clear();
            updateSelectedCount();

            var selectAllCheckbox = document.getElementById('selectAllCheckbox');
            if (selectAllCheckbox) selectAllCheckbox.checked = false;
        }

        function exportSelected() {
            if (selectedTransactions.size === 0) {
                alert('Please select at least one transaction to export.');
                return;
            }
            var transactionIds = Array.from(selectedTransactions).join(',');
            window.location.href = 'Transactions.aspx?export=selected&ids=' + transactionIds;
        }

        function exportAll() {
            window.location.href = 'Transactions.aspx?export=all';
        }

        window.onclick = function (event) {
            var modal = document.getElementById('transactionModal');
            if (event.target === modal) closeModal();
        }

        document.addEventListener('keydown', function (e) {
            if (e.key === 'Escape') closeModal();
        });

        document.addEventListener('DOMContentLoaded', function () {
            updateSelectedCount();
        });
    </script>
</asp:Content>