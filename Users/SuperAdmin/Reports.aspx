<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/SuperAdmin.Master" AutoEventWireup="true" CodeBehind="Reports.aspx.cs" Inherits="TasteNet.Users.SuperAdmin.Reports" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <style>
        :root {
            --primary-maroon: #6b0d1e;
            --soft-cream: #fffaf3;
            --text-dark: #4a0e0e;
            --muted-text: #8a6d6d;
            --accent-yellow: #ffcc00;
            --success-green: #2d9d78;
            --card-shadow: 0 10px 30px rgba(107, 13, 30, 0.05);
            --hover-shadow: 0 15px 40px rgba(107, 13, 30, 0.12);
            --radius-lg: 16px;
            --radius-xl: 20px;
            --radius-2xl: 25px;
            --radius-3xl: 30px;
        }

        body {
            background-color: var(--soft-cream) !important;
            font-family: 'Poppins', sans-serif !important;
        }

        .reports-container {
            padding: 25px 35px;
        }

        .reports-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 35px;
        }

        .header-info h2 {
            color: var(--text-dark);
            font-weight: 700;
            margin: 0;
            font-size: 32px;
            letter-spacing: -0.5px;
        }

        .header-info p {
            color: var(--muted-text);
            margin: 8px 0 0 0;
            font-size: 16px;
        }

        .date-range-container {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-right: 20px;
        }

        .date-range-label {
            color: var(--muted-text);
            font-size: 14px;
            font-weight: 500;
            white-space: nowrap;
        }

        .date-range-select {
            position: relative;
            min-width: 160px;
        }

        .date-range-select i {
            position: absolute;
            left: 18px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--muted-text);
            z-index: 2;
            font-size: 16px;
        }

        .date-dropdown {
            border: 2px solid #e2d1d1 !important;
            border-radius: var(--radius-lg) !important;
            padding: 14px 20px 14px 45px !important;
            background: white !important;
            color: var(--text-dark) !important;
            font-weight: 600 !important;
            font-size: 15px !important;
            transition: all 0.3s ease !important;
            cursor: pointer !important;
            box-shadow: none !important;
            width: 100% !important;
            appearance: none !important;
            -webkit-appearance: none !important;
            -moz-appearance: none !important;
        }

        .date-dropdown:focus {
            border-color: var(--primary-maroon) !important;
            box-shadow: 0 0 0 4px rgba(107, 13, 30, 0.08) !important;
            outline: none !important;
        }

        .date-dropdown:hover {
            transform: translateY(-2px);
            border-color: var(--primary-maroon) !important;
        }

        .header-actions {
            display: flex;
            align-items: center;
            gap: 25px;
        }

        .btn-export {
            background: var(--primary-maroon);
            color: white;
            border: none;
            border-radius: var(--radius-lg);
            padding: 16px 32px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
            font-size: 16px;
            box-shadow: 0 4px 12px rgba(107, 13, 30, 0.2);
            display: flex;
            align-items: center;
            gap: 10px;
            white-space: nowrap;
            min-width: 180px;
            justify-content: center;
        }

        .btn-export:hover {
            background: #5a0b19;
            transform: translateY(-4px) scale(1.02);
            box-shadow: 0 8px 20px rgba(107, 13, 30, 0.3);
            letter-spacing: 0.3px;
        }

        .kpi-row {
            display: flex;
            gap: 25px;
            margin-bottom: 40px;
            flex-wrap: nowrap;
            overflow-x: auto;
            padding-bottom: 10px;
        }

        .kpi-row::-webkit-scrollbar {
            height: 6px;
        }

        .kpi-row::-webkit-scrollbar-track {
            background: #f1e9e9;
            border-radius: 10px;
        }

        .kpi-row::-webkit-scrollbar-thumb {
            background: var(--primary-maroon);
            border-radius: 10px;
        }

        .kpi-card {
            background: white;
            border-radius: var(--radius-2xl);
            padding: 30px 25px;
            flex: 1;
            min-width: 180px;
            box-shadow: var(--card-shadow);
            border: none;
            transition: all 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
            cursor: pointer;
        }

        .kpi-card:hover {
            transform: translateY(-8px) scale(1.02);
            box-shadow: var(--hover-shadow);
        }

        .kpi-icon {
            width: 45px;
            height: 45px;
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            margin-bottom: 15px;
            font-size: 18px;
            transition: transform 0.3s ease;
        }

        .kpi-card:hover .kpi-icon {
            transform: scale(1.1) rotate(5deg);
        }

        .kpi-value {
            font-size: 32px;
            font-weight: 800;
            color: var(--text-dark);
            margin-bottom: 8px;
            letter-spacing: -0.5px;
        }

        .kpi-label {
            font-size: 14px;
            color: var(--muted-text);
            font-weight: 600;
            float: right;
            background: #f9f4ee;
            padding: 6px 12px;
            border-radius: 12px;
        }

        .trend-text {
            font-size: 14px;
            font-weight: 700;
            color: var(--success-green);
            background: #edf7f4;
            padding: 4px 10px;
            border-radius: 10px;
            display: inline-block;
        }

        .vs-text {
            font-size: 12px;
            color: var(--muted-text);
            float: right;
            margin-top: 5px;
        }

        .dashboard-grid {
            display: grid;
            grid-template-columns: 1.8fr 1fr;
            gap: 30px;
            margin-bottom: 30px;
        }

        .chart-box {
            background: white;
            border-radius: var(--radius-2xl);
            padding: 30px;
            box-shadow: var(--card-shadow);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .chart-box:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(107, 13, 30, 0.1);
        }

        .chart-title {
            color: var(--text-dark);
            font-weight: 700;
            font-size: 20px;
            margin-bottom: 25px;
            display: block;
            letter-spacing: -0.3px;
        }

        .btn-chart-active {
            background: var(--primary-maroon) !important;
            color: white !important;
            border: none !important;
            border-radius: var(--radius-lg) !important;
            padding: 10px 24px !important;
            font-weight: 600 !important;
            transition: all 0.3s ease !important;
        }

        .btn-chart-inactive {
            background: #f9f4ee !important;
            color: var(--text-dark) !important;
            border: 2px solid #e2d1d1 !important;
            border-radius: var(--radius-lg) !important;
            padding: 10px 24px !important;
            font-weight: 600 !important;
            transition: all 0.3s ease !important;
        }

        .btn-chart-inactive:hover {
            background: var(--soft-cream) !important;
            color: var(--primary-maroon) !important;
            border-color: var(--primary-maroon) !important;
            transform: translateY(-2px) !important;
        }

        .status-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
            padding: 12px 15px;
            border-radius: var(--radius-lg);
            background: #fefaf5;
            transition: all 0.3s ease;
        }

        .status-item:hover {
            transform: translateX(5px);
            background: #f9f4ee;
        }

        .status-item span {
            color: var(--text-dark) !important;
            font-weight: 500 !important;
            font-size: 15px !important;
        }

        .status-item b {
            color: var(--text-dark) !important;
            font-weight: 700 !important;
            font-size: 15px !important;
        }

        .status-item i {
            font-size: 10px !important;
            margin-right: 10px !important;
        }

        .restaurant-item {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
            gap: 15px;
            padding: 15px;
            border-radius: var(--radius-lg);
            transition: all 0.3s ease;
        }

        .restaurant-item:hover {
            background: #fefaf5;
            transform: translateX(5px);
        }

        .rank-circle {
            width: 35px;
            height: 35px;
            background: linear-gradient(135deg, var(--primary-maroon), #8a1f35);
            color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            font-size: 14px;
            flex-shrink: 0;
            box-shadow: 0 4px 8px rgba(107, 13, 30, 0.2);
        }

        .res-bar-container {
            height: 8px;
            background: #FFF5E6;
            border-radius: 4px;
            overflow: hidden;
            width: 100%;
            margin-top: 8px;
        }

        .res-bar-fill {
            height: 100%;
            background: linear-gradient(90deg, var(--primary-maroon), #d97706);
            border-radius: 4px;
            transition: width 0.5s ease;
        }

        .res-info b {
            color: var(--text-dark);
            font-weight: 600;
            font-size: 16px;
        }

        .res-value {
            color: var(--primary-maroon);
            font-weight: 700;
            font-size: 18px;
            margin-left: auto;
        }

        .menu-table-box {
            background: white;
            border-radius: var(--radius-2xl);
            padding: 30px;
            box-shadow: var(--card-shadow);
            margin-top: 20px;
            transition: transform 0.3s ease;
        }

        .menu-table-box:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(107, 13, 30, 0.1);
        }

        .menu-table-box .d-flex {
            display: flex;
            align-items: flex-start !important;
            margin-bottom: 25px;
            min-height: 45px;
        }

        .menu-table-box .chart-title {
            flex: 1;
            margin-bottom: 0 !important;
            line-height: 1.4;
            padding-top: 8px;
        }

        .view-all {
            color: var(--primary-maroon);
            text-decoration: none;
            font-weight: 700;
            font-size: 15px;
            padding: 12px 24px;
            border-radius: var(--radius-lg);
            background: #f9f4ee;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            height: fit-content;
            white-space: nowrap;
            margin-left: 20px;
            flex-shrink: 0;
            margin-top: 0;
        }

        .view-all:hover {
            background: var(--primary-maroon);
            color: white;
            transform: translateY(-2px) scale(1.05);
            box-shadow: 0 4px 12px rgba(107, 13, 30, 0.2);
        }

        .menu-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 0;
        }

        .menu-table th {
            color: var(--muted-text);
            font-size: 15px;
            text-align: left;
            padding: 20px 15px;
            border-bottom: 2px solid #f3ebe0;
            font-weight: 600;
            letter-spacing: 0.3px;
        }

        .menu-table td {
            padding: 24px 15px;
            border-bottom: 1px solid #f9f4ee;
            color: var(--text-dark);
            font-size: 16px;
            transition: background 0.3s ease;
        }

        .menu-table tbody tr:hover {
            background: #fefaf5;
        }

        .menu-table tbody tr:hover td {
            transform: scale(1.005);
        }

        .rank-badge {
            width: 32px;
            height: 32px;
            background: var(--accent-yellow);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 800;
            font-size: 14px;
            color: var(--text-dark);
            box-shadow: 0 4px 8px rgba(255, 204, 0, 0.2);
            transition: transform 0.3s ease;
        }

        .menu-table tbody tr:hover .rank-badge {
            transform: scale(1.1) rotate(10deg);
        }

        .cat-badge {
            background: #FFF5E6;
            color: #D48C70;
            padding: 8px 16px;
            border-radius: 12px;
            font-size: 13px;
            font-weight: 700;
            display: inline-block;
            transition: all 0.3s ease;
        }

        .menu-table tbody tr:hover .cat-badge {
            background: #ffedd5;
            transform: translateY(-2px);
        }

        canvas {
            border-radius: var(--radius-lg);
        }

        @media (max-width: 1200px) {
            .dashboard-grid {
                grid-template-columns: 1fr;
            }
            
            .kpi-row {
                grid-template-columns: repeat(3, 1fr);
            }
        }

        @media (max-width: 992px) {
            .reports-header {
                flex-direction: column;
                gap: 20px;
                align-items: flex-start;
            }
            
            .header-actions {
                width: 100%;
                justify-content: space-between;
            }
            
            .menu-table-box .d-flex {
                flex-direction: column;
                align-items: flex-start !important;
            }
            
            .view-all {
                margin-left: 0;
                margin-top: 15px;
            }
        }

        @media (max-width: 768px) {
            .reports-container {
                padding: 15px;
            }
            
            .header-actions {
                flex-direction: column;
                gap: 15px;
                width: 100%;
            }
            
            .date-range-container {
                width: 100%;
                justify-content: space-between;
                margin-right: 0;
            }
            
            .kpi-row {
                grid-template-columns: repeat(2, 1fr);
            }
            
            .btn-export {
                width: 100%;
            }
            
            .menu-table-box {
                padding: 20px;
            }
        }

        @media (max-width: 576px) {
            .kpi-row {
                grid-template-columns: 1fr;
            }
            
            .chart-box {
                padding: 20px;
            }
            
            .date-range-container {
                flex-direction: column;
                align-items: flex-start;
                gap: 10px;
            }
            
            .date-range-select {
                width: 100%;
            }
            
            .menu-table th,
            .menu-table td {
                padding: 15px 10px;
                font-size: 14px;
            }
            
            .view-all {
                padding: 10px 16px;
                font-size: 14px;
            }
        }

        @keyframes gentlePulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
        }

        .kpi-value {
            animation: gentlePulse 3s infinite;
        }

        .chart-box:has(#statusChart) .status-item span,
        .chart-box:has(#statusChart) .status-item b {
            color: #4a0e0e !important;
            font-weight: 600 !important;
            font-size: 15px !important;
        }

        .chart-box:has(#statusChart) .status-item i.fa-circle {
            color: inherit !important;
            font-size: 10px !important;
            margin-right: 10px !important;
            vertical-align: middle !important;
        }

        .chart-box:has(#statusChart) .status-item:first-child i.fa-circle {
            color: #2d9d78 !important;
        }

        .chart-box:has(#statusChart) .status-item:nth-child(2) i.fa-circle {
            color: #ffcc00 !important;
        }

        .chart-box:has(#statusChart) .status-item:nth-child(3) i.fa-circle {
            color: #B22222 !important;
        }

        .chart-box:has(#statusChart) {
            color: #4a0e0e !important;
        }

        .chart-box:has(#statusChart) *:not(i.fa-circle) {
            color: #4a0e0e !important;
        }
    </style>

    <div class="reports-container">
        <div class="reports-header">
            <div class="header-info">
                <h2>Analytics & Reports</h2>
                <p>Comprehensive insights into your platform's performance</p>
            </div>
            
            <div class="header-actions">
                <div class="date-range-container">
                    <span class="date-range-label">Date Range:</span>
                    <div class="date-range-select">
                        <i class="far fa-calendar-alt"></i>
                        <asp:DropDownList ID="ddlDateRange" runat="server" CssClass="date-dropdown">
                            <asp:ListItem Text="Last 7 days" Value="7" Selected="True" />
                            <asp:ListItem Text="Last 30 days" Value="30" />
                            <asp:ListItem Text="Last 90 days" Value="90" />
                            <asp:ListItem Text="This Year" Value="365" />
                            <asp:ListItem Text="Custom Range" Value="custom" />
                        </asp:DropDownList>
                    </div>
                </div>
                <button type="button" class="btn-export">
                    <i class="fas fa-download me-2"></i>Export All Reports
                </button>
            </div>
        </div>

        <div class="kpi-row">
            <div class="kpi-card">
                <div class="d-flex justify-content-between">
                    <div class="kpi-icon" style="background:var(--accent-yellow);">
                        <i class="fas fa-shopping-bag"></i>
                    </div>
                    <span class="kpi-label">Total Orders</span>
                </div>
                <div class="kpi-value">1,245</div>
                <div class="d-flex justify-content-between align-items-center mt-3">
                    <span class="trend-text">↑ +18%</span>
                    <span class="vs-text">vs last month</span>
                </div>
            </div>
            <div class="kpi-card">
                <div class="d-flex justify-content-between">
                    <div class="kpi-icon" style="background:var(--primary-maroon);">
                        <i class="fas fa-peso-sign"></i>
                    </div>
                    <span class="kpi-label">Total Revenue</span>
                </div>
                <div class="kpi-value">₱542K</div>
                <div class="d-flex justify-content-between align-items-center mt-3">
                    <span class="trend-text">↑ +23%</span>
                    <span class="vs-text">vs last month</span>
                </div>
            </div>
            <div class="kpi-card">
                <div class="d-flex justify-content-between">
                    <div class="kpi-icon" style="background:var(--success-green);">
                        <i class="fas fa-chart-line"></i>
                    </div>
                    <span class="kpi-label">Avg Order Value</span>
                </div>
                <div class="kpi-value">₱435</div>
                <div class="d-flex justify-content-between align-items-center mt-3">
                    <span class="trend-text">↑ +5%</span>
                    <span class="vs-text">vs last month</span>
                </div>
            </div>
            <div class="kpi-card">
                <div class="d-flex justify-content-between">
                    <div class="kpi-icon" style="background:#3498db;">
                        <i class="fas fa-users"></i>
                    </div>
                    <span class="kpi-label">New Customers</span>
                </div>
                <div class="kpi-value">234</div>
                <div class="d-flex justify-content-between align-items-center mt-3">
                    <span class="trend-text">↑ +15%</span>
                    <span class="vs-text">vs last month</span>
                </div>
            </div>
            <div class="kpi-card">
                <div class="d-flex justify-content-between">
                    <div class="kpi-icon" style="background:#e67e22;">
                        <i class="fas fa-sync"></i>
                    </div>
                    <span class="kpi-label">Retention Rate</span>
                </div>
                <div class="kpi-value">68%</div>
                <div class="d-flex justify-content-between align-items-center mt-3">
                    <span class="trend-text">↑ +3%</span>
                    <span class="vs-text">vs last month</span>
                </div>
            </div>
        </div>

        <div class="dashboard-grid">
            <div class="chart-box">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <span class="chart-title m-0">Revenue & Orders Trend</span>
                    <div class="btn-group btn-group-sm rounded shadow-sm">
                        <button class="btn btn-chart-active px-4">Revenue</button>
                        <button class="btn btn-chart-inactive px-4">Orders</button>
                    </div>
                </div>
                <div style="height: 300px;"><canvas id="revenueChart"></canvas></div>
            </div>
            <div class="chart-box">
                <span class="chart-title">Order Status Distribution</span>
                <div style="height: 200px;"><canvas id="statusChart"></canvas></div>
                <div class="mt-4">
                    <div class="status-item">
                        <span><i class="fas fa-circle me-2" style="color:var(--success-green)"></i>Completed</span>
                        <b>1198 (96%)</b>
                    </div>
                    <div class="status-item">
                        <span><i class="fas fa-circle me-2" style="color:var(--accent-yellow)"></i>Active</span>
                        <b>23 (2%)</b>
                    </div>
                    <div class="status-item">
                        <span><i class="fas fa-circle me-2" style="color:#B22222"></i>Cancelled</span>
                        <b>24 (2%)</b>
                    </div>
                </div>
            </div>
        </div>

        <div class="dashboard-grid">
            <div class="chart-box">
                <span class="chart-title">Orders by Time of Day</span>
                <div style="height: 280px;"><canvas id="timeChart"></canvas></div>
                <div class="text-center mt-3">
                    <span class="trend-text">Peak hours: 12PM-1PM and 7PM-8PM</span>
                </div>
            </div>
            <div class="chart-box">
                <span class="chart-title">Top Selling Meals</span>
                <div class="restaurant-item">
                    <div class="rank-circle">1</div>
                    <div class="res-info flex-grow-1">
                        <b>Tapsilog</b>
                        <div class="res-bar-container"><div class="res-bar-fill" style="width: 85%;"></div></div>
                    </div>
                    <div class="res-value">₱45.6K</div>
                </div>
                <div class="restaurant-item">
                    <div class="rank-circle">2</div>
                    <div class="res-info flex-grow-1">
                        <b>Pork Sisig</b>
                        <div class="res-bar-container"><div class="res-bar-fill" style="width: 95%;"></div></div>
                    </div>
                    <div class="res-value">₱52.3K</div>
                </div>
                <div class="restaurant-item">
                    <div class="rank-circle">3</div>
                    <div class="res-info flex-grow-1">
                        <b>Arrozcaldo</b>
                        <div class="res-bar-container"><div class="res-bar-fill" style="width: 70%;"></div></div>
                    </div>
                    <div class="res-value">₱38.4K</div>
                </div>
                <div class="restaurant-item">
                    <div class="rank-circle">4</div>
                    <div class="res-info flex-grow-1">
                        <b>Tofu Sisig</b>
                        <div class="res-bar-container"><div class="res-bar-fill" style="width: 60%;"></div></div>
                    </div>
                    <div class="res-value">₱29.8K</div>
                </div>
            </div>
        </div>

        <div class="menu-table-box">
            <div class="d-flex justify-content-between align-items-center">
                <span class="chart-title m-0">Popular Menu Items - Focus on Sizzling & Silog Meals</span>
                <a href="#" class="view-all">View All →</a>
            </div>
            <table class="menu-table">
                <thead>
                    <tr>
                        <th>Rank</th>
                        <th>Menu Item</th>
                        <th>Category</th>
                        <th>Total Orders</th>
                        <th>Revenue</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><div class="rank-badge">1</div></td>
                        <td><b>Sizzling Sisig</b></td>
                        <td><span class="cat-badge">Sizzling Plates</span></td>
                        <td style="color:var(--primary-maroon); font-weight:700;">456</td>
                        <td style="color:var(--text-dark); font-weight:800;">₱68,400</td>
                    </tr>
                    <tr>
                        <td><div class="rank-badge">2</div></td>
                        <td><b>Tapsilog</b></td>
                        <td><span class="cat-badge">Silog Meals</span></td>
                        <td style="color:var(--primary-maroon); font-weight:700;">423</td>
                        <td style="color:var(--text-dark); font-weight:800;">₱63,450</td>
                    </tr>
                    <tr>
                        <td><div class="rank-badge">3</div></td>
                        <td><b>Longsilog</b></td>
                        <td><span class="cat-badge">Silog Meals</span></td>
                        <td style="color:var(--primary-maroon); font-weight:700;">389</td>
                        <td style="color:var(--text-dark); font-weight:800;">₱58,350</td>
                    </tr>
                    <tr>
                        <td><div class="rank-badge">4</div></td>
                        <td><b>Sizzling Bangus</b></td>
                        <td><span class="cat-badge">Sizzling Plates</span></td>
                        <td style="color:var(--primary-maroon); font-weight:700;">345</td>
                        <td style="color:var(--text-dark); font-weight:800;">₱51,750</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

    <script>
        const commonOptions = {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    display: false
                },
                tooltip: {
                    backgroundColor: 'rgba(107, 13, 30, 0.9)',
                    titleFont: {
                        family: 'Poppins',
                        size: 14,
                        color: '#ffffff'
                    },
                    bodyFont: {
                        family: 'Poppins',
                        size: 13,
                        color: '#ffffff'
                    },
                    padding: 12,
                    cornerRadius: 10,
                    titleColor: '#ffffff',
                    bodyColor: '#ffffff'
                }
            },
            scales: {
                x: {
                    grid: {
                        color: 'rgba(234, 226, 226, 0.5)'
                    },
                    ticks: {
                        font: {
                            family: 'Poppins',
                            size: 12
                        },
                        color: '#4a0e0e'
                    }
                },
                y: {
                    grid: {
                        color: 'rgba(234, 226, 226, 0.5)'
                    },
                    ticks: {
                        font: {
                            family: 'Poppins',
                            size: 12
                        },
                        color: '#4a0e0e'
                    }
                }
            }
        };

        new Chart(document.getElementById('revenueChart'), {
            type: 'line',
            data: {
                labels: ['Nov 1', 'Nov 5', 'Nov 10', 'Nov 15', 'Nov 20', 'Nov 22'],
                datasets: [{
                    data: [38000, 42000, 45000, 48000, 52000, 54000],
                    borderColor: '#6b0d1e',
                    backgroundColor: 'rgba(107, 13, 30, 0.05)',
                    fill: true,
                    tension: 0.3,
                    borderWidth: 3,
                    pointBackgroundColor: '#6b0d1e',
                    pointBorderColor: '#fff',
                    pointBorderWidth: 2,
                    pointRadius: 6,
                    pointHoverRadius: 8
                }]
            },
            options: commonOptions
        });

        new Chart(document.getElementById('statusChart'), {
            type: 'doughnut',
            data: {
                datasets: [{
                    data: [96, 2, 2],
                    backgroundColor: ['#2d9d78', '#ffcc00', '#B22222'],
                    borderWidth: 0,
                    borderRadius: 8,
                    hoverOffset: 15
                }]
            },
            options: {
                ...commonOptions,
                cutout: '80%',
                plugins: {
                    ...commonOptions.plugins,
                    tooltip: {
                        ...commonOptions.plugins.tooltip,
                        callbacks: {
                            label: function (context) {
                                return `${context.label}: ${context.raw}%`;
                            }
                        }
                    }
                }
            }
        });

        new Chart(document.getElementById('timeChart'), {
            type: 'bar',
            data: {
                labels: ['6AM', '7AM', '8AM', '9AM', '10AM', '11AM', '12PM', '1PM', '2PM', '3PM', '4PM', '5PM', '6PM', '7PM', '8PM', '9PM'],
                datasets: [{
                    data: [15, 30, 45, 60, 75, 95, 115, 100, 75, 55, 48, 65, 90, 105, 88, 62],
                    backgroundColor: (ctx) => {
                        return [6, 7, 13, 14].includes(ctx.dataIndex) ?
                            '#ffcc00' :
                            'rgba(107, 13, 30, 0.8)';
                    },
                    borderRadius: 8,
                    borderSkipped: false,
                    hoverBackgroundColor: (ctx) => {
                        return [6, 7, 13, 14].includes(ctx.dataIndex) ?
                            '#e6b800' :
                            '#5a0b19';
                    }
                }]
            },
            options: commonOptions
        });

        document.querySelectorAll('.date-dropdown').forEach(select => {
            const wrapper = select.parentElement;
            const arrow = document.createElement('div');
            arrow.className = 'dropdown-arrow';
            arrow.innerHTML = '<i class="fas fa-chevron-down"></i>';
            arrow.style.position = 'absolute';
            arrow.style.right = '15px';
            arrow.style.top = '50%';
            arrow.style.transform = 'translateY(-50%)';
            arrow.style.color = 'var(--muted-text)';
            arrow.style.pointerEvents = 'none';
            wrapper.style.position = 'relative';
            wrapper.appendChild(arrow);
        });
    </script>
</asp:Content>