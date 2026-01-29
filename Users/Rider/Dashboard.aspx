<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Rider.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="TasteNet.Users.Rider.Dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /* Main Container to respect MasterPage padding */
        .dashboard-container {
            padding: 10px 20px;
            color: #333;
        }

        /* Top Bar Refinement */
        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .top-bar h1 {
            font-size: 22px;
            color: #8b0000;
            font-weight: 500;
            margin: 0;
        }

        .top-actions {
            display: flex;
            align-items: center;
            gap: 20px;
            color: #444;
        }

        /* Availability Card */
        .status-card {
            background: #fff;
            border-radius: 10px;
            padding: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border: 1px solid #eaeaea;
            margin-bottom: 20px;
        }

        .status-info strong {
            font-size: 16px;
            display: block;
        }

        .status-info small {
            color: #888;
            font-size: 13px;
        }

        /* The Exact Toggle Switch */
        .toggle-switch {
            width: 60px;
            height: 30px;
            background-color: #e4e4e4;
            border-radius: 50px;
            position: relative;
            cursor: pointer;
        }

        .toggle-knob {
            width: 24px;
            height: 24px;
            background: #fff;
            border-radius: 50%;
            position: absolute;
            top: 3px;
            left: 3px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 8px;
            font-weight: bold;
            color: #aaa;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }

        /* Stats Grid - Using Grid for perfect alignment */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 15px;
            margin-bottom: 20px;
        }

        .stat-card {
            background: #fff;
            border-radius: 10px;
            padding: 15px 20px;
            border: 1px solid #eaeaea;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .stat-label {
            font-size: 13px;
            color: #777;
            margin-bottom: 5px;
        }

        .stat-value {
            font-size: 22px;
            font-weight: 600;
            margin: 0;
        }

        .icon-circle {
            width: 35px;
            height: 35px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #fdfdfd;
            border: 1px solid #f0f0f0;
        }

        /* The Large "You're Offline" Box */
        .offline-hero {
            background: #f1f1f1;
            border-radius: 15px;
            padding: 60px 20px;
            text-align: center;
            border: 1px solid #e0e0e0;
        }

        .offline-hero .icon-lg {
            font-size: 50px;
            color: #666;
            margin-bottom: 10px;
        }

        .offline-hero h2 {
            font-size: 18px;
            margin: 10px 0;
            color: #222;
        }

        .offline-hero p {
            color: #777;
            font-size: 14px;
            margin-bottom: 20px;
        }

        .btn-online {
            background: #8b0000;
            color: white;
            border: none;
            padding: 12px 30px;
            border-radius: 6px;
            font-weight: 500;
            cursor: pointer;
        }

        /* Responsive Breakpoints */
        @media (max-width: 1100px) {
            .stats-grid { grid-template-columns: repeat(2, 1fr); }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="dashboard-container">
        <div class="top-bar">
            <h1>Delivery Dashboard</h1>
            <div class="top-actions">
                <span>🔔</span>
                <span>Logout ⮞</span>
            </div>
        </div>

        <div class="status-card">
            <div class="status-info">
                <strong>Availability Status</strong>
                <small>You are currently offline</small>
            </div>
            <div class="toggle-switch">
                <div class="toggle-knob">OFF</div>
            </div>
        </div>

        <div class="stats-grid">
            <div class="stat-card">
                <div>
                    <div class="stat-label">Total Deliveries</div>
                    <div class="stat-value">24</div>
                </div>
                <div class="icon-circle" style="color:#b00000; background: #fff5f5;">📦</div>
            </div>

            <div class="stat-card">
                <div>
                    <div class="stat-label">Earnings Today</div>
                    <div class="stat-value">$156.80</div>
                </div>
                <div class="icon-circle" style="color:#28a745; background: #f5fff8;">$</div>
            </div>

            <div class="stat-card">
                <div>
                    <div class="stat-label">Completed</div>
                    <div class="stat-value">22</div>
                </div>
                <div class="icon-circle" style="color:#28a745; background: #f5fff8;">✔</div>
            </div>

            <div class="stat-card">
                <div>
                    <div class="stat-label">Avg. Time</div>
                    <div class="stat-value">18 min</div>
                </div>
                <div class="icon-circle" style="color:#ff9800; background: #fffcf5;">🕒</div>
            </div>
        </div>

        <div class="offline-hero">
            <div class="icon-lg">🕒</div>
            <h2>You're Offline</h2>
            <p>Turn on your availability to start receiving delivery requests</p>
            <button type="button" class="btn-online">Go Online</button>
        </div>
    </div>
</asp:Content>