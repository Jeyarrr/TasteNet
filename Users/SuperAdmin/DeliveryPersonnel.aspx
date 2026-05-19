<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/SuperAdmin.Master" AutoEventWireup="true" CodeBehind="DeliveryPersonnel.aspx.cs" Inherits="TasteNet.Users.SuperAdmin.DeliveryPersonnel" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true" />
    <asp:HiddenField ID="hdnRiderIdForOrders" runat="server" Value="" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
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
            --accent-yellow: #ffcc00;
            --accent-yellow-dark: #e6b800;
            --accent-yellow-light: #fff9e6;
            --accent-pink: #f9ecee;
            --accent-blue: #eff6ff;
            --accent-blue-dark: #3b82f6;
            
            --border-light: #e2d1d1;
            --border-hover: #d4b8b8;
            --bg-hover: #fefaf5;
            --bg-light: #f3ebe0;
            --bg-lighter: #f9f4ee;
            
            --card-shadow: 0 10px 30px rgba(107, 13, 30, 0.05);
            --card-shadow-hover: 0 15px 40px rgba(107, 13, 30, 0.12);
            --button-shadow: 0 4px 12px rgba(107, 13, 30, 0.2);
            --button-shadow-hover: 0 6px 18px rgba(107, 13, 30, 0.3);
            
            --radius-sm: 8px;
            --radius-md: 10px;
            --radius-lg: 12px;
            --radius-xl: 16px;
            --radius-2xl: 20px;
            
            --transition-fast: 0.2s ease;
            --transition-base: 0.3s ease;
            --transition-slow: 0.4s ease;
        }

        html, body, form {
            margin: 0 !important;
            padding: 0 !important;
            background-color: var(--soft-cream) !important;
            width: 100%;
            font-family: 'Poppins', sans-serif;
            color: var(--text-dark);
            min-height: 100vh;
        }

        #delivery-mgmt-wrapper {
            background: var(--soft-cream) !important;
            padding: 20px 30px;
            max-width: 1600px;
            margin: 0 auto;
            min-height: 100vh;
            box-sizing: border-box;
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
            margin: 5px 0 0 0;
            font-size: 14px;
            line-height: 1.5;
        }

        .header-actions {
            display: flex;
            gap: 10px;
            align-items: center;
            flex-wrap: wrap;
        }

            .stats-grid {
                display: grid;
                grid-template-columns: repeat(4, 1fr);
                gap: 20px;
                margin-bottom: 30px;
            }

            .stat-card {
                background: white;
                padding: 20px;
                border-radius: 18px;
                box-shadow: var(--card-shadow);
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }

            .stat-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 12px 30px rgba(107, 13, 30, 0.12);
            }

            .stat-card__header {
                display: flex;
                justify-content: space-between;
                align-items: flex-start;
                margin-bottom: 10px;
            }

            .stat-card__label {
                font-size: 12px;
                font-weight: 500;
                color: var(--muted-text);
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .stat-card__icon {
                width: 36px;
                height: 36px;
                border-radius: var(--radius-md);
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 16px;
                flex-shrink: 0;
                transition: all var(--transition-base);
                transform-origin: center;
            }

            .stat-card:hover .stat-card__icon {
                transform: scale(1.1) rotate(5deg);
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
            }

            .stat-card__icon--total { background: var(--accent-pink); color: var(--primary-maroon); }
            .stat-card__icon--available { background: var(--success-green-light); color: var(--success-green); }
            .stat-card__icon--delivery { background: var(--warning-orange-light); color: var(--warning-orange); }
            .stat-card__icon--orders { background: var(--accent-blue); color: var(--accent-blue-dark); }

            .stat-card__value {
                font-size: 26px;
                font-weight: 700;
                color: var(--primary-maroon);
                margin: 6px 0;
                line-height: 1;
            }

            .stat-card__trend {
                font-size: 12px;
                font-weight: 600;
                color: var(--muted-text);
            }

        .filter-container {
            display: flex;
            gap: 8px;
            margin-bottom: 20px;
            align-items: center;
            flex-wrap: nowrap;
        }

        .inner-search {
            position: relative;
            min-width: 300px;
            flex: 0 0 auto;
        }

        .inner-search i {
            position: absolute;
            left: 12px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--muted-text);
            font-size: 14px;
            z-index: 2;
        }

        .inner-search input {
            width: 100%;
            padding: 8px 15px 8px 40px;
            border: 2px solid var(--border-light);
            border-radius: var(--radius-md);
            font-size: 13px;
            font-family: 'Poppins', sans-serif;
            background: white;
            color: var(--text-dark);
            transition: all var(--transition-base);
            outline: none;
            font-weight: 500;
            height: 38px;
            box-shadow: 0 2px 6px rgba(107, 13, 30, 0.05);
            box-sizing: border-box;
        }

        .inner-search input:hover {
            border-color: var(--border-hover);
            box-shadow: 0 4px 12px rgba(107, 13, 30, 0.08);
        }

        .inner-search input:focus {
            transform: translateY(-1px);
            border-color: var(--primary-maroon);
            box-shadow: 
                0 6px 16px rgba(107, 13, 30, 0.12),
                0 0 0 3px rgba(107, 13, 30, 0.1);
        }

        .inner-search input::placeholder {
            color: var(--muted-text);
            opacity: 0.7;
            font-size: 13px;
        }

        .filter-select {
            padding: 8px 35px 8px 15px;
            border: 2px solid var(--border-light);
            border-radius: var(--radius-md);
            background: white;
            color: var(--text-dark);
            font-size: 13px;
            font-family: 'Poppins', sans-serif;
            cursor: pointer;
            min-width: 80px;
            outline: none;
            font-weight: 500;
            transition: all var(--transition-base);
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='14' height='14' fill='%238a6d6d' viewBox='0 0 16 16'%3E%3Cpath d='M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 12px center;
            background-size: 10px;
            height: 38px;
            box-shadow: 0 2px 6px rgba(107, 13, 30, 0.05);
            box-sizing: border-box;
            flex: 0 0 auto;
            position: relative;
            z-index: 1;
        }

        .filter-select:hover {
            border-color: var(--primary-maroon);
            box-shadow: 0 4px 12px rgba(107, 13, 30, 0.1);
            transform: translateY(-1px);
        }

        .filter-select:focus {
            transform: translateY(0);
            border-color: var(--primary-maroon);
            box-shadow: 0 0 0 3px rgba(107, 13, 30, 0.15);
        }

        .table-container {
            background: white;
            border-radius: var(--radius-lg);
            box-shadow: var(--card-shadow);
            overflow: hidden;
            margin-bottom: 20px;
            animation: fadeIn 0.5s ease-out;
            margin-top: 0 !important;
        }

        .table-wrapper {
            overflow-x: auto;
            padding: 0 !important;
        }

        .custom-table {
            width: 100%;
            border-collapse: collapse;
            min-width: 100%;
            font-size: 13px;
            border-spacing: 0 !important;
            border-collapse: separate !important;
        }

        .custom-table thead {
            background: white;
            border-bottom: 2px solid var(--bg-light) !important;
        }

        .custom-table thead tr {
            height: 40px !important;
        }

        .custom-table th {
            padding: 8px 10px !important;
            text-align: center;
            font-size: 11px;
            color: var(--muted-text);
            font-weight: 600;
            border-bottom: 2px solid var(--bg-light);
            letter-spacing: 0.3px;
            text-transform: uppercase;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            background: white;
            vertical-align: middle !important;
        }

        .custom-table td {
            padding: 16px 10px;
            border-bottom: 1px solid var(--bg-lighter);
            font-size: 13px;
            vertical-align: middle;
            color: var(--text-dark);
            text-align: center;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            height: 60px;
            position: relative;
            transition: all var(--transition-fast);
        }

        .custom-table tbody tr {
            transition: all var(--transition-base);
            position: relative;
            animation: tableRowFadeIn 0.5s ease-out;
            animation-fill-mode: both;
            border-left: 3px solid transparent;
        }

        .custom-table tbody tr:hover {
            background: linear-gradient(90deg, var(--bg-hover) 0%, white 100%);
            border-left: 3px solid var(--primary-maroon);
            transform: translateX(2px);
            box-shadow: 0 4px 12px rgba(107, 13, 30, 0.08);
        }

        .custom-table tbody tr:hover td {
            border-color: transparent;
        }

        .custom-table tbody tr:hover td::before {
            content: '';
            position: absolute;
            top: 0;
            left: -2px;
            right: -2px;
            bottom: 0;
            background: var(--bg-hover);
            z-index: -1;
            opacity: 0.3;
        }

        .custom-table tbody tr:last-child td {
            border-bottom: none;
        }

        .rider-id {
            color: var(--primary-maroon);
            font-weight: 700;
            font-size: 12px;
            font-family: 'Courier New', monospace;
            transition: all var(--transition-base);
            position: relative;
            display: inline-block;
        }

        .rider-id:hover {
            color: var(--primary-maroon);
            animation: bounce 0.5s ease infinite alternate;
        }

        .rider-id:hover::before {
            content: '';
            position: absolute;
            left: 50%;
            transform: translateX(-50%);
            bottom: -5px;
            width: 30px;
            height: 2px;
            background: var(--primary-maroon);
            animation: underlineExpand 0.3s ease forwards;
        }

        .rider-info {
            display: flex;
            flex-direction: column;
            gap: 2px;
            align-items: center;
        }

        .rider-name {
            color: var(--text-dark);
            font-weight: 600;
            font-size: 13px;
            line-height: 1.2;
            position: relative;
            display: inline-block;
            transition: color var(--transition-fast);
        }

        .rider-name:hover {
            color: var(--primary-maroon);
        }

        .rider-name:hover::after {
            content: '';
            position: absolute;
            bottom: -2px;
            left: 0;
            width: 100%;
            height: 1px;
            background: var(--primary-maroon);
            animation: underlineExpand 0.3s ease forwards;
        }

        .rider-contact {
            color: var(--muted-text);
            font-size: 11px;
            font-weight: 500;
            line-height: 1.2;
        }

        .contact-info {
            display: flex;
            flex-direction: column;
            gap: 2px;
            align-items: center;
        }

        .contact-phone {
            color: var(--text-dark);
            font-size: 12px;
            font-weight: 500;
            line-height: 1.2;
        }

        .contact-email {
            color: var(--muted-text);
            font-size: 11px;
            line-height: 1.2;
        }

        .vehicle-badge {
            background: var(--bg-lighter);
            color: var(--text-dark);
            padding: 4px 12px;
            border-radius: var(--radius-sm);
            font-size: 11px;
            font-weight: 600;
            display: inline-block;
            border: 1px solid var(--border-light);
            transition: all var(--transition-fast);
        }

        .vehicle-badge:hover {
            transform: translateY(-1px);
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .status-badge {
            padding: 4px 8px;
            border-radius: var(--radius-sm);
            font-size: 10px;
            font-weight: 700;
            display: inline-block;
            text-transform: uppercase;
            letter-spacing: 0.3px;
            min-width: 60px;
            text-align: center;
            line-height: 1.2;
            border: 1px solid transparent;
            transition: all var(--transition-fast);
            position: relative;
            overflow: hidden;
        }

        .status-badge:hover {
            transform: translateY(-1px);
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .status-badge--available {
            background: var(--success-green-light);
            color: var(--success-green);
            border-color: var(--success-green);
        }

        .status-badge--available:hover {
            background: var(--success-green);
            color: white;
        }

        .status-badge--delivery {
            background: var(--warning-orange-light);
            color: var(--warning-orange);
            border-color: var(--warning-orange);
        }

        .status-badge--delivery:hover {
            background: var(--warning-orange);
            color: white;
        }

        .status-badge--offline {
            background: var(--bg-lighter);
            color: var(--muted-text);
            border-color: var(--border-light);
        }

        .status-badge--offline:hover {
            background: var(--muted-text);
            color: white;
        }

        .stat-number {
            font-weight: 700;
            font-size: 13px;
            color: var(--primary-maroon);
        }

        .completed-deliveries {
            font-weight: 700;
            font-size: 13px;
            color: var(--success-green);
        }

        .rating-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            gap: 4px;
        }

        .rating-stars {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 2px;
            font-size: 12px;
        }

        .rating-stars i {
            color: #ffcc00;
        }

        .rating-value {
            font-weight: 600;
            font-size: 12px;
            color: #d97706;
        }

        .action-btns {
            display: flex;
            gap: 6px;
            align-items: center;
            justify-content: center;
        }

        .action-icon {
            width: 26px;
            height: 26px;
            border-radius: var(--radius-sm);
            display: flex;
            align-items: center;
            justify-content: center;
            background: var(--bg-lighter);
            color: var(--muted-text);
            border: none;
            cursor: pointer;
            transition: all var(--transition-base);
            font-size: 11px;
            position: relative;
            text-decoration: none;
            overflow: hidden;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        /* Fix for View button color - Maroon */
        .action-icon.view {
            color: var(--primary-maroon) !important;
        }

        .action-icon.view i {
            color: inherit;
        }

        .action-icon.view:hover {
            color: white !important;
        }

        .action-icon::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 0;
            height: 0;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.2);
            transform: translate(-50%, -50%);
            transition: width 0.6s, height 0.6s;
        }

        .action-icon:active::before {
            width: 200px;
            height: 200px;
        }

        .action-icon:hover {
            transform: translateY(-2px) scale(1.1);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
        }

        .action-icon.view:hover {
            background: var(--primary-maroon);
            color: white;
        }

        .action-icon.delete:hover {
            background: var(--danger-red);
            color: white;
        }

        .action-icon.edit { color: var(--accent-blue-dark); }
        .action-icon.edit:hover { background: var(--accent-blue-dark); color: white; }

        .edit-rider-modal {
            background: white; border-radius: var(--radius-xl);
            max-width: 820px; width: 90%; max-height: 92vh; overflow-y: auto;
            box-shadow: 0 25px 50px rgba(0,0,0,0.25);
            animation: slideUp 0.4s cubic-bezier(0.4,0,0.2,1); position: relative;
        }
        .edit-info-row {
            display:flex; justify-content:space-between; align-items:center;
            padding:8px 0; border-bottom:1px dashed var(--border-light); gap:12px;
        }
        .edit-info-row:last-child { border-bottom:none; }
        .edit-info-row .info-label { flex-shrink:0; white-space:nowrap; }
        .edit-info-row .edit-input {
            flex:1; text-align:right; padding:5px 10px;
            border:1px solid var(--border-light); border-radius:var(--radius-sm);
            font-size:13px; font-family:'Poppins',sans-serif; color:var(--text-dark);
            font-weight:600; background:white; outline:none; min-width:0; max-width:220px;
            transition:border-color var(--transition-fast),box-shadow var(--transition-fast);
        }
        .edit-info-row .edit-input:focus { border-color:var(--primary-maroon); box-shadow:0 0 0 3px rgba(107,13,30,0.1); }
        .edit-info-row select.edit-input {
            cursor:pointer; appearance:none;
            background-image:url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' fill='%238a6d6d' viewBox='0 0 16 16'%3E%3Cpath d='M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z'/%3E%3C/svg%3E");
            background-repeat:no-repeat; background-position:right 8px center; padding-right:26px;
        }
        .edit-profile-wrap { display:flex; flex-direction:column; align-items:center; margin-bottom:18px; }
        .edit-profile-circle {
            width:88px; height:88px; border-radius:50%; overflow:hidden;
            border:3px solid var(--border-light); background:var(--bg-light);
            display:flex; align-items:center; justify-content:center;
            cursor:pointer; position:relative; transition:border-color var(--transition-base);
        }
        .edit-profile-circle:hover { border-color:var(--primary-maroon); }
        .edit-profile-circle .edit-cam-overlay {
            position:absolute; inset:0; background:rgba(107,13,30,0.45);
            display:flex; align-items:center; justify-content:center;
            opacity:0; transition:opacity var(--transition-fast);
        }
        .edit-profile-circle:hover .edit-cam-overlay { opacity:1; }
        .edit-profile-circle .edit-cam-overlay i { color:white; font-size:20px; }
        .edit-doc-grid { display:grid; grid-template-columns:repeat(auto-fill,minmax(150px,1fr)); gap:14px; margin-top:14px; }
        .edit-doc-card {
            border-radius:10px; overflow:hidden; border:2px solid var(--border-light);
            background:var(--bg-lighter); cursor:pointer;
            transition:box-shadow var(--transition-fast),transform var(--transition-fast);
        }
        .edit-doc-card:hover { box-shadow:0 6px 20px rgba(107,13,30,0.15); transform:translateY(-3px); border-color:var(--primary-maroon); }
        .edit-doc-card__img { height:100px; overflow:hidden; background:var(--bg-light); position:relative; }
        .edit-doc-card__img img { width:100%; height:100%; object-fit:cover; }
        .edit-doc-card__img .no-photo { width:100%; height:100%; display:flex; align-items:center; justify-content:center; color:var(--muted-text); font-size:28px; }
        .edit-doc-card__img .change-overlay {
            position:absolute; inset:0; background:rgba(107,13,30,0.5);
            display:flex; flex-direction:column; align-items:center; justify-content:center;
            opacity:0; transition:opacity var(--transition-fast); color:white; font-size:12px; gap:4px;
        }
        .edit-doc-card:hover .change-overlay { opacity:1; }
        .edit-doc-card__label { padding:7px 10px; font-size:11px; font-weight:600; color:var(--text-dark); text-align:center; }
        .edit-doc-card__label span { display:block; font-size:10px; color:var(--muted-text); font-weight:400; margin-top:2px; }

        .action-icon[title]:hover::after {
            content: attr(title);
            position: absolute;
            bottom: -30px;
            left: 50%;
            transform: translateX(-50%) translateY(-5px);
            background: var(--text-dark);
            color: white;
            padding: 6px 10px;
            border-radius: var(--radius-sm);
            font-size: 11px;
            font-weight: 500;
            white-space: nowrap;
            z-index: 100;
            opacity: 0;
            animation: tooltipFadeIn 0.3s ease forwards;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        }

        .action-icon[title]:hover::before {
            content: '';
            position: absolute;
            bottom: -20px;
            left: 50%;
            transform: translateX(-50%);
            border: 5px solid transparent;
            border-bottom-color: var(--text-dark);
            z-index: 101;
            opacity: 0;
            animation: tooltipFadeIn 0.3s ease forwards;
        }

        .btn {
            padding: 8px 16px;
            border-radius: var(--radius-md);
            font-weight: 600;
            font-size: 13px;
            cursor: pointer;
            transition: all var(--transition-base);
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 6px;
            border: 2px solid transparent;
            font-family: 'Poppins', sans-serif;
            text-decoration: none;
            white-space: nowrap;
            min-height: 36px;
            line-height: 1.2;
            position: relative;
            overflow: hidden;
            z-index: 1;
        }

        .btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(
                90deg,
                transparent,
                rgba(255, 255, 255, 0.2),
                transparent
            );
            transition: left 0.7s;
            z-index: -1;
        }

        .btn:hover::before {
            left: 100%;
        }

        .btn--secondary {
            background: var(--accent-yellow);
            color: var(--text-dark);
            box-shadow: 0 4px 12px rgba(255, 204, 0, 0.2);
        }

        .btn--secondary:hover {
            background: var(--accent-yellow-dark);
            transform: translateY(-3px);
            box-shadow: 0 6px 18px rgba(255, 204, 0, 0.3);
        }

        .btn--primary {
            background: var(--primary-maroon);
            color: white;
            box-shadow: var(--button-shadow);
        }

        .btn--primary:hover {
            background: var(--primary-maroon-dark);
            transform: translateY(-3px);
            box-shadow: 
                0 8px 20px rgba(107, 13, 30, 0.25),
                0 0 0 1px rgba(107, 13, 30, 0.1);
        }

        .btn--outline {
            background: white;
            color: var(--primary-maroon);
            border-color: var(--border-light);
            box-shadow: 0 2px 8px rgba(107, 13, 30, 0.1);
        }

        .btn--outline:hover {
            background: var(--soft-cream);
            border-color: var(--primary-maroon);
            transform: translateY(-3px);
        }

        .no-results {
            text-align: center;
            padding: 40px;
            color: var(--muted-text);
            display: none;
        }

        .no-results i {
            font-size: 48px;
            margin-bottom: 15px;
            color: var(--border-light);
        }

        .filter-select.active {
            border-color: var(--primary-maroon);
            background-color: var(--soft-cream);
            box-shadow: 0 0 0 3px rgba(107, 13, 30, 0.1);
        }

        .inner-search.loading i {
            animation: spin 1s linear infinite;
        }
        
        .modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0,0,0,0.7);
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 10000;
            animation: fadeIn 0.3s ease;
            backdrop-filter: blur(5px);
            display: none;
        }

        .rider-modal {
            background: white;
            border-radius: var(--radius-xl);
            max-width: 800px;
            width: 90%;
            max-height: 90vh;
            overflow-y: auto;
            box-shadow: 0 25px 50px rgba(0,0,0,0.25);
            animation: slideUp 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
        }

        .modal-header {
            padding: 25px 30px;
            border-bottom: 1px solid var(--border-light);
            background: linear-gradient(135deg, var(--primary-maroon), var(--primary-maroon-dark));
            color: white;
            border-radius: var(--radius-xl) var(--radius-xl) 0 0;
            position: relative;
        }

        .modal-header h3 {
            margin: 0;
            font-size: 22px;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .modal-header h3 .rider-id {
            background: rgba(255,255,255,0.2);
            padding: 4px 12px;
            border-radius: var(--radius-sm);
            font-size: 14px;
            font-weight: 500;
            color: white;
            font-family: 'Poppins', sans-serif;
        }

        .close-modal {
            position: absolute;
            top: 25px;
            right: 30px;
            background: rgba(255,255,255,0.2);
            border: none;
            width: 36px;
            height: 36px;
            border-radius: 50%;
            color: white;
            cursor: pointer;
            transition: all var(--transition-base);
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .close-modal:hover {
            background: rgba(255,255,255,0.3);
            transform: rotate(90deg);
        }

        .modal-body {
            padding: 30px;
        }

        .rider-info-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 25px;
            margin-bottom: 30px;
        }

        .info-section {
            background: var(--soft-cream);
            padding: 20px;
            border-radius: var(--radius-lg);
            border: 1px solid var(--border-light);
        }

        .info-section h4 {
            margin: 0 0 15px 0;
            color: var(--primary-maroon);
            font-size: 16px;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .info-section h4 i {
            color: var(--muted-text);
        }

        .info-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 0;
            border-bottom: 1px dashed var(--border-light);
        }

        .info-row:last-child {
            border-bottom: none;
        }

        .info-label {
            color: var(--muted-text);
            font-size: 13px;
            font-weight: 500;
        }

        .info-value {
            color: var(--text-dark);
            font-weight: 600;
            font-size: 14px;
            text-align: right;
        }

        .info-value.status {
            display: inline-flex;
            padding: 4px 12px;
            border-radius: var(--radius-sm);
            font-size: 12px;
            font-weight: 700;
            text-transform: uppercase;
        }

        .info-value.status-available {
            background: var(--success-green-light);
            color: var(--success-green);
        }

        .info-value.status-delivery {
            background: var(--warning-orange-light);
            color: var(--warning-orange);
        }

        .info-value.status-offline {
            background: var(--bg-lighter);
            color: var(--muted-text);
        }

        .rider-activity {
            background: white;
            border-radius: var(--radius-lg);
            padding: 25px;
            border: 1px solid var(--border-light);
        }

        .activity-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            margin-top: 15px;
        }

        .activity-stat {
            text-align: center;
            padding: 20px;
            background: var(--soft-cream);
            border-radius: var(--radius-md);
            transition: all var(--transition-base);
        }

        .activity-stat:hover {
            transform: translateY(-5px);
            box-shadow: var(--card-shadow);
        }

        .activity-stat__value {
            font-size: 28px;
            font-weight: 700;
            color: var(--primary-maroon);
            margin-bottom: 5px;
        }

        .activity-stat__label {
            color: var(--muted-text);
            font-size: 12px;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .modal-footer {
            padding: 20px 30px;
            border-top: 1px solid var(--border-light);
            display: flex;
            justify-content: flex-end;
            gap: 12px;
            background: var(--soft-cream);
            border-radius: 0 0 var(--radius-xl) var(--radius-xl);
        }

        .delete-confirm-modal {
            background: white;
            border-radius: var(--radius-xl);
            max-width: 400px;
            width: 90%;
            padding: 30px;
            text-align: center;
            animation: slideUp 0.4s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .delete-confirm-modal i {
            font-size: 48px;
            color: var(--danger-red);
            margin-bottom: 20px;
        }

        .delete-confirm-modal h3 {
            color: var(--text-dark);
            margin-top: 0;
            margin-bottom: 15px;
        }

        .delete-confirm-modal p {
            color: var(--muted-text);
            margin-bottom: 25px;
            font-size: 14px;
        }

        .delete-confirm-actions {
            display: flex;
            gap: 10px;
            justify-content: center;
        }

        .delete-confirm-actions .btn {
            min-width: 100px;
        }

        .add-rider-modal {
            background: white;
            border-radius: var(--radius-xl);
            max-width: 800px;
            width: 90%;
            max-height: 90vh;
            overflow-y: auto;
            box-shadow: 0 25px 50px rgba(0,0,0,0.25);
            animation: slideUp 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
        }

        .add-rider-modal__header {
            padding: 25px 30px;
            border-bottom: 1px solid var(--border-light);
            background: linear-gradient(135deg, var(--primary-maroon), var(--primary-maroon-dark));
            color: white;
            border-radius: var(--radius-xl) var(--radius-xl) 0 0;
            position: relative;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .add-rider-modal__header h3 {
            margin: 0;
            font-size: 22px;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 12px;
            color: white;
        }

        .add-rider-modal__header h3 i {
            color: rgba(255, 255, 255, 0.9);
        }

        .add-rider-modal__close {
            background: rgba(255, 255, 255, 0.2);
            border: none;
            width: 36px;
            height: 36px;
            border-radius: 50%;
            color: white;
            cursor: pointer;
            transition: all var(--transition-base);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 16px;
            flex-shrink: 0;
        }

        .add-rider-modal__close:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: rotate(90deg);
        }

        .add-rider-modal__body {
            padding: 30px;
        }

        .form-section {
            background: var(--soft-cream);
            padding: 20px;
            border-radius: var(--radius-lg);
            border: 1px solid var(--border-light);
            margin-bottom: 20px;
        }

        .form-section h4 {
            color: var(--primary-maroon);
            font-size: 16px;
            font-weight: 600;
            margin: 0 0 15px 0;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .form-section h4 i {
            color: var(--muted-text);
            font-size: 14px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: var(--text-dark);
            font-weight: 500;
            font-size: 13px;
        }

        .form-control {
            width: 100%;
            padding: 10px 15px;
            border: 2px solid var(--border-light);
            border-radius: var(--radius-md);
            font-size: 13px;
            font-family: 'Poppins', sans-serif;
            background: white;
            color: var(--text-dark);
            transition: all var(--transition-base);
            outline: none;
            box-sizing: border-box;
        }

        .form-control:focus {
            border-color: var(--primary-maroon);
            box-shadow: 0 0 0 3px rgba(107, 13, 30, 0.1);
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
        }

        .form-actions {
            display: flex;
            gap: 10px;
            justify-content: flex-end;
            margin-top: 30px;
        }

        .gender-options {
            display: flex;
            gap: 20px;
            margin-top: 10px;
        }

        .radio-option {
            display: flex;
            align-items: center;
            cursor: pointer;
        }

        .radio-option input[type="radio"] {
            margin-right: 8px;
            width: 16px;
            height: 16px;
            cursor: pointer;
        }

        .radio-label {
            color: var(--text-dark);
            font-size: 13px;
            font-weight: 500;
        }

        .file-upload-container {
            margin-top: 8px;
        }

        .file-input {
            display: none;
        }

        .file-label {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 15px;
            background: white;
            border: 2px dashed var(--border-light);
            border-radius: var(--radius-md);
            color: var(--muted-text);
            cursor: pointer;
            transition: all var(--transition-base);
            font-size: 13px;
            font-weight: 500;
        }

        .file-label:hover {
            background: var(--bg-lighter);
            border-color: var(--primary-maroon);
            color: var(--primary-maroon);
        }

        .file-label i {
            font-size: 16px;
        }

        .file-hint {
            display: block;
            margin-top: 5px;
            color: var(--muted-text);
            font-size: 11px;
            font-style: italic;
        }

        .file-preview {
            margin-top: 10px;
            padding: 10px;
            background: white;
            border-radius: var(--radius-sm);
            border: 1px solid var(--border-light);
            font-size: 12px;
            color: var(--muted-text);
            display: none;
        }

        .file-preview.show {
            display: block;
        }

        .form-text {
            display: block;
            margin-top: 5px;
            color: var(--muted-text);
            font-size: 11px;
            font-style: italic;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes tableRowFadeIn {
            from {
                opacity: 0;
                transform: translateY(10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes bounce {
            from { transform: translateY(0); }
            to { transform: translateY(-3px); }
        }

        @keyframes underlineExpand {
            from { width: 0; }
            to { width: 100%; }
        }

        @keyframes tooltipFadeIn {
            from {
                opacity: 0;
                transform: translateX(-50%) translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateX(-50%) translateY(0);
            }
        }

        @keyframes shimmer {
            0% { left: -100%; }
            100% { left: 100%; }
        }

        @keyframes spin {
            from { transform: translateY(-50%) rotate(0deg); }
            to { transform: translateY(-50%) rotate(360deg); }
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

        @media (max-width: 1400px) {
            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 1200px) {
            #delivery-mgmt-wrapper {
                padding: 15px 20px;
            }
            
            .filter-container {
                flex-wrap: wrap;
                gap: 8px;
            }
            
            .inner-search {
                min-width: calc(100% - 10px);
                margin-bottom: 0;
            }
            
            .filter-select {
                min-width: calc(50% - 6px);
            }
            
            .custom-table {
                font-size: 12px;
            }
            
            .custom-table th {
                font-size: 10px;
                padding: 14px 8px;
            }
            
            .custom-table td {
                font-size: 12px;
                padding: 14px 8px;
            }

            .rider-info-grid {
                grid-template-columns: 1fr;
            }

            .form-row {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 992px) {
            .page-header {
                flex-direction: column;
                align-items: stretch;
                gap: 15px;
                margin-bottom: 20px;
            }
            
            .header-title h2 {
                font-size: 24px;
            }
            
            .header-actions {
                justify-content: flex-start;
                width: 100%;
            }
            
            .btn {
                width: 100%;
                justify-content: center;
            }
        }

        @media (max-width: 768px) {
            .stats-grid {
                grid-template-columns: 1fr;
            }
            
            .filter-container {
                flex-direction: column;
                width: 100%;
            }
            
            .inner-search {
                min-width: 100%;
                margin-bottom: 8px;
            }
            
            .filter-select {
                width: 100%;
                min-width: auto;
            }
            
            .table-container {
                border-radius: var(--radius-md);
            }
            
            .custom-table th,
            .custom-table td {
                padding: 12px 6px;
                font-size: 11px;
            }
            
            .action-btns {
                flex-wrap: wrap;
                justify-content: center;
            }

            .modal-body {
                padding: 20px;
            }

            .modal-header {
                padding: 20px;
            }

            .modal-footer {
                padding: 15px 20px;
            }

            .activity-grid {
                grid-template-columns: 1fr;
            }

            .delete-confirm-modal {
                padding: 20px;
            }

            .add-rider-modal {
                padding: 0;
            }

            .add-rider-modal__header {
                padding: 20px;
            }

            .add-rider-modal__body {
                padding: 20px;
            }

            .gender-options {
                flex-direction: column;
                gap: 10px;
            }
            
            .form-section {
                padding: 15px;
            }
        }

        @media (max-width: 480px) {
            #delivery-mgmt-wrapper {
                padding: 12px 15px;
            }
            
            .header-title h2 {
                font-size: 20px;
            }
            
            .header-title p {
                font-size: 13px;
            }
            
            .stat-card {
                padding: 15px;
            }

            .stat-card__value { 
                font-size: 22px;
            }
            
            .btn {
                padding: 6px 12px;
                font-size: 12px;
                min-height: 32px;
            }

            .modal-header h3 {
                font-size: 18px;
                flex-direction: column;
                align-items: flex-start;
                gap: 8px;
            }

            .modal-footer {
                flex-direction: column;
            }

            .modal-footer .btn {
                width: 100%;
            }

            .delete-confirm-actions {
                flex-direction: column;
            }

            .delete-confirm-actions .btn {
                width: 100%;
            }

            .form-actions {
                flex-direction: column;
            }

            .form-actions .btn {
                width: 100%;
            }

            .add-rider-modal__header h3 {
                font-size: 18px;
            }

            .add-rider-modal__close {
                width: 32px;
                height: 32px;
                font-size: 14px;
            }
        }
        /* ── Order status badges (rptRiderOrders) ── */
        .badge-completed { padding:3px 10px; border-radius:20px; font-size:11px; font-weight:700; background:#e6f4f1; color:#2d9d78; display:inline-block; }
        .badge-cancelled { padding:3px 10px; border-radius:20px; font-size:11px; font-weight:700; background:#fdecea; color:#b91c1c; display:inline-block; }
        .badge-active    { padding:3px 10px; border-radius:20px; font-size:11px; font-weight:700; background:#fff3e6; color:#d97706; display:inline-block; }
        .badge-pending   { padding:3px 10px; border-radius:20px; font-size:11px; font-weight:700; background:#fff3e6; color:#d97706; display:inline-block; }
        .badge-default   { padding:3px 10px; border-radius:20px; font-size:11px; font-weight:700; background:#f0f0f0;  color:#666;    display:inline-block; }
        /* ── Document Approval Styles ─────────────────────────────────────── */
        .doc-approval-card {
            border-radius: 10px; overflow: hidden;
            border: 2px solid var(--border-light);
            background: var(--bg-lighter);
            transition: box-shadow var(--transition-fast), transform var(--transition-fast);
        }
        .doc-approval-card:hover { box-shadow: 0 6px 20px rgba(107,13,30,0.12); transform: translateY(-2px); }
        .doc-approval-card__img {
            height: 110px; overflow: hidden; background: var(--bg-light);
            position: relative; cursor: pointer;
        }
        .doc-approval-card__img img { width:100%; height:100%; object-fit:cover; }
        .doc-approval-badge {
            position: absolute; top: 6px; left: 6px;
            padding: 3px 8px; border-radius: 20px;
            font-size: 10px; font-weight: 700; letter-spacing: 0.3px;
            text-transform: uppercase;
        }
        .badge-approved  { background: var(--success-green-light); color: var(--success-green); border: 1px solid var(--success-green); }
        .badge-pending   { background: var(--warning-orange-light); color: var(--warning-orange); border: 1px solid var(--warning-orange); }
        .badge-rejected  { background: var(--danger-red-light);     color: var(--danger-red);     border: 1px solid var(--danger-red); }
        .badge-unreviewed { background: var(--bg-light); color: var(--muted-text); border: 1px solid var(--border-light); }
        .doc-approval-card__footer {
            padding: 8px 10px;
            font-size: 11px; font-weight: 600; color: var(--text-dark); text-align: center;
        }
        .doc-approval-card__footer span { display:block; font-size:10px; color:var(--muted-text); font-weight:400; margin-top:2px; }
        .doc-approval-actions {
            display: flex; gap: 5px; padding: 0 8px 8px; justify-content: center;
        }
        .btn-approve, .btn-reject {
            flex: 1; padding: 5px 8px; border: none; border-radius: 6px;
            font-size: 11px; font-weight: 600; cursor: pointer;
            font-family: 'Poppins', sans-serif;
            display: inline-flex; align-items: center; justify-content: center; gap: 4px;
            transition: all var(--transition-fast);
        }
        .btn-approve { background: var(--success-green-light); color: var(--success-green); border: 1px solid var(--success-green); }
        .btn-approve:hover { background: var(--success-green); color: white; }
        .btn-reject  { background: var(--danger-red-light);   color: var(--danger-red);   border: 1px solid var(--danger-red); }
        .btn-reject:hover  { background: var(--danger-red);   color: white; }
        .btn-approve:disabled, .btn-reject:disabled { opacity: 0.5; cursor: not-allowed; }
        .doc-no-photo {
            height: 110px; display: flex; align-items: center; justify-content: center;
            color: var(--muted-text); font-size: 28px; background: var(--bg-light);
        }
    </style>

    <div id="delivery-mgmt-wrapper">
        <div class="page-header">
            <div class="header-title">
                <h2>Delivery Personnel</h2>
                <p>Manage riders and delivery staff performance</p>
            </div>
            <div class="header-actions">
                <button type="button" class="btn btn--secondary" onclick="showAddRiderModal()">
                    <i class="fas fa-plus"></i>
                    Add Rider
                </button>
            </div>
        </div>

        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-card__header">
                    <span class="stat-card__label">Total Active Riders</span>
                    <div class="stat-card__icon stat-card__icon--total">
                        <i class="fas fa-user"></i>
                    </div>
                </div>
                <div class="stat-card__value" id="totalRiders">5</div>
                <div class="stat-card__trend">All registered riders</div>
            </div>

            <div class="stat-card">
                <div class="stat-card__header">
                    <span class="stat-card__label">Available Now</span>
                    <div class="stat-card__icon stat-card__icon--available">
                        <i class="fas fa-clock"></i>
                    </div>
                </div>
                <div class="stat-card__value" id="availableRiders">3</div>
                <div class="stat-card__trend">Currently available</div>
            </div>

            <div class="stat-card">
                <div class="stat-card__header">
                    <span class="stat-card__label">On Delivery</span>
                    <div class="stat-card__icon stat-card__icon--delivery">
                        <i class="fas fa-motorcycle"></i>
                    </div>
                </div>
                <div class="stat-card__value" id="onDeliveryRiders">2</div>
                <div class="stat-card__trend">Currently delivering</div>
            </div>

            <div class="stat-card">
                <div class="stat-card__header">
                    <span class="stat-card__label">Offline</span>
                    <div class="stat-card__icon stat-card__icon--orders">
                        <i class="fas fa-moon"></i>
                    </div>
                </div>
                <div class="stat-card__value" id="offlineRiders">0</div>
                <div class="stat-card__trend">Not available</div>
            </div>
        </div>

        <div class="filter-container">
            <div class="inner-search" id="searchBox">
                <i class="fas fa-search"></i>
                <input type="text" id="searchInput" placeholder="Search by name, ID, or contact...">
            </div>
            <select class="filter-select" id="statusFilter">
                <option value="all">All Status</option>
                <option value="available">Available</option>
                <option value="delivery">On Delivery</option>
                <option value="offline">Offline</option>
            </select>
            <select class="filter-select" id="vehicleFilter">
                <option value="all">All Vehicles</option>
                <option value="motorcycle">Motorcycle</option>
                <option value="bicycle">Bicycle</option>
            </select>
            <select class="filter-select" id="sortFilter">
                <option value="rating">Sort by: Rating</option>
                <option value="orders-desc">Sort by: Completed Orders (High to Low)</option>
                <option value="orders-asc">Sort by: Completed Orders (Low to High)</option>
                <option value="name-asc">Sort by: Name (A-Z)</option>
                <option value="name-desc">Sort by: Name (Z-A)</option>
                <option value="date-desc">Sort by: Date Joined (Newest)</option>
                <option value="date-asc">Sort by: Date Joined (Oldest)</option>
            </select>
        </div>

        <div class="table-container">
            <div class="table-wrapper">
                <table class="custom-table">
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
                    <tbody id="ridersTableBody">
                    </tbody>
                </table>
                <div class="no-results" id="noResultsMessage">
                    <i class="fas fa-search"></i>
                    <h3>No results found</h3>
                    <p>Try searching with different keywords</p>
                </div>
            </div>
        </div>
    </div>

    <div id="riderModal" class="modal-overlay">
        <div class="rider-modal">
            <div class="modal-header">
                <h3>
                    <i class="fas fa-user-circle"></i>
                    Rider Details
                    <span class="rider-id" id="modalRiderId">RDR-000</span>
                </h3>
                <button class="close-modal" onclick="closeModal()">
                    <i class="fas fa-times"></i>
                </button>
            </div>
            <div class="modal-body">
                <div class="rider-info-grid">
                    <div class="info-section">
                        <h4><i class="fas fa-id-card"></i> Personal Information</h4>
                        <div class="info-row">
                            <span class="info-label">Full Name:</span>
                            <span class="info-value" id="modalFullName">Loading...</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Date Joined:</span>
                            <span class="info-value" id="modalDateJoined">Loading...</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Email Address:</span>
                            <span class="info-value" id="modalEmail">Loading...</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Phone Number:</span>
                            <span class="info-value" id="modalPhone">Loading...</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Vehicle Type:</span>
                            <span class="info-value" id="modalVehicle">Loading...</span>
                        </div>
                    </div>
                    
                    <div class="info-section">
                        <h4><i class="fas fa-chart-line"></i> Account Status</h4>
                        <div class="info-row">
                            <span class="info-label">Rider ID:</span>
                            <span class="info-value" id="modalRiderId2">Loading...</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Status:</span>
                            <span class="info-value status" id="modalStatus">Loading</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Last Activity:</span>
                            <span class="info-value" id="modalLastActivity">Today, 10:30 AM</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Account Type:</span>
                            <span class="info-value">Delivery Rider</span>
                        </div>
                    </div>
                </div>

                <div class="rider-activity">
                    <h4><i class="fas fa-shipping-fast"></i> Delivery Activity</h4>
                    <div class="activity-grid">
                        <div class="activity-stat">
                            <div class="activity-stat__value" id="modalAssignedOrders">0</div>
                            <div class="activity-stat__label">Assigned Orders</div>
                        </div>
                        <div class="activity-stat">
                            <div class="activity-stat__value" id="modalCompletedDeliveries">0</div>
                            <div class="activity-stat__label">Completed Deliveries</div>
                        </div>
                        <div class="activity-stat">
                            <div class="activity-stat__value" id="modalRating">0.0</div>
                            <div class="activity-stat__label">Rating</div>
                        </div>
                    </div>
                </div>

                <div class="rider-activity" style="margin-top: 20px;">
                    <h4 style="display:flex;align-items:center;justify-content:space-between;">
                        <span><i class="fas fa-file-alt"></i> Requirement Documents</span>
                        <span id="pendingDocsCount" style="font-size:12px;font-weight:500;color:var(--warning-orange);display:none;">
                            <i class="fas fa-clock"></i> <span id="pendingDocsNum">0</span> pending approval
                        </span>
                    </h4>
                    <div id="modalDocPhotos" style="display:grid;grid-template-columns:repeat(auto-fill,minmax(160px,1fr));gap:14px;margin-top:14px;"></div>
                </div>

                <div class="rider-activity" style="margin-top: 20px;">
                    <asp:UpdatePanel ID="upOrders" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <asp:Button ID="btnLoadOrders" runat="server" Text="" 
                                OnClick="btnLoadOrders_Click"
                                style="display:none;" />
                            <div style="display:flex;align-items:center;justify-content:space-between;flex-wrap:wrap;gap:10px;margin-bottom:10px;">
                                <h4 style="margin:0;"><i class="fas fa-history"></i> Recent Deliveries</h4>
                                <asp:DropDownList ID="ddlOrderPeriod" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlOrderPeriod_SelectedIndexChanged" style="font-family:Poppins,sans-serif;font-size:12px;font-weight:500;padding:6px 12px;border-radius:8px;border:1.5px solid var(--border-light);background:white;color:var(--text-dark);cursor:pointer;outline:none;">
                                    <asp:ListItem Value="today">Today</asp:ListItem>
                                    <asp:ListItem Value="weekly">This Week</asp:ListItem>
                                    <asp:ListItem Value="monthly" Selected="True">This Month</asp:ListItem>
                                </asp:DropDownList>
                            </div>

                            <asp:Repeater ID="rptRiderOrders" runat="server">
                                <HeaderTemplate>
                                    <div style="overflow-x:auto;margin-top:4px;">
                                    <table style="width:100%;border-collapse:collapse;font-size:13px;">
                                        <thead>
                                            <tr style="background:var(--bg-lighter);">
                                                <th style="padding:10px 14px;text-align:left;font-size:11px;font-weight:600;color:var(--muted-text);text-transform:uppercase;letter-spacing:0.4px;border-bottom:2px solid var(--border-light);white-space:nowrap;">Ticket No.</th>
                                                <th style="padding:10px 14px;text-align:left;font-size:11px;font-weight:600;color:var(--muted-text);text-transform:uppercase;letter-spacing:0.4px;border-bottom:2px solid var(--border-light);white-space:nowrap;">Delivery Address</th>
                                                <th style="padding:10px 14px;text-align:left;font-size:11px;font-weight:600;color:var(--muted-text);text-transform:uppercase;letter-spacing:0.4px;border-bottom:2px solid var(--border-light);white-space:nowrap;">Status</th>
                                                <th style="padding:10px 14px;text-align:left;font-size:11px;font-weight:600;color:var(--muted-text);text-transform:uppercase;letter-spacing:0.4px;border-bottom:2px solid var(--border-light);white-space:nowrap;">Date</th>
                                                <th style="padding:10px 14px;text-align:right;font-size:11px;font-weight:600;color:var(--muted-text);text-transform:uppercase;letter-spacing:0.4px;border-bottom:2px solid var(--border-light);white-space:nowrap;">Amount</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <tr style="background:white;" onmouseover="this.style.background='#fefaf5'" onmouseout="this.style.background='white'">
                                        <td style="padding:11px 14px;border-bottom:1px solid #f9f4ee;font-family:Courier New,monospace;font-weight:700;font-size:12px;color:#6b0d1e;"><%# Eval("TicketNumber") %></td>
                                        <td style="padding:11px 14px;border-bottom:1px solid #f9f4ee;color:#8a6d6d;font-size:12px;max-width:180px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;" title='<%# Eval("DeliveryAddress") %>'><%# string.IsNullOrEmpty(Eval("DeliveryAddress")?.ToString()) ? "&mdash;" : Eval("DeliveryAddress").ToString() %></td>
                                        <td style="padding:11px 14px;border-bottom:1px solid #f9f4ee;">
                                            <span class='<%# GetStatusClass(Eval("Status")?.ToString()) %>'><%# Eval("Status") %></span>
                                        </td>
                                        <td style="padding:11px 14px;border-bottom:1px solid #f9f4ee;color:#8a6d6d;font-size:12px;white-space:nowrap;"><%# Eval("CreatedAt") != DBNull.Value ? Convert.ToDateTime(Eval("CreatedAt")).ToString("MMM d, yyyy h:mm tt") : "—" %></td>
                                        <td style="padding:11px 14px;border-bottom:1px solid #f9f4ee;text-align:right;font-weight:700;color:#2d9d78;"><%# Eval("TotalAmount") != DBNull.Value ? "₱" + Convert.ToDecimal(Eval("TotalAmount")).ToString("N2") : "—" %></td>
                                    </tr>
                                </ItemTemplate>
                                <AlternatingItemTemplate>
                                    <tr style="background:#f9f4ee;" onmouseover="this.style.background='#fefaf5'" onmouseout="this.style.background='#f9f4ee'">
                                        <td style="padding:11px 14px;border-bottom:1px solid #f9f4ee;font-family:Courier New,monospace;font-weight:700;font-size:12px;color:#6b0d1e;"><%# Eval("TicketNumber") %></td>
                                        <td style="padding:11px 14px;border-bottom:1px solid #f9f4ee;color:#8a6d6d;font-size:12px;max-width:180px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;" title='<%# Eval("DeliveryAddress") %>'><%# string.IsNullOrEmpty(Eval("DeliveryAddress")?.ToString()) ? "&mdash;" : Eval("DeliveryAddress").ToString() %></td>
                                        <td style="padding:11px 14px;border-bottom:1px solid #f9f4ee;">
                                            <span class='<%# GetStatusClass(Eval("Status")?.ToString()) %>'><%# Eval("Status") %></span>
                                        </td>
                                        <td style="padding:11px 14px;border-bottom:1px solid #f9f4ee;color:#8a6d6d;font-size:12px;white-space:nowrap;"><%# Eval("CreatedAt") != DBNull.Value ? Convert.ToDateTime(Eval("CreatedAt")).ToString("MMM d, yyyy h:mm tt") : "—" %></td>
                                        <td style="padding:11px 14px;border-bottom:1px solid #f9f4ee;text-align:right;font-weight:700;color:#2d9d78;"><%# Eval("TotalAmount") != DBNull.Value ? "₱" + Convert.ToDecimal(Eval("TotalAmount")).ToString("N2") : "—" %></td>
                                    </tr>
                                </AlternatingItemTemplate>
                                <FooterTemplate>
                                        </tbody>
                                    </table>
                                    </div>
                                </FooterTemplate>
                            </asp:Repeater>
                            <asp:Panel ID="pnlNoOrders" runat="server" Visible="false">
                                <div style="text-align:center;padding:30px;color:var(--muted-text);">
                                    <i class="fas fa-box-open" style="font-size:36px;margin-bottom:10px;color:var(--border-light);display:block;"></i>
                                    <p style="margin:0;font-size:13px;">No orders found for this period.</p>
                                </div>
                            </asp:Panel>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="btnLoadOrders" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="ddlOrderPeriod" EventName="SelectedIndexChanged" />
                        </Triggers>
                    </asp:UpdatePanel>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn--outline" onclick="closeModal()">
                    <i class="fas fa-times"></i> Close
                </button>
                <button class="btn btn--primary" id="modalActionButton" onclick="toggleRiderStatus()">
                    <i class="fas fa-ban"></i> Change Status
                </button>
            </div>
        </div>
    </div>

    <div id="deleteConfirmModal" class="modal-overlay" style="display: none;">
        <div class="delete-confirm-modal">
            <i class="fas fa-exclamation-triangle"></i>
            <h3>Delete Rider</h3>
            <p id="deleteConfirmationText">Are you sure you want to delete this rider?</p>
            <p style="color: var(--muted-text); font-size: 12px; margin-top: -10px;">This action cannot be undone.</p>
            <div class="delete-confirm-actions">
                <button id="confirmDelete" class="btn btn--primary" style="background: var(--danger-red);">
                    Delete
                </button>
                <button id="cancelDelete" class="btn btn--outline">
                    Cancel
                </button>
            </div>
        </div>
    </div>

    <div id="addRiderModal" class="modal-overlay" style="display: none;">
        <div class="add-rider-modal">
            <div class="add-rider-modal__header">
                <h3><i class="fas fa-user-plus"></i> Add New Rider</h3>
                <button class="add-rider-modal__close" onclick="closeAddRiderModal()" title="Close">
                    <i class="fas fa-times"></i>
                </button>
            </div>
            <div class="add-rider-modal__body">
                <div id="addRiderForm">
                    <div class="form-section">
                        <h4><i class="fas fa-user-circle"></i> Personal Information</h4>

                        <!-- Profile Picture -->
                        <div class="form-group" style="display:flex;flex-direction:column;align-items:center;margin-bottom:18px;">
                            <label style="margin-bottom:8px;font-weight:600;">Profile Picture</label>
                            <div id="profilePicPreviewWrap" style="width:90px;height:90px;border-radius:50%;overflow:hidden;border:3px solid var(--border-light);background:var(--bg-light);display:flex;align-items:center;justify-content:center;margin-bottom:10px;cursor:pointer;" onclick="document.getElementById('newRiderProfilePic').click()">
                                <img id="profilePicPreviewImg" src="" alt="" style="width:100%;height:100%;object-fit:cover;display:none;">
                                <i id="profilePicIcon" class="fas fa-camera" style="font-size:28px;color:var(--muted-text);"></i>
                            </div>
                            <input type="file" id="newRiderProfilePic" accept="image/*" style="display:none;">
                            <small class="form-text" style="text-align:center;">Click photo to upload (JPG, PNG)</small>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="newRiderFullName">Full Name *</label>
                                <input type="text" id="newRiderFullName" class="form-control" placeholder="Enter full name" required>
                            </div>
                            <div class="form-group">
                                <label for="newRiderUsername">Username *</label>
                                <input type="text" id="newRiderUsername" class="form-control" placeholder="Enter username" required>
                            </div>
                        </div>
                        
                        <div class="form-row">
                            <div class="form-group">
                                <label for="newRiderEmail">Email *</label>
                                <input type="email" id="newRiderEmail" class="form-control" placeholder="email@example.com" required>
                            </div>
                            <div class="form-group">
                                <label for="newRiderMobile">Mobile Number (+63) *</label>
                                <input type="tel" id="newRiderMobile" class="form-control" placeholder="9123456789" pattern="[0-9]{10}" title="Please enter a 11-digit phone number" required>
                                <small class="form-text">Format: 9123456789 (10 digits)</small>
                            </div>
                        </div>
                        
                        <div class="form-row">
                            <div class="form-group">
                                <label for="newRiderLicense">Driver's License Number *</label>
                                <input type="text" id="newRiderLicense" class="form-control" placeholder="Enter license number" required>
                            </div>
                            <div class="form-group">
                                <label for="newRiderNBI">NBI Clearance Number *</label>
                                <input type="text" id="newRiderNBI" class="form-control" placeholder="Enter NBI clearance number" required>
                            </div>
                        </div>
                        
                        <div class="form-row">
                            <div class="form-group">
                                <label for="newRiderPassword">Password *</label>
                                <input type="password" id="newRiderPassword" class="form-control" placeholder="Enter password" required minlength="8">
                                <small class="form-text">Minimum 8 characters</small>
                            </div>
                            <div class="form-group">
                                <label for="newRiderConfirmPassword">Confirm Password *</label>
                                <input type="password" id="newRiderConfirmPassword" class="form-control" placeholder="Confirm password" required>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label>Gender *</label>
                            <div class="gender-options">
                                <label class="radio-option">
                                    <input type="radio" name="gender" value="male" required>
                                    <span class="radio-label">Male</span>
                                </label>
                                <label class="radio-option">
                                    <input type="radio" name="gender" value="female">
                                    <span class="radio-label">Female</span>
                                </label>
                                <label class="radio-option">
                                    <input type="radio" name="gender" value="prefer-not-to-say">
                                    <span class="radio-label">Rather not say</span>
                                </label>
                            </div>
                        </div>
                    </div>
                    
                    <div class="form-section">
                        <h4><i class="fas fa-motorcycle"></i> Vehicle Information</h4>
                        <div class="form-row">
                            <div class="form-group">
                                <label for="newRiderVehicleType">Vehicle Type *</label>
                                <select id="newRiderVehicleType" class="form-control" required>
                                    <option value="">Select vehicle type</option>
                                    <option value="Motorcycle">Motorcycle</option>
                                    <option value="Bicycle">Bicycle</option>
                                    <option value="Car">Car</option>
                                    <option value="Scooter">Scooter</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="newRiderVehicleModel">Model *</label>
                                <input type="text" id="newRiderVehicleModel" class="form-control" placeholder="Enter vehicle model" required>
                            </div>
                        </div>
                        
                        <div class="form-row">
                            <div class="form-group">
                                <label for="newRiderVehicleYear">Year *</label>
                                <input type="number" id="newRiderVehicleYear" class="form-control" placeholder="e.g. 2022" min="2000" max="2027" required>
                            </div>
                            <div class="form-group">
                                <label for="newRiderLicensePlate">License Plate Number *</label>
                                <input type="text" id="newRiderLicensePlate" class="form-control" placeholder="Enter license plate" required>
                            </div>
                        </div>
                        
                        <div class="form-row">
                            <div class="form-group">
                                <label for="newRiderVehicleColor">Vehicle Color *</label>
                                <input type="text" id="newRiderVehicleColor" class="form-control" placeholder="Enter vehicle color" required>
                            </div>
                            <div class="form-group">
                                <label for="newRiderORCR">OR/CR Number *</label>
                                <input type="text" id="newRiderORCR" class="form-control" placeholder="Enter OR/CR number" required>
                            </div>
                        </div>
                    </div>
                    
                    <div class="form-section">
                        <h4><i class="fas fa-shield-alt"></i> Insurance Information</h4>
                        <div class="form-row">
                            <div class="form-group">
                                <label for="newRiderInsurancePolicy">Insurance Policy Number *</label>
                                <input type="text" id="newRiderInsurancePolicy" class="form-control" placeholder="Enter policy number" required>
                            </div>
                            <div class="form-group">
                                <label for="newRiderInsuranceDate">Date *</label>
                                <input type="date" id="newRiderInsuranceDate" class="form-control" required>
                            </div>
                        </div>
                    </div>
                    
                    <div class="form-section">
                        <h4><i class="fas fa-file-upload"></i> Requirement Documents</h4>
                        
                        <div class="document-upload">
                            <div class="form-group">
                                <label>Driver's License *</label>
                                <div class="file-upload-container">
                                    <input type="file" id="newRiderLicenseFile" class="file-input" accept="image/*,.pdf" required>
                                    <label for="newRiderLicenseFile" class="file-label">
                                        <i class="fas fa-cloud-upload-alt"></i>
                                        <span>Choose file</span>
                                    </label>
                                    <small class="file-hint">Upload clear photo or scanned copy</small>
                                    <div class="file-preview" id="licensePreview"></div>
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <label>Vehicle Registration (OR/CR) *</label>
                                <div class="file-upload-container">
                                    <input type="file" id="newRiderORCRFile" class="file-input" accept="image/*,.pdf" required>
                                    <label for="newRiderORCRFile" class="file-label">
                                        <i class="fas fa-cloud-upload-alt"></i>
                                        <span>Choose file</span>
                                    </label>
                                    <small class="file-hint">Upload clear photo or scanned copy</small>
                                    <div class="file-preview" id="orcrPreview"></div>
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <label>Insurance Certificate *</label>
                                <div class="file-upload-container">
                                    <input type="file" id="newRiderInsuranceFile" class="file-input" accept="image/*,.pdf" required>
                                    <label for="newRiderInsuranceFile" class="file-label">
                                        <i class="fas fa-cloud-upload-alt"></i>
                                        <span>Choose file</span>
                                    </label>
                                    <small class="file-hint">Must be valid and active</small>
                                    <div class="file-preview" id="insurancePreview"></div>
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <label>NBI Clearance *</label>
                                <div class="file-upload-container">
                                    <input type="file" id="newRiderNBIFile" class="file-input" accept="image/*,.pdf" required>
                                    <label for="newRiderNBIFile" class="file-label">
                                        <i class="fas fa-cloud-upload-alt"></i>
                                        <span>Choose file</span>
                                    </label>
                                    <small class="file-hint">Upload clear photo or scanned copy</small>
                                    <div class="file-preview" id="nbiPreview"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="form-actions">
                        <button type="button" class="btn btn--outline" onclick="closeAddRiderModal()">
                            Cancel
                        </button>
                        <button type="button" class="btn btn--primary" onclick="addNewRider(event)">
                            <i class="fas fa-save"></i> Save Rider
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        // Data injected directly from code-behind on page load
        // Normalise types: id→string, rating→number, assigned/completed→number
        let ridersData = (<%= GetRidersJson() %>).map(function (r) {
            return Object.assign(r, {
                id: String(r.id),
                rating: parseFloat(r.rating) || 0,
                assigned: parseInt(r.assigned) || 0,
                completed: parseInt(r.completed) || 0
            });
        });
        // All AJAX actions post directly to this page with ?action= — no .ashx files needed
        const pageUrl = window.location.pathname;

        let allRiders = [];
        let currentRiderId = null;
        let riderToDelete = null;

        function initializeRiderTable() {
            const tbody = document.getElementById('ridersTableBody');
            tbody.innerHTML = '';

            ridersData.forEach(rider => {
                const row = document.createElement('tr');
                row.setAttribute('data-rider-id', rider.id);
                row.setAttribute('data-status', rider.status);
                row.setAttribute('data-vehicle', rider.vehicle.toLowerCase());
                row.setAttribute('data-orders', rider.completed);
                row.setAttribute('data-rating', rider.rating);
                row.setAttribute('data-date', rider.joinDate);

                const fullStars = Math.floor(rider.rating);
                const hasHalfStar = rider.rating % 1 >= 0.5;
                const emptyStars = 5 - fullStars - (hasHalfStar ? 1 : 0);

                let starsHtml = '';
                for (let i = 0; i < fullStars; i++) starsHtml += '<i class="fas fa-star"></i>';
                if (hasHalfStar) starsHtml += '<i class="fas fa-star-half-alt"></i>';
                for (let i = 0; i < emptyStars; i++) starsHtml += '<i class="far fa-star"></i>';

                row.innerHTML = `
                    <td>
                        <span class="rider-id">RDR-${rider.id.padStart(3, '0')}</span>
                    </td>
                    <td>
                        <div class="rider-info" style="display:flex;align-items:center;gap:10px;">
                            <div style="width:38px;height:38px;border-radius:50%;overflow:hidden;background:var(--bg-light);flex-shrink:0;border:2px solid var(--border-light);">
                                ${rider.profilePicture
                        ? `<img src="${rider.profilePicture}" style="width:100%;height:100%;object-fit:cover;" onerror="this.parentElement.innerHTML='<i class=\'fas fa-user\' style=\'font-size:18px;color:var(--muted-text);margin:auto;display:block;padding-top:9px;\'></i>'">`
                        : `<i class="fas fa-user" style="font-size:18px;color:var(--muted-text);margin:auto;display:block;padding-top:9px;"></i>`}
                            </div>
                            <div>
                                <span class="rider-name">${rider.name}</span>
                                <span class="rider-contact">Joined: ${rider.joinDate}</span>
                            </div>
                        </div>
                    </td>
                    <td>
                        <div class="contact-info">
                            <span class="contact-phone">${rider.phone}</span>
                            <span class="contact-email">${rider.email}</span>
                        </div>
                    </td>
                    <td><span class="vehicle-badge">${rider.vehicle}</span></td>
                    <td>
                        <span class="status-badge ${getStatusClass(rider.status)}">
                            ${getStatusText(rider.status)}
                        </span>
                    </td>
                    <td class="stat-number">${rider.assigned}</td>
                    <td class="completed-deliveries">${rider.completed.toLocaleString()}</td>
                    <td>
                        <div class="rating-container">
                            <div class="rating-stars">
                                ${starsHtml}
                            </div>
                            <div class="rating-value">${rider.rating.toFixed(1)}</div>
                        </div>
                    </td>
                    <td>
                        <div class="action-btns">
                            <button type="button" class="action-icon view" title="View Profile">
                                <i class="fas fa-eye"></i>
                            </button>
                            <button type="button" class="action-icon edit" title="Edit Rider">
                                <i class="fas fa-pencil-alt"></i>
                            </button>
                            <button type="button" class="action-icon delete" title="Remove Rider">
                                <i class="fas fa-trash"></i>
                            </button>
                        </div>
                    </td>
                `;

                tbody.appendChild(row);
            });

            initializeRiderData();
            setupEventListeners();
        }

        function getStatusClass(status) {
            switch (status) {
                case 'available': return 'status-badge--available';
                case 'delivery': return 'status-badge--delivery';
                default: return 'status-badge--offline';
            }
        }

        function getStatusText(status) {
            switch (status) {
                case 'available': return 'Available';
                case 'delivery': return 'On Delivery';
                default: return 'Offline';
            }
        }

        function initializeRiderData() {
            const rows = document.querySelectorAll('#ridersTableBody tr');
            allRiders = [];

            rows.forEach(row => {
                const cells = row.querySelectorAll('td');
                const id = row.dataset.riderId;
                const name = cells[1].querySelector('.rider-name').textContent;
                const joinDate = cells[1].querySelector('.rider-contact')?.textContent.replace('Joined: ', '') || '';
                const phone = cells[2].querySelector('.contact-phone').textContent;
                const email = cells[2].querySelector('.contact-email').textContent;
                const vehicle = row.dataset.vehicle || '';
                const status = row.dataset.status || 'available';
                const assigned = parseInt(cells[5].textContent) || 0;
                const completed = parseInt(cells[6].textContent.replace(/,/g, '')) || 0;
                const rating = parseFloat(row.dataset.rating) || 0;
                const date = row.dataset.date || '';

                allRiders.push({
                    element: row,
                    id: id,
                    name: name,
                    joinDate: joinDate,
                    phone: phone,
                    email: email,
                    vehicle: vehicle,
                    status: status,
                    assigned: assigned,
                    completed: completed,
                    rating: rating,
                    date: date
                });
            });

            updateStats();
        }

        function setupEventListeners() {
            const tableBody = document.getElementById('ridersTableBody');

            tableBody.addEventListener('click', function (e) {
                const target = e.target;
                const deleteBtn = target.closest('.action-icon.delete');
                const viewBtn = target.closest('.action-icon.view');
                const editBtn = target.closest('.action-icon.edit');

                if (deleteBtn) {
                    e.preventDefault();
                    e.stopPropagation();
                    const row = deleteBtn.closest('tr');
                    const riderId = row.getAttribute('data-rider-id');
                    if (riderId) showDeleteConfirmation(riderId);
                    return false;
                }

                if (viewBtn) {
                    e.preventDefault();
                    e.stopPropagation();
                    const row = viewBtn.closest('tr');
                    const riderId = row.getAttribute('data-rider-id');
                    if (riderId) viewRider(riderId);
                    return false;
                }

                if (editBtn) {
                    e.preventDefault();
                    e.stopPropagation();
                    const row = editBtn.closest('tr');
                    const riderId = row.getAttribute('data-rider-id');
                    if (riderId) openEditModal(riderId);
                    return false;
                }
            });
        }

        let searchTimeout;
        function handleSearch() {
            clearTimeout(searchTimeout);

            const searchBox = document.getElementById('searchBox');
            const searchInput = document.getElementById('searchInput');
            const searchTerm = searchInput.value.toLowerCase().trim();

            searchBox.classList.add('loading');

            searchTimeout = setTimeout(() => {
                applyFilters();
                searchBox.classList.remove('loading');
            }, 300);
        }

        function handleFilter() {
            applyFilters();
        }

        function applyFilters() {
            const searchInput = document.getElementById('searchInput');
            const searchTerm = searchInput.value.toLowerCase().trim();

            const statusFilter = document.getElementById('statusFilter');
            const vehicleFilter = document.getElementById('vehicleFilter');
            const selectedStatus = statusFilter.value;
            const selectedVehicle = vehicleFilter.value;

            let hasVisibleRows = false;
            allRiders.forEach(rider => {
                const searchMatches = searchTerm === '' ||
                    rider.id.toLowerCase().includes(searchTerm) ||
                    rider.name.toLowerCase().includes(searchTerm) ||
                    rider.phone.toLowerCase().includes(searchTerm) ||
                    rider.email.toLowerCase().includes(searchTerm);

                const statusMatch = selectedStatus === 'all' || rider.status === selectedStatus;

                const vehicleMatch = selectedVehicle === 'all' || rider.vehicle === selectedVehicle;

                const shouldShow = searchMatches && statusMatch && vehicleMatch;

                rider.element.style.display = shouldShow ? '' : 'none';
                if (shouldShow) hasVisibleRows = true;
            });

            const noResultsMessage = document.getElementById('noResultsMessage');
            if (!hasVisibleRows) {
                noResultsMessage.style.display = 'block';
            } else {
                noResultsMessage.style.display = 'none';
            }

            updateStats();
        }

        function handleSort() {
            const sortFilter = document.getElementById('sortFilter');
            const sortBy = sortFilter.value;

            const tbody = document.querySelector('#ridersTableBody');
            const rows = Array.from(tbody.querySelectorAll('tr:not([style*="display: none"])'));

            rows.sort((a, b) => {
                const aData = allRiders.find(r => r.element === a);
                const bData = allRiders.find(r => r.element === b);

                if (!aData || !bData) return 0;

                switch (sortBy) {
                    case 'name-asc':
                        return aData.name.localeCompare(bData.name);
                    case 'name-desc':
                        return bData.name.localeCompare(aData.name);
                    case 'date-desc':
                        return new Date(bData.date) - new Date(aData.date);
                    case 'date-asc':
                        return new Date(aData.date) - new Date(bData.date);
                    case 'orders-desc':
                        return bData.completed - aData.completed;
                    case 'orders-asc':
                        return aData.completed - bData.completed;
                    case 'rating':
                        return bData.rating - aData.rating;
                    default:
                        return 0;
                }
            });

            rows.forEach((row, index) => {
                row.style.animation = 'none';
                void row.offsetWidth;
                row.style.animation = `tableRowFadeIn 0.3s ease ${index * 0.05}s`;
                tbody.appendChild(row);
            });
        }

        function viewRider(riderId) {
            currentRiderId = riderId;
            const rider = ridersData.find(r => r.id === riderId);

            if (!rider) {
                alert('Rider not found!');
                return;
            }

            document.getElementById('modalRiderId').textContent = `RDR-${rider.id.padStart(3, '0')}`;
            document.getElementById('modalRiderId2').textContent = `RDR-${rider.id.padStart(3, '0')}`;
            document.getElementById('modalFullName').textContent = rider.name;
            document.getElementById('modalDateJoined').textContent = rider.joinDate;
            document.getElementById('modalEmail').textContent = rider.email;
            document.getElementById('modalPhone').textContent = rider.phone;
            document.getElementById('modalVehicle').textContent = rider.vehicle;
            document.getElementById('modalLastActivity').textContent = rider.lastActivity;
            document.getElementById('modalAssignedOrders').textContent = rider.assigned;
            document.getElementById('modalCompletedDeliveries').textContent = rider.completed.toLocaleString();
            document.getElementById('modalRating').textContent = rider.rating.toFixed(1);

            const statusElement = document.getElementById('modalStatus');
            statusElement.textContent = getStatusText(rider.status);
            statusElement.className = 'info-value status ' +
                (rider.status === 'available' ? 'status-available' :
                    rider.status === 'delivery' ? 'status-delivery' : 'status-offline');

            const actionButton = document.getElementById('modalActionButton');
            if (rider.status === 'available') {
                actionButton.innerHTML = '<i class="fas fa-motorcycle"></i> Set to On Delivery';
            } else if (rider.status === 'delivery') {
                actionButton.innerHTML = '<i class="fas fa-check"></i> Set to Available';
            } else {
                actionButton.innerHTML = '<i class="fas fa-check"></i> Set to Available';
            }

            // Set rider ID into hidden field then trigger UpdatePanel postback
            document.getElementById('<%= hdnRiderIdForOrders.ClientID %>').value = rider.id;
            // Reset dropdown to monthly then trigger the hidden button to load orders
            document.getElementById('<%= ddlOrderPeriod.ClientID %>').value = 'monthly';
            document.getElementById('<%= btnLoadOrders.ClientID %>').click();
            renderDocumentPhotos(rider);

            const modal = document.getElementById('riderModal');
            modal.style.display = 'flex';
            document.body.style.overflow = 'hidden';

            document.addEventListener('keydown', handleModalKeydown);
        }

        function closeModal() {
            const modal = document.getElementById('riderModal');
            const deleteModal = document.getElementById('deleteConfirmModal');
            modal.style.display = 'none';
            deleteModal.style.display = 'none';
            document.body.style.overflow = 'auto';
            document.removeEventListener('keydown', handleModalKeydown);
            riderToDelete = null;
        }

        function handleModalKeydown(e) {
            if (e.key === 'Escape') {
                closeModal();
            }
        }

        function toggleRiderStatus() {
            const rider = ridersData.find(r => r.id === currentRiderId);
            if (!rider) return;

            const row = document.querySelector(`tr[data-rider-id="${currentRiderId}"]`);
            if (!row) return;

            const statusBadge = row.querySelector('.status-badge');
            const assignedCell = row.querySelector('.stat-number');

            if (rider.status === 'available') {
                rider.status = 'delivery';
                rider.lastActivity = 'Currently delivering';
                rider.assigned = Math.max(1, rider.assigned);

                row.setAttribute('data-status', 'delivery');

                statusBadge.textContent = 'On Delivery';
                statusBadge.className = 'status-badge status-badge--delivery';
                assignedCell.textContent = rider.assigned;

                document.getElementById('modalStatus').textContent = 'On Delivery';
                document.getElementById('modalStatus').className = 'info-value status status-delivery';
                document.getElementById('modalLastActivity').textContent = 'Currently delivering';
                document.getElementById('modalAssignedOrders').textContent = rider.assigned;

                document.getElementById('modalActionButton').innerHTML = '<i class="fas fa-check"></i> Set to Available';
            } else {
                rider.status = 'available';
                rider.lastActivity = 'Today, ' + new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
                rider.assigned = 0;

                row.setAttribute('data-status', 'available');

                statusBadge.textContent = 'Available';
                statusBadge.className = 'status-badge status-badge--available';
                assignedCell.textContent = rider.assigned;

                document.getElementById('modalStatus').textContent = 'Available';
                document.getElementById('modalStatus').className = 'info-value status status-available';
                document.getElementById('modalLastActivity').textContent = rider.lastActivity;
                document.getElementById('modalAssignedOrders').textContent = rider.assigned;

                document.getElementById('modalActionButton').innerHTML = '<i class="fas fa-motorcycle"></i> Set to On Delivery';
            }

            initializeRiderData();
            updateStats();
        }


        // ── Edit Modal ────────────────────────────────────────────────────────
        const editDocFiles = { driverLicense: null, orcr: null, insurance: null, nbi: null, profile: null };

        function openEditModal(riderId) {
            const rider = ridersData.find(r => r.id === riderId);
            if (!rider) return;
            Object.keys(editDocFiles).forEach(k => editDocFiles[k] = null);
            document.getElementById('editRiderId').value = rider.id;
            const profImg = document.getElementById('editProfileImg');
            const profIcon = document.getElementById('editProfileIcon');
            if (rider.profilePicture) { profImg.src = rider.profilePicture; profImg.style.display = 'block'; profIcon.style.display = 'none'; }
            else { profImg.style.display = 'none'; profIcon.style.display = 'block'; }
            document.getElementById('editFullName').value = rider.name || '';
            document.getElementById('editUsername').value = rider.username || '';
            document.getElementById('editEmail').value = rider.email || '';
            document.getElementById('editPhone').value = rider.phone || '';
            document.getElementById('editGender').value = (rider.gender || '').toLowerCase();
            document.getElementById('editLicenseNumber').value = rider.licenseNumber || '';
            document.getElementById('editNBINumber').value = rider.nbiNumber || '';
            document.getElementById('editVehicleType').value = rider.vehicle || '';
            document.getElementById('editVehicleModel').value = rider.vehicleModel || '';
            document.getElementById('editVehicleYear').value = rider.vehicleYear || '';
            document.getElementById('editLicensePlate').value = rider.licensePlate || '';
            document.getElementById('editVehicleColor').value = rider.vehicleColor || '';
            document.getElementById('editORCRNumber').value = rider.orcrNumber || '';
            document.getElementById('editInsurancePolicy').value = rider.insurancePolicy || '';
            document.getElementById('editInsuranceDate').value = rider.insuranceDate || '';
            document.getElementById('editAssignedOrders').textContent = rider.assigned;
            document.getElementById('editCompletedDeliveries').textContent = rider.completed.toLocaleString();
            document.getElementById('editModalRating').textContent = rider.rating.toFixed(1);
            const sb = document.getElementById('editModalStatus');
            sb.textContent = getStatusText(rider.status);
            sb.className = 'info-value status ' + (rider.status === 'available' ? 'status-available' : rider.status === 'delivery' ? 'status-delivery' : 'status-offline');
            document.getElementById('editModalRiderId').textContent = `RDR-${rider.id.padStart(3, '0')}`;
            document.getElementById('editModalRiderId2').textContent = `RDR-${rider.id.padStart(3, '0')}`;
            renderEditDocPhotos(rider);
            document.getElementById('editRiderModal').style.display = 'flex';
            document.body.style.overflow = 'hidden';
        }

        function closeEditModal() {
            document.getElementById('editRiderModal').style.display = 'none';
            document.body.style.overflow = 'auto';
        }

        function renderEditDocPhotos(rider) {
            const docs = [
                { key: 'driverLicensePhoto', fileKey: 'driverLicense', label: "Driver's License", inputId: 'editLicenseFile' },
                { key: 'orcrPhoto', fileKey: 'orcr', label: 'OR/CR', inputId: 'editORCRFile' },
                { key: 'insurancePhoto', fileKey: 'insurance', label: 'Insurance', inputId: 'editInsuranceFile' },
                { key: 'nbiClearancePhoto', fileKey: 'nbi', label: 'NBI Clearance', inputId: 'editNBIFile' }
            ];
            const container = document.getElementById('editDocPhotos');
            container.innerHTML = '';
            docs.forEach(doc => {
                const src = rider[doc.key];
                const card = document.createElement('div');
                card.className = 'edit-doc-card';
                card.onclick = () => document.getElementById(doc.inputId).click();
                const imgArea = document.createElement('div');
                imgArea.className = 'edit-doc-card__img';
                imgArea.id = 'editDocImgArea_' + doc.fileKey;
                imgArea.innerHTML = src
                    ? `<img src="${src}" alt="${doc.label}"><div class="change-overlay"><i class="fas fa-camera" style="font-size:20px;"></i><span>Change</span></div>`
                    : `<div class="no-photo"><i class="fas fa-file-image"></i></div><div class="change-overlay"><i class="fas fa-camera" style="font-size:20px;"></i><span>Upload</span></div>`;
                const lbl = document.createElement('div');
                lbl.className = 'edit-doc-card__label';
                lbl.innerHTML = doc.label + '<span>Click to change</span>';
                const inp = document.createElement('input');
                inp.type = 'file'; inp.accept = 'image/*,.pdf'; inp.id = doc.inputId; inp.style.display = 'none';
                inp.addEventListener('change', function () {
                    const file = this.files[0]; if (!file) return;
                    editDocFiles[doc.fileKey] = file;
                    const reader = new FileReader();
                    reader.onload = e2 => {
                        document.getElementById('editDocImgArea_' + doc.fileKey).innerHTML =
                            `<img src="${e2.target.result}" alt="${doc.label}"><div class="change-overlay"><i class="fas fa-camera" style="font-size:20px;"></i><span>Change</span></div>`;
                    };
                    reader.readAsDataURL(file);
                });
                card.appendChild(imgArea); card.appendChild(lbl); card.appendChild(inp);
                container.appendChild(card);
            });
        }

        function saveEditRider() {
            const riderId = document.getElementById('editRiderId').value;
            const fullName = document.getElementById('editFullName').value.trim();
            const email = document.getElementById('editEmail').value.trim();
            const phone = document.getElementById('editPhone').value.trim();
            if (!fullName || !email || !phone) { showNotification('Full name, email, and phone are required.', 'error'); return; }
            const saveBtn = document.getElementById('editSaveBtn');
            saveBtn.disabled = true;
            saveBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Saving...';
            const fd = new FormData();
            fd.append('fullName', fullName);
            fd.append('username', document.getElementById('editUsername').value.trim());
            fd.append('email', email);
            fd.append('contact', phone);
            fd.append('gender', document.getElementById('editGender').value);
            fd.append('licenseNumber', document.getElementById('editLicenseNumber').value.trim());
            fd.append('nbiNumber', document.getElementById('editNBINumber').value.trim());
            fd.append('vehicle', document.getElementById('editVehicleType').value);
            fd.append('vehicleModel', document.getElementById('editVehicleModel').value.trim());
            fd.append('vehicleYear', document.getElementById('editVehicleYear').value.trim());
            fd.append('licensePlate', document.getElementById('editLicensePlate').value.trim());
            fd.append('vehicleColor', document.getElementById('editVehicleColor').value.trim());
            fd.append('orcrNumber', document.getElementById('editORCRNumber').value.trim());
            fd.append('insurancePolicy', document.getElementById('editInsurancePolicy').value.trim());
            fd.append('insuranceDate', document.getElementById('editInsuranceDate').value);
            if (editDocFiles.profile) fd.append('profilePhoto', editDocFiles.profile);
            if (editDocFiles.driverLicense) fd.append('driverLicensePhoto', editDocFiles.driverLicense);
            if (editDocFiles.orcr) fd.append('orcrPhoto', editDocFiles.orcr);
            if (editDocFiles.insurance) fd.append('insurancePhoto', editDocFiles.insurance);
            if (editDocFiles.nbi) fd.append('nbiClearancePhoto', editDocFiles.nbi);
            fetch(pageUrl + '?action=updateRider&id=' + encodeURIComponent(riderId), { method: 'POST', body: fd })
                .then(r => r.json())
                .then(data => {
                    if (data.success) {
                        const rider = ridersData.find(r => r.id === riderId);
                        if (rider) {
                            rider.name = fullName; rider.username = document.getElementById('editUsername').value.trim();
                            rider.email = email; rider.phone = phone; rider.gender = document.getElementById('editGender').value;
                            rider.licenseNumber = document.getElementById('editLicenseNumber').value.trim();
                            rider.nbiNumber = document.getElementById('editNBINumber').value.trim();
                            rider.vehicle = document.getElementById('editVehicleType').value;
                            rider.vehicleModel = document.getElementById('editVehicleModel').value.trim();
                            rider.vehicleYear = document.getElementById('editVehicleYear').value.trim();
                            rider.licensePlate = document.getElementById('editLicensePlate').value.trim();
                            rider.vehicleColor = document.getElementById('editVehicleColor').value.trim();
                            rider.orcrNumber = document.getElementById('editORCRNumber').value.trim();
                            rider.insurancePolicy = document.getElementById('editInsurancePolicy').value.trim();
                            rider.insuranceDate = document.getElementById('editInsuranceDate').value;
                            if (data.profilePicture) rider.profilePicture = data.profilePicture;
                            if (data.driverLicensePhoto) rider.driverLicensePhoto = data.driverLicensePhoto;
                            if (data.orcrPhoto) rider.orcrPhoto = data.orcrPhoto;
                            if (data.insurancePhoto) rider.insurancePhoto = data.insurancePhoto;
                            if (data.nbiClearancePhoto) rider.nbiClearancePhoto = data.nbiClearancePhoto;
                        }
                        const row = document.querySelector(`tr[data-rider-id="${riderId}"]`);
                        if (row) {
                            row.querySelector('.rider-name').textContent = fullName;
                            row.querySelector('.contact-phone').textContent = phone;
                            row.querySelector('.contact-email').textContent = email;
                            row.querySelector('.vehicle-badge').textContent = document.getElementById('editVehicleType').value;
                            row.setAttribute('data-vehicle', document.getElementById('editVehicleType').value.toLowerCase());
                            if (data.profilePicture) { const img = row.querySelector('img'); if (img) img.src = data.profilePicture; }
                        }
                        closeEditModal();
                        showNotification('Rider updated successfully!', 'success');
                    } else {
                        showNotification(data.message || 'Update failed.', 'error');
                    }
                })
                .catch(() => showNotification('Network error. Please try again.', 'error'))
                .finally(() => { saveBtn.disabled = false; saveBtn.innerHTML = '<i class="fas fa-save"></i> Save Changes'; });
        }

        function showDeleteConfirmation(riderId) {
            riderToDelete = riderId;
            const rider = ridersData.find(r => r.id === riderId);

            if (!rider) return;

            document.getElementById('deleteConfirmationText').textContent =
                `Are you sure you want to delete rider ${rider.name} (RDR-${rider.id.padStart(3, '0')})?`;

            const modal = document.getElementById('deleteConfirmModal');
            modal.style.display = 'flex';
            document.body.style.overflow = 'hidden';

            document.getElementById('confirmDelete').onclick = confirmDelete;
            document.getElementById('cancelDelete').onclick = closeModal;

            document.addEventListener('keydown', handleDeleteModalKeydown);
        }

        function handleDeleteModalKeydown(e) {
            if (e.key === 'Escape') {
                closeModal();
            }
        }

        function confirmDelete() {
            if (!riderToDelete) return;

            // Normalise: compare as strings since data-rider-id is always a string
            const riderIndex = ridersData.findIndex(r => String(r.id) === String(riderToDelete));
            if (riderIndex === -1) {
                showNotification('Rider not found in list.', 'error');
                return;
            }

            const deleteBtn = document.getElementById('confirmDelete');
            deleteBtn.disabled = true;
            deleteBtn.textContent = 'Deleting...';

            // Post to this page's inline deleteRider action — no .ashx needed
            const deleteUrl = pageUrl + '?action=deleteRider';

            const formData = new FormData();
            formData.append('riderId', String(riderToDelete));

            fetch(deleteUrl, { method: 'POST', body: formData })
                .then(function (res) {
                    // Log raw response text first so we can see 404 HTML or errors
                    return res.text();
                })
                .then(function (text) {
                    console.log('DeleteRider raw response:', text);
                    let result;
                    try { result = JSON.parse(text); }
                    catch (e) {
                        showNotification('Server error: ' + text.substring(0, 100), 'error');
                        return;
                    }
                    if (result && result.success) {
                        ridersData.splice(riderIndex, 1);
                        initializeRiderTable();
                        updateStatCards();
                        closeModal();
                        showNotification('Rider deleted successfully!', 'success');
                    } else {
                        showNotification(result.message || 'Failed to delete rider from database.', 'error');
                    }
                })
                .catch(function (err) {
                    console.error('DeleteRider error:', err);
                    showNotification('Network error: ' + err.message, 'error');
                })
                .finally(function () {
                    deleteBtn.disabled = false;
                    deleteBtn.textContent = 'Delete';
                });
        }

        function updateStats() {
            const visibleRiders = allRiders.filter(r => r.element.style.display !== 'none');
            const availableRiders = visibleRiders.filter(r => r.status === 'available').length;
            const onDeliveryRiders = visibleRiders.filter(r => r.status === 'delivery').length;
            const offlineRiders = visibleRiders.filter(r => r.status === 'offline').length;
            const totalRiders = visibleRiders.length;

            document.getElementById('totalRiders').textContent = totalRiders;
            document.getElementById('availableRiders').textContent = availableRiders;
            document.getElementById('onDeliveryRiders').textContent = onDeliveryRiders;
            document.getElementById('offlineRiders').textContent = offlineRiders;
        }

        function showAddRiderModal() {
            const modal = document.getElementById('addRiderModal');
            modal.style.display = 'flex';
            document.body.style.overflow = 'hidden';

            document.querySelectorAll('#addRiderForm input, #addRiderForm select, #addRiderForm textarea').forEach(function (el) {
                if (el.type === 'radio' || el.type === 'checkbox') el.checked = false;
                else el.value = '';
            });

            document.querySelectorAll('.file-preview').forEach(preview => {
                preview.classList.remove('show');
                preview.innerHTML = '';
            });

            document.addEventListener('keydown', handleAddModalKeydown);
        }

        function closeAddRiderModal() {
            const modal = document.getElementById('addRiderModal');
            modal.style.display = 'none';
            document.body.style.overflow = 'auto';
            document.removeEventListener('keydown', handleAddModalKeydown);
        }

        function handleAddModalKeydown(e) {
            if (e.key === 'Escape') {
                closeAddRiderModal();
            }
        }

        function addNewRider(event) {
            if (event) event.preventDefault();

            const password = document.getElementById('newRiderPassword').value;
            const confirmPassword = document.getElementById('newRiderConfirmPassword').value;

            if (password !== confirmPassword) {
                showNotification('Passwords do not match!', 'error');
                return false;
            }

            const fullName = document.getElementById('newRiderFullName').value;
            const username = document.getElementById('newRiderUsername').value;
            const email = document.getElementById('newRiderEmail').value;
            const mobile = document.getElementById('newRiderMobile').value;
            const licenseNumber = document.getElementById('newRiderLicense').value;
            const nbiNumber = document.getElementById('newRiderNBI').value;
            const gender = document.querySelector('input[name="gender"]:checked')?.value;
            const vehicleType = document.getElementById('newRiderVehicleType').value;
            const vehicleModel = document.getElementById('newRiderVehicleModel').value;
            const vehicleYear = document.getElementById('newRiderVehicleYear').value;
            const licensePlate = document.getElementById('newRiderLicensePlate').value;
            const vehicleColor = document.getElementById('newRiderVehicleColor').value;
            const orcrNumber = document.getElementById('newRiderORCR').value;
            const insurancePolicy = document.getElementById('newRiderInsurancePolicy').value;
            const insuranceDate = document.getElementById('newRiderInsuranceDate').value;

            const licenseFile = document.getElementById('newRiderLicenseFile').files[0];
            const orcrFile = document.getElementById('newRiderORCRFile').files[0];
            const insuranceFile = document.getElementById('newRiderInsuranceFile').files[0];
            const nbiFile = document.getElementById('newRiderNBIFile').files[0];

            if (!licenseFile || !orcrFile || !insuranceFile || !nbiFile) {
                showNotification('Please upload all required documents!', 'error');
                return false;
            }

            const formattedMobile = mobile.startsWith('0') ? mobile : '0' + mobile;

            let genderDisplay = 'Rather not say';
            if (gender === 'male') genderDisplay = 'Male';
            if (gender === 'female') genderDisplay = 'Female';

            // --- Save to database via SaveRider.ashx (supports file upload) ---
            const saveBtn = document.querySelector('#addRiderForm .btn--primary');
            saveBtn.disabled = true;
            saveBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Saving...';

            const formData = new FormData();
            formData.append('fullName', fullName);
            formData.append('username', username);
            formData.append('email', email);
            formData.append('password', password);
            formData.append('contact', formattedMobile);
            formData.append('gender', genderDisplay);
            formData.append('licenseNumber', licenseNumber);
            formData.append('nbiNumber', nbiNumber);
            formData.append('vehicle', vehicleType);
            formData.append('vehicleModel', vehicleModel);
            formData.append('vehicleYear', vehicleYear);
            formData.append('licensePlate', licensePlate);
            formData.append('vehicleColor', vehicleColor);
            formData.append('orcrNumber', orcrNumber);
            formData.append('insurancePolicy', insurancePolicy);
            formData.append('insuranceDate', insuranceDate);

            // profilePhoto maps to the new ProfilePhoto column
            const profilePicFile = document.getElementById('newRiderProfilePic').files[0];
            if (profilePicFile) formData.append('profilePhoto', profilePicFile);

            // Document photos — map to new dedicated columns
            const licensePhotoFile = document.getElementById('newRiderLicenseFile').files[0];
            if (licensePhotoFile) formData.append('driverLicensePhoto', licensePhotoFile);

            const orcrPhotoFile = document.getElementById('newRiderORCRFile').files[0];
            if (orcrPhotoFile) formData.append('orcrPhoto', orcrPhotoFile);

            const insurancePhotoFile = document.getElementById('newRiderInsuranceFile').files[0];
            if (insurancePhotoFile) formData.append('insurancePhoto', insurancePhotoFile);

            const nbiPhotoFile = document.getElementById('newRiderNBIFile').files[0];
            if (nbiPhotoFile) formData.append('nbiClearancePhoto', nbiPhotoFile);

            fetch(pageUrl + '?action=saveRider', {
                method: 'POST',
                body: formData
            })
                .then(function (response) { return response.json(); })
                .then(function (result) {
                    if (result && result.success) {
                        const newRider = {
                            id: result.riderId.toString(),
                            name: fullName,
                            username: username,
                            joinDate: result.joinDate,
                            phone: formattedMobile,
                            email: email,
                            licenseNumber: licenseNumber,
                            nbiNumber: nbiNumber,
                            gender: genderDisplay,
                            vehicle: vehicleType,
                            vehicleModel: vehicleModel,
                            vehicleYear: vehicleYear,
                            licensePlate: licensePlate,
                            vehicleColor: vehicleColor,
                            orcrNumber: orcrNumber,
                            insurancePolicy: insurancePolicy,
                            insuranceDate: insuranceDate,
                            profilePicture: result.profilePicture || '',
                            driverLicensePhoto: result.driverLicensePhoto || '',
                            orcrPhoto: result.orcrPhoto || '',
                            insurancePhoto: result.insurancePhoto || '',
                            nbiClearancePhoto: result.nbiClearancePhoto || '',
                            status: "available",
                            assigned: 0,
                            completed: 0,
                            rating: 4.0,
                            lastActivity: 'Today, ' + new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' }),
                            recentDeliveries: []
                        };

                        ridersData.push(newRider);
                        initializeRiderTable();
                        updateStatCards();
                        closeAddRiderModal();
                        document.querySelectorAll('#addRiderForm input, #addRiderForm select, #addRiderForm textarea').forEach(function (el) {
                            if (el.type === 'radio' || el.type === 'checkbox') el.checked = false;
                            else el.value = '';
                        });
                        document.getElementById('profilePicPreviewImg').style.display = 'none';
                        document.getElementById('profilePicIcon').style.display = '';
                        document.querySelectorAll('.file-preview').forEach(function (preview) {
                            preview.classList.remove('show');
                            preview.innerHTML = '';
                        });
                        showNotification('Rider added successfully!', 'success');
                    } else {
                        showNotification(result && result.message ? result.message : 'Failed to save rider.', 'error');
                    }
                })
                .catch(function (err) {
                    console.error('SaveRider error:', err);
                    showNotification('Server error. Please try again.', 'error');
                })
                .finally(function () {
                    saveBtn.disabled = false;
                    saveBtn.innerHTML = '<i class="fas fa-save"></i> Save Rider';
                });

            return false;
        }

        function populateYearDropdown() {
            const yearSelect = document.getElementById('newRiderVehicleYear');
            const currentYear = new Date().getFullYear();

            while (yearSelect.options.length > 1) {
                yearSelect.remove(1);
            }

            for (let year = currentYear + 1; year >= 2000; year--) {
                const option = document.createElement('option');
                option.value = year;
                option.textContent = year;
                yearSelect.appendChild(option);
            }
        }

        function setupFileUploads() {
            // Profile picture live preview
            document.getElementById('newRiderProfilePic').addEventListener('change', function (e) {
                const file = e.target.files[0];
                if (file) {
                    const reader = new FileReader();
                    reader.onload = function (ev) {
                        const img = document.getElementById('profilePicPreviewImg');
                        const icon = document.getElementById('profilePicIcon');
                        img.src = ev.target.result;
                        img.style.display = 'block';
                        icon.style.display = 'none';
                    };
                    reader.readAsDataURL(file);
                }
            });

            document.getElementById('newRiderLicenseFile').addEventListener('change', function (e) {
                const file = e.target.files[0];
                const preview = document.getElementById('licensePreview');
                if (file) {
                    preview.innerHTML = `<i class="fas fa-file"></i> ${file.name} (${(file.size / 1024).toFixed(2)} KB)`;
                    preview.classList.add('show');
                }
            });

            document.getElementById('newRiderORCRFile').addEventListener('change', function (e) {
                const file = e.target.files[0];
                const preview = document.getElementById('orcrPreview');
                if (file) {
                    preview.innerHTML = `<i class="fas fa-file"></i> ${file.name} (${(file.size / 1024).toFixed(2)} KB)`;
                    preview.classList.add('show');
                }
            });

            document.getElementById('newRiderInsuranceFile').addEventListener('change', function (e) {
                const file = e.target.files[0];
                const preview = document.getElementById('insurancePreview');
                if (file) {
                    preview.innerHTML = `<i class="fas fa-file"></i> ${file.name} (${(file.size / 1024).toFixed(2)} KB)`;
                    preview.classList.add('show');
                }
            });

            document.getElementById('newRiderNBIFile').addEventListener('change', function (e) {
                const file = e.target.files[0];
                const preview = document.getElementById('nbiPreview');
                if (file) {
                    preview.innerHTML = `<i class="fas fa-file"></i> ${file.name} (${(file.size / 1024).toFixed(2)} KB)`;
                    preview.classList.add('show');
                }
            });
        }

        function showNotification(message, type) {
            const notification = document.createElement('div');
            notification.style.cssText = `
                position: fixed;
                top: 20px;
                right: 20px;
                padding: 15px 20px;
                background: ${type === 'success' ? 'var(--success-green)' : 'var(--danger-red)'};
                color: white;
                border-radius: var(--radius-md);
                box-shadow: 0 4px 12px rgba(0,0,0,0.15);
                z-index: 10001;
                animation: slideInRight 0.3s ease;
                display: flex;
                align-items: center;
                gap: 10px;
                max-width: 300px;
            `;

            var iconClass = (type === 'success') ? 'fa-check-circle' : 'fa-exclamation-circle';
            notification.innerHTML = '<i class="fas ' + iconClass + '"></i><span>' + message + '</span>';

            document.body.appendChild(notification);

            setTimeout(() => {
                notification.style.animation = 'slideOutRight 0.3s ease';
                setTimeout(() => {
                    document.body.removeChild(notification);
                }, 300);
            }, 3000);
        }

        const style = document.createElement('style');
        style.textContent = `
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
        `;
        document.head.appendChild(style);

        function updateStatCards() {
            var total = ridersData.length;
            var available = ridersData.filter(function (r) { return r.status === 'available'; }).length;
            var onDelivery = ridersData.filter(function (r) { return r.status === 'delivery'; }).length;
            var offline = ridersData.filter(function (r) { return r.status === 'offline'; }).length;
            document.getElementById('totalRiders').textContent = total;
            document.getElementById('availableRiders').textContent = available;
            document.getElementById('onDeliveryRiders').textContent = onDelivery;
            document.getElementById('offlineRiders').textContent = offline;
        }

        document.addEventListener('DOMContentLoaded', function () {
            console.log("Page loaded - initializing rider table");

            initializeRiderTable();
            updateStatCards();

            const searchInput = document.getElementById('searchInput');
            searchInput.addEventListener('input', handleSearch);

            const statusFilter = document.getElementById('statusFilter');
            statusFilter.addEventListener('change', handleFilter);

            const vehicleFilter = document.getElementById('vehicleFilter');
            vehicleFilter.addEventListener('change', handleFilter);

            const sortFilter = document.getElementById('sortFilter');
            sortFilter.addEventListener('change', handleSort);

            setupFileUploads();

            const modal = document.getElementById('riderModal');
            const deleteModal = document.getElementById('deleteConfirmModal');
            const addModal = document.getElementById('addRiderModal');

            modal.addEventListener('click', (e) => {
                if (e.target === modal) {
                    closeModal();
                }
            });

            deleteModal.addEventListener('click', (e) => {
                if (e.target === deleteModal) {
                    closeModal();
                }
            });

            addModal.addEventListener('click', (e) => {
                if (e.target === addModal) {
                    closeAddRiderModal();
                }
            });

            document.getElementById('editRiderModal').addEventListener('click', (e) => {
                if (e.target === document.getElementById('editRiderModal')) closeEditModal();
            });


        });
    </script>

    <!-- Edit Rider Modal -->
    <div id="editRiderModal" class="modal-overlay" style="display:none;">
        <div class="edit-rider-modal">
            <div class="modal-header">
                <h3><i class="fas fa-pencil-alt"></i> Edit Rider <span class="rider-id" id="editModalRiderId">RDR-000</span></h3>
                <button class="close-modal" onclick="closeEditModal()"><i class="fas fa-times"></i></button>
            </div>
            <div class="modal-body">
                <input type="hidden" id="editRiderId">
                <div class="edit-profile-wrap">
                    <div class="edit-profile-circle" onclick="document.getElementById('editProfileFileInput').click()">
                        <img id="editProfileImg" src="" alt="" style="width:100%;height:100%;object-fit:cover;display:none;">
                        <i id="editProfileIcon" class="fas fa-user" style="font-size:30px;color:var(--muted-text);"></i>
                        <div class="edit-cam-overlay"><i class="fas fa-camera"></i></div>
                    </div>
                    <input type="file" id="editProfileFileInput" accept="image/*" style="display:none;"
                           onchange="handleEditProfileChange(this)">
                    <small style="color:var(--muted-text);font-size:11px;margin-top:6px;">Click to change photo</small>
                </div>
                <div class="rider-info-grid">
                    <div class="info-section">
                        <h4><i class="fas fa-id-card"></i> Personal Information</h4>
                        <div class="edit-info-row"><span class="info-label">Full Name:</span><input id="editFullName" class="edit-input" type="text" placeholder="Full name"></div>
                        <div class="edit-info-row"><span class="info-label">Username:</span><input id="editUsername" class="edit-input" type="text" placeholder="Username"></div>
                        <div class="edit-info-row"><span class="info-label">Email Address:</span><input id="editEmail" class="edit-input" type="email" placeholder="Email"></div>
                        <div class="edit-info-row"><span class="info-label">Phone Number:</span><input id="editPhone" class="edit-input" type="text" placeholder="Phone"></div>
                        <div class="edit-info-row"><span class="info-label">Gender:</span>
                            <select id="editGender" class="edit-input">
                                <option value="">Select</option>
                                <option value="male">Male</option>
                                <option value="female">Female</option>
                                <option value="prefer-not-to-say">Rather not say</option>
                            </select>
                        </div>
                        <div class="edit-info-row"><span class="info-label">License No.:</span><input id="editLicenseNumber" class="edit-input" type="text" placeholder="License number"></div>
                        <div class="edit-info-row"><span class="info-label">NBI No.:</span><input id="editNBINumber" class="edit-input" type="text" placeholder="NBI number"></div>
                    </div>
                    <div class="info-section">
                        <h4><i class="fas fa-chart-line"></i> Account Status</h4>
                        <div class="info-row"><span class="info-label">Rider ID:</span><span class="info-value" id="editModalRiderId2">—</span></div>
                        <div class="info-row"><span class="info-label">Status:</span><span class="info-value status" id="editModalStatus">—</span></div>
                        <div class="info-row"><span class="info-label">Account Type:</span><span class="info-value">Delivery Rider</span></div>
                        <h4 style="margin-top:18px;"><i class="fas fa-motorcycle"></i> Vehicle</h4>
                        <div class="edit-info-row"><span class="info-label">Type:</span>
                            <select id="editVehicleType" class="edit-input">
                                <option value="">Select</option>
                                <option value="Motorcycle">Motorcycle</option>
                                <option value="Bicycle">Bicycle</option>
                                <option value="Car">Car</option>
                                <option value="Scooter">Scooter</option>
                            </select>
                        </div>
                        <div class="edit-info-row"><span class="info-label">Model:</span><input id="editVehicleModel" class="edit-input" type="text" placeholder="Model"></div>
                        <div class="edit-info-row"><span class="info-label">Year:</span><input id="editVehicleYear" class="edit-input" type="number" min="2000" max="2027" placeholder="Year"></div>
                        <div class="edit-info-row"><span class="info-label">Plate No.:</span><input id="editLicensePlate" class="edit-input" type="text" placeholder="Plate"></div>
                        <div class="edit-info-row"><span class="info-label">Color:</span><input id="editVehicleColor" class="edit-input" type="text" placeholder="Color"></div>
                        <div class="edit-info-row"><span class="info-label">OR/CR No.:</span><input id="editORCRNumber" class="edit-input" type="text" placeholder="OR/CR"></div>
                        <h4 style="margin-top:18px;"><i class="fas fa-shield-alt"></i> Insurance</h4>
                        <div class="edit-info-row"><span class="info-label">Policy No.:</span><input id="editInsurancePolicy" class="edit-input" type="text" placeholder="Policy"></div>
                        <div class="edit-info-row"><span class="info-label">Date:</span><input id="editInsuranceDate" class="edit-input" type="date"></div>
                    </div>
                </div>
                <div class="rider-activity">
                    <h4><i class="fas fa-shipping-fast"></i> Delivery Activity</h4>
                    <div class="activity-grid">
                        <div class="activity-stat"><div class="activity-stat__value" id="editAssignedOrders">0</div><div class="activity-stat__label">Assigned Orders</div></div>
                        <div class="activity-stat"><div class="activity-stat__value" id="editCompletedDeliveries">0</div><div class="activity-stat__label">Completed Deliveries</div></div>
                        <div class="activity-stat"><div class="activity-stat__value" id="editModalRating">0.0</div><div class="activity-stat__label">Rating</div></div>
                    </div>
                </div>
                <div class="rider-activity" style="margin-top:20px;">
                    <h4><i class="fas fa-file-alt"></i> Requirement Documents <small style="font-weight:400;font-size:12px;color:var(--muted-text);margin-left:6px;">— click a card to replace</small></h4>
                    <div class="edit-doc-grid" id="editDocPhotos"></div>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn--outline" onclick="closeEditModal()"><i class="fas fa-times"></i> Cancel</button>
                <button class="btn btn--primary" id="editSaveBtn" onclick="saveEditRider()"><i class="fas fa-save"></i> Save Changes</button>
            </div>
        </div>
    </div>

    <!-- Photo lightbox overlay -->
    <div id="photoLightbox" style="display:none;position:fixed;inset:0;background:rgba(0,0,0,0.88);z-index:20000;align-items:center;justify-content:center;flex-direction:column;gap:16px;">
        <button onclick="closeLightbox()" style="position:absolute;top:18px;right:22px;background:rgba(255,255,255,0.15);border:none;color:white;font-size:26px;width:42px;height:42px;border-radius:50%;cursor:pointer;line-height:42px;text-align:center;">&times;</button>
        <img id="lightboxImg" src="" alt="" style="max-width:90vw;max-height:82vh;border-radius:10px;box-shadow:0 8px 40px rgba(0,0,0,0.5);object-fit:contain;">
        <span id="lightboxCaption" style="color:rgba(255,255,255,0.8);font-size:13px;font-family:Poppins,sans-serif;letter-spacing:0.5px;"></span>
    </div>

    <script type="text/javascript">
        function openLightbox(src, caption) {
            document.getElementById('lightboxImg').src = src;
            document.getElementById('lightboxCaption').textContent = caption;
            var lb = document.getElementById('photoLightbox');
            lb.style.display = 'flex';
        }
        function closeLightbox() {
            document.getElementById('photoLightbox').style.display = 'none';
        }
        document.getElementById('photoLightbox').addEventListener('click', function (e) {
            if (e.target === this) closeLightbox();
        });

        function handleEditProfileChange(input) {
            var f = input.files[0];
            if (!f) return;
            editDocFiles.profile = f;
            var r = new FileReader();
            r.onload = function (e) {
                var img = document.getElementById('editProfileImg');
                img.src = e.target.result;
                img.style.display = 'block';
                document.getElementById('editProfileIcon').style.display = 'none';
            };
            r.readAsDataURL(f);
        }

        function renderDocumentPhotos(rider) {
            var docs = [
                { key: 'driverLicensePhoto', col: 'DriverLicensePhoto', label: "Driver's License" },
                { key: 'orcrPhoto', col: 'ORCRPhoto', label: 'OR/CR' },
                { key: 'insurancePhoto', col: 'InsurancePhoto', label: 'Insurance' },
                { key: 'nbiClearancePhoto', col: 'NBIClearancePhoto', label: 'NBI Clearance' }
            ];
            var container = document.getElementById('modalDocPhotos');
            container.innerHTML = '<p style="color:var(--muted-text);font-size:13px;"><i class="fas fa-spinner fa-spin"></i> Loading...</p>';

            fetch(pageUrl + '?action=getDocStatus&id=' + rider.id)
                .then(function (r) { return r.json(); })
                .then(function (result) {
                    var statuses = (result && result.success) ? result.statuses : {};
                    container.innerHTML = '';

                    docs.forEach(function (doc) {
                        var src = rider[doc.key] || '';
                        var approvalStatus = statuses[doc.col] || (src ? 'pending' : 'none');

                        // ── card wrapper ──────────────────────────────────────
                        var card = document.createElement('div');
                        card.className = 'doc-approval-card';

                        // ── image area ────────────────────────────────────────
                        var imgWrap = document.createElement('div');
                        imgWrap.className = 'doc-approval-card__img';

                        if (src) {
                            imgWrap.style.cursor = 'pointer';
                            imgWrap.dataset.src = src;
                            imgWrap.dataset.label = doc.label;
                            imgWrap.classList.add('doc-img-clickable');

                            var img = document.createElement('img');
                            img.src = src;
                            img.alt = doc.label;
                            img.style.cssText = 'width:100%;height:100%;object-fit:cover;';
                            img.onerror = function () {
                                imgWrap.innerHTML = '<div class="doc-no-photo"><i class="fas fa-file-image"></i></div>';
                            };
                            imgWrap.appendChild(img);
                        } else {
                            imgWrap.innerHTML = '<div class="doc-no-photo"><i class="fas fa-file-image"></i></div>';
                        }

                        // ── status badge ──────────────────────────────────────
                        var badge = document.createElement('span');
                        badge.className = 'doc-approval-badge ' + (
                            approvalStatus === 'approved' ? 'badge-approved' :
                                approvalStatus === 'rejected' ? 'badge-rejected' :
                                    src ? 'badge-pending' : 'badge-unreviewed');
                        badge.innerHTML =
                            approvalStatus === 'approved' ? '&#10003; Approved' :
                                approvalStatus === 'rejected' ? '&#10007; Rejected' :
                                    src ? 'Pending Review' : 'Not Uploaded';
                        imgWrap.appendChild(badge);
                        card.appendChild(imgWrap);

                        // ── footer label ──────────────────────────────────────
                        var footer = document.createElement('div');
                        footer.className = 'doc-approval-card__footer';
                        footer.textContent = doc.label;
                        var sub = document.createElement('span');
                        sub.textContent = src ? 'Click image to view' : 'No file uploaded';
                        footer.appendChild(sub);
                        card.appendChild(footer);

                        // ── approve / reject buttons ──────────────────────────
                        if (src) {
                            var actions = document.createElement('div');
                            actions.className = 'doc-approval-actions';

                            var btnApprove = document.createElement('button');
                            btnApprove.className = 'btn-approve';
                            btnApprove.innerHTML = '<i class="fas fa-check"></i> Approve';
                            btnApprove.disabled = (approvalStatus === 'approved');
                            btnApprove.dataset.rider = rider.id;
                            btnApprove.dataset.col = doc.col;
                            btnApprove.dataset.action = 'approve';

                            var btnReject = document.createElement('button');
                            btnReject.className = 'btn-reject';
                            btnReject.innerHTML = '<i class="fas fa-times"></i> Reject';
                            btnReject.disabled = (approvalStatus === 'rejected');
                            btnReject.dataset.rider = rider.id;
                            btnReject.dataset.col = doc.col;
                            btnReject.dataset.action = 'reject';

                            actions.appendChild(btnApprove);
                            actions.appendChild(btnReject);
                            card.appendChild(actions);
                        }

                        container.appendChild(card);
                    });

                    // update pending count banner
                    var pending = container.querySelectorAll('.badge-pending').length;
                    var countEl = document.getElementById('pendingDocsCount');
                    document.getElementById('pendingDocsNum').textContent = pending;
                    countEl.style.display = pending > 0 ? 'inline-flex' : 'none';
                })
                .catch(function () {
                    container.innerHTML = '<p style="color:var(--muted-text);font-size:13px;">Could not load approval status.</p>';
                });
        }

        // Delegated click — image lightbox and approve/reject buttons
        document.addEventListener('click', function (e) {
            var imgEl = e.target.closest('.doc-img-clickable');
            if (imgEl) {
                openLightbox(imgEl.dataset.src, imgEl.dataset.label);
                return;
            }
            var actionBtn = e.target.closest('[data-action="approve"],[data-action="reject"]');
            if (actionBtn) {
                var act = actionBtn.dataset.action;
                var rId = actionBtn.dataset.rider;
                var dCol = actionBtn.dataset.col;
                _setDocStatus(rId, dCol, act === 'approve' ? 'approved' : 'rejected', actionBtn);
            }
        });


        function approveDoc(riderId, docCol, btn) { _setDocStatus(riderId, docCol, 'approved', btn); }
        function rejectDoc(riderId, docCol, btn) { _setDocStatus(riderId, docCol, 'rejected', btn); }

        function _setDocStatus(riderId, docCol, status, clickedBtn) {
            var card = clickedBtn.closest('.doc-approval-card');
            var btns = card.querySelectorAll('.btn-approve, .btn-reject');
            btns.forEach(function (b) { b.disabled = true; });

            var fd = new FormData();
            fd.append('riderId', riderId);
            fd.append('docCol', docCol);
            fd.append('status', status);

            fetch(pageUrl + '?action=setDocStatus', { method: 'POST', body: fd })
                .then(function (r) { return r.json(); })
                .then(function (result) {
                    if (result && result.success) {
                        var badge = card.querySelector('.doc-approval-badge');
                        badge.className = 'doc-approval-badge ' + (status === 'approved' ? 'badge-approved' : 'badge-rejected');
                        badge.innerHTML = status === 'approved' ? '&#10003; Approved' : '&#10007; Rejected';
                        btns.forEach(function (b) {
                            b.disabled = (status === 'approved' && b.classList.contains('btn-approve')) ||
                                (status === 'rejected' && b.classList.contains('btn-reject'));
                        });
                        var pending = document.querySelectorAll('#modalDocPhotos .badge-pending').length;
                        var countEl = document.getElementById('pendingDocsCount');
                        document.getElementById('pendingDocsNum').textContent = pending;
                        countEl.style.display = pending > 0 ? 'inline-flex' : 'none';
                        showNotification(status === 'approved' ? 'Document approved!' : 'Document rejected.', status === 'approved' ? 'success' : 'error');
                    } else {
                        btns.forEach(function (b) { b.disabled = false; });
                        showNotification('Failed to update approval status.', 'error');
                    }
                })
                .catch(function () {
                    btns.forEach(function (b) { b.disabled = false; });
                    showNotification('Server error.', 'error');
                });
        }
    </script>
</asp:Content>