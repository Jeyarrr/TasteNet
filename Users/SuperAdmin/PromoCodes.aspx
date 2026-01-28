<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/SuperAdmin.Master" AutoEventWireup="true" CodeBehind="PromoCodes.aspx.cs" Inherits="TasteNet.Users.SuperAdmin.PromoCodes" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

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

        .promo-container {
            padding: 25px 35px;
        }

        .promo-header {
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

        .btn-create {
            background: var(--accent-yellow);
            color: var(--text-dark);
            border: none;
            border-radius: var(--radius-lg);
            padding: 16px 32px;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
            font-size: 16px;
            box-shadow: 0 4px 12px rgba(255, 204, 0, 0.2);
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .btn-create:hover {
            background: #e6b800;
            transform: translateY(-4px) scale(1.02);
            box-shadow: 0 8px 20px rgba(255, 204, 0, 0.3);
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
            position: relative;
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
            margin-bottom: 15px;
            font-size: 18px;
            transition: transform 0.3s ease;
        }

        .kpi-card:hover .kpi-icon {
            transform: scale(1.1) rotate(5deg);
        }

        .kpi-label {
            font-size: 14px;
            color: var(--muted-text);
            font-weight: 600;
            position: absolute;
            top: 25px;
            right: 25px;
            background: #f9f4ee;
            padding: 6px 12px;
            border-radius: 12px;
        }

        .kpi-value {
            font-size: 32px;
            font-weight: 800;
            color: var(--primary-maroon);
            letter-spacing: -0.5px;
        }

        .promo-section-title {
            color: var(--primary-maroon);
            font-weight: 700;
            margin: 30px 0 25px;
            font-size: 24px;
            letter-spacing: -0.3px;
        }

        .promo-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 30px;
            margin-bottom: 40px;
        }

        .promo-card {
            background: white;
            border-radius: var(--radius-2xl);
            padding: 30px;
            box-shadow: var(--card-shadow);
            position: relative;
            transition: all 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
            border: 2px solid transparent;
        }

        .promo-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--hover-shadow);
            border-color: rgba(107, 13, 30, 0.1);
        }

        .promo-badge-header {
            display: flex;
            gap: 12px;
            align-items: center;
            margin-bottom: 20px;
        }

        .code-pill {
            background: var(--primary-maroon);
            color: white;
            padding: 8px 16px;
            border-radius: var(--radius-lg);
            font-weight: 700;
            font-size: 15px;
            box-shadow: 0 4px 8px rgba(107, 13, 30, 0.2);
            transition: transform 0.3s ease;
        }

        .promo-card:hover .code-pill {
            transform: scale(1.05);
        }

        .status-pill {
            background: #E6F2ED;
            color: var(--success-green);
            padding: 6px 14px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 700;
            letter-spacing: 0.5px;
        }

        .promo-badge-header i {
            margin-left: auto;
            color: var(--muted-text);
            font-size: 18px;
            cursor: pointer;
            padding: 8px;
            border-radius: 10px;
            background: #f9f4ee;
            transition: all 0.3s ease;
        }

        .promo-badge-header i:hover {
            color: var(--primary-maroon);
            background: #f3ebe0;
            transform: scale(1.1);
        }

        .promo-card b {
            color: var(--primary-maroon);
            font-size: 18px;
            font-weight: 700;
            display: block;
            margin-bottom: 8px;
        }

        .promo-card p.small {
            color: var(--muted-text);
            font-size: 14px;
            line-height: 1.5;
            margin-bottom: 20px;
        }

        .discount-box {
            background: var(--accent-yellow);
            width: fit-content;
            padding: 12px 24px;
            border-radius: var(--radius-lg);
            font-weight: 800;
            font-size: 24px;
            margin: 20px 0;
            box-shadow: 0 4px 12px rgba(255, 204, 0, 0.2);
            transition: transform 0.3s ease;
        }

        .promo-card:hover .discount-box {
            transform: scale(1.05);
        }

        .promo-stats-bar {
            display: flex;
            justify-content: space-between;
            background: #FEF9F0;
            padding: 18px;
            border-radius: var(--radius-lg);
            margin: 20px 0;
            border: 2px solid #f3ebe0;
        }

        .stat-group {
            display: flex;
            flex-direction: column;
            transition: transform 0.3s ease;
        }

        .promo-card:hover .stat-group {
            transform: translateY(-2px);
        }

        .stat-label {
            font-size: 12px;
            color: var(--muted-text);
            font-weight: 600;
            margin-bottom: 4px;
            letter-spacing: 0.3px;
        }

        .stat-value {
            font-size: 16px;
            font-weight: 700;
            color: var(--text-dark);
        }

        .progress-line {
            height: 6px;
            background: #e2d1d1;
            border-radius: 3px;
            width: 100%;
            margin-top: 8px;
            overflow: hidden;
        }

        .progress-fill {
            height: 100%;
            background: var(--success-green);
            border-radius: 3px;
            transition: width 0.5s ease;
        }

        .small.text-muted.mb-3 {
            color: var(--muted-text) !important;
            font-size: 14px;
            padding: 10px 15px;
            background: #f9f4ee;
            border-radius: var(--radius-lg);
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s ease;
        }

        .promo-card:hover .small.text-muted.mb-3 {
            background: #f3ebe0;
            transform: translateX(5px);
        }

        .promo-actions {
            display: flex;
            gap: 15px;
            border-top: 2px solid #f3ebe0;
            padding-top: 20px;
            margin-top: 20px;
        }

        .btn-action {
            flex: 1;
            padding: 14px;
            border-radius: var(--radius-lg);
            font-size: 14px;
            font-weight: 600;
            text-align: center;
            text-decoration: none !important;
            transition: all 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            border: 2px solid transparent;
        }

        .btn-action:hover {
            transform: translateY(-3px) scale(1.05);
        }

        .btn-edit {
            background: var(--primary-maroon);
            color: white !important;
            box-shadow: 0 4px 12px rgba(107, 13, 30, 0.2);
        }

        .btn-edit:hover {
            background: #5a0b19;
            box-shadow: 0 6px 18px rgba(107, 13, 30, 0.3);
        }

        .btn-view {
            border: 2px solid var(--primary-maroon);
            color: var(--primary-maroon) !important;
            background: white;
        }

        .btn-view:hover {
            background: var(--primary-maroon);
            color: white !important;
            box-shadow: 0 4px 12px rgba(107, 13, 30, 0.2);
        }

        .btn-deactivate {
            flex: 0.5;
            border: 2px solid #e2d1d1;
            color: var(--muted-text) !important;
            background: white;
        }

        .btn-deactivate:hover {
            border-color: #d97706;
            color: #d97706 !important;
            background: #fff9e6;
        }

        .suggested-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 30px;
            margin-bottom: 30px;
        }

        .suggested-card {
            border: 2px dashed #D48C70;
            background: transparent;
            border-radius: var(--radius-2xl);
            padding: 30px;
            transition: all 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
        }

        .suggested-card:hover {
            transform: translateY(-5px);
            border-color: var(--primary-maroon);
            box-shadow: var(--card-shadow);
            background: rgba(255, 255, 255, 0.8);
        }

        .suggested-card h4 {
            color: var(--primary-maroon);
            font-weight: 700;
            font-size: 18px;
            margin-bottom: 10px;
            letter-spacing: -0.2px;
        }

        .suggested-card p.small {
            color: var(--muted-text);
            font-size: 14px;
            line-height: 1.5;
            margin-bottom: 20px;
        }

        .d-flex.gap-4 {
            gap: 25px !important;
            margin: 25px 0;
        }

        .btn-create-campaign {
            width: 100%;
            border: 2px solid var(--primary-maroon);
            background: white;
            color: var(--primary-maroon);
            padding: 16px;
            border-radius: var(--radius-lg);
            font-weight: 600;
            font-size: 15px;
            cursor: pointer;
            transition: all 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }

        .btn-create-campaign:hover {
            background: var(--primary-maroon);
            color: white;
            transform: translateY(-3px) scale(1.02);
            box-shadow: 0 6px 18px rgba(107, 13, 30, 0.2);
        }

        @keyframes gentlePulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
        }

        .kpi-value {
            animation: gentlePulse 3s infinite;
        }

        @media (max-width: 1200px) {
            .promo-grid,
            .suggested-grid {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 992px) {
            .promo-header {
                flex-direction: column;
                gap: 20px;
                align-items: flex-start;
            }
            
            .kpi-row {
                grid-template-columns: repeat(3, 1fr);
            }
        }

        @media (max-width: 768px) {
            .promo-container {
                padding: 15px;
            }
            
            .kpi-row {
                grid-template-columns: repeat(2, 1fr);
            }
            
            .promo-actions {
                flex-direction: column;
            }
            
            .btn-action {
                width: 100%;
            }
            
            .btn-deactivate {
                flex: 1;
            }
        }

        @media (max-width: 576px) {
            .kpi-row {
                grid-template-columns: 1fr;
            }
            
            .promo-card,
            .suggested-card {
                padding: 20px;
            }
            
            .d-flex.gap-4 {
                flex-direction: column;
                gap: 15px !important;
            }
            
            .header-info h2 {
                font-size: 28px;
            }
        }
    </style>

    <div class="promo-container">
        <div class="promo-header">
            <div class="header-info">
                <h2>Promotions & Campaigns</h2>
                <p>Manage promo codes and marketing campaigns</p>
            </div>
            <button type="button" class="btn-create"><i class="fas fa-plus me-2"></i>Create New Promotion</button>
        </div>

        <div class="kpi-row">
            <div class="kpi-card">
                <div class="kpi-icon" style="background:#FFF9E6; color:var(--accent-yellow);"><i class="fas fa-bullhorn"></i></div>
                <span class="kpi-label">Active Promos</span>
                <div class="kpi-value">4</div>
            </div>
            <div class="kpi-card">
                <div class="kpi-icon" style="background:#E6F2ED; color:var(--success-green);"><i class="fas fa-users"></i></div>
                <span class="kpi-label">Total Uses</span>
                <div class="kpi-value">480</div>
            </div>
            <div class="kpi-card">
                <div class="kpi-icon" style="background:#F9E6E9; color:var(--primary-maroon);"><i class="fas fa-peso-sign"></i></div>
                <span class="kpi-label">Revenue Generated</span>
                <div class="kpi-value">₱111K</div>
            </div>
            <div class="kpi-card">
                <div class="kpi-icon" style="background:#E6F0F9; color:#3498db;"><i class="fas fa-clock"></i></div>
                <span class="kpi-label">Expiring Soon</span>
                <div class="kpi-value">2</div>
            </div>
        </div>

        <h3 class="promo-section-title">Active Promotions</h3>
        <div class="promo-grid">
            <div class="promo-card">
                <div class="promo-badge-header">
                    <span class="code-pill">SILOG20</span>
                    <span class="status-pill">ACTIVE</span>
                    <i class="far fa-copy ms-auto"></i>
                </div>
                <b>20% Off All Silog Meals</b>
                <p class="small text-muted mb-2">Get 20% discount on all silog meal orders</p>
                <div class="discount-box">20%</div>
                <div class="promo-stats-bar">
                    <div class="stat-group" style="flex: 1.5;">
                        <span class="stat-label">Usage</span>
                        <span class="stat-value">45/100</span>
                        <div class="progress-line"><div class="progress-fill" style="width: 45%;"></div></div>
                    </div>
                    <div class="stat-group">
                        <span class="stat-label">Revenue</span>
                        <span class="stat-value">₱12,450</span>
                    </div>
                    <div class="stat-group">
                        <span class="stat-label">Avg Order</span>
                        <span class="stat-value">₱278</span>
                    </div>
                </div>
                <div class="small text-muted mb-3"><i class="far fa-calendar-alt me-1"></i> Valid until Nov 30, 2025</div>
                <div class="promo-actions">
                    <a href="#" class="btn-action btn-edit"><i class="far fa-edit me-1"></i> Edit</a>
                    <a href="#" class="btn-action btn-view">View Analytics</a>
                    <a href="#" class="btn-action btn-deactivate">Deactivate</a>
                </div>
            </div>

            <div class="promo-card">
                <div class="promo-badge-header">
                    <span class="code-pill">SIZZLE50</span>
                    <span class="status-pill">ACTIVE</span>
                    <i class="far fa-copy ms-auto"></i>
                </div>
                <b>₱50 Off Sizzling Plates</b>
                <p class="small text-muted mb-2">Fixed ₱50 discount on sizzling plate orders above ₱300</p>
                <div class="discount-box">₱50</div>
                <div class="promo-stats-bar">
                    <div class="stat-group" style="flex: 1.5;">
                        <span class="stat-label">Usage</span>
                        <span class="stat-value">78/150</span>
                        <div class="progress-line"><div class="progress-fill" style="width: 52%;"></div></div>
                    </div>
                    <div class="stat-group">
                        <span class="stat-label">Revenue</span>
                        <span class="stat-value">₱18,920</span>
                    </div>
                    <div class="stat-group">
                        <span class="stat-label">Avg Order</span>
                        <span class="stat-value">₱243</span>
                    </div>
                </div>
                <div class="small text-muted mb-3"><i class="far fa-calendar-alt me-1"></i> Valid until Nov 28, 2025</div>
                <div class="promo-actions">
                    <a href="#" class="btn-action btn-edit"><i class="far fa-edit me-1"></i> Edit</a>
                    <a href="#" class="btn-action btn-view">View Analytics</a>
                    <a href="#" class="btn-action btn-deactivate">Deactivate</a>
                </div>
            </div>
        </div>

        <h3 class="promo-section-title">Suggested Campaign Ideas</h3>
        <div class="suggested-grid">
            <div class="suggested-card">
                <h4>Silog Saturday Special</h4>
                <p class="small text-muted">Weekly promotion for all Silog meals every Saturday</p>
                <div class="d-flex gap-4 mt-3">
                    <div><span class="stat-label">Suggested Discount</span><div class="discount-box" style="font-size: 20px; padding: 8px 16px;">25%</div></div>
                    <div><span class="stat-label">Target Audience</span><div class="stat-value mt-1">All customers</div></div>
                </div>
                <button type="button" class="btn-create-campaign"><i class="fas fa-plus me-2"></i>Create Campaign</button>
            </div>
            <div class="suggested-card">
                <h4>Sizzling Weekday Deals</h4>
                <p class="small text-muted">Monday to Friday exclusive deals on sizzling plates</p>
                <div class="d-flex gap-4 mt-3">
                    <div><span class="stat-label">Suggested Discount</span><div class="discount-box" style="font-size: 20px; padding: 8px 16px;">₱100 off</div></div>
                    <div><span class="stat-label">Target Audience</span><div class="stat-value mt-1">Returning customers</div></div>
                </div>
                <button type="button" class="btn-create-campaign"><i class="fas fa-plus me-2"></i>Create Campaign</button>
            </div>
        </div>
    </div>
</asp:Content>