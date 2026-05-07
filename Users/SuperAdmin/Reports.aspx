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
         background-color: #fffaf3 !important;
         font-family: 'Poppins', sans-serif !important;
         color: var(--text-dark);
        }

        
        .reports-container { padding: 16px; max-width: 1600px; margin: 0 auto; }
        @media (min-width: 576px)  { .reports-container { padding: 20px; } }
        @media (min-width: 992px)  { .reports-container { padding: 25px 35px; } }

        /* ── Header ─────────────────────────────────────────────────────────── */
        .reports-header { display: flex; flex-direction: column; gap: 14px; margin-bottom: 24px; }
        @media (min-width: 768px)  { .reports-header { flex-direction: row; justify-content: space-between; align-items: center; margin-bottom: 35px; } }
        .header-info h2 { color: var(--text-dark); font-weight: 700; margin: 0; font-size: 22px; letter-spacing: -0.5px; }
        .header-info p  { color: var(--muted-text); margin: 4px 0 0 0; font-size: 13px; }
        @media (min-width: 576px)  { .header-info h2 { font-size: 26px; } .header-info p { font-size: 14px; } }
        @media (min-width: 992px)  { .header-info h2 { font-size: 32px; } .header-info p { font-size: 16px; } }

        /* ── Header actions ─────────────────────────────────────────────────── */
        .header-actions { display: flex; flex-direction: column; gap: 10px; width: 100%; }
        @media (min-width: 576px)  { .header-actions { flex-direction: row; align-items: center; width: auto; gap: 12px; } }
        @media (min-width: 768px)  { .header-actions { flex-wrap: nowrap; gap: 16px; } }
        .simple-date-filter { display: flex; align-items: center; gap: 8px; background: white; padding: 8px 14px; border-radius: var(--radius-md); border: 1px solid var(--border-light); box-shadow: 0 2px 6px rgba(107,13,30,0.05); transition: all var(--transition-base); width: 100%; }
        @media (min-width: 576px)  { .simple-date-filter { width: auto; } }
        .simple-date-filter:hover { border-color: var(--primary-maroon); box-shadow: 0 4px 12px rgba(107,13,30,0.1); }
        .simple-date-filter i  { color: var(--muted-text); font-size: 15px; flex-shrink: 0; }
        .simple-date-filter select { border: none; background: transparent; font-family: 'Poppins', sans-serif; font-size: 13px; font-weight: 500; color: var(--text-dark); outline: none; cursor: pointer; width: 100%; appearance: none; padding: 2px 4px; }
        @media (min-width: 576px)  { .simple-date-filter select { min-width: 120px; width: auto; } }

        /* ── Buttons ────────────────────────────────────────────────────────── */
        .btn { padding: 8px 14px; border-radius: var(--radius-md); font-weight: 600; font-size: 13px; cursor: pointer; transition: all var(--transition-base); display: inline-flex; align-items: center; justify-content: center; gap: 6px; border: 2px solid transparent; font-family: 'Poppins', sans-serif; text-decoration: none; white-space: nowrap; min-height: 36px; line-height: 1.2; position: relative; overflow: hidden; z-index: 1; width: 100%; }
        @media (min-width: 576px)  { .btn { width: auto; padding: 8px 16px; } }
        .btn::before { content: ''; position: absolute; top: 0; left: -100%; width: 100%; height: 100%; background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent); transition: left 0.7s; z-index: -1; }
        .btn:hover::before { left: 100%; }
        .btn--primary { background: var(--primary-maroon); color: white; box-shadow: var(--button-shadow); }
        .btn--primary:hover { background: var(--primary-maroon-dark); transform: translateY(-2px); box-shadow: var(--button-shadow-hover); }
        .btn--danger { background: #1a7a4a; color: white; box-shadow: 0 4px 12px rgba(26,122,74,0.25); }
        .btn--danger:hover { background: #155f39; transform: translateY(-2px); }

        /* ── KPI Cards ──────────────────────────────────────────────────────── */
        .kpi-row { display: grid; grid-template-columns: 1fr 1fr; gap: 12px; margin-bottom: 24px; }
        @media (min-width: 768px)  { .kpi-row { grid-template-columns: repeat(2, 1fr); gap: 16px; margin-bottom: 30px; } }
        @media (min-width: 992px)  { .kpi-row { grid-template-columns: repeat(4, 1fr); gap: 20px; margin-bottom: 40px; } }

        .stat-card { background: white; padding: 14px; border-radius: 14px; box-shadow: var(--card-shadow); transition: transform 0.3s ease, box-shadow 0.3s ease; display: flex; flex-direction: column; justify-content: space-between; gap: 8px; }
        @media (min-width: 576px)  { .stat-card { padding: 16px 18px; } }
        .stat-card:hover { transform: translateY(-4px); box-shadow: 0 12px 30px rgba(107,13,30,0.12); }
        .stat-card__header { display: flex; justify-content: space-between; align-items: center; }
        .stat-card__label { font-size: 10px; font-weight: 600; color: var(--muted-text); text-transform: uppercase; letter-spacing: 0.6px; }
        @media (min-width: 576px)  { .stat-card__label { font-size: 11px; } }
        .stat-card__icon { width: 32px; height: 32px; border-radius: 9px; display: flex; align-items: center; justify-content: center; font-size: 13px; flex-shrink: 0; color: white; transition: all var(--transition-base); }
        @media (min-width: 576px)  { .stat-card__icon { width: 36px; height: 36px; font-size: 14px; border-radius: 10px; } }
        .stat-card:hover .stat-card__icon { transform: scale(1.1) rotate(5deg); box-shadow: 0 6px 15px rgba(0,0,0,0.2); }
        .stat-card__icon--orders   { background: var(--accent-yellow); }
        .stat-card__icon--revenue  { background: var(--primary-maroon); }
        .stat-card__icon--average  { background: var(--success-green); }
        .stat-card__icon--customers{ background: var(--accent-blue-dark); }
        .stat-card__value { font-size: 22px; font-weight: 800; color: var(--text-dark); line-height: 1; transition: all var(--transition-fast); }
        @media (min-width: 576px)  { .stat-card__value { font-size: 26px; } }
        @media (min-width: 992px)  { .stat-card__value { font-size: 28px; } }
        .stat-card:hover .stat-card__value { color: var(--primary-maroon); }
        .stat-card__trend { display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 4px; }
        .trend-badge { font-size: 10px; font-weight: 700; padding: 3px 8px; border-radius: var(--radius-sm); display: inline-flex; align-items: center; gap: 4px; }
        @media (min-width: 576px)  { .trend-badge { font-size: 11px; padding: 4px 10px; } }
        .trend-badge--positive { background: var(--success-green-light); color: #800000; }
        .trend-text { font-size: 10px; color: var(--muted-text); font-weight: 500; }
        @media (min-width: 576px)  { .trend-text { font-size: 11px; } }

        /* ── Dashboard Grid (charts) ─────────────────────────────────────────── */
        .dashboard-grid { display: grid; grid-template-columns: 1fr; gap: 16px; margin-bottom: 16px; }
        @media (min-width: 992px)  { .dashboard-grid { grid-template-columns: 1.8fr 1fr; gap: 24px; margin-bottom: 24px; } }
        @media (min-width: 1200px) { .dashboard-grid { gap: 30px; margin-bottom: 30px; } }

        /* ── Chart boxes ─────────────────────────────────────────────────────── */
        .chart-box { background: white; border-radius: var(--radius-xl); padding: 16px; box-shadow: var(--card-shadow); transition: all var(--transition-base); border: 2px solid transparent; overflow: hidden; }
        @media (min-width: 576px)  { .chart-box { padding: 20px; } }
        @media (min-width: 992px)  { .chart-box { padding: 25px; } }
        .chart-box:hover { transform: translateY(-4px); box-shadow: var(--card-shadow-hover); }
        .chart-title { color: var(--text-dark); font-weight: 700; font-size: 15px; margin-bottom: 16px; display: block; }
        @media (min-width: 576px)  { .chart-title { font-size: 17px; } }
        @media (min-width: 992px)  { .chart-title { font-size: 18px; margin-bottom: 20px; } }

        /* ── Chart toggle buttons ─────────────────────────────────────────────── */
        .btn-group { display: flex; gap: 6px; flex-shrink: 0; }
        .btn-chart { padding: 7px 14px; border-radius: var(--radius-md); font-weight: 600; font-size: 12px; cursor: pointer; transition: all var(--transition-base); border: 2px solid; font-family: 'Poppins', sans-serif; white-space: nowrap; }
        @media (min-width: 576px)  { .btn-chart { padding: 8px 18px; font-size: 13px; } }
        @media (min-width: 992px)  { .btn-chart { padding: 10px 24px; font-size: 14px; } }
        .btn-chart-active   { background: var(--primary-maroon); color: white; border-color: var(--primary-maroon); }
        .btn-chart-inactive { background: white; color: var(--text-dark); border-color: var(--border-light); }
        .btn-chart-inactive:hover { background: var(--soft-cream); color: var(--primary-maroon); border-color: var(--primary-maroon); }

        /* ── Status items ───────────────────────────────────────────────────── */
        .status-item { display: flex; justify-content: space-between; align-items: center; margin-bottom: 10px; padding: 10px 12px; border-radius: var(--radius-md); background: var(--bg-lighter); transition: all var(--transition-base); border: 2px solid transparent; gap: 10px; }
        @media (min-width: 576px)  { .status-item { padding: 12px 14px; gap: 16px; } }
        @media (min-width: 992px)  { .status-item { padding: 14px 16px; gap: 20px; margin-bottom: 12px; } }
        .status-item i   { margin-right: 8px; font-size: 13px; flex-shrink: 0; }
        .status-item span{ display: flex; align-items: center; flex-grow: 1; gap: 6px; color: var(--text-dark); font-weight: 600; font-size: 13px; }
        .status-item b   { color: #800000 !important; font-weight: 700; font-size: 13px; flex-shrink: 0; }
        @media (min-width: 576px)  { .status-item span { font-size: 14px; } .status-item b { font-size: 15px; } }
        .status-item:hover { transform: translateX(4px); background: var(--bg-hover); }

        /* ── Top Selling / Restaurant items ─────────────────────────────────── */
        .res-info { display: flex; flex-direction: column; width: 100%; }
        .res-info b { color: var(--text-dark) !important; font-size: 13px; font-weight: 700; margin-bottom: 4px; display: block; }
        @media (min-width: 576px)  { .res-info b { font-size: 15px; } }
        .res-bar-container { width: 100%; height: 7px; background-color: var(--bg-light); border-radius: 4px; margin-top: 4px; overflow: hidden; }
        .res-bar-fill { height: 100%; background: linear-gradient(90deg, var(--primary-maroon), #8a1f35); border-radius: 4px; transition: width 0.5s ease; }
        .res-value { color: var(--primary-maroon) !important; font-weight: 800 !important; font-size: 13px !important; flex-shrink: 0; min-width: 55px; text-align: right; }
        @media (min-width: 576px)  { .res-value { font-size: 15px !important; min-width: 70px; } }

        .restaurant-item { display: flex; align-items: center; margin-bottom: 10px; gap: 10px; padding: 10px 12px; border-radius: var(--radius-md); transition: all var(--transition-base); border: 2px solid transparent; background: var(--bg-lighter); }
        @media (min-width: 576px)  { .restaurant-item { padding: 14px; gap: 14px; margin-bottom: 14px; } }
        .restaurant-item:hover { background: var(--bg-hover); transform: translateX(4px); border-color: var(--primary-maroon); }
        .rank-circle { width: 30px; height: 30px; background: linear-gradient(135deg, var(--primary-maroon), #8a1f35); color: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: 700; font-size: 12px; flex-shrink: 0; box-shadow: 0 4px 8px rgba(107,13,30,0.2); }
        @media (min-width: 576px)  { .rank-circle { width: 35px; height: 35px; font-size: 14px; } }

        /* ── Menu table ─────────────────────────────────────────────────────── */
        .menu-table-box { background: white; border-radius: var(--radius-xl); padding: 16px; box-shadow: var(--card-shadow); margin-top: 16px; overflow-x: auto; }
        @media (min-width: 576px)  { .menu-table-box { padding: 20px; margin-top: 20px; } }
        @media (min-width: 992px)  { .menu-table-box { padding: 25px; } }
        .table-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 16px; flex-wrap: wrap; gap: 10px; }
        .table-title { color: var(--text-dark); font-weight: 700; font-size: 15px; margin: 0; }
        @media (min-width: 576px)  { .table-title { font-size: 17px; } }
        @media (min-width: 992px)  { .table-title { font-size: 18px; } }
        .table-header-actions { flex-shrink: 0; }
        .view-all-link { color: var(--primary-maroon); text-decoration: none; font-weight: 700; font-size: 12px; padding: 8px 14px; border-radius: var(--radius-md); background: var(--bg-lighter); transition: all var(--transition-base); display: inline-flex; align-items: center; gap: 6px; border: 2px solid transparent; white-space: nowrap; }
        @media (min-width: 576px)  { .view-all-link { font-size: 13px; padding: 10px 18px; } }
        .view-all-link:hover { background: var(--primary-maroon); color: white; border-color: var(--primary-maroon); }

        .menu-table { width: 100%; border-collapse: collapse; min-width: 480px; }
        .menu-table th { color: var(--muted-text); font-size: 11px; text-align: left; padding: 12px 10px; border-bottom: 2px solid var(--bg-light); font-weight: 600; text-transform: uppercase; letter-spacing: 0.3px; white-space: nowrap; }
        .menu-table td { padding: 14px 10px; border-bottom: 1px solid var(--bg-lighter); color: var(--text-dark); font-size: 13px; transition: all var(--transition-fast); }
        @media (min-width: 768px)  { .menu-table th { font-size: 12px; padding: 14px 12px; } .menu-table td { font-size: 14px; padding: 18px 12px; } }
        @media (min-width: 992px)  { .menu-table th { padding: 16px 15px; } .menu-table td { padding: 20px 15px; } }
        .menu-table tbody tr:hover { background: var(--bg-hover); }

        .rank-badge { width: 28px; height: 28px; background: var(--accent-yellow); border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: 800; font-size: 12px; color: var(--text-dark); }
        @media (min-width: 576px)  { .rank-badge { width: 32px; height: 32px; font-size: 14px; } }
        .cat-badge { background: var(--accent-yellow-light); color: #D48C70; padding: 5px 10px; border-radius: var(--radius-sm); font-size: 11px; font-weight: 700; display: inline-block; }
        @media (min-width: 576px)  { .cat-badge { padding: 6px 12px; font-size: 12px; } }

        /* ── Notifications ──────────────────────────────────────────────────── */
        .notification { position: fixed; top: 16px; right: 16px; left: 16px; padding: 14px 18px; border-radius: var(--radius-md); color: white; font-weight: 600; font-size: 13px; display: flex; align-items: center; gap: 10px; z-index: 10000; box-shadow: 0 4px 12px rgba(0,0,0,0.15); animation: slideInRight 0.3s ease; }
        @media (min-width: 576px)  { .notification { left: auto; min-width: 280px; } }
        .notification-success { background: var(--success-green); }
        .notification-error   { background: var(--danger-red); }

        @keyframes slideInRight  { from { transform: translateX(100%); opacity: 0; } to { transform: translateX(0); opacity: 1; } }
        @keyframes slideOutRight { from { transform: translateX(0); opacity: 1; } to { transform: translateX(100%); opacity: 0; } }
        @media (max-width: 576px) { .header-info h2 { font-size: 24px; } .header-info p { font-size: 14px; } .stat-card__value { font-size: 24px; } .menu-table th, .menu-table td { padding: 12px 8px; font-size: 12px; } .simple-date-filter { flex-direction: column; align-items: flex-start; gap: 8px; } .simple-date-filter select { width: 100%; } .status-item { gap: 10px; padding: 12px 14px; } .status-item b { font-size: 14px; } .restaurant-item { flex-direction: column; align-items: flex-start; gap: 8px; } .restaurant-item .rank-circle { align-self: flex-start; } .res-value { align-self: flex-end; margin-top: 8px; } }
    </style>

    <%-- Hidden fields to pass server-side data to JavaScript --%>
    <asp:HiddenField ID="hfRevenueTrendLabels"  runat="server" />
    <asp:HiddenField ID="hfRevenueTrendData"    runat="server" />
    <asp:HiddenField ID="hfOrdersTrendData"     runat="server" />
    <asp:HiddenField ID="hfWeeklyRevenueLabels" runat="server" />
    <asp:HiddenField ID="hfWeeklyRevenueData"   runat="server" />
    <asp:HiddenField ID="hfWeeklyOrdersData"    runat="server" />
    <asp:HiddenField ID="hfYearlyRevenueLabels" runat="server" />
    <asp:HiddenField ID="hfYearlyRevenueData"   runat="server" />
    <asp:HiddenField ID="hfYearlyOrdersData"    runat="server" />
    <asp:HiddenField ID="hfTimeLabels"          runat="server" />
    <asp:HiddenField ID="hfTimeData"            runat="server" />
    <asp:HiddenField ID="hfStatusCompleted"     runat="server" />
    <asp:HiddenField ID="hfStatusActive"        runat="server" />
    <asp:HiddenField ID="hfStatusCancelled"     runat="server" />
    <asp:HiddenField ID="hfStatusTotal"         runat="server" />
    <asp:HiddenField ID="hfTopRevenueMax"       runat="server" />

    <div class="reports-container">
        <div class="reports-header">
            <div class="header-info">
                <h2>Analytics &amp; Reports</h2>
                <p>Comprehensive insights into your platform's performance</p>
            </div>
            <div class="header-actions">
                <div class="simple-date-filter">
                    <i class="far fa-calendar-alt"></i>
                    <asp:DropDownList ID="ddlDateRange" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlDateRange_SelectedIndexChanged">
                        <asp:ListItem Text="Last 7 days"  Value="7"   Selected="True" />
                        <asp:ListItem Text="Last 30 days" Value="30" />
                        <asp:ListItem Text="Last 90 days" Value="90" />
                        <asp:ListItem Text="This Year"    Value="365" />
                    </asp:DropDownList>
                </div>
                <asp:Button ID="btnExportExcel" runat="server"
                    CssClass="btn btn--primary"
                    Text="⬇ Export All Reports"
                    OnClick="btnExportExcel_Click"
                    OnClientClick="this.blur();" />
            </div>
        </div>

        <%-- ══════════════════════════════════════════════
             KPI CARDS
             ══════════════════════════════════════════════ --%>
        <div class="kpi-row">
            <%-- Total Orders --%>
            <div class="stat-card" data-type="orders">
                <div class="stat-card__header">
                    <span class="stat-card__label">Total Orders</span>
                    <div class="stat-card__icon stat-card__icon--orders">
                        <i class="fas fa-shopping-bag"></i>
                    </div>
                </div>
                <div class="stat-card__value">
                    <asp:Label ID="lblTotalOrders" runat="server" Text="0" />
                </div>
                <div class="stat-card__trend">
                    <span class="trend-badge trend-badge--positive">
                        <i class="fas fa-shopping-cart"></i> Orders
                    </span>
                    <span class="trend-text">selected period</span>
                </div>
            </div>

            <%-- Total Revenue --%>
            <div class="stat-card" data-type="revenue">
                <div class="stat-card__header">
                    <span class="stat-card__label">Total Revenue</span>
                    <div class="stat-card__icon stat-card__icon--revenue">
                        <i class="fas fa-peso-sign"></i>
                    </div>
                </div>
                <div class="stat-card__value">
                    <asp:Label ID="lblTotalRevenue" runat="server" Text="₱0" />
                </div>
                <div class="stat-card__trend">
                    <span class="trend-badge trend-badge--positive">
                        <i class="fas fa-peso-sign"></i> Revenue
                    </span>
                    <span class="trend-text">selected period</span>
                </div>
            </div>

            <%-- Average Order Value --%>
            <div class="stat-card" data-type="average">
                <div class="stat-card__header">
                    <span class="stat-card__label">Avg Order Value</span>
                    <div class="stat-card__icon stat-card__icon--average">
                        <i class="fas fa-chart-line"></i>
                    </div>
                </div>
                <div class="stat-card__value">
                    <asp:Label ID="lblAvgOrderValue" runat="server" Text="₱0" />
                </div>
                <div class="stat-card__trend">
                    <span class="trend-badge trend-badge--positive">
                        <i class="fas fa-chart-bar"></i> Average
                    </span>
                    <span class="trend-text">per ticket</span>
                </div>
            </div>

            <%-- New Customers --%>
            <div class="stat-card" data-type="customers">
                <div class="stat-card__header">
                    <span class="stat-card__label">New Customers</span>
                    <div class="stat-card__icon stat-card__icon--customers">
                        <i class="fas fa-users"></i>
                    </div>
                </div>
                <div class="stat-card__value">
                    <asp:Label ID="lblNewCustomers" runat="server" Text="0" />
                </div>
                <div class="stat-card__trend">
                    <span class="trend-badge trend-badge--positive">
                        <i class="fas fa-user-plus"></i> Customers
                    </span>
                    <span class="trend-text">selected period</span>
                </div>
            </div>


        </div>

        <%-- ══════════════════════════════════════════════
             ROW 1 — Revenue/Orders Trend  +  Order Status
             ══════════════════════════════════════════════ --%>
        <div class="dashboard-grid">
            <%-- Revenue & Orders Trend chart --%>
            <div class="chart-box">
                <div class="d-flex justify-content-between align-items-center mb-3" style="flex-wrap:wrap; gap:10px;">
                    <span class="chart-title m-0">Revenue &amp; Orders Trend</span>
                    <div class="btn-group">
                        <button type="button" class="btn-chart btn-chart-active"   onclick="toggleChartType('revenue')">Revenue</button>
                        <button type="button" class="btn-chart btn-chart-inactive" onclick="toggleChartType('orders')">Orders</button>
                    </div>
                </div>
                <div style="height:300px;"><canvas id="revenueChart"></canvas></div>
            </div>

            <%-- Order Status Distribution --%>
            <div class="chart-box">
                <span class="chart-title">Order Status Distribution</span>
                <div style="height:200px;"><canvas id="statusChart"></canvas></div>
                <div class="mt-4">
                    <%-- Repeater: Status breakdown list --%>
                    <asp:Repeater ID="rptStatusList" runat="server">
                        <ItemTemplate>
                            <div class="status-item">
                                <span>
                                    <i class="fas fa-circle me-2" style="color:<%# Container.ItemIndex == 0 ? "var(--success-green)" : Container.ItemIndex == 1 ? "var(--accent-yellow)" : "#B22222" %>"></i>
                                    <%# Eval("Status") %>
                                </span>
                                <b><%# Eval("Count") %> (<%# Eval("Pct") %>%)</b>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </div>

        <%-- ══════════════════════════════════════════════
             ROW 2 — Orders by Time of Day  +  Top Selling Meals
             ══════════════════════════════════════════════ --%>
        <div class="dashboard-grid">
            <%-- Orders by Time of Day chart --%>
            <div class="chart-box">
                <span class="chart-title">Orders by Time of Day</span>
                <div style="height:280px;"><canvas id="timeChart"></canvas></div>
                <div class="text-center mt-3">
                    <asp:Label ID="lblPeakHours" runat="server"
                        CssClass="trend-badge trend-badge--positive"
                        Text='<i class="fas fa-clock"></i> Peak hours: —' />
                </div>
            </div>

            <%-- Top Selling Meals — Repeater --%>
            <div class="chart-box">
                <span class="chart-title">Top Selling Meals</span>
                <asp:Repeater ID="rptTopMeals" runat="server">
                    <ItemTemplate>
                        <div class="restaurant-item">
                            <div class="rank-circle"><%# Container.ItemIndex + 1 %></div>
                            <div class="res-info flex-grow-1">
                                <b><%# Eval("FoodName") %></b>
                                <div class="res-bar-container">
                                    <div class="res-bar-fill" style="width:<%# Eval("BarPct") %>%;"></div>
                                </div>
                            </div>
                            <div class="res-value">₱<%# Eval("Revenue", "{0:N0}") %></div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>

        <%-- ══════════════════════════════════════════════
             Popular Menu Items Table — Repeater
             ══════════════════════════════════════════════ --%>
        <div class="menu-table-box">
            <div class="table-header">
                <h3 class="table-title">Popular Menu Items</h3>
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
                    <asp:Repeater ID="rptMenuItems" runat="server">
                        <ItemTemplate>
                            <tr>
                                <td><div class="rank-badge"><%# Container.ItemIndex + 1 %></div></td>
                                <td><b><%# Eval("FoodName") %></b></td>
                                <td><span class="cat-badge"><%# Eval("FoodType") %></span></td>
                                <td style="color:#800000; font-weight:700;"><%# Eval("TotalOrders") %></td>
                                <td style="color:var(--text-dark); font-weight:800;">₱<%# Eval("Revenue", "{0:N2}") %></td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </tbody>
            </table>
        </div>
    </div><%-- /reports-container --%>

    <script>
        /* ── Common Chart.js options ────────────────────────── */
        const commonOptions = {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: { display: false },
                tooltip: {
                    backgroundColor: 'rgba(107,13,30,0.95)',
                    titleFont: { family: 'Poppins', size: 14, weight: '600' },
                    bodyFont: { family: 'Poppins', size: 13, weight: '500' },
                    padding: 12, cornerRadius: 8,
                    titleColor: '#ffffff', bodyColor: '#ffffff',
                    borderColor: 'rgba(255,255,255,0.2)', borderWidth: 1,
                    callbacks: {
                        label: function (ctx) {
                            if (ctx.dataset.label === 'Revenue')
                                return 'Revenue: ₱' + ctx.parsed.y.toLocaleString();
                            return ctx.dataset.label + ': ' + ctx.parsed.y.toLocaleString();
                        }
                    }
                }
            },
            scales: {
                x: { grid: { color: 'rgba(234,226,226,0.3)', drawBorder: false }, ticks: { font: { family: 'Poppins', size: 12, weight: '500' }, color: '#8a6d6d' } },
                y: { grid: { color: 'rgba(234,226,226,0.3)', drawBorder: false }, ticks: { font: { family: 'Poppins', size: 12, weight: '500' }, color: '#8a6d6d', callback: v => '₱' + v.toLocaleString() } }
            },
            interaction: { intersect: false, mode: 'index' },
            animations: { tension: { duration: 1000, easing: 'linear' } }
        };

        /* ── Data from server ───────────────────────────────── */
        const trendLabels = JSON.parse(document.getElementById('<%= hfRevenueTrendLabels.ClientID %>').value || '[]');
        const revenueData = JSON.parse(document.getElementById('<%= hfRevenueTrendData.ClientID %>').value   || '[]');
        const ordersData    = JSON.parse(document.getElementById('<%= hfOrdersTrendData.ClientID %>').value    || '[]');

        const weeklyLabels  = JSON.parse(document.getElementById('<%= hfWeeklyRevenueLabels.ClientID %>').value || '[]');
        const weeklyRev     = JSON.parse(document.getElementById('<%= hfWeeklyRevenueData.ClientID %>').value   || '[]');
        const weeklyOrd     = JSON.parse(document.getElementById('<%= hfWeeklyOrdersData.ClientID %>').value    || '[]');

        const yearlyLabels  = JSON.parse(document.getElementById('<%= hfYearlyRevenueLabels.ClientID %>').value || '[]');
        const yearlyRev     = JSON.parse(document.getElementById('<%= hfYearlyRevenueData.ClientID %>').value   || '[]');
        const yearlyOrd     = JSON.parse(document.getElementById('<%= hfYearlyOrdersData.ClientID %>').value    || '[]');

        const timeLabels    = JSON.parse(document.getElementById('<%= hfTimeLabels.ClientID %>').value         || '[]');
        const timeData      = JSON.parse(document.getElementById('<%= hfTimeData.ClientID %>').value           || '[]');

        const statusCompleted = parseFloat(document.getElementById('<%= hfStatusCompleted.ClientID %>').value || '0');
        const statusActive    = parseFloat(document.getElementById('<%= hfStatusActive.ClientID %>').value    || '0');
        const statusCancelled = parseFloat(document.getElementById('<%= hfStatusCancelled.ClientID %>').value || '0');

        /* ── State ──────────────────────────────────────────── */
        let revenueChart, statusChart, timeChart;
        let currentChartType = 'revenue';
        let currentPeriodType = 'monthly';

        /* ── Get labels+data for current period ─────────────── */
        function getPeriodData() {
            if (currentPeriodType === 'weekly')
                return { labels: weeklyLabels, rev: weeklyRev, ord: weeklyOrd };
            if (currentPeriodType === 'yearly')
                return { labels: yearlyLabels, rev: yearlyRev, ord: yearlyOrd };
            return { labels: trendLabels, rev: revenueData, ord: ordersData };
        }

        /* Builds a fresh isolated options object for the trend chart */
        function buildTrendOptions(isRevenue) {
            return {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: { display: false },
                    tooltip: {
                        backgroundColor: 'rgba(107,13,30,0.95)',
                        titleFont: { family: 'Poppins', size: 14, weight: '600' },
                        bodyFont: { family: 'Poppins', size: 13, weight: '500' },
                        padding: 12, cornerRadius: 8,
                        titleColor: '#ffffff', bodyColor: '#ffffff',
                        borderColor: 'rgba(255,255,255,0.2)', borderWidth: 1,
                        callbacks: {
                            label: function (ctx) {
                                return isRevenue
                                    ? 'Revenue: ₱' + ctx.parsed.y.toLocaleString()
                                    : 'Orders: ' + ctx.parsed.y.toLocaleString();
                            }
                        }
                    }
                },
                scales: {
                    x: {
                        grid: { color: 'rgba(234,226,226,0.3)', drawBorder: false },
                        ticks: { font: { family: 'Poppins', size: 12, weight: '500' }, color: '#8a6d6d' }
                    },
                    y: {
                        grid: { color: 'rgba(234,226,226,0.3)', drawBorder: false },
                        ticks: {
                            font: { family: 'Poppins', size: 12, weight: '500' },
                            color: '#8a6d6d',
                            callback: isRevenue ? v => '₱' + v.toLocaleString() : v => v
                        }
                    }
                },
                interaction: { intersect: false, mode: 'index' },
                animations: { tension: { duration: 1000, easing: 'linear' } }
            };
        }

        function initializeCharts() {
            const pd = getPeriodData();

            /* Revenue / Orders Trend — own options object */
            const revenueCtx = document.getElementById('revenueChart').getContext('2d');
            revenueChart = new Chart(revenueCtx, {
                type: 'line',
                data: {
                    labels: pd.labels,
                    datasets: [{
                        label: 'Revenue',
                        data: pd.rev,
                        borderColor: '#6b0d1e',
                        backgroundColor: 'rgba(107,13,30,0.05)',
                        fill: true, tension: 0.4, borderWidth: 3,
                        pointBackgroundColor: '#6b0d1e', pointBorderColor: '#ffffff',
                        pointBorderWidth: 2, pointRadius: 6, pointHoverRadius: 8,
                        pointHoverBackgroundColor: '#5a0b19'
                    }]
                },
                options: buildTrendOptions(true)
            });

            /* Order Status Doughnut */
            const statusCtx = document.getElementById('statusChart').getContext('2d');
            statusChart = new Chart(statusCtx, {
                type: 'doughnut',
                data: {
                    datasets: [{
                        data: [statusCompleted, statusActive, statusCancelled],
                        backgroundColor: ['#2d9d78', '#ffcc00', '#B22222'],
                        borderWidth: 0, borderRadius: 8, hoverOffset: 20,
                        hoverBackgroundColor: ['#2d9d78CC', '#ffcc00CC', '#B22222CC']
                    }]
                },
                options: {
                    ...commonOptions, cutout: '65%',
                    plugins: {
                        ...commonOptions.plugins,
                        tooltip: {
                            ...commonOptions.plugins.tooltip,
                            callbacks: {
                                label: function (ctx) {
                                    const l = ['Completed', 'Active', 'Cancelled'];
                                    return l[ctx.dataIndex] + ': ' + ctx.raw + '%';
                                }
                            }
                        }
                    }
                }
            });

            /* Orders by Time of Day */
            const timeCtx = document.getElementById('timeChart').getContext('2d');
            const peakIdxs = timeData.map((v, i) => [v, i]).sort((a, b) => b[0] - a[0]).slice(0, 2).map(x => x[1]);

            timeChart = new Chart(timeCtx, {
                type: 'bar',
                data: {
                    labels: timeLabels,
                    datasets: [{
                        label: 'Orders',
                        data: timeData,
                        backgroundColor: ctx => peakIdxs.includes(ctx.dataIndex) ? '#ffcc00' : 'rgba(107,13,30,0.8)',
                        borderRadius: 8, borderSkipped: false,
                        hoverBackgroundColor: ctx => peakIdxs.includes(ctx.dataIndex) ? '#e6b800' : '#5a0b19'
                    }]
                },
                options: {
                    ...commonOptions,
                    scales: {
                        x: commonOptions.scales.x,
                        y: { ...commonOptions.scales.y, ticks: { ...commonOptions.scales.y.ticks, callback: v => v } }
                    }
                }
            });
        }

        /* ── Rebuild trend chart with current type + period ─── */
        function rebuildTrendChart() {
            const pd = getPeriodData();
            const isRevenue = currentChartType === 'revenue';

            revenueChart.destroy();
            const ctx = document.getElementById('revenueChart').getContext('2d');
            revenueChart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: pd.labels,
                    datasets: [{
                        label: isRevenue ? 'Revenue' : 'Orders',
                        data: isRevenue ? pd.rev : pd.ord,
                        borderColor: '#6b0d1e',
                        backgroundColor: 'rgba(107,13,30,0.05)',
                        fill: true, tension: 0.4, borderWidth: 3,
                        pointBackgroundColor: '#6b0d1e', pointBorderColor: '#ffffff',
                        pointBorderWidth: 2, pointRadius: 6, pointHoverRadius: 8,
                        pointHoverBackgroundColor: '#5a0b19'
                    }]
                },
                options: buildTrendOptions(isRevenue)
            });
        }

        function toggleChartType(type) {
            currentChartType = type;
            const isRevenue = type === 'revenue';
            document.querySelectorAll('.btn-chart').forEach((b, i) => {
                b.className = (i === 0 && isRevenue) || (i === 1 && !isRevenue)
                    ? 'btn-chart btn-chart-active'
                    : 'btn-chart btn-chart-inactive';
            });
            rebuildTrendChart();
        }

        function togglePeriod(period) {
            currentPeriodType = period;
            document.querySelectorAll('.btn-period').forEach(b => {
                const p = b.getAttribute('onclick').match(/'(\w+)'/)[1];
                b.className = p === period ? 'btn-period btn-period-active' : 'btn-period btn-period-inactive';
            });
            rebuildTrendChart();
        }

        document.addEventListener('DOMContentLoaded', function () {
            initializeCharts();
        });
    </script>
</asp:Content>
