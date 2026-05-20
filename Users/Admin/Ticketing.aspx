<%@ Page Title="Ticketing System" Language="C#" MasterPageFile="~/MasterPages/Admin.Master" AutoEventWireup="true" CodeBehind="Ticketing.aspx.cs" Inherits="TasteNet.Users.Admin.Ticketing" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
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

    .ticketing-container {
        padding: 20px 30px !important;
        max-width: 1600px !important;
        margin: 0 auto !important;
        min-height: 100vh !important;
    }

    .page-header-main {
        display: flex !important;
        justify-content: space-between !important;
        align-items: center !important;
        margin-bottom: 30px !important;
        flex-wrap: wrap !important;
        gap: 15px !important;
    }

    .header-title h2 {
        color: var(--text-dark) !important;
        font-weight: 700 !important;
        margin: 0 !important;
        font-size: 28px !important;
        letter-spacing: -0.5px !important;
    }

    .header-title p {
        color: var(--muted-text) !important;
        margin: 5px 0 0 !important;
        font-size: 14px !important;
    }

    .status-tabs-container {
        display: flex !important;
        gap: 10px !important;
        align-items: center !important;
        background: white !important;
        padding: 4px !important;
        border-radius: var(--radius-md) !important;
        box-shadow: var(--card-shadow) !important;
        border: 1px solid var(--border-light) !important;
    }

    .status-tab {
        padding: 10px 20px !important;
        border-radius: var(--radius-sm) !important;
        font-size: 13px !important;
        font-weight: 600 !important;
        cursor: pointer !important;
        transition: all var(--transition-base) !important;
        display: flex !important;
        align-items: center !important;
        gap: 8px !important;
        background: transparent !important;
        color: var(--text-dark) !important;
        border: none !important;
        text-decoration: none !important;
    }

    .status-tab:hover {
        background: var(--bg-hover) !important;
        transform: translateY(-2px) !important;
        text-decoration: none !important;
    }

    .status-tab.active {
        background: var(--primary-maroon) !important;
        color: white !important;
        box-shadow: var(--button-shadow) !important;
    }

    .status-badge {
        background: rgba(255, 255, 255, 0.2) !important;
        padding: 2px 8px !important;
        border-radius: 12px !important;
        font-size: 11px !important;
        font-weight: 600 !important;
        min-width: 24px !important;
        text-align: center !important;
    }

    .status-tab.active .status-badge {
        background: rgba(255, 255, 255, 0.3) !important;
    }

    .tickets-grid {
        display: grid !important;
        grid-template-columns: repeat(3, minmax(0, 1fr)) !important;
        gap: 20px !important;
        margin-top: 20px !important;
        width: 100% !important;
    }

    .ticket-card {
        background: white !important;
        border-radius: var(--radius-lg) !important;
        overflow: visible !important;
        box-shadow: var(--card-shadow) !important;
        transition: box-shadow var(--transition-base), border-left-color var(--transition-base) !important;
        position: relative !important;
        border: 1px solid var(--border-light) !important;
        width: 100% !important;
        display: flex !important;
        flex-direction: column !important;
        animation: fadeInUp 0.5s ease-out !important;
        border-left: 3px solid transparent;
    }

    @keyframes fadeInUp {
        from {
            opacity: 0;
            transform: translateY(20px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    .ticket-card:hover {
        box-shadow: var(--card-shadow-hover) !important;
        border-left-color: var(--primary-maroon) !important;
    }

    .ticket-icon-bg {
        position: absolute;
        top: -15px;
        right: -15px;
        width: 80px;
        height: 80px;
        background: var(--primary-maroon);
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        opacity: 0.12;
        z-index: 0;
    }

    .ticket-icon-bg i {
        font-size: 55px;
        color: white;
        transform: rotate(15deg);
    }

    .ticket-header {
        background: linear-gradient(135deg, var(--primary-maroon) 0%, var(--primary-maroon-dark) 100%) !important;
        color: white !important;
        padding: 14px 16px !important;
        position: relative !important;
        z-index: 1;
        border-radius: var(--radius-lg) var(--radius-lg) 0 0 !important;
    }

    .ticket-title {
        font-size: 14px !important;
        font-weight: 700 !important;
        margin-bottom: 6px !important;
        display: flex !important;
        align-items: center !important;
        gap: 6px !important;
        position: relative !important;
        z-index: 1 !important;
        flex-wrap: wrap !important;
        padding-right: 40px !important;
    }

    .order-number {
        font-size: 11px !important;
        opacity: 0.9 !important;
        font-weight: 400 !important;
        background: rgba(255, 255, 255, 0.15) !important;
        padding: 2px 8px !important;
        border-radius: 12px !important;
        margin-bottom: 6px !important;
        display: inline-flex !important;
        align-items: center !important;
        gap: 5px !important;
    }

    .order-number i {
        font-size: 9px !important;
    }

    .ticket-time {
        font-size: 10px !important;
        opacity: 0.85 !important;
        font-weight: 400 !important;
        margin: 0 !important;
        position: relative !important;
        z-index: 1 !important;
        display: flex !important;
        align-items: center !important;
        gap: 5px !important;
    }

    .status-dot {
        width: 8px !important;
        height: 8px !important;
        border-radius: 50% !important;
        display: inline-block !important;
        animation: pulse 2s infinite !important;
    }

    .status-dot.open {
        background-color: #ff4444 !important;
        box-shadow: 0 0 6px rgba(255, 68, 68, 0.5) !important;
    }

    .status-dot.inprogress {
        background-color: #ffa500 !important;
        box-shadow: 0 0 6px rgba(255, 165, 0, 0.5) !important;
    }

    .status-dot.completed {
        background-color: #00c851 !important;
        box-shadow: 0 0 6px rgba(0, 200, 81, 0.5) !important;
    }

    .status-dot.cancelled {
        background-color: #9ca3af !important;
        box-shadow: 0 0 6px rgba(156, 163, 175, 0.5) !important;
        animation: none !important;
    }

    .ticket-action {
        position: absolute !important;
        right: 12px !important;
        top: 50% !important;
        transform: translateY(-50%) !important;
        background: rgba(255, 255, 255, 0.2) !important;
        width: 30px !important;
        height: 30px !important;
        border-radius: 50% !important;
        display: flex !important;
        align-items: center !important;
        justify-content: center !important;
        cursor: pointer !important;
        transition: all var(--transition-base) !important;
        z-index: 2 !important;
        color: white !important;
        text-decoration: none !important;
        font-size: 12px !important;
    }

    .ticket-action:hover {
        background: rgba(255, 255, 255, 0.4) !important;
        transform: translateY(-50%) scale(1.1) !important;
        text-decoration: none !important;
        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1) !important;
    }

    .ticket-body {
        padding: 14px !important;
        background: var(--bg-lighter) !important;
        position: relative;
        z-index: 1;
        flex: 1;
    }

    .ticket-info {
        display: flex !important;
        justify-content: space-between !important;
        align-items: center !important;
        margin-bottom: 12px !important;
        padding-bottom: 10px !important;
        border-bottom: 1px solid var(--border-light) !important;
        gap: 8px !important;
        flex-wrap: wrap !important;
    }

    .order-type {
        background: white !important;
        color: var(--primary-maroon) !important;
        padding: 4px 10px !important;
        border-radius: var(--radius-sm) !important;
        font-size: 11px !important;
        font-weight: 600 !important;
        display: flex !important;
        align-items: center !important;
        gap: 5px !important;
        transition: all var(--transition-base) !important;
    }

    .order-type:hover {
        transform: translateX(3px) !important;
    }

    .ticket-items {
        margin-bottom: 12px !important;
        font-size: 11px !important;
        color: var(--text-dark) !important;
        line-height: 1.5 !important;
        max-height: 100px;
        overflow-y: scroll;
    }

    .item-row {
        display: flex !important;
        justify-content: space-between !important;
        padding: 5px 0 !important;
        border-bottom: 1px dashed var(--border-light) !important;
        transition: background 0.2s ease !important;
    }

    .item-row:hover {
        background: rgba(107, 13, 30, 0.05) !important;
    }

    .item-name {
        font-weight: 500 !important;
        font-size: 11px !important;
        transition: all 0.2s ease !important;
    }

    .item-quantity {
        color: var(--primary-maroon) !important;
        font-weight: 700 !important;
        background: white !important;
        padding: 2px 6px !important;
        border-radius: 10px !important;
        min-width: 20px !important;
        text-align: center !important;
        font-size: 10px !important;
        transition: all var(--transition-base) !important;
    }

    .item-quantity:hover {
        transform: scale(1.05) !important;
    }

    .ticket-footer {
        display: flex !important;
        justify-content: space-between !important;
        align-items: center !important;
        padding-top: 10px !important;
        border-top: 1px solid var(--border-light) !important;
        flex-wrap: wrap !important;
        gap: 10px !important;
    }

    .ticket-footer > div:first-child {
        font-size: 13px !important;
        font-weight: 700 !important;
        color: var(--primary-maroon) !important;
    }

    .ticket-actions {
        display: flex !important;
        gap: 8px !important;
    }

    .action-btn {
        padding: 6px 12px !important;
        border-radius: var(--radius-sm) !important;
        border: none !important;
        font-family: 'Poppins', sans-serif !important;
        font-weight: 600 !important;
        font-size: 11px !important;
        cursor: pointer !important;
        transition: all var(--transition-base) !important;
        display: inline-flex !important;
        align-items: center !important;
        gap: 6px !important;
        text-decoration: none !important;
    }

    .action-btn i {
        font-size: 10px !important;
    }

    .action-btn:hover {
        transform: translateY(-2px) scale(1.05) !important;
        text-decoration: none !important;
    }

    .btn-start {
        background: var(--primary-maroon) !important;
        color: white !important;
    }

    .btn-start:hover {
        background: var(--primary-maroon-dark) !important;
        box-shadow: var(--button-shadow) !important;
    }

    .btn-done {
        background: var(--success-green) !important;
        color: white !important;
    }

    .btn-done:hover {
        background: #1e7c5a !important;
        box-shadow: 0 4px 12px rgba(45, 157, 120, 0.3) !important;
    }

    .btn-primary-custom {
        background: var(--primary-maroon) !important;
        color: white !important;
        padding: 10px 20px !important;
        font-size: 13px !important;
        border-radius: var(--radius-md) !important;
        border: none !important;
        cursor: pointer !important;
        transition: all var(--transition-base) !important;
        font-weight: 600 !important;
    }

    .btn-primary-custom:hover {
        transform: translateY(-2px) !important;
        box-shadow: var(--button-shadow) !important;
        background: var(--primary-maroon-dark) !important;
    }

    .rush-badge {
        background: var(--danger-red-light) !important;
        color: var(--danger-red) !important;
        padding: 2px 8px !important;
        border-radius: 10px !important;
        font-size: 9px !important;
        font-weight: 700 !important;
        text-transform: uppercase !important;
        letter-spacing: 0.5px !important;
        display: inline-flex !important;
        align-items: center !important;
        gap: 3px !important;
        margin-left: 6px !important;
        animation: pulse 2s infinite !important;
    }

    .rush-badge i {
        font-size: 8px !important;
    }

    .modal-overlay {
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0, 0, 0, 0.7);
        backdrop-filter: blur(5px);
        z-index: 10000;
        justify-content: center;
        align-items: center;
    }

    .modal-container {
        background: white;
        border-radius: var(--radius-xl);
        width: 90%;
        max-width: 600px;
        max-height: 85vh;
        overflow-y: auto;
        box-shadow: var(--card-shadow-hover);
        animation: slideUp 0.3s ease;
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

    .modal-header {
        background: linear-gradient(135deg, var(--primary-maroon) 0%, var(--primary-maroon-dark) 100%);
        color: white;
        padding: 18px 20px;
        border-radius: var(--radius-xl) var(--radius-xl) 0 0;
        display: flex;
        justify-content: space-between;
        align-items: center;
        position: sticky;
        top: 0;
        z-index: 10;
    }

    .modal-header h3 {
        margin: 0;
        display: flex;
        align-items: center;
        gap: 10px;
        font-size: 18px;
    }

    .modal-close {
        background: rgba(255, 255, 255, 0.2);
        border: none;
        color: white;
        width: 32px;
        height: 32px;
        border-radius: 50%;
        cursor: pointer;
        transition: all var(--transition-base);
        font-size: 18px;
    }

    .modal-close:hover {
        background: rgba(255, 255, 255, 0.3);
        transform: rotate(90deg);
    }

    .modal-body {
        padding: 20px;
    }

    .form-group {
        margin-bottom: 15px;
    }

    .form-group label {
        display: block;
        margin-bottom: 6px;
        font-weight: 600;
        color: var(--text-dark);
        font-size: 13px;
    }

    .form-control {
        width: 100%;
        padding: 10px 12px;
        border: 2px solid var(--border-light);
        border-radius: var(--radius-md);
        font-family: 'Poppins', sans-serif;
        transition: all var(--transition-base);
        font-size: 13px;
        background: white;
    }

    .form-control:focus {
        outline: none;
        border-color: var(--primary-maroon);
        box-shadow: 0 0 0 3px rgba(107, 13, 30, 0.1);
    }

    .item-row-modal {
        display: flex;
        gap: 8px;
        margin-bottom: 10px;
        align-items: center;
    }

    .item-row-modal select {
        flex: 2;
    }

    .item-row-modal input {
        flex: 1;
    }

    .btn-add-item {
        background: var(--primary-maroon);
        color: white;
        border: none;
        padding: 10px 15px;
        border-radius: var(--radius-md);
        cursor: pointer;
        font-weight: 600;
        transition: all var(--transition-base);
        font-size: 12px;
    }

    .btn-add-item:hover {
        background: var(--primary-maroon-dark);
        transform: translateY(-2px);
        box-shadow: var(--button-shadow);
    }

    .items-list {
        max-height: 300px;
        overflow-y: auto;
        margin-top: 10px;
        border: 1px solid var(--border-light);
        border-radius: var(--radius-md);
        padding: 10px;
        background: var(--bg-lighter);
    }

    .modal-footer {
        padding: 15px 20px;
        border-top: 1px solid var(--border-light);
        display: flex;
        gap: 10px;
        justify-content: flex-end;
        position: sticky;
        bottom: 0;
        background: white;
        border-radius: 0 0 var(--radius-xl) var(--radius-xl);
    }

    .btn-cancel {
        background: #e0e0e0;
        color: #666;
        border: none;
        padding: 8px 16px;
        border-radius: var(--radius-md);
        font-weight: 600;
        cursor: pointer;
        transition: all var(--transition-base);
    }

    .btn-cancel:hover {
        background: #ccc;
        transform: translateY(-2px);
    }

    .loading-overlay {
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0, 0, 0, 0.5);
        z-index: 10001;
        justify-content: center;
        align-items: center;
        backdrop-filter: blur(3px);
    }

    .loading-spinner {
        background: white;
        padding: 25px;
        border-radius: var(--radius-lg);
        text-align: center;
        animation: slideUp 0.3s ease;
    }

    .no-tickets {
        text-align: center;
        padding: 60px;
        color: var(--muted-text);
        grid-column: 1 / -1 !important;
    }

    .no-tickets i {
        font-size: 64px;
        margin-bottom: 20px;
        opacity: 0.5;
        color: var(--primary-maroon);
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

    .btn-cancel-ticket {
        background: #fff0f0 !important;
        color: var(--danger-red) !important;
        border: 1px solid #f5c6cb !important;
    }

    .btn-cancel-ticket:hover {
        background: var(--danger-red) !important;
        color: white !important;
        box-shadow: 0 4px 12px rgba(185, 28, 28, 0.3) !important;
    }

    .btn-rider {
        background: linear-gradient(135deg, #680D1E, #4f0a17) !important;
        color: #FFFFFF !important;
        box-shadow: 0 4px 12px rgba(104, 13, 30, 0.3) !important;
    }

    .btn-rider:hover {
        background: linear-gradient(135deg, #4f0a17, #380712) !important;
        transform: translateY(-2px) !important;
        box-shadow: 0 6px 16px rgba(104, 13, 30, 0.4) !important;
        color: #FFFFFF !important;
        text-decoration: none !important;
    }

    .rider-info-strip {
        margin: 8px 0 10px !important;
        padding: 7px 10px !important;
        border-radius: var(--radius-sm) !important;
        font-size: 11px !important;
        display: flex !important;
        align-items: center !important;
        gap: 6px !important;
        flex-wrap: wrap !important;
    }

    .rider-info-strip.assigned {
        background: #e8f4fd !important;
        color: #1a6fb5 !important;
        border: 1px solid #b3d7f5 !important;
    }

    .rider-info-strip.unassigned {
        background: #fff8e6 !important;
        color: #FFC107 !important;
        border: 1px dashed #FFC107 !important;
    }

    .rider-phone {
        color: #555 !important;
        font-size: 10px !important;
    }

    .delivery-address-tag {
        font-size: 10px !important;
        color: var(--muted-text) !important;
        background: white !important;
        border: 1px solid var(--border-light) !important;
        padding: 3px 8px !important;
        border-radius: var(--radius-sm) !important;
        display: inline-flex !important;
        align-items: center !important;
        gap: 4px !important;
        max-width: 200px !important;
        overflow: hidden !important;
        text-overflow: ellipsis !important;
        white-space: nowrap !important;
    }

    @keyframes pulse {
        0%, 100% { opacity: 1; }
        50% { opacity: 0.6; }
    }

    @media (max-width: 1200px) {
        .tickets-grid {
            grid-template-columns: repeat(2, minmax(0, 1fr)) !important;
        }
    }

    @media (max-width: 768px) {
        .ticketing-container {
            padding: 15px !important;
        }
        
        .tickets-grid {
            grid-template-columns: 1fr !important;
        }
        
        .ticket-info {
            flex-direction: column;
            align-items: flex-start !important;
            gap: 8px;
        }
        
        .ticket-footer {
            flex-direction: column;
            gap: 10px;
        }
        
        .ticket-actions {
            width: 100%;
        }
        
        .action-btn {
            width: 100%;
            justify-content: center;
            padding: 8px 12px !important;
        }
        
        .page-header-main {
            flex-direction: column;
            align-items: stretch;
        }
        
        .status-tabs-container {
            width: 100%;
            justify-content: center;
            flex-wrap: wrap;
        }
        
        .status-tab {
            flex: 1;
            justify-content: center;
        }
    }

    @media (max-width: 480px) {
        .ticketing-container {
            padding: 10px !important;
        }
        
        .status-tab {
            padding: 6px 12px !important;
            font-size: 11px !important;
        }
        
        .ticket-title {
            font-size: 12px !important;
        }
    }
</style>

<asp:ScriptManager ID="ScriptManager1" runat="server" />

<div class="ticketing-container">
    <div class="page-header-main">
        <div class="header-title">
            <h2> Ticket Management</h2>
            <p>Manage and track order tickets in real-time</p>
        </div>
        
        <div style="display: flex; gap: 15px; flex-wrap: wrap;">
            <button type="button" class="btn-primary-custom" onclick="openModalDirect()">
                <i class="fas fa-plus-circle"></i> Create Ticket
            </button>
            
            <div class="status-tabs-container">
                <asp:LinkButton ID="btnFilterOpen" runat="server" CssClass="status-tab" OnClick="btnFilterOpen_Click">
                    <i class="fas fa-clock"></i> Open
                    <span class="status-badge"><asp:Literal ID="litOpenCount" runat="server">0</asp:Literal></span>
                </asp:LinkButton>
                
                <asp:LinkButton ID="btnFilterInProgress" runat="server" CssClass="status-tab" OnClick="btnFilterInProgress_Click">
                    <i class="fas fa-spinner"></i> In Progress
                    <span class="status-badge"><asp:Literal ID="litInProgressCount" runat="server">0</asp:Literal></span>
                </asp:LinkButton>
                
                <asp:LinkButton ID="btnFilterCompleted" runat="server" CssClass="status-tab" OnClick="btnFilterCompleted_Click">
                    <i class="fas fa-check-circle"></i> Completed
                    <span class="status-badge"><asp:Literal ID="litCompletedCount" runat="server">0</asp:Literal></span>
                </asp:LinkButton>
                
                <asp:LinkButton ID="btnFilterCancelled" runat="server" CssClass="status-tab" OnClick="btnFilterCancelled_Click">
                    <i class="fas fa-ban"></i> Cancelled
                    <span class="status-badge"><asp:Literal ID="litCancelledCount" runat="server">0</asp:Literal></span>
                </asp:LinkButton>
                
                <asp:LinkButton ID="btnFilterAll" runat="server" CssClass="status-tab" OnClick="btnFilterAll_Click">
                    <i class="fas fa-list"></i> All
                    <span class="status-badge"><asp:Literal ID="litAllCount" runat="server">0</asp:Literal></span>
                </asp:LinkButton>
            </div>
        </div>
    </div>

    <asp:UpdatePanel ID="upTickets" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <div class="tickets-grid">
                <asp:Repeater ID="rptTickets" runat="server" OnItemCommand="RptTickets_ItemCommand" OnItemDataBound="RptTickets_ItemDataBound">
                    <ItemTemplate>
                        <div class="ticket-card">
                            <div class="ticket-icon-bg">
                                <i class="fas fa-receipt"></i>
                            </div>
                            <div class="ticket-header">
                                <div class="ticket-title">
                                    <i class="fas fa-ticket-alt"></i> <%# Eval("TicketNumber") %>
                                    <%# Eval("Priority").ToString() == "Rush" ? "<span class='rush-badge'><i class='fas fa-bolt'></i> RUSH</span>" : "" %>
                                </div>
                                <div class="order-number">
                                    <i class="fas fa-hashtag"></i> Order #: <%# Eval("OrderNumber") %>
                                </div>
                                <div class="ticket-time">
                                    <span class='status-dot <%# GetStatusDotClass(Eval("Status").ToString()) %>'></span>
                                    <i class="far fa-clock"></i> <%# Eval("CreatedTime") %>
                                    <%# Convert.ToInt32(Eval("MinutesAgo")) > 0 ? $" <span style='opacity:0.8;'>({Eval("MinutesAgo")} min ago)</span>" : "" %>
                                </div>
                                <asp:LinkButton ID="btnDeleteTicket" runat="server" 
                                    CommandName="DeleteTicket" 
                                    CommandArgument='<%# Eval("TicketID") %>'
                                    CssClass="ticket-action"
                                    ToolTip="Delete Ticket"
                                    OnClientClick='<%# "return confirmDelete(" + Eval("TicketID") + ");" %>'>
                                    <i class="fas fa-trash-alt"></i>
                                </asp:LinkButton>
                            </div>
                            
                            <div class="ticket-body">
                                <div class="ticket-info">
                                    <span class="order-type">
                                        <i class='<%# Eval("OrderType").ToString() == "Dine-In" ? "fas fa-utensils" : Eval("OrderType").ToString() == "Delivery" ? "fas fa-motorcycle" : "fas fa-box" %>'></i>
                                        <%# Eval("OrderType") %>
                                    </span>
                                    <%# !string.IsNullOrEmpty(Eval("DeliveryAddress")?.ToString()) 
                                        ? $"<span class='delivery-address-tag'><i class='fas fa-map-marker-alt'></i> {Eval("DeliveryAddress")}</span>" 
                                        : "" %>
                                </div>

                                <%-- Rider info strip (only for Delivery) --%>
                                <%# Eval("OrderType").ToString() == "Delivery" ? 
                                    (Eval("RiderID") != DBNull.Value && Eval("RiderID") != null 
                                        ? $"<div class='rider-info-strip assigned'><i class='fas fa-motorcycle'></i> Rider: <strong>{Eval("RiderName")}</strong> &nbsp;<span class='rider-phone'><i class='fas fa-phone'></i> {Eval("RiderPhone")}</span></div>"
                                        : "<div class='rider-info-strip unassigned'><i class='fas fa-motorcycle'></i> No rider assigned yet</div>") 
                                    : "" %>
                                
                                <div class="ticket-items">
                                    <asp:Repeater ID="rptItems" runat="server">
                                        <ItemTemplate>
                                            <div class="item-row">
                                                <span class="item-name">
                                                    <i class="fas fa-utensil-spoon"></i>
                                                    <%# Eval("Quantity") %>x <%# Eval("ItemName") %>
                                                </span>
                                                <span class="item-quantity">₱<%# Convert.ToDecimal(Eval("SubTotal")).ToString("N2") %></span>
                                            </div>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                                
                                <div class="ticket-footer">
                                    <div>
                                        <i class="fas fa-coins"></i> Total: ₱<%# Convert.ToDecimal(Eval("TotalAmount")).ToString("N2") %>
                                    </div>
                                    <div class="ticket-actions">
                                        <asp:LinkButton ID="btnStart" runat="server" 
                                            CommandName="Start" 
                                            CommandArgument='<%# Eval("TicketID") %>'
                                            CssClass="action-btn btn-start"
                                            Visible='<%# Eval("Status").ToString() == "Open" %>'>
                                            <i class="fas fa-play"></i> Start
                                        </asp:LinkButton>
                                        
                                        <asp:LinkButton ID="btnComplete" runat="server" 
                                            CommandName="Complete" 
                                            CommandArgument='<%# Eval("TicketID") %>'
                                            CssClass="action-btn btn-done"
                                            Visible='<%# Eval("Status").ToString() == "In Progress" && Eval("OrderType").ToString() != "Delivery" %>'>
                                            <i class="fas fa-check-double"></i> Complete
                                        </asp:LinkButton>

                                        <%-- Cancel button: only on Open tickets --%>
                                        <asp:LinkButton ID="btnCancelTicket" runat="server"
                                            CommandName="CancelTicket"
                                            CommandArgument='<%# Eval("TicketID") %>'
                                            CssClass="action-btn btn-cancel-ticket"
                                            Visible='<%# Eval("Status").ToString() == "Open" %>'
                                            OnClientClick='<%# "return confirmCancel(" + Eval("TicketID") + ");" %>'>
                                            <i class="fas fa-ban"></i> Cancel
                                        </asp:LinkButton>

                                        <%-- Delivery: show Assign Rider when In Progress and no rider yet --%>
                                        <asp:LinkButton ID="btnAssignRider" runat="server"
                                            CommandName="AssignRider"
                                            CommandArgument='<%# Eval("TicketID") %>'
                                            CssClass="action-btn btn-rider"
                                            Visible='<%# Eval("OrderType").ToString() == "Delivery" && Eval("Status").ToString() == "In Progress" && (Eval("RiderID") == DBNull.Value || Eval("RiderID") == null) %>'>
                                            <i class="fas fa-motorcycle"></i> Assign Rider
                                        </asp:LinkButton>

                                        <%-- Delivery: Complete only after rider is assigned --%>
                                        <asp:LinkButton ID="btnCompleteDelivery" runat="server" 
                                            CommandName="Complete" 
                                            CommandArgument='<%# Eval("TicketID") %>'
                                            CssClass="action-btn btn-done"
                                            Visible='<%# Eval("OrderType").ToString() == "Delivery" && Eval("Status").ToString() == "In Progress" && Eval("RiderID") != DBNull.Value && Eval("RiderID") != null %>'>
                                            <i class="fas fa-check-double"></i> Complete
                                        </asp:LinkButton>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
                
                <asp:Panel ID="pnlNoTickets" runat="server" Visible="false" CssClass="no-tickets">
                    <i class="fas fa-ticket-alt"></i>
                    <h3>No tickets found</h3>
                    <p>Click "Create Ticket" to create your first ticket</p>
                </asp:Panel>
            </div>
            
            <asp:HiddenField ID="hfSelectedStatus" runat="server" Value="Open" />
        </ContentTemplate>
    </asp:UpdatePanel>
</div>

<div id="ticketModal" class="modal-overlay">
    <div class="modal-container">
        <div class="modal-header">
            <h3><i class="fas fa-plus-circle"></i> Create New Ticket</h3>
            <button type="button" class="modal-close" onclick="closeModal()">✕</button>
        </div>
        <asp:UpdatePanel ID="upModal" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <div class="modal-body">
                    <div class="form-group">
                        <label><i class="fas fa-tag"></i> Order Type:</label>
                        <asp:DropDownList ID="ddlOrderType" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="DdlOrderType_SelectedIndexChanged">
                            <asp:ListItem Value="Dine-In">Dine-In</asp:ListItem>
                            <asp:ListItem Value="Takeout">Takeout</asp:ListItem>
                            <%-- Delivery intentionally excluded: delivery orders are managed separately --%>
                        </asp:DropDownList>
                    </div>
                    
                    <asp:Panel ID="pnlDeliveryAddress" runat="server" Visible="false" CssClass="form-group">
                        <label><i class="fas fa-map-marker-alt"></i> Delivery Address:</label>
                        <asp:TextBox ID="txtDeliveryAddress" runat="server" CssClass="form-control" 
                            placeholder="Enter delivery address..." TextMode="MultiLine" Rows="2" />
                    </asp:Panel>

                    <div class="form-group">
                        <label><i class="fas fa-flag"></i> Priority:</label>
                        <asp:DropDownList ID="ddlPriority" runat="server" CssClass="form-control">
                            <asp:ListItem Value="Normal">Normal</asp:ListItem>
                            <asp:ListItem Value="Rush">Rush (Priority)</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    
                    <div class="form-group">
                        <label><i class="fas fa-shopping-cart"></i> Add Items:</label>
                        <div class="item-row-modal">
                            <asp:DropDownList ID="ddlMenuItem" runat="server" CssClass="form-control">
                            </asp:DropDownList>
                            <asp:TextBox ID="txtQuantity" runat="server" Text="1" TextMode="Number" 
                                CssClass="form-control" style="width:80px;" min="1" />
                            <asp:Button ID="btnAddItem" runat="server" Text="+ Add Item" 
                                CssClass="btn-add-item" OnClick="BtnAddItem_Click" UseSubmitBehavior="false" />
                        </div>
                        
                        <div class="items-list">
                            <asp:Panel ID="pnlNoItems" runat="server" Visible="true" 
                                style="text-align:center; padding:20px; color:#999;">
                                <i class="fas fa-cart-plus fa-2x"></i>
                                <p style="margin-top:10px;">No items added yet</p>
                            </asp:Panel>
                            
                            <asp:Repeater ID="rptSelectedItems" runat="server" OnItemCommand="RptSelectedItems_ItemCommand">
                                <ItemTemplate>
                                    <div style="display:flex; gap:10px; align-items:center; margin:8px 0; padding:8px; background:#f9f4ee; border-radius:8px; transition: all 0.3s ease;">
                                        <strong style="flex:2; color:#4a0e0e;">
                                            <i class="fas fa-utensils"></i> <%# Eval("Quantity") %>x <%# Eval("ItemName") %>
                                        </strong>
                                        <span style="flex:1; color:#6b0d1e; font-weight:bold;">
                                            ₱<%# Convert.ToDecimal(Eval("SubTotal")).ToString("N2") %>
                                        </span>
                                        <asp:LinkButton ID="btnRemoveItem" runat="server" CommandName="RemoveItem" 
                                            CommandArgument='<%# Container.ItemIndex %>' 
                                            style="background:#b91c1c; color:white; padding:4px 12px; border-radius:6px; text-decoration:none; transition: all 0.3s ease;"
                                            OnClientClick="return confirm('Remove this item?');">
                                            <i class="fas fa-trash"></i> Remove
                                        </asp:LinkButton>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                            
                            <div style="font-weight:bold; margin-top:15px; padding-top:10px; border-top:2px solid #6b0d1e; 
                                        display:flex; justify-content:space-between; color:#4a0e0e;">
                                <span><i class="fas fa-calculator"></i> Total:</span> 
                                <asp:Literal ID="litModalTotal" runat="server">₱0.00</asp:Literal>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="modal-footer">
                    <asp:Button ID="btnCreateTicket" runat="server" Text="Create Ticket" 
                        CssClass="action-btn btn-done" OnClick="BtnCreateTicket_Click" />
                    <%-- Fix 13: Hidden reset button triggered by JS on modal open to clear stale cart --%>
                    <asp:Button ID="btnResetCart" runat="server" Text="" OnClick="BtnResetCart_Click"
                        style="display:none;" />
                    <button type="button" class="btn-cancel" onclick="closeModal()">
                        <i class="fas fa-times"></i> Cancel
                    </button>
                </div>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="btnCreateTicket" EventName="Click" />
                <asp:AsyncPostBackTrigger ControlID="btnAddItem" EventName="Click" />
                <asp:AsyncPostBackTrigger ControlID="btnResetCart" EventName="Click" />
            </Triggers>
        </asp:UpdatePanel>
    </div>
</div>

<%-- ══ Assign Rider Modal ══════════════════════════════════════════════ --%>
<div id="riderModal" class="modal-overlay">
    <div class="modal-container" style="max-width:480px;">
        <div class="modal-header">
            <h3><i class="fas fa-motorcycle"></i> Assign Rider</h3>
            <button type="button" class="modal-close" onclick="closeRiderModal()">✕</button>
        </div>
        <asp:UpdatePanel ID="upRiderModal" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <asp:HiddenField ID="hfAssignTicketID" runat="server" Value="0" />
                <div class="modal-body">
                    <div class="form-group">
                        <label><i class="fas fa-user"></i> Select Rider:</label>
                        <asp:DropDownList ID="ddlRider" runat="server" CssClass="form-control">
                        </asp:DropDownList>
                    </div>
                    <div id="noRidersMsg" runat="server" visible="false"
                         style="text-align:center; padding:20px; color:#8a6d6d;">
                        <i class="fas fa-motorcycle fa-2x" style="color:#ccc;"></i>
                        <p style="margin-top:10px;">No available riders found.</p>
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="btnConfirmRider" runat="server" Text="Assign Rider"
                        CssClass="action-btn btn-rider" OnClick="BtnConfirmRider_Click" />
                    <button type="button" class="btn-cancel" onclick="closeRiderModal()">
                        <i class="fas fa-times"></i> Cancel
                    </button>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</div>

<div id="loadingOverlay" class="loading-overlay">
    <div class="loading-spinner">
        <i class="fas fa-spinner fa-spin fa-3x" style="color: var(--primary-maroon);"></i>
        <p style="margin-top: 15px;">Processing...</p>
    </div>
</div>

<script type="text/javascript">
    let modalShouldStayOpen = false;

    // Safe confirm helpers — use ticketId so no server-side string quoting issues
    function confirmDelete(ticketId) {
        return confirm('Delete this ticket? This action cannot be undone!');
    }

    function confirmCancel(ticketId) {
        return confirm('Cancel this ticket? This will mark it as Cancelled.');
    }

    document.addEventListener('DOMContentLoaded', function () {
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    target.scrollIntoView({
                        behavior: 'smooth',
                        block: 'start'
                    });
                }
            });
        });
    });

    function openModalDirect() {
        // Fix 13: Trigger server-side cart reset each time the modal opens,
        // so stale items from a previous abandoned session are cleared.
        var resetBtn = document.getElementById('<%= btnResetCart.ClientID %>');
        if (resetBtn) {
            modalShouldStayOpen = true;
            resetBtn.click();
        } else {
            var modal = document.getElementById('ticketModal');
            if (modal) {
                modal.style.display = 'flex';
                modalShouldStayOpen = true;
            }
        }
        return false;
    }

    function closeModal() {
        var modal = document.getElementById('ticketModal');
        if (modal) {
            modal.style.display = 'none';
            modalShouldStayOpen = false;
        }
    }

    function showLoading(show) {
        var overlay = document.getElementById('loadingOverlay');
        if (overlay) {
            overlay.style.display = show ? 'flex' : 'none';
        }
    }

    function showNotification(message, type) {
        var existingNotif = document.querySelector('.custom-notification');
        if (existingNotif) {
            existingNotif.remove();
        }

        var notification = document.createElement('div');
        notification.className = 'custom-notification';
        var bgColor = type === 'success' ? '#2d9d78' : (type === 'warning' ? '#d97706' : '#b91c1c');
        var icon = type === 'success' ? 'fa-check-circle' : (type === 'warning' ? 'fa-exclamation-triangle' : 'fa-times-circle');

        notification.style.cssText = `
            position: fixed; bottom: 20px; right: 20px; padding: 15px 20px;
            background: ${bgColor}; color: white; border-radius: 8px; 
            z-index: 10002; animation: slideInRight 0.3s ease;
            font-family: 'Poppins', sans-serif; box-shadow: 0 4px 12px rgba(0,0,0,0.2);
            max-width: 350px; font-size: 14px;
        `;
        notification.innerHTML = `<i class="fas ${icon}" style="margin-right: 10px;"></i> ${message}`;
        document.body.appendChild(notification);

        setTimeout(() => {
            notification.style.opacity = '0';
            notification.style.transition = 'opacity 0.3s ease';
            setTimeout(() => {
                if (notification && notification.remove) {
                    notification.remove();
                }
            }, 300);
        }, 4000);
    }

    function openRiderModal() {
        var modal = document.getElementById('riderModal');
        if (modal) modal.style.display = 'flex';
    }

    function closeRiderModal() {
        var modal = document.getElementById('riderModal');
        if (modal) modal.style.display = 'none';
    }

    window.onclick = function (event) {
        var modal = document.getElementById('ticketModal');
        if (event.target === modal) { closeModal(); }
        var rModal = document.getElementById('riderModal');
        if (event.target === rModal) { closeRiderModal(); }
    }

    Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function (sender, args) {
        showLoading(false);

        if (modalShouldStayOpen) {
            setTimeout(function () {
                var modal = document.getElementById('ticketModal');
                if (modal) {
                    modal.style.display = 'flex';
                }
            }, 100);
        }

        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    target.scrollIntoView({
                        behavior: 'smooth',
                        block: 'start'
                    });
                }
            });
        });
    });
</script>
</asp:Content>