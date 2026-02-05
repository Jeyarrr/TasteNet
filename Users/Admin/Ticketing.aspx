<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Admin.Master" AutoEventWireup="true" CodeBehind="Ticketing.aspx.cs" Inherits="TasteNet.Users.Admin.Ticketing" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
* {
    box-sizing: border-box;
    font-family: 'Segoe UI', sans-serif;
}

body {
    background: #f2f2f2;
}

/* Container */
.container {
    max-width: 1200px;
    margin: 30px auto;
    padding: 0 20px;
}

/* Header */
.header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
}

.header h2 {
    color: #b00000;
    font-size: 22px;
    font-weight: 600;
}

.header p {
    font-size: 13px;
    color: #666;
}

/* Status Tabs */
.status-tabs {
    display: flex;
    gap: 8px;
    color: #000000
}

.status-tab {
    padding: 6px 12px;
    border-radius: 6px;
    font-size: 12px;
    background: #e0e0e0;
}

.status-tab.active {
    background: #9b0000;
    color: #fff;
}

/* Grid */
.ticket-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(260px, 1fr));
    gap: 20px;
}

/* Ticket Card */
.ticket {
    border-radius: 10px;
    overflow: hidden;
    border: 1px solid #ccc;
    background: #fff;
}

/* Ticket Header */
.ticket-header {
    background: #9b0000;
    color: #fff;
    padding: 10px 12px;
    font-size: 12px;
    position: relative;
}

.ticket-header strong {
    font-size: 13px;
}

.trash {
    position: absolute;
    right: 10px;
    top: 10px;
}

/* Ticket Body */
.ticket-body {
    padding: 12px;
    font-size: 12px;
    color: #000000
}

.ticket-body .row {
    display: flex;
    justify-content: space-between;
    margin-bottom: 8px;
}

.items {
    font-size: 11px;
    color: #444;
    margin-bottom: 10px;
}

/* Button */
.ticket-btn {
    display: block;
    width: 100%;
    text-align: center;
    padding: 6px;
    border-radius: 14px;
    font-size: 11px;
    border: none;
    cursor: pointer;
}

.start {
    background: #0a8f3c;
    color: #fff;
}

.done {
    background: #0a8f3c;
    color: #fff;
}
</style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">

    <!-- Header -->
    <div class="header">
        <div>
            <h2>Ticketing Management</h2>
            <p>Manage Order Tickets</p>
        </div>

        <div class="status-tabs">
            <div class="status-tab active">Open (4)</div>
            <div class="status-tab">Complete (2)</div>
        </div>
    </div>

    <!-- Tickets -->
    <div class="ticket-grid">

        <!-- Ticket -->
        <div class="ticket">
            <div class="ticket-header">
                <strong>Order #001</strong><br />
                <small>1:00 PM</small>
                <span class="trash">🗑</span>
            </div>
            <div class="ticket-body">
                <div class="row">
                    <span>Delivery</span>
                    <span>Jay-r Reyes</span>
                </div>
                <div class="items">
                    1 Tofu Sisig<br />
                    1 Pork Sisig<br />
                    1 Coke
                </div>
                <button class="ticket-btn done">Mark as done</button>
            </div>
        </div>

        <div class="ticket">
            <div class="ticket-header">
                <strong>Order #002</strong><br />
                <small>2:00 PM</small>
                <span class="trash">🗑</span>
            </div>
            <div class="ticket-body">
                <div class="row">
                    <span>Table 001</span>
                    <span>George Luna</span>
                </div>
                <div class="items">
                    1 Tofu Sisig<br />
                    1 Goto<br />
                    1 Coke
                </div>
                <button class="ticket-btn done">Mark as done</button>
            </div>
        </div>

        <div class="ticket">
            <div class="ticket-header">
                <strong>Order #003</strong><br />
                <small>3:00 PM</small>
                <span class="trash">🗑</span>
            </div>
            <div class="ticket-body">
                <div class="row">
                    <span>Table 002</span>
                    <span>Bryle Andres</span>
                </div>
                <div class="items">
                    1 Pares<br />
                    1 Mami<br />
                    2 Coke
                </div>
                <button class="ticket-btn start">Start</button>
            </div>
        </div>

        <div class="ticket">
            <div class="ticket-header">
                <strong>Order #004</strong><br />
                <small>1:00 PM</small>
                <span class="trash">🗑</span>
            </div>
            <div class="ticket-body">
                <div class="row">
                    <span>Delivery</span>
                    <span>Lalaine Gomez</span>
                </div>
                <div class="items">
                    1 Tofu Sisig<br />
                    1 Pork Sisig<br />
                    1 Coke<br />
                    2 Extra Rice
                </div>
                <button class="ticket-btn start">Start</button>
            </div>
        </div>

        <div class="ticket">
            <div class="ticket-header">
                <strong>Order #005</strong><br />
                <small>1:00 PM</small>
                <span class="trash">🗑</span>
            </div>
            <div class="ticket-body">
                <div class="row">
                    <span>Table 003</span>
                    <span>Lalaine Gomez</span>
                </div>
                <div class="items">
                    1 Pork Sisig<br />
                    2 Extra Rice
                </div>
                <button class="ticket-btn start">Start</button>
            </div>
        </div>

    </div>

</div>
</asp:Content>
