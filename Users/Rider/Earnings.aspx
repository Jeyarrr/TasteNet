<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Rider.Master" AutoEventWireup="true" CodeBehind="Earnings.aspx.cs" Inherits="TasteNet.Users.Rider.Earnings" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

 <style>
 .wallet-container {
  font-family: 'Segoe UI', sans-serif;
  padding: 25px;
  background: #f5f6fa;
}

.wallet-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 15px;
}

.wallet-header h2 {
    font-weight: 600;
    color: #000000;
}

.btn-payout {
    background: #b31217;
    color: white;
    border: none;
    padding: 8px 15px;
    border-radius: 6px;
    cursor: pointer;
    font-size: 13px;
}

.toggle {
    margin-bottom: 20px;
}

.toggle button {
    border: none;
    padding: 6px 14px;
    margin-right: 5px;
    border-radius: 15px;
    background: #e0e0e0;
    cursor: pointer;
}

.toggle .active {
    background: #b31217;
    color: white;
}

.cards {
    display: flex;
    gap: 15px;
    margin-bottom: 20px;
}

.card {
    flex: 1;
    background: white;
    padding: 18px;
    border-radius: 10px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.05);
}

.card-title {
    font-size: 13px;
    color: #777;
    margin-bottom: 5px;
}

.card h3 {
    margin: 0;
    color: #0a8f3c;
}

.section {
    background: white;
    padding: 18px;
    border-radius: 10px;
    margin-bottom: 20px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.05);
}

.section h4 {
    margin-bottom: 15px;
    color: #000000;
}

.section p {
    margin-bottom: 15px;
    color: #000000;
}
.bonus-row,
.earn-row {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 10px 0;
    border-bottom: 1px solid #eee;
}

.bonus-row:last-child,
.earn-row:last-child {
    border-bottom: none;
}

.amount {
    color: #0a8f3c;
    font-weight: 600;
}

small {
    color: #888;
    font-size: 12px;
}

</style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
  <div class="wallet-container">

    <!-- Header -->
    <div class="wallet-header">
        <h2 class="header-h2">Earnings & Wallet</h2>
        <button class="btn-payout">Request Payout</button>
    </div>

    <!-- Toggle -->
    <div class="toggle">
        <button class="active">Daily</button>
        <button>Weekly</button>
    </div>

    <!-- Summary Cards -->
    <div class="cards">
        <div class="card">
            <p class="card-title">Total Earnings</p>
            <h3>$156.80</h3>
            <span>24 deliveries</span>
        </div>

        <div class="card">
            <p class="card-title">Average per Delivery</p>
            <h3>$6.50</h3>
            <span>↑ 8% from last week</span>
        </div>

        <div class="card">
            <p class="card-title">Available Balance</p>
            <h3>$425.30</h3>
            <span>Ready for withdrawal</span>
        </div>
    </div>

    <!-- Incentives -->
    <div class="section">
        <h4 class="h4">Incentives & Bonuses</h4>

        <div class="bonus-row">
            <div>
                <p class="p">Peak Hour Bonus</p>
                <small>Active</small>
            </div>
            <span class="amount">+$15.00</span>
        </div>

        <div class="bonus-row">
            <div>
                <p class="p">Weekend Boost</p>
                <small>Pending</small>
            </div>
            <span class="amount">+$20.00</span>
        </div>
    </div>

    <!-- Recent Earnings -->
    <div class="section">
        <h4>Recent Earnings</h4>

        <div class="earn-row">
            <div>
                <p>2026-01-29</p>
                <small>24 deliveries</small>
            </div>
            <span class="amount">$156.80</span>
        </div>

        <div class="earn-row">
            <div>
                <p>2026-01-28</p>
                <small>28 deliveries</small>
            </div>
            <span class="amount">$189.00</span>
        </div>

        <div class="earn-row">
            <div>
                <p>2026-01-27</p>
                <small>22 deliveries</small>
            </div>
            <span class="amount">$148.50</span>
        </div>

        <div class="earn-row">
            <div>
                <p>2026-01-26</p>
                <small>25 deliveries</small>
            </div>
            <span class="amount">$175.20</span>
        </div>

        <div class="earn-row">
            <div>
                <p>2026-01-25</p>
                <small>30 deliveries</small>
            </div>
            <span class="amount">$201.00</span>
        </div>
    </div>

</div>
</asp:Content>
