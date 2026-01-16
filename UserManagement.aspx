<%@ Page Title="User Management" Language="C#" MasterPageFile="~/Sidebar.Master" AutoEventWireup="true" CodeBehind="UserManagement.aspx.cs" Inherits="TasteNet.UserManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        /* Top Global Header Styles */
.top-nav-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 15px 0 25px 0;
    margin-bottom: 10px;
}
.top-nav-header h2{
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 15px 0 25px 0;
    margin-bottom: 10px;
    font-color: #5D1020;
}

.top-search-container {
    position: relative;
    width: 450px;
}

.top-search-container i {
    position: absolute;
    left: 15px;
    top: 50%;
    transform: translateY(-50%);
    color: #aaa;
}

.top-search-container input {
    width: 100%;
    padding: 10px 15px 10px 45px;
    border: 1px solid #eee;
    border-radius: 10px;
    background: #fff;
    font-size: 14px;
}

.admin-profile-section {
    display: flex;
    align-items: center;
    gap: 20px;
}

.notif-bell {
    position: relative;
    color: #FFD333;
    font-size: 18px;
    cursor: pointer;
}

.notif-badge {
    position: absolute;
    top: -8px;
    right: -8px;
    background: #FFD333;
    color: #000;
    font-size: 10px;
    font-weight: bold;
    padding: 2px 5px;
    border-radius: 50%;
    border: 2px solid #fff;
}

.user-meta {
    display: flex;
    align-items: center;
    gap: 12px;
}

.user-text {
    text-align: right;
}

.user-text .u-name {
    display: block;
    font-weight: 600;
    font-size: 14px;
    color: #333;
}

.user-text .u-role {
    display: block;
    font-size: 11px;
    color: #999;
}

