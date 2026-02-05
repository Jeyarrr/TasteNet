<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/SuperAdmin.Master" AutoEventWireup="true" CodeBehind="Settings.aspx.cs" Inherits="TasteNet.Users.SuperAdmin.Settings" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root {
            --primary-maroon: #6b0d1e;
            --soft-cream: #fffaf3;
            --text-dark: #4a0e0e;
            --muted-text: #8a6d6d;
            --accent-yellow: #ffcc00;
            --success-green: #2d9d78;
            --card-shadow: 0 10px 30px rgba(107, 13, 30, 0.05);
            --hover-shadow: 0 15px 40px rgba(107, 13, 30, 0.12);
            --radius-lg: 12px;
            --radius-xl: 16px;
            --radius-2xl: 18px;
            --radius-3xl: 22px;
        }

        body {
            background-color: var(--soft-cream) !important;
            font-family: 'Poppins', sans-serif !important;
        }

        .settings-container {
            padding: 20px 25px;
        }

        .page-header {
            margin-bottom: 25px;
        }

        .page-header h2 {
            color: var(--text-dark);
            font-weight: 700;
            margin: 0;
            font-size: 26px;
            letter-spacing: -0.5px;
        }

        .page-header p {
            color: var(--muted-text);
            font-size: 14px;
            margin-top: 8px;
        }

        .settings-layout {
            display: grid;
            grid-template-columns: 240px 1fr;
            gap: 25px;
        }

        .settings-sidebar {
            background: white;
            border-radius: var(--radius-xl);
            padding: 20px;
            box-shadow: var(--card-shadow);
            height: fit-content;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .settings-sidebar:hover {
            transform: translateY(-5px);
            box-shadow: var(--hover-shadow);
        }

        .nav-item {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 14px 16px;
            border-radius: var(--radius-lg);
            color: var(--text-dark);
            text-decoration: none;
            font-weight: 600;
            font-size: 14px;
            transition: all 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
            margin-bottom: 8px;
            cursor: pointer;
            border: 2px solid transparent;
            width: 100%;
            background: none;
            text-align: left;
            letter-spacing: 0.2px;
        }

        .nav-item:hover {
            background: #fefaf5;
            color: var(--primary-maroon);
            transform: translateX(5px) scale(1.02);
            border-color: rgba(107, 13, 30, 0.1);
        }

        .nav-item.active {
            background: var(--primary-maroon);
            color: white;
            box-shadow: 0 4px 12px rgba(107, 13, 30, 0.2);
            transform: translateX(5px);
        }

        .nav-item i {
            font-size: 16px;
            width: 20px;
            text-align: center;
            transition: transform 0.3s ease;
        }

        .nav-item:hover i {
            transform: scale(1.1) rotate(5deg);
        }

        .settings-card {
            background: white;
            border-radius: var(--radius-xl);
            padding: 25px;
            box-shadow: var(--card-shadow);
            display: none;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .settings-card.active {
            display: block;
            animation: fadeIn 0.5s ease;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .settings-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--hover-shadow);
        }

        .settings-card h3 {
            color: var(--primary-maroon);
            font-weight: 700;
            margin-bottom: 20px;
            font-size: 20px;
            letter-spacing: -0.3px;
            padding-bottom: 12px;
            border-bottom: 2px solid #f3ebe0;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-label {
            display: block;
            color: var(--text-dark);
            font-weight: 600;
            font-size: 14px;
            margin-bottom: 8px;
            letter-spacing: 0.2px;
        }

        .form-control {
            width: 100%;
            padding: 14px 16px;
            border-radius: var(--radius-lg);
            border: 2px solid #e2d1d1;
            background: white;
            font-family: 'Poppins', sans-serif;
            font-size: 14px;
            font-weight: 500;
            color: var(--text-dark);
            transition: all 0.3s ease;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.02);
            box-sizing: border-box;
        }

        .form-control:focus {
            border-color: var(--primary-maroon);
            box-shadow: 0 0 0 4px rgba(107, 13, 30, 0.08);
            outline: none;
            transform: translateY(-2px);
        }

        .form-control:hover {
            border-color: var(--primary-maroon);
        }

        select.form-control {
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='%238a6d6d' viewBox='0 0 16 16'%3E%3Cpath d='M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 16px center;
            background-size: 16px;
            padding-right: 45px;
            cursor: pointer;
        }

        .grid-2-col {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 16px;
        }

        .grid-2-col > div {
            position: relative;
        }

        .grid-2-col span {
            font-size: 13px;
            color: var(--muted-text);
            font-weight: 600;
            margin-bottom: 8px;
            display: block;
        }

        .payment-method-row {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 16px;
            border: 2px solid #e2d1d1;
            border-radius: var(--radius-lg);
            margin-bottom: 12px;
            transition: all 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
            background: white;
        }

        .payment-method-row:hover {
            transform: translateY(-3px);
            border-color: var(--primary-maroon);
            box-shadow: 0 4px 12px rgba(107, 13, 30, 0.08);
        }

        .method-info {
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .method-info i {
            color: var(--primary-maroon);
            font-size: 20px;
            background: #f9f4ee;
            width: 40px;
            height: 40px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: transform 0.3s ease;
        }

        .payment-method-row:hover .method-info i {
            transform: scale(1.1) rotate(5deg);
        }

        .method-text b {
            display: block;
            font-size: 14px;
            color: var(--text-dark);
            font-weight: 700;
            margin-bottom: 4px;
        }

        .method-text span {
            font-size: 12px;
            color: var(--muted-text);
            font-weight: 500;
        }

        .switch {
            position: relative;
            display: inline-block;
            width: 48px;
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
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: #e2d1d1;
            transition: .4s;
            border-radius: 28px;
            box-shadow: inset 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .slider:before {
            position: absolute;
            content: "";
            height: 18px;
            width: 18px;
            left: 3px;
            bottom: 3px;
            background-color: white;
            transition: .4s cubic-bezier(0.34, 1.56, 0.64, 1);
            border-radius: 50%;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        input:checked + .slider {
            background-color: var(--success-green);
        }

        input:checked + .slider:before {
            transform: translateX(22px);
            box-shadow: 0 2px 6px rgba(45, 157, 120, 0.3);
        }

        .payment-method-row:hover .slider {
            background-color: #d4c4c4;
        }

        .payment-method-row:hover input:checked + .slider {
            background-color: #259469;
        }

        .logo-upload-box {
            border: 2.5px dashed #d4c4c4;
            border-radius: var(--radius-xl);
            padding: 40px 25px;
            text-align: center;
            color: var(--muted-text);
            cursor: pointer;
            transition: all 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
            margin-bottom: 12px;
            background: #fefaf5;
        }

        .logo-upload-box:hover {
            border-color: var(--primary-maroon);
            background: #f9f4ee;
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(107, 13, 30, 0.08);
        }

        .logo-upload-box i {
            font-size: 36px;
            margin-bottom: 15px;
            color: var(--primary-maroon);
            transition: transform 0.3s ease;
        }

        .logo-upload-box:hover i {
            transform: scale(1.1);
        }

        .logo-upload-box b {
            display: block;
            color: var(--text-dark);
            font-size: 16px;
            font-weight: 700;
            margin-bottom: 8px;
        }

        .logo-upload-box span {
            font-size: 13px;
        }

        .btn-save {
            background: var(--accent-yellow);
            color: var(--text-dark);
            border: none;
            border-radius: var(--radius-lg);
            padding: 14px 25px;
            font-weight: 700;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
            display: inline-flex;
            align-items: center;
            gap: 12px;
            margin-top: 25px;
            box-shadow: 0 4px 12px rgba(255, 204, 0, 0.2);
            letter-spacing: 0.3px;
        }

        .btn-save:hover {
            background: #e6b800;
            transform: translateY(-4px) scale(1.02);
            box-shadow: 0 8px 20px rgba(255, 204, 0, 0.3);
        }

        .btn-save i {
            font-size: 16px;
            transition: transform 0.3s ease;
        }

        .btn-save:hover i {
            transform: scale(1.1) rotate(10deg);
        }

        textarea.form-control {
            min-height: 100px;
            resize: vertical;
            line-height: 1.6;
        }

        @media (max-width: 1200px) {
            .settings-layout {
                grid-template-columns: 220px 1fr;
            }
        }

        @media (max-width: 992px) {
            .settings-layout {
                grid-template-columns: 1fr;
                gap: 20px;
            }
            
            .settings-sidebar {
                display: flex;
                flex-wrap: wrap;
                gap: 10px;
                padding: 16px;
            }
            
            .nav-item {
                flex: 1;
                min-width: 180px;
                justify-content: center;
                text-align: center;
            }
            
            .grid-2-col {
                grid-template-columns: 1fr;
                gap: 12px;
            }
        }

        @media (max-width: 768px) {
            .settings-container {
                padding: 12px;
            }
            
            .settings-card {
                padding: 20px;
            }
            
            .page-header h2 {
                font-size: 22px;
            }
            
            .settings-sidebar {
                flex-direction: column;
            }
            
            .nav-item {
                width: 100%;
                justify-content: flex-start;
                text-align: left;
            }
            
            .payment-method-row {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }
            
            .method-info {
                width: 100%;
            }
            
            .switch {
                align-self: flex-end;
            }
        }

        @media (max-width: 576px) {
            .settings-card {
                padding: 16px;
            }
            
            .logo-upload-box {
                padding: 30px 16px;
            }
            
            .btn-save {
                width: 100%;
                justify-content: center;
            }
            
            .method-info i {
                width: 35px;
                height: 35px;
                font-size: 18px;
            }
        }
    </style>

    <div class="settings-container">
        <div class="page-header">
            <h2>Platform Settings</h2>
            <p>Configure system-wide settings and preferences</p>
        </div>

        <div class="settings-layout">
            <div class="settings-sidebar">
                <button type="button" class="nav-item active" onclick="showTab('general', this)">
                    <i class="fas fa-info-circle"></i> General Settings
                </button>
                <button type="button" class="nav-item" onclick="showTab('order', this)">
                    <i class="far fa-clock"></i> Order Settings
                </button>
                <button type="button" class="nav-item" onclick="showTab('payment', this)">
                    <i class="far fa-credit-card"></i> Payment Settings
                </button>
                <button type="button" class="nav-item" onclick="showTab('security', this)">
                    <i class="far fa-shield-alt"></i> User & Security
                </button>
                <button type="button" class="nav-item" onclick="showTab('system', this)">
                    <i class="fas fa-sliders-h"></i> System Controls
                </button>
            </div>

            <div id="general" class="settings-card active">
                <h3>General Settings</h3>
                <div class="form-group">
                    <label class="form-label">System Name</label>
                    <asp:TextBox ID="txtSystemName" runat="server" CssClass="form-control" Text="Caballeros TasteNet"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label class="form-label">Logo Upload</label>
                    <div class="logo-upload-box">
                        <i class="fas fa-upload"></i><br />
                        <b>Click to upload or drag and drop</b><br />
                        <span>SVG, PNG, JPG (max. 2MB)</span>
                    </div>
                </div>
                <div class="form-group">
                    <label class="form-label">Contact Email</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" Text="support@caballerostastenet.com"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label class="form-label">Contact Phone</label>
                    <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" Text="(046) 123-4567"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label class="form-label">Store Address</label>
                    <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" Text="Dasmariñas, Cavite, Philippines"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label class="form-label">Operating Hours</label>
                    <div class="grid-2-col">
                        <div>
                            <span>Opening Time</span>
                            <asp:TextBox ID="txtOpen" runat="server" CssClass="form-control" Text="09:00 AM"></asp:TextBox>
                        </div>
                        <div>
                            <span>Closing Time</span>
                            <asp:TextBox ID="txtClose" runat="server" CssClass="form-control" Text="09:00 PM"></asp:TextBox>
                        </div>
                    </div>
                </div>
                <button type="button" class="btn-save"><i class="fas fa-save"></i> Save Changes</button>
            </div>

            <div id="order" class="settings-card">
                <h3>Order Settings</h3>
                <div class="form-group">
                    <label class="form-label">Minimum Order Amount</label>
                    <asp:TextBox ID="txtMinOrder" runat="server" CssClass="form-control" Text="₱ 100"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label class="form-label">Delivery Fee</label>
                    <asp:TextBox ID="txtDelFee" runat="server" CssClass="form-control" Text="₱ 30"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label class="form-label">Order Cut-off Time</label>
                    <asp:TextBox ID="txtCutoff" runat="server" CssClass="form-control" Text="08:30 PM"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label class="form-label">Auto-cancel Time (Unpaid Orders)</label>
                    <asp:DropDownList ID="ddlAutoCancel" runat="server" CssClass="form-control">
                        <asp:ListItem Text="30 minutes" Value="30" Selected="True" />
                        <asp:ListItem Text="45 minutes" Value="45" />
                        <asp:ListItem Text="60 minutes" Value="60" />
                    </asp:DropDownList>
                </div>
                <div class="form-group">
                    <label class="form-label">Estimated Preparation Time</label>
                    <asp:DropDownList ID="ddlPrepTime" runat="server" CssClass="form-control">
                        <asp:ListItem Text="30 minutes" Value="30" Selected="True" />
                        <asp:ListItem Text="45 minutes" Value="45" />
                        <asp:ListItem Text="60 minutes" Value="60" />
                    </asp:DropDownList>
                </div>
                <div class="form-group">
                    <label class="form-label">Estimated Delivery Time</label>
                    <asp:DropDownList ID="ddlDeliveryTime" runat="server" CssClass="form-control">
                        <asp:ListItem Text="30 minutes" Value="30" Selected="True" />
                        <asp:ListItem Text="45 minutes" Value="45" />
                        <asp:ListItem Text="60 minutes" Value="60" />
                    </asp:DropDownList>
                </div>
                <button type="button" class="btn-save"><i class="fas fa-save"></i> Save Changes</button>
            </div>

            <div id="payment" class="settings-card">
                <h3>Payment Settings</h3>
                
                <div class="form-group">
                    <label class="form-label">Enable Payment Methods</label>
                    
                    <div class="payment-method-row">
                        <div class="method-info">
                            <i class="fas fa-hand-holding-usd"></i>
                            <div class="method-text">
                                <b>Cash on Delivery</b>
                                <span>Pay with cash upon delivery</span>
                            </div>
                        </div>
                        <label class="switch">
                            <input type="checkbox" checked>
                            <span class="slider"></span>
                        </label>
                    </div>

                    <div class="payment-method-row">
                        <div class="method-info">
                            <i class="fas fa-wallet"></i>
                            <div class="method-text">
                                <b>GCash</b>
                                <span>Pay via GCash e-wallet</span>
                            </div>
                        </div>
                        <label class="switch">
                            <input type="checkbox" checked>
                            <span class="slider"></span>
                        </label>
                    </div>

                    <div class="payment-method-row">
                        <div class="method-info">
                            <i class="fas fa-mobile-alt"></i>
                            <div class="method-text">
                                <b>PayMaya</b>
                                <span>Pay via PayMaya e-wallet</span>
                            </div>
                        </div>
                        <label class="switch">
                            <input type="checkbox" checked>
                            <span class="slider"></span>
                        </label>
                    </div>

                    <div class="payment-method-row">
                        <div class="method-info">
                            <i class="fas fa-university"></i>
                            <div class="method-text">
                                <b>Bank Transfer</b>
                                <span>Direct bank transfer</span>
                            </div>
                        </div>
                        <label class="switch">
                            <input type="checkbox">
                            <span class="slider"></span>
                        </label>
                    </div>
                </div>

                <div class="form-group" style="margin-top: 25px;">
                    <label class="form-label">Payment Instructions</label>
                    <asp:TextBox ID="txtPaymentInstructions" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4" 
                        Text="Please ensure accurate payment details. For GCash/PayMaya, send payment screenshot. Bank transfers should include order reference number."></asp:TextBox>
                </div>

                <div class="form-group">
                    <label class="form-label">GCash Account Details</label>
                    <asp:TextBox ID="txtGCashDetails" runat="server" CssClass="form-control" Text="09171234567"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label class="form-label">Bank Account Details</label>
                    <asp:TextBox ID="txtBankDetails" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" 
                        Text="BDO - Account Name: Caballeros TasteNet&#10;Account Number: 1234567890"></asp:TextBox>
                </div>

                <button type="button" class="btn-save"><i class="fas fa-save"></i> Save Changes</button>
            </div>

            <div id="security" class="settings-card">
                <h3>User & Security</h3>
                
                <div class="form-group">
                    <label class="form-label" style="font-size: 16px; color: var(--primary-maroon); margin-bottom: 12px; font-weight: 700;">
                        <i class="fas fa-user-shield" style="margin-right: 10px;"></i>Admin Account Management
                    </label>
                    
                    <div class="payment-method-row" style="margin-top: 0; border: 2px solid #f3ebe0; background: #fefaf5;">
                        <div class="method-info">
                            <i class="fas fa-user-cog"></i>
                            <div class="method-text">
                                <b>Administrator</b>
                                <span style="color: var(--text-dark);">admin@caballerostastenet.com</span>
                            </div>
                        </div>
                        <button type="button" class="btn-save" style="padding: 6px 12px; font-size: 13px; margin: 0;">
                            <i class="fas fa-edit"></i> Edit
                        </button>
                    </div>
                    
                    <div style="margin-top: 15px;">
                        <button type="button" class="nav-item" style="margin-bottom: 0; width: auto; display: inline-flex; background: var(--soft-cream);">
                            <i class="fas fa-sliders-h"></i> System Controls
                        </button>
                        <button type="button" class="nav-item" style="margin-bottom: 0; width: auto; display: inline-flex; background: var(--soft-cream); margin-left: 10px;">
                            <i class="fas fa-user-plus"></i> Add Admin Account
                        </button>
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label" style="font-size: 16px; color: var(--primary-maroon); margin-bottom: 12px; font-weight: 700;">
                        <i class="fas fa-key" style="margin-right: 10px;"></i>Password Rules
                    </label>
                    
                    <div style="background: #fefaf5; border-radius: var(--radius-lg); padding: 16px; border: 2px solid #f3ebe0;">
                        <div style="display: flex; align-items: center; margin-bottom: 10px;">
                            <i class="fas fa-check-circle" style="color: var(--success-green); margin-right: 10px;"></i>
                            <span style="color: var(--text-dark); font-weight: 500;">Minimum 8 characters</span>
                        </div>
                        <div style="display: flex; align-items: center; margin-bottom: 10px;">
                            <i class="fas fa-check-circle" style="color: var(--success-green); margin-right: 10px;"></i>
                            <span style="color: var(--text-dark); font-weight: 500;">Require uppercase and lowercase letters</span>
                        </div>
                        <div style="display: flex; align-items: center; margin-bottom: 10px;">
                            <i class="fas fa-check-circle" style="color: var(--success-green); margin-right: 10px;"></i>
                            <span style="color: var(--text-dark); font-weight: 500;">Require numbers</span>
                        </div>
                        <div style="display: flex; align-items: center;">
                            <i class="fas fa-check-circle" style="color: var(--success-green); margin-right: 10px;"></i>
                            <span style="color: var(--text-dark); font-weight: 500;">Require special characters</span>
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label" style="font-size: 16px; color: var(--primary-maroon); margin-bottom: 12px; font-weight: 700;">
                        <i class="fas fa-clock" style="margin-right: 10px;"></i>Session Timeout
                    </label>
                    
                    <div class="grid-2-col">
                        <div>
                            <span>Timeout Duration</span>
                            <asp:DropDownList ID="ddlSessionTimeout" runat="server" CssClass="form-control">
                                <asp:ListItem Text="30 minutes" Value="30" />
                                <asp:ListItem Text="1 hour" Value="60" Selected="True" />
                                <asp:ListItem Text="2 hours" Value="120" />
                                <asp:ListItem Text="4 hours" Value="240" />
                            </asp:DropDownList>
                        </div>
                        <div>
                            <span style="margin-bottom: 8px; display: block;">Auto-logout Setting</span>
                            <div style="display: flex; align-items: center; gap: 12px;">
                                <label class="switch" style="flex-shrink: 0;">
                                    <input type="checkbox" checked>
                                    <span class="slider"></span>
                                </label>
                                <span style="font-weight: 600; color: var(--text-dark); flex: 1;">Auto-logout inactive sessions</span>
                            </div>
                        </div>
                    </div>
                    <div style="margin-top: 8px; color: var(--muted-text); font-size: 12px; font-style: italic;">
                        <i class="fas fa-info-circle" style="margin-right: 5px;"></i> Automatically log out inactive admin accounts
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label" style="font-size: 16px; color: var(--primary-maroon); margin-bottom: 12px; font-weight: 700;">
                        <i class="fas fa-shield-alt" style="margin-right: 10px;"></i>Two-Factor Authentication
                    </label>
                    
                    <div class="payment-method-row" style="border: 2px solid #f3ebe0; background: #fefaf5;">
                        <div class="method-info">
                            <i class="fas fa-mobile-alt"></i>
                            <div class="method-text">
                                <b>Enable 2FA for Admin Accounts</b>
                                <span>Require OTP verification on login</span>
                            </div>
                        </div>
                        <label class="switch">
                            <input type="checkbox">
                            <span class="slider"></span>
                        </label>
                    </div>
                    
                    <div style="margin-top: 12px; padding: 12px; background: #f9f4ee; border-radius: var(--radius-lg); border-left: 4px solid var(--accent-yellow);">
                        <div style="display: flex; align-items: center;">
                            <i class="fas fa-exclamation-triangle" style="color: var(--accent-yellow); font-size: 16px; margin-right: 10px;"></i>
                            <div>
                                <b style="color: var(--text-dark);">Security Recommendation</b><br>
                                <span style="color: var(--muted-text); font-size: 12px;">Enabling 2FA adds an extra layer of security by requiring a one-time password from an authenticator app.</span>
                            </div>
                        </div>
                    </div>
                </div>

                <button type="button" class="btn-save"><i class="fas fa-save"></i> Save Changes</button>
            </div>

            <div id="system" class="settings-card">
                <h3>System Controls</h3>
                
                <div class="form-group">
                    <label class="form-label" style="font-size: 16px; color: var(--primary-maroon); margin-bottom: 12px; font-weight: 700;">
                        <i class="fas fa-database" style="margin-right: 10px;"></i>Database Management
                    </label>
                    
                    <div class="payment-method-row" style="border: 2px solid #f3ebe0; background: #fefaf5; flex-direction: column; align-items: flex-start; gap: 12px;">
                        <div class="method-info" style="width: 100%;">
                            <i class="fas fa-save" style="background: #e3f2fd; color: #1565c0;"></i>
                            <div class="method-text" style="flex: 1;">
                                <b>Backup Database</b>
                                <span>Create a backup of all data</span>
                            </div>
                            <button type="button" class="btn-save" style="padding: 8px 16px; font-size: 13px; margin: 0; background: #1565c0; color: white;">
                                <i class="fas fa-download"></i> Backup Now
                            </button>
                        </div>
                        <div style="width: 100%; padding: 8px 12px; background: #f5f5f5; border-radius: var(--radius-lg); font-size: 12px; color: var(--muted-text);">
                            <i class="fas fa-history" style="margin-right: 8px;"></i> 
                            Last backup: <b>January 7, 2026 at 11:45 PM</b>
                        </div>
                    </div>

                    <div class="payment-method-row" style="border: 2px solid #f3ebe0; background: #fefaf5; margin-top: 12px;">
                        <div class="method-info">
                            <i class="fas fa-history" style="background: #e8f5e9; color: #2e7d32;"></i>
                            <div class="method-text">
                                <b>Restore Database</b>
                                <span>Restore from a previous backup</span>
                            </div>
                        </div>
                        <button type="button" class="btn-save" style="padding: 8px 16px; font-size: 13px; margin: 0; background: #2e7d32; color: white;">
                            <i class="fas fa-undo"></i> Restore
                        </button>
                    </div>

                    <div class="payment-method-row" style="border: 2px solid #f3ebe0; background: #fefaf5; margin-top: 12px;">
                        <div class="method-info">
                            <i class="fas fa-robot" style="background: #fff3e0; color: #f57c00;"></i>
                            <div class="method-text">
                                <b>Automatic Backups</b>
                                <span>Backup database every day at midnight</span>
                            </div>
                        </div>
                        <label class="switch">
                            <input type="checkbox" checked>
                            <span class="slider"></span>
                        </label>
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label" style="font-size: 16px; color: var(--primary-maroon); margin-bottom: 12px; font-weight: 700;">
                        <i class="fas fa-tools" style="margin-right: 10px;"></i>Maintenance Mode
                    </label>
                    
                    <div class="payment-method-row" style="border: 2px solid #f3ebe0; background: #fefaf5;">
                        <div class="method-info">
                            <i class="fas fa-wrench" style="background: #fce4ec; color: #c2185b;"></i>
                            <div class="method-text">
                                <b>Enable Maintenance Mode</b>
                                <span>Temporarily disable customer access for maintenance</span>
                            </div>
                        </div>
                        <label class="switch">
                            <input type="checkbox">
                            <span class="slider"></span>
                        </label>
                    </div>
                    
                    <div style="margin-top: 8px; padding: 12px; background: #fff8e1; border-radius: var(--radius-lg); border-left: 4px solid #ffb300;">
                        <div style="display: flex; align-items: center;">
                            <i class="fas fa-exclamation-circle" style="color: #ffb300; font-size: 16px; margin-right: 10px;"></i>
                            <div>
                                <b style="color: var(--text-dark);">Warning</b><br>
                                <span style="color: var(--muted-text); font-size: 12px;">When enabled, customers will see a maintenance page and won't be able to place orders.</span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label" style="font-size: 16px; color: var(--primary-maroon); margin-bottom: 12px; font-weight: 700;">
                        <i class="fas fa-clipboard-list" style="margin-right: 10px;"></i>Audit Logs
                    </label>
                    
                    <div class="payment-method-row" style="border: 2px solid #f3ebe0; background: #fefaf5;">
                        <div class="method-info">
                            <i class="fas fa-file-alt" style="background: #e8eaf6; color: #3949ab;"></i>
                            <div class="method-text">
                                <b>View Audit Logs</b>
                                <span>Track all admin activities and changes</span>
                            </div>
                        </div>
                        <button type="button" class="btn-save" style="padding: 8px 16px; font-size: 13px; margin: 0; background: #3949ab; color: white;">
                            <i class="fas fa-search"></i> View Logs
                        </button>
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label" style="font-size: 16px; color: var(--primary-maroon); margin-bottom: 12px; font-weight: 700;">
                        <i class="fas fa-info-circle" style="margin-right: 10px;"></i>System Information
                    </label>
                    
                    <div style="background: #fefaf5; border-radius: var(--radius-lg); padding: 16px; border: 2px solid #f3ebe0;">
                        <div class="grid-2-col">
                            <div>
                                <div style="margin-bottom: 15px;">
                                    <div style="font-size: 12px; color: var(--muted-text); margin-bottom: 5px;">Platform Version</div>
                                    <div style="font-size: 14px; font-weight: 700; color: var(--primary-maroon);">v2.1.0</div>
                                </div>
                                <div style="margin-bottom: 15px;">
                                    <div style="font-size: 12px; color: var(--muted-text); margin-bottom: 5px;">Total Orders</div>
                                    <div style="font-size: 14px; font-weight: 700; color: var(--primary-maroon);">1,847</div>
                                </div>
                            </div>
                            <div>
                                <div style="margin-bottom: 15px;">
                                    <div style="font-size: 12px; color: var(--muted-text); margin-bottom: 5px;">Database Size</div>
                                    <div style="font-size: 14px; font-weight: 700; color: var(--primary-maroon);">245 MB</div>
                                </div>
                                <div>
                                    <div style="font-size: 12px; color: var(--muted-text); margin-bottom: 5px;">Storage Used</div>
                                    <div style="font-size: 14px; font-weight: 700; color: var(--primary-maroon);">1.2 GB / 10 GB</div>
                                    <div style="height: 6px; background: #e0e0e0; border-radius: 3px; margin-top: 5px; overflow: hidden;">
                                        <div style="width: 12%; height: 100%; background: var(--primary-maroon); border-radius: 3px;"></div>
                                    </div>
                                    <div style="font-size: 11px; color: var(--muted-text); margin-top: 5px;">12% of storage used</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <button type="button" class="btn-save"><i class="fas fa-save"></i> Save Changes</button>
            </div>
        </div>
    </div>

    <script>
        function showTab(tabId, element) {
            document.querySelectorAll('.settings-card').forEach(card => {
                card.classList.remove('active');
            });

            document.querySelectorAll('.nav-item').forEach(nav => {
                nav.classList.remove('active');
            });

            const selectedCard = document.getElementById(tabId);
            if (selectedCard) {
                selectedCard.classList.add('active');
            }

            element.classList.add('active');

            if (selectedCard) {
                selectedCard.style.opacity = '0';
                selectedCard.style.transform = 'translateY(10px)';

                setTimeout(() => {
                    selectedCard.style.transition = 'all 0.3s ease';
                    selectedCard.style.opacity = '1';
                    selectedCard.style.transform = 'translateY(0)';
                }, 10);
            }
        }

        document.querySelectorAll('.form-control').forEach(input => {
            input.addEventListener('mouseenter', function () {
                this.style.transform = 'translateY(-2px)';
            });

            input.addEventListener('mouseleave', function () {
                if (document.activeElement !== this) {
                    this.style.transform = 'translateY(0)';
                }
            });
        });

        document.querySelectorAll('.payment-method-row').forEach(row => {
            row.addEventListener('mouseenter', function () {
                const icon = this.querySelector('.method-info i');
                if (icon) {
                    icon.style.transform = 'scale(1.1) rotate(5deg)';
                }
            });

            row.addEventListener('mouseleave', function () {
                const icon = this.querySelector('.method-info i');
                if (icon) {
                    icon.style.transform = 'scale(1) rotate(0)';
                }
            });
        });
    </script>
</asp:Content>