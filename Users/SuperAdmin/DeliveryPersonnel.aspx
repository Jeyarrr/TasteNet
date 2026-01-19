<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/SuperAdmin.Master" AutoEventWireup="true" CodeBehind="DeliveryPersonnel.aspx.cs" Inherits="TasteNet.Users.SuperAdmin.DeliveryPersonnel" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <!DOCTYPE html>
<html lang="en">
<head>

    <meta charset="UTF-8">
    <title>Delivery Personnel Management</title>
    <style>
        /* GLOBAL */
* {
    box-sizing: border-box;
    font-family: "Segoe UI", Tahoma, sans-serif;
}

body {
    margin: 0;
    background-color: #FFF7ED; /* light cream like image */
    color: #333;
}

/* TOP HEADER */
.header {
    display: flex;
    align-items: center;
    padding: 14px 30px;
    background: #FFFFFF;
    border-bottom: 1px solid #E5E7EB;
}

.logo {
    font-size: 20px;
    font-weight: 700;
    color: #B91C1C;
    flex: 1;
}

.global-search {
    width: 320px;
    padding: 8px 12px;
    border-radius: 8px;
    border: 1px solid #D1D5DB;
}

.admin-info {
    display: flex;
    align-items: center;
    gap: 15px;
    margin-left: 20px;
}

.admin-name {
    font-size: 16px;
    font-weight: 700;
    color: #000; 

}
/* PAGE HEADER */
.page-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 25px 30px 10px;
}

.page-header h1 {
    margin: 0;
    font-size: 26px;
    font-weight: 700;
    color: #000; 

}

.page-header p {
    margin-top: 5px;
    font-size: 14px;
    color: #6B7280;
}

/* BUTTONS */
.btn {
    padding: 10px 18px;
    border-radius: 8px;
    border: none;
    cursor: pointer;
    font-weight: 600;
    font-size: 14px;
}

.btn-yellow {
    background-color: #FACC15;
    color: #000;
}

.btn-red {
    background-color: #991B1B;
    color: #FFF;
}

/* STAT CARDS */
.stats {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 20px;
    padding: 20px 30px;
}

.card {
    background: #FFFFFF;
    padding: 20px;
    border-radius: 12px;
    box-shadow: 0 1px 4px rgba(0,0,0,0.05);
}

.card span {
    font-size: 13px;
    color: #6B7280;
}

.card h2 {
    margin: 10px 0 0;
    font-size: 32px;
    color: #991B1B;
}

/* FILTERS */
.filters {
    display: flex;
    gap: 12px;
    padding: 10px 30px 20px;
}

.filters input,
.filters select {
    padding: 9px 12px;
    border-radius: 8px;
    border: 1px solid #D1D5DB;
    font-size: 14px;
}

/* TABLE */
.table-container {
    padding: 0 30px 30px;
}

table {
    width: 100%;
    border-collapse: collapse;
    background: #FFFFFF;
    border-radius: 12px;
    overflow: hidden;
}

thead {
    background-color: #FEF3C7;
}

th {
    padding: 14px;
    font-size: 13px;
    font-weight: 700;
    color: #374151;
}

td {
    padding: 14px;
    font-size: 14px;
     color: #000;
}
}

tbody tr {
    border-bottom: 1px solid #E5E7EB;
}

/* STATUS BADGES */
.status {
    padding: 4px 12px;
    border-radius: 999px;
    font-size: 11px;
    font-weight: 700;
    display: inline-block;
}

.available {
    background-color: #DCFCE7;
    color: #15803D;
}

.delivery {
    background-color: #FEF3C7;
    color: #B45309;
}

.offline {
    background-color: #E5E7EB;
    color: #6B7280;
}

/* ACTION ICONS */
.actions {
    font-size: 16px;
    cursor: pointer;
}


    </style>

</head>
<body>

    <!-- HEADER -->
    <header class="header">
        <h2 class="logo">Delivery Personnel</h2>

        <input type="text" class="global-search" placeholder="Search orders, restaurants, users...">

        <div class="admin-info">
            <span class="notification">🔔</span>
            <span class="admin-name">Admin User</span>
        </div>
    </header>

    <!-- PAGE HEADER -->
    <section class="page-header">
        <div>
            <h1>Delivery Personnel Management</h1>
            <p>Manage riders and delivery staff</p>
        </div>
        <div class="header-actions">
            <button class="btn btn-yellow">+ Add Rider</button>
            <button class="btn btn-red">Assign Orders</button>
        </div>
    </section>

    <!-- DASHBOARD CARDS -->
    <section class="stats">
        <div class="card">
            <span>Total Active Riders</span>
            <h2>7</h2>
        </div>
        <div class="card">
            <span>Available Now</span>
            <h2>3</h2>
        </div>
        <div class="card">
            <span>On Delivery</span>
            <h2>2</h2>
        </div>
        <div class="card">
            <span>Active Orders</span>
            <h2>6</h2>
        </div>
    </section>

    <!-- FILTERS -->
    <section class="filters">
        <input type="text" placeholder="Search by name, ID, or contact number...">
        <select>
            <option>All Status</option>
        </select>
        <select>
            <option>All Vehicles</option>
        </select>
        <select>
            <option>Sort by: Name</option>
        </select>
    </section>

    <!-- TABLE -->
    <section class="table-container">
        <table>
            <thead>
                <tr>
                    <th>Rider ID</th>
                    <th>Full Name</th>
                    <th>Contact</th>
                    <th>Vehicle</th>
                    <th>Status</th>
                    <th>Assigned</th>
                    <th>Completed</th>
                    <th>Rating</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>RDR-001</td>
                    <td>Miguel Santos</td>
                    <td>0917-111-2222</td>
                    <td>Motorcycle</td>
                    <td><span class="status available">AVAILABLE</span></td>
                    <td>2</td>
                    <td>487</td>
                    <td>⭐ 4.8</td>
                    <td class="actions">
                        👁 ✏ 🗑
                    </td>
                </tr>
                <tr>
                    <td>RDR-002</td>
                    <td>Carlo Reyes</td>
                    <td>0918-222-3333</td>
                    <td>Motorcycle</td>
                    <td><span class="status delivery">ON DELIVERY</span></td>
                    <td>1</td>
                    <td>523</td>
                    <td>⭐ 4.9</td>
                    <td class="actions">
                        👁 ✏ 🗑
                    </td>
                </tr>
            </tbody>
        </table>
    </section>

</body>
</html>

</asp:Content>
