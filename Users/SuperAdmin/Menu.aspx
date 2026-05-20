<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/SuperAdmin.Master" AutoEventWireup="true" CodeBehind="Menu.aspx.cs" Inherits="TasteNet.Users.SuperAdmin.Menu" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true" />

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
            --primary-maroon-light: #a33b4d;
            --primary-maroon-pale: #cc6677;
            --soft-cream: #fffaf3;
            --text-dark: #4a0e0e;
            --muted-text: #8a6d6d;
            --success-green: #2d9d78;
            --success-green-light: #e6f4f1;
            --warning-orange: #d97706;
            --warning-orange-light: #fff3e6;
            --danger-red: #b91c1c;
            --danger-red-light: #fee2e2;
            --accent-yellow: #ffd43b;
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
            --radius-3xl: 24px;
            --transition-fast: 0.2s ease;
            --transition-base: 0.3s ease;
            --transition-slow: 0.4s ease;
        }

        @media (prefers-reduced-motion: reduce) {
            *,
            *::before,
            *::after {
                animation-duration: 0.01ms !important;
                animation-iteration-count: 1 !important;
                transition-duration: 0.01ms !important;
                scroll-behavior: auto !important;
            }
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

        .header-title h1 { 
            color: var(--text-dark); 
            font-weight: 700; 
            margin: 0; 
            font-size: 32px; 
            letter-spacing: -0.5px;
        }

        .header-title p { 
            color: var(--muted-text); 
            margin: 5px 0 0 0; 
            font-size: 14px; 
            line-height: 1.5;
        }

        .btn {
            padding: 12px 24px;
            border-radius: var(--radius-md);
            font-weight: 600;
            font-size: 14px;
            cursor: pointer;
            transition: all var(--transition-base);
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            border: 2px solid transparent;
            font-family: 'Poppins', sans-serif;
            text-decoration: none;
            white-space: nowrap;
            min-height: 44px;
            line-height: 1.2;
            position: relative;
            overflow: hidden;
            z-index: 1;
        }

        .btn:focus-visible {
            outline: 3px solid var(--primary-maroon);
            outline-offset: 2px;
            box-shadow: 0 0 0 3px rgba(107, 13, 30, 0.3);
            transform: translateY(-2px);
        }

        .btn:focus:not(:focus-visible) {
            outline: none;
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

        .btn:active {
            transform: translateY(-1px);
            transition-duration: 0.1s;
        }

        .btn--secondary {
            background: var(--accent-yellow);
            color: var(--text-dark);
            box-shadow: var(--button-shadow);
        }

        .btn--secondary:hover {
            background: var(--accent-yellow-dark);
            transform: translateY(-3px);
            box-shadow: var(--button-shadow-hover);
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

        .btn--sm {
            padding: 8px 16px;
            font-size: 12px;
            min-height: 36px;
            gap: 6px;
        }

        .btn--lg {
            padding: 14px 28px;
            font-size: 15px;
            min-height: 48px;
            gap: 10px;
        }

        .btn--icon {
            padding: 8px;
            min-height: 36px;
            min-width: 36px;
            justify-content: center;
        }

        .btn--icon i {
            margin: 0;
        }

        .btn--loading {
            position: relative;
            color: transparent !important;
            pointer-events: none;
        }

        .btn--loading::after {
            content: '';
            position: absolute;
            width: 16px;
            height: 16px;
            border: 2px solid white;
            border-radius: 50%;
            border-top-color: transparent;
            animation: spin 1s linear infinite;
            left: 50%;
            top: 50%;
            transform: translate(-50%, -50%);
        }

        .btn--outline.btn--loading::after {
            border-color: var(--primary-maroon);
            border-top-color: transparent;
        }

        .btn:disabled,
        .btn--disabled {
            opacity: 0.6;
            cursor: not-allowed;
            transform: none !important;
            box-shadow: none !important;
        }

        .btn:disabled:hover,
        .btn--disabled:hover {
            transform: none !important;
            box-shadow: none !important;
            background: inherit !important;
            border-color: inherit !important;
            color: inherit !important;
        }

        .btn:disabled::before,
        .btn--disabled::before {
            display: none;
        }

        .btn--success {
            background: var(--success-green);
            color: white;
            animation: successPulse 2s ease;
        }

        .btn--error {
            background: var(--danger-red);
            color: white;
            animation: errorShake 0.5s ease;
        }

        .btn-group {
            display: inline-flex;
            border-radius: var(--radius-md);
            overflow: hidden;
            box-shadow: var(--button-shadow);
            background: white;
        }

        .btn-group .btn {
            border-radius: 0;
            margin: 0;
            border-right: 1px solid rgba(255, 255, 255, 0.2);
        }

        .btn-group .btn:first-child {
            border-radius: var(--radius-md) 0 0 var(--radius-md);
        }

        .btn-group .btn:last-child {
            border-radius: 0 var(--radius-md) var(--radius-md) 0;
            border-right: none;
        }

        .stats-grid { 
            display: grid; 
            grid-template-columns: repeat(4, 1fr);
            gap: 15px; 
            margin-bottom: 25px; 
            width: 100%; 
        }

        .stat-card { 
            position: relative;
            background: white; 
            padding: 20px;
            border-radius: var(--radius-xl); 
            box-shadow: 0 2px 12px rgba(107, 13, 30, 0.06);
            transition: all 0.25s ease;
            border: 1.5px solid #ede8e8;
            cursor: pointer;
            overflow: hidden;
            display: flex;
            flex-direction: column;
            gap: 10px;
            will-change: transform, box-shadow;
        }

        .stat-card:focus-visible {
            outline: 3px solid var(--primary-maroon);
            outline-offset: 2px;
        }

        .stat-card:active {
            transform: translateY(-1px) scale(0.99);
            transition-duration: 0.1s;
        }

        .stat-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 10px 28px rgba(107, 13, 30, 0.12);
            border-color: var(--border-hover);
        }

        .stat-card__header {
            display: flex;
            justify-content: space-between;
            align-items: center;
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
            border-radius: 50%; 
            display: flex; 
            align-items: center; 
            justify-content: center; 
            font-size: 15px; 
            flex-shrink: 0;
            transition: transform 0.3s ease;
        }

        .stat-card:hover .stat-icon {
            transform: scale(1.1);
        }

        .icon-total { 
            background: #fce8eb; 
            color: var(--primary-maroon); 
        }
        .icon-active { 
            background: var(--success-green-light); 
            color: var(--success-green); 
        }
        .icon-hidden { 
            background: var(--warning-orange-light); 
            color: var(--warning-orange); 
        }
        .icon-items { 
            background: var(--accent-blue); 
            color: #3b82f6; 
        }

        .stat-card__value {
            font-size: 25px;
            font-weight: 800;
            color: var(--text-dark);
            line-height: 1;
            transition: color 0.2s ease;
        }

        .stat-card:hover .stat-card__value {
            color: var(--primary-maroon);
        }

        .stat-card__subtitle {
            font-size: 13px;
            font-weight: 400;
            color: var(--muted-text);
        }


        @keyframes successPulse {
            0%, 100% { 
                box-shadow: 0 4px 12px rgba(45, 157, 120, 0.2); 
            }
            50% { 
                box-shadow: 0 4px 20px rgba(45, 157, 120, 0.4); 
            }
        }

        @keyframes errorShake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-5px); }
            75% { transform: translateX(5px); }
        }

        @keyframes spin {
            from { transform: translateY(-50%) rotate(0deg); }
            to { transform: translateY(-50%) rotate(360deg); }
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
            height: 42px;
            box-shadow: 0 2px 6px rgba(107, 13, 30, 0.05);
            box-sizing: border-box;
        }

        .search-wrapper input:focus-visible {
            outline: 2px solid var(--primary-maroon);
            outline-offset: 2px;
            border-color: transparent;
            transform: translateY(-1px);
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
            min-width: 120px;
            outline: none;
            font-weight: 500;
            transition: all var(--transition-base);
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='14' height='14' fill='%238a6d6d' viewBox='0 0 16 16'%3E%3Cpath d='M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 12px center;
            background-size: 10px;
            height: 42px;
            box-shadow: 0 2px 6px rgba(107, 13, 30, 0.05);
            box-sizing: border-box;
            flex: 0 0 auto;
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
        
        .category-tabs {
            display: flex;
            gap: 8px;
            margin-bottom: 18px;
            flex-wrap: wrap;
        }

        .category-tab {
            display: inline-flex;
            align-items: center;
            gap: 7px;
            padding: 9px 20px;
            border-radius: 50px;
            font-size: 13px;
            font-weight: 600;
            font-family: 'Poppins', sans-serif;
            cursor: pointer;
            border: 2px solid var(--border-light);
            background: white;
            color: var(--muted-text);
            transition: all var(--transition-base);
            box-shadow: 0 2px 6px rgba(107,13,30,0.05);
            white-space: nowrap;
        }

        .category-tab i {
            font-size: 13px;
        }

        .category-tab:hover {
            border-color: var(--primary-maroon);
            color: var(--primary-maroon);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(107,13,30,0.1);
        }

        .category-tab.active {
            background: var(--primary-maroon);
            border-color: var(--primary-maroon);
            color: white;
            box-shadow: var(--button-shadow);
        }

        .category-tab.active:hover {
            background: var(--primary-maroon-dark);
            border-color: var(--primary-maroon-dark);
            color: white;
        }
        
        .category-section-header {
            display: flex;
            align-items: center;
            gap: 12px;
            margin: 28px 0 16px 0;
            padding-bottom: 10px;
            border-bottom: 2px solid var(--border-light);
        }

        .category-section-header:first-child {
            margin-top: 0;
        }

        .category-section-icon {
            width: 36px;
            height: 36px;
            border-radius: var(--radius-sm);
            background: var(--primary-maroon);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 15px;
            flex-shrink: 0;
        }

        .category-section-title {
            font-size: 18px;
            font-weight: 700;
            color: var(--text-dark);
            margin: 0;
        }

        .category-section-count {
            margin-left: auto;
            background: var(--bg-light);
            color: var(--muted-text);
            font-size: 12px;
            font-weight: 600;
            padding: 3px 12px;
            border-radius: 50px;
        }

        .category-section-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(270px, 1fr));
            gap: 20px;
            margin-bottom: 10px;
        }

        .menus-grid {
            display: block;
            margin-top: 10px;
            width: 100%;
        }

        .menu-card {
            background: white;
            border-radius: var(--radius-2xl);
            box-shadow: var(--card-shadow);
            overflow: hidden;
            transition: all var(--transition-base);
            position: relative;
            animation: fadeIn 0.5s ease-out;
            border: 2px solid transparent;
        }

        .menu-card:focus-visible {
            outline: 3px solid var(--primary-maroon);
            outline-offset: 2px;
            box-shadow: 0 0 0 3px rgba(107, 13, 30, 0.3);
            transform: translateY(-4px);
        }

        .menu-card:hover {
            transform: translateY(-8px) scale(1.02);
            box-shadow: var(--card-shadow-hover);
            border-color: var(--border-light);
            z-index: 2;
        }

        .menu-header {
            height: 180px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            text-align: center;
            padding: 20px;
            position: relative;
            overflow: hidden;
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
        }

        .menu-image {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            object-fit: cover;
            z-index: 0;
            transition: transform var(--transition-base);
            opacity: 1;
        }

        .menu-card:hover .menu-image {
            transform: scale(1.05);
        }

        .menu-icon {
            font-size: 32px;
            margin-bottom: 12px;
            z-index: 2;
            position: relative;
            transition: transform var(--transition-base);
            color: white;
            filter: drop-shadow(0 2px 4px rgba(0,0,0,0.8));
        }

        .menu-card:hover .menu-icon {
            transform: scale(1.2) rotate(5deg);
        }

        .menu-title {
            font-size: 24px;
            font-weight: 700;
            color: white;
            margin: 0;
            z-index: 2;
            position: relative;
            text-shadow: 0 2px 4px rgba(0,0,0,0.5);
        }

        .menu-body {
            padding: 24px;
        }

        .menu-meta {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 16px;
        }

        .menu-code {
            color: var(--primary-maroon);
            font-weight: 700;
            font-size: 13px;
            background: var(--bg-lighter);
            padding: 6px 12px;
            border-radius: var(--radius-sm);
        }

        .status-toggle-btn {
            padding: 5px 14px;
            border-radius: 20px;
            font-size: 10px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.6px;
            color: white;
            cursor: pointer;
            user-select: none;
            border: none;
            outline: none;
            transition: all var(--transition-fast);
        }

        .status-toggle-btn:hover {
            transform: translateY(-1px);
            filter: brightness(0.95);
        }

        .status-toggle-btn:focus-visible {
            outline: 2px solid var(--primary-maroon);
            outline-offset: 2px;
        }

        .menu-description {
            color: var(--muted-text);
            font-size: 14px;
            line-height: 1.6;
            margin-bottom: 20px;
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .menu-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-top: 20px;
            border-top: 2px solid var(--bg-light);
        }

        .item-count {
            font-size: 14px;
            color: var(--muted-text);
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .item-count i {
            color: var(--primary-maroon);
        }

        .menu-actions {
            display: flex;
            gap: 8px;
        }

        .action-icon {
            width: 36px;
            height: 36px;
            background: var(--bg-lighter);
            border-radius: var(--radius-sm);
            display: inline-flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all var(--transition-base);
            color: var(--muted-text);
            font-size: 14px;
            position: relative;
            text-decoration: none;
            overflow: hidden;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            border: none;
            outline: none;
        }

        .action-icon:focus-visible {
            outline: 2px solid var(--primary-maroon);
            outline-offset: 2px;
            transform: scale(1.1);
        }

        .action-icon:active {
            transform: translateY(0) scale(0.95);
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

        .action-icon.view:hover {
            background: var(--primary-maroon);
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

        .no-results {
            text-align: center;
            padding: 60px 40px;
            color: var(--muted-text);
            display: none;
            grid-column: 1 / -1;
        }

        .no-results i {
            font-size: 64px;
            margin-bottom: 20px;
            color: var(--border-light);
        }

        .no-results h3 {
            margin: 0 0 10px 0;
            font-size: 20px;
            font-weight: 600;
        }

        .no-results p {
            margin: 0;
            font-size: 15px;
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

        .modal-content {
            background: white;
            border-radius: var(--radius-xl);
            box-shadow: 0 20px 60px rgba(107, 13, 30, 0.25);
            width: 90%;
            max-width: 500px;
            max-height: 90vh;
            overflow-y: auto;
            animation: slideUp 0.4s ease;
            position: relative;
        }

        .view-modal-content {
            max-width: 600px;
        }

        .view-modal-header {
            position: relative;
            height: 200px;
            overflow: hidden;
            border-radius: var(--radius-xl) var(--radius-xl) 0 0;
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
        }

        .view-modal-overlay {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(135deg, rgba(107, 13, 30, 0.8) 0%, rgba(90, 11, 25, 0.6) 100%);
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            color: white;
            padding: 20px;
        }

        .view-modal-icon {
            font-size: 48px;
            margin-bottom: 15px;
        }

        .view-modal-title {
            font-size: 28px;
            font-weight: 700;
            margin: 0 0 10px 0;
            text-shadow: 0 2px 4px rgba(0,0,0,0.3);
        }

        .view-modal-code {
            background: rgba(255, 255, 255, 0.2);
            padding: 6px 16px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 600;
        }

        .view-modal-body {
            padding: 25px;
        }

        .view-modal-section {
            margin-bottom: 25px;
        }

        .view-modal-section h4 {
            color: var(--primary-maroon);
            font-size: 16px;
            font-weight: 600;
            margin: 0 0 15px 0;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .view-modal-description {
            color: var(--muted-text);
            font-size: 15px;
            line-height: 1.7;
            margin: 0;
        }

        .view-modal-details {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 15px;
            margin-top: 15px;
        }

        .detail-item {
            display: flex;
            flex-direction: column;
            gap: 5px;
        }

        .detail-label {
            font-size: 12px;
            color: var(--muted-text);
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .detail-value {
            font-size: 15px;
            font-weight: 600;
            color: var(--text-dark);
        }

        .detail-value.status {
            display: inline-flex;
            padding: 6px 16px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 700;
            text-transform: uppercase;
            width: fit-content;
        }

        .detail-value.status-active {
            background: var(--success-green-light);
            color: var(--success-green);
        }

        .detail-value.status-hidden {
            background: var(--warning-orange-light);
            color: var(--warning-orange);
        }

        .modal-header {
            background: var(--primary-maroon);
            color: white;
            padding: 20px 25px;
            border-radius: var(--radius-xl) var(--radius-xl) 0 0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .modal-header h3 {
            margin: 0;
            font-size: 18px;
            font-weight: 600;
            color: white;
        }

        .modal-close {
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

        .modal-close:focus-visible {
            outline: 2px solid white;
            outline-offset: 2px;
        }

        .modal-close:hover {
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
            padding: 12px 15px;
            border: 2px solid var(--border-light);
            border-radius: var(--radius-md);
            font-family: 'Poppins', sans-serif;
            font-size: 14px;
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

        .modal-footer {
            padding: 20px 25px;
            border-top: 2px solid var(--bg-light);
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            background: var(--bg-lighter);
            border-radius: 0 0 var(--radius-xl) var(--radius-xl);
        }

        .view-modal-footer {
            justify-content: center;
        }

        .image-drop-zone {
            border: 2px dashed var(--border-light);
            border-radius: var(--radius-lg);
            background: var(--bg-lighter);
            transition: border-color var(--transition-base), background var(--transition-base);
            overflow: hidden;
            position: relative;
            min-height: 150px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .image-drop-zone.drag-over {
            border-color: var(--primary-maroon);
            background: var(--accent-pink);
        }
        
        .drop-zone-placeholder {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 10px;
            padding: 28px 20px;
            text-align: center;
            width: 100%;
        }
        
        .drop-zone-icon {
            font-size: 36px;
            color: var(--primary-maroon-pale);
        }
        
        .drop-zone-text {
            margin: 0;
            font-size: 14px;
            font-weight: 500;
            color: var(--muted-text);
        }
        
        .drop-zone-hint {
            margin: 0;
            font-size: 11px;
            color: var(--muted-text);
            opacity: 0.7;
        }
        
        .image-preview-wrapper {
            position: relative;
            width: 100%;
        }
        
        .image-preview-img {
            width: 100%;
            height: 200px;
            object-fit: cover;
            display: block;
        }
        
        .image-preview-overlay {
            position: absolute;
            bottom: 10px;
            right: 10px;
            display: flex;
            gap: 8px;
        }
        
        .image-preview-name {
            position: absolute;
            bottom: 10px;
            left: 10px;
            background: rgba(0,0,0,0.55);
            color: #fff;
            font-size: 11px;
            padding: 4px 10px;
            border-radius: var(--radius-sm);
            max-width: 60%;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        
        .image-path-fallback {
            margin-top: 10px;
        }
        
        .image-path-fallback summary {
            cursor: pointer;
            font-size: 12px;
            color: var(--primary-maroon);
            font-weight: 500;
            margin-bottom: 8px;
            list-style: none;
        }
        
        .image-path-fallback summary::before { 
            content: '▸ '; 
        }
        
        .image-path-fallback[open] summary::before { 
            content: '▾ '; 
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

        @media (max-width: 1400px) {
            .category-section-grid {
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
            
            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
            }

            .view-modal-details {
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
            
            .header-title h1 {
                font-size: 28px;
            }
            
            .category-section-grid {
                grid-template-columns: 1fr;
                max-width: 600px;
                margin-left: auto;
                margin-right: auto;
            }

            .form-row {
                grid-template-columns: 1fr;
            }
            
            .btn-group {
                width: 100%;
                flex-direction: column;
            }
            
            .btn-group .btn {
                width: 100%;
                border-radius: var(--radius-md);
                margin: 5px 0;
                border-right: none;
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
            
            .menu-card {
                max-width: 100%;
            }

            .edit-modal-body,
            .view-modal-body {
                padding: 20px;
            }
            
            .modal-footer {
                padding: 15px 20px;
                flex-direction: column;
                gap: 10px;
            }
            
            .btn {
                width: 100%;
                justify-content: center;
            }
            
            .modal-footer .btn {
                width: 100%;
            }

            .view-modal-header {
                height: 160px;
            }

            .view-modal-title {
                font-size: 24px;
            }
        }

        @media (max-width: 480px) {
            #full-page-wrapper {
                padding: 12px 15px;
            }
            
            .header-title h1 {
                font-size: 24px;
            }
            
            .header-title p {
                font-size: 13px;
            }
            
            .stat-card {
                padding: 14px;
                height: auto;
                min-height: 100px;
            }

            .stat-card__value { 
                font-size: 26px;
            }
            
            .btn {
                padding: 10px 20px;
                font-size: 13px;
                min-height: 40px;
            }
            
            .btn--sm {
                padding: 6px 12px;
                font-size: 12px;
                min-height: 32px;
            }

            .menu-header {
                height: 160px;
                padding: 15px;
            }

            .menu-title {
                font-size: 20px;
            }

            .menu-body {
                padding: 20px;
            }

            .menu-actions {
                flex-wrap: wrap;
                justify-content: center;
            }
            
            .action-icon {
                width: 32px;
                height: 32px;
                font-size: 13px;
            }

            .modal-content {
                width: 95%;
                margin: 10px;
            }

            .modal-header,
            .edit-modal-body,
            .view-modal-body,
            .modal-footer {
                padding: 15px;
            }

            .view-modal-header {
                height: 140px;
            }

            .view-modal-title {
                font-size: 20px;
            }

            .view-modal-icon {
                font-size: 36px;
            }
        }
    </style>

    <div id="full-page-wrapper">
        <div class="page-header">
            <div class="header-title">
                <h2>Menu Management</h2>
                <p>Organize and manage your food menu items</p>
            </div>
            <div class="header-actions">
                <button type="button" class="btn btn--secondary" id="addMenuBtn">
                    <i class="fas fa-plus"></i>Add Menu
                </button>
            </div>
        </div>
        
        <div class="stats-grid">
            <div class="stat-card" tabindex="0" role="button" aria-label="View total menus">
                <div class="stat-card__header">
                    <span class="stat-card__label">Total Items</span>
                    <div class="stat-icon icon-total"><i class="fas fa-utensils"></i></div>
                </div>
                <div class="stat-card__value" id="totalMenus">0</div>
                <div class="stat-card__subtitle">All menu items</div>
            </div>
            <div class="stat-card" tabindex="0" role="button" aria-label="View active items">
                <div class="stat-card__header">
                    <span class="stat-card__label">Active Items</span>
                    <div class="stat-icon icon-active"><i class="fas fa-eye"></i></div>
                </div>
                <div class="stat-card__value" id="activeMenus">0</div>
                <div class="stat-card__subtitle">Visible to customers</div>
            </div>
            <div class="stat-card" tabindex="0" role="button" aria-label="View hidden items">
                <div class="stat-card__header">
                    <span class="stat-card__label">Hidden Items</span>
                    <div class="stat-icon icon-hidden"><i class="fas fa-eye-slash"></i></div>
                </div>
                <div class="stat-card__value" id="hiddenMenus">0</div>
                <div class="stat-card__subtitle">Not visible to customers</div>
            </div>
            <div class="stat-card" tabindex="0" role="button" aria-label="View categories">
                <div class="stat-card__header">
                    <span class="stat-card__label">Categories</span>
                    <div class="stat-icon icon-items"><i class="fas fa-tags"></i></div>
                </div>
                <div class="stat-card__value" id="totalCategories">5</div>
                <div class="stat-card__subtitle">Food categories</div>
            </div>
        </div>

        <div class="category-tabs" id="categoryTabs">
            <button type="button" class="category-tab active" data-category="all">
                <i class="fas fa-th-large"></i> All Categories
            </button>
            <button type="button" class="category-tab" data-category="Silog">
                <i class="fas fa-egg"></i> Silog
            </button>
            <button type="button" class="category-tab" data-category="Sizzling Specials">
                <i class="fas fa-fire"></i> Sizzling Specials
            </button>
            <button type="button" class="category-tab" data-category="Special Meals">
                <i class="fas fa-star"></i> Special Meals
            </button>
            <button type="button" class="category-tab" data-category="Beverage">
                <i class="fas fa-glass-water"></i> Beverage
            </button>
            <button type="button" class="category-tab" data-category="Addons">
                <i class="fas fa-plus-circle"></i> Addons
            </button>
        </div>

        <div class="filter-container">
            <div class="search-wrapper" id="searchBox">
                <i class="fas fa-search"></i>
                <input type="text" id="searchInput" placeholder="Search by food name or description...">
            </div>
            <select class="filter-dropdown" id="statusFilter">
                <option value="all">All Status</option>
                <option value="active">Active</option>
                <option value="hidden">Hidden</option>
            </select>
            <select class="filter-dropdown" id="sortFilter">
                <option value="newest">Sort by: Newest</option>
                <option value="oldest">Sort by: Oldest</option>
                <option value="name-asc">Sort by: Name (A-Z)</option>
                <option value="name-desc">Sort by: Name (Z-A)</option>
                <option value="price-high">Sort by: Price (High-Low)</option>
                <option value="price-low">Sort by: Price (Low-High)</option>
            </select>
        </div>

        <div style="display:none;">
            <asp:FileUpload ID="fuMenuImage" runat="server" />
            <input type="hidden" name="hMenuId" id="hMenuId" value="" />
            <input type="hidden" name="hFoodName" id="hFoodName" value="" />
            <input type="hidden" name="hFoodType" id="hFoodType" value="" />
            <input type="hidden" name="hPrice" id="hPrice" value="" />
            <input type="hidden" name="hImagePath" id="hImagePath" value="" />
            <asp:Button ID="btnSaveMenu" runat="server" Text="Save" OnClick="btnSaveMenu_Click" />
        </div>

        <div style="display:none;">
            <asp:Repeater ID="rptMenu" runat="server">
                <ItemTemplate></ItemTemplate>
            </asp:Repeater>
        </div>

        <div class="menus-grid" id="menusGrid"></div>
        
        <div class="no-results" id="noResultsMessage">
            <i class="fas fa-search"></i>
            <h3>No menu items found</h3>
            <p>Try adjusting your search or filters</p>
        </div>
    </div>

    <div class="modal-overlay" id="viewModal">
        <div class="modal-content view-modal-content">
            <div class="view-modal-header" id="viewModalHeader">
                <div class="view-modal-overlay">
                    <i class="fas" id="viewModalIcon"></i>
                    <h3 class="view-modal-title" id="viewModalTitle">Item Name</h3>
                    <div class="view-modal-code" id="viewModalCode">ITEM-000</div>
                </div>
                <button class="modal-close" id="closeViewModal" aria-label="Close view modal">&times;</button>
            </div>
            <div class="view-modal-body">
                <div class="view-modal-section">
                    <h4><i class="fas fa-align-left"></i> Description</h4>
                    <p class="view-modal-description" id="viewModalDescription"></p>
                </div>
                <div class="view-modal-section">
                    <h4><i class="fas fa-info-circle"></i> Details</h4>
                    <div class="view-modal-details">
                        <div class="detail-item">
                            <span class="detail-label">Status</span>
                            <span class="detail-value status" id="viewModalStatus">ACTIVE</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">Category</span>
                            <span class="detail-value" id="viewModalCategory">-</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">Price</span>
                            <span class="detail-value" id="viewModalPrice">₱0.00</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">Items Count</span>
                            <span class="detail-value" id="viewModalItems">0 items</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer view-modal-footer">
                <button type="button" class="btn btn--outline" id="closeViewBtn">Close</button>
            </div>
        </div>
    </div>

    <div class="modal-overlay" id="editModal">
        <div class="modal-content">
            <div class="modal-header">
                <h3 id="editModalTitle">Add Food Item</h3>
                <button class="modal-close" id="closeEditModal" aria-label="Close edit modal">&times;</button>
            </div>
            <div class="edit-modal-body">
                <input type="hidden" id="editMenuId" value="">
                
                <div class="form-group">
                    <label for="editFoodName">
                        <i class="fas fa-utensils" style="margin-right:6px;color:var(--primary-maroon);"></i>
                        Food Name <span style="color:var(--danger-red);">*</span>
                    </label>
                    <input type="text" id="editFoodName" class="form-control" placeholder="e.g., Chicken Adobo">
                </div>

                <div class="form-group">
                    <label for="editFoodType">
                        <i class="fas fa-tag" style="margin-right:6px;color:var(--primary-maroon);"></i>
                        Category <span style="color:var(--danger-red);">*</span>
                    </label>
                    <select id="editFoodType" class="form-control">
                        <option value="">-- Select category --</option>
                        <option value="Silog">🍳 Silog</option>
                        <option value="Sizzling Specials">🔥 Sizzling Specials</option>
                        <option value="Special Meals">⭐ Special Meals</option>
                        <option value="Beverage">🥤 Beverage</option>
                        <option value="Addons">➕ Addons</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="editPrice">
                        <i class="fas fa-peso-sign" style="margin-right:6px;color:var(--primary-maroon);"></i>
                        Price (₱) <span style="color:var(--danger-red);">*</span>
                    </label>
                    <input type="number" id="editPrice" class="form-control" step="0.01" min="0" placeholder="e.g., 150.00">
                </div>

                <div class="form-group">
                    <label>
                        <i class="fas fa-image" style="margin-right:6px;color:var(--primary-maroon);"></i>
                        Food Image
                    </label>
                    
                    <div id="imageDropZone" class="image-drop-zone">
                        <input type="file" id="editImageFile" accept="image/*" style="display:none;">
                        <div id="dropZonePlaceholder" class="drop-zone-placeholder">
                            <i class="fas fa-cloud-upload-alt drop-zone-icon"></i>
                            <p class="drop-zone-text">Drag & drop a photo here, or</p>
                            <button type="button" class="btn btn--outline btn--sm" id="browseFileBtn">
                                <i class="fas fa-folder-open"></i> Browse File
                            </button>
                            <p class="drop-zone-hint">JPG, PNG, WEBP — max 5 MB</p>
                        </div>
                        <div id="imagePreviewWrapper" class="image-preview-wrapper" style="display:none;">
                            <img id="imagePreview" src="" alt="Preview" class="image-preview-img">
                            <div class="image-preview-overlay">
                                <button type="button" class="btn btn--sm btn--outline" id="changeImageBtn">
                                    <i class="fas fa-pencil-alt"></i> Change
                                </button>
                                <button type="button" class="btn btn--sm btn--danger" id="removeImageBtn">
                                    <i class="fas fa-times"></i> Remove
                                </button>
                            </div>
                            <div class="image-preview-name" id="imagePreviewName"></div>
                        </div>
                    </div>

                    <details class="image-path-fallback">
                        <summary>Or enter an image URL manually</summary>
                        <input type="text" id="editImagePath" class="form-control" placeholder="e.g., /Images/food.jpg or https://...">
                        <small style="color:var(--muted-text);font-size:11px;margin-top:4px;display:block;">
                            Used when no file is selected above
                        </small>
                    </details>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn--outline" id="cancelEdit">Cancel</button>
                <button type="button" class="btn btn--primary" id="saveEdit">
                    <i class="fas fa-save"></i> Save to Database
                </button>
            </div>
        </div>
    </div>

    <div class="modal-overlay" id="deleteModal">
        <div class="modal-content">
            <div class="modal-header">
                <h3>Delete Menu Item</h3>
                <button class="modal-close" id="closeDeleteModal" aria-label="Close delete modal">&times;</button>
            </div>
            <div class="edit-modal-body">
                <div style="text-align: center; margin-bottom: 20px;">
                    <div style="margin-bottom: 16px;">
                        <i class="fas fa-trash" style="color: var(--danger-red); font-size: 48px;"></i>
                    </div>
                    <p style="font-weight: 600; margin-bottom: 8px;" id="deleteMessage">
                        Are you sure you want to delete this item?
                    </p>
                    <p style="color: var(--muted-text); font-size: 13px;" id="deleteWarning">
                        This action cannot be undone.
                    </p>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn--outline" id="cancelDelete">Cancel</button>
                <button type="button" class="btn btn--danger" id="confirmDelete">Delete Item</button>
            </div>
        </div>
    </div>

    <asp:Literal ID="MenusJsonLiteral" runat="server" />
    <asp:Literal ID="ErrorLiteral" runat="server" />
    
    <script>
        let menusData = window.__menusData || [];

        let currentFilters = {
            search: '',
            status: 'all',
            sort: 'newest',
            category: 'all'
        };

        let currentEditMenuId = null;
        let currentViewMenuId = null;
        let activeStatusDropdown = null;
        let _selectedFile = null;
        let _isDeleting = false;

        var foodTypeIcons = {
            'Silog': 'fa-egg',
            'Sizzling Specials': 'fa-fire',
            'Special Meals': 'fa-star',
            'Beverage': 'fa-glass-water',
            'Addons': 'fa-plus-circle'
        };

        var CATEGORIES = [
            { key: 'Silog', label: 'Silog', icon: 'fa-egg' },
            { key: 'Sizzling Specials', label: 'Sizzling Specials', icon: 'fa-fire' },
            { key: 'Special Meals', label: 'Special Meals', icon: 'fa-star' },
            { key: 'Beverage', label: 'Beverage', icon: 'fa-glass-water' },
            { key: 'Addons', label: 'Addons', icon: 'fa-plus-circle' }
        ];

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
            notification.innerHTML = `<i class="fas ${type === 'success' ? 'fa-check-circle' : type === 'error' ? 'fa-exclamation-circle' : 'fa-info-circle'}"></i><span>${message}</span>`;
            document.body.appendChild(notification);
            setTimeout(() => {
                notification.style.animation = 'slideOutRight 0.3s ease';
                setTimeout(() => document.body.removeChild(notification), 300);
            }, 3000);
        }

        function updateStats() {
            var total = menusData.length;
            var active = menusData.filter(function (m) { return !m.status || m.status === 'active'; }).length;
            var hidden = menusData.filter(function (m) { return m.status === 'hidden'; }).length;
            document.getElementById('totalMenus').textContent = total;
            document.getElementById('activeMenus').textContent = active;
            document.getElementById('hiddenMenus').textContent = hidden;
            document.getElementById('totalCategories').textContent = CATEGORIES.length;
        }

        function formatDate(dateString) {
            if (!dateString) return '—';
            const options = { year: 'numeric', month: 'short', day: 'numeric' };
            return new Date(dateString).toLocaleDateString('en-US', options);
        }

        function clearImageUpload() {
            _selectedFile = null;
            var fi = document.getElementById('editImageFile');
            if (fi) fi.value = '';
            document.getElementById('imagePreviewWrapper').style.display = 'none';
            document.getElementById('dropZonePlaceholder').style.display = 'flex';
        }

        function applyFileToPreview(file) {
            if (!file) return;
            if (file.size > 5 * 1024 * 1024) {
                showNotification('File too large! Maximum 5 MB.', 'error');
                return;
            }
            if (!file.type.startsWith('image/')) {
                showNotification('Please select an image file.', 'error');
                return;
            }
            _selectedFile = file;
            var reader = new FileReader();
            reader.onload = function (ev) {
                document.getElementById('imagePreview').src = ev.target.result;
                document.getElementById('imagePreviewName').textContent = file.name;
                document.getElementById('imagePreviewWrapper').style.display = 'block';
                document.getElementById('dropZonePlaceholder').style.display = 'none';
            };
            reader.readAsDataURL(file);
        }

        function setupImageUploadWidget() {
            var dropZone = document.getElementById('imageDropZone');
            var fileInput = document.getElementById('editImageFile');
            var browseBtn = document.getElementById('browseFileBtn');
            var changeBtn = document.getElementById('changeImageBtn');
            var removeBtn = document.getElementById('removeImageBtn');

            if (!dropZone) return;

            browseBtn.addEventListener('click', function (e) { e.stopPropagation(); fileInput.click(); });
            changeBtn.addEventListener('click', function (e) { e.stopPropagation(); fileInput.click(); });
            fileInput.addEventListener('change', function () { if (this.files && this.files[0]) applyFileToPreview(this.files[0]); });
            removeBtn.addEventListener('click', function () { clearImageUpload(); document.getElementById('editImagePath').value = ''; });
            dropZone.addEventListener('dragover', function (e) { e.preventDefault(); dropZone.classList.add('drag-over'); });
            dropZone.addEventListener('dragleave', function () { dropZone.classList.remove('drag-over'); });
            dropZone.addEventListener('drop', function (e) { e.preventDefault(); dropZone.classList.remove('drag-over'); var file = e.dataTransfer.files && e.dataTransfer.files[0]; if (file) applyFileToPreview(file); });
            dropZone.addEventListener('click', function (e) {
                if (e.target === dropZone || e.target.classList.contains('drop-zone-placeholder') || e.target.classList.contains('drop-zone-icon') || e.target.classList.contains('drop-zone-text') || e.target.classList.contains('drop-zone-hint')) {
                    fileInput.click();
                }
            });
        }

        function buildMenuCard(menu) {
            var menuId = menu.menuId;
            var code = 'MEN-' + String(menuId).padStart(3, '0');
            var status = menu.status || 'active';
            var iconCls = foodTypeIcons[menu.foodType] || 'fa-utensils';
            var desc = menu.description || (menu.foodType + ' — ₱' + parseFloat(menu.price).toFixed(2));
            var _imgUrl = '';
            if (menu.imagePath) {
                var _root = (window.__appRoot || '').replace(/\/+$/, '');
                _imgUrl = _root + '/' + menu.imagePath.replace(/^\//, '');
            }
            var headerBgStyle = _imgUrl ? 'background-image:url(\'' + _imgUrl + '\');background-size:cover;background-position:center;' : 'background-color:#f3ebe0;';
            var overlayBg = _imgUrl ? 'rgba(0,0,0,0.38)' : 'none';
            var statusDotClass = status === 'active' ? '#2d9d78' : '#d97706';
            var statusBadgeBg = status === 'active' ? 'var(--success-green)' : 'var(--warning-orange)';
            var statusLabel = status === 'active' ? 'ACTIVE' : 'HIDDEN';

            var card = document.createElement('div');
            card.className = 'menu-card';
            card.setAttribute('data-menu-id', menuId);
            card.setAttribute('tabindex', '0');
            card.setAttribute('role', 'article');
            card.setAttribute('aria-label', menu.foodName + ', ' + menu.foodType);
            card.innerHTML = `
                <div class="menu-header" style="position:relative;${headerBgStyle}">
                    <div style="position:absolute;inset:0;background:${overlayBg};display:flex;flex-direction:column;align-items:center;justify-content:center;z-index:2;padding:20px;text-align:center;">
                        <i class="fas ${iconCls} menu-icon" aria-hidden="true"></i>
                        <h3 class="menu-title">${menu.foodName}</h3>
                    </div>
                    <div style="position:absolute;top:12px;right:12px;z-index:3;width:12px;height:12px;border-radius:50%;background:${statusDotClass};border:2px solid white;box-shadow:0 0 0 2px rgba(255,255,255,0.3);"></div>
                </div>
                <div class="menu-body">
                    <div class="menu-meta">
                        <span class="menu-code">${code}</span>
                        <button type="button" class="status-toggle-btn" data-menu-id="${menuId}" style="background:${statusBadgeBg};">${statusLabel}</button>
                    </div>
                    <p class="menu-description">${desc}</p>
                    <div class="menu-footer">
                        <div class="item-count">
                            <i class="fas fa-tag"></i>
                            <span>₱${parseFloat(menu.price).toFixed(2)}</span>
                        </div>
                        <div class="menu-actions">
                            <button type="button" class="action-icon view" title="View Details" aria-label="View ${menu.foodName}"><i class="fas fa-eye"></i></button>
                            <button type="button" class="action-icon edit" title="Edit Item" aria-label="Edit ${menu.foodName}"><i class="fas fa-edit"></i></button>
                            <button type="button" class="action-icon delete" title="Delete Item" aria-label="Delete ${menu.foodName}"><i class="fas fa-trash"></i></button>
                        </div>
                    </div>
                </div>
            `;
            return card;
        }

        function renderMenus() {
            const grid = document.getElementById('menusGrid');
            if (!grid) return;
            grid.innerHTML = '';
            let filteredMenus = [...menusData];

            if (currentFilters.search) {
                const s = currentFilters.search.toLowerCase();
                filteredMenus = filteredMenus.filter(m => (m.foodName || '').toLowerCase().includes(s) || (m.foodType || '').toLowerCase().includes(s));
            }
            if (currentFilters.status && currentFilters.status !== 'all') {
                filteredMenus = filteredMenus.filter(m => (m.status || 'active') === currentFilters.status);
            }
            if (currentFilters.category && currentFilters.category !== 'all') {
                filteredMenus = filteredMenus.filter(m => (m.foodType || '').toLowerCase() === currentFilters.category.toLowerCase());
            }

            filteredMenus.sort((a, b) => {
                switch (currentFilters.sort) {
                    case 'name-asc': return (a.foodName || '').localeCompare(b.foodName || '');
                    case 'name-desc': return (b.foodName || '').localeCompare(a.foodName || '');
                    case 'price-high': return (b.price || 0) - (a.price || 0);
                    case 'price-low': return (a.price || 0) - (b.price || 0);
                    default: return b.menuId - a.menuId;
                }
            });

            if (filteredMenus.length === 0) {
                document.getElementById('noResultsMessage').style.display = 'block';
                return;
            }
            document.getElementById('noResultsMessage').style.display = 'none';

            var categoriesToShow = currentFilters.category !== 'all'
                ? CATEGORIES.filter(c => c.key.toLowerCase() === currentFilters.category.toLowerCase())
                : CATEGORIES;

            var knownKeys = CATEGORIES.map(c => c.key.toLowerCase());
            var otherItems = filteredMenus.filter(m => !knownKeys.includes((m.foodType || '').toLowerCase()));

            categoriesToShow.forEach(function (cat) {
                var items = filteredMenus.filter(m => (m.foodType || '').toLowerCase() === cat.key.toLowerCase());
                if (items.length === 0) return;
                var header = document.createElement('div');
                header.className = 'category-section-header';
                header.innerHTML = `<div class="category-section-icon"><i class="fas ${cat.icon}"></i></div><h2 class="category-section-title">${cat.label}</h2><span class="category-section-count">${items.length} item${items.length !== 1 ? 's' : ''}</span>`;
                grid.appendChild(header);
                var sectionGrid = document.createElement('div');
                sectionGrid.className = 'category-section-grid';
                items.forEach(menu => sectionGrid.appendChild(buildMenuCard(menu)));
                grid.appendChild(sectionGrid);
            });

            if (otherItems.length > 0 && currentFilters.category === 'all') {
                var header = document.createElement('div');
                header.className = 'category-section-header';
                header.innerHTML = `<div class="category-section-icon"><i class="fas fa-utensils"></i></div><h2 class="category-section-title">Other Items</h2><span class="category-section-count">${otherItems.length} item${otherItems.length !== 1 ? 's' : ''}</span>`;
                grid.appendChild(header);
                var sectionGrid = document.createElement('div');
                sectionGrid.className = 'category-section-grid';
                otherItems.forEach(menu => sectionGrid.appendChild(buildMenuCard(menu)));
                grid.appendChild(sectionGrid);
            }
        }

        function openViewModal(menuId) {
            var menu = menusData.find(m => m.menuId === menuId);
            if (!menu) return;
            var code = 'MEN-' + String(menu.menuId).padStart(3, '0');
            var status = menu.status || 'active';
            var iconCls = foodTypeIcons[menu.foodType] || 'fa-utensils';
            var desc = menu.description || (menu.foodType + ' — ₱' + parseFloat(menu.price).toFixed(2));
            var viewModalHeader = document.getElementById('viewModalHeader');
            var _vmRoot = (window.__appRoot || '').replace(/\/+$/, '');
            var _vmImg = menu.imagePath ? _vmRoot + '/' + menu.imagePath.replace(/^\//, '') : '';
            viewModalHeader.style.backgroundImage = _vmImg ? "url('" + _vmImg + "')" : '';
            document.getElementById('viewModalIcon').className = 'fas ' + iconCls + ' view-modal-icon';
            document.getElementById('viewModalTitle').textContent = menu.foodName;
            document.getElementById('viewModalCode').textContent = code;
            document.getElementById('viewModalDescription').textContent = desc;
            document.getElementById('viewModalCategory').textContent = menu.foodType || '—';
            document.getElementById('viewModalPrice').textContent = '₱' + parseFloat(menu.price).toFixed(2);
            document.getElementById('viewModalItems').textContent = (menu.itemCount || 0) + ' items';
            var statusElement = document.getElementById('viewModalStatus');
            statusElement.textContent = status === 'active' ? 'ACTIVE' : 'HIDDEN';
            statusElement.className = 'detail-value status ' + (status === 'active' ? 'status-active' : 'status-hidden');
            document.getElementById('viewModal').style.display = 'flex';
            setTimeout(function () { document.getElementById('closeViewModal').focus(); }, 100);
        }

        function closeViewModal() {
            document.getElementById('viewModal').style.display = 'none';
        }

        function openEditModal(menuId = null, isNew = false) {
            clearImageUpload();
            document.getElementById('editFoodName').value = '';
            document.getElementById('editFoodType').value = '';
            document.getElementById('editPrice').value = '';
            document.getElementById('editImagePath').value = '';

            if (isNew) {
                document.getElementById('editModalTitle').textContent = 'Add Food Item';
                document.getElementById('editMenuId').value = '';
                currentEditMenuId = null;
            } else {
                document.getElementById('editModalTitle').textContent = 'Edit Food Item';
                document.getElementById('editMenuId').value = menuId;
                currentEditMenuId = menuId;
                var menu = menusData.find(m => m.menuId === menuId);
                if (menu) {
                    document.getElementById('editFoodName').value = menu.foodName || '';
                    document.getElementById('editFoodType').value = menu.foodType || '';
                    document.getElementById('editPrice').value = menu.price || '';
                    document.getElementById('editImagePath').value = menu.imagePath || '';
                }
            }
            document.getElementById('editModal').style.display = 'flex';
            setTimeout(() => { document.getElementById('editFoodName').focus(); }, 100);
        }

        function closeEditModal() {
            document.getElementById('editModal').style.display = 'none';
            clearImageUpload();
        }

        async function saveEditChanges() {
            const saveBtn = document.getElementById('saveEdit');
            const foodName = document.getElementById('editFoodName').value.trim();
            const foodType = document.getElementById('editFoodType').value;
            const price = document.getElementById('editPrice').value.trim();
            const imagePath = document.getElementById('editImagePath').value.trim();

            if (!foodName) {
                showNotification('Food Name is required!', 'error');
                document.getElementById('editFoodName').focus();
                return;
            }
            if (!foodType) {
                showNotification('Please select a category!', 'error');
                document.getElementById('editFoodType').focus();
                return;
            }
            if (!price || isNaN(parseFloat(price)) || parseFloat(price) < 0) {
                showNotification('Please enter a valid price!', 'error');
                document.getElementById('editPrice').focus();
                return;
            }

            saveBtn.classList.add('btn--loading');
            saveBtn.disabled = true;

            const hiddenMenuId = document.getElementById('editMenuId').value;
            document.getElementById('hMenuId').value = hiddenMenuId;
            document.getElementById('hFoodName').value = foodName;
            document.getElementById('hFoodType').value = foodType;
            document.getElementById('hPrice').value = parseFloat(price).toFixed(2);
            document.getElementById('hImagePath').value = imagePath;

            const editFileInput = document.getElementById('editImageFile');
            if (editFileInput && editFileInput.files && editFileInput.files[0]) {
                try {
                    var imgFd = new FormData();
                    imgFd.append('ImageFile', editFileInput.files[0]);
                    var upResp = await fetch(window.location.pathname + '?action=upload', { method: 'POST', body: imgFd });
                    var upRes = await upResp.json();
                    if (upRes.success && upRes.imagePath) {
                        document.getElementById('hImagePath').value = upRes.imagePath;
                    }
                } catch (upErr) {
                    console.warn('Image upload failed:', upErr);
                }
            }

            saveBtn.classList.remove('btn--loading');
            saveBtn.classList.add('btn--success');
            showNotification(hiddenMenuId ? '"' + foodName + '" updated!' : '"' + foodName + '" added!', 'success');
            setTimeout(function () {
                var btn = document.getElementById('<%= btnSaveMenu.ClientID %>');
                btn._allowSubmit = true;
                btn.click();
            }, 600);
        }

        function openDeleteModal(menuId) {
            var menu = menusData.find(m => m.menuId === menuId);
            if (!menu) return;
            document.getElementById('deleteMessage').innerHTML = 'Are you sure you want to delete <strong>"' + menu.foodName + '"</strong>?';
            document.getElementById('deleteWarning').textContent = 'This action cannot be undone.';
            currentEditMenuId = menuId;
            document.getElementById('deleteModal').style.display = 'flex';
            setTimeout(() => { document.getElementById('cancelDelete').focus(); }, 100);
        }

        function closeDeleteModal() {
            document.getElementById('deleteModal').style.display = 'none';
            currentEditMenuId = null;
        }

        async function confirmDelete() {
            if (_isDeleting) return;
            _isDeleting = true;
            const deleteBtn = document.getElementById('confirmDelete');
            var menu = menusData.find(m => m.menuId === currentEditMenuId);
            if (!menu) { _isDeleting = false; return; }
            deleteBtn.classList.add('btn--loading');
            deleteBtn.disabled = true;
            try {
                var fd = new FormData();
                fd.append('menuId', menu.menuId);
                var resp = await fetch(window.location.pathname + '?action=delete', { method: 'POST', body: fd });
                var res = await resp.json();
                if (res.success) {
                    showNotification(menu.foodName + ' deleted successfully!', 'success');
                    closeDeleteModal();
                    setTimeout(function () { location.replace(window.location.pathname); }, 800);
                } else {
                    throw new Error(res.message || 'Delete failed.');
                }
            } catch (e) {
                _isDeleting = false;
                deleteBtn.classList.remove('btn--loading');
                deleteBtn.disabled = false;
                showNotification('Error: ' + e.message, 'error');
            }
        }

        async function toggleMenuStatus(menuId) {
            var menu = menusData.find(m => m.menuId === menuId);
            if (!menu) return;
            var newStatus = (!menu.status || menu.status === 'active') ? 'hidden' : 'active';
            try {
                var fd = new FormData();
                fd.append('menuId', menuId);
                fd.append('newStatus', newStatus);
                var resp = await fetch(window.location.pathname + '?action=toggleStatus', { method: 'POST', body: fd });
                var res = await resp.json();
                if (res.success) {
                    menu.status = newStatus;
                    var badge = document.querySelector('.status-toggle-btn[data-menu-id="' + menuId + '"]');
                    if (badge) {
                        badge.textContent = newStatus === 'active' ? 'ACTIVE' : 'HIDDEN';
                        badge.style.background = newStatus === 'active' ? 'var(--success-green)' : 'var(--warning-orange)';
                    }
                    updateStats();
                    showNotification(menu.foodName + ' is now ' + newStatus + '!', 'success');
                } else {
                    showNotification('Error: ' + (res.message || 'Status update failed.'), 'error');
                }
            } catch (e) {
                showNotification('Error updating status. Please try again.', 'error');
            }
        }

        function setupActionButtons() {
            document.addEventListener('click', function (e) {
                const editBtn = e.target.closest('.action-icon.edit');
                const deleteBtn = e.target.closest('.action-icon.delete');
                const viewBtn = e.target.closest('.action-icon.view');
                const statCard = e.target.closest('.stat-card');
                const statusBadge = e.target.closest('.status-toggle-btn');

                if (statusBadge) {
                    e.preventDefault();
                    var menuId = parseInt(statusBadge.dataset.menuId);
                    toggleMenuStatus(menuId);
                    return;
                }
                if (editBtn) {
                    e.preventDefault();
                    var card = editBtn.closest('.menu-card');
                    var menuId = parseInt(card.dataset.menuId);
                    openEditModal(menuId, false);
                    return;
                }
                if (deleteBtn) {
                    e.preventDefault();
                    var card = deleteBtn.closest('.menu-card');
                    var menuId = parseInt(card.dataset.menuId);
                    openDeleteModal(menuId);
                    return;
                }
                if (viewBtn) {
                    e.preventDefault();
                    var card = viewBtn.closest('.menu-card');
                    var menuId = parseInt(card.dataset.menuId);
                    openViewModal(menuId);
                    return;
                }
                if (statCard) {
                    var label = statCard.querySelector('.stat-card__label');
                    if (label) {
                        var statType = label.textContent.toLowerCase();
                        if (statType === 'total items') {
                            document.getElementById('statusFilter').value = 'all';
                            document.getElementById('statusFilter').dispatchEvent(new Event('change'));
                        } else if (statType === 'active items') {
                            document.getElementById('statusFilter').value = 'active';
                            document.getElementById('statusFilter').dispatchEvent(new Event('change'));
                        } else if (statType === 'hidden items') {
                            document.getElementById('statusFilter').value = 'hidden';
                            document.getElementById('statusFilter').dispatchEvent(new Event('change'));
                        }
                    }
                }
            });
        }

        function setupModalHandlers() {
            document.getElementById('closeViewModal')?.addEventListener('click', closeViewModal);
            document.getElementById('closeViewBtn')?.addEventListener('click', closeViewModal);
            document.getElementById('closeEditModal')?.addEventListener('click', closeEditModal);
            document.getElementById('cancelEdit')?.addEventListener('click', closeEditModal);
            document.getElementById('saveEdit')?.addEventListener('click', saveEditChanges);
            document.getElementById('closeDeleteModal')?.addEventListener('click', closeDeleteModal);
            document.getElementById('cancelDelete')?.addEventListener('click', closeDeleteModal);
            document.getElementById('confirmDelete')?.addEventListener('click', confirmDelete);
            document.getElementById('addMenuBtn')?.addEventListener('click', () => openEditModal(null, true));

            document.getElementById('viewModal')?.addEventListener('click', function (e) { if (e.target === this) closeViewModal(); });
            document.getElementById('editModal')?.addEventListener('click', function (e) { if (e.target === this) closeEditModal(); });
            document.getElementById('deleteModal')?.addEventListener('click', function (e) { if (e.target === this) closeDeleteModal(); });
        }

        function setupFilters() {
            document.getElementById('searchInput')?.addEventListener('input', function (e) {
                currentFilters.search = e.target.value.toLowerCase().trim();
                renderMenus();
            });
            document.getElementById('statusFilter')?.addEventListener('change', function (e) {
                currentFilters.status = e.target.value;
                renderMenus();
            });
            document.getElementById('sortFilter')?.addEventListener('change', function (e) {
                currentFilters.sort = e.target.value;
                renderMenus();
            });
            document.getElementById('categoryTabs')?.addEventListener('click', function (e) {
                var tab = e.target.closest('.category-tab');
                if (!tab) return;
                document.querySelectorAll('.category-tab').forEach(t => t.classList.remove('active'));
                tab.classList.add('active');
                currentFilters.category = tab.dataset.category;
                renderMenus();
            });
        }

        function setupKeyboardNavigation() {
            document.addEventListener('keydown', function (e) {
                if (e.key === 'Escape') {
                    const modals = ['viewModal', 'editModal', 'deleteModal'];
                    modals.forEach(id => {
                        var modal = document.getElementById(id);
                        if (modal && modal.style.display === 'flex') {
                            if (id === 'viewModal') closeViewModal();
                            if (id === 'editModal') closeEditModal();
                            if (id === 'deleteModal') closeDeleteModal();
                        }
                    });
                }
                // Intercept Enter inside the edit modal — route through validation instead of
                // letting the browser fire the hidden ASP.NET submit button directly.
                if (e.key === 'Enter') {
                    var editModal = document.getElementById('editModal');
                    if (editModal && editModal.style.display === 'flex') {
                        var tag = e.target.tagName;
                        // Allow Enter in textareas; block it elsewhere in the modal
                        if (tag !== 'TEXTAREA') {
                            e.preventDefault();
                            saveEditChanges();
                        }
                    }
                }
            });

            // Also block the hidden btnSaveMenu from being triggered by any means other
            // than the explicit .click() call inside saveEditChanges().
            var hiddenSaveBtn = document.getElementById('<%= btnSaveMenu.ClientID %>');
            if (hiddenSaveBtn) {
                hiddenSaveBtn.addEventListener('click', function (e) {
                    // Allow only if validation gate has already passed (flag set below)
                    if (!hiddenSaveBtn._allowSubmit) {
                        e.preventDefault();
                        e.stopImmediatePropagation();
                    }
                    hiddenSaveBtn._allowSubmit = false;
                }, true);
            }
        }

        document.addEventListener('DOMContentLoaded', function () {
            updateStats();
            renderMenus();
            setupFilters();
            setupActionButtons();
            setupModalHandlers();
            setupKeyboardNavigation();
            setupImageUploadWidget();
        });
    </script>
</asp:Content>