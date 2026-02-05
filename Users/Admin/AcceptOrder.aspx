<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Admin.Master" AutoEventWireup="true" CodeBehind="AcceptOrder.aspx.cs" Inherits="TasteNet.Users.Admin.AcceptOrder" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
* {
    box-sizing: border-box;
    font-family: 'Segoe UI', sans-serif;
}

body {
    background: #f2f2f2;
}

.container {
    max-width: 1200px;
    margin: 30px auto;
    padding: 0 20px;
}

/* Header */
.header h2 {
    color: #b00000;
    font-size: 22px;
    font-weight: 600;
}

.header p {
    font-size: 13px;
    color: #666;
    margin-bottom: 20px;
}

/* Stats */
.stats {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 15px;
    margin-bottom: 25px;
}

.stat-card {
    background: #fff;
    border: 1px solid #ccc;
    border-radius: 6px;
    padding: 15px;
    font-size: 13px;
    color: #000000
}

.stat-card span {
    font-size: 20px;
    font-weight: 600;
    display: block;
    margin-top: 6px;
}

/* Workflow */
.workflow {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 20px;
}

/* Column */
.column {
    background: #ddd;
    border-radius: 6px;
    overflow: hidden;
}

.column-header {
    background: #9b0000;
    color: #fff;
    padding: 10px 15px;
    font-size: 13px;
}

.column-body {
    padding: 10px;
}

/* Order Card */
.order-card {
    background: #fff;
    border-radius: 6px;
    padding: 12px;
    margin-bottom: 10px;
    font-size: 12px;
}

.order-top {
    display: flex;
    justify-content: space-between;
    font-weight: 600;
    margin-bottom: 6px;
    color: #000000
}

.order-items {
    font-size: 11px;
    color: #444;
    margin-bottom: 8px;
}

.order-footer {
    display: flex;
    justify-content: space-between;
    align-items: center;
    font-weight: 600;
    color: #000000
}

.btn {
    padding: 4px 10px;
    font-size: 11px;
    border: none;
    border-radius: 12px;
    cursor: pointer;
}

.btn-accept {
    background: #0a8f3c;
    color: #fff;
}

.btn-complete {
    background: #0a8f3c;
    color: #fff;
}
</style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">

    <!-- Header -->
    <div class="header">
        <h2>Order Workflow</h2>
        <p>Manage incoming orders and track preparation status</p>
    </div>

    <!-- Stats -->
    <div class="stats">
        <div class="stat-card">
            New Orders
            <span>2</span>
        </div>
        <div class="stat-card">
            Preparing
            <span>1</span>
        </div>
        <div class="stat-card">
            Avg. Waiting Time
            <span>12 min</span>
        </div>
        <div class="stat-card">
            Today's Orders
            <span>42</span>
        </div>
    </div>

    <!-- Workflow Columns -->
    <div class="workflow">

        <!-- New Orders -->
        <div class="column">
            <div class="column-header">
                New Order (2)<br />
                <small>Order waiting to be accepted</small>
            </div>

            <div class="column-body">

                <div class="order-card">
                    <div class="order-top">
                        <span>#001 Jay-r Reyes</span>
                        <span>1:00 PM</span>
                    </div>
                    <div class="order-items">
                        1 Tofu Sisig<br />
                        1 Pork Sisig<br />
                        1 Coke
                    </div>
                    <div class="order-footer">
                        <span>₱350</span>
                        <button class="btn btn-accept">Accept</button>
                    </div>
                </div>

                <div class="order-card">
                    <div class="order-top">
                        <span>#002 Raymond Santos</span>
                        <span>1:00 PM</span>
                    </div>
                    <div class="order-items">
                        1 Tofu Sisig<br />
                        1 Pork Sisig<br />
                        1 Mountain Dew
                    </div>
                    <div class="order-footer">
                        <span>₱350</span>
                        <button class="btn btn-accept">Accept</button>
                    </div>
                </div>

            </div>
        </div>

        <!-- Preparing -->
        <div class="column">
            <div class="column-header">
                Preparing (1)<br />
                <small>Order currently being prepared</small>
            </div>

            <div class="column-body">

                <div class="order-card">
                    <div class="order-top">
                        <span>#001 Jay-r Reyes</span>
                        <span>1:00 PM</span>
                    </div>
                    <div class="order-items">
                        1 Tofu Sisig<br />
                        1 Pork Sisig<br />
                        1 Coke
                    </div>
                    <div class="order-footer">
                        <span>₱350</span>
                        <button class="btn btn-complete">Complete</button>
                    </div>
                </div>

            </div>
        </div>

    </div>

</div>

</asp:Content>