.user-avatar {
    background: #5D1020;
    color: white;
    width: 40px;
    height: 40px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-weight: bold;
    font-size: 16px;
}
        /* Apply Poppins to everything in this content area */
        #user-mgmt-wrapper {
            font-family: 'Poppins', sans-serif;
            background-color: #FFF9F1;
            padding: 20px;
            min-height: 100vh;
        }

        /* Header Section */
        .page-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px; }
        .header-title h2 { color: #5D1020; font-weight: 700; margin: 0; font-size: 28px; }
        .header-title p { color: #888; margin: 0; font-size: 14px; }

        .btn-yellow { background-color: #FFD333; color: #000; font-weight: 600; border: none; padding: 10px 20px; border-radius: 8px; margin-right: 10px; }
        .btn-maroon { background-color: #5D1020; color: #fff; font-weight: 500; border: none; padding: 10px 20px; border-radius: 8px; }

        /* Stats Cards */
        .stats-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 20px; margin-bottom: 30px; }
        .stat-box { background: #fff; padding: 20px; border-radius: 15px; display: flex; align-items: center; box-shadow: 0 2px 10px rgba(0,0,0,0.02); }
        .stat-icon { width: 50px; height: 50px; border-radius: 12px; display: flex; align-items: center; justify-content: center; margin-right: 15px; font-size: 20px; }
        
        .icon-total { background: #FDE8E8; color: #800020; }
        .icon-active { background: #E8F5E9; color: #2E7D32; }
        .icon-blocked { background: #FFF3E0; color: #EF6C00; }
        .icon-revenue { background: #E0F2F1; color: #00695C; }

        .stat-info span { font-size: 12px; color: #777; display: block; }
        .stat-info h3 { font-size: 24px; font-weight: 700; color: #5D1020; margin: 0; }

        /* Filters */
        .filter-row { display: flex; gap: 15px; margin-bottom: 20px; }
        .search-box { flex: 1; position: relative; }
        .search-box i { position: absolute; left: 15px; top: 12px; color: #aaa; }
        .search-box input { width: 100%; padding: 10px 10px 10px 40px; border: 1px solid #ddd; border-radius: 8px; }
        .filter-select { padding: 10px; border: 1px solid #ddd; border-radius: 8px; min-width: 150px; background: white; }

        /* Table Design */
        .table-container { background: #fff; border-radius: 15px; overflow: hidden; box-shadow: 0 2px 10px rgba(0,0,0,0.02); }
        .custom-table { width: 100%; border-collapse: collapse; }
        .custom-table th { background: #FFF9F1; padding: 15px; text-align: left; font-size: 13px; color: #555; border-bottom: 1px solid #eee; }
        .custom-table td { padding: 15px; border-bottom: 1px solid #eee; font-size: 14px; vertical-align: middle; }
        
        .cust-id { color: #800020; font-weight: 600; }
        .badge-active { background: #E8F5E9; color: #2E7D32; padding: 4px 10px; border-radius: 6px; font-size: 11px; font-weight: 600; }
        .badge-blocked { background: #FDE8E8; color: #C62828; padding: 4px 10px; border-radius: 6px; font-size: 11px; font-weight: 600; }
        
        .action-btns i { color: #aaa; margin: 0 5px; cursor: pointer; transition: 0.3s; }
        .action-btns i:hover { color: #5D1020; }
    </style>
    <div class="top-nav-header">
        <h2>User Management</h2>
    <div class="top-search-container">
        <i class="fa fa-search"></i>
        <input type="text" placeholder="Search orders, restaurants, users...">
    </div>

    <div class="admin-profile-section">
        <div class="notif-bell">
            <i class="fa fa-bell"></i>
            <span class="notif-badge">8</span>
        </div>
        
        <div class="user-meta">
            <div class="user-text">
                <span class="u-name">Admin User</span>
                <span class="u-role">Administrator</span>
            </div>
            <div class="user-avatar">A</div>
            <i class="fa fa-chevron-down" style="font-size: 12px; color: #aaa;"></i>
        </div>
    </div>
</div>
<hr style="border: 0; border-top: 1px solid #eee; margin-bottom: 25px;" />
    <div id="user-mgmt-wrapper">
        <div class="page-header">
            <div class="header-title">
                <h2>Customer Management</h2>
                <p>Monitor and manage all registered customers</p>
            </div>
            <div>
                <button type="button" class="btn-yellow"><i class="fa fa-plus me-2"></i>Add Customer</button>
                <button type="button" class="btn-maroon">Export Data</button>
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

        <div class="filter-row">
            <div class="search-box">
                <i class="fa fa-search"></i>
                <input type="text" placeholder="Search by name, email, contact number, or ID...">
            </div>
            <select class="filter-select">
                <option>All Status</option>
            </select>
            <select class="filter-select">
                <option>Sort by: Date Registered</option>
            </select>
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
                                    <strong><%# Eval("FullName") %></strong><br />
                                    <small class="text-muted">@<%# Eval("Username") %></small>
                                </td>
                                <td>
                                    <small><%# Eval("Email") %></small><br />
                                    <small class="text-muted"><%# Eval("Contact") %></small>
                                </td>
                                <td><%# Eval("DateRegistered", "{0:MMM dd, yyyy}") %></td>
                                <td>
                                    <span class='<%# Eval("Status").ToString() == "ACTIVE" ? "badge-active" : "badge-blocked" %>'>
                                        <%# Eval("Status") %>
                                    </span>
                                </td>
                                <td style="color: #800020; font-weight: 700;"><%# Eval("TotalOrders") %></td>
                                <td style="color: #2E7D32; font-weight: 700;">₱<%# Eval("TotalSpent", "{0:N0}") %></td>
                                <td class="action-btns">
                                    <i class="fa fa-eye"></i>
                                    <i class="fa fa-edit"></i>
                                    <i class="fa fa-ban"></i>
                                    <i class="fa fa-trash"></i>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </tbody>
            </table>
        </div>
    </div>
</asp:Content>