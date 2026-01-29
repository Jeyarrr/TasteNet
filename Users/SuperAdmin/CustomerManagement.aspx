<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/SuperAdmin.Master" AutoEventWireup="true" CodeBehind="CustomerManagement.aspx.cs" Inherits="TasteNet.Users.SuperAdmin.CustomerManagement" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root {
            --primary-maroon: #6b0d1e;
            --soft-cream: #fffaf3;
            --text-dark: #4a0e0e;
            --muted-text: #8a6d6d;
            --card-shadow: 0 10px 30px rgba(107, 13, 30, 0.05);
            --success-green: #2d9d78;
            --radius-lg: 16px;
            --radius-xl: 20px;
            --radius-2xl: 25px;
        }

        body {
            background-color: var(--soft-cream) !important;
            font-family: 'Poppins', sans-serif;
        }

        #user-mgmt-wrapper {
            padding: 25px 35px;
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 35px;
        }

        .header-title h2 {
            color: var(--text-dark);
            font-weight: 700;
            margin: 0;
            font-size: 32px;
            letter-spacing: -0.5px;
        }

        .header-title p {
            color: var(--muted-text);
            margin: 8px 0 0 0;
            font-size: 16px;
        }

        .header-actions {
            display: flex;
            gap: 25px;
            align-items: center;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 25px;
            margin-bottom: 40px;
        }

        .stat-box {
            background: white;
            padding: 30px 25px;
            border-radius: var(--radius-2xl);
            display: flex;
            flex-direction: row-reverse;
            justify-content: space-between;
            align-items: center;
            box-shadow: var(--card-shadow);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            border: none;
            cursor: pointer;
        }

        .stat-box:hover {
            transform: translateY(-8px);
            box-shadow: 0 15px 40px rgba(107, 13, 30, 0.12);
        }

        .stat-icon {
            width: 50px;
            height: 50px;
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
        }

        .icon-total { background: #fff9e6; color: #d97706; }
        .icon-active { background: #edf7f4; color: var(--success-green); }
        .icon-blocked { background: #fff3e6; color: #d97706; }
        .icon-revenue { background: #f9ecee; color: var(--primary-maroon); }

        .stat-info span {
            font-size: 15px;
            color: var(--muted-text);
            font-weight: 500;
        }

        .stat-info h3 {
            font-size: 36px;
            font-weight: 700;
            color: var(--primary-maroon);
            margin: 12px 0 0 0;
        }

        .filter-container {
            display: flex;
            flex-direction: row;
            align-items: center;
            gap: 20px;
            margin-bottom: 30px;
        }

        .inner-search {
            position: relative;
            display: flex;
        }

        .inner-search i {
            position: absolute;
            left: 24px;
            top: 50%;
            transform: translateY(-50%);
            color: #aaa;
            font-size: 18px;
        }

        .inner-search input {
            width: 380px;
            max-width: 350px;
            padding: 16px 24px 16px 60px;
            border: 2px solid #e2d1d1;
            border-radius: 18px;
            font-size: 16px;
            background: #ffffff;
            transition: all 0.3s ease;
            outline: none;
            font-weight: 500;
        }

        .inner-search input:focus {
            border-color: var(--primary-maroon);
            box-shadow: 0 0 0 4px rgba(107, 13, 30, 0.08);
        }

        .filter-group {
            display: flex;
            justify-content: flex-start;
            gap: 15px;
            flex-shrink: 0;
        }

        .filter-select {
            padding: 14px 20px;
            border: 2px solid #e2d1d1;
            border-radius: 16px;
            background: white;
            color: var(--text-dark);
            font-size: 15px;
            cursor: pointer;
            min-width: 160px;
            outline: none;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .filter-select:focus {
            border-color: var(--primary-maroon);
            box-shadow: 0 0 0 3px rgba(107, 13, 30, 0.05);
        }
        
        .table-container {
            background: white;
            border-radius: var(--radius-2xl);
            padding: 10px 25px 25px 25px;
            box-shadow: var(--card-shadow);
            overflow-x: auto;
        }

        .custom-table {
            width: 100%;
            border-collapse: collapse;
        }

        .custom-table th {
            padding: 24px 18px;
            text-align: center;
            font-size: 17px;
            color: var(--muted-text);
            font-weight: 600;
            border-bottom: 2px solid #f3ebe0;
            letter-spacing: 0.3px;
        }

        .custom-table td {
            padding: 26px 18px;
            border-bottom: 1px solid #f9f4ee;
            font-size: 17px;
            vertical-align: middle;
            color: var(--text-dark);
            text-align: center;
        }

        .cust-id {
            color: var(--primary-maroon) !important;
            font-weight: 700;
            font-size: 17px;
        }

        .user-name {
            color: var(--text-dark) !important;
            font-weight: 600;
            display: block;
            font-size: 18px;
        }

        .user-handle {
            font-size: 14px;
            color: var(--muted-text);
        }

        .contact-email {
            font-size: 15px;
            font-weight: 500;
        }

        .cell-orders {
            color: var(--primary-maroon);
            font-weight: 700;
            font-size: 18px;
        }

        .cell-spent {
            color: var(--success-green);
            font-weight: 700;
            font-size: 18px;
        }

        .badge-active {
            background: #E6F4F1;
            color: var(--success-green);
            padding: 10px 20px;
            border-radius: 14px;
            font-size: 14px;
            font-weight: 700;
            display: inline-block;
        }

        .badge-blocked {
            background: #FEE2E2;
            color: #B91C1C;
            padding: 10px 20px;
            border-radius: 14px;
            font-size: 14px;
            font-weight: 700;
            display: inline-block;
        }

        .action-btns {
            display: flex;
            gap: 25px;
            font-size: 20px;
            color: var(--muted-text);
            justify-content: center;
        }

        .action-btns i {
            cursor: pointer;
            transition: 0.2s;
            padding: 8px;
            border-radius: 10px;
            background: #f9f4ee;
        }

        .action-btns i:hover {
            color: var(--primary-maroon);
            background: #f3ebe0;
            transform: scale(1.1);
        }

        .btn-maroon {
            background: var(--primary-maroon);
            color: white;
            border: none;
            border-radius: 16px;
            padding: 16px 32px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            font-size: 16px;
            box-shadow: 0 4px 12px rgba(107, 13, 30, 0.2);
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .btn-maroon:hover {
            background: #5a0b19;
            transform: translateY(-2px);
            box-shadow: 0 6px 18px rgba(107, 13, 30, 0.3);
        }

        .btn-yellow {
            background: #ffcc00;
            border: none;
            border-radius: 16px;
            padding: 16px 32px;
            font-weight: 600;
            color: #4a0e0e;
            cursor: pointer;
            transition: all 0.3s ease;
            font-size: 16px;
            box-shadow: 0 4px 12px rgba(255, 204, 0, 0.2);
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .btn-yellow:hover {
            background: #e6b800;
            transform: translateY(-2px);
            box-shadow: 0 6px 18px rgba(255, 204, 0, 0.3);
        }

        .custom-table tbody tr {
            transition: all 0.3s ease;
            border-radius: 12px;
        }

        .custom-table tbody tr:hover {
            background-color: #fefaf5;
            transform: scale(1.005);
            box-shadow: 0 4px 12px rgba(107, 13, 30, 0.05);
        }

        .pagination {
            display: flex;
            gap: 8px;
            margin-top: 25px;
            justify-content: center;
        }

        .page-item {
            background: white;
            border: 2px solid #e2d1d1;
            border-radius: 12px;
            padding: 12px 18px;
            cursor: pointer;
            transition: all 0.3s ease;
            font-weight: 600;
        }

        .page-item:hover {
            background: var(--soft-cream);
            border-color: var(--primary-maroon);
        }

        .page-item.active {
            background: var(--primary-maroon);
            color: white;
            border-color: var(--primary-maroon);
        }
    </style>

    <div id="user-mgmt-wrapper">
        <div class="page-header">
            <div class="header-title">
                <h2>Customer Management</h2>
                <p>Monitor and manage all registered customers</p>
            </div>
            <div class="header-actions">
                <button type="button" class="btn-yellow"><i class="fa fa-plus me-2"></i>Add Customer</button>
                <button type="button" class="btn-maroon"><i class="fa fa-download me-2"></i>Export Data</button>
            </div>
        </div>

        <div class="stats-grid">
            <div class="stat-box">
                <div class="stat-icon icon-total"><i class="fa fa-users"></i></div>
                <div class="stat-info"><span>Total Customers</span><h3>8</h3></div>
            </div>
            <div class="stat-box">
                <div class="stat-icon icon-active"><i class="fa fa-user-check"></i></div>
                <div class="stat-info"><span>Active Customers</span><h3>7</h3></div>
            </div>
            <div class="stat-box">
                <div class="stat-icon icon-blocked"><i class="fa fa-ban"></i></div>
                <div class="stat-info"><span>Blocked</span><h3>1</h3></div>
            </div>
            <div class="stat-box">
                <div class="stat-icon icon-revenue"><i class="fa fa-peso-sign"></i></div>
                <div class="stat-info"><span>Total Revenue</span><h3>₱59,035</h3></div>
            </div>
        </div>

        <div class="filter-container">
            <div class="inner-search">
                <i class="fa fa-search"></i>
                <input type="text" placeholder="Search by name, ID, or contact number...">
            </div>
            <div class="filter-group">
                <select class="filter-select">
                    <option>All Status</option>
                    <option>Active</option>
                    <option>Blocked</option>
                </select>
                <select class="filter-select">
                    <option>Sort by: Name</option>
                    <option>Sort by: Date Registered</option>
                </select>
            </div>
        </div>

        <div class="table-container">
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
                                <td class="cust-id"><%# Eval("CustomerID") %></td>
                                <td>
                                    <span class="user-name"><%# Eval("FullName") %></span>
                                    <span class="user-handle">@<%# Eval("Username") %></span>
                                </td>
                                <td>
                                    <div class="contact-email"><%# Eval("Email") %></div>
                                    <div class="user-handle"><%# Eval("Contact") %></div>
                                </td>
                                <td><%# Eval("DateRegistered", "{0:MMM dd, yyyy}") %></td>
                                <td>
                                    <span class='<%# Eval("Status").ToString() == "ACTIVE" ? "badge-active" : "badge-blocked" %>'>
                                        <%# Eval("Status") %>
                                    </span>
                                </td>
                                <td class="cell-orders"><%# Eval("TotalOrders") %></td>
                                <td class="cell-spent">₱<%# Eval("TotalSpent", "{0:N0}") %></td>
                                <td>
                                    <div class="action-btns">
                                        <i class="fa fa-eye" title="View"></i>
                                        <i class="fa fa-edit" title="Edit"></i>
                                        <i class="fa fa-ban" title="Block"></i>
                                        <i class="fa fa-trash" title="Delete"></i>
                                    </div>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </tbody>
            </table>
        </div>
    </div>
   
</asp:Content>
