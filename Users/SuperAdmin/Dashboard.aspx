<%@ Page Title="Dashboard | TasteNet" Language="C#" MasterPageFile="~/MasterPages/SuperAdmin.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="TasteNet.Users.SuperAdmin.Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <asp:HiddenField ID="hdnPeriod"      runat="server" Value="Monthly" />
    <asp:HiddenField ID="hdnChartLabels" runat="server" />
    <asp:HiddenField ID="hdnChartData"   runat="server" />
    <asp:HiddenField ID="hdnQuotaSaved"  runat="server" Value="0" />
    <asp:HiddenField ID="hdnQuotaTarget" runat="server" Value="0" />
    <asp:HiddenField ID="hdnQuotaPct"    runat="server" Value="0" />

    <style>
        :root {
            --primary-maroon: #6b0d1e;
            --soft-cream:     #fffaf3;
            --text-dark:      #4a0e0e;
            --muted-text:     #8a6d6d;
            --success-green:  #2d9d78;
            --warning-orange: #d97706;
            --card-shadow:    0 10px 30px rgba(107,13,30,.05);
        }
        body { background-color:var(--soft-cream) !important; font-family:'Poppins',sans-serif; color:var(--text-dark); }
        .dashboard-wrapper { padding:24px 28px; max-width:1600px; margin:0 auto; width:100%; box-sizing:border-box; overflow-x:hidden; }

        .dashboard-header { display:flex; justify-content:space-between; align-items:center; margin-bottom:35px; }
        .welcome h1 { font-size:32px; font-weight:700; margin:0; color:var(--text-dark); }
        .welcome p  { color:var(--muted-text); margin:8px 0 0; font-size:16px; }

        /* ── Stat grid ── */
        .stat-grid { display:grid; grid-template-columns:repeat(4,1fr); gap:16px; margin-bottom:28px; }
        .stat-card {
            background:white; padding:16px 18px; border-radius:14px;
            box-shadow:var(--card-shadow); transition:transform .25s,box-shadow .25s;
            position:relative; overflow:hidden;
        }
        .stat-card::before {
            content:''; position:absolute; inset:0; border-radius:14px;
            opacity:0; transition:opacity .25s;
        }
        .stat-card:hover { transform:translateY(-3px); box-shadow:0 8px 24px rgba(107,13,30,.10); }
        .stat-card:hover::before { opacity:1; }

        /* Left accent bar */
        
        .stat-top { display:flex; justify-content:space-between; align-items:flex-start; margin-bottom:10px; }
        .stat-meta { display:flex; flex-direction:column; gap:2px; }
        .stat-label { font-size:11px; font-weight:600; color:var(--muted-text); letter-spacing:.5px; text-transform:uppercase; }
        .stat-value { font-size:28px; font-weight:700; color:var(--text-dark); line-height:1.1; margin:0; }
        .stat-trend { font-size:11px; font-weight:500; margin-top:8px; display:flex; align-items:center; gap:4px; color:var(--muted-text); }
        .trend-up   { color:var(--success-green); }
        .icon-box {
            width:36px; height:36px; border-radius:10px; flex-shrink:0;
            display:flex; align-items:center; justify-content:center; font-size:15px;
        }

        /* Quota card */
        .quota-card { cursor:pointer; }
        .quota-card:hover .quota-edit-hint { opacity:1; }
        .quota-edit-hint { position:absolute; top:10px; right:10px; background:var(--primary-maroon); color:white; font-size:9px; font-weight:700; padding:2px 7px; border-radius:6px; opacity:0; transition:opacity .2s; letter-spacing:.3px; }
        .quota-pct { font-size:22px; font-weight:700; color:var(--primary-maroon); margin:2px 0 8px; line-height:1; }
        .quota-pct.over { color:var(--success-green); }
        .quota-progress-wrap { margin-top:2px; }
        .quota-bar-bg { width:100%; height:5px; background:#f3ebe0; border-radius:999px; overflow:hidden; margin-bottom:8px; }
        .quota-bar-fill { height:100%; width:0%; border-radius:999px; background:var(--primary-maroon); transition:width .6s ease; }
        .quota-bar-fill.over { background:var(--success-green); }
        .quota-progress-row { display:flex; justify-content:space-between; font-size:10px; font-weight:500; color:var(--muted-text); margin-bottom:3px; }
        .quota-progress-row .qval { color:var(--text-dark); font-weight:700; font-size:10px; }

        /* Period buttons */
        .chart-controls { display:flex; background:#f3ebe0; padding:5px; border-radius:12px; gap:4px; }
        .chart-btn { padding:8px 16px; border-radius:10px; border:none; font-size:12px; font-weight:600; cursor:pointer; background:transparent; color:var(--muted-text); transition:all .3s; min-width:60px; font-family:'Poppins',sans-serif; }
        .chart-btn.active { background:var(--primary-maroon); color:white; box-shadow:0 2px 6px rgba(107,13,30,.2); }
        .chart-btn:hover:not(.active) { background:rgba(107,13,30,.05); }

        .main-grid {
            display:grid;
            grid-template-columns: minmax(0, 2fr) minmax(0, 1fr);
            gap:20px;
            align-items:start;
            width:100%;
            box-sizing:border-box;
        }
        .chart-box, .side-box { background:white; border-radius:18px; padding:20px 22px; box-shadow:var(--card-shadow); min-width:0; width:100%; box-sizing:border-box; overflow:hidden; }
        .side-box { padding:18px 20px; }
        .box-title { font-size:18px; font-weight:700; margin-bottom:20px; color:var(--primary-maroon); display:flex; justify-content:space-between; align-items:center; }
        .chart-container {
            position:relative;
            width:100%;
            height:280px;
            overflow:hidden;
            display:block;
        }
        @media (max-width:1100px) { .chart-container { height:260px; } }
        @media (max-width:768px)  { .chart-container { height:220px; } }
        @media (max-width:480px)  { .chart-container { height:180px; } }
        .chart-legend { display:flex; align-items:center; gap:8px; margin-top:12px; font-size:12px; color:var(--muted-text); }
        .chart-legend-dash { display:inline-block; width:24px; border-top:2px dashed var(--primary-maroon); opacity:.6; }

        .meal-item { display:flex; align-items:center; padding:10px 12px; border-radius:12px; background:#fffcf8; margin-bottom:8px; border:1.5px solid #f3ebe0; transition:all .3s; min-width:0; }
        .meal-item:hover { background:#fefaf5; border-color:#e2d1d1; transform:translateX(3px); }
        .meal-rank { width:32px; height:32px; background:var(--primary-maroon); color:white; border-radius:10px; display:flex; align-items:center; justify-content:center; font-weight:bold; font-size:14px; margin-right:15px; flex-shrink:0; }
        .meal-rank.gray { background:#e2d1d1 !important; }
        .meal-info  { flex-grow:1; }
        .meal-name  { font-weight:600; font-size:13px; margin:0 0 3px; color:var(--text-dark); white-space:nowrap; overflow:hidden; text-overflow:ellipsis; max-width:140px; }
        .meal-sales { font-size:12px; color:var(--muted-text); margin:0; }
        .meal-price { font-weight:700; color:var(--primary-maroon); font-size:14px; margin-left:10px; }

        .recent-orders-full { margin-top:20px; }
        .table-container { background:white; border-radius:16px; padding:6px 16px 16px; box-shadow:var(--card-shadow); overflow-x:auto; -webkit-overflow-scrolling:touch; }
        .custom-table { width:100%; border-collapse:separate; border-spacing:0; }
        .custom-table th { padding:16px 12px; text-align:center; font-size:13px; color:var(--muted-text); font-weight:600; border-bottom:2px solid #f3ebe0; }
        .custom-table td { padding:18px 12px; border-bottom:1px solid #f9f4ee; font-size:13px; vertical-align:middle; text-align:center; }
        .custom-table tbody tr:hover { background-color:#fefaf5; }
        .order-id      { color:var(--primary-maroon) !important; font-weight:700; }
        .customer-name { color:var(--text-dark) !important; font-weight:600; }
        .action-icon { width:32px; height:32px; background:#f9f4ee; border-radius:10px; display:inline-flex; align-items:center; justify-content:center; cursor:pointer; transition:all .3s; color:var(--muted-text); }
        .action-icon:hover { background:var(--primary-maroon); color:white; }

        .badge-completed,.badge-pending,.badge-progress,.badge-cancelled { padding:6px 14px; border-radius:10px; font-size:11px; font-weight:700; display:inline-block; text-transform:uppercase; }
        .badge-completed { background:#e6f4f1; color:#2d9d78; }
        .badge-pending   { background:#fff4e6; color:#d97706; }
        .badge-progress  { background:#e6f0ff; color:#2563eb; }
        .badge-cancelled { background:#fee2e2; color:#b91c1c; }
        .priority-high   { background:#fee2e2; color:#b91c1c; padding:4px 10px; border-radius:8px; font-size:10px; font-weight:700; text-transform:uppercase; }
        .priority-normal { background:#f3ebe0; color:#8a6d6d; padding:4px 10px; border-radius:8px; font-size:10px; font-weight:700; text-transform:uppercase; }

        .stock-quick-grid { display:grid; grid-template-columns:1fr 1fr; gap:20px; margin-top:20px; }
        .btn-quick { background:var(--primary-maroon); color:white; border:none; border-radius:14px; padding:13px 18px; font-weight:600; cursor:pointer; transition:all .3s; font-size:14px; box-shadow:0 4px 12px rgba(107,13,30,.2); width:100%; margin-bottom:12px; display:flex; align-items:center; justify-content:center; gap:10px; font-family:'Poppins',sans-serif; }
        .btn-quick:hover { background:#5a0b19; transform:translateY(-2px); }
        .btn-quick.outline { background:white; color:var(--primary-maroon); border:2px solid var(--primary-maroon); box-shadow:none; }
        .btn-quick.outline:hover { background:var(--soft-cream); }
        .view-all-link { font-size:13px; color:var(--primary-maroon); text-decoration:none; font-weight:600; display:flex; align-items:center; gap:5px; padding:6px 12px; border-radius:10px; background:#f9f4ee; transition:all .3s; }
        .view-all-link:hover { background:var(--primary-maroon); color:white; }
        .no-data { text-align:center; color:var(--muted-text); padding:30px 0; font-size:14px; }

        /* Quota Modal */
        .modal-overlay { display:none; position:fixed; inset:0; background:rgba(74,14,14,.45); z-index:9999; align-items:center; justify-content:center; }
        .modal-overlay.open { display:flex; }
        .modal-box { background:white; border-radius:24px; padding:32px; width:100%; max-width:460px; box-shadow:0 20px 60px rgba(107,13,30,.2); animation:slideUp .25s ease; }
        @keyframes slideUp { from{transform:translateY(30px);opacity:0} to{transform:translateY(0);opacity:1} }
        .modal-header { display:flex; justify-content:space-between; align-items:center; margin-bottom:24px; }
        .modal-title { font-size:20px; font-weight:700; color:var(--text-dark); margin:0; }
        .modal-close { background:none; border:none; font-size:20px; color:var(--muted-text); cursor:pointer; width:36px; height:36px; border-radius:10px; display:flex; align-items:center; justify-content:center; transition:all .2s; }
        .modal-close:hover { background:#f3ebe0; color:var(--text-dark); }
        .quota-row { margin-bottom:18px; }
        .quota-label { font-size:13px; font-weight:600; color:var(--muted-text); margin-bottom:6px; display:flex; align-items:center; gap:8px; }
        .quota-label i { font-size:14px; color:var(--primary-maroon); }
        .quota-input-wrap { position:relative; }
        .quota-input-wrap .peso-sign { position:absolute; left:14px; top:50%; transform:translateY(-50%); font-weight:700; color:var(--primary-maroon); font-size:15px; }
        .quota-input { width:100%; padding:12px 14px 12px 32px; border:2px solid #e8ddd5; border-radius:12px; font-size:16px; font-weight:600; font-family:'Poppins',sans-serif; color:var(--text-dark); outline:none; transition:border-color .2s; box-sizing:border-box; }
        .quota-input:focus { border-color:var(--primary-maroon); box-shadow:0 0 0 3px rgba(107,13,30,.08); }
        .modal-footer { display:flex; gap:10px; margin-top:28px; }
        .btn-modal-save { flex:1; background:var(--primary-maroon); color:white; border:none; border-radius:12px; padding:14px; font-size:15px; font-weight:700; cursor:pointer; font-family:'Poppins',sans-serif; transition:all .2s; }
        .btn-modal-save:hover { background:#5a0b19; }
        .btn-modal-cancel { background:white; color:var(--muted-text); border:2px solid #e8ddd5; border-radius:12px; padding:14px 20px; font-size:15px; font-weight:600; cursor:pointer; font-family:'Poppins',sans-serif; transition:all .2s; }
        .btn-modal-cancel:hover { border-color:var(--primary-maroon); color:var(--text-dark); }

        .toast { position:fixed; bottom:30px; right:30px; background:#2d9d78; color:white; padding:14px 22px; border-radius:14px; font-size:14px; font-weight:600; box-shadow:0 8px 24px rgba(0,0,0,.15); display:flex; align-items:center; gap:10px; z-index:99999; transform:translateY(80px); opacity:0; transition:all .35s ease; }
        .toast.show { transform:translateY(0); opacity:1; }

        /* ── Responsive ── */

        /* Tablet landscape */
        @media (max-width:1100px) {
            .main-grid {
                grid-template-columns: 1fr;
            }
            .side-box { max-height:none; }
            .stock-quick-grid { grid-template-columns:1fr 1fr; }
        }

        /* Tablet portrait */
        @media (max-width:900px) {
            .dashboard-wrapper  { padding:18px; }
            .stat-grid          { grid-template-columns:repeat(2,1fr); gap:14px; }
            .stock-quick-grid   { grid-template-columns:1fr; }
            .main-grid          { gap:16px; }
            .custom-table th:nth-child(6),
            .custom-table td:nth-child(6) { display:none; }
        }

        /* Mobile landscape / large phone */
        @media (max-width:768px) {
            .dashboard-wrapper  { padding:14px; }
            .stat-grid          { grid-template-columns:repeat(2,1fr); gap:12px; }
            .dashboard-header   { flex-direction:column; align-items:flex-start; gap:12px; }
            .chart-controls     { width:100%; }
            .chart-controls .chart-btn { flex:1; padding:8px 6px; font-size:11px; }
            .welcome h1         { font-size:20px; }
            .welcome p          { font-size:13px; }
            .chart-box, .side-box { padding:14px 16px; border-radius:14px; }
            .box-title          { font-size:15px; margin-bottom:12px; }
            .stat-value         { font-size:22px; }
            .table-container    { padding:4px 8px 12px; border-radius:12px; }
            .custom-table th    { padding:12px 8px; font-size:11px; }
            .custom-table td    { padding:12px 8px; font-size:11px; }
            .custom-table th:nth-child(3),
            .custom-table td:nth-child(3),
            .custom-table th:nth-child(8),
            .custom-table td:nth-child(8) { display:none; }
            .meal-name          { max-width:100px; }
            .recent-orders-full { margin-top:16px; }
        }

        /* Mobile portrait */
        @media (max-width:480px) {
            .dashboard-wrapper  { padding:10px; }
            .stat-grid          { grid-template-columns:1fr 1fr; gap:10px; }
            .stat-card          { padding:12px 14px; }
            .stat-value         { font-size:20px; }
            .icon-box           { width:30px; height:30px; font-size:13px; }
            .main-grid          { gap:12px; }
            .stock-quick-grid   { gap:12px; }
            .modal-box          { padding:20px 16px; margin:0 10px; }
            .custom-table th:nth-child(4),
            .custom-table td:nth-child(4),
            .custom-table th:nth-child(6),
            .custom-table td:nth-child(6) { display:none; }
            .btn-quick          { padding:11px 14px; font-size:13px; }
            .meal-name          { max-width:80px; font-size:12px; }
            .meal-price         { font-size:12px; }
            .meal-sales         { font-size:11px; }
            .view-all-link      { font-size:11px; padding:5px 8px; }
        }

        /* Very small screens */
        @media (max-width:360px) {
            .stat-grid { grid-template-columns:1fr; }
        }
        /* Order Details Modal */
        #orderModal .modal-box { animation:slideUp .25s ease; }
    </style>

    <asp:ScriptManager ID="ScriptManager1" runat="server" />

    <asp:UpdatePanel ID="upDashboard" runat="server" UpdateMode="Always" style="display:block;width:100%;">
        <ContentTemplate>

            <div class="dashboard-wrapper">

                <%-- HEADER --%>
                <div class="dashboard-header">
                    <div class="welcome">
                        <h1>Welcome back, Admin!</h1>
                        <p>Here's what's happening with your platform.</p>
                    </div>
                    <div class="chart-controls">
                        <asp:Button ID="btnToday"  runat="server" Text="Daily"   CommandArgument="Daily"   CssClass="chart-btn"        OnClick="btnPeriod_Click" />
                        <asp:Button ID="btn7Days"  runat="server" Text="Weekly"  CommandArgument="Weekly"  CssClass="chart-btn"        OnClick="btnPeriod_Click" />
                        <asp:Button ID="btn30Days" runat="server" Text="Monthly" CommandArgument="Monthly" CssClass="chart-btn active" OnClick="btnPeriod_Click" />
                    </div>
                </div>

                <%-- STAT CARDS --%>
                <div class="stat-grid">

                    <div class="stat-card" style="--accent-color:#d97706;">
                        <div class="stat-top">
                            <div class="stat-meta">
                                <span class="stat-label">Total Orders</span>
                                <span class="stat-value"><asp:Label ID="lblTotalOrders" runat="server" Text="0" /></span>
                            </div>
                            <div class="icon-box" style="background:#fff9e6;color:#d97706;"><i class="fas fa-shopping-bag"></i></div>
                        </div>
                        <div class="stat-trend trend-up">
                            <i class="fas fa-calendar-alt"></i>
                            <asp:Label ID="lblPeriodOrders" runat="server" Text="monthly" />
                        </div>
                    </div>

                    <div class="stat-card" style="--accent-color:#6b0d1e;">
                        <div class="stat-top">
                            <div class="stat-meta">
                                <span class="stat-label">Total Revenue</span>
                                <span class="stat-value"><asp:Label ID="lblTotalRevenue" runat="server" Text="&#8369;0.00" /></span>
                            </div>
                            <div class="icon-box" style="background:#f9ecee;color:#6b0d1e;"><i class="fas fa-peso-sign"></i></div>
                        </div>
                        <div class="stat-trend trend-up">
                            <i class="fas fa-calendar-alt"></i>
                            <asp:Label ID="lblPeriodRevenue" runat="server" Text="monthly" />
                        </div>
                    </div>

                    <div class="stat-card" style="--accent-color:#2d9d78;">
                        <div class="stat-top">
                            <div class="stat-meta">
                                <span class="stat-label">Active Users</span>
                                <span class="stat-value"><asp:Label ID="lblActiveUsers" runat="server" Text="0" /></span>
                            </div>
                            <div class="icon-box" style="background:#edf7f4;color:#2d9d78;"><i class="fas fa-users"></i></div>
                        </div>
                        <div class="stat-trend trend-up">
                            <i class="fas fa-user-check"></i> customers
                        </div>
                    </div>

                    <%-- QUOTA CARD --%>
                    <div class="stat-card quota-card" onclick="openQuotaModal()" title="Click to set quotas" style="--accent-color:#7c3aed;">
                        <span class="quota-edit-hint"><i class="fas fa-pen"></i> Edit</span>
                        <div class="stat-top">
                            <div class="stat-meta">
                                <span class="stat-label">Quota &mdash; <asp:Label ID="lblActiveQuotaType" runat="server" Text="Monthly" /></span>
                                <asp:Label ID="lblQuotaPct" runat="server" Text="0%" CssClass="quota-pct" />
                            </div>
                            <div class="icon-box" style="background:#f3ebff;color:#7c3aed;"><i class="fas fa-bullseye"></i></div>
                        </div>

                        <div class="quota-progress-wrap">
                            <%-- Animated bar — width driven by JS from hdnQuotaPct --%>
                            <div class="quota-bar-bg">
                                <div class="quota-bar-fill" id="quotaBarFill"></div>
                            </div>
                            <div class="quota-progress-row">
                                <span>Target</span>
                                <span class="qval"><asp:Label ID="lblActiveQuotaAmount" runat="server" Text="&#8369;0" /></span>
                            </div>
                            <div class="quota-progress-row">
                                <span>Current Sales</span>
                                <span class="qval"><asp:Label ID="lblQuotaCurrent" runat="server" Text="&#8369;0" /></span>
                            </div>
                            <div class="quota-progress-row">
                                <span>Progress</span>
                                <span class="qval"><asp:Label ID="lblQuotaPctSmall" runat="server" Text="0%" /></span>
                            </div>
                        </div>
                    </div>

                </div>

                <%-- CHART + TOP MEALS --%>
                <div class="main-grid">
                    <div class="chart-box">
                        <div class="box-title">Revenue Overview</div>
                        <div class="chart-container">
                            <canvas id="revenueChart"></canvas>
                        </div>
                        <div class="chart-legend">
                            <span style="display:inline-block;width:24px;border-top:2px dashed #7c3aed;"></span>
                            <asp:Label ID="lblQuotaPeriod" runat="server" Text="Monthly target" />
                        </div>
                    </div>

                    <div class="side-box">
                        <div class="box-title">Top Selling Meals</div>
                        <asp:Repeater ID="rptTopMeals" runat="server">
                            <ItemTemplate>
                                <div class="meal-item">
                                    <div class="meal-rank <%# Container.ItemIndex >= 3 ? "gray" : "" %>"><%# Container.ItemIndex + 1 %></div>
                                    <div class="meal-info">
                                        <p class="meal-name"><%# Eval("FoodName") %></p>
                                        <p class="meal-sales"><%# Eval("TotalOrders") %> orders</p>
                                    </div>
                                    <div class="meal-price">&#8369;<%# string.Format("{0:N2}", Eval("TotalSales")) %></div>
                                </div>
                            </ItemTemplate>
                            <FooterTemplate>
                                <%# rptTopMeals.Items.Count == 0 ? "<p class='no-data'>No meal data for this period.</p>" : "" %>
                            </FooterTemplate>
                        </asp:Repeater>
                    </div>
                </div>

                <%-- RECENT ORDERS --%>
                <div class="recent-orders-full">
                    <div class="chart-box">
                        <div class="box-title">
                            Recent Orders
                        </div>
                        <div class="table-container">
                            <table class="custom-table">
                                <thead>
                                    <tr>
                                        <th>Ticket #</th><th>Customer</th><th>Order Type</th>
                                        <th>Items</th><th>Amount</th><th>Priority</th>
                                        <th>Status</th><th>Date &amp; Time</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:Repeater ID="rptRecentOrders" runat="server">
                                        <ItemTemplate>
                                            <tr>
                                                <td class="order-id"><%# Eval("TicketNumber") %></td>
                                                <td class="customer-name"><%# Eval("CustomerName") %></td>
                                                <td><%# Eval("PaymentMethod") %></td>
                                                <td><%# Eval("FirstItem") %><%# Convert.ToInt32(Eval("ItemCount")) > 1 ? "<br/><small style='color:var(--muted-text)'>+" + (Convert.ToInt32(Eval("ItemCount")) - 1) + " more</small>" : "" %></td>
                                                <td style="font-weight:700;color:var(--primary-maroon);">&#8369;<%# string.Format("{0:N2}", Eval("TotalAmount")) %></td>
                                                <td><span class="<%# Eval("Priority").ToString().ToUpper() == "HIGH" ? "priority-high" : "priority-normal" %>"><%# Eval("Priority") %></span></td>
                                                <td><span class="<%# GetStatusCss(Eval("Status").ToString()) %>"><%# Eval("Status") %></span></td>
                                                <td style="color:var(--muted-text);"><%# Convert.ToDateTime(Eval("CreatedAt")).ToString("MMM dd, hh:mm tt") %></td>
                                            </tr>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <%# rptRecentOrders.Items.Count == 0 ? "<tr><td colspan='8' class='no-data'>No completed orders for this period.</td></tr>" : "" %>
                                        </FooterTemplate>
                                    </asp:Repeater>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <%-- QUICK ACTIONS --%>


            </div><%-- /dashboard-wrapper --%>

            <%-- QUOTA MODAL --%>
            <div class="modal-overlay" id="quotaModal">
                <div class="modal-box">
                    <div class="modal-header">
                        <h2 class="modal-title"><i class="fas fa-bullseye" style="color:var(--primary-maroon);margin-right:10px;"></i>Set Quota Targets</h2>
                        <button type="button" class="modal-close" onclick="closeQuotaModal()"><i class="fas fa-times"></i></button>
                    </div>
                    <div class="quota-row">
                        <div class="quota-label"><i class="fas fa-sun"></i> Daily Target</div>
                        <div class="quota-input-wrap">
                            <span class="peso-sign">&#8369;</span>
                            <asp:TextBox ID="txtDailyQuota" runat="server" CssClass="quota-input" TextMode="Number" min="0" step="0.01" placeholder="e.g. 1000" />
                        </div>
                    </div>
                    <div class="quota-row">
                        <div class="quota-label"><i class="fas fa-calendar-week"></i> Weekly Target</div>
                        <div class="quota-input-wrap">
                            <span class="peso-sign">&#8369;</span>
                            <asp:TextBox ID="txtWeeklyQuota" runat="server" CssClass="quota-input" TextMode="Number" min="0" step="0.01" placeholder="e.g. 5000" />
                        </div>
                    </div>
                    <div class="quota-row">
                        <div class="quota-label"><i class="fas fa-calendar-alt"></i> Monthly Target</div>
                        <div class="quota-input-wrap">
                            <span class="peso-sign">&#8369;</span>
                            <asp:TextBox ID="txtMonthlyQuota" runat="server" CssClass="quota-input" TextMode="Number" min="0" step="0.01" placeholder="e.g. 20000" />
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn-modal-cancel" onclick="closeQuotaModal()">Cancel</button>
                        <asp:Button ID="btnSaveQuota" runat="server" Text="Save Quotas" CssClass="btn-modal-save" OnClick="btnSaveQuota_Click" />
                    </div>
                </div>
            </div>

        </ContentTemplate>
    </asp:UpdatePanel>

    <%-- ORDER DETAILS MODAL --%>
    <div class="modal-overlay" id="orderModal">
        <div class="modal-box" style="max-width:520px;">
            <div class="modal-header">
                <h2 class="modal-title">
                    <i class="fas fa-receipt" style="color:var(--primary-maroon);margin-right:10px;"></i>
                    Order Details
                </h2>
                <button type="button" class="modal-close" onclick="closeOrderModal()"><i class="fas fa-times"></i></button>
            </div>

            <%-- Ticket badge row --%>
            <div style="display:flex;align-items:center;justify-content:space-between;margin-bottom:20px;flex-wrap:wrap;gap:10px;">
                <span id="omTicketNumber" style="font-size:18px;font-weight:700;color:var(--primary-maroon);"></span>
                <div style="display:flex;gap:8px;align-items:center;flex-wrap:wrap;">
                    <span id="omStatusBadge" style="padding:6px 14px;border-radius:10px;font-size:11px;font-weight:700;text-transform:uppercase;"></span>
                    <span id="omPriorityBadge" style="padding:4px 10px;border-radius:8px;font-size:10px;font-weight:700;text-transform:uppercase;"></span>
                </div>
            </div>

            <%-- Detail rows --%>
            <div style="display:grid;grid-template-columns:1fr 1fr;gap:14px;margin-bottom:20px;">
                <div style="background:#fffcf8;border:1.5px solid #f3ebe0;border-radius:12px;padding:12px 14px;">
                    <div style="font-size:10px;font-weight:600;color:var(--muted-text);text-transform:uppercase;letter-spacing:.5px;margin-bottom:4px;">
                        <i class="fas fa-user" style="color:var(--primary-maroon);margin-right:5px;"></i>Customer
                    </div>
                    <div id="omCustomer" style="font-size:14px;font-weight:600;color:var(--text-dark);"></div>
                </div>
                <div style="background:#fffcf8;border:1.5px solid #f3ebe0;border-radius:12px;padding:12px 14px;">
                    <div style="font-size:10px;font-weight:600;color:var(--muted-text);text-transform:uppercase;letter-spacing:.5px;margin-bottom:4px;">
                        <i class="fas fa-credit-card" style="color:var(--primary-maroon);margin-right:5px;"></i>Order Type
                    </div>
                    <div id="omOrderType" style="font-size:14px;font-weight:600;color:var(--text-dark);"></div>
                </div>
                <div style="background:#fffcf8;border:1.5px solid #f3ebe0;border-radius:12px;padding:12px 14px;">
                    <div style="font-size:10px;font-weight:600;color:var(--muted-text);text-transform:uppercase;letter-spacing:.5px;margin-bottom:4px;">
                        <i class="fas fa-peso-sign" style="color:var(--primary-maroon);margin-right:5px;"></i>Total Amount
                    </div>
                    <div id="omAmount" style="font-size:18px;font-weight:700;color:var(--primary-maroon);"></div>
                </div>
                <div style="background:#fffcf8;border:1.5px solid #f3ebe0;border-radius:12px;padding:12px 14px;">
                    <div style="font-size:10px;font-weight:600;color:var(--muted-text);text-transform:uppercase;letter-spacing:.5px;margin-bottom:4px;">
                        <i class="fas fa-calendar" style="color:var(--primary-maroon);margin-right:5px;"></i>Date &amp; Time
                    </div>
                    <div id="omDate" style="font-size:13px;font-weight:600;color:var(--text-dark);"></div>
                </div>
            </div>

            <%-- Items section --%>
            <div style="background:#fffcf8;border:1.5px solid #f3ebe0;border-radius:12px;padding:14px 16px;margin-bottom:8px;">
                <div style="font-size:10px;font-weight:600;color:var(--muted-text);text-transform:uppercase;letter-spacing:.5px;margin-bottom:8px;">
                    <i class="fas fa-utensils" style="color:var(--primary-maroon);margin-right:5px;"></i>Order Items
                </div>
                <div id="omFirstItem" style="font-size:14px;font-weight:600;color:var(--text-dark);margin-bottom:4px;"></div>
                <div id="omMoreItems" style="font-size:12px;color:var(--muted-text);"></div>
            </div>

            <div class="modal-footer" style="margin-top:18px;">
                <button type="button" class="btn-modal-cancel" onclick="closeOrderModal()" style="flex:1;">Close</button>
            </div>
        </div>
    </div>

    <div class="toast" id="quotaToast"><i class="fas fa-check-circle"></i> Quotas saved successfully!</div>

    <script>
        var myRevenueChart = null;

        // ── Modal ──────────────────────────────────────────────────────────────
        function openQuotaModal()  { document.getElementById('quotaModal').classList.add('open'); }
        function closeQuotaModal() { document.getElementById('quotaModal').classList.remove('open'); }
        document.getElementById('quotaModal').addEventListener('click', function(e) {
            if (e.target === this) closeQuotaModal();
        });

        // ── Order Details Modal ────────────────────────────────────────────────
        function openOrderModal(el) {
            var ticket    = el.getAttribute('data-ticket')    || '';
            var customer  = el.getAttribute('data-customer')  || '';
            var ordertype = el.getAttribute('data-ordertype') || '';
            var amount    = el.getAttribute('data-amount')    || '0.00';
            var status    = el.getAttribute('data-status')    || '';
            var priority  = el.getAttribute('data-priority')  || '';
            var date      = el.getAttribute('data-date')      || '';
            var firstItem = el.getAttribute('data-firstitem') || '';
            var itemCount = parseInt(el.getAttribute('data-itemcount') || '0', 10);

            document.getElementById('omTicketNumber').textContent = ticket;
            document.getElementById('omCustomer').textContent     = customer;
            document.getElementById('omOrderType').textContent    = ordertype;
            document.getElementById('omAmount').textContent       = '₱' + amount;
            document.getElementById('omDate').textContent         = date;
            document.getElementById('omFirstItem').textContent    = firstItem;

            var moreEl = document.getElementById('omMoreItems');
            moreEl.textContent = itemCount > 1 ? '+' + (itemCount - 1) + ' more item(s)' : '';

            // Status badge
            var statusEl = document.getElementById('omStatusBadge');
            var statusMap = {
                'COMPLETED': 'badge-completed', 'DELIVERED': 'badge-completed',
                'PENDING':   'badge-pending',
                'IN PROGRESS': 'badge-progress',
                'CANCELLED': 'badge-cancelled'
            };
            statusEl.className = statusMap[status.toUpperCase()] || 'badge-pending';
            statusEl.textContent = status;

            // Priority badge
            var prioEl = document.getElementById('omPriorityBadge');
            prioEl.className  = priority.toUpperCase() === 'HIGH' ? 'priority-high' : 'priority-normal';
            prioEl.textContent = priority;

            document.getElementById('orderModal').classList.add('open');
        }

        function closeOrderModal() {
            document.getElementById('orderModal').classList.remove('open');
        }

        document.addEventListener('DOMContentLoaded', function () {
            document.getElementById('orderModal').addEventListener('click', function(e) {
                if (e.target === this) closeOrderModal();
            });
        });

        // ── Toast ──────────────────────────────────────────────────────────────
        function showToast() {
            var t = document.getElementById('quotaToast');
            t.classList.add('show');
            setTimeout(function() { t.classList.remove('show'); }, 3000);
        }

        // ── Quota bar ──────────────────────────────────────────────────────────
        function updateQuotaBar() {
            var hdn = document.getElementById('<%= hdnQuotaPct.ClientID %>');
            var bar = document.getElementById('quotaBarFill');
            if (!hdn || !bar) return;
            var pct = parseFloat(hdn.value) || 0;
            bar.style.width = Math.min(pct, 100) + '%';
            if (pct >= 100) bar.classList.add('over');
            else            bar.classList.remove('over');
        }

        // ── Check save result ─────────────────────────────────────────────────
        function checkQuotaSaved() {
            var hdn = document.getElementById('<%= hdnQuotaSaved.ClientID %>');
            if (hdn && hdn.value === '1') {
                closeQuotaModal();
                showToast();
                hdn.value = '0';
            }
        }

        // ── Revenue chart ─────────────────────────────────────────────────────
        function initDashboardChart() {
            var canvas = document.getElementById('revenueChart');
            if (!canvas) return;
            var ctx = canvas.getContext('2d');
            if (myRevenueChart) { myRevenueChart.destroy(); myRevenueChart = null; }

            var rawLabels = document.getElementById('<%= hdnChartLabels.ClientID %>').value;
            var rawData = document.getElementById('<%= hdnChartData.ClientID %>').value;
            var quotaTarget = parseFloat(document.getElementById('<%= hdnQuotaTarget.ClientID %>').value) || 0;

            var chartLabels = (rawLabels && rawLabels !== '[]') ? JSON.parse(rawLabels) : ['No Data'];
            var chartData = (rawData && rawData !== '[]') ? JSON.parse(rawData) : [0];
            var quotaLine = chartLabels.map(function () { return quotaTarget; });

            var gradient = ctx.createLinearGradient(0, 0, 0, 300);
            gradient.addColorStop(0, 'rgba(107,13,30,0.2)');
            gradient.addColorStop(1, 'rgba(107,13,30,0.0)');

            myRevenueChart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: chartLabels,
                    datasets: [
                        {
                            label: 'Revenue',
                            data: chartData,
                            borderColor: '#6b0d1e', borderWidth: 3,
                            backgroundColor: gradient, fill: true, tension: 0.4,
                            pointBackgroundColor: '#6b0d1e', pointBorderColor: '#fff',
                            pointBorderWidth: 2, pointRadius: 5, pointHoverRadius: 7
                        },
                        {
                            label: 'Quota Target',
                            data: quotaLine,
                            borderColor: '#7c3aed',
                            borderWidth: 2,
                            borderDash: [8, 5],
                            backgroundColor: 'transparent',
                            fill: false,
                            tension: 0,
                            pointRadius: 0,
                            pointHoverRadius: 4,
                            pointBackgroundColor: '#7c3aed'
                        }
                    ]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    onResize: function (chart, size) {
                        var small = size.width < 400;
                        chart.options.scales.x.ticks.maxTicksLimit = small ? 4 : 8;
                        chart.options.scales.y.ticks.maxTicksLimit = small ? 4 : 6;
                        chart.options.scales.x.ticks.font = { size: small ? 9 : 11, family: "'Poppins',sans-serif" };
                        chart.options.scales.y.ticks.font = { size: small ? 9 : 11, family: "'Poppins',sans-serif" };
                    },
                    plugins: {
                        legend: { display: false },
                        tooltip: {
                            backgroundColor: 'rgba(74,14,14,.9)',
                            padding: 10,
                            cornerRadius: 8,
                            titleFont: { size: 12, family: "'Poppins',sans-serif" },
                            bodyFont: { size: 12, family: "'Poppins',sans-serif" },
                            callbacks: {
                                label: function (c) {
                                    if (c.datasetIndex === 1) {
                                        return 'Daily target: ₱' + c.parsed.y.toLocaleString('en-PH', { minimumFractionDigits: 2 });
                                    }
                                    return 'Revenue: ₱' + c.parsed.y.toLocaleString('en-PH', { minimumFractionDigits: 2 });
                                },
                                afterBody: function (items) {
                                    var rev = null, target = null;
                                    items.forEach(function (i) {
                                        if (i.datasetIndex === 0) rev = i.parsed.y;
                                        if (i.datasetIndex === 1) target = i.parsed.y;
                                    });
                                    if (rev !== null && target !== null && target > 0) {
                                        var pct = ((rev / target) * 100).toFixed(1);
                                        return ['', pct + '% of daily target'];
                                    }
                                    return [];
                                }
                            }
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            grid: { color: '#f3ebe0', lineWidth: 1 },
                            border: { display: false },
                            ticks: {
                                color: '#8a6d6d',
                                maxTicksLimit: 6,
                                font: { size: 11, family: "'Poppins',sans-serif" },
                                callback: function (v) {
                                    return v >= 1000 ? '₱' + (v / 1000).toFixed(0) + 'k' : '₱' + v;
                                }
                            }
                        },
                        x: {
                            grid: { display: false },
                            border: { display: false },
                            ticks: {
                                color: '#8a6d6d',
                                maxTicksLimit: 8,
                                maxRotation: 0,
                                font: { size: 11, family: "'Poppins',sans-serif" }
                            }
                        }
                    }
                }
            });
        }

        // ── Boot ──────────────────────────────────────────────────────────────
        document.addEventListener('DOMContentLoaded', function () {
            initDashboardChart();
            updateQuotaBar();
            checkQuotaSaved();
        });

        // Reinit on window resize so chart fills new width
        var resizeTimer;
        window.addEventListener('resize', function () {
            clearTimeout(resizeTimer);
            resizeTimer = setTimeout(function () {
                initDashboardChart();
            }, 200);
        });

        if (typeof Sys !== 'undefined') {
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
                initDashboardChart();
                updateQuotaBar();
                checkQuotaSaved();
            });
        }
    </script>
</asp:Content>
