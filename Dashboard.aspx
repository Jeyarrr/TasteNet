<%@ Page Title="Dashboard" Language="C#" MasterPageFile="~/Sidebar.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="TasteNet.Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
        }

        .dashboard-container {
            padding: 25px;
            background: #FFE6BF;
        }

        /* ===== TOP BAR ===== */
        .dashboard-header {
            background: #FFD000;
            padding: 15px 25px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .dashboard-header h2 {
            margin: 0;
            font-weight: 600;
        }

        .search-box input {
            padding: 8px 15px;
            width: 280px;
            border-radius: 20px;
            border: none;
            outline: none;
        }

        /* ===== WELCOME ===== */
        .welcome {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 20px;
        }

        .btn-yellow {
            background: #FFD000;
            border: none;
            padding: 8px 15px;
            border-radius: 6px;
            font-weight: 600;
            cursor: pointer;
        }

        /* ===== CARDS ===== */
        .cards {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            margin-top: 20px;
        }

        .card {
            background: #fff;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(0,0,0,.1);
        }

        .card h4 {
            margin: 0;
            color: #555;
            font-weight: 500;
        }

        .card h1 {
            margin: 10px 0;
            color: maroon;
        }

        /* ===== GRID ===== */
        .grid {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 20px;
            margin-top: 25px;
        }

        .panel {
            background: white;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(0,0,0,.1);
        }

        .panel h3 {
            margin-top: 0;
            color: maroon;
        }

        /* ===== TABLE ===== */
        table {
            width: 100%;
            border-collapse: collapse;
            font-size: 14px;
        }

        th, td {
            padding: 10px;
            border-bottom: 1px solid #ddd;
        }

        th {
            background: #FFD000;
        }

        /* ===== STOCK ALERT ===== */
        .alert {
            background: #FFF1E5;
            padding: 10px;
            border-radius: 6px;
            margin-bottom: 10px;
            font-size: 14px;
        }

        /* ===== QUICK ACTIONS ===== */
        .actions button {
            width: 100%;
            margin-bottom: 10px;
            padding: 10px;
            border-radius: 6px;
            border: 1px solid maroon;
            background: white;
            cursor: pointer;
            font-weight: 500;
        }

        .actions button.primary {
            background: maroon;
            color: white;
        }
    </style>

    <div class="dashboard-container">

        <!-- HEADER -->
        <div class="dashboard-header">
            <h2>Dashboard</h2>
            <div class="search-box">
                <asp:TextBox ID="txtSearch" runat="server" Placeholder="Search order, user..." />
            </div>
        </div>

        <!-- WELCOME -->
        <div class="welcome">
            <div>
                <h2>Welcome Back, Admin!</h2>
                <p>Here's what's happening with your platform today.</p>
            </div>
            <asp:Button ID="btnExport" runat="server" Text="Export Report" CssClass="btn-yellow" />
        </div>

        <!-- STAT CARDS -->
        <div class="cards">
            <div class="card">
                <h4>Total Orders Today</h4>
                <h1>156</h1>
                <small>+12% from yesterday</small>
            </div>

            <div class="card">
                <h4>Today's Revenue</h4>
                <h1>₱45,680</h1>
                <small>+8% from yesterday</small>
            </div>

            <div class="card">
                <h4>New Customers</h4>
                <h1>1,234</h1>
                <small>+23% today</small>
            </div>

            <div class="card">
                <h4>Pending Approvals</h4>
                <h1>8</h1>
            </div>
        </div>

        <!-- GRID -->
        <div class="grid">

            <!-- RECENT ORDERS -->
            <div class="panel">
                <h3>Recent Orders</h3>
                <table>
                    <tr>
                        <th>Order ID</th>
                        <th>Customer</th>
                        <th>Payment</th>
                        <th>Items</th>
                        <th>Amount</th>
                        <th>Status</th>
                    </tr>
                    <tr>
                        <td>#2234</td>
                        <td>Jayr Casano</td>
                        <td>COD</td>
                        <td>Tapsilog x2</td>
                        <td>₱350</td>
                        <td>Active</td>
                    </tr>
                    <tr>
                        <td>#2235</td>
                        <td>George Gonzaga</td>
                        <td>GCash</td>
                        <td>Tofu Sisig</td>
                        <td>₱165</td>
                        <td>Completed</td>
                    </tr>
                </table>
            </div>

            <!-- RIGHT SIDE -->
            <div>
                <div class="panel">
                    <h3>Stock Alerts</h3>
                    <div class="alert">Pork Sisig – Low stock (3 left)</div>
                    <div class="alert">Goto Overload – Out of stock</div>
                    <div class="alert">Tofu Sisig – Low stock (5 left)</div>
                </div>

                <div class="panel actions" style="margin-top:20px;">
                    <h3>Quick Actions</h3>
                    <button class="primary">Add New Menu Item</button>
                    <button>Update Stock Levels</button>
                    <button>View Low Stock Items</button>
                    <button>Manage Categories</button>
                </div>
            </div>

        </div>

    </div>

</asp:Content>
