<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/SuperAdmin.Master" AutoEventWireup="true" CodeBehind="StockManagement.aspx.cs" Inherits="TasteNet.Users.SuperAdmin.StockManagement" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
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

        #full-page-wrapper { 
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

        .btn--danger {
            background: var(--danger-red);
            color: white;
            box-shadow: 0 4px 12px rgba(185, 28, 28, 0.2);
        }

        .btn--danger:hover {
            background: #991b1b;
            transform: translateY(-3px);
            box-shadow: 0 6px 18px rgba(185, 28, 28, 0.3);
        }

        .btn--outline {
            background: transparent;
            color: var(--primary-maroon);
            border: 2px solid var(--border-light);
            box-shadow: none;
        }

        .btn--outline:hover {
            background: var(--bg-lighter);
            border-color: var(--primary-maroon);
            transform: translateY(-3px);
            box-shadow: 0 4px 12px rgba(107, 13, 30, 0.1);
        }

        .btn--delete {
            background: var(--primary-maroon);
            color: white;
            padding: 10px 30px;
            border-radius: var(--radius-md);
            font-weight: 600;
            font-size: 14px;
            cursor: pointer;
            transition: all var(--transition-base);
            border: 2px solid transparent;
            min-width: 100px;
            box-shadow: 0 4px 12px rgba(107, 13, 30, 0.2);
        }

        .btn--delete:hover {
            background: var(--primary-maroon-dark);
            transform: translateY(-2px);
            box-shadow: 0 6px 18px rgba(107, 13, 30, 0.3);
        }

        .btn--cancel {
            background: transparent;
            color: var(--muted-text);
            padding: 10px 30px;
            border-radius: var(--radius-md);
            font-weight: 600;
            font-size: 14px;
            cursor: pointer;
            transition: all var(--transition-base);
            border: 2px solid var(--border-light);
            min-width: 100px;
        }

        .btn--cancel:hover {
            background: var(--bg-lighter);
            border-color: var(--border-hover);
            color: var(--text-dark);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        .stats-grid { 
            display: grid; 
            grid-template-columns: repeat(4, 1fr);
            gap: 15px; 
            margin-bottom: 25px; 
            width: 100%; 
        }

        .stat-card { 
            background: white; 
            padding: 18px;
            border-radius: var(--radius-lg); 
            box-shadow: var(--card-shadow);
            transition: all var(--transition-base) cubic-bezier(0.4, 0, 0.2, 1);
            border: 2px solid transparent;
            cursor: pointer;
            position: relative;
            overflow: hidden;
            transform-origin: center;
        }

        .stat-card:hover {
            transform: translateY(-5px) scale(1.02);
            box-shadow: 
                0 20px 40px rgba(107, 13, 30, 0.15),
                0 0 0 1px rgba(107, 13, 30, 0.05);
            z-index: 2;
            border-color: var(--border-light);
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

        .stat-icon { 
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

        .stat-card:hover .stat-icon {
            transform: scale(1.1) rotate(5deg);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
        }

        .icon-items { 
            background: var(--accent-pink); 
            color: var(--primary-maroon); 
        }
        .icon-low { 
            background: var(--warning-orange-light); 
            color: var(--warning-orange); 
        }
        .icon-out { 
            background: var(--danger-red-light); 
            color: var(--danger-red); 
        }
        .icon-value { 
            background: var(--accent-blue); 
            color: #3b82f6; 
        }

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

        .search-wrapper { 
            position: relative; 
            min-width: 300px;
            flex: 0 0 auto;
        }

        .search-wrapper i { 
            position: absolute; 
            left: 12px;
            top: 50%; 
            transform: translateY(-50%); 
            color: var(--muted-text); 
            font-size: 14px;
            z-index: 2;
        }

        .search-wrapper input { 
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

        .search-wrapper input:hover {
            border-color: var(--border-hover);
            box-shadow: 0 4px 12px rgba(107, 13, 30, 0.08);
        }

        .search-wrapper input:focus {
            transform: translateY(-1px);
            border-color: var(--primary-maroon);
            box-shadow: 
                0 6px 16px rgba(107, 13, 30, 0.12),
                0 0 0 3px rgba(107, 13, 30, 0.1);
        }

        .search-wrapper input::placeholder {
            color: var(--muted-text);
            opacity: 0.7;
            font-size: 13px;
        }

        .search-wrapper.loading i {
            animation: spin 1s linear infinite;
        }

        .filter-dropdown { 
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

        .filter-dropdown:hover {
            border-color: var(--primary-maroon);
            box-shadow: 0 4px 12px rgba(107, 13, 30, 0.1);
            transform: translateY(-1px);
        }

        .filter-dropdown:focus {
            transform: translateY(0);
            border-color: var(--primary-maroon);
            box-shadow: 0 0 0 3px rgba(107, 13, 30, 0.15);
        }

        .table-wrapper { 
            background: #fff; 
            border-radius: var(--radius-lg); 
            box-shadow: var(--card-shadow); 
            overflow: hidden; 
            width: 100%; 
            animation: fadeIn 0.5s ease-out;
        }

        .table-inner-wrapper {
            overflow-x: auto;
            padding: 0;
        }

        .full-table { 
            width: 100%; 
            border-collapse: collapse;
            min-width: 100%;
            font-size: 13px;
            table-layout: fixed;
        }

        .full-table th { 
            padding: 16px 12px;
            text-align: center;
            background: white; 
            color: var(--muted-text); 
            font-weight: 600; 
            font-size: 11px; 
            border-bottom: 2px solid var(--bg-light);
            text-transform: uppercase;
            letter-spacing: 0.3px;
            white-space: nowrap;
            word-wrap: break-word;
        }

        .full-table td { 
            padding: 16px 12px;
            border-bottom: 1px solid var(--bg-lighter); 
            vertical-align: middle; 
            color: var(--text-dark);
            transition: all var(--transition-fast);
            position: relative;
            height: 60px;
            white-space: normal;
            text-align: center;
            word-wrap: break-word;
            overflow-wrap: break-word;
        }

        .full-table th:nth-child(1),
        .full-table td:nth-child(1) {
            width: 20%;
            min-width: 180px;
        }

        .full-table th:nth-child(2),
        .full-table td:nth-child(2) {
            width: 12%;
            min-width: 100px;
        }

        .full-table th:nth-child(3),
        .full-table td:nth-child(3) {
            width: 13%;
            min-width: 110px;
        }

        .full-table th:nth-child(4),
        .full-table td:nth-child(4) {
            width: 13%;
            min-width: 110px;
        }

        .full-table th:nth-child(5),
        .full-table td:nth-child(5) {
            width: 22%;
            min-width: 180px;
        }

        .full-table th:nth-child(6),
        .full-table td:nth-child(6) {
            width: 10%;
            min-width: 90px;
        }

        .full-table th:nth-child(7),
        .full-table td:nth-child(7) {
            width: 10%;
            min-width: 90px;
        }

        .full-table tbody tr {
            transition: all var(--transition-base);
            position: relative;
            animation: tableRowFadeIn 0.5s ease-out;
            animation-fill-mode: both;
            border-left: 3px solid transparent;
        }

        .full-table tbody tr:hover {
            background: linear-gradient(90deg, var(--bg-hover) 0%, white 100%);
            border-left: 3px solid var(--primary-maroon);
            transform: translateX(2px);
            box-shadow: 0 4px 12px rgba(107, 13, 30, 0.08);
        }

        .full-table tbody tr:hover td {
            border-color: transparent;
        }

        .full-table tbody tr:last-child td {
            border-bottom: none;
        }

        .item-name { 
            font-weight: 600; 
            font-size: 13px;
            color: var(--text-dark);
            margin-bottom: 2px;
            display: block;
            transition: color var(--transition-fast);
        }

        .full-table tbody tr:hover .item-name {
            color: var(--primary-maroon);
        }

        .item-category { 
            font-size: 11px; 
            color: var(--muted-text);
            display: block;
        }

        .stock-badge { 
            padding: 4px 8px; 
            border-radius: var(--radius-sm); 
            font-size: 10px; 
            font-weight: 700; 
            text-transform: uppercase; 
            letter-spacing: 0.3px;
            display: inline-block;
            border: 1px solid transparent;
            transition: all var(--transition-fast);
            min-width: 60px;
            text-align: center;
        }

        .stock-badge:hover {
            transform: translateY(-1px);
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .in-stock { 
            background: var(--success-green-light); 
            color: var(--success-green); 
            border-color: var(--success-green);
        }

        .in-stock:hover {
            background: var(--success-green);
            color: white;
        }

        .low-stock { 
            background: var(--warning-orange-light); 
            color: var(--warning-orange); 
            border-color: var(--warning-orange);
        }

        .low-stock:hover {
            background: var(--warning-orange);
            color: white;
        }

        .out-of-stock { 
            background: var(--danger-red-light); 
            color: var(--danger-red); 
            border-color: var(--danger-red);
        }

        .out-of-stock:hover {
            background: var(--danger-red);
            color: white;
        }

        .quantity-controls {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            background: var(--bg-lighter);
            padding: 6px 12px;
            border-radius: var(--radius-md);
            border: 2px solid var(--border-light);
            width: fit-content;
            margin: 0 auto;
            transition: all var(--transition-fast);
        }

        .full-table tbody tr:hover .quantity-controls {
            border-color: var(--primary-maroon);
            background: white;
        }

        .qty-btn {
            width: 28px;
            height: 28px;
            border-radius: var(--radius-sm);
            background: white;
            border: 2px solid var(--border-light);
            color: var(--primary-maroon);
            font-size: 14px;
            font-weight: 700;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all var(--transition-fast);
            position: relative;
            overflow: hidden;
        }

        .qty-btn::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 0;
            height: 0;
            border-radius: 50%;
            background: rgba(107, 13, 30, 0.1);
            transform: translate(-50%, -50%);
            transition: width 0.6s, height 0.6s;
        }

        .qty-btn:active::before {
            width: 200px;
            height: 200px;
        }

        .qty-btn:hover {
            background: var(--primary-maroon);
            color: white;
            border-color: var(--primary-maroon);
            transform: scale(1.1);
        }

        .quantity-value {
            font-weight: 700;
            color: var(--primary-maroon);
            font-size: 16px;
            min-width: 30px;
            text-align: center;
        }

        .switch { 
            position: relative; 
            display: inline-block; 
            width: 50px; 
            height: 24px; 
            margin: 0 auto;
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
            border: 2px solid transparent;
        }

        .slider:before { 
            position: absolute; 
            content: ""; 
            height: 16px; 
            width: 16px; 
            left: 4px; 
            bottom: 2px; 
            background-color: white; 
            transition: var(--transition-base); 
            border-radius: 50%;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        input:checked + .slider { 
            background-color: var(--success-green); 
            border-color: var(--success-green);
        }

        input:checked + .slider:before { 
            transform: translateX(26px); 
        }

        .action-icons {
            display: flex;
            gap: 8px;
            justify-content: center;
        }

        .action-icon {
            width: 26px;
            height: 26px;
            background: var(--bg-lighter);
            border-radius: var(--radius-sm);
            display: inline-flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all var(--transition-base);
            color: var(--muted-text);
            font-size: 11px;
            position: relative;
            text-decoration: none;
            overflow: hidden;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
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

        .action-icon.edit:hover {
            background: var(--success-green);
            color: white;
        }

        .action-icon.delete:hover {
            background: var(--danger-red);
            color: white;
        }

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

        .supplier-info {
            display: flex;
            flex-direction: column;
            gap: 2px;
            align-items: center;
        }

        .supplier-name {
            font-size: 12px;
            color: var(--text-dark);
            font-weight: 500;
        }

        .supplier-contact {
            font-size: 11px;
            color: var(--muted-text);
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

        .no-results h3 {
            margin: 0 0 10px 0;
            font-size: 18px;
            font-weight: 600;
        }

        .no-results p {
            margin: 0;
            font-size: 14px;
        }

        .modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: rgba(0, 0, 0, 0.5);
            display: none;
            justify-content: center;
            align-items: center;
            z-index: 10000;
            animation: fadeIn 0.3s ease;
            backdrop-filter: blur(8px);
            -webkit-backdrop-filter: blur(8px);
        }

        #deleteModal {
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            background: rgba(0, 0, 0, 0.75);
        }

        #deleteModal .modal-content {
            background: white;
            border-radius: var(--radius-xl);
            box-shadow: 
                0 25px 50px rgba(0, 0, 0, 0.4),
                0 0 0 1px rgba(255, 255, 255, 0.1);
            max-width: 450px;
            width: 90%;
            animation: slideUp 0.4s ease;
            overflow: hidden;
        }

        .modal-content {
            background: white;
            border-radius: var(--radius-lg);
            box-shadow: 0 20px 60px rgba(107, 13, 30, 0.25);
            width: 90%;
            max-width: 500px;
            max-height: 90vh;
            overflow-y: auto;
            animation: slideUp 0.4s ease;
            position: relative;
        }

        .edit-modal-header {
            background: var(--primary-maroon);
            color: white;
            padding: 20px 25px;
            border-radius: var(--radius-lg) var(--radius-lg) 0 0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .edit-modal-header h3 {
            margin: 0;
            font-size: 18px;
            font-weight: 600;
            color: white;
        }

        .edit-modal-close {
            background: none;
            border: none;
            font-size: 24px;
            color: white;
            cursor: pointer;
            width: 36px;
            height: 36px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all var(--transition-fast);
            padding: 0;
            line-height: 1;
        }

        .edit-modal-close:hover {
            background: rgba(255, 255, 255, 0.2);
            transform: rotate(90deg);
        }

        .edit-modal-body {
            padding: 25px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: var(--text-dark);
            font-size: 13px;
        }

        .form-control {
            width: 100%;
            padding: 10px 15px;
            border: 2px solid var(--border-light);
            border-radius: var(--radius-md);
            font-family: 'Poppins', sans-serif;
            font-size: 13px;
            color: var(--text-dark);
            transition: all var(--transition-base);
            background: white;
            box-sizing: border-box;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--primary-maroon);
            box-shadow: 0 0 0 3px rgba(107, 13, 30, 0.1);
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
        }

        .edit-modal-footer {
            padding: 20px 25px;
            border-top: 2px solid var(--bg-light);
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            background: var(--bg-lighter);
            border-radius: 0 0 var(--radius-lg) var(--radius-lg);
        }

        .delete-modal-header {
            padding: 25px 30px 0;
            text-align: center;
            border-bottom: none;
        }

        .delete-modal-header h3 {
            margin: 0;
            font-size: 20px;
            font-weight: 600;
            color: var(--text-dark);
        }

        .delete-modal-header h3::before {
            display: none;
        }

        .delete-modal-close {
            display: none;
        }

        .delete-modal-body {
            padding: 30px;
            text-align: center;
        }

        .delete-icon {
            font-size: 60px;
            color: var(--primary-maroon);
            margin-bottom: 20px;
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.1); }
            100% { transform: scale(1); }
        }

        .delete-message {
            font-size: 18px;
            color: var(--text-dark);
            margin-bottom: 15px;
            font-weight: 500;
            line-height: 1.4;
        }

        .delete-ingredient-name {
            font-weight: 600;
            color: var(--primary-maroon);
            background: var(--danger-red-light);
            padding: 2px 8px;
            border-radius: var(--radius-sm);
            display: inline-block;
        }

        .delete-warning {
            font-size: 14px;
            color: var(--muted-text);
            margin-bottom: 30px;
            line-height: 1.5;
        }

        .delete-modal-footer {
            padding: 0 30px 30px;
            display: flex;
            justify-content: center;
            gap: 15px;
            border-top: none;
            background: transparent;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        @keyframes slideUp {
            from { 
                opacity: 0;
                transform: translateY(20px);
            }
            to { 
                opacity: 1;
                transform: translateY(0);
            }
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

        @keyframes spin {
            from { transform: translateY(-50%) rotate(0deg); }
            to { transform: translateY(-50%) rotate(360deg); }
        }

        @media (max-width: 1400px) {
            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 1200px) {
            #full-page-wrapper {
                padding: 15px 20px;
            }
            
            .filter-container {
                flex-wrap: wrap;
                gap: 8px;
            }
            
            .search-wrapper {
                min-width: calc(100% - 10px);
                margin-bottom: 0;
            }
            
            .filter-dropdown {
                min-width: calc(50% - 6px);
            }
            
            .full-table {
                font-size: 12px;
            }
            
            .full-table th {
                font-size: 10px;
                padding: 14px 8px;
            }
            
            .full-table td {
                font-size: 12px;
                padding: 14px 8px;
            }

            .full-table th:nth-child(1),
            .full-table td:nth-child(1) {
                min-width: 150px;
            }

            .full-table th:nth-child(5),
            .full-table td:nth-child(5) {
                min-width: 150px;
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

            .form-row {
                grid-template-columns: 1fr;
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
            
            .search-wrapper {
                min-width: 100%;
                margin-bottom: 8px;
            }
            
            .filter-dropdown {
                width: 100%;
                min-width: auto;
            }
            
            .table-wrapper {
                border-radius: var(--radius-md);
            }
            
            .full-table th,
            .full-table td {
                padding: 12px 6px;
                font-size: 11px;
            }
            
            .action-icons {
                flex-wrap: wrap;
                justify-content: center;
            }

            .full-table th:nth-child(1),
            .full-table td:nth-child(1) {
                min-width: 120px;
            }

            .full-table th:nth-child(5),
            .full-table td:nth-child(5) {
                min-width: 120px;
            }

            .delete-modal-body {
                padding: 20px;
            }
            
            .delete-modal-footer {
                padding: 0 20px 20px;
                flex-direction: column;
                gap: 10px;
            }
            
            .btn--delete,
            .btn--cancel {
                width: 100%;
            }
        }

        @media (max-width: 480px) {
            #full-page-wrapper {
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

            .quantity-controls {
                padding: 4px 8px;
            }

            .qty-btn {
                width: 24px;
                height: 24px;
                font-size: 12px;
            }

            .quantity-value {
                font-size: 14px;
                min-width: 24px;
            }

            .switch {
                width: 40px;
                height: 20px;
            }

            .slider:before {
                height: 12px;
                width: 12px;
                left: 4px;
                bottom: 2px;
            }

            input:checked + .slider:before {
                transform: translateX(20px);
            }

            .modal-content {
                width: 95%;
                margin: 10px;
            }

            .edit-modal-header,
            .edit-modal-body,
            .edit-modal-footer {
                padding: 15px;
            }

            .delete-modal-header {
                padding: 20px 20px 0;
            }
            
            .delete-modal-body {
                padding: 15px;
            }
            
            .delete-icon {
                font-size: 48px;
                margin-bottom: 15px;
            }
            
            .delete-message {
                font-size: 16px;
            }
            
            .delete-warning {
                font-size: 13px;
                margin-bottom: 20px;
            }
        }
    </style>

    <div id="full-page-wrapper">
        <div class="page-header">
            <div class="header-title">
                <h2>Inventory Management</h2>
                <p>Manage ingredient stock and suppliers</p>
            </div>
            <div class="header-actions">
                <button type="button" class="btn btn--secondary" id="addIngredientBtn"><i class="fas fa-plus"></i>Add New Ingredient</button>
                <button type="button" class="btn btn--primary" id="bulkRestockBtn"><i class="fas fa-sync-alt"></i>Bulk Restock</button>
            </div>
        </div>

        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-card__header">
                    <span class="stat-card__label">Total Ingredients</span>
                    <div class="stat-icon icon-items"><i class="fas fa-apple-alt"></i></div>
                </div>
                <div class="stat-card__value" id="totalIngredients">8</div>
                <div class="stat-card__trend">All categories</div>
            </div>
            <div class="stat-card">
                <div class="stat-card__header">
                    <span class="stat-card__label">Low Stock Alerts</span>
                    <div class="stat-icon icon-low"><i class="fas fa-exclamation-triangle"></i></div>
                </div>
                <div class="stat-card__value" id="lowStockCount">3</div>
                <div class="stat-card__trend">Needs restocking</div>
            </div>
            <div class="stat-card">
                <div class="stat-card__header">
                    <span class="stat-card__label">Out of Stock</span>
                    <div class="stat-icon icon-out"><i class="fas fa-times-circle"></i></div>
                </div>
                <div class="stat-card__value" id="outOfStockCount">1</div>
                <div class="stat-card__trend">Currently unavailable</div>
            </div>
            <div class="stat-card">
                <div class="stat-card__header">
                    <span class="stat-card__label">Inventory Value</span>
                    <div class="stat-icon icon-value"><i class="fas fa-peso-sign"></i></div>
                </div>
                <div class="stat-card__value">₱25,480</div>
                <div class="stat-card__trend">Total stock value</div>
            </div>
        </div>

        <div class="filter-container">
            <div class="search-wrapper" id="searchBox">
                <i class="fas fa-search"></i>
                <input type="text" id="searchInput" placeholder="Search by ingredient name or description...">
            </div>
            <select class="filter-dropdown" id="categoryFilter">
                <option value="all">All Categories</option>
                <option value="protein">Protein (Meat, Eggs, etc.)</option>
                <option value="produce">Produce (Vegetables and Fruits)</option>
                <option value="grains">Grains & Starches</option>
                <option value="spices">Spices & Seasonings</option>
                <option value="essentials">Cooking Essentials</option>
            </select>
            <select class="filter-dropdown" id="statusFilter">
                <option value="all">All Stock Status</option>
                <option value="in-stock">In Stock</option>
                <option value="low-stock">Low Stock</option>
                <option value="out-of-stock">Out of Stock</option>
            </select>
        </div>

        <div class="table-wrapper">
            <div class="table-inner-wrapper">
                <table class="full-table">
                    <thead>
                        <tr>
                            <th>Ingredient Name</th>
                            <th>Category</th>
                            <th>Stock Status</th>
                            <th>Quantity</th>
                            <th>Supplier</th>
                            <th>Available</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody id="ingredientsTableBody">
                    </tbody>
                </table>
                <div class="no-results" id="noResultsMessage">
                    <i class="fas fa-search"></i>
                    <h3>No ingredients found</h3>
                    <p>Try adjusting your search or filters</p>
                </div>
            </div>
        </div>
    </div>

    <div class="modal-overlay" id="editModal">
        <div class="modal-content">
            <div class="edit-modal-header">
                <h3 id="editModalTitle">Edit Ingredient</h3>
                <button class="edit-modal-close" id="closeEditModal">&times;</button>
            </div>
            <div class="edit-modal-body">
                <div class="form-group">
                    <label for="editName">Ingredient Name</label>
                    <input type="text" id="editName" class="form-control" placeholder="Enter ingredient name">
                </div>
                <div class="form-group">
                    <label for="editDescription">Description</label>
                    <input type="text" id="editDescription" class="form-control" placeholder="Enter description">
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label for="editCategory">Category</label>
                        <select id="editCategory" class="form-control">
                            <option value="protein">Protein</option>
                            <option value="produce">Produce</option>
                            <option value="grains">Grains & Starches</option>
                            <option value="spices">Spices & Seasonings</option>
                            <option value="essentials">Cooking Essentials</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="editQuantity">Quantity</label>
                        <input type="number" id="editQuantity" class="form-control" min="0" placeholder="Enter quantity">
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label for="editLowStockThreshold">Low Stock Threshold</label>
                        <input type="number" id="editLowStockThreshold" class="form-control" min="1" placeholder="Enter threshold">
                    </div>
                    <div class="form-group">
                        <label for="editAvailable">Available</label>
                        <select id="editAvailable" class="form-control">
                            <option value="true">Yes</option>
                            <option value="false">No</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label for="editSupplierName">Supplier Name</label>
                    <input type="text" id="editSupplierName" class="form-control" placeholder="Enter supplier name">
                </div>
                <div class="form-group">
                    <label for="editSupplierContact">Supplier Contact</label>
                    <input type="text" id="editSupplierContact" class="form-control" placeholder="Enter supplier contact">
                </div>
            </div>
            <div class="edit-modal-footer">
                <button type="button" class="btn btn--outline" id="cancelEdit">Cancel</button>
                <button type="button" class="btn btn--primary" id="saveEdit">Save Changes</button>
            </div>
        </div>
    </div>

    <div class="modal-overlay" id="deleteModal">
        <div class="modal-content">
            <div class="delete-modal-header">
                <h3>Delete Ingredient</h3>
            </div>
            <div class="delete-modal-body">
                <div class="delete-icon">
                    <i class="fas fa-trash"></i>
                </div>
                <div class="delete-message" id="deleteMessage">
                    Are you sure you want to delete <span class="delete-ingredient-name" id="deleteIngredientName"></span>?
                </div>
                <div class="delete-warning" id="deleteWarning">
                    This action cannot be undone.
                </div>
            </div>
            <div class="delete-modal-footer">
                <button type="button" class="btn btn--delete" id="confirmDelete">Delete</button>
                <button type="button" class="btn btn--cancel" id="cancelDelete">Cancel</button>
            </div>
        </div>
    </div>

    <script>
        let ingredientsData = [
            {
                id: 1,
                name: "Beef Tapa Strips",
                description: "Tapsilog ingredient",
                category: "protein",
                categoryDisplay: "Protein",
                status: "in-stock",
                quantity: 45,
                supplier: {
                    name: "Meat King Supplier",
                    contact: "0917-123-4567"
                },
                available: true,
                lowStockThreshold: 10
            },
            {
                id: 2,
                name: "Eggs (Large)",
                description: "For silog meals",
                category: "protein",
                categoryDisplay: "Protein",
                status: "low-stock",
                quantity: 12,
                supplier: {
                    name: "Fresh Poultry Farm",
                    contact: "0918-234-5678"
                },
                available: true,
                lowStockThreshold: 15
            },
            {
                id: 3,
                name: "Garlic (Minced)",
                description: "Seasoning",
                category: "spices",
                categoryDisplay: "Spices & Seasonings",
                status: "out-of-stock",
                quantity: 0,
                supplier: {
                    name: "Spice Masters Inc.",
                    contact: "0919-345-6789"
                },
                available: false,
                lowStockThreshold: 5
            },
            {
                id: 4,
                name: "Jasmine Rice",
                description: "For all rice meals",
                category: "grains",
                categoryDisplay: "Grains & Starches",
                status: "in-stock",
                quantity: 28,
                supplier: {
                    name: "Rice Supply Co.",
                    contact: "0920-456-7890"
                },
                available: true,
                lowStockThreshold: 20
            },
            {
                id: 5,
                name: "Bangus (Milkfish)",
                description: "Bangsilog ingredient",
                category: "protein",
                categoryDisplay: "Protein",
                status: "low-stock",
                quantity: 5,
                supplier: {
                    name: "Fresh Seafood Market",
                    contact: "0921-567-8901"
                },
                available: true,
                lowStockThreshold: 10
            },
            {
                id: 6,
                name: "Tomatoes (Fresh)",
                description: "For salads and sides",
                category: "produce",
                categoryDisplay: "Produce",
                status: "in-stock",
                quantity: 35,
                supplier: {
                    name: "Vegetable Garden Supply",
                    contact: "0922-678-9012"
                },
                available: true,
                lowStockThreshold: 15
            },
            {
                id: 7,
                name: "Soy Sauce (Premium)",
                description: "Marinade and seasoning",
                category: "spices",
                categoryDisplay: "Spices & Seasonings",
                status: "in-stock",
                quantity: 18,
                supplier: {
                    name: "Asian Condiments Inc.",
                    contact: "0923-789-0123"
                },
                available: true,
                lowStockThreshold: 8
            },
            {
                id: 8,
                name: "Cooking Oil",
                description: "For frying and cooking",
                category: "essentials",
                categoryDisplay: "Cooking Essentials",
                status: "low-stock",
                quantity: 3,
                supplier: {
                    name: "Oil & Fat Suppliers",
                    contact: "0924-890-1234"
                },
                available: true,
                lowStockThreshold: 5
            }
        ];

        let allIngredients = [];
        let currentFilters = {
            search: '',
            category: 'all',
            status: 'all'
        };

        let currentEditIngredientId = null;

        function initializeIngredientsTable() {
            const tbody = document.getElementById('ingredientsTableBody');
            tbody.innerHTML = '';

            updateAllIngredientStatuses();

            ingredientsData.forEach(ingredient => {
                const row = document.createElement('tr');
                row.setAttribute('data-ingredient-id', ingredient.id);
                row.setAttribute('data-category', ingredient.category);
                row.setAttribute('data-status', ingredient.status);

                row.innerHTML = `
                    <td>
                        <span class="item-name">${ingredient.name}</span>
                        <span class="item-category">${ingredient.description}</span>
                    </td>
                    <td><span class="item-category">${ingredient.categoryDisplay}</span></td>
                    <td><span class="stock-badge ${ingredient.status}">${getStatusText(ingredient.status)}</span></td>
                    <td>
                        <div class="quantity-controls">
                            <button type="button" class="qty-btn minus-btn">-</button>
                            <span class="quantity-value">${ingredient.quantity}</span>
                            <button type="button" class="qty-btn plus-btn">+</button>
                        </div>
                    </td>
                    <td>
                        <div class="supplier-info">
                            <span class="supplier-name">${ingredient.supplier.name}</span>
                            <span class="supplier-contact">${ingredient.supplier.contact}</span>
                        </div>
                    </td>
                    <td><label class="switch"><input type="checkbox" ${ingredient.available ? 'checked' : ''}><span class="slider"></span></label></td>
                    <td>
                        <div class="action-icons">
                            <div class="action-icon edit" title="Edit Ingredient">
                                <i class="fas fa-edit"></i>
                            </div>
                            <div class="action-icon delete" title="Delete Ingredient">
                                <i class="fas fa-trash"></i>
                            </div>
                        </div>
                    </td>
                `;

                tbody.appendChild(row);
            });

            initializeIngredientData();
            updateStats();
            applyFilters();
        }

        function getStatusText(status) {
            switch (status) {
                case 'in-stock': return 'IN STOCK';
                case 'low-stock': return 'LOW STOCK';
                case 'out-of-stock': return 'OUT OF STOCK';
                default: return 'UNKNOWN';
            }
        }

        function updateAllIngredientStatuses() {
            ingredientsData.forEach(ingredient => {
                updateIngredientStatus(ingredient);
            });
        }

        function updateIngredientStatus(ingredient) {
            if (ingredient.quantity === 0) {
                ingredient.status = 'out-of-stock';
            } else if (ingredient.quantity <= ingredient.lowStockThreshold) {
                ingredient.status = 'low-stock';
            } else {
                ingredient.status = 'in-stock';
            }
        }

        function initializeIngredientData() {
            const rows = document.querySelectorAll('#ingredientsTableBody tr');
            allIngredients = [];

            rows.forEach(row => {
                const ingredientId = parseInt(row.dataset.ingredientId);
                const ingredient = ingredientsData.find(i => i.id === ingredientId);

                if (ingredient) {
                    ingredient.element = row;
                    allIngredients.push(ingredient);
                }
            });
        }

        function handleSearch() {
            const searchInput = document.getElementById('searchInput');
            const searchBox = document.getElementById('searchBox');

            currentFilters.search = searchInput.value.toLowerCase().trim();
            searchBox.classList.add('loading');

            setTimeout(() => {
                applyFilters();
                searchBox.classList.remove('loading');
            }, 300);
        }

        function handleCategoryFilter() {
            const categoryFilter = document.getElementById('categoryFilter');
            currentFilters.category = categoryFilter.value;
            applyFilters();
        }

        function handleStatusFilter() {
            const statusFilter = document.getElementById('statusFilter');
            currentFilters.status = statusFilter.value;
            applyFilters();
        }

        function applyFilters() {
            let hasVisibleRows = false;

            allIngredients.forEach(ingredient => {
                const searchMatches = currentFilters.search === '' ||
                    ingredient.name.toLowerCase().includes(currentFilters.search) ||
                    ingredient.description.toLowerCase().includes(currentFilters.search);

                const categoryMatches = currentFilters.category === 'all' ||
                    ingredient.category === currentFilters.category;

                const statusMatches = currentFilters.status === 'all' ||
                    ingredient.status === currentFilters.status;

                const shouldShow = searchMatches && categoryMatches && statusMatches;

                if (ingredient.element) {
                    ingredient.element.style.display = shouldShow ? '' : 'none';
                    if (shouldShow) hasVisibleRows = true;
                }
            });

            const noResultsMessage = document.getElementById('noResultsMessage');
            if (!hasVisibleRows) {
                noResultsMessage.style.display = 'block';
            } else {
                noResultsMessage.style.display = 'none';
            }

            updateStats();
        }

        function setupQuantityControls() {
            document.addEventListener('click', function (e) {
                if (e.target.classList.contains('qty-btn')) {
                    const button = e.target;
                    const controls = button.closest('.quantity-controls');
                    const valueSpan = controls.querySelector('.quantity-value');
                    const row = button.closest('tr');
                    const ingredientId = parseInt(row.dataset.ingredientId);
                    const ingredient = ingredientsData.find(i => i.id === ingredientId);

                    if (!ingredient) return;

                    let currentValue = parseInt(valueSpan.textContent);

                    if (button.classList.contains('minus-btn')) {
                        currentValue = Math.max(0, currentValue - 1);
                    } else if (button.classList.contains('plus-btn')) {
                        currentValue++;
                    }

                    ingredient.quantity = currentValue;
                    updateIngredientStatus(ingredient);

                    valueSpan.textContent = currentValue;

                    const statusBadge = row.querySelector('.stock-badge');
                    statusBadge.className = `stock-badge ${ingredient.status}`;
                    statusBadge.textContent = getStatusText(ingredient.status);

                    row.setAttribute('data-status', ingredient.status);

                    updateStats();

                    if (currentFilters.status !== 'all') {
                        applyFilters();
                    }

                    button.style.transform = 'scale(0.9)';
                    setTimeout(() => {
                        button.style.transform = 'scale(1)';
                    }, 150);
                }
            });
        }

        function setupToggleSwitches() {
            document.addEventListener('change', function (e) {
                if (e.target.type === 'checkbox' && e.target.closest('.switch')) {
                    const toggle = e.target;
                    const row = toggle.closest('tr');
                    const ingredientId = parseInt(row.dataset.ingredientId);
                    const ingredient = ingredientsData.find(i => i.id === ingredientId);

                    if (ingredient) {
                        ingredient.available = toggle.checked;

                        const slider = toggle.nextElementSibling;
                        slider.style.transform = 'scale(0.95)';
                        setTimeout(() => {
                            slider.style.transform = 'scale(1)';
                        }, 200);
                    }
                }
            });
        }

        function updateStats() {
            const totalIngredients = ingredientsData.length;
            const lowStockCount = ingredientsData.filter(i => i.status === 'low-stock').length;
            const outOfStockCount = ingredientsData.filter(i => i.status === 'out-of-stock').length;

            document.getElementById('totalIngredients').textContent = totalIngredients;
            document.getElementById('lowStockCount').textContent = lowStockCount;
            document.getElementById('outOfStockCount').textContent = outOfStockCount;
        }

        function openEditModal(ingredientId, isNew = false) {
            const modal = document.getElementById('editModal');
            const modalTitle = document.getElementById('editModalTitle');

            if (isNew) {
                modalTitle.textContent = 'Add New Ingredient';
                currentEditIngredientId = null;

                document.getElementById('editName').value = '';
                document.getElementById('editDescription').value = '';
                document.getElementById('editCategory').value = 'protein';
                document.getElementById('editQuantity').value = '';
                document.getElementById('editLowStockThreshold').value = '10';
                document.getElementById('editAvailable').value = 'true';
                document.getElementById('editSupplierName').value = '';
                document.getElementById('editSupplierContact').value = '';
            } else {
                modalTitle.textContent = 'Edit Ingredient';
                currentEditIngredientId = ingredientId;

                const ingredient = ingredientsData.find(i => i.id === ingredientId);
                if (!ingredient) return;

                document.getElementById('editName').value = ingredient.name;
                document.getElementById('editDescription').value = ingredient.description;
                document.getElementById('editCategory').value = ingredient.category;
                document.getElementById('editQuantity').value = ingredient.quantity;
                document.getElementById('editLowStockThreshold').value = ingredient.lowStockThreshold;
                document.getElementById('editAvailable').value = ingredient.available ? 'true' : 'false';
                document.getElementById('editSupplierName').value = ingredient.supplier.name;
                document.getElementById('editSupplierContact').value = ingredient.supplier.contact;
            }

            modal.style.display = 'flex';
        }

        function closeEditModal() {
            document.getElementById('editModal').style.display = 'none';
            currentEditIngredientId = null;
        }

        function saveEditChanges() {
            const name = document.getElementById('editName').value;
            const description = document.getElementById('editDescription').value;
            const category = document.getElementById('editCategory').value;
            const quantity = parseInt(document.getElementById('editQuantity').value);
            const lowStockThreshold = parseInt(document.getElementById('editLowStockThreshold').value);
            const available = document.getElementById('editAvailable').value === 'true';
            const supplierName = document.getElementById('editSupplierName').value;
            const supplierContact = document.getElementById('editSupplierContact').value;

            if (!name || !description || !supplierName || !supplierContact || isNaN(quantity) || isNaN(lowStockThreshold)) {
                showNotification('Please fill in all required fields correctly!', 'error');
                return;
            }

            if (currentEditIngredientId) {
                const ingredient = ingredientsData.find(i => i.id === currentEditIngredientId);
                if (!ingredient) return;

                ingredient.name = name;
                ingredient.description = description;
                ingredient.category = category;
                ingredient.quantity = quantity;
                ingredient.lowStockThreshold = lowStockThreshold;
                ingredient.available = available;
                ingredient.supplier.name = supplierName;
                ingredient.supplier.contact = supplierContact;
                ingredient.categoryDisplay = getCategoryDisplayText(category);

                updateIngredientStatus(ingredient);
                showNotification(`${ingredient.name} updated successfully!`, 'success');
            } else {
                const newIngredient = {
                    id: ingredientsData.length > 0 ? Math.max(...ingredientsData.map(i => i.id)) + 1 : 1,
                    name: name,
                    description: description,
                    category: category,
                    categoryDisplay: getCategoryDisplayText(category),
                    status: quantity > 0 ? (quantity <= lowStockThreshold ? 'low-stock' : 'in-stock') : 'out-of-stock',
                    quantity: quantity,
                    supplier: {
                        name: supplierName,
                        contact: supplierContact
                    },
                    available: available,
                    lowStockThreshold: lowStockThreshold
                };

                ingredientsData.push(newIngredient);
                showNotification(`${newIngredient.name} added successfully!`, 'success');
            }

            initializeIngredientsTable();
            closeEditModal();
        }

        function openDeleteModal(ingredientId) {
            const ingredient = ingredientsData.find(i => i.id === ingredientId);
            if (!ingredient) return;

            document.getElementById('deleteIngredientName').textContent = ingredient.name;
            document.getElementById('deleteModal').style.display = 'flex';
        }

        function closeDeleteModal() {
            document.getElementById('deleteModal').style.display = 'none';
        }

        function confirmDelete() {
            const ingredient = ingredientsData.find(i => i.id === currentEditIngredientId);
            if (!ingredient) return;

            const index = ingredientsData.findIndex(i => i.id === currentEditIngredientId);
            ingredientsData.splice(index, 1);

            initializeIngredientsTable();

            showNotification(`${ingredient.name} deleted successfully!`, 'success');

            closeDeleteModal();
        }

        function getCategoryDisplayText(category) {
            const categoryMap = {
                'protein': 'Protein',
                'produce': 'Produce',
                'grains': 'Grains & Starches',
                'spices': 'Spices & Seasonings',
                'essentials': 'Cooking Essentials'
            };
            return categoryMap[category] || category;
        }

        function setupActionButtons() {
            document.addEventListener('click', function (e) {
                const editBtn = e.target.closest('.action-icon.edit');
                const deleteBtn = e.target.closest('.action-icon.delete');

                if (editBtn) {
                    e.preventDefault();
                    e.stopPropagation();

                    const row = editBtn.closest('tr');
                    const ingredientId = parseInt(row.dataset.ingredientId);

                    openEditModal(ingredientId, false);
                    return false;
                }

                if (deleteBtn) {
                    e.preventDefault();
                    e.stopPropagation();

                    const row = deleteBtn.closest('tr');
                    const ingredientId = parseInt(row.dataset.ingredientId);

                    openDeleteModal(ingredientId);
                    return false;
                }
            });
        }

        function setupModalHandlers() {
            document.getElementById('closeEditModal').addEventListener('click', closeEditModal);
            document.getElementById('cancelEdit').addEventListener('click', closeEditModal);
            document.getElementById('saveEdit').addEventListener('click', saveEditChanges);

            document.getElementById('confirmDelete').addEventListener('click', confirmDelete);
            document.getElementById('cancelDelete').addEventListener('click', closeDeleteModal);

            document.getElementById('editModal').addEventListener('click', function (e) {
                if (e.target === this) {
                    closeEditModal();
                }
            });

            document.getElementById('deleteModal').addEventListener('click', function (e) {
                if (e.target === this) {
                    closeDeleteModal();
                }
            });

            document.addEventListener('keydown', function (e) {
                if (e.key === 'Escape') {
                    if (document.getElementById('editModal').style.display === 'flex') {
                        closeEditModal();
                    }
                    if (document.getElementById('deleteModal').style.display === 'flex') {
                        closeDeleteModal();
                    }
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
                background: ${type === 'success' ? 'var(--success-green)' : type === 'error' ? 'var(--danger-red)' : 'var(--warning-orange)'};
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

            notification.innerHTML = `
                <i class="fas ${type === 'success' ? 'fa-check-circle' : type === 'error' ? 'fa-exclamation-circle' : 'fa-info-circle'}"></i>
                <span>${message}</span>
            `;

            document.body.appendChild(notification);

            setTimeout(() => {
                notification.style.animation = 'slideOutRight 0.3s ease';
                setTimeout(() => {
                    document.body.removeChild(notification);
                }, 300);
            }, 3000);
        }

        function setupAddIngredientButton() {
            document.getElementById('addIngredientBtn').addEventListener('click', function () {
                openEditModal(null, true);
            });
        }

        function setupBulkRestockButton() {
            document.getElementById('bulkRestockBtn').addEventListener('click', function () {
                let restockedCount = 0;

                ingredientsData.forEach(ingredient => {
                    if (ingredient.status === 'low-stock' || ingredient.status === 'out-of-stock') {
                        const oldQuantity = ingredient.quantity;
                        ingredient.quantity = Math.max(ingredient.lowStockThreshold * 2, 20);
                        updateIngredientStatus(ingredient);
                        restockedCount++;
                    }
                });

                if (restockedCount > 0) {
                    initializeIngredientsTable();
                    showNotification(`${restockedCount} ingredients restocked!`, 'success');
                } else {
                    showNotification("No items need restocking", 'info');
                }
            });
        }

        document.addEventListener('DOMContentLoaded', function () {
            console.log("Page loaded - initializing ingredients table");

            initializeIngredientsTable();

            const searchInput = document.getElementById('searchInput');
            searchInput.addEventListener('input', handleSearch);

            const categoryFilter = document.getElementById('categoryFilter');
            categoryFilter.addEventListener('change', handleCategoryFilter);

            const statusFilter = document.getElementById('statusFilter');
            statusFilter.addEventListener('change', handleStatusFilter);

            setupQuantityControls();

            setupToggleSwitches();

            setupActionButtons();

            setupModalHandlers();

            setupAddIngredientButton();

            setupBulkRestockButton();

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
        });
    </script>
</asp:Content>