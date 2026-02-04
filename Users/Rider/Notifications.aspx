<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Rider.Master" AutoEventWireup="true" CodeBehind="Notifications.aspx.cs" Inherits="TasteNet.Users.Rider.Transactions" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
    <style>
    * {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: 'Segoe UI', sans-serif;
}

body {
    background: #f7f7f7;
}

.container {
    max-width: 1100px;
    margin: 40px auto;
    padding: 0 20px;
}

/* Header */
.header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
    color: #000000;
}

.header h2 {
    font-weight: 600;
}

.mark-read {
    color: #b00000;
    font-size: 14px;
    text-decoration: none;
}

/* Stats */
.stats {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 15px;
    margin-bottom: 30px;
}

.stat-card {
    background: #fff;
    padding: 20px;
    border-radius: 12px;
    border: 1px solid #eee;
}

.stat-card span {
    font-size: 13px;
    color: #000000;
}

.stat-card h3 {
    margin-top: 10px;
    font-size: 28px;
    color: #fff;
}

.stat-card .danger {
    color: #c00000;
}

/* Notifications */
.notification {
    background: #fff;
    border-radius: 12px;
    padding: 18px;
    display: flex;
    align-items: center;
    margin-bottom: 15px;
    border: 1px solid #eee;
    position: relative;
}

.notification.unread {
    border: 1px solid #c00000;
    background: #fff6f6;
}

/* Icon */
.icon {
    width: 45px;
    height: 45px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 18px;
    margin-right: 15px;
}

.icon.red { background: #ffe5e5; }
.icon.green { background: #e5fff0; }
.icon.yellow { background: #fff7d6; }

/* Content */
.content h4 {
    font-size: 15px;
    margin-bottom: 4px;
    color: #;
}

.content p {
    font-size: 13px;
    color: #555;
}

.content span {
    font-size: 11px;
    color: #999;
}

/* Unread Dot */
.dot {
    width: 8px;
    height: 8px;
    background: #c00000;
    border-radius: 50%;
    position: absolute;
    right: 20px;
}
  </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Notifications</title>
    <link rel="stylesheet" href="notifications.css">
</head>
<body>

<div class="container">

    <!-- Header -->
    <div class="header">
        <h2>Notifications</h2>
        <a href="#" class="mark-read">Mark all as read</a>
    </div>

    <!-- Summary Cards -->
    <div class="stats">
        <div class="stat-card">
            <span>Unread</span>
            <h3 class="danger">2</h3>
        </div>
        <div class="stat-card">
            <span>Today</span>
            <h3>5</h3>
        </div>
        <div class="stat-card">
            <span>This Week</span>
            <h3>12</h3>
        </div>
        <div class="stat-card">
            <span>Total</span>
            <h3>47</h3>
        </div>
    </div>

    <!-- Notification List -->
    <div class="notification unread">
        <div class="icon red">📦</div>
        <div class="content">
            <h4 class ="h4">New Order Available</h4>
            <p>Order #ORD-12345 is waiting for acceptance</p>
            <span>2 minutes ago</span>
        </div>
        <div class="dot"></div>
    </div>

    <div class="notification unread">
        <div class="icon green">💲</div>
        <div class="content">
            <h4>Payment Received</h4>
            <p>Your weekly earnings of ₱982.50 have been processed</p>
            <span>1 hour ago</span>
        </div>
        <div class="dot"></div>
    </div>

    <div class="notification">
        <div class="icon yellow">🔔</div>
        <div class="content">
            <h4>Peak Hour Alert</h4>
            <p>High demand area detected near your location</p>
            <span>2 hours ago</span>
        </div>
    </div>

    <div class="notification">
        <div class="icon green">✅</div>
        <div class="content">
            <h4>Delivery Completed</h4>
            <p>Order #ORD-12344 delivered. You earned ₱85.00</p>
            <span>3 hours ago</span>
        </div>
    </div>

</div>

</body>
</html>
</asp:Content>
