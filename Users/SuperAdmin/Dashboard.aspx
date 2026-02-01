<%@ Page Title="Dashboard | TasteNet" Language="C#" MasterPageFile="~/MasterPages/SuperAdmin.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="TasteNet.Users.SuperAdmin.Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root {
            --primary-maroon: #6b0d1e;
            --soft-cream: #fffaf3;
            --text-dark: #4a0e0e;
            --muted-text: #8a6d6d;
            --success-green: #2d9d78;
            --warning-orange: #d97706;
            --card-shadow: 0 10px 30px rgba(107, 13, 30, 0.05);
            --radius-lg: 16px;
            --radius-xl: 20px;
            --radius-2xl: 25px;
        }

        body {
            background-color: var(--soft-cream) !important;
            font-family: 'Poppins', sans-serif;
            color: var(--text-dark);
        }

        .dashboard-wrapper { padding: 25px 35px; }

        .dashboard-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 35px;
        }

        .welcome h1 { 
            font-size: 32px; 
            font-weight: 700; 
            margin: 0; 
            color: var(--text-dark); 
            letter-spacing: -0.5px;
        }
        .welcome p { 
            color: var(--muted-text); 
            margin: 8px 0 0 0; 
            font-size: 16px; 
        }

        .header-actions { 
            display: flex; 
            gap: 10px;
            align-items: center; 
        }

        .filter-dropdown {
            padding: 8px 12px;
            border-radius: var(--radius-lg);
            border: 1.5px solid #e2d1d1;
            background: white;
            color: #555;
            outline: none;
            font-size: 13px;
            font-family: 'Poppins', sans-serif;
            font-weight: 500;
            min-width: 100px;
            cursor: pointer;
            transition: all 0.3s ease;
            height: 36px;
        }

        .filter-dropdown:focus {
            border-color: var(--primary-maroon);
            box-shadow: 0 0 0 2px rgba(107, 13, 30, 0.05);
        }

        .btn-export {
            background: var(--primary-maroon);
            color: white;
            border: 2px solid transparent;
            padding: 10px 20px;
            border-radius: var(--radius-lg);
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            font-size: 14px;
            font-family: 'Poppins', sans-serif;
            box-shadow: 0 3px 8px rgba(107, 13, 30, 0.2);
            height: 36px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            text-decoration: none;
            white-space: nowrap;
            min-height: 40px;   
            line-height: 1.2;
        }

        .btn-export:hover {
            background: #5a0b19;
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(107, 13, 30, 0.3);
        }

        .btn-export i {
            font-size: 12px;
        }

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

        .stat-label {
            font-size: 14px;
            font-weight: 500;
            color: var(--muted-text);
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 12px;
        }

        .stat-value { 
            font-size: 32px;
            font-weight: 700; 
            color: var(--primary-maroon); 
            margin: 8px 0;
            line-height: 1;
        }
        
        .stat-trend { 
            font-size: 13px;
            font-weight: 600; 
            margin-top: 10px;
        }
        
        .trend-up { 
            color: var(--success-green); 
        }

        .icon-box {
            width: 40px;
            height: 40px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 18px;
        }

        .main-grid {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 30px;
        }

        .chart-box, .side-box {
            background: white;
            border-radius: var(--radius-2xl);
            padding: 25px;
            box-shadow: var(--card-shadow);
        }

        .box-title {
            font-size: 18px;
            font-weight: 700;
            margin-bottom: 20px;
            color: var(--primary-maroon);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .meal-rank {
            width: 32px;
            height: 32px;
            background: var(--primary-maroon) !important;
            color: white;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            font-size: 14px;
            margin-right: 15px;
            flex-shrink: 0;
        }

        .meal-rank.gray {
            background: #e2d1d1 !important;
        }

        .side-box {
            padding: 20px;
        }

        .meal-item {
            display: flex;
            align-items: center;
            padding: 12px 15px;
            border-radius: 14px;
            background: #fffcf8;
            margin-bottom: 10px;
            border: 1.5px solid #f3ebe0;
            transition: all 0.3s ease;
        }

        .meal-item:hover {
            background: #fefaf5;
            border-color: #e2d1d1;
            transform: translateX(3px);
        }

        .meal-info { 
            flex-grow: 1; 
        }
        
        .meal-name { 
            font-weight: 600; 
            font-size: 14px;
            margin: 0 0 4px 0;
            color: var(--text-dark); 
        }
        
        .meal-sales { 
            font-size: 12px;
            color: var(--muted-text); 
            margin: 0; 
        }
        
        .meal-price { 
            font-weight: 700; 
            color: var(--primary-maroon); 
            font-size: 14px;
            margin-left: 10px;
        }

        .badge-stock {
            padding: 6px 12px;
            border-radius: 10px;
            font-size: 10px;
            font-weight: bold;
            text-transform: uppercase;
            display: inline-block;
        }
        
        .in-stock { 
            background: #e6f4f1; 
            color: var(--success-green); 
        }
        
        .low-stock { 
            background: #fff4e6; 
            color: var(--warning-orange); 
        }

        .chart-controls {
            display: flex;
            background: #f3ebe0;
            padding: 5px;
            border-radius: 12px;
            gap: 4px;
        }

        .chart-btn {
            padding: 8px 16px;
            border-radius: 10px;
            border: none;
            font-size: 12px;
            font-weight: 600;
            cursor: pointer;
            background: transparent;
            color: var(--muted-text);
            transition: all 0.3s ease;
            min-width: 60px;
        }

        .chart-btn.active { 
            background: var(--primary-maroon); 
            color: white; 
            box-shadow: 0 2px 6px rgba(107, 13, 30, 0.2);
        }

        .chart-btn:hover:not(.active) {
            background: rgba(107, 13, 30, 0.05);
        }

        .chart-container {
            position: relative;
            height: 280px;
            width: 100%;
            margin-top: 0; 
            padding: 0 5px; 
        }

        #revenueChart {
            width: 100% !important;
            height: 100% !important;
        }

        .table-container {
            background: white;
            border-radius: var(--radius-xl);
            padding: 10px 20px 20px;
            box-shadow: var(--card-shadow);
            overflow-x: auto;
            margin-top: 10px;
        }

        .custom-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
        }

        .custom-table th {
            padding: 22px 16px;
            text-align: center;
            font-size: 16px;
            color: var(--muted-text);
            font-weight: 600;
            border-bottom: 2px solid #f3ebe0;
            letter-spacing: 0.3px;
        }

        .custom-table td {
            padding: 24px 16px;
            border-bottom: 1px solid #f9f4ee;
            font-size: 16px;
            vertical-align: middle;
            color: var(--text-dark);
            text-align: center;
        }

        .custom-table tbody tr {
            transition: all 0.3s ease;
        }

        .custom-table tbody tr:hover {
            background-color: #fefaf5;
            transform: scale(1.005);
        }

        .order-id {
            color: var(--primary-maroon) !important;
            font-weight: 700;
            font-size: 16px;
        }

        .customer-name {
            color: var(--text-dark) !important;
            font-weight: 600;
            font-size: 16px;
        }

        .status-badge {
            padding: 10px 18px;
            border-radius: 14px;
            font-size: 12px;
            font-weight: bold;
            display: inline-block;
        }

        .action-icon {
            width: 40px;
            height: 40px;
            background: #f9f4ee;
            border-radius: 12px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.3s ease;
            color: var(--muted-text);
        }

        .action-icon:hover {
            background: var(--primary-maroon);
            color: white;
            transform: scale(1.1);
        }

        .btn-quick {
            background: var(--primary-maroon);
            color: white;
            border: none;
            border-radius: 16px;
            padding: 18px 24px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            font-size: 15px;
            box-shadow: 0 4px 12px rgba(107, 13, 30, 0.2);
            width: 100%;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }

        .btn-quick:hover {
            background: #5a0b19;
            transform: translateY(-2px);
            box-shadow: 0 6px 18px rgba(107, 13, 30, 0.3);
        }

        .btn-quick.yellow {
            background: #ffcc00;
            color: #4a0e0e;
            box-shadow: 0 4px 12px rgba(255, 204, 0, 0.2);
        }

        .btn-quick.yellow:hover {
            background: #e6b800;
            box-shadow: 0 6px 18px rgba(255, 204, 0, 0.3);
        }

        .btn-quick.outline {
            background: white;
            color: var(--primary-maroon);
            border: 2px solid var(--primary-maroon);
            box-shadow: 0 2px 8px rgba(107, 13, 30, 0.1);
        }

        .btn-quick.outline:hover {
            background: var(--soft-cream);
            border-color: #5a0b19;
        }

        .alert-badge {
            background: var(--primary-maroon);
            color: white;
            border-radius: 50%;
            padding: 2px 10px;
            font-size: 12px;
            font-weight: bold;
            margin-left: 8px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-width: 20px;
            height: 20px;
        }

        .view-all-link {
            font-size: 14px;
            color: var(--primary-maroon);
            text-decoration: none;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 5px;
            transition: all 0.3s ease;
            padding: 8px 12px;
            border-radius: 12px;
            background: #f9f4ee;
        }

        .view-all-link:hover {
            background: var(--primary-maroon);
            color: white;
        }

        .recent-orders-full {
            grid-column: 1 / -1;
            margin-top: 30px;
        }

        .recent-orders-full .table-container {
            margin-top: 0;
        }

        .recent-orders-full .custom-table th {
            font-size: 13px;
            padding: 16px 12px;
        }

        .recent-orders-full .custom-table td {
            font-size: 13px;
            padding: 18px 12px;
        }

        .recent-orders-full .order-id {
            font-size: 13px;
        }

        .recent-orders-full .customer-name {
            font-size: 13px;
        }

        .recent-orders-full .status-badge {
            font-size: 11px;
            padding: 6px 12px;
        }

        .recent-orders-full .action-icon {
            width: 32px;
            height: 32px;
            font-size: 12px;
        }

        .stock-quick-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-top: 30px;
        }

        .compact-actions .btn-quick {
            padding: 12px 16px; 
            margin-bottom: 10px;
            font-size: 14px; 
            border-radius: 12px; 
        }

        .compact-actions .btn-quick i {
            font-size: 13px; 
        }

        @media (max-width: 1200px) {
            .stat-grid {
                grid-template-columns: repeat(2, 1fr);
            }
            .main-grid {
                grid-template-columns: 1fr;
            }
            .stock-quick-grid {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 768px) {
            .dashboard-wrapper {
                padding: 15px;
            }
            .stat-grid {
                grid-template-columns: 1fr;
            }
            .dashboard-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 20px;
            }
            .header-actions {
                width: 100%;
                justify-content: space-between;
            }
        }
    </style>

    <div class="dashboard-wrapper">
        <div class="dashboard-header">
            <div class="welcome">
                <h1>Welcome back, Admin!</h1>
                <p>Here's what's happening with your platform today.</p>
            </div>
            <div class="header-actions">
                <asp:DropDownList ID="ddlTimeRange" runat="server" CssClass="filter-dropdown">
                    <asp:ListItem Text="Last 7 days" Value="7" />
                    <asp:ListItem Text="Last 30 days" Value="30" />
                </asp:DropDownList>
                <button type="button" class="btn-export"><i class="fas fa-download me-2"></i>Export Report</button>
            </div>
        </div>

        <div class="stat-grid">
            <div class="stat-card">
                <div class="stat-label">
                    Total Orders Today
                    <div class="icon-box" style="background:#fff9e6; color:#d97706;"><i class="fas fa-shopping-bag"></i></div>
                </div>
                <div class="stat-value">156</div>
                <div class="stat-trend trend-up"><i class="fas fa-arrow-up"></i> +12% <small style="color:#8a6d6d">from yesterday</small></div>
            </div>

            <div class="stat-card">
                <div class="stat-label">
                    Today's Revenue
                    <div class="icon-box" style="background:#f9ecee; color:#6b0d1e;"><i class="fas fa-peso-sign"></i></div>
                </div>
                <div class="stat-value">₱45,680</div>
                <div class="stat-trend trend-up"><i class="fas fa-arrow-up"></i> +8% <small style="color:#8a6d6d">from yesterday</small></div>
            </div>

            <div class="stat-card">
                <div class="stat-label">
                    Active Users
                    <div class="icon-box" style="background:#edf7f4; color:#2d9d78;"><i class="fas fa-users"></i></div>
                </div>
                <div class="stat-value">1,234</div>
                <div class="stat-trend trend-up"><i class="fas fa-plus"></i> 23 <small style="color:#8a6d6d">new today</small></div>
            </div>

            <div class="stat-card">
                <div class="stat-label">
                    Pending Approvals
                    <div class="icon-box" style="background:#fff3e6; color:#d97706;"><i class="fas fa-clock"></i></div>
                </div>
                <div class="stat-value">8</div>
                <div class="stat-trend" style="color:#8a6d6d">Action required</div>
            </div>
        </div>

        <div class="main-grid">
            <div class="chart-box">
                <div class="box-title">
                    Revenue Overview
                    <div class="chart-controls">
                        <button type="button" class="chart-btn active">Daily</button>
                        <button type="button" class="chart-btn">Weekly</button>
                        <button type="button" class="chart-btn">Monthly</button>
                    </div>
                </div>
                <div class="chart-container">
                    <canvas id="revenueChart"></canvas>
                </div>
            </div>

            <div class="side-box">
                <div class="box-title">Top Selling Meals This Week</div>
                
                <div class="meal-item">
                    <div class="meal-rank">1</div>
                    <div class="meal-info">
                        <p class="meal-name">Tapsilog</p>
                        <p class="meal-sales">132 orders</p>
                        <span class="badge-stock in-stock">In Stock</span>
                    </div>
                    <div class="meal-price">₱1,980</div>
                </div>

                <div class="meal-item">
                    <div class="meal-rank">2</div>
                    <div class="meal-info">
                        <p class="meal-name">Pork Sisig</p>
                        <p class="meal-sales">98 orders</p>
                        <span class="badge-stock low-stock">Low Stock</span>
                    </div>
                    <div class="meal-price">₱1,470</div>
                </div>

                <div class="meal-item">
                    <div class="meal-rank">3</div>
                    <div class="meal-info">
                        <p class="meal-name">Longsilog</p>
                        <p class="meal-sales">87 orders</p>
                        <span class="badge-stock in-stock">In Stock</span>
                    </div>
                    <div class="meal-price">₱1,305</div>
                </div>

                <div class="meal-item">
                    <div class="meal-rank">4</div>
                    <div class="meal-info">
                        <p class="meal-name">Bangsilog</p>
                        <p class="meal-sales">76 orders</p>
                        <span class="badge-stock in-stock">In Stock</span>
                    </div>
                    <div class="meal-price">₱1,140</div>
                </div>
            </div>
        </div>
        
        <div class="recent-orders-full">
            <div class="chart-box">
                <div class="box-title">
                    Recent Orders
                    <a href="#" class="view-all-link">View All <i class="fas fa-arrow-right"></i></a>
                </div>
                <div class="table-container">
                    <table class="custom-table">
                        <thead>
                            <tr>
                                <th>Order ID</th>
                                <th>Customer</th>
                                <th>Mode of Payment</th>
                                <th>Items</th>
                                <th>Amount</th>
                                <th>Status</th>
                                <th>Time</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td class="order-id">#12345</td>
                                <td class="customer-name">Jay-r Casano</td>
                                <td>Cash On Delivery</td>
                                <td>Tapsilog x2</td>
                                <td style="font-weight:700; color:var(--primary-maroon); font-size: 13px;">₱350</td>
                                <td><span class="badge-stock in-stock">COMPLETED</span></td>
                                <td style="font-weight:600; color:var(--text-dark); font-size: 13px;">10:00 AM</td>
                                <td><div class="action-icon"><i class="fas fa-eye"></i></div></td>
                            </tr>
                            <tr>
                                <td class="order-id">#12346</td>
                                <td class="customer-name">George Gonzaga</td>
                                <td>GCash</td>
                                <td>Tofu Sisig x2</td>
                                <td style="font-weight:700; color:var(--primary-maroon); font-size: 13px;">₱65</td>
                                <td><span class="badge-stock in-stock">COMPLETED</span></td>
                                <td style="font-weight:600; color:var(--text-dark); font-size: 13px;">10:00 AM</td>
                                <td><div class="action-icon"><i class="fas fa-eye"></i></div></td>
                            </tr>
                            <tr>
                                <td class="order-id">#12347</td>
                                <td class="customer-name">Zea Mae Sulit</td>
                                <td>Paypal</td>
                                <td>Arrozcaldo x1</td>
                                <td style="font-weight:700; color:var(--primary-maroon); font-size: 13px;">₱50</td>
                                <td><span class="badge-stock in-stock">COMPLETED</span></td>
                                <td style="font-weight:600; color:var(--text-dark); font-size: 13px;">10:00 AM</td>
                                <td><div class="action-icon"><i class="fas fa-eye"></i></div></td>
                            </tr>
                            <tr>
                                <td class="order-id">#12348</td>
                                <td class="customer-name">Lalaine Reyes</td>
                                <td>Cash On Delivery</td>
                                <td>Goto Special x2</td>
                                <td style="font-weight:700; color:var(--primary-maroon); font-size: 13px;">₱120</td>
                                <td><span class="badge-stock in-stock">COMPLETED</span></td>
                                <td style="font-weight:600; color:var(--text-dark); font-size: 13px;">10:00 AM</td>
                                <td><div class="action-icon"><i class="fas fa-eye"></i></div></td>
                            </tr>
                            <tr>
                                <td class="order-id">#12349</td>
                                <td class="customer-name">Bryle Andre Magallano</td>
                                <td>GoTyme</td>
                                <td>Tapsilog x2</td>
                                <td style="font-weight:700; color:var(--primary-maroon); font-size: 13px;">₱350</td>
                                <td><span class="badge-stock in-stock">COMPLETED</span></td>
                                <td style="font-weight:600; color:var(--text-dark); font-size: 13px;">10:00 AM</td>
                                <td><div class="action-icon"><i class="fas fa-eye"></i></div></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <div class="stock-quick-grid">
            <div class="side-box">
                <div class="box-title">
                    Stock Alerts <span class="alert-badge">2</span>
                </div>
                
                <div class="meal-item" style="background: #fff4e6; border-color: #fed7aa; margin-bottom: 12px;">
                    <div class="meal-info">
                        <p class="meal-name">Pork Sisig</p>
                        <p class="meal-sales" style="color: #c2410c; font-weight: 600;">Low stock (3 left)</p>
                    </div>
                </div>

                <div class="meal-item" style="background: #fee2e2; border-color: #fecaca; margin-bottom: 20px;">
                    <div class="meal-info">
                        <p class="meal-name">Goto Overload</p>
                        <p class="meal-sales" style="color: #b91c1c; font-weight: 600;">Out of stock</p>
                    </div>
                </div>

                <button type="button" class="btn-quick yellow"><i class="fas fa-boxes me-2"></i>Manage Stock</button>
            </div>
            
            <div class="side-box compact-actions">
                <div class="box-title">Quick Actions</div>
                <button type="button" class="btn-quick"><i class="fas fa-plus me-2"></i>Add New Menu Item</button>
                <button type="button" class="btn-quick outline"><i class="fas fa-sync-alt me-2"></i>Update Stock Levels</button>
                <button type="button" class="btn-quick outline"><i class="fas fa-exclamation-triangle me-2"></i>View Low Stock Items</button>
            </div>
        </div>
    </div>

    <script>
        var myRevenueChart = null;

        function initDashboardChart() {
            const canvas = document.getElementById('revenueChart');
            if (!canvas) return;

            const ctx = canvas.getContext('2d');

            if (myRevenueChart !== null) {
                myRevenueChart.destroy();
            }

            const gradient = ctx.createLinearGradient(0, 0, 0, 300);
            gradient.addColorStop(0, 'rgba(107, 13, 30, 0.2)');
            gradient.addColorStop(1, 'rgba(107, 13, 30, 0.0)');

            myRevenueChart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: ['Nov 15', 'Nov 16', 'Nov 17', 'Nov 18', 'Nov 19', 'Nov 20', 'Nov 21', 'Nov 22'],
                    datasets: [{
                        label: 'Revenue',
                        data: [32000, 38000, 35000, 42000, 45000, 48000, 52000, 45680],
                        borderColor: '#6b0d1e',
                        borderWidth: 3,
                        backgroundColor: gradient,
                        fill: true,
                        tension: 0.4,
                        pointBackgroundColor: '#6b0d1e',
                        pointBorderColor: '#fff',
                        pointBorderWidth: 2,
                        pointRadius: 5,
                        pointHoverRadius: 7
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    layout: {
                        padding: {
                            top: 5,
                            bottom: 5,
                            left: 10,
                            right: 10
                        }
                    },
                    plugins: {
                        legend: { display: false },
                        tooltip: {
                            backgroundColor: 'rgba(74, 14, 14, 0.9)',
                            titleFont: { size: 13, family: "'Poppins', sans-serif" },
                            bodyFont: { size: 12, family: "'Poppins', sans-serif" },
                            padding: 10,
                            cornerRadius: 8,
                            displayColors: false,
                            callbacks: {
                                label: function (context) {
                                    return '₱' + context.parsed.y.toLocaleString();
                                }
                            }
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            grid: {
                                color: '#f3ebe0',
                                drawBorder: false,
                                lineWidth: 1.5
                            },
                            ticks: {
                                color: '#8a6d6d',
                                font: { size: 11, family: "'Poppins', sans-serif" },
                                padding: 5,
                                maxTicksLimit: 6,
                                callback: function (value) {
                                    if (value >= 1000) {
                                        return '₱' + (value / 1000).toFixed(0) + 'k';
                                    }
                                    return '₱' + value;
                                }
                            }
                        },
                        x: {
                            grid: {
                                display: false
                            },
                            ticks: {
                                color: '#8a6d6d',
                                font: { size: 11, family: "'Poppins', sans-serif" },
                                padding: 5,
                                maxTicksLimit: 8
                            }
                        }
                    }
                }
            });
        }

        document.addEventListener("DOMContentLoaded", initDashboardChart);

        // eto yung sa chart yung nag cocontrol
        document.querySelectorAll('.chart-btn').forEach(btn => {
            btn.addEventListener('click', function () {
                document.querySelectorAll('.chart-btn').forEach(b => b.classList.remove('active'));
                this.classList.add('active');
            });
        });

        if (typeof (Sys) !== 'undefined') {
            var prm = Sys.WebForms.PageRequestManager.getInstance();
            prm.add_endRequest(function () {
                initDashboardChart();
            });
        }
    </script>
</asp:Content>