<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Admin.Master" AutoEventWireup="true" CodeBehind="UpdateMenu.aspx.cs" Inherits="TasteNet.Users.Admin.UpdateMenu" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
* {
    box-sizing: border-box;
    font-family: 'Segoe UI', sans-serif;
}

body {
    background: #f7f7f7;
}

/* Container */
.menu-container {
    max-width: 1200px;
    margin: 10px auto;
    padding: 0 20px;
}

/* Header */
.menu-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
    color: #000000
}

.menu-header h2 {
    font-size: 22px;
    font-weight: 600;
}

.add-btn {
    background: #e6b08c;
    border: none;
    padding: 8px 14px;
    border-radius: 8px;
    cursor: pointer;
    font-size: 13px;
}


.stats{
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 20px;
    margin-bottom: 25px;
}

.stat-card {
    background: #fff;
    border-radius: 12px;
    padding: 20px;
    border: 1px solid #eee;
    font-size: 13px;
}
.stat-value green {
    color: #000000;
}
.stat-value { 
    color: #fff;
}
.stat-label {
    font-size: 22px;
    font-weight: 600;
    display: block;
    margin-top: 5px;
    color: #000000
}
/* Tabs */
.tabs {
    display: flex;
    gap: 8px;
    margin-bottom: 25px;
}

.tab {
    padding: 6px 12px;
    border-radius: 8px;
    border: 1px solid #eee;
    background: #fff;
    font-size: 12px;
    cursor: pointer;
    color: #000000
}

.tab.active {
    background: #6b2c2c;
    color: #fff;
}

/* Grid */
.menu-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
    gap: 20px;
}

/* Card */
.menu-card {
    background: #fff;
    border-radius: 14px;
    border: 1px solid #eee;
    overflow: hidden;
    
}

.menu-card img {
    width: 100%;
    height: 160px;
    object-fit: cover;
}

/* Card body */
.menu-body {
    padding: 14px;
}

.menu-title {
    display: flex;
    justify-content: space-between;
    font-weight: 600;
    font-size: 14px;
    color: #000000;
}

.menu-category {
    font-size: 11px;
    color: #888;
    margin: 4px 0;
}

.menu-desc {
    font-size: 12px;
    color: #555;
    margin-bottom: 10px;
}

/* Actions */
.actions {
    display: flex;
    gap: 6px;
}

.edit-btn {
    flex: 1;
    background: #e6b08c;
    border: none;
    padding: 6px;
    border-radius: 6px;
    font-size: 12px;
}

.icon-btn {
    width: 30px;
    border: 1px solid #eee;
    background: #fff;
    border-radius: 6px;
}

/* Badge */
.badge {
    position: absolute;
    background: red;
    color: #fff;
    font-size: 10px;
    padding: 4px 8px;
    border-radius: 20px;
    margin: 10px;
}

/* Stats */

</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="menu-container">

    <!-- Header -->
    <div class="menu-header">
        <div>
            <h2>Menu Editor</h2>
            <small>Manage menu items</small>
        </div>
        <button class="add-btn">＋ Add Menu Item</button>
    </div>
         <!-- Stats -->
        <div class="stats">
    <div class="stat-card">
        <p class="stat-label">Total Items</p>
        <h3 class="stat-value">6</h3>
    </div>

    <div class="stat-card">
        <p class="stat-label">Available</p>
        <h3 class="stat-value green">5</h3>
    </div>

    <div class="stat-card">
        <p class="stat-label">Categories</p>
        <h3 class="stat-value">4</h3>
    </div>
</div>


<!-- CATEGORIES -->
<div class="tabs">
    <div class="tab active">All</div>
    <div class="tab">Sizzling</div>
    <div class="tab">Silog</div>
    <div class="tab">Special Meals</div>
</div>

    <!-- Menu Grid -->
    <div class="menu-grid">

        <!-- Card -->
        <div class="menu-card">
            <img src="images/pizza.jpg" />
            <div class="menu-body">
                <div class="menu-title">
                    <span>Sizzling Pork Sisig</span>
                    <span>₱155</span>
                </div>
                <div class="menu-category">Sizzling Meals</div>
                   <div class="menu-desc">Authentic Pork Sisig</div>
                <div class="actions">
                    <button class="edit-btn">✏ Edit</button>
                    <button class="icon-btn">👁</button>
                    <button class="icon-btn">🗑</button>
                </div>
            </div>
        </div>

        <div class="menu-card">
            <img src="images/pasta.jpg" />
            <div class="menu-body">
                <div class="menu-title">
                    <span>Tapsilog</span>
                    <span>₱100</span>
                </div>
                <div class="menu-category">Silog Meals</div>
                <div class="menu-desc">Tapa from moutain of jerusalem</div>
                <div class="actions">
                    <button class="edit-btn">✏ Edit</button>
                    <button class="icon-btn">👁</button>
                    <button class="icon-btn">🗑</button>
                </div>
            </div>
        </div>

        <div class="menu-card" style="position:relative;">
            <div class="badge">Unavailable</div>
            <img src="images/salmon.jpg" />
            <div class="menu-body">
                <div class="menu-title">
                    <span>Goto Overload</span>
                    <span>₱90</span>
                </div>
                <div class="menu-category">Special Meals</div>
                <div class="menu-desc">Overload Meat and Tasty</div>
                <div class="actions">
                    <button class="edit-btn">✏ Edit</button>
                    <button class="icon-btn">👁</button>
                    <button class="icon-btn">🗑</button>
                </div>
            </div>
        </div>

    </div>

    <!-- Stats -->


</div>

</asp:Content>
