<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/SuperAdmin.Master" AutoEventWireup="true" CodeBehind="StockManagement.aspx.cs" Inherits="TasteNet.Users.SuperAdmin.StockManagement" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        /* ELIMINATE BLACK SIDES: Force full width */
        html, body { margin: 0; padding: 0; width: 100%; height: 100%; background-color: #FFF9F1 !important; }

        /* Use this to override any Bootstrap container constraints in your MasterPage */
        .container, .container-fluid { 
            max-width: none !important; 
            padding: 0 !important; 
            margin: 0 !important; 
            width: 100% !important;
        }

        #full-page-wrapper {
            font-family: 'Poppins', sans-serif;
            background-color: #FFF9F1;
            min-height: 100vh;
            width: 100%; /* Ensures it fills the screen */
            padding: 40px;
            box-sizing: border-box;
            display: flex;
            flex-direction: column;
        }

        /* Header Section */
        .page-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px; width: 100%; }
        .header-title h2 { color: #2D0A0A; font-weight: 700; margin: 0; font-size: 32px; }
        .header-title p { color: #8a6d6d; margin: 5px 0 0 0; font-size: 16px; }

        .btn-yellow { background-color: #FFD333; color: #2D0A0A; font-weight: 600; border: none; padding: 12px 25px; border-radius: 12px; cursor: pointer; }
        .btn-maroon { background-color: #5D1020; color: #fff; font-weight: 500; border: none; padding: 12px 25px; border-radius: 12px; cursor: pointer; margin-left: 10px; }

        /* Stats Cards - Now fluid to width */
        .stats-grid { 
            display: grid; 
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); 
            gap: 25px; 
            margin-bottom: 40px; 
            width: 100%;
        }
        .stat-card { 
            background: #fff; 
            padding: 30px; 
            border-radius: 20px; 
            display: flex; 
            justify-content: space-between; 
            align-items: center;
            box-shadow: 0 10px 30px rgba(93, 16, 32, 0.04); 
        }
        .stat-icon { width: 50px; height: 50px; border-radius: 15px; display: flex; align-items: center; justify-content: center; font-size: 22px; }
        .icon-items { background: #F9ECEE; color: #5D1020; }
        .icon-low { background: #FFF3E0; color: #E67E22; }
        .icon-out { background: #FEE2E2; color: #B91C1C; }
        .icon-sales { background: #E6F4F1; color: #2D9D78; }

        .stat-info { text-align: right; }
        .stat-info span { color: #8a6d6d; font-size: 13px; font-weight: 500; text-transform: uppercase; }
        .stat-info h3 { font-size: 38px; font-weight: 700; color: #2D0A0A; margin: 5px 0; }

        /* NO OVERLAP FILTER BAR: Using CSS Grid */
        .filter-container {
            display: grid;
            grid-template-columns: 1fr 220px 220px; /* Search takes rest, filters are fixed */
            gap: 20px;
            margin-bottom: 30px;
            width: 100%;
            align-items: center;
        }
        .search-wrapper { position: relative; width: 100%; }
        .search-wrapper i { position: absolute; left: 20px; top: 50%; transform: translateY(-50%); color: #aaa; }
        .search-wrapper input { 
            width: 100%; 
            padding: 15px 15px 15px 55px; 
            border: 1px solid #E2D1D1; 
            border-radius: 15px; 
            font-size: 15px; 
            outline: none;
            box-sizing: border-box;
        }
        .filter-dropdown { 
            padding: 15px; 
            border: 1px solid #E2D1D1; 
            border-radius: 15px; 
            background: #fff; 
            font-size: 15px; 
            color: #555;
            width: 100%;
        }

        /* Tabs */
        .tab-bar { display: flex; gap: 35px; border-bottom: 2px solid #E2D1D1; margin-bottom: 0; padding-bottom: 0; width: 100%; }
        .tab-link { padding: 15px 5px; cursor: pointer; color: #8a6d6d; font-weight: 500; font-size: 15px; position: relative; border-bottom: 4px solid transparent; }
        .tab-link.active { color: #5D1020; font-weight: 700; border-bottom-color: #5D1020; }
        .tab-badge { background: #FFD333; color: #2D0A0A; font-size: 11px; padding: 3px 8px; border-radius: 8px; margin-left: 10px; font-weight: 700; }

        /* Full Width Table */
        .table-wrapper { 
            background: #fff; 
            border-radius: 0 0 25px 25px; 
            box-shadow: 0 10px 40px rgba(93, 16, 32, 0.04); 
            overflow: hidden; 
            width: 100%;
        }
        .full-table { width: 100%; border-collapse: collapse; }
        .full-table th { padding: 22px; text-align: left; background: #fff; color: #8a6d6d; font-weight: 600; font-size: 14px; border-bottom: 1px solid #F3EBE0; }
        .full-table td { padding: 22px; border-bottom: 1px solid #F9F4EE; vertical-align: middle; }

        .item-box { width: 48px; height: 48px; background: #5D1020; color: #fff; border-radius: 12px; display: flex; align-items: center; justify-content: center; font-weight: 700; font-size: 20px; }
        .stock-badge { padding: 8px 15px; border-radius: 10px; font-size: 11px; font-weight: 800; text-transform: uppercase; }
        .in-stock { background: #E6F4F1; color: #2D9D78; }
        .low-stock { background: #FFF3E0; color: #E67E22; }

        /* Toggle */
        .switch { position: relative; display: inline-block; width: 44px; height: 24px; }
        .switch input { opacity: 0; width: 0; height: 0; }
        .slider { position: absolute; cursor: pointer; top: 0; left: 0; right: 0; bottom: 0; background-color: #ccc; transition: .4s; border-radius: 34px; }
        .slider:before { position: absolute; content: ""; height: 18px; width: 18px; left: 3px; bottom: 3px; background-color: white; transition: .4s; border-radius: 50%; }
        input:checked + .slider { background-color: #2D9D78; }
        input:checked + .slider:before { transform: translateX(20px); }
    </style>

    <div id="full-page-wrapper">
        <div class="page-header">
            <div class="header-title">
                <h2>Menu & Stock Management</h2>
                <p>Manage menu items and inventory levels</p>
            </div>
            <div>
                <button type="button" class="btn-yellow"><i class="fa fa-plus me-2"></i>Add New Item</button>
                <button type="button" class="btn-maroon">Bulk Update Stock</button>
            </div>
        </div>

        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon icon-items"><i class="fa fa-utensils"></i></div>
                <div class="stat-info"><span>Total Menu Items</span><h3>17</h3></div>
            </div>
            <div class="stat-card">
                <div class="stat-icon icon-low"><i class="fa fa-exclamation-triangle"></i></div>
                <div class="stat-info"><span>Low Stock Alerts</span><h3>2</h3></div>
            </div>
            <div class="stat-card">
                <div class="stat-icon icon-out"><i class="fa fa-times-circle"></i></div>
                <div class="stat-info"><span>Out of Stock</span><h3>1</h3></div>
            </div>
            <div class="stat-card">
                <div class="stat-icon icon-sales"><i class="fa fa-peso-sign"></i></div>
                <div class="stat-info"><span>Total Sales Today</span><h3>₱11,625</h3></div>
            </div>
        </div>

        <div class="filter-container">
            <div class="search-wrapper">
                <i class="fa fa-search"></i>
                <input type="text" placeholder="Search by menu item name...">
            </div>
            <select class="filter-dropdown">
                <option>Filter by Category</option>
            </select>
            <select class="filter-dropdown">
                <option>All Stock Status</option>
            </select>
        </div>

        <div class="tab-bar">
            <div class="tab-link active">All Items <span class="tab-badge">17</span></div>
            <div class="tab-link">Sizzling Specials <span class="tab-badge" style="background:#eee">4</span></div>
            <div class="tab-link">Silog Meals <span class="tab-badge" style="background:#eee">9</span></div>
            <div class="tab-link">Special Meals <span class="tab-badge" style="background:#eee">4</span></div>
        </div>

        <div class="table-wrapper">
            <table class="full-table">
                <thead>
                    <tr>
                        <th>Image</th>
                        <th>Item Name</th>
                        <th>Price</th>
                        <th>Stock Status</th>
                        <th>Quantity</th>
                        <th>Sold Today</th>
                        <th>Available</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <asp:Repeater ID="rptStock" runat="server">
                        <ItemTemplate>
                            <tr>
                                <td><div class="item-box"><%# Eval("ItemName").ToString().Substring(0,1) %></div></td>
                                <td>
                                    <div style="font-weight:600; color:#2D0A0A;"><%# Eval("ItemName") %></div>
                                    <div style="font-size:12px; color:#8a6d6d;"><%# Eval("Category") %></div>
                                </td>
                                <td style="font-weight:700;">₱<%# Eval("Price") %></td>
                                <td>
                                    <span class='stock-badge <%# Convert.ToInt32(Eval("Quantity")) < 10 ? "low-stock" : "in-stock" %>'>
                                        <%# Convert.ToInt32(Eval("Quantity")) < 10 ? "LOW STOCK" : "IN STOCK" %>
                                    </span>
                                </td>
                                <td>
                                    <div style="display:flex; align-items:center; gap:12px;">
                                        <button type="button" style="border:1px solid #ddd; background:none; width:28px; height:28px; border-radius:6px; cursor:pointer;">-</button>
                                        <span style="font-weight:700; min-width:20px; text-align:center;"><%# Eval("Quantity") %></span>
                                        <button type="button" style="border:1px solid #ddd; background:none; width:28px; height:28px; border-radius:6px; cursor:pointer;">+</button>
                                    </div>
                                </td>
                                <td style="font-weight:700; color:#5D1020;"><%# Eval("SoldToday") %></td>
                                <td>
                                    <label class="switch">
                                        <input type="checkbox" checked>
                                        <span class="slider"></span>
                                    </label>
                                </td>
                                <td style="color:#8a6d6d; font-size: 18px;">
                                    <i class="fa fa-edit" style="margin-right:20px; cursor:pointer;"></i>
                                    <i class="fa fa-trash" style="cursor:pointer;"></i>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </tbody>
            </table>
        </div>
    </div>
</asp:Content>
