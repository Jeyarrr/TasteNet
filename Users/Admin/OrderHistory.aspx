<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Admin.Master" AutoEventWireup="true" CodeBehind="OrderHistory.aspx.cs" Inherits="TasteNet.Users.Admin.OrderHistory" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

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
    --danger-red: #b91c1c;
    --danger-red-light: #fee2e2;
    --accent-yellow: #ffcc00;
    --accent-yellow-dark: #e6b800;
    --accent-yellow-light: #fff9e6;
    --accent-pink: #f9ecee;
    --accent-blue: #eff6ff;
    
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
    
    --transition-fast: 0.2s ease;
    --transition-base: 0.3s ease;
    --transition-slow: 0.4s ease;
}

html, body {
    margin: 0;
    padding: 0;
    width: 100%;
    height: 100%;
    background-color: var(--soft-cream) !important;

}
 .order-history-container {

    max-width: none;
    margin: 0;
    color: #000;
    
}

.page-header h2 {
    color: #9b0000;
    margin-bottom: 4px;
}

.page-header p {
    font-size: 13px;
    color: #666;
}

/* Filters */
.filters {
    display: flex;
    gap: 10px;
    margin: 20px 0;
}

.filters select,
.filters input {
    padding: 8px 10px;
    border-radius: 6px;
    border: 1px solid #ccc;
    font-size: 13px;
}

/* Summary Cards */
.summary-cards {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 15px;
    margin-bottom: 25px;
}

.summary-card {
    background: #fff;
    padding: 18px;
    border-radius: 10px;
    border: 1px solid #eee;
}

.summary-card p {
    font-size: 12px;
    color: #666;
}

.summary-card h3 {
    font-size: 24px;
    margin-top: 5px;
}

.green { color: green; }
.red { color: #c00000; }

/* Table */
.table-card {
    background: #fff;
    border-radius: 10px;
    border: 1px solid #eee;
    overflow: hidden;
}

table {
    width: 100%;
    border-collapse: collapse;
    font-size: 13px;
}

thead {
    background: #f5f5f5;
}

th, td {
    padding: 12px;
    text-align: left;
    border-bottom: 1px solid #eee;
}

/* Status */
.status {
    padding: 4px 10px;
    border-radius: 12px;
    font-size: 11px;
}

.status.completed {
    background: #e0f5e8;
    color: #0a8f3c;
}

.status.cancelled {
    background: #fde0e0;
    color: #b00000;
}

 </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <div class="order-history-container">

    <!-- Header -->
    <div class="page-header">
        <h2>Order History</h2>
        <p>View past orders and analytics</p>
    </div>

    <!-- Filters -->
    <div class="filters">
        <select>
            <option>All Status</option>
            <option>Completed</option>
            <option>Cancelled</option>
        </select>

        <select>
            <option>Today</option>
            <option>This Week</option>
            <option>This Month</option>
        </select>

        <input type="text" placeholder="Search Order ID or Name">
    </div>

    <!-- Summary Cards -->
    <div class="summary-cards">
        <div class="summary-card">
            <p>Total Orders</p>
            <h3>128</h3>
        </div>
        <div class="summary-card">
            <p>Completed</p>
            <h3 class="green">110</h3>
        </div>
        <div class="summary-card">
            <p>Cancelled</p>
            <h3 class="red">18</h3>
        </div>
    </div>

    <!-- Orders Table -->
    <div class="table-card">
        <table>
            <thead>
                <tr>
                    <th>Order ID</th>
                    <th>Customer</th>
                    <th>Type</th>
                    <th>Date</th>
                    <th>Total</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>#00123</td>
                    <td>Jay-r Reyes</td>
                    <td>Delivery</td>
                    <td>Feb 2, 2026</td>
                    <td>₱350</td>
                    <td><span class="status completed">Completed</span></td>
                </tr>
                <tr>
                    <td>#00124</td>
                    <td>Lalaine Gomez</td>
                    <td>Dine-in</td>
                    <td>Feb 2, 2026</td>
                    <td>₱420</td>
                    <td><span class="status completed">Completed</span></td>
                </tr>
                <tr>
                    <td>#00125</td>
                    <td>George Luna</td>
                    <td>Dine-in</td>
                    <td>Feb 1, 2026</td>
                    <td>₱280</td>
                    <td><span class="status cancelled">Cancelled</span></td>
                </tr>
            </tbody>
        </table>
    </div>

</div>

</asp:Content>
