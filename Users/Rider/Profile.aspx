<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Rider.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="TasteNet.Users.Rider.Profile" %>
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
.page-title {
    font-size: 22px;
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
    margin-bottom: 25px;
    color:#000
}

/* Profile Header */
.profile-header {
    display: flex;
    align-items: center;
    gap: 15px;
}

.avatar {
    width: 60px;
    height: 60px;
    border-radius: 50%;
    background: #c00000;
    color: #fff;
    display: flex;
    align-items: center;
    justify-content: center;
    font-weight: 600;
    font-size: 18px;
}

.badge {
    display: inline-block;
    margin-top: 5px;
    font-size: 12px;
    color: #0a8f3c;
}

/* Form */
.form-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
    gap: 15px;
}

.form-group label {
    font-size: 13px;
    color: #000;
    margin-bottom: 4px;
    display: block;
}

.form-group input {
    width: 100%;
    padding: 10px;
    border-radius: 8px;
    border: 1px solid #ddd;
}

.full {
    grid-column: 1 / -1;
}

/* Buttons */
.actions {
    text-align: right;
    margin-top: 15px;
}

.btn {
    background: #c00000;
    color: #fff;
    border: none;
    padding: 10px 18px;
    border-radius: 8px;
    cursor: pointer;
}

.btn-outline {
    background: transparent;
    border: 1px dashed #ccc;
    color: #555;
    width: 100%;
}

/* Documents */
.doc-item {
    display: flex;
    justify-content: space-between;
    padding: 12px;
    border: 1px solid #eee;
    border-radius: 8px;
    margin-bottom: 10px;
    font-size: 14px;
    color: #000
}

.verified {
    color: #0a8f3c;
}

.pending {
    color: #d48b00;
}
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">

    <div class="page-title">Profile & Account</div>

    <!-- Profile Header -->
    <div class="card">
        <div class="profile-header">
            <div class="avatar">JR</div>
            <div>
                <strong>John Rider</strong><br />
                <small>Rider ID: RDR-2024-001</small><br />
                <span class="badge">✔ Verified Rider</span>
            </div>
        </div>
    </div>

    <!-- Personal Information -->
    <div class="card">
        <h4>Personal Information</h4><br />

        <div class="form-grid">
            <div class="form-group">
                <label>Full Name</label>
                <input type="text" value="John Rider" />
            </div>

            <div class="form-group">
                <label>Email</label>
                <input type="email" value="john.rider@example.com" />
            </div>

            <div class="form-group">
                <label>Phone Number</label>
                <input type="text" value="+1 (555) 123-4567" />
            </div>

            <div class="form-group">
                <label>Date of Birth</label>
                <input type="date" value="1995-06-15" />
            </div>

            <div class="form-group full">
                <label>Address</label>
                <input type="text" value="123 Main Street, Cityville, ST 12345" />
            </div>
        </div>

        <div class="actions">
            <button class="btn">Save Changes</button>
        </div>
    </div>

    <!-- Vehicle Details -->
    <div class="card">
        <h4>Vehicle Details</h4><br />

        <div class="form-grid">
            <div class="form-group">
                <label>Vehicle Type</label>
                <input type="text" value="Motorcycle" />
            </div>

            <div class="form-group">
                <label>Make & Model</label>
                <input type="text" value="Honda CB 125" />
            </div>

            <div class="form-group">
                <label>License Plate</label>
                <input type="text" value="ABC-1234" />
            </div>

            <div class="form-group">
                <label>Year</label>
                <input type="text" value="2022" />
            </div>

            <div class="form-group">
                <label>Color</label>
                <input type="text" value="Black" />
            </div>

            <div class="form-group">
                <label>Insurance Policy</label>
                <input type="text" value="INS-987654" />
            </div>
        </div>

        <div class="actions">
            <button class="btn">Update Vehicle Info</button>
        </div>
    </div>

    <!-- Uploaded Documents -->
    <div class="card">
        <h4>Uploaded Documents</h4><br />

        <div class="doc-item">
            Driver’s License <span class="verified">Verified</span>
        </div>

        <div class="doc-item">
            Vehicle Registration <span class="verified">Verified</span>
        </div>

        <div class="doc-item">
            Insurance Certificate <span class="pending">Pending</span>
        </div>

        <div class="doc-item">
            Background Check <span class="verified">Verified</span>
        </div>

        <button class="btn-outline">Upload New Document</button>
    </div>

    <!-- Change Password -->
    <div class="card">
        <h4>Change Password</h4><br />

        <div class="form-group">
            <input type="password" placeholder="Current Password" />
        </div><br />

        <div class="form-group">
            <input type="password" placeholder="New Password" />
        </div><br />

        <div class="form-group">
            <input type="password" placeholder="Confirm New Password" />
        </div>

        <div class="actions">
            <button class="btn">Update Password</button>
        </div>
    </div>

</div>
</asp:Content>
