<%@ Page Title="Platform Settings" Language="C#" MasterPageFile="~/MasterPages/SuperAdmin.Master" AutoEventWireup="true" CodeBehind="Settings.aspx.cs" Inherits="TasteNet.Users.SuperAdmin.Settings" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

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
            --border-light: #e2d1d1;
            --border-hover: #d4b8b8;
            --bg-hover: #fefaf5;
            --bg-light: #f3ebe0;
            --bg-lighter: #f9f4ee;
            --card-shadow: 0 10px 30px rgba(107, 13, 30, 0.05);
            --card-shadow-hover: 0 15px 40px rgba(107, 13, 30, 0.12);
            --button-shadow: 0 4px 12px rgba(107, 13, 30, 0.2);
            --radius-sm: 8px;
            --radius-md: 10px;
            --radius-lg: 12px;
            --radius-xl: 16px;
            --transition-base: 0.3s ease;
        }

        body, form {
            background: var(--soft-cream) !important;
            font-family: 'Poppins', sans-serif;
        }

        #settings-wrapper {
            padding: 20px 30px;
            max-width: 1600px;
            margin: 0 auto;
            min-height: 100vh;
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            flex-wrap: wrap;
            gap: 15px;
        }

        .header-title h2 {
            color: var(--text-dark);
            font-weight: 700;
            margin: 0;
            font-size: 28px;
            letter-spacing: -0.5px;
        }

        .header-title p {
            color: var(--muted-text);
            margin: 5px 0 0;
            font-size: 14px;
        }


        .nav-item {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            padding: 10px 20px;
            border-radius: var(--radius-md);
            color: var(--text-dark);
            text-decoration: none;
            font-weight: 600;
            font-size: 14px;
            transition: all var(--transition-base);
            cursor: pointer;
            border: 2px solid transparent;
            background: none;
            letter-spacing: 0.2px;
        }

        .nav-item:hover {
            background: var(--bg-hover);
            color: var(--primary-maroon);
            border-color: var(--border-light);
            transform: translateY(-2px);
        }

        .nav-item.active {
            background: var(--primary-maroon);
            color: white;
            box-shadow: var(--button-shadow);
        }

        .nav-item i {
            font-size: 16px;
            width: 20px;
            text-align: center;
            transition: transform var(--transition-base);
        }

        .nav-item:hover i {
            transform: scale(1.1);
        }

        .settings-card {
            background: white;
            border-radius: var(--radius-lg);
            padding: 25px;
            box-shadow: var(--card-shadow);
            display: none;
            transition: transform var(--transition-base), box-shadow var(--transition-base);
        }

        .settings-card.active {
            display: block;
            animation: fadeIn 0.5s ease;
        }

        .settings-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--card-shadow-hover);
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .settings-card h3 {
            color: var(--primary-maroon);
            font-weight: 700;
            margin-bottom: 20px;
            font-size: 20px;
            letter-spacing: -0.3px;
            padding-bottom: 12px;
            border-bottom: 2px solid var(--bg-light);
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-label {
            display: block;
            color: var(--text-dark);
            font-weight: 600;
            font-size: 13px;
            margin-bottom: 8px;
            letter-spacing: 0.2px;
        }

        .form-control {
            width: 100%;
            padding: 10px 15px;
            border-radius: var(--radius-md);
            border: 2px solid var(--border-light);
            background: white;
            font-family: 'Poppins', sans-serif;
            font-size: 13px;
            font-weight: 500;
            color: var(--text-dark);
            transition: all var(--transition-base);
            box-sizing: border-box;
        }

        .form-control:focus {
            border-color: var(--primary-maroon);
            box-shadow: 0 0 0 3px rgba(107, 13, 30, 0.1);
            outline: none;
        }

        .form-control:hover {
            border-color: var(--primary-maroon);
        }

        select.form-control {
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='%238a6d6d' viewBox='0 0 16 16'%3E%3Cpath d='M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 15px center;
            background-size: 14px;
            padding-right: 40px;
            cursor: pointer;
        }

        textarea.form-control {
            min-height: 100px;
            resize: vertical;
            line-height: 1.6;
        }

        .grid-2-col {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 16px;
        }

        .pm-table-wrap {
            overflow-x: auto;
            border-radius: var(--radius-lg);
            border: 2px solid var(--bg-light);
            margin-top: 10px;
        }

        .pm-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 13px;
            font-family: 'Poppins', sans-serif;
            min-width: 800px;
        }

        .pm-table thead {
            background: white;
            border-bottom: 2px solid var(--bg-light);
        }

        .pm-table thead th {
            padding: 16px 12px;
            text-align: left;
            font-weight: 600;
            font-size: 12px;
            color: var(--muted-text);
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .pm-table tbody tr {
            transition: all var(--transition-base);
            border-left: 3px solid transparent;
        }

        .pm-table tbody tr:hover {
            background: var(--bg-hover);
            border-left-color: var(--primary-maroon);
            transform: translateX(2px);
        }

        .pm-table td {
            padding: 14px 12px;
            border-bottom: 1px solid var(--bg-lighter);
            color: var(--text-dark);
            vertical-align: middle;
        }

        .pm-table td.method-cell {
            font-weight: 600;
        }

        .pm-table td.method-cell i {
            color: var(--primary-maroon);
            font-size: 18px;
            width: 30px;
        }

        .badge-active {
            display: inline-block;
            padding: 4px 12px;
            border-radius: var(--radius-sm);
            font-size: 11px;
            font-weight: 700;
            background: var(--success-green-light);
            color: var(--success-green);
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .badge-inactive {
            display: inline-block;
            padding: 4px 12px;
            border-radius: var(--radius-sm);
            font-size: 11px;
            font-weight: 700;
            background: var(--danger-red-light);
            color: var(--danger-red);
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .switch {
            position: relative;
            display: inline-block;
            width: 50px;
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
            background-color: var(--border-light);
            transition: var(--transition-base);
            border-radius: 34px;
        }

        .slider:before {
            position: absolute;
            content: "";
            height: 16px;
            width: 16px;
            left: 4px;
            bottom: 4px;
            background-color: white;
            transition: var(--transition-base);
            border-radius: 50%;
        }

        input:checked + .slider {
            background-color: var(--success-green);
        }

        input:checked + .slider:before {
            transform: translateX(26px);
        }

        .qr-thumb {
            width: 40px;
            height: 40px;
            object-fit: cover;
            border-radius: var(--radius-sm);
            border: 2px solid var(--border-light);
            cursor: pointer;
            transition: transform var(--transition-base);
        }

        .qr-thumb:hover {
            transform: scale(1.1);
            border-color: var(--primary-maroon);
        }

        .no-qr {
            font-size: 11px;
            color: var(--muted-text);
            font-style: italic;
        }

        .action-icons {
            display: flex;
            gap: 8px;
            justify-content: flex-start;
        }

        .btn-icon-edit, .btn-icon-delete {
            width: 32px;
            height: 32px;
            border-radius: var(--radius-sm);
            border: none;
            cursor: pointer;
            transition: all var(--transition-base);
            font-size: 14px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            text-decoration: none;
        }

        .btn-icon-edit {
            background: var(--bg-lighter);
            color: var(--muted-text);
        }

        .btn-icon-edit:hover {
            background: var(--success-green);
            color: white;
            transform: translateY(-2px);
        }

        .btn-icon-delete {
            background: var(--bg-lighter);
            color: var(--muted-text);
        }

        .btn-icon-delete:hover {
            background: var(--danger-red);
            color: white;
            transform: translateY(-2px);
        }

        .btn-save {
            background: var(--success-green);
            color: white;
            border: none;
            border-radius: var(--radius-md);
            padding: 12px 24px;
            font-weight: 600;
            font-size: 13px;
            cursor: pointer;
            transition: all var(--transition-base);
            display: inline-flex;
            align-items: center;
            gap: 10px;
            margin-top: 20px;
            font-family: 'Poppins', sans-serif;
        }

        .btn-save:hover {
            background: #259469;
            transform: translateY(-2px);
            box-shadow: var(--button-shadow);
        }

        .btn-save i {
            font-size: 14px;
            transition: transform var(--transition-base);
        }

        .btn-save:hover i {
            transform: scale(1.1);
        }

        .pm-modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0, 0, 0, 0.7);
            backdrop-filter: blur(5px);
            display: none;
            justify-content: center;
            align-items: center;
            z-index: 10000;
        }

        .pm-modal-overlay.open {
            display: flex;
        }

        .pm-modal {
            background: white;
            border-radius: var(--radius-xl);
            width: 520px;
            max-width: 90vw;
            max-height: 90vh;
            overflow-y: auto;
            animation: slideUp 0.3s ease;
            box-shadow: 0 20px 60px rgba(107, 13, 30, 0.3);
        }

        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .pm-modal h4 {
            padding: 20px 25px;
            background: linear-gradient(135deg, var(--primary-maroon), var(--primary-maroon-dark));
            color: white;
            border-radius: var(--radius-xl) var(--radius-xl) 0 0;
            margin: 0;
            font-size: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .pm-modal .form-group {
            padding: 0 25px;
            margin-bottom: 20px;
        }

        .pm-modal-footer {
            padding: 20px 25px;
            border-top: 2px solid var(--bg-light);
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            background: var(--bg-lighter);
            border-radius: 0 0 var(--radius-xl) var(--radius-xl);
        }

        .btn-modal-save {
            background: var(--success-green);
            color: white;
            border: none;
            border-radius: var(--radius-md);
            padding: 10px 24px;
            font-weight: 600;
            font-size: 13px;
            cursor: pointer;
            font-family: 'Poppins', sans-serif;
            transition: all var(--transition-base);
        }

        .btn-modal-save:hover {
            background: #259469;
            transform: translateY(-2px);
        }

        .btn-modal-cancel {
            background: transparent;
            color: var(--primary-maroon);
            border: 2px solid var(--border-light);
            border-radius: var(--radius-md);
            padding: 10px 20px;
            font-weight: 600;
            font-size: 13px;
            cursor: pointer;
            font-family: 'Poppins', sans-serif;
            transition: all var(--transition-base);
        }

        .btn-modal-cancel:hover {
            background: var(--bg-hover);
            border-color: var(--primary-maroon);
            transform: translateY(-2px);
        }

        .qr-preview-wrap {
            margin-top: 12px;
            text-align: center;
        }

        .qr-preview-wrap img {
            max-width: 140px;
            border-radius: var(--radius-md);
            border: 2px solid var(--border-light);
            padding: 4px;
        }

        .message-container {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 10001;
            animation: slideInRight 0.3s ease;
        }

        @keyframes slideInRight {
            from {
                transform: translateX(100%);
                opacity: 0;
            }
            to {
                transform: translateX(0);
                opacity: 1;
            }
        }

        @keyframes slideOutRight {
            from {
                transform: translateX(0);
                opacity: 1;
            }
            to {
                transform: translateX(100%);
                opacity: 0;
            }
        }

        .alert-message {
            padding: 15px 20px;
            border-radius: var(--radius-md);
            margin-bottom: 10px;
            box-shadow: var(--card-shadow-hover);
            display: flex;
            align-items: center;
            gap: 12px;
            font-weight: 500;
            font-size: 13px;
            min-width: 280px;
        }

        .alert-success {
            background: var(--success-green);
            color: white;
        }

        .alert-error {
            background: var(--danger-red);
            color: white;
        }

        .alert-message i {
            font-size: 18px;
        }

        #qrLightbox {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0, 0, 0, 0.9);
            backdrop-filter: blur(8px);
            display: none;
            justify-content: center;
            align-items: center;
            z-index: 20000;
            cursor: pointer;
        }

        #qrLightbox.open {
            display: flex;
        }

        #qrLightboxImg {
            max-width: 90vw;
            max-height: 85vh;
            border-radius: var(--radius-lg);
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.4);
        }

        @media (max-width: 768px) {
            #settings-wrapper {
                padding: 15px;
            }
            
            .page-header {
                flex-direction: column;
                align-items: stretch;
            }
            
           
            
            .nav-item {
                white-space: nowrap;
                padding: 8px 16px;
                font-size: 13px;
            }
            
            .settings-card {
                padding: 20px;
            }
            
            .grid-2-col {
                grid-template-columns: 1fr;
                gap: 12px;
            }
            
            .pm-table-wrap {
                overflow-x: auto;
            }
            
            .pm-table {
                font-size: 12px;
            }
            
            .pm-table th,
            .pm-table td {
                padding: 10px 8px;
            }
            
            .action-icons {
                gap: 5px;
            }
            
            .btn-icon-edit, .btn-icon-delete {
                width: 28px;
                height: 28px;
                font-size: 12px;
            }
        }

        @media (max-width: 480px) {
            .header-title h2 {
                font-size: 22px;
            }
            
            .settings-card h3 {
                font-size: 18px;
            }
            
            .btn-save {
                width: 100%;
                justify-content: center;
            }
            
            .pm-modal-footer {
                flex-direction: column;
            }
            
            .pm-modal-footer button {
                width: 100%;
                justify-content: center;
            }
        }
    </style>

    <div id="settings-wrapper">
        <div class="page-header">
            <div class="header-title">
                <h2>Platform Settings</h2>
                <p>Configure system-wide settings and preferences</p>
            </div>
        </div>

        <asp:Panel ID="pnlMessage" runat="server" CssClass="message-container" Visible="false">
            <div class="alert-message" id="messageDiv" runat="server">
                <i class="fas" id="messageIcon" runat="server"></i>
                <span id="messageText" runat="server"></span>
            </div>
        </asp:Panel>


        <div class="settings-layout">
            <div id="payment" class="settings-card active">
                <h3>
                    <i class="fas fa-credit-card"></i>
                    Payment Methods
                </h3>

                <asp:HiddenField ID="hfEditId" runat="server" />
                <asp:HiddenField ID="hfEditMethod" runat="server" />

                <div class="pm-table-wrap">
                    <asp:Repeater ID="rptPaymentMethods" runat="server"
                                  OnItemCommand="rptPaymentMethods_ItemCommand">
                        <HeaderTemplate>
                            <table class="pm-table">
                                <thead>
                                    <tr>
                                        <th>Payment Method</th>
                                        <th>Account Details</th>
                                        <th>Instructions</th>
                                        <th style="text-align:center;">Status</th>
                                        <th style="text-align:center;">QR Photo</th>
                                        <th style="text-align:center;">Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <td class="method-cell">
                                    <div style="display:flex; align-items:center; gap:10px;">
                                        <i class="<%# GetMethodIcon(Eval("MethodName").ToString()) %>"></i>
                                        <%# Eval("MethodName") %>
                                    </div>
                                </td>
                                <td style="max-width:160px; word-break:break-word;">
                                    <%# string.IsNullOrEmpty(Eval("AccountDetails") != DBNull.Value ? Eval("AccountDetails").ToString() : "")
                                            ? "<span class='no-qr'>—</span>"
                                            : System.Web.HttpUtility.HtmlEncode(Eval("AccountDetails").ToString()) %>
                                </td>
                                <td style="max-width:200px; word-break:break-word;">
                                    <%# string.IsNullOrEmpty(Eval("Instructions") != DBNull.Value ? Eval("Instructions").ToString() : "")
                                            ? "<span class='no-qr'>—</span>"
                                            : System.Web.HttpUtility.HtmlEncode(Eval("Instructions").ToString()) %>
                                </td>
                                <td style="text-align:center;">
                                    <asp:LinkButton runat="server"
                                        CommandName="ToggleStatus"
                                        CommandArgument='<%# Eval("PaymentMethodId") %>'
                                        CausesValidation="false"
                                        title='<%# Convert.ToBoolean(Eval("IsEnabled")) ? "Click to disable" : "Click to enable" %>'
                                        style="text-decoration:none;">
                                        <label class="switch" style="pointer-events:none; margin-bottom:4px;">
                                            <input type="checkbox"
                                                   <%# Convert.ToBoolean(Eval("IsEnabled")) ? "checked=\"checked\"" : "" %>
                                                   disabled="disabled" />
                                            <span class="slider"></span>
                                        </label>
                                        <div style="margin-top:6px;">
                                            <span class='<%# Convert.ToBoolean(Eval("IsEnabled")) ? "badge-active" : "badge-inactive" %>'>
                                                <%# Convert.ToBoolean(Eval("IsEnabled")) ? "Active" : "Inactive" %>
                                            </span>
                                        </div>
                                    </asp:LinkButton>
                                </td>
                                <td style="text-align:center;">
                                    <%# (Eval("QRPhoto") != DBNull.Value && !string.IsNullOrEmpty(Eval("QRPhoto").ToString()))
                                        ? string.Format("<img src='{0}' class='qr-thumb' onclick='openQRPreview(\"{0}\")' title='Click to enlarge' />", Eval("QRPhoto"))
                                        : "<span class='no-qr'>None</span>" %>
                                </td>
                                <td style="text-align:center;">
                                    <div class="action-icons">
                                        <asp:LinkButton runat="server"
                                            CommandName="EditMethod"
                                            CommandArgument='<%# Eval("PaymentMethodId") %>'
                                            CssClass="btn-icon-edit"
                                            CausesValidation="false"
                                            title="Edit">
                                            <i class="fas fa-pen"></i>
                                        </asp:LinkButton>
                                        <asp:LinkButton runat="server"
                                            CommandName="DeleteMethod"
                                            CommandArgument='<%# Eval("PaymentMethodId") %>'
                                            CssClass="btn-icon-delete"
                                            CausesValidation="false"
                                            title="Delete"
                                            OnClientClick="return confirm('Delete this payment method?');">
                                            <i class="fas fa-trash"></i>
                                        </asp:LinkButton>
                                    </div>
                                </td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                                </tbody>
                            </table>
                        </FooterTemplate>
                    </asp:Repeater>
                </div>

                <asp:Button ID="btnSavePayment" runat="server" CssClass="btn-save"
                            OnClick="btnSavePayment_Click" Text="Refresh Methods" />
            </div>
        </div>
    </div>

    <div class="pm-modal-overlay" id="pmEditModal">
        <div class="pm-modal">
            <h4><i class="fas fa-edit"></i> Edit Payment Method</h4>

            <div class="form-group">
                <label class="form-label">Method Name</label>
                <asp:TextBox ID="txtEditMethodName" runat="server" CssClass="form-control"
                             ReadOnly="true" style="background:#f5f5f5; cursor:not-allowed;"></asp:TextBox>
            </div>

            <div class="form-group">
                <label class="form-label">Enabled</label>
                <div style="display:flex; align-items:center; gap:12px; margin-top:4px;">
                    <label class="switch" style="flex-shrink:0;">
                        <asp:CheckBox ID="chkEditEnabled" runat="server" />
                        <span class="slider"></span>
                    </label>
                    <span style="font-weight:600; color:var(--text-dark); flex:1;">Allow customers to use this payment method</span>
                </div>
            </div>

            <div class="form-group">
                <label class="form-label">Display Order</label>
                <asp:TextBox ID="txtEditDisplayOrder" runat="server" CssClass="form-control"
                             TextMode="Number" placeholder="e.g. 1"></asp:TextBox>
            </div>

            <div class="form-group">
                <label class="form-label">Account Details</label>
                <asp:TextBox ID="txtEditAccountDetails" runat="server" CssClass="form-control"
                             TextMode="MultiLine" Rows="3"
                             placeholder="e.g. GCash number, bank account info..."></asp:TextBox>
            </div>

            <div class="form-group">
                <label class="form-label">Instructions</label>
                <asp:TextBox ID="txtEditInstructions" runat="server" CssClass="form-control"
                             TextMode="MultiLine" Rows="3"
                             placeholder="Payment instructions shown to customers..."></asp:TextBox>
            </div>

            <div class="form-group">
                <label class="form-label">Status</label>
                <asp:DropDownList ID="ddlEditStatus" runat="server" CssClass="form-control">
                    <asp:ListItem Text="Active" Value="Active" />
                    <asp:ListItem Text="Inactive" Value="Inactive" />
                </asp:DropDownList>
            </div>

            <div class="form-group">
                <label class="form-label">QR Code Photo</label>
                <asp:FileUpload ID="fileEditQR" runat="server" CssClass="form-control" style="padding:8px;" />
                <div class="qr-preview-wrap" id="qrPreviewWrap" runat="server"></div>
                <div style="font-size:12px; color:var(--muted-text); margin-top:6px;">
                    <i class="fas fa-info-circle" style="margin-right:4px;"></i>
                    PNG, JPG, WEBP — max 2 MB. Leave blank to keep the existing image.
                </div>
            </div>

            <div class="pm-modal-footer">
                <button type="button" class="btn-modal-cancel" onclick="closePmModal()">Cancel</button>
                <asp:Button ID="btnSaveEditMethod" runat="server"
                            CssClass="btn-modal-save"
                            OnClick="btnSaveEditMethod_Click"
                            Text="Save Method"
                            CausesValidation="false" />
                    </div>
                </div>
            </div>

            <div id="qrLightbox" onclick="closeQRPreview()">
                <div style="text-align:center;">
                    <img id="qrLightboxImg" src="" alt="QR Code" />
                    <div style="color:white; margin-top:12px; font-size:13px;">Click anywhere to close</div>
                </div>
            </div>

    <script>
        function showTab(tabId, element) {
            document.querySelectorAll('.settings-card').forEach(c => c.classList.remove('active'));
            document.querySelectorAll('.nav-item').forEach(n => n.classList.remove('active'));

            var card = document.getElementById(tabId);
            if (card) {
                card.classList.add('active');
            }
            element.classList.add('active');
        }

        function hideMessage() {
            var msg = document.querySelector('.message-container');
            if (msg) {
                setTimeout(function () {
                    msg.style.animation = 'slideOutRight 0.3s ease';
                    setTimeout(function () { msg.style.display = 'none'; }, 300);
                }, 5000);
            }
        }
        document.addEventListener('DOMContentLoaded', hideMessage);

        function openPmModal() {
            document.getElementById('pmEditModal').classList.add('open');
            document.body.style.overflow = 'hidden';
        }

        function closePmModal() {
            document.getElementById('pmEditModal').classList.remove('open');
            document.body.style.overflow = '';
        }

        document.getElementById('pmEditModal').addEventListener('click', function (e) {
            if (e.target === this) closePmModal();
        });

        function openQRPreview(src) {
            document.getElementById('qrLightboxImg').src = src;
            document.getElementById('qrLightbox').classList.add('open');
        }

        function closeQRPreview() {
            document.getElementById('qrLightbox').classList.remove('open');
        }

        document.addEventListener('keydown', function (e) {
            if (e.key === 'Escape') {
                closePmModal();
                closeQRPreview();
            }
        });
    </script>
</asp:Content>