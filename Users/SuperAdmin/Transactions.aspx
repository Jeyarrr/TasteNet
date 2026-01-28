<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/SuperAdmin.Master" AutoEventWireup="true" CodeBehind="Transactions.aspx.cs" Inherits="TasteNet.Users.SuperAdmin.Transactions" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        body { background-color: #FFF9F1; font-family: 'Poppins', sans-serif; margin: 0; }
        .page-container { padding: 40px; }

        /* Header Section */
        .header-section { display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 25px; }
        .header-title h1 { font-size: 32px; color: #2D0A0A; font-weight: 700; margin: 0; }
        .header-title p { color: #8a6d6d; margin: 5px 0 0 0; font-size: 14px; }
        
        .header-actions { display: flex; gap: 10px; }
        .btn-yellow { background-color: #FFD333; color: #2D0A0A; border: none; padding: 12px 25px; border-radius: 12px; font-weight: 600; cursor: pointer; display: flex; align-items: center; gap: 8px; }
        .btn-maroon { background-color: #5D1020; color: white; border: none; padding: 12px 25px; border-radius: 12px; font-weight: 600; cursor: pointer; display: flex; align-items: center; gap: 8px; }

        /* Dashboard Stats */
        .stats-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 20px; margin-bottom: 30px; }
        .stat-card { background: white; padding: 25px; border-radius: 20px; display: flex; justify-content: space-between; align-items: center; box-shadow: 0 10px 30px rgba(93, 16, 32, 0.04); }
        .stat-icon { width: 50px; height: 50px; border-radius: 15px; display: flex; align-items: center; justify-content: center; font-size: 22px; }
        .icon-total { background: #F9ECEE; color: #5D1020; }
        .icon-paid { background: #E6F4F1; color: #2D9D78; }
        .icon-pending { background: #FFF3E0; color: #E67E22; }
        .icon-revenue { background: #E6F4F1; color: #2D9D78; }
        
        .stat-info { text-align: right; }
        .stat-label { color: #8a6d6d; font-size: 13px; font-weight: 500; text-transform: uppercase; }
        .stat-value { font-size: 38px; font-weight: 700; color: #2D0A0A; margin: 5px 0; }
        .stat-value.revenue { color: #5D1020; }

        /* SEPARATED FILTER BAR - Applied from first prompt */
        .filter-container { 
            display: flex; 
            gap: 20px; 
            margin-bottom: 30px; 
            align-items: center; 
            justify-content: flex-start; /* Prevents long stretching */
            width: 100%;
        }

        .search-box { 
            position: relative; 
            width: 350px; /* Short fixed width as requested */
        }

        .search-box i { position: absolute; left: 20px; top: 50%; transform: translateY(-50%); color: #aaa; }
        
        .search-box input { 
            width: 100%; 
            padding: 15px 15px 15px 55px; 
            border: 1px solid #E2D1D1; 
            border-radius: 15px; 
            outline: none; 
            font-size: 15px;
            box-sizing: border-box;
            background: #fff;
        }

        .filter-select { 
            padding: 15px; 
            border: 1px solid #E2D1D1; 
            border-radius: 15px; 
            color: #555; 
            background: white; 
            width: 200px; 
            font-size: 15px;
            outline: none;
        }

        .filter-date { 
            padding: 14px; 
            border: 1px solid #E2D1D1; 
            border-radius: 15px; 
            color: #555; 
            background: white; 
            width: 200px;
            outline: none;
            font-size: 15px;
        }

        /* Table Card */
        .table-card { background: white; border-radius: 25px; box-shadow: 0 10px 40px rgba(93, 16, 32, 0.04); overflow: hidden; }
        .trans-table { width: 100%; border-collapse: collapse; text-align: left; }
        .trans-table th { background: #fff; padding: 22px; color: #8a6d6d; font-size: 14px; font-weight: 600; border-bottom: 1px solid #F3EBE0; }
        .trans-table td { padding: 22px; border-bottom: 1px solid #F9F4EE; font-size: 14px; vertical-align: middle; }
        
        .txn-link { color: #B91C1C; font-weight: 600; text-decoration: none; }
        .amount-text { font-weight: 700; color: #2D9D78; }
        .text-muted { color: #8a6d6d; font-size: 12px; }

        /* Status Badges */
        .status-badge { padding: 8px 15px; border-radius: 10px; font-size: 11px; font-weight: 800; text-transform: uppercase; letter-spacing: 0.5px; }
        .status-paid { background: #E6F4F1; color: #2D9D78; }
        .status-pending { background: #FFF3E0; color: #E67E22; }
        .status-failed { background: #FEE2E2; color: #B91C1C; }

        .action-icons { display: flex; gap: 20px; color: #8a6d6d; font-size: 18px; cursor: pointer; }
    </style>

    <div class="page-container">
        <div class="header-section">
            <div class="header-title">
                <h1>Transactions Management</h1>
                <p>Track and monitor all payment transactions</p>
            </div>
            <div class="header-actions">
                <button type="button" class="btn-yellow"><i class="fa fa-file-pdf"></i> Export PDF</button>
                <button type="button" class="btn-maroon"><i class="fa fa-file-excel"></i> Export Excel</button>
            </div>
        </div>

        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon icon-total"><i class="fa fa-receipt"></i></div>
                <div class="stat-info"><span class="stat-label">Total Transactions</span><span class="stat-value">10</span></div>
            </div>
            <div class="stat-card">
                <div class="stat-icon icon-paid"><i class="fa fa-check-circle"></i></div>
                <div class="stat-info"><span class="stat-label">Paid Transactions</span><span class="stat-value">7</span></div>
            </div>
            <div class="stat-card">
                <div class="stat-icon icon-pending"><i class="fa fa-clock"></i></div>
                <div class="stat-info"><span class="stat-label">Pending</span><span class="stat-value">2</span></div>
            </div>
            <div class="stat-card">
                <div class="stat-icon icon-revenue"><i class="fa fa-peso-sign"></i></div>
                <div class="stat-info"><span class="stat-label">Total Revenue</span><span class="stat-value revenue">₱2,650</span></div>
            </div>
        </div>

        <div class="filter-container">
            <div class="search-box">
                <i class="fa fa-search"></i>
                <input type="text" placeholder="Search by transaction ID...">
            </div>
            <select class="filter-select"><option>All Status</option></select>
            <select class="filter-select"><option>All Methods</option></select>
            <input type="date" class="filter-date">
        </div>

        <div class="table-card">
            <table class="trans-table">
                <thead>
                    <tr>
                        <th>Transaction ID</th>
                        <th>Order ID</th>
                        <th>Customer</th>
                        <th>Payment Method</th>
                        <th>Date & Time</th>
                        <th>Amount</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <asp:Repeater ID="rptTransactions" runat="server">
                        <ItemTemplate>
                            <tr>
                                <td><a href="#" class="txn-link"><%# Eval("TxnID") %></a></td>
                                <td><%# Eval("OrderID") %></td>
                                <td><%# Eval("Customer") %></td>
                                <td><i class="fa <%# Eval("Method").ToString() == "GCash" ? "fa-mobile-alt" : "fa-hand-holding-usd" %>" style="margin-right: 8px; color: #8a6d6d;"></i><%# Eval("Method") %></td>
                                <td>
                                    <div style="font-weight:600;"><%# Eval("Date", "{0:MMM d, yyyy}") %></div>
                                    <div class="text-muted"><%# Eval("Date", "{0:HH:mm:ss}") %></div>
                                </td>
                                <td class="amount-text">₱<%# Eval("Amount") %></td>
                                <td><span class='status-badge status-<%# Eval("Status").ToString().ToLower() %>'><%# Eval("Status") %></span></td>
                                <td class="action-icons">
                                    <i class="fa fa-eye"></i>
                                    <i class="fa fa-download"></i>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </tbody>
            </table>
        </div>
    </div>
</asp:Content>
