<%@ Page Title="Dashboard | TasteNet" Language="C#" MasterPageFile="~/MasterPages/SuperAdmin.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="TasteNet.Users.SuperAdmin.Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <style>
        :root {
            --primary-maroon: #6b0d1e;
            --soft-cream: #fffaf3;
            --text-dark: #4a0e0e;
            --card-shadow: 0 10px 30px rgba(107, 13, 30, 0.05);
        }

        body {
            background-color: var(--soft-cream) !important;
            font-family: 'Poppins', 'Segoe UI', sans-serif;
            color: var(--text-dark);
        }

        .dashboard-wrapper { padding: 20px; }

        /* HEADER SECTION */
        .dashboard-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }

        .welcome h1 { font-size: 28px; font-weight: 700; margin: 0; color: var(--text-dark); }
        .welcome p { color: #8a6d6d; margin: 5px 0 0 0; }

        .header-actions { display: flex; gap: 12px; }

        .filter-dropdown {
            padding: 8px 15px;
            border-radius: 8px;
            border: 1px solid #e2d1d1;
            background: white;
            color: #555;
            outline: none;
        }

        .btn-export {
            background: var(--primary-maroon);
            color: white;
            border: none;
            padding: 8px 20px;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: 0.3s;
        }

        .btn-export:hover {
            background: #4a0914;
            box-shadow: 0 4px 12px rgba(107, 13, 30, 0.2);
        }

        /* STAT CARDS */
        .stat-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: white;
            padding: 25px;
            border-radius: 20px;
            box-shadow: var(--card-shadow);
            transition: transform 0.3s ease;
        }

        .stat-card:hover { transform: translateY(-5px); }

        .stat-label {
            font-size: 13px;
            font-weight: 500;
            color: #8a6d6d;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .stat-value { font-size: 32px; font-weight: 700; color: var(--primary-maroon); margin: 10px 0; }
        .stat-trend { font-size: 12px; font-weight: 600; }
        .trend-up { color: #2d9d78; }

        .icon-box {
            width: 35px;
            height: 35px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 16px;
        }

        /* MAIN GRID */
        .main-grid {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 25px;
        }

        .chart-box, .side-box {
            background: white;
            border-radius: 20px;
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

        /* TOP SELLING LIST */
        .meal-item {
            display: flex;
            align-items: center;
            padding: 12px;
            border-radius: 15px;
            background: #fffcf8;
            margin-bottom: 12px;
            border: 1px solid #f3ebe0;
        }

        .meal-rank {
            width: 30px;
            height: 30px;
            background: var(--primary-maroon);
            color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            font-size: 12px;
            margin-right: 15px;
            flex-shrink: 0;
        }

        .meal-info { flex-grow: 1; }
        .meal-name { font-weight: 600; font-size: 14px; margin: 0; color: var(--text-dark); }
        .meal-sales { font-size: 12px; color: #8a6d6d; margin: 0; }
        .meal-price { font-weight: 700; color: var(--primary-maroon); margin-left: 10px; }

        .badge-stock {
            padding: 3px 8px;
            border-radius: 6px;
            font-size: 10px;
            font-weight: bold;
            text-transform: uppercase;
        }
        .in-stock { background: #e6f4f1; color: #2d9d78; }
        .low-stock { background: #fff4e6; color: #d97706; }

        /* CHART TOGGLES */
        .chart-controls {
            display: flex;
            background: #f3ebe0;
            padding: 4px;
            border-radius: 10px;
        }

        .chart-btn {
            padding: 6px 12px;
            border-radius: 8px;
            border: none;
            font-size: 11px;
            font-weight: 600;
            cursor: pointer;
            background: transparent;
            color: #8a6d6d;
        }

        .chart-btn.active { background: var(--primary-maroon); color: white; }

        /* Chart container to fix resizing/infinite growth issues */
        .chart-container {
            position: relative;
            height: 300px;
            width: 100%;
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
                <button type="button" class="btn-export">Export Report</button>
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
        <div class="main-grid" style="margin-top: 25px;">
            <div class="chart-box">
                <div class="box-title">
                    Recent Orders
                    <a href="#" style="font-size: 12px; color: var(--primary-maroon); text-decoration: none;">View All →</a>
                </div>
                <div style="overflow-x: auto;">
                    <table style="width: 100%; border-collapse: collapse; font-size: 13px;">
                        <thead>
                            <tr style="text-align: left; border-bottom: 2px solid #f3ebe0; color: #8a6d6d;">
                                <th style="padding: 12px 8px;">Order ID</th>
                                <th style="padding: 12px 8px;">Customer</th>
                                <th style="padding: 12px 8px;">Restaurant</th>
                                <th style="padding: 12px 8px;">Amount</th>
                                <th style="padding: 12px 8px;">Status</th>
                                <th style="padding: 12px 8px;">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr style="border-bottom: 1px solid #f3ebe0;">
                                <td style="padding: 12px 8px; font-weight: 600; color: var(--primary-maroon);">#12345</td>
                                <td style="padding: 12px 8px;">Juan dela Cruz</td>
                                <td style="padding: 12px 8px;">Sizzling House</td>
                                <td style="padding: 12px 8px; font-weight: 600;">₱350</td>
                                <td style="padding: 12px 8px;"><span class="badge-stock in-stock">COMPLETED</span></td>
                                <td style="padding: 12px 8px;"><i class="fas fa-eye" style="cursor:pointer; color:#8a6d6d;"></i></td>
                            </tr>
                            <tr style="border-bottom: 1px solid #f3ebe0;">
                                <td style="padding: 12px 8px; font-weight: 600; color: var(--primary-maroon);">#12344</td>
                                <td style="padding: 12px 8px;">Maria Santos</td>
                                <td style="padding: 12px 8px;">Silog Express</td>
                                <td style="padding: 12px 8px; font-weight: 600;">₱280</td>
                                <td style="padding: 12px 8px;"><span class="badge-stock" style="background:#e0f2fe; color:#0369a1;">ACTIVE</span></td>
                                <td style="padding: 12px 8px;"><i class="fas fa-eye" style="cursor:pointer; color:#8a6d6d;"></i></td>
                            </tr>
                            <tr>
                                <td style="padding: 12px 8px; font-weight: 600; color: var(--primary-maroon);">#12340</td>
                                <td style="padding: 12px 8px;">Lisa Manalo</td>
                                <td style="padding: 12px 8px;">Sizzling House</td>
                                <td style="padding: 12px 8px; font-weight: 600;">₱310</td>
                                <td style="padding: 12px 8px;"><span class="badge-stock" style="background:#fee2e2; color:#b91c1c;">CANCELLED</span></td>
                                <td style="padding: 12px 8px;"><i class="fas fa-eye" style="cursor:pointer; color:#8a6d6d;"></i></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="side-box">
                <div class="box-title">
                    Stock Alerts <span style="background: var(--primary-maroon); color: white; border-radius: 50%; padding: 2px 8px; font-size: 10px; margin-left: 5px;">3</span>
                </div>
                
                <div class="meal-item" style="background: #fff4e6; border-color: #fed7aa;">
                    <div class="meal-info">
                        <p class="meal-name">Pork Sisig</p>
                        <p class="meal-sales" style="color: #c2410c;">Low stock (3 left)</p>
                    </div>
                </div>

                <div class="meal-item" style="background: #fee2e2; border-color: #fecaca;">
                    <div class="meal-info">
                        <p class="meal-name">Goto Overload</p>
                        <p class="meal-sales" style="color: #b91c1c;">Out of stock</p>
                    </div>
                </div>

                <button type="button" class="btn-export" style="width: 100%; background: #ffcc00; color: #4a0e0e; margin-bottom: 25px;">Manage Stock</button>

                <div class="box-title" style="margin-top: 20px;">Quick Actions</div>
                <button type="button" class="btn-export" style="width: 100%; margin-bottom: 10px;">Add New Menu Item</button>
                <button type="button" class="btn-export" style="width: 100%; background: white; color: var(--primary-maroon); border: 1px solid var(--primary-maroon); margin-bottom: 10px;">Update Stock Levels</button>
                <button type="button" class="btn-export" style="width: 100%; background: white; color: var(--primary-maroon); border: 1px solid var(--primary-maroon);">View Low Stock Items</button>
            </div>
        </div>
    </div>

    <script>
        var myRevenueChart = null;

        function initDashboardChart() {
            const canvas = document.getElementById('revenueChart');
            if (!canvas) return;

            const ctx = canvas.getContext('2d');

            // Prevent infinite loop/flicker by destroying old instance
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
                        pointRadius: 4,
                        pointHoverRadius: 6
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: { legend: { display: false } },
                    scales: {
                        y: {
                            beginAtZero: true,
                            grid: { color: '#f3ebe0', drawBorder: false },
                            ticks: {
                                color: '#8a6d6d',
                                font: { size: 11 },
                                callback: function (value) { return '₱' + value.toLocaleString(); }
                            }
                        },
                        x: {
                            grid: { display: false },
                            ticks: { color: '#8a6d6d', font: { size: 11 } }
                        }
                    }
                }
            });
        }

        // Initial Load
        document.addEventListener("DOMContentLoaded", initDashboardChart);

        // Fix for ASP.NET UpdatePanels (Partial Postbacks)
        if (typeof (Sys) !== 'undefined') {
            var prm = Sys.WebForms.PageRequestManager.getInstance();
            prm.add_endRequest(function () {
                initDashboardChart();
            });
        }
    </script>
</asp:Content>