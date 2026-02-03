<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Rider.Master" AutoEventWireup="true" CodeBehind="DeliveryHistory.aspx.cs" Inherits="TasteNet.Users.Rider.DeliveryHistory" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

   <style>
/* ===== RESET ===== */
html, body, form {
    margin: 0;
    padding: 0;
    background: #f5f6f8;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

/* ===== CENTERED PAGE WRAPPER ===== */
.history-container {
    max-width: 1200px;        /* 🔥 controls UI size */
    margin: 0 auto;           /* 🔥 center horizontally */
    padding: 24px 20px;
}

/* ===== HEADER ===== */
.page-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 18px;
    color :#000000;
}

.page-header h2 {
    font-size: 20px;
    font-weight: 600;
    margin: 0;
}

/* ===== SUMMARY ===== */
.summary-row {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 16px;
    margin-bottom: 18px;
}

.summary-card {
    background: #fff;
    border-radius: 8px;
    padding: 14px 18px;
    border: 1px solid #e6e6e6;
    display: flex;
    justify-content: space-between;
    align-items: center;
    color :#000000;
}

.summary-card small {
    color: #888;
    font-size: 11px;
}

.summary-card h3 {
    margin: 4px 0 0;
    font-size: 20px;
}

/* ===== ORDER CARD ===== */
.order-card {
    background: #fff;
    border: 1px solid #e5e5e5;
    border-radius: 8px;
    padding: 14px 18px;
    margin-bottom: 10px;
    display: flex;
    justify-content: space-between;
}

/* LEFT */
.order-details {
    font-size: 12px;

}

.order-id {
    font-weight: 600;
    margin-bottom: 4px;
    color :#000000;

}

.order-time {
    font-size: 11px;
    color: #888;
    margin-bottom: 8px;
}

.address-row {
    display: flex;
    gap: 6px;
    margin-bottom: 6px;
    color: #000000;
}

.address-dot {
    width: 7px;
    height: 7px;
    border-radius: 50%;
    margin-top: 4px;
}

/* RIGHT */
.order-metrics {
    text-align: right;
    font-size: 12px;
    color: #000000;
}

.status-badge {
    font-size: 10px;
    padding: 3px 10px;
    border-radius: 20px;
    display: inline-block;
    margin-bottom: 6px;
}

.status-completed {
    background: #e6f7ec;
    color: #1b8a4b;
}

.status-cancelled {
    background: #fdecea;
    color: #c62828;
}

.metric-info small {
    display: block;
    color: #888;
}

.metric-info strong {
    color: #000000;
}

</style>


</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    
        <div class="history-container">

    
        <h1>Delivery History</h1>
        <select>
            <option>All Status</option>
            <option>Completed</option>
            <option>Cancelled</option>
        </select>
    

    <div class="summary-row">
        <div class="summary-card">
            <div>
                <small>Total Deliveries</small>
                <h3>156</h3>
            </div>
            📦
        </div>

        <div class="summary-card">
            <div>
                <small>Completed</small>
                <h3 style="color:#28a745;">152</h3>
            </div>
            ✔️
        </div>

        <div class="summary-card">
            <div>
                <small>Cancelled</small>
                <h3 style="color:#dc3545;">4</h3>
            </div>
            ⭕
        </div>
    </div>

    <!-- ORDER CARD -->
    <div class="order-card">
        <div class="order-details">
            <div class="order-id">Order #ORD-12345</div>
            <div class="order-time">2026-01-29 at 14:30</div>

            <div class="address-row">
                <span class="address-dot" style="background:#dc3545"></span>
                <div><strong>Pickup</strong><br />123 Restaurant St</div>
            </div>

            <div class="address-row">
                <span class="address-dot" style="background:#28a745"></span>
                <div><strong>Drop-off</strong><br />456 Customer Ave</div>
            </div>
        </div>

        <div class="order-metrics">
            <span class="status-badge status-completed">Completed</span>
            <div class="metric-info">
                <small>Distance</small>3.2 km
                <small>Earnings</small><strong>$8.50</strong>
            </div>
        </div>
    </div>
            <div class="order-card">
    <div class="order-details">
        <div class="order-id">Order #ORD-12345</div>
        <div class="order-time">2026-01-29 at 14:30</div>

        <div class="address-row">
            <span class="address-dot" style="background:#dc3545"></span>
            <div><strong>Pickup</strong><br />123 Restaurant St</div>
        </div>

        <div class="address-row">
            <span class="address-dot" style="background:#28a745"></span>
            <div><strong>Drop-off</strong><br />456 Customer Ave</div>
        </div>
    </div>

    <div class="order-metrics">
        <span class="status-badge status-completed">Completed</span>
        <div class="metric-info">
            <small>Distance</small>3.2 km
            <small>Earnings</small><strong>$8.50</strong>
        </div>
    </div>
</div>
            <div class="order-card">
    <div class="order-details">
        <div class="order-id">Order #ORD-12345</div>
        <div class="order-time">2026-01-29 at 14:30</div>

        <div class="address-row">
            <span class="address-dot" style="background:#dc3545"></span>
            <div><strong>Pickup</strong><br />123 Restaurant St</div>
        </div>

        <div class="address-row">
            <span class="address-dot" style="background:#28a745"></span>
            <div><strong>Drop-off</strong><br />456 Customer Ave</div>
        </div>
    </div>

    <div class="order-metrics">
        <span class="status-badge status-completed">Completed</span>
        <div class="metric-info">
            <small>Distance</small>3.2 km
            <small>Earnings</small><strong>$8.50</strong>
        </div>
    </div>
</div>
            <div class="order-card">
    <div class="order-details">
        <div class="order-id">Order #ORD-12345</div>
        <div class="order-time">2026-01-29 at 14:30</div>

        <div class="address-row">
            <span class="address-dot" style="background:#dc3545"></span>
            <div><strong>Pickup</strong><br />123 Restaurant St</div>
        </div>

        <div class="address-row">
            <span class="address-dot" style="background:#28a745"></span>
            <div><strong>Drop-off</strong><br />456 Customer Ave</div>
        </div>
    </div>

    <div class="order-metrics">
        <span class="status-badge status-completed">Completed</span>
        <div class="metric-info">
            <small>Distance</small>3.2 km
            <small>Earnings</small><strong>$8.50</strong>
        </div>
    </div>
</div>
</div>
</asp:Content>


