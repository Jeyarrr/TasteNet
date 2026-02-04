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

        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 3px;
            background: linear-gradient(90deg, var(--primary-maroon), transparent);
            opacity: 0;
            transition: opacity var(--transition-base);
        }

        .stat-card:hover::before {
            opacity: 1;
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
        .icon-sales { 
            background: var(--success-green-light); 
            color: var(--success-green); 
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

        .tab-bar { 
            display: flex; 
            gap: 20px; 
            border-bottom: 2px solid var(--border-light); 
            margin-bottom: 0; 
            padding-bottom: 0; 
            width: 100%; 
            overflow-x: auto;
        }

        .tab-link { 
            padding: 12px 0; 
            cursor: pointer; 
            color: var(--muted-text); 
            font-weight: 500; 
            font-size: 14px; 
            position: relative; 
            border-bottom: 3px solid transparent;
            transition: all var(--transition-base);
            white-space: nowrap;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .tab-link:hover {
            color: var(--primary-maroon);
        }

        .tab-link.active { 
            color: var(--primary-maroon); 
            font-weight: 700; 
            border-bottom-color: var(--primary-maroon); 
        }

        .tab-badge { 
            background: var(--accent-yellow); 
            color: var(--text-dark); 
            font-size: 11px; 
            padding: 2px 8px; 
            border-radius: var(--radius-sm); 
            font-weight: 700; 
            min-width: 24px;
            text-align: center;
        }

        .table-wrapper { 
            background: #fff; 
            border-radius: 0 0 var(--radius-xl) var(--radius-xl); 
            box-shadow: var(--card-shadow); 
            overflow: hidden; 
            width: 100%; 
            margin-top: -2px;
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
        }

        .full-table th { 
            padding: 16px 10px; 
            text-align: left; 
            background: white; 
            color: var(--muted-text); 
            font-weight: 600; 
            font-size: 11px; 
            border-bottom: 2px solid var(--bg-light);
            text-transform: uppercase;
            letter-spacing: 0.3px;
            white-space: nowrap;
        }

        .full-table td { 
            padding: 16px 10px; 
            border-bottom: 1px solid var(--bg-lighter); 
            vertical-align: middle; 
            color: var(--text-dark);
            transition: all var(--transition-fast);
            position: relative;
            height: 60px;
            white-space: nowrap;
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

        .item-box { 
            width: 40px; 
            height: 40px; 
            background: var(--primary-maroon); 
            color: #fff; 
            border-radius: var(--radius-md); 
            display: flex; 
            align-items: center; 
            justify-content: center; 
            font-weight: 700; 
            font-size: 16px; 
            transition: all var(--transition-base);
        }

        .full-table tbody tr:hover .item-box {
            transform: scale(1.1);
            background: var(--primary-maroon-dark);
            box-shadow: 0 4px 12px rgba(107, 13, 30, 0.2);
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
            gap: 10px;
            background: var(--bg-lighter);
            padding: 6px 12px;
            border-radius: var(--radius-md);
            border: 2px solid var(--border-light);
            width: fit-content;
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

        .item-price {
            font-weight: 700;
            color: var(--primary-maroon);
            font-size: 14px;
        }

        .sold-today {
            font-weight: 700;
            color: var(--primary-maroon);
            font-size: 14px;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .sold-today i {
            color: var(--success-green);
            font-size: 12px;
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

        @keyframes ripple {
            to {
                transform: scale(4);
                opacity: 0;
            }
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
            
            .search-wrapper {
                min-width: 100%;
                margin-bottom: 8px;
            }
            
            .filter-dropdown {
                width: 100%;
                min-width: auto;
            }
            
            .table-wrapper {
                border-radius: 0 0 var(--radius-md) var(--radius-md);
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

            .tab-bar {
                gap: 10px;
                overflow-x: auto;
                padding-bottom: 5px;
            }

            .tab-link {
                font-size: 12px;
                padding: 8px 0;
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

            .item-box {
                width: 32px;
                height: 32px;
                font-size: 14px;
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
        }
    </style>

    <div id="full-page-wrapper">
        <div class="page-header">
            <div class="header-title">
                <h2>Menu & Stock Management</h2>
                <p>Manage menu items and inventory levels</p>
            </div>
            <div class="header-actions">
                <button type="button" class="btn btn--secondary"><i class="fas fa-plus"></i>Add New Item</button>
                <button type="button" class="btn btn--primary"><i class="fas fa-sync-alt"></i>Bulk Update Stock</button>
            </div>
        </div>

        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-card__header">
                    <span class="stat-card__label">Total Menu Items</span>
                    <div class="stat-icon icon-items"><i class="fas fa-utensils"></i></div>
                </div>
                <div class="stat-card__value">17</div>
                <div class="stat-card__trend">All categories</div>
            </div>
            <div class="stat-card">
                <div class="stat-card__header">
                    <span class="stat-card__label">Low Stock Alerts</span>
                    <div class="stat-icon icon-low"><i class="fas fa-exclamation-triangle"></i></div>
                </div>
                <div class="stat-card__value">2</div>
                <div class="stat-card__trend">Needs restocking</div>
            </div>
            <div class="stat-card">
                <div class="stat-card__header">
                    <span class="stat-card__label">Out of Stock</span>
                    <div class="stat-icon icon-out"><i class="fas fa-times-circle"></i></div>
                </div>
                <div class="stat-card__value">1</div>
                <div class="stat-card__trend">Currently unavailable</div>
            </div>
            <div class="stat-card">
                <div class="stat-card__header">
                    <span class="stat-card__label">Total Sales Today</span>
                    <div class="stat-icon icon-sales"><i class="fas fa-peso-sign"></i></div>
                </div>
                <div class="stat-card__value">₱11,625</div>
                <div class="stat-card__trend">Revenue generated</div>
            </div>
        </div>

        <div class="filter-container">
            <div class="search-wrapper" id="searchBox">
                <i class="fas fa-search"></i>
                <input type="text" placeholder="Search by menu item name...">
            </div>
            <select class="filter-dropdown">
                <option>Filter by Category</option>
                <option>Sizzling Specials</option>
                <option>Silog Meals</option>
                <option>Special Meals</option>
                <option>Drinks</option>
            </select>
            <select class="filter-dropdown">
                <option>All Stock Status</option>
                <option>In Stock</option>
                <option>Low Stock</option>
                <option>Out of Stock</option>
            </select>
        </div>

        <div class="tab-bar">
            <div class="tab-link active">
                All Items
                <span class="tab-badge">17</span>
            </div>
            <div class="tab-link">
                Sizzling Specials
                <span class="tab-badge">4</span>
            </div>
            <div class="tab-link">
                Silog Meals
                <span class="tab-badge">9</span>
            </div>
            <div class="tab-link">
                Special Meals
                <span class="tab-badge">4</span>
            </div>
        </div>

        <div class="table-wrapper">
            <div class="table-inner-wrapper">
                <table class="full-table">
                    <thead>
                        <tr>
                            <th style="width: 60px;">Image</th>
                            <th>Item Name</th>
                            <th style="width: 100px;">Price</th>
                            <th style="width: 110px;">Stock Status</th>
                            <th style="width: 150px;">Quantity</th>
                            <th style="width: 120px;">Sold Today</th>
                            <th style="width: 100px;">Available</th>
                            <th style="width: 120px;">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><div class="item-box">S</div></td>
                            <td>
                                <span class="item-name">Sizzling Sisig</span>
                                <span class="item-category">Sizzling Specials</span>
                            </td>
                            <td class="item-price">₱150.00</td>
                            <td><span class="stock-badge in-stock">IN STOCK</span></td>
                            <td>
                                <div class="quantity-controls">
                                    <button type="button" class="qty-btn">-</button>
                                    <span class="quantity-value">45</span>
                                    <button type="button" class="qty-btn">+</button>
                                </div>
                            </td>
                            <td class="sold-today"><i class="fas fa-fire"></i> 12</td>
                            <td><label class="switch"><input type="checkbox" checked><span class="slider"></span></label></td>
                            <td>
                                <div class="action-icons">
                                    <div class="action-icon edit" title="Edit Item">
                                        <i class="fas fa-edit"></i>
                                    </div>
                                    <div class="action-icon delete" title="Delete Item">
                                        <i class="fas fa-trash"></i>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td><div class="item-box">G</div></td>
                            <td>
                                <span class="item-name">Sizzling Tofu</span>
                                <span class="item-category">Sizzling Specials</span>
                            </td>
                            <td class="item-price">₱220.00</td>
                            <td><span class="stock-badge low-stock">LOW STOCK</span></td>
                            <td>
                                <div class="quantity-controls">
                                    <button type="button" class="qty-btn">-</button>
                                    <span class="quantity-value">3</span>
                                    <button type="button" class="qty-btn">+</button>
                                </div>
                            </td>
                            <td class="sold-today"><i class="fas fa-fire"></i> 51</td>
                            <td><label class="switch"><input type="checkbox" checked><span class="slider"></span></label></td>
                            <td>
                                <div class="action-icons">
                                    <div class="action-icon edit" title="Edit Item">
                                        <i class="fas fa-edit"></i>
                                    </div>
                                    <div class="action-icon delete" title="Delete Item">
                                        <i class="fas fa-trash"></i>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td><div class="item-box">P</div></td>
                            <td>
                                <span class="item-name">Arrozcaldo</span>
                                <span class="item-category">Special Meals</span>
                            </td>
                            <td class="item-price">₱165.00</td>
                            <td><span class="stock-badge out-of-stock">OUT OF STOCK</span></td>
                            <td>
                                <div class="quantity-controls">
                                    <button type="button" class="qty-btn">-</button>
                                    <span class="quantity-value">0</span>
                                    <button type="button" class="qty-btn">+</button>
                                </div>
                            </td>
                            <td class="sold-today"><i class="fas fa-fire"></i> 80</td>
                            <td><label class="switch"><input type="checkbox"><span class="slider"></span></label></td>
                            <td>
                                <div class="action-icons">
                                    <div class="action-icon edit" title="Edit Item">
                                        <i class="fas fa-edit"></i>
                                    </div>
                                    <div class="action-icon delete" title="Delete Item">
                                        <i class="fas fa-trash"></i>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td><div class="item-box">T</div></td>
                            <td>
                                <span class="item-name">Tapsilog</span>
                                <span class="item-category">Silog Meals</span>
                            </td>
                            <td class="item-price">₱175.00</td>
                            <td><span class="stock-badge in-stock">IN STOCK</span></td>
                            <td>
                                <div class="quantity-controls">
                                    <button type="button" class="qty-btn">-</button>
                                    <span class="quantity-value">28</span>
                                    <button type="button" class="qty-btn">+</button>
                                </div>
                            </td>
                            <td class="sold-today"><i class="fas fa-fire"></i> 32</td>
                            <td><label class="switch"><input type="checkbox" checked><span class="slider"></span></label></td>
                            <td>
                                <div class="action-icons">
                                    <div class="action-icon edit" title="Edit Item">
                                        <i class="fas fa-edit"></i>
                                    </div>
                                    <div class="action-icon delete" title="Delete Item">
                                        <i class="fas fa-trash"></i>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td><div class="item-box">B</div></td>
                            <td>
                                <span class="item-name">Bangsilog</span>
                                <span class="item-category">Silog Meals</span>
                            </td>
                            <td class="item-price">₱190.00</td>
                            <td><span class="stock-badge low-stock">LOW STOCK</span></td>
                            <td>
                                <div class="quantity-controls">
                                    <button type="button" class="qty-btn">-</button>
                                    <span class="quantity-value">5</span>
                                    <button type="button" class="qty-btn">+</button>
                                </div>
                            </td>
                            <td class="sold-today"><i class="fas fa-fire"></i> 76</td>
                            <td><label class="switch"><input type="checkbox" checked><span class="slider"></span></label></td>
                            <td>
                                <div class="action-icons">
                                    <div class="action-icon edit" title="Edit Item">
                                        <i class="fas fa-edit"></i>
                                    </div>
                                    <div class="action-icon delete" title="Delete Item">
                                        <i class="fas fa-trash"></i>
                                    </div>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <script>
        // Quantity controls functionality
        document.querySelectorAll('.qty-btn').forEach(button => {
            button.addEventListener('click', function () {
                const controls = this.closest('.quantity-controls');
                const valueSpan = controls.querySelector('.quantity-value');
                let currentValue = parseInt(valueSpan.textContent);

                if (this.textContent === '+') {
                    currentValue++;
                } else if (this.textContent === '-') {
                    currentValue = Math.max(0, currentValue - 1);
                }

                valueSpan.textContent = currentValue;

                // Update stock badge based on quantity
                const row = this.closest('tr');
                const stockBadge = row.querySelector('.stock-badge');

                if (currentValue === 0) {
                    stockBadge.className = 'stock-badge out-of-stock';
                    stockBadge.textContent = 'OUT OF STOCK';
                } else if (currentValue <= 5) {
                    stockBadge.className = 'stock-badge low-stock';
                    stockBadge.textContent = 'LOW STOCK';
                } else {
                    stockBadge.className = 'stock-badge in-stock';
                    stockBadge.textContent = 'IN STOCK';
                }

                // Button animation
                this.style.transform = 'scale(0.9)';
                setTimeout(() => {
                    this.style.transform = 'scale(1)';
                }, 150);
            });
        });

        // Tab switching functionality
        document.querySelectorAll('.tab-link').forEach(tab => {
            tab.addEventListener('click', function () {
                document.querySelectorAll('.tab-link').forEach(t => t.classList.remove('active'));
                this.classList.add('active');

                // Add click animation
                this.style.transform = 'scale(0.95)';
                setTimeout(() => {
                    this.style.transform = 'scale(1)';
                }, 150);
            });
        });

        // Search functionality
        const searchInput = document.querySelector('.search-wrapper input');
        const searchBox = document.querySelector('.search-wrapper');

        if (searchInput) {
            let searchTimeout;

            searchInput.addEventListener('input', function () {
                clearTimeout(searchTimeout);
                searchBox.classList.add('loading');

                searchTimeout = setTimeout(() => {
                    const searchTerm = this.value.toLowerCase().trim();
                    const rows = document.querySelectorAll('.full-table tbody tr');
                    let hasVisibleRows = false;

                    rows.forEach(row => {
                        const itemName = row.querySelector('.item-name').textContent.toLowerCase();
                        const itemCategory = row.querySelector('.item-category').textContent.toLowerCase();

                        const isVisible = searchTerm === '' ||
                            itemName.includes(searchTerm) ||
                            itemCategory.includes(searchTerm);

                        row.style.display = isVisible ? '' : 'none';
                        if (isVisible) hasVisibleRows = true;
                    });

                    searchBox.classList.remove('loading');
                }, 300);
            });

            searchInput.addEventListener('focus', function () {
                this.parentElement.style.transform = 'scale(1.02)';
            });

            searchInput.addEventListener('blur', function () {
                this.parentElement.style.transform = 'scale(1)';
            });
        }

        // Filter dropdown functionality
        document.querySelectorAll('.filter-dropdown').forEach(dropdown => {
            dropdown.addEventListener('change', function () {
                this.style.transform = 'scale(0.98)';
                setTimeout(() => {
                    this.style.transform = 'scale(1)';
                }, 150);

                // Apply filter logic here
                const filterType = this.parentElement.querySelectorAll('.filter-dropdown').indexOf(this);
                const filterValue = this.value;

                // Filter implementation would go here
            });
        });

        // Toggle switch click effect
        document.querySelectorAll('.switch input').forEach(toggle => {
            toggle.addEventListener('change', function () {
                const slider = this.nextElementSibling;
                slider.style.transform = 'scale(0.95)';
                setTimeout(() => {
                    slider.style.transform = 'scale(1)';
                }, 200);
            });
        });

        // Stat card click effect
        document.querySelectorAll('.stat-card').forEach(card => {
            card.addEventListener('click', function () {
                this.style.transform = 'translateY(-4px) scale(1.02)';
                setTimeout(() => {
                    this.style.transform = 'translateY(-5px) scale(1.02)';
                }, 150);
            });
        });

        // Button ripple effects
        document.querySelectorAll('.btn').forEach(button => {
            button.addEventListener('click', function (e) {
                let ripple = document.createElement('span');
                let rect = this.getBoundingClientRect();
                let size = Math.max(rect.width, rect.height);
                let x = e.clientX - rect.left - size / 2;
                let y = e.clientY - rect.top - size / 2;

                ripple.style.cssText = `
                    position: absolute;
                    border-radius: 50%;
                    background: rgba(255, 255, 255, 0.3);
                    transform: scale(0);
                    animation: ripple 0.6s linear;
                    width: ${size}px;
                    height: ${size}px;
                    top: ${y}px;
                    left: ${x}px;
                `;

                this.style.position = 'relative';
                this.style.overflow = 'hidden';
                this.appendChild(ripple);

                setTimeout(() => {
                    ripple.remove();
                }, 600);
            });
        });

        // Action icons click effects
        document.querySelectorAll('.action-icon').forEach(icon => {
            icon.addEventListener('click', function (e) {
                e.stopPropagation();

                // Add bounce effect
                this.style.transform = 'translateY(-4px) scale(1.1)';
                setTimeout(() => {
                    this.style.transform = 'translateY(-2px) scale(1.1)';
                }, 100);

                // Handle edit/delete actions
                if (this.classList.contains('edit')) {
                    console.log('Edit item clicked');
                } else if (this.classList.contains('delete')) {
                    console.log('Delete item clicked');
                }
            });
        });

        // Initialize table row animations
        document.addEventListener('DOMContentLoaded', function () {
            const rows = document.querySelectorAll('.full-table tbody tr');
            rows.forEach((row, index) => {
                row.style.animationDelay = `${index * 0.05}s`;
            });
        });
    </script>
</asp:Content>