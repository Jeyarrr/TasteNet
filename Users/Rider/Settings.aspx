<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Rider.Master" AutoEventWireup="true" CodeBehind="Settings.aspx.cs" Inherits="TasteNet.Users.Rider.settings" %>
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

/* Page Title */
.page-title {
    font-size: 20px;
    font-weight: 600;
    margin-bottom: 20px;
    color: #000;
}

/* Card */
.card {
    background: #fff;
    border-radius: 12px;
    padding: 20px;
    border: 1px solid #eee;
}

/* Section Title */
.section-title {
    font-size: 14px;
    font-weight: 600;
    color: #b00000;
    margin-bottom: 15px;
    display: flex;
    align-items: center;
    gap: 6px;
}

/* Preference Row */
.pref-row {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 14px 0;
    border-bottom: 1px solid #eee;
}

.pref-row:last-child {
    border-bottom: none;
}

.pref-text h4 {
    font-size: 14px;
    font-weight: 600;
    color: #000;
}

.pref-text p {
    font-size: 12px;
    color: #777;
    margin-top: 2px;
}

/* Toggle Switch */
.switch {
    position: relative;
    width: 46px;
    height: 24px;
}

.switch input {
    opacity: 0;
    width: 0;
    height: 0;
}

.slider {
    position: absolute;
    cursor: pointer;
    inset: 0;
    background-color: #ddd;
    border-radius: 24px;
    transition: .3s;
}

.slider:before {
    content: "";
    position: absolute;
    height: 18px;
    width: 18px;
    left: 3px;
    bottom: 3px;
    background-color: white;
    border-radius: 50%;
    transition: .3s;
}

.switch input:checked + .slider {
    background-color: #b00000;
}

.switch input:checked + .slider:before {
    transform: translateX(22px);
}
</style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="container">

    <div class="page-title">Settings</div>

    <div class="card">

        <div class="section-title">
            🔔 Notification Preferences
        </div>

        <!-- Push Notifications -->
        <div class="pref-row">
            <div class="pref-text">
                <h4>Push Notifications</h4>
                <p>Receive instant updates on your device</p>
            </div>

            <label class="switch">
                <input type="checkbox" checked />
                <span class="slider"></span>
            </label>
        </div>

        <!-- Email Notifications -->
        <div class="pref-row">
            <div class="pref-text">
                <h4>Email Notifications</h4>
                <p>Get updates via email</p>
            </div>

            <label class="switch">
                <input type="checkbox" checked />
                <span class="slider"></span>
            </label>
        </div>

        <!-- SMS Notifications -->
        <div class="pref-row">
            <div class="pref-text">
                <h4>SMS Notifications</h4>
                <p>Receive text message updates</p>
            </div>

            <label class="switch">
                <input type="checkbox" />
                <span class="slider"></span>
            </label>
        </div>

    </div>

</div>

</asp:Content>

