<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Rider.Master" AutoEventWireup="true" CodeBehind="Earnings.aspx.cs" Inherits="TasteNet.Users.Rider.Earnings" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

<style>
html, body, form {
    margin: 0;
    padding: 0;
    background: #f5f6f8;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

.wallet-container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 24px 20px;
}

/* HEADER */
.wallet-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 14px;
}

.wallet-header h2 {
    font-size: 20px;
    font-weight: 600;
}

.payout-btn {
    background: #9b0000;
    color: #fff;
    border: none;
    padding: 8px 14px;
    border-radius: 6px;
    font-size: 12px;
    cursor: pointer;
}

/* TOGGLE */
.toggle-row {
    margin-bottom: 14px;
}

.toggle-btn {
    font-size: 11px;
    padding: 4px 10px;
    border-radius: 12px;
    border: 1px solid #ddd;
    background: #fff;
    cursor: pointer;
}

.toggle-btn.active {
    background: #9b0000;
    color: #fff;
    border-color: #9b0000;
}

/* SUMMARY */
.summary-row {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 16px;
    margin-bottom: 16px;
}

.summary-card {
    background: #fff;
    border-radius: 8px;
    padding: 14px 18px;
    border: 1px solid #e5e5e5;
}

.summary-card small {
    font-size: 11px;
    color: #777;
}

.summary-card h3 {
    margin: 6px 0 4px;
    font-size: 18px;
}

.green { color: #1b8a4b; }
.orange { color: #ff9800; }

/* BOX SECTIONS */
.box {
    background: #fff;
    border-radius: 8px;
    border: 1px solid #e5e5e5;
    padding: 16px;
    margin-bottom: 16px;
}

.box-title {
    font-size: 13px;
    font-weight: 600;
    margin-bottom: 12px;
}

/* INCENTIVES */
.bonus-row {
    display: flex;
    justify-content: space-between;
    padding: 10px 0;
    border-bottom: 1px solid #eee;
    font-size: 12px;
}

.bonus-row:last-child {
    border-bottom: none;
}

.bonus-status {
    font-size: 10px;
    color: #888;
}

/* RECENT */
.earning-row {
    display: flex;
    justify-content: space-between;
    padding: 10px 0;
    border-bottom: 1px solid #eee;
    font-size: 12px;
}

.earning-row:last-child {
    border-bottom: none;
}

.earning-right {
    text-align: right;
}

.earning-right strong {
    color: #1b8a4b;
}
</style>


<div class="wallet-container">

    <div class="wallet-header">
        <h2>Earnings & Wallet</h2>
        <button class="payout-btn">Request Payout</button>
    </div>

    <div class="toggle-row">
        <button class="toggle-btn active">Daily</button>
        <button class="toggle-btn">Weekly</button>
    </div>

    <div class="summary-row">
        <div class="summary-card">
            <small>Total Earnings</small>
            <h3 class="green">$156.80</h3>
            <small>24 deliveries</small>
        </div>

        <div class="summary-card">
            <small>Average per Delivery</small>
            <h3>$6.50</h3>
            <small class="green">+8% from last week</small>
        </div>

        <div class="summary-card">
            <small>Available Balance</small>
            <h3 class="orange">$425.30</h3>
            <small>Ready for withdrawal</small>
        </div>
    </div>

    <div class="box">
        <div class="box-title">Incentives & Bonuses</div>

        <div class="bonus-row">
            <div>
                <strong>Peak Hour Bonus</strong><br />
                <span class="bonus-status">Active</span>
            </div>
            <strong class="green">+$15.00</strong>
        </div>

        <div class="bonus-row">
            <div>
                <strong>Weekend Boost</strong><br />
                <span class="bonus-status">Pending</span>
            </div>
            <strong class="green">+$20.00</strong>
        </div>
    </div>

    <div class="box">
        <div class="box-title">Recent Earnings</div>

        <div class="earning-row">
            <div>
                <strong>2026-01-29</strong><br />
                <small>24 deliveries</small>
            </div>
            <div class="earning-right">
                <strong>$156.80</strong>
                <small>Completed</small>
            </div>
        </div>

        <div class="earning-row">
            <div>
                <strong>2026-01-28</strong><br />
                <small>28 deliveries</small>
            </div>
            <div class="earning-right">
                <strong>$189.00</strong>
                <small>Completed</small>
            </div>
        </div>

        <div class="earning-row">
            <div>
                <strong>2026-01-27</strong><br />
                <small>22 deliveries</small>
            </div>
            <div class="earning-right">
                <strong>$148.50</strong>
                <small>Completed</small>
            </div>
        </div>
    </div>

</div>

</asp:Content>

