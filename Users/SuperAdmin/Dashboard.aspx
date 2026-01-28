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
            gap: 20px; 
            align-items: center; 
        }

        .filter-dropdown {
            padding: 14px 20px;
            border-radius: 16px;
            border: 2px solid #e2d1d1;
            background: white;
            color: #555;
            outline: none;
            font-size: 15px;
            font-weight: 500;
            min-width: 150px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .filter-dropdown:focus {
            border-color: var(--primary-maroon);
            box-shadow: 0 0 0 3px rgba(107, 13, 30, 0.05);
        }

        .btn-export {
            background: var(--primary-maroon);
            color: white;
            border: none;
            padding: 16px 32px;
            border-radius: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            font-size: 16px;
            box-shadow: 0 4px 12px rgba(107, 13, 30, 0.2);
        }

        .btn-export:hover {
            background: #5a0b19;
            transform: translateY(-2px);
            box-shadow: 0 6px 18px rgba(107, 13, 30, 0.3);
        }

        .stat-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 25px;
            margin-bottom: 35px;
        }

        .stat-card {
            background: white;
            padding: 30px 25px;
            border-radius: var(--radius-2xl);
            box-shadow: var(--card-shadow);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .stat-card:hover { 
            transform: translateY(-8px); 
            box-shadow: 0 15px 40px rgba(107, 13, 30, 0.12);
        }

        .stat-label {
            font-size: 15px;
            font-weight: 500;
            color: var(--muted-text);
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }

        .stat-value { 
            font-size: 40px; 
            font-weight: 700; 
            color: var(--primary-maroon); 
            margin: 10px 0; 
            line-height: 1;
        }
        
        .stat-trend { 
            font-size: 14px; 
            font-weight: 600; 
            margin-top: 12px;
        }
        
        .trend-up { 
            color: var(--success-green); 
        }

        .icon-box {
            width: 50px;
            height: 50px;
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
        }

        .main-grid {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 30px;
        }

        .chart-box, .side-box {
            background: white;
            border-radius: var(--radius-2xl);
            padding: 30px;
            box-shadow: var(--card-shadow);
        }

        .box-title {
            font-size: 20px;
            font-weight: 700;
            margin-bottom: 25px;
            color: var(--primary-maroon);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .meal-item {
            display: flex;
            align-items: center;
            padding: 18px;
            border-radius: 18px;
            background: #fffcf8;
            margin-bottom: 15px;
            border: 2px solid #f3ebe0;
            transition: all 0.3s ease;
        }

        .meal-item:hover {
            background: #fefaf5;
            border-color: #e2d1d1;
            transform: translateX(5px);
        }

        .meal-rank {
            width: 40px;
            height: 40px;
            background: var(--primary-maroon);
            color: white;
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            font-size: 16px;
            margin-right: 20px;
            flex-shrink: 0;
        }

        .meal-info { 
            flex-grow: 1; 
        }
        
        .meal-name { 
            font-weight: 600; 
            font-size: 16px; 
            margin: 0 0 5px 0; 
            color: var(--text-dark); 
        }
        
        .meal-sales { 
            font-size: 14px; 
            color: var(--muted-text); 
            margin: 0; 
        }
        
        .meal-price { 
            font-weight: 700; 
            color: var(--primary-maroon); 
            font-size: 16px;
            margin-left: 15px;
        }

        .badge-stock {
            padding: 10px 18px;
            border-radius: 14px;
            font-size: 12px;
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
            padding: 6px;
            border-radius: 16px;
            gap: 5px;
        }

        .chart-btn {
            padding: 10px 20px;
            border-radius: 14px;
            border: none;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            background: transparent;
            color: var(--muted-text);
            transition: all 0.3s ease;
        }

        .chart-btn.active { 
            background: var(--primary-maroon); 
            color: white; 
            box-shadow: 0 2px 8px rgba(107, 13, 30, 0.2);
        }

        .chart-btn:hover:not(.active) {
            background: rgba(107, 13, 30, 0.05);
        }

        .chart-container {
            position: relative;
            height: 320px;
            width: 100%;
        }

        /* CHUBBY TABLE STYLES */
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

        /* CHUBBY QUICK ACTION BUTTONS */
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
                    <div class="meal-rank" style="background:#e2d1d1;">4</div>
                    <div class="meal-info">
                        <p class="meal-name">Bangsilog</p>
                        <p class="meal-sales">76 orders</p>
                        <span class="badge-stock in-stock">In Stock</span>
                    </div>
                    <div class="meal-price">₱1,140</div>
                </div>
            </div>
        </div>
        
        <div class="main-grid" style="margin-top: 30px;">
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
                                <td style="font-weight:700; color:var(--primary-maroon);">₱350</td>
                                <td><span class="badge-stock in-stock">COMPLETED</span></td>
                                <td style="font-weight:600; color:var(--text-dark);">10:00 AM</td>
                                <td><div class="action-icon"><i class="fas fa-eye"></i></div></td>
                            </tr>
                            <tr>
                                <td class="order-id">#12346</td>
                                <td class="customer-name">George Gonzaga</td>
                                <td>GCash</td>
                                <td>Tofu Sisig x2</td>
                                <td style="font-weight:700; color:var(--primary-maroon);">₱65</td>
                                <td><span class="badge-stock in-stock">COMPLETED</span></td>
                                <td style="font-weight:600; color:var(--text-dark);">10:00 AM</td>
                                <td><div class="action-icon"><i class="fas fa-eye"></i></div></td>
                            </tr>
                            <tr>
                                <td class="order-id">#12347</td>
                                <td class="customer-name">Zea Mae Sulit</td>
                                <td>Paypal</td>
                                <td>Arrozcaldo x1</td>
                                <td style="font-weight:700; color:var(--primary-maroon);">₱50</td>
                                <td><span class="badge-stock in-stock">COMPLETED</span></td>
                                <td style="font-weight:600; color:var(--text-dark);">10:00 AM</td>
                                <td><div class="action-icon"><i class="fas fa-eye"></i></div></td>
                            </tr>
                            <tr>
                                <td class="order-id">#12348</td>
                                <td class="customer-name">Lalaine Reyes</td>
                                <td>Cash On Delivery</td>
                                <td>Goto Special x2</td>
                                <td style="font-weight:700; color:var(--primary-maroon);">₱120</td>
                                <td><span class="badge-stock in-stock">COMPLETED</span></td>
                                <td style="font-weight:600; color:var(--text-dark);">10:00 AM</td>
                                <td><div class="action-icon"><i class="fas fa-eye"></i></div></td>
                            </tr>
                            <tr>
                                <td class="order-id">#12349</td>
                                <td class="customer-name">Bryle Andre Magallano</td>
                                <td>GoTyme</td>
                                <td>Tapsilog x2</td>
                                <td style="font-weight:700; color:var(--primary-maroon);">₱350</td>
                                <td><span class="badge-stock in-stock">COMPLETED</span></td>
                                <td style="font-weight:600; color:var(--text-dark);">10:00 AM</td>
                                <td><div class="action-icon"><i class="fas fa-eye"></i></div></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="side-box">
                <div class="box-title">
                    Stock Alerts <span class="alert-badge">2</span>
                </div>
                
                <div class="meal-item" style="background: #fff4e6; border-color: #fed7aa;">
                    <div class="meal-info">
                        <p class="meal-name">Pork Sisig</p>
                        <p class="meal-sales" style="color: #c2410c; font-weight: 600;">Low stock (3 left)</p>
                    </div>
                </div>

                <div class="meal-item" style="background: #fee2e2; border-color: #fecaca;">
                    <div class="meal-info">
                        <p class="meal-name">Goto Overload</p>
                        <p class="meal-sales" style="color: #b91c1c; font-weight: 600;">Out of stock</p>
                    </div>
                </div>

                <button type="button" class="btn-quick yellow"><i class="fas fa-boxes me-2"></i>Manage Stock</button>

                <div class="box-title" style="margin-top: 25px; padding-top: 25px; border-top: 2px solid #f3ebe0;">Quick Actions</div>
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
                        pointRadius: 6,
                        pointHoverRadius: 8
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: { display: false },
                        tooltip: {
                            backgroundColor: 'rgba(74, 14, 14, 0.9)',
                            titleFont: { size: 14, family: "'Poppins', sans-serif" },
                            bodyFont: { size: 13, family: "'Poppins', sans-serif" },
                            padding: 12,
                            cornerRadius: 10,
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
                                lineWidth: 2
                            },
                            ticks: {
                                color: '#8a6d6d',
                                font: { size: 12, family: "'Poppins', sans-serif" },
                                padding: 10,
                                callback: function (value) { return '₱' + value.toLocaleString(); }
                            }
                        },
                        x: {
                            grid: {
                                display: false
                            },
                            ticks: {
                                color: '#8a6d6d',
                                font: { size: 12, family: "'Poppins', sans-serif" },
                                padding: 10
                            }
                        }
                    }
                }
            });
        }

        document.addEventListener("DOMContentLoaded", initDashboardChart);

        // Handle chart controls
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