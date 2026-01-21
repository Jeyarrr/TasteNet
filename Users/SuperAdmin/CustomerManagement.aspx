<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/SuperAdmin.Master" AutoEventWireup="true" CodeBehind="CustomerManagement.aspx.cs" Inherits="TasteNet.Users.SuperAdmin.CustomerManagement" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<style>
    /* Global Styles */
    body { background-color: #FFF9F1 !important; }
    
    #user-mgmt-wrapper {
        font-family: 'Poppins', sans-serif;
        padding: 20px 30px;
    }

    /* Customer Management Header */
    .page-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px; }
    .header-title h2 { color: #2D0A0A; font-weight: 700; margin: 0; font-size: 32px; }
    .header-title p { color: #8a6d6d; margin: 5px 0 0 0; font-size: 14px; }

    .btn-yellow { 
        background-color: #FFD333; color: #2D0A0A; font-weight: 600; 
        border: none; padding: 10px 22px; border-radius: 10px; 
        cursor: pointer; transition: 0.3s;
    }
    .btn-maroon { 
        background-color: #5D1020; color: #fff; font-weight: 500; 
        border: none; padding: 10px 22px; border-radius: 10px; 
        cursor: pointer; transition: 0.3s;
    }

    /* Stats Cards */
    .stats-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 25px; margin-bottom: 35px; }
    .stat-box { 
        background: #fff; padding: 25px; border-radius: 20px; 
        display: flex; justify-content: space-between; align-items: flex-start;
        box-shadow: 0 10px 30px rgba(93, 16, 32, 0.03); 
    }
    .stat-icon { width: 45px; height: 45px; border-radius: 12px; display: flex; align-items: center; justify-content: center; font-size: 18px; }
    .icon-total { background: #F9ECEE; color: #5D1020; }
    .icon-active { background: #EDF7F4; color: #2D9D78; }
    .icon-blocked { background: #FFF3F3; color: #B91C1C; }
    .icon-revenue { background: #EEF7F5; color: #1E5649; }
    .stat-info { text-align: right; }
    .stat-info span { font-size: 12px; color: #8a6d6d; font-weight: 500; }
    .stat-info h3 { font-size: 36px; font-weight: 700; color: #5D1020; margin: 5px 0 0 0; }

    /* FIXED: Filters and Search Layout */
    .filter-row { 
        display: flex; 
        gap: 15px; 
        margin-bottom: 25px; 
        align-items: center; 
        justify-content: flex-start;
        flex-wrap: nowrap; /* Prevents overlap on smaller screens */
    }
    .inner-search { 
        position: relative; 
        width: 350px;
    }
    .inner-search i { position: absolute; left: 15px; top: 50%; transform: translateY(-50%); color: #aaa; }
    .inner-search input { 
        width: 100%; 
        padding: 12px 15px 12px 45px; 
        border: 1px solid #e2d1d1; 
        border-radius: 10px; 
        font-size: 14px; 
        background: #fff;
        box-sizing: border-box;
    }
    .filter-select { 
        padding: 12px 15px; border: 1px solid #e2d1d1; 
        border-radius: 10px; min-width: 160px; background: white; 
        color: #555; font-size: 14px;
    }

    /* Table Design */
    .table-container { 
        background: #fff; border-radius: 20px; 
        overflow: hidden; box-shadow: 0 10px 30px rgba(93, 16, 32, 0.03); 
        padding: 10px;
    }
    .custom-table { width: 100%; border-collapse: collapse; }
    .custom-table th { 
        padding: 18px 15px; text-align: left; font-size: 13px; 
        color: #8a6d6d; font-weight: 500; border-bottom: 1px solid #f3ebe0; 
    }
    .custom-table td { padding: 18px 15px; border-bottom: 1px solid #f9f4ee; font-size: 14px; vertical-align: middle; }
    .cust-id { color: #800020; font-weight: 600; font-size: 13px; }
    .user-name { color: #2D0A0A; font-weight: 600; display: block; }
    .user-handle { font-size: 11px; color: #8a6d6d; }
    .badge-active { background: #E6F4F1; color: #2D9D78; padding: 6px 14px; border-radius: 8px; font-size: 11px; font-weight: 700; }
    .badge-blocked { background: #FEE2E2; color: #B91C1C; padding: 6px 14px; border-radius: 8px; font-size: 11px; font-weight: 700; }
    .action-btns { display: flex; gap: 15px; font-size: 16px; color: #8a6d6d; }
    .action-btns i { cursor: pointer; transition: 0.2s; }
    .action-btns i:hover { color: #5D1020; }
</style>

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
        <div class="inner-search">
            <i class="fa fa-search"></i>
            <input type="text" placeholder="Search by name, email, contact number, or ID...">
        </div>
        <select class="filter-select">
            <option>All Status</option>
            <option>Active</option>
            <option>Blocked</option>
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
                                <span class="user-name"><%# Eval("FullName") %></span>
                                <span class="user-handle">@<%# Eval("Username") %></span>
                            </td>
                            <td>
                                <div style="font-size:12px; font-weight: 500;"><%# Eval("Email") %></div>
                                <div class="user-handle"><%# Eval("Contact") %></div>
                            </td>
                            <td>
                                <%# Eval("DateRegistered", "{0:MMM dd, yyyy}") %>
                            </td>
                            <td>
                                <span class='<%# Eval("Status").ToString() == "ACTIVE" ? "badge-active" : "badge-blocked" %>'>
                                    <%# Eval("Status") %>
                                </span>
                            </td>
                            <td style="color: #5D1020; font-weight: 700; font-size: 15px;"><%# Eval("TotalOrders") %></td>
                            <td style="color: #2D9D78; font-weight: 700; font-size: 15px;">₱<%# Eval("TotalSpent", "{0:N0}") %></td>
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
