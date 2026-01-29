<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Rider.Master" AutoEventWireup="true" CodeBehind="DeliveryHistory.aspx.cs" Inherits="TasteNet.Users.Rider.DeliveryHistory" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>
        .history-container {
            padding: 20px;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f8f9fa;
        }

        /* Page Header */
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .page-header h2 {
            font-size: 18px;
            color: #333;
            font-weight: 500;
        }

        .filter-dropdown {
            padding: 6px 12px;
            border-radius: 20px;
            border: 1px solid #ddd;
            font-size: 13px;
            background: white;
            color: #555;
        }

        /* Summary Row */
        .summary-row {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            margin-bottom: 30px;
        }

        .summary-card {
            background: #fff;
            padding: 15px 20px;
            border-radius: 10px;
            border: 1px solid #eee;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .summary-card small {
            color: #888;
            font-size: 11px;
            display: block;
        }

        .summary-card h3 {
            margin: 5px 0 0;
            font-size: 20px;
        }

        /* Order Cards List */
        .order-card {
            background: #fff;
            border-radius: 10px;
            border: 1px solid #eee;
            padding: 15px 20px;
            margin-bottom: 12px;
            display: flex;
            justify-content: space-between;
            transition: transform 0.2s;
        }

        .order-card:hover {
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        }

        /* Left Side: Order Info */
        .order-details {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .order-id {
            font-weight: 600;
            font-size: 14px;
            margin: 0;
        }

        .order-time {
            font-size: 11px;
            color: #999;
        }

        .address-row {
            display: flex;
            align-items: flex-start;
            gap: 10px;
            font-size: 12px;
            margin-top: 5px;
        }

        .address-dot {
            width: 8px;
            height: 8px;
            border-radius: 50%;
            margin-top: 4px;
        }

        /* Right Side: Status & Metrics */
        .order-metrics {
            text-align: right;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .status-badge {
            font-size: 10px;
            padding: 3px 10px;
            border-radius: 12px;
            display: inline-block;
            font-weight: 500;
        }

        .status-completed { background: #e8f5e9; color: #2e7d32; }
        .status-cancelled { background: #ffebee; color: #c62828; }

        .metric-info {
            font-size: 12px;
            color: #666;
            margin-top: 10px;
        }

        .metric-info strong {
            display: block;
            font-size: 14px;
            color: #2e7d32; /* Green for earnings */
        }
        
        .metric-info .cancelled-amt { color: #333; }

        /* Icons placeholder */
        .icon-sm { width: 18px; text-align: center; }

    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="history-container">
        
        <div class="page-header">
            <h2>Delivery History</h2>
            <select class="filter-dropdown">
                <option>All Status</option>
                <option>Completed</option>
                <option>Cancelled</option>
            </select>
        </div>

        <div class="summary-row">
            <div class="summary-card">
                <div>
                    <small>Total Deliveries</small>
                    <h3 style="color: #333;">156</h3>
                </div>
                <div style="color: #b00000;">📦</div>
            </div>
            <div class="summary-card">
                <div>
                    <small>Completed</small>
                    <h3 style="color: #28a745;">152</h3>
                </div>
                <div style="color: #28a745;">✔️</div>
            </div>
            <div class="summary-card">
                <div>
                    <small>Cancelled</small>
                    <h3 style="color: #dc3545;">4</h3>
                </div>
                <div style="color: #dc3545;">⭕</div>
            </div>
        </div>

        <div class="order-card">
            <div class="order-details">
                <p class="order-id">Order #ORD-12345</p>
                <span class="order-time">2026-01-29 at 14:30</span>
                <div class="address-row">
                    <span class="address-dot" style="background: #dc3545;"></span>
                    <div><strong>Pickup</strong><br /><small>123 Restaurant St</small></div>
                </div>
                <div class="address-row">
                    <span class="address-dot" style="background: #28a745;"></span>
                    <div><strong>Drop-off</strong><br /><small>456 Customer Ave</small></div>
                </div>
            </div>
            <div class="order-metrics">
                <div><span class="status-badge status-completed">Completed</span></div>
                <div class="metric-info">
                    <small>Distance</small> 3.2 km<br />
                    <small>Earnings</small> <strong>$8.50</strong>
                </div>
            </div>
        </div>

        <div class="order-card">
            <div class="order-details">
                <p class="order-id">Order #ORD-12342</p>
                <span class="order-time">2026-01-29 at 11:20</span>
                <div class="address-row">
                    <span class="address-dot" style="background: #dc3545;"></span>
                    <div><strong>Pickup</strong><br /><small>999 Diner Road</small></div>
                </div>
                <div class="address-row">
                    <span class="address-dot" style="background: #28a745;"></span>
                    <div><strong>Drop-off</strong><br /><small>111 Park Lane</small></div>
                </div>
            </div>
            <div class="order-metrics">
                <div><span class="status-badge status-cancelled">Cancelled</span></div>
                <div class="metric-info">
                    <small>Distance</small> 4.5 km<br />
                    <small>Earnings</small> <strong class="cancelled-amt">$0.00</strong>
                </div>
            </div>
        </div>

        <div class="order-card">
            <div class="order-details">
                <p class="order-id">Order #ORD-12341</p>
                <span class="order-time">2026-01-28 at 18:45</span>
                <div class="address-row">
                    <span class="address-dot" style="background: #dc3545;"></span>
                    <div><strong>Pickup</strong><br /><small>222 Pizza Place</small></div>
                </div>
                <div class="address-row">
                    <span class="address-dot" style="background: #28a745;"></span>
                    <div><strong>Drop-off</strong><br /><small>333 Main Blvd</small></div>
                </div>
            </div>
            <div class="order-metrics">
                <div><span class="status-badge status-completed">Completed</span></div>
                <div class="metric-info">
                    <small>Distance</small> 3.9 km<br />
                    <small>Earnings</small> <strong>$9.50</strong>
                </div>
            </div>
        </div>

    </div>
</asp:Content>


