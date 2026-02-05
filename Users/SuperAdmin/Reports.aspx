<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/SuperAdmin.Master" AutoEventWireup="true" CodeBehind="Reports.aspx.cs" Inherits="TasteNet.Users.SuperAdmin.Reports" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <style>
        :root {
            --primary-maroon: #6b0d1e;
            --primary-maroon-dark: #5a0b19;
            --soft-cream: #fffaf3;
            --text-dark: #4a0e0e;
            --muted-text: #8a6d6d;
            --success-green: #2d9d78;
            --success-green-light: #e6f4f1;
            --warning-orange: #d97706;
            --warning-orange-light: #fff3e6;
            --accent-yellow: #ffcc00;
            --accent-yellow-dark: #e6b800;
            --accent-yellow-light: #fff9e6;
            --accent-pink: #f9ecee;
            --accent-blue: #eff6ff;
            --accent-blue-dark: #3b82f6;
            --danger-red: #b91c1c;
            --border-light: #e2d1d1;
            --border-hover: #d4b8b8;
            --bg-hover: #fefaf5;
            --bg-light: #f3ebe0;
            --bg-lighter: #f9f4ee;
            
            --card-shadow: 0 10px 30px rgba(107, 13, 30, 0.05);
            --card-shadow-hover: 0 15px 40px rgba(107, 13, 30, 0.12);
            --button-shadow: 0 4px 12px rgba(107, 13, 30, 0.2);
            --button-shadow-hover: 0 6px 18px rgba(107, 13, 30, 0.3);
            
            --radius-sm: 8px;
            --radius-md: 10px;
            --radius-lg: 12px;
            --radius-xl: 16px;
            --radius-2xl: 20px;
            --radius-3xl: 30px;
            
            --transition-fast: 0.2s ease;
            --transition-base: 0.3s ease;
            --transition-slow: 0.4s ease;
        }

        body {
            background-color: var(--soft-cream) !important;
            font-family: 'Poppins', sans-serif !important;
            color: var(--text-dark);
        }

        .reports-container {
            padding: 25px 35px;
            max-width: 1600px;
            margin: 0 auto;
        }

        .reports-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 35px;
            flex-wrap: wrap;
            gap: 15px;
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

        .kpi-row {
            display: grid;
            grid-template-columns: repeat(5, 1fr);
            gap: 20px;
            margin-bottom: 40px;
        }

        @media (max-width: 1400px) {
            .kpi-row {
                grid-template-columns: repeat(3, 1fr);
            }
        }

        @media (max-width: 768px) {
            .kpi-row {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 576px) {
            .kpi-row {
                grid-template-columns: 1fr;
            }
        }

        .stats-grid {
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
            height: 125px;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 30px rgba(107, 13, 30, 0.12);
        }

        .stat-card__header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 10px;
        }

        .stat-card__label {
            font-size: 12px;
            font-weight: 500;
            color: var(--muted-text);
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .stat-card__icon {
            width: 45px;
            height: 45px;
            border-radius: var(--radius-lg);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 18px;
            flex-shrink: 0;
            transition: all var(--transition-base);
            transform-origin: center;
            color: white;
        }

        .stat-card:hover .stat-card__icon {
            transform: scale(1.1) rotate(5deg);
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.2);
        }

        .stat-card__icon--orders { background: var(--accent-yellow); }
        .stat-card__icon--revenue { background: var(--primary-maroon); }
        .stat-card__icon--average { background: var(--success-green); }
        .stat-card__icon--customers { background: var(--accent-blue-dark); }
        .stat-card__icon--retention { background: #e67e22; }

        .stat-card__value {
            font-size: 34px;
            font-weight: 800;
            color: var(--text-dark);
            margin: 10px 0;
            line-height: 1;
            position: relative;
            z-index: 2;
            transition: all var(--transition-fast);
        }

        .stat-card:hover .stat-card__value {
            color: var(--primary-maroon);
        }

        .stat-card__trend {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 15px;
            position: relative;
            z-index: 2;
        }

        .trend-badge {
            font-size: 13px;
            font-weight: 700;
            padding: 5px 12px;
            border-radius: var(--radius-sm);
            display: inline-flex;
            align-items: center;
            gap: 5px;
            transition: all var(--transition-fast);
        }

        .trend-badge--positive {
            background: var(--success-green-light);
            color: #800000;
        }

        .trend-badge--positive i {
            font-size: 12px;
        }

        .trend-text {
            font-size: 12px;
            color: var(--muted-text);
            font-weight: 500;
        }

        .header-actions {
            display: flex;
            align-items: center;
            gap: 20px;
            flex-wrap: nowrap;
        }

        .simple-date-filter {
            display: flex;
            align-items: center;
            gap: 10px;
            background: white;
            padding: 8px 16px;
            border-radius: var(--radius-md);
            border: 1px solid var(--border-light);
            box-shadow: 0 2px 6px rgba(107, 13, 30, 0.05);
            transition: all var(--transition-base);
        }

        .simple-date-filter:hover {
            border-color: var(--primary-maroon);
            box-shadow: 0 4px 12px rgba(107, 13, 30, 0.1);
        }

        .simple-date-filter i {
            color: var(--muted-text);
            font-size: 16px;
        }

        .simple-date-filter select {
            border: none;
            background: transparent;
            font-family: 'Poppins', sans-serif;
            font-size: 14px;
            font-weight: 500;
            color: var(--text-dark);
            outline: none;
            cursor: pointer;
            min-width: 120px;
            appearance: none;
            padding: 2px 5px;
        }

        .btn {
            padding: 8px 16px;
border-radius: var(--radius-md);
font-weight: 600;
font-size: 13px;
cursor: pointer;
transition: all var(--transition-base);
display: inline-flex;
align-items: center;
justify-content: center;
gap: 6px;
border: 2px solid transparent;
font-family: 'Poppins', sans-serif;
text-decoration: none;
white-space: nowrap;
min-height: 36px;
line-height: 1.2;
position: relative;
overflow: hidden;
z-index: 1;
        }

        .btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(
                90deg,
                transparent,
                rgba(255, 255, 255, 0.2),
                transparent
            );
            transition: left 0.7s;
            z-index: -1;
        }

        .btn:hover::before {
            left: 100%;
        }

        .btn--primary {
            background: var(--primary-maroon);
            color: white;
            box-shadow: var(--button-shadow);
        }

        .btn--primary:hover {
            background: var(--primary-maroon-dark);
            transform: translateY(-2px);
            box-shadow: var(--button-shadow-hover);
        }
        
        .status-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 12px;
            padding: 14px 16px;
            border-radius: var(--radius-md);
            background: var(--bg-lighter);
            transition: all var(--transition-base);
            border: 2px solid transparent;
            gap: 20px;
        }

        .status-item i {
            margin-right: 12px;
            font-size: 14px;
            flex-shrink: 0;
        }

        .status-item span {
            display: flex;
            align-items: center;
            flex-grow: 1;
            gap: 8px;
            color: var(--text-dark);
            font-weight: 600;
        }

        .status-item b {
            color: #800000 !important;
            font-weight: 700;
            font-size: 16px;
            flex-shrink: 0;
        }

        .res-info b {
            color: var(--text-dark) !important;
            font-size: 16px;
            font-weight: 700;
            margin-bottom: 5px;
            display: block;
        }

        .res-info {
            display: flex;
            flex-direction: column;
            width: 100%;
        }

        .res-bar-container {
            width: 100%;
            height: 8px;
            background-color: var(--bg-light);
            border-radius: 4px;
            margin-top: 5px;
            overflow: hidden;
        }

        .res-bar-fill {
            height: 100%;
            background: linear-gradient(90deg, var(--primary-maroon), #8a1f35);
            border-radius: 4px;
            transition: width 0.5s ease;
        }

        .res-value {
            color: var(--primary-maroon) !important;
            font-weight: 800 !important;
            font-size: 16px !important;
            flex-shrink: 0;
            min-width: 70px;
            text-align: right;
        }

        .restaurant-item {
            display: flex;
            align-items: center;
            margin-bottom: 16px;
            gap: 15px;
            padding: 16px;
            border-radius: var(--radius-md);
            transition: all var(--transition-base);
            border: 2px solid transparent;
            background: var(--bg-lighter);
        }

        .restaurant-item:hover {
            background: var(--bg-hover);
            transform: translateX(5px);
            border-color: var(--primary-maroon);
        }

        .restaurant-item:hover .res-info b {
            color: var(--primary-maroon) !important;
        }

        .restaurant-item:hover .res-value {
            color: var(--primary-maroon-dark) !important;
            transform: scale(1.05);
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
            transition: transform var(--transition-base);
        }

        .restaurant-item:hover .rank-circle {
            transform: scale(1.1) rotate(5deg);
            box-shadow: 0 6px 12px rgba(107, 13, 30, 0.3);
        }

        .table-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            width: 100%;
        }

        .table-title {
            color: var(--text-dark);
            font-weight: 700;
            font-size: 18px;
            margin: 0;
            flex-grow: 1;
        }

        .table-header-actions {
            flex-shrink: 0;
            margin-left: 20px;
        }

        .view-all-link {
            color: var(--primary-maroon);
            text-decoration: none;
            font-weight: 700;
            font-size: 14px;
            padding: 10px 20px;
            border-radius: var(--radius-md);
            background: var(--bg-lighter);
            transition: all var(--transition-base);
            display: inline-flex;
            align-items: center;
            gap: 8px;
            border: 2px solid transparent;
            white-space: nowrap;
        }

        .view-all-link:hover {
            background: var(--primary-maroon);
            color: white;
            transform: translateY(-2px);
            border-color: var(--primary-maroon);
            box-shadow: 0 4px 12px rgba(107, 13, 30, 0.2);
        }

        .dashboard-grid {
            display: grid;
            grid-template-columns: 1.8fr 1fr;
            gap: 30px;
            margin-bottom: 30px;
        }

        @media (max-width: 1200px) {
            .dashboard-grid {
                grid-template-columns: 1fr;
            }
        }

        .chart-box {
            background: white;
            border-radius: var(--radius-xl);
            padding: 25px;
            box-shadow: var(--card-shadow);
            transition: all var(--transition-base);
            border: 2px solid transparent;
        }

        .chart-box:hover {
            transform: translateY(-5px);
            box-shadow: var(--card-shadow-hover);
        }

        .chart-title {
            color: var(--text-dark);
            font-weight: 700;
            font-size: 18px;
            margin-bottom: 20px;
            display: block;
        }

        .menu-table-box {
            background: white;
            border-radius: var(--radius-xl);
            padding: 25px;
            box-shadow: var(--card-shadow);
            margin-top: 20px;
            transition: all var(--transition-base);
            border: 2px solid transparent;
        }

        .menu-table-box:hover {
            transform: translateY(-5px);
            box-shadow: var(--card-shadow-hover);
        }

        .menu-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 0;
        }

        .menu-table th {
            color: var(--muted-text);
            font-size: 13px;
            text-align: left;
            padding: 16px 15px;
            border-bottom: 2px solid var(--bg-light);
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.3px;
        }

        .menu-table td {
            padding: 20px 15px;
            border-bottom: 1px solid var(--bg-lighter);
            color: var(--text-dark);
            font-size: 14px;
            transition: all var(--transition-fast);
        }

        .menu-table tbody tr {
            transition: all var(--transition-base);
        }

        .menu-table tbody tr:hover {
            background: var(--bg-hover);
        }

        .menu-table tbody tr:hover td {
            transform: scale(1.005);
            border-color: transparent;
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
            transition: transform var(--transition-base);
        }

        .menu-table tbody tr:hover .rank-badge {
            transform: scale(1.1) rotate(10deg);
        }

        .cat-badge {
            background: var(--accent-yellow-light);
            color: #D48C70;
            padding: 6px 12px;
            border-radius: var(--radius-sm);
            font-size: 12px;
            font-weight: 700;
            display: inline-block;
            transition: all var(--transition-fast);
        }

        .menu-table tbody tr:hover .cat-badge {
            background: var(--accent-yellow);
            color: var(--text-dark);
            transform: translateY(-2px);
        }

        .status-item:hover {
            transform: translateX(5px);
            background: var(--bg-hover);
        }

        .btn-group {
            display: flex;
            gap: 10px;
        }

        .btn-chart {
            padding: 10px 24px;
            border-radius: var(--radius-md);
            font-weight: 600;
            font-size: 14px;
            cursor: pointer;
            transition: all var(--transition-base);
            border: 2px solid;
        }

        .btn-chart-active {
            background: var(--primary-maroon);
            color: white;
            border-color: var(--primary-maroon);
        }

        .btn-chart-inactive {
            background: white;
            color: var(--text-dark);
            border-color: var(--border-light);
        }

        .btn-chart-inactive:hover {
            background: var(--soft-cream);
            color: var(--primary-maroon);
            border-color: var(--primary-maroon);
            transform: translateY(-2px);
        }

        .notification {
            position: fixed;
            top: 20px;
            right: 20px;
            padding: 16px 24px;
            border-radius: var(--radius-md);
            color: white;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 12px;
            z-index: 10000;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            animation: slideInRight 0.3s ease;
        }

        .notification-success {
            background: var(--success-green);
        }

        .notification-error {
            background: var(--danger-red);
        }

        .notification-warning {
            background: var(--warning-orange);
        }

        @keyframes slideInRight {
            from {
                transform: translateX(100%);
                opacity: 0;
            }
            to {
                transform: translateX(0);
                opacity: 1;
            }
        }

        @keyframes slideOutRight {
            from {
                transform: translateX(0);
                opacity: 1;
            }
            to {
                transform: translateX(100%);
                opacity: 0;
            }
        }

        @keyframes gentlePulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.02); }
        }

        .stat-card__value {
            animation: gentlePulse 3s infinite;
        }

        @media (max-width: 992px) {
            .reports-header {
                flex-direction: column;
                align-items: stretch;
                gap: 20px;
            }
            
            .header-actions {
                width: 100%;
                justify-content: space-between;
            }
        }

        @media (max-width: 768px) {
            .reports-container {
                padding: 15px;
            }
            
            .stat-card {
                padding: 20px;
            }
            
            .stat-card__value {
                font-size: 28px;
            }
            
            .btn {
                padding: 10px 20px;
                font-size: 14px;
            }
            
            .chart-box {
                padding: 20px;
            }
            
            .header-actions {
                flex-direction: column;
                gap: 15px;
                align-items: stretch;
            }
            
            .simple-date-filter {
                width: 100%;
                justify-content: space-between;
                height: 25px;
            }
            
            .btn--primary {
                width: 100%;
                justify-content: center;
            }

            .restaurant-item {
                padding: 12px;
                gap: 10px;
            }
            
            .res-info b {
                font-size: 14px;
            }
            
            .res-value {
                font-size: 14px !important;
                min-width: 60px;
            }
            
            .rank-circle {
                width: 30px;
                height: 30px;
                font-size: 12px;
            }

            .table-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }
            
            .table-header-actions {
                margin-left: 0;
                width: 100%;
            }
            
            .view-all-link {
                width: 100%;
                justify-content: center;
            }
        }

        @media (max-width: 576px) {
            .header-info h2 {
                font-size: 24px;
            }
            
            .header-info p {
                font-size: 14px;
            }
            
            .stat-card__value {
                font-size: 24px;
            }
            
            .menu-table th,
            .menu-table td {
                padding: 12px 8px;
                font-size: 12px;
            }
            
            .simple-date-filter {
                flex-direction: column;
                align-items: flex-start;
                gap: 8px;
            }
            
            .simple-date-filter select {
                width: 100%;
            }

            .status-item {
                gap: 10px;
                padding: 12px 14px;
            }
            
            .status-item b {
                font-size: 14px;
            }

            .restaurant-item {
                flex-direction: column;
                align-items: flex-start;
                gap: 8px;
            }
            
            .restaurant-item .rank-circle {
                align-self: flex-start;
            }
            
            .res-value {
                align-self: flex-end;
                margin-top: 8px;
            }
        }
    </style>

    <div class="reports-container">
        <div class="reports-header">
            <div class="header-info">
                <h2>Analytics & Reports</h2>
                <p>Comprehensive insights into your platform's performance</p>
            </div>
            
            <div class="header-actions">
                <div class="simple-date-filter">
                    <i class="far fa-calendar-alt"></i>
                    <asp:DropDownList ID="ddlDateRange" runat="server">
                        <asp:ListItem Text="Last 7 days" Value="7" Selected="True" />
                        <asp:ListItem Text="Last 30 days" Value="30" />
                        <asp:ListItem Text="Last 90 days" Value="90" />
                        <asp:ListItem Text="This Year" Value="365" />
                    </asp:DropDownList>
                </div>
                <button type="button" class="btn btn--primary" id="exportBtn">
                    <i class="fas fa-download"></i>Export All Reports
                </button>
            </div>
        </div>

        <div class="kpi-row">
            <div class="stat-card" data-type="orders">
                <div class="stat-card__header">
                    <span class="stat-card__label">Total Orders</span>
                    <div class="stat-card__icon stat-card__icon--orders">
                        <i class="fas fa-shopping-bag"></i>
                    </div>
                </div>
                <div class="stat-card__value" id="totalOrders">1,245</div>
                <div class="stat-card__trend">
                    <span class="trend-badge trend-badge--positive">
                        <i class="fas fa-arrow-up"></i> +18%
                    </span>
                    <span class="trend-text">vs last month</span>
                </div>
            </div>
            
            <div class="stat-card" data-type="revenue">
                <div class="stat-card__header">
                    <span class="stat-card__label">Total Revenue</span>
                    <div class="stat-card__icon stat-card__icon--revenue">
                        <i class="fas fa-peso-sign"></i>
                    </div>
                </div>
                <div class="stat-card__value" id="totalRevenue">₱542K</div>
                <div class="stat-card__trend">
                    <span class="trend-badge trend-badge--positive">
                        <i class="fas fa-arrow-up"></i> +23%
                    </span>
                    <span class="trend-text">vs last month</span>
                </div>
            </div>
            
            <div class="stat-card" data-type="average">
                <div class="stat-card__header">
                    <span class="stat-card__label">Avg Order Value</span>
                    <div class="stat-card__icon stat-card__icon--average">
                        <i class="fas fa-chart-line"></i>
                    </div>
                </div>
                <div class="stat-card__value" id="avgOrderValue">₱435</div>
                <div class="stat-card__trend">
                    <span class="trend-badge trend-badge--positive">
                        <i class="fas fa-arrow-up"></i> +5%
                    </span>
                    <span class="trend-text">vs last month</span>
                </div>
            </div>
            
            <div class="stat-card" data-type="customers">
                <div class="stat-card__header">
                    <span class="stat-card__label">New Customers</span>
                    <div class="stat-card__icon stat-card__icon--customers">
                        <i class="fas fa-users"></i>
                    </div>
                </div>
                <div class="stat-card__value" id="newCustomers">234</div>
                <div class="stat-card__trend">
                    <span class="trend-badge trend-badge--positive">
                        <i class="fas fa-arrow-up"></i> +15%
                    </span>
                    <span class="trend-text">vs last month</span>
                </div>
            </div>
            
            <div class="stat-card" data-type="retention">
                <div class="stat-card__header">
                    <span class="stat-card__label">Retention Rate</span>
                    <div class="stat-card__icon stat-card__icon--retention">
                        <i class="fas fa-sync"></i>
                    </div>
                </div>
                <div class="stat-card__value" id="retentionRate">68%</div>
                <div class="stat-card__trend">
                    <span class="trend-badge trend-badge--positive">
                        <i class="fas fa-arrow-up"></i> +3%
                    </span>
                    <span class="trend-text">vs last month</span>
                </div>
            </div>
        </div>

        <div class="dashboard-grid">
            <div class="chart-box">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <span class="chart-title m-0">Revenue & Orders Trend</span>
                    <div class="btn-group">
                        <button class="btn-chart btn-chart-active" onclick="toggleChartType('revenue')">Revenue</button>
                        <button class="btn-chart btn-chart-inactive" onclick="toggleChartType('orders')">Orders</button>
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
                    <span class="trend-badge trend-badge--positive">
                        <i class="fas fa-clock"></i> Peak hours: 12PM-1PM and 7PM-8PM
                    </span>
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
            <div class="table-header">
                <h3 class="table-title">Popular Menu Items - Focus on Sizzling & Silog Meals</h3>
                <div class="table-header-actions">
                    <a href="#" class="view-all-link">
                        View All <i class="fas fa-arrow-right"></i>
                    </a>
                </div>
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
                        <td style="color:#800000; font-weight:700;">456</td>
                        <td style="color:var(--text-dark); font-weight:800;">₱68,400</td>
                    </tr>
                    <tr>
                        <td><div class="rank-badge">2</div></td>
                        <td><b>Tapsilog</b></td>
                        <td><span class="cat-badge">Silog Meals</span></td>
                        <td style="color:#800000; font-weight:700;">423</td>
                        <td style="color:var(--text-dark); font-weight:800;">₱63,450</td>
                    </tr>
                    <tr>
                        <td><div class="rank-badge">3</div></td>
                        <td><b>Longsilog</b></td>
                        <td><span class="cat-badge">Silog Meals</span></td>
                        <td style="color:#800000; font-weight:700;">389</td>
                        <td style="color:var(--text-dark); font-weight:800;">₱58,350</td>
                    </tr>
                    <tr>
                        <td><div class="rank-badge">4</div></td>
                        <td><b>Sizzling Bangus</b></td>
                        <td><span class="cat-badge">Sizzling Plates</span></td>
                        <td style="color:#800000; font-weight:700;">345</td>
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
                    backgroundColor: 'rgba(107, 13, 30, 0.95)',
                    titleFont: {
                        family: 'Poppins',
                        size: 14,
                        weight: '600'
                    },
                    bodyFont: {
                        family: 'Poppins',
                        size: 13,
                        weight: '500'
                    },
                    padding: 12,
                    cornerRadius: 8,
                    titleColor: '#ffffff',
                    bodyColor: '#ffffff',
                    borderColor: 'rgba(255, 255, 255, 0.2)',
                    borderWidth: 1,
                    callbacks: {
                        label: function (context) {
                            if (context.dataset.label) {
                                return `${context.dataset.label}: ₱${context.parsed.y.toLocaleString()}`;
                            }
                            return `₱${context.parsed.y.toLocaleString()}`;
                        }
                    }
                }
            },
            scales: {
                x: {
                    grid: {
                        color: 'rgba(234, 226, 226, 0.3)',
                        drawBorder: false
                    },
                    ticks: {
                        font: {
                            family: 'Poppins',
                            size: 12,
                            weight: '500'
                        },
                        color: '#8a6d6d'
                    }
                },
                y: {
                    grid: {
                        color: 'rgba(234, 226, 226, 0.3)',
                        drawBorder: false
                    },
                    ticks: {
                        font: {
                            family: 'Poppins',
                            size: 12,
                            weight: '500'
                        },
                        color: '#8a6d6d',
                        callback: function (value) {
                            return '₱' + value.toLocaleString();
                        }
                    }
                }
            },
            interaction: {
                intersect: false,
                mode: 'index'
            },
            animations: {
                tension: {
                    duration: 1000,
                    easing: 'linear'
                }
            }
        };

        let revenueChart, statusChart, timeChart;
        let currentChartType = 'revenue';

        function initializeCharts() {
            const revenueCtx = document.getElementById('revenueChart').getContext('2d');
            revenueChart = new Chart(revenueCtx, {
                type: 'line',
                data: {
                    labels: ['Nov 1', 'Nov 5', 'Nov 10', 'Nov 15', 'Nov 20', 'Nov 22'],
                    datasets: [{
                        label: 'Revenue',
                        data: [38000, 42000, 45000, 48000, 52000, 54000],
                        borderColor: '#6b0d1e',
                        backgroundColor: 'rgba(107, 13, 30, 0.05)',
                        fill: true,
                        tension: 0.4,
                        borderWidth: 3,
                        pointBackgroundColor: '#6b0d1e',
                        pointBorderColor: '#ffffff',
                        pointBorderWidth: 2,
                        pointRadius: 6,
                        pointHoverRadius: 8,
                        pointHoverBackgroundColor: '#5a0b19'
                    }]
                },
                options: commonOptions
            });

            const statusCtx = document.getElementById('statusChart').getContext('2d');
            statusChart = new Chart(statusCtx, {
                type: 'doughnut',
                data: {
                    datasets: [{
                        data: [96, 2, 2],
                        backgroundColor: ['#2d9d78', '#ffcc00', '#B22222'],
                        borderWidth: 0,
                        borderRadius: 8,
                        hoverOffset: 20,
                        hoverBackgroundColor: ['#2d9d78', '#ffcc00', '#B22222'].map(color => color + 'CC')
                    }]
                },
                options: {
                    ...commonOptions,
                    cutout: '65%',
                    plugins: {
                        ...commonOptions.plugins,
                        tooltip: {
                            ...commonOptions.plugins.tooltip,
                            callbacks: {
                                label: function (context) {
                                    const labels = ['Completed', 'Active', 'Cancelled'];
                                    return `${labels[context.dataIndex]}: ${context.raw}%`;
                                }
                            }
                        }
                    }
                }
            });

            const timeCtx = document.getElementById('timeChart').getContext('2d');
            timeChart = new Chart(timeCtx, {
                type: 'bar',
                data: {
                    labels: ['6AM', '7AM', '8AM', '9AM', '10AM', '11AM', '12PM', '1PM', '2PM', '3PM', '4PM', '5PM', '6PM', '7PM', '8PM', '9PM'],
                    datasets: [{
                        label: 'Orders',
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
        }

        function toggleChartType(type) {
            const revenueBtn = document.querySelector('.btn-chart:nth-child(1)');
            const ordersBtn = document.querySelector('.btn-chart:nth-child(2)');

            if (type === 'revenue') {
                revenueBtn.className = 'btn-chart btn-chart-active';
                ordersBtn.className = 'btn-chart btn-chart-inactive';
                currentChartType = 'revenue';
                updateChartData();
            } else {
                revenueBtn.className = 'btn-chart btn-chart-inactive';
                ordersBtn.className = 'btn-chart btn-chart-active';
                currentChartType = 'orders';
                updateChartData();
            }
        }

        function updateChartData() {
            if (currentChartType === 'revenue') {
                revenueChart.data.datasets[0].data = [38000, 42000, 45000, 48000, 52000, 54000];
                revenueChart.data.datasets[0].label = 'Revenue';
            } else {
                revenueChart.data.datasets[0].data = [85, 92, 98, 104, 112, 124];
                revenueChart.data.datasets[0].label = 'Orders';
            }
            revenueChart.update();
        }

        function exportReports() {
            const notification = document.createElement('div');
            notification.className = 'notification notification-success';
            notification.innerHTML = `
                <i class="fas fa-check-circle"></i>
                <span>Reports exported successfully!</span>
            `;

            document.body.appendChild(notification);

            setTimeout(() => {
                notification.style.animation = 'slideOutRight 0.3s ease';
                setTimeout(() => {
                    if (notification.parentNode) {
                        document.body.removeChild(notification);
                    }
                }, 300);
            }, 3000);
        }

        document.addEventListener('DOMContentLoaded', function () {
            console.log('Reports page initialized');

            initializeCharts();

            document.getElementById('exportBtn').addEventListener('click', exportReports);

            const dateRangeSelect = document.getElementById('<%= ddlDateRange.ClientID %>');
            if (dateRangeSelect) {
                dateRangeSelect.addEventListener('change', function () {
                    console.log('Date range changed to:', this.value);
                });
            }
        });
    </script>
</asp:Content>