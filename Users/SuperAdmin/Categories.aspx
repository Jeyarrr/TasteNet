<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/SuperAdmin.Master" AutoEventWireup="true" CodeBehind="Categories.aspx.cs" Inherits="TasteNet.Users.SuperAdmin.Categories" %>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
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
            padding: 16px 20px;
            border-radius: var(--radius-lg); 
            box-shadow: var(--card-shadow);
            transition: all 0.3s cubic-bezier(0.25, 0.46, 0.45, 0.94);
            border: 2px solid transparent;
            cursor: pointer;
            overflow: hidden;
            transform-origin: center;
            height: 100px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            will-change: transform, box-shadow;
            backface-visibility: hidden;
            -webkit-font-smoothing: antialiased;
            -moz-osx-font-smoothing: grayscale;
        }

        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 0;
            background: linear-gradient(
                to bottom, 
                rgba(255, 250, 243, 0.9) 0%, 
                rgba(255, 255, 255, 0.1) 100%
            );
            transition: height 0.4s cubic-bezier(0.25, 0.46, 0.45, 0.94);
            z-index: 0;
            border-radius: inherit;
            pointer-events: none;
        }

        .stat-card:hover {
            transform: translateY(-8px) scale(1.02);
            box-shadow: 
                0 20px 40px rgba(107, 13, 30, 0.15),
                0 8px 16px rgba(107, 13, 30, 0.1),
                0 0 0 1px rgba(107, 13, 30, 0.05);
            z-index: 2;
            border-color: var(--border-light);
        }

        .stat-card:hover::before {
            height: 100%;
        }

        .stat-card__header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 8px;
            position: relative;
            z-index: 1;
        }

        .stat-card__label {
            font-size: 11px;
            font-weight: 600;
            color: var(--muted-text);
            text-transform: uppercase;
            letter-spacing: 0.5px;
            position: relative;
            z-index: 1;
            transition: color 0.3s ease;
        }

        .stat-card:hover .stat-card__label {
            color: var(--text-dark);
        }

        .stat-icon { 
            width: 32px; 
            height: 32px; 
            border-radius: var(--radius-sm); 
            display: flex; 
            align-items: center; 
            justify-content: center; 
            font-size: 14px; 
            flex-shrink: 0;
            transition: all 0.4s cubic-bezier(0.34, 1.56, 0.64, 1) 0.1s;
            transform-origin: center;
            position: relative;
            z-index: 1;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .stat-card:hover .stat-icon {
            transform: scale(1.15) rotate(8deg);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);
        }

        .icon-total { 
            background: var(--primary-maroon); 
            color: white; 
        }
        .icon-active { 
            background: var(--success-green); 
            color: white; 
        }
        .icon-hidden { 
            background: var(--warning-orange); 
            color: white; 
        }
        .icon-items { 
            background: var(--accent-blue); 
            color: #3b82f6; 
        }

        .stat-card:hover .icon-total {
            background: var(--primary-maroon-dark);
        }

        .stat-card:hover .icon-active {
            background: #248765;
        }

        .stat-card:hover .icon-hidden {
            background: #c26806;
        }

        .stat-card__value {
            font-size: 28px;
            font-weight: 700;
            color: var(--primary-maroon);
            margin: 5px 0;
            line-height: 1;
            position: relative;
            z-index: 1;
            transition: all 0.3s ease;
            transform-origin: left center;
        }

        .stat-card:hover .stat-card__value {
            color: var(--primary-maroon-dark);
            transform: scale(1.05);
        }

        .stat-card__subtitle {
            font-size: 11px;
            font-weight: 500;
            color: var(--muted-text);
            opacity: 0.9;
            position: relative;
            z-index: 1;
            transition: all 0.3s ease;
        }

        .stat-card:hover .stat-card__subtitle {
            opacity: 1;
            color: var(--text-dark);
        }

        .stat-card::after {
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
            z-index: 0;
        }

        .stat-card:active::after {
            width: 200px;
            height: 200px;
        }

        .stat-card {
            transition-delay: 0.05s;
        }

        .stat-card > * {
            position: relative;
            z-index: 1;
        }

        @keyframes subtlePulse {
            0%, 100% { 
                box-shadow: 
                    0 20px 40px rgba(107, 13, 30, 0.15),
                    0 8px 16px rgba(107, 13, 30, 0.1),
                    0 0 0 1px rgba(107, 13, 30, 0.05);
            }
            50% { 
                box-shadow: 
                    0 25px 45px rgba(107, 13, 30, 0.18),
                    0 10px 20px rgba(107, 13, 30, 0.12),
                    0 0 0 1px rgba(107, 13, 30, 0.07);
            }
        }

        .stat-card:hover {
            animation: subtlePulse 2s infinite ease-in-out;
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
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org2000/svg' width='14' height='14' fill='%238a6d6d' viewBox='0 0 16 16'%3E%3Cpath d='M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 12px center;
            background-size: 10px;
            height: 42px;
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

        .categories-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 25px;
            margin-top: 30px;
            width: 100%;
        }

        .category-card {
            background: white;
            border-radius: var(--radius-2xl);
            box-shadow: var(--card-shadow);
            overflow: hidden;
            transition: all var(--transition-base);
            position: relative;
            animation: fadeIn 0.5s ease-out;
            border: 2px solid transparent;
        }

        .category-card:hover {
            transform: translateY(-8px) scale(1.02);
            box-shadow: var(--card-shadow-hover);
            border-color: var(--border-light);
            z-index: 2;
        }

        .category-header {
            height: 180px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            text-align: center;
            padding: 20px;
            position: relative;
            overflow: hidden;
        }

        .category-image {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            object-fit: cover;
            z-index: 0;
            transition: transform var(--transition-base);
        }

        .category-card:hover .category-image {
            transform: scale(1.05);
        }

        .category-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(135deg, rgba(0,0,0,0.4) 0%, rgba(0,0,0,0.2) 100%);
            z-index: 1;
        }

        .category-icon {
            font-size: 32px;
            margin-bottom: 12px;
            z-index: 2;
            position: relative;
            transition: transform var(--transition-base);
            color: white;
        }

        .category-card:hover .category-icon {
            transform: scale(1.2) rotate(5deg);
        }

        .category-title {
            font-size: 24px;
            font-weight: 700;
            color: white;
            margin: 0;
            z-index: 2;
            position: relative;
            text-shadow: 0 2px 4px rgba(0,0,0,0.3);
        }

        .category-body {
            padding: 24px;
        }

        .category-meta {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 16px;
        }

        .category-code {
            color: var(--primary-maroon);
            font-weight: 700;
            font-size: 13px;
            background: var(--bg-lighter);
            padding: 6px 12px;
            border-radius: var(--radius-sm);
        }

        .category-status {
            padding: 6px 16px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            transition: all var(--transition-fast);
            cursor: pointer;
        }

        .status-active {
            background: var(--success-green-light);
            color: var(--success-green);
            border: 1px solid var(--success-green);
        }

        .status-active:hover {
            background: var(--success-green);
            color: white;
            transform: translateY(-1px);
        }

        .status-hidden {
            background: var(--warning-orange-light);
            color: var(--warning-orange);
            border: 1px solid var(--warning-orange);
        }

        .status-hidden:hover {
            background: var(--warning-orange);
            color: white;
            transform: translateY(-1px);
        }

        .category-description {
            color: var(--muted-text);
            font-size: 14px;
            line-height: 1.6;
            margin-bottom: 20px;
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .category-footer {
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

        .category-actions {
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
        }

        .view-modal-image {
            width: 100%;
            height: 100%;
            object-fit: cover;
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

        .view-modal-section h4 i {
            color: var(--muted-text);
            font-size: 14px;
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

        @keyframes spin {
            from { transform: translateY(-50%) rotate(0deg); }
            to { transform: translateY(-50%) rotate(360deg); }
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

        @keyframes subtlePulse {
            0%, 100% { 
                box-shadow: 
                    0 20px 40px rgba(107, 13, 30, 0.15),
                    0 8px 16px rgba(107, 13, 30, 0.1),
                    0 0 0 1px rgba(107, 13, 30, 0.05);
            }
            50% { 
                box-shadow: 
                    0 25px 45px rgba(107, 13, 30, 0.18),
                    0 10px 20px rgba(107, 13, 30, 0.12),
                    0 0 0 1px rgba(107, 13, 30, 0.07);
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

        .status-indicator {
            position: absolute;
            top: 15px;
            right: 15px;
            width: 12px;
            height: 12px;
            border-radius: 50%;
            z-index: 3;
            border: 2px solid white;
        }

        .status-indicator.active {
            background: var(--success-green);
            box-shadow: 0 0 0 2px var(--success-green-light);
        }

        .status-indicator.hidden {
            background: var(--warning-orange);
            box-shadow: 0 0 0 2px var(--warning-orange-light);
        }

        @media (max-width: 1400px) {
            .categories-grid {
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
            
            .categories-grid {
                grid-template-columns: 1fr;
                max-width: 600px;
                margin-left: auto;
                margin-right: auto;
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
            
            .category-card {
                max-width: 100%;
            }

            .edit-modal-body,
            .view-modal-body {
                padding: 20px;
            }
            
            .modal-footer {
                padding: 15px 20px;
                flex-direction: column;
            }
            
            .btn {
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
                height: 120px;
            }

            .stat-card__value { 
                font-size: 26px;
            }
            
            .btn {
                padding: 10px 20px;
                font-size: 13px;
                min-height: 40px;
            }

            .category-header {
                height: 160px;
                padding: 15px;
            }

            .category-title {
                font-size: 20px;
            }

            .category-body {
                padding: 20px;
            }

            .category-actions {
                flex-wrap: wrap;
                justify-content: center;
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
                <h1>Category Management</h1>
                <p>Organize and manage menu categories</p>
            </div>
            <div class="header-actions">
                <button type="button" class="btn btn--secondary" id="addCategoryBtn">
                    <i class="fas fa-plus"></i>Add Category
                </button>
            </div>
        </div>

        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-card__header">
                    <span class="stat-card__label">Total Categories</span>
                    <div class="stat-icon icon-total"><i class="fas fa-layer-group"></i></div>
                </div>
                <div class="stat-card__value" id="totalCategories">5</div>
                <div class="stat-card__subtitle">All categories</div>
            </div>
            <div class="stat-card">
                <div class="stat-card__header">
                    <span class="stat-card__label">Active Categories</span>
                    <div class="stat-icon icon-active"><i class="fas fa-eye"></i></div>
                </div>
                <div class="stat-card__value" id="activeCategories">3</div>
                <div class="stat-card__subtitle">Visible to customers</div>
            </div>
            <div class="stat-card">
                <div class="stat-card__header">
                    <span class="stat-card__label">Hidden Categories</span>
                    <div class="stat-icon icon-hidden"><i class="fas fa-eye-slash"></i></div>
                </div>
                <div class="stat-card__value" id="hiddenCategories">2</div>
                <div class="stat-card__subtitle">Not visible to customers</div>
            </div>
            <div class="stat-card">
                <div class="stat-card__header">
                    <span class="stat-card__label">Total Items</span>
                    <div class="stat-icon icon-items"><i class="fas fa-utensils"></i></div>
                </div>
                <div class="stat-card__value" id="totalItems">20</div>
                <div class="stat-card__subtitle">Across all categories</div>
            </div>
        </div>

        <div class="filter-container">
            <div class="search-wrapper" id="searchBox">
                <i class="fas fa-search"></i>
                <input type="text" id="searchInput" placeholder="Search by category name or description...">
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
                <option value="items-high">Sort by: Items (High-Low)</option>
                <option value="items-low">Sort by: Items (Low-High)</option>
            </select>
        </div>

        <div class="categories-grid" id="categoriesGrid">
        </div>
        
        <div class="no-results" id="noResultsMessage">
            <i class="fas fa-search"></i>
            <h3>No categories found</h3>
            <p>Try adjusting your search or filters</p>
        </div>
    </div>

    <div class="modal-overlay" id="viewModal">
        <div class="modal-content view-modal-content">
            <div class="view-modal-header">
                <img src="" alt="" class="view-modal-image" id="viewModalImage">
                <div class="view-modal-overlay">
                    <i class="fas" id="viewModalIcon"></i>
                    <h3 class="view-modal-title" id="viewModalTitle">Category Name</h3>
                    <div class="view-modal-code" id="viewModalCode">CAT-000</div>
                </div>
                <button class="modal-close" id="closeViewModal">&times;</button>
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
                            <span class="detail-label">Items</span>
                            <span class="detail-value" id="viewModalItems">0 items</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">Created</span>
                            <span class="detail-value" id="viewModalCreated">Jan 1, 2024</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">Color Theme</span>
                            <span class="detail-value" id="viewModalColor">Maroon</span>
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
                <h3 id="editModalTitle">Add New Category</h3>
                <button class="modal-close" id="closeEditModal">&times;</button>
            </div>
            <div class="edit-modal-body">
                <div class="form-group">
                    <label for="editName">Category Name</label>
                    <input type="text" id="editName" class="form-control" placeholder="Enter category name">
                </div>
                <div class="form-group">
                    <label for="editDescription">Description</label>
                    <textarea id="editDescription" class="form-control" placeholder="Enter category description" rows="3"></textarea>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label for="editColor">Category Color</label>
                        <select id="editColor" class="form-control">
                            <option value="maroon">Maroon</option>
                            <option value="maroon-light">Light Maroon</option>
                            <option value="maroon-pale">Pale Maroon</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="editIcon">Icon</label>
                        <select id="editIcon" class="form-control">
                            <option value="fa-layer-group">Stack</option>
                            <option value="fa-utensils">Utensils</option>
                            <option value="fa-fire">Fire</option>
                            <option value="fa-mug-hot">Coffee</option>
                            <option value="fa-pizza-slice">Pizza</option>
                            <option value="fa-hamburger">Burger</option>
                            <option value="fa-seedling">Vegetarian</option>
                            <option value="fa-cookie">Dessert</option>
                        </select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label for="editCode">Category Code</label>
                        <input type="text" id="editCode" class="form-control" placeholder="e.g., CAT-001">
                    </div>
                    <div class="form-group">
                        <label for="editItemCount">Number of Items</label>
                        <input type="number" id="editItemCount" class="form-control" min="0" placeholder="Enter item count">
                    </div>
                </div>
                <div class="form-group">
                    <label for="editImage">Category Image URL</label>
                    <input type="text" id="editImage" class="form-control" placeholder="e.g., Image/Sisig.jpg">
                </div>
                <div class="form-group">
                    <label for="editStatus">Status</label>
                    <div class="flex items-center gap-4">
                        <label class="switch">
                            <input type="checkbox" id="editStatus" checked>
                            <span class="slider"></span>
                        </label>
                        <span id="statusText" class="text-sm font-medium">Active</span>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn--outline" id="cancelEdit">Cancel</button>
                <button type="button" class="btn btn--primary" id="saveEdit">Save Category</button>
            </div>
        </div>
    </div>

    <div class="modal-overlay" id="deleteModal">
        <div class="modal-content">
            <div class="modal-header">
                <h3>Delete Category</h3>
                <button class="modal-close" id="closeDeleteModal">&times;</button>
            </div>
            <div class="edit-modal-body">
                <div class="text-center mb-6">
                    <div class="delete-icon mb-4">
                        <i class="fas fa-trash" style="color: var(--danger-red); font-size: 48px;"></i>
                    </div>
                    <p class="text-lg font-semibold mb-2" id="deleteMessage">
                        Are you sure you want to delete this category?
                    </p>
                    <p class="text-gray-600 text-sm" id="deleteWarning">
                        This will also remove all items in this category. This action cannot be undone.
                    </p>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn--outline" id="cancelDelete">Cancel</button>
                <button type="button" class="btn btn--danger" id="confirmDelete">Delete Category</button>
            </div>
        </div>
    </div>

    <script>
        let categoriesData = [
            {
                id: 1,
                name: "Sizzling Specials",
                code: "CAT-001",
                description: "Premium sizzling plate meals featuring authentic flavors and high-quality ingredients. Our sizzling specials are served hot on cast-iron plates to preserve the aroma and taste.",
                color: "maroon",
                icon: "fa-fire",
                status: "active",
                itemCount: 5,
                image: "Images/Sisig.jpg",
                createdAt: "2024-01-15"
            },
            {
                id: 2,
                name: "Silog Meals",
                code: "CAT-002",
                description: "Classic Filipino breakfast combinations with rice, egg, and your choice of protein. Perfect for any time of the day, these comforting meals are a customer favorite.",
                color: "maroon-light",
                icon: "fa-utensils",
                status: "active",
                itemCount: 6,
                image: "Images/Hotsilog.jpg",
                createdAt: "2024-01-20"
            },
            {
                id: 3,
                name: "Special Meals",
                code: "CAT-003",
                description: "Comfort food and traditional Filipino favorites prepared with a special twist. Each dish is carefully crafted to deliver exceptional taste and presentation.",
                color: "maroon-pale",
                icon: "fa-mug-hot",
                status: "active",
                itemCount: 4,
                image: "Images/Goto.jpg",
                createdAt: "2024-02-01"
            },
            {
                id: 4,
                name: "Appetizers",
                code: "CAT-004",
                description: "Perfect starters to begin your meal experience. Our appetizers are designed to awaken your taste buds and prepare you for the main course.",
                color: "maroon",
                icon: "fa-cookie",
                status: "hidden",
                itemCount: 3,
                image: "Images/Appetizers.jpg",
                createdAt: "2024-02-10"
            },
            {
                id: 5,
                name: "Desserts",
                code: "CAT-005",
                description: "Sweet treats and delicious desserts to complete your meal. From classic Filipino favorites to modern creations, we have something for every sweet tooth.",
                color: "maroon-light",
                icon: "fa-seedling",
                status: "hidden",
                itemCount: 2,
                image: "Images/Desserts.jpg",
                createdAt: "2024-02-15"
            }
        ];

        let currentFilters = {
            search: '',
            status: 'all',
            sort: 'newest'
        };

        let currentEditCategoryId = null;
        let currentViewCategoryId = null;

        let hoverTimers = {};

        function initializeHoverIntent() {
            document.querySelectorAll('.stat-card').forEach((card, index) => {
                const cardId = `stat-card-${index}`;

                card.addEventListener('mouseenter', () => {
                    clearTimeout(hoverTimers[cardId]);
                    hoverTimers[cardId] = setTimeout(() => {
                        card.classList.add('hover-active');
                    }, 100);
                });

                card.addEventListener('mouseleave', () => {
                    clearTimeout(hoverTimers[cardId]);
                    card.classList.remove('hover-active');
                });
            });
        }

        function getColorClass(color) {
            switch (color) {
                case 'maroon': return 'bg-maroon';
                case 'maroon-light': return 'bg-maroon-light';
                case 'maroon-pale': return 'bg-maroon-pale';
                default: return 'bg-maroon';
            }
        }

        function getStatusText(status) {
            return status === 'active' ? 'ACTIVE' : 'HIDDEN';
        }

        function getStatusClass(status) {
            return status === 'active' ? 'status-active' : 'status-hidden';
        }

        function getColorText(color) {
            switch (color) {
                case 'maroon': return 'Maroon';
                case 'maroon-light': return 'Light Maroon';
                case 'maroon-pale': return 'Pale Maroon';
                default: return 'Maroon';
            }
        }

        function updateStats() {
            const totalCategories = categoriesData.length;
            const activeCategories = categoriesData.filter(c => c.status === 'active').length;
            const hiddenCategories = categoriesData.filter(c => c.status === 'hidden').length;
            const totalItems = categoriesData.reduce((sum, cat) => sum + cat.itemCount, 0);

            document.getElementById('totalCategories').textContent = totalCategories;
            document.getElementById('activeCategories').textContent = activeCategories;
            document.getElementById('hiddenCategories').textContent = hiddenCategories;
            document.getElementById('totalItems').textContent = totalItems;
        }

        function renderCategories() {
            const grid = document.getElementById('categoriesGrid');
            grid.innerHTML = '';

            let filteredCategories = [...categoriesData];

            if (currentFilters.search) {
                const searchTerm = currentFilters.search.toLowerCase();
                filteredCategories = filteredCategories.filter(category =>
                    category.name.toLowerCase().includes(searchTerm) ||
                    category.description.toLowerCase().includes(searchTerm) ||
                    category.code.toLowerCase().includes(searchTerm)
                );
            }

            if (currentFilters.status !== 'all') {
                filteredCategories = filteredCategories.filter(category =>
                    category.status === currentFilters.status
                );
            }

            filteredCategories.sort((a, b) => {
                if (a.status !== b.status) {
                    return a.status === 'active' ? -1 : 1;
                }

                switch (currentFilters.sort) {
                    case 'newest':
                        return new Date(b.createdAt) - new Date(a.createdAt);
                    case 'oldest':
                        return new Date(a.createdAt) - new Date(b.createdAt);
                    case 'name-asc':
                        return a.name.localeCompare(b.name);
                    case 'name-desc':
                        return b.name.localeCompare(a.name);
                    case 'items-high':
                        return b.itemCount - a.itemCount;
                    case 'items-low':
                        return a.itemCount - b.itemCount;
                    default:
                        return 0;
                }
            });

            if (filteredCategories.length === 0) {
                document.getElementById('noResultsMessage').style.display = 'block';
            } else {
                document.getElementById('noResultsMessage').style.display = 'none';

                filteredCategories.forEach(category => {
                    const categoryElement = document.createElement('div');
                    categoryElement.className = 'category-card';
                    categoryElement.setAttribute('data-category-id', category.id);
                    categoryElement.setAttribute('data-status', category.status);

                    categoryElement.innerHTML = `
                        <div class="category-header ${getColorClass(category.color)}">
                            ${category.image ? `<img src="${category.image}" alt="${category.name}" class="category-image">` : ''}
                            <div class="status-indicator ${category.status === 'active' ? 'active' : 'hidden'}"></div>
                            <i class="fas ${category.icon} category-icon"></i>
                            <h3 class="category-title">${category.name}</h3>
                        </div>
                        <div class="category-body">
                            <div class="category-meta">
                                <span class="category-code">${category.code}</span>
                                <span class="category-status ${getStatusClass(category.status)}">
                                    ${getStatusText(category.status)}
                                </span>
                            </div>
                            <p class="category-description">${category.description}</p>
                            <div class="category-footer">
                                <div class="item-count">
                                    <i class="fas fa-utensils"></i>
                                    <span>${category.itemCount} items</span>
                                </div>
                                <div class="category-actions">
                                    <div class="action-icon view" title="View Details">
                                        <i class="fas fa-eye"></i>
                                    </div>
                                    <div class="action-icon edit" title="Edit Category">
                                        <i class="fas fa-edit"></i>
                                    </div>
                                    <div class="action-icon delete" title="Delete Category">
                                        <i class="fas fa-trash"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    `;

                    grid.appendChild(categoryElement);
                });
            }
        }

        function handleSearch() {
            const searchInput = document.getElementById('searchInput');
            const searchBox = document.getElementById('searchBox');

            currentFilters.search = searchInput.value.toLowerCase().trim();
            searchBox.classList.add('loading');

            setTimeout(() => {
                renderCategories();
                searchBox.classList.remove('loading');
            }, 300);
        }

        function handleStatusFilter() {
            const statusFilter = document.getElementById('statusFilter');
            currentFilters.status = statusFilter.value;
            renderCategories();
        }

        function handleSortFilter() {
            const sortFilter = document.getElementById('sortFilter');
            currentFilters.sort = sortFilter.value;
            renderCategories();
        }

        function openViewModal(categoryId) {
            currentViewCategoryId = categoryId;
            const category = categoriesData.find(c => c.id === categoryId);

            if (!category) return;

            document.getElementById('viewModalImage').src = category.image || '';
            document.getElementById('viewModalImage').alt = category.name;
            document.getElementById('viewModalIcon').className = `fas ${category.icon} view-modal-icon`;
            document.getElementById('viewModalTitle').textContent = category.name;
            document.getElementById('viewModalCode').textContent = category.code;
            document.getElementById('viewModalDescription').textContent = category.description;
            document.getElementById('viewModalItems').textContent = `${category.itemCount} items`;
            document.getElementById('viewModalCreated').textContent = formatDate(category.createdAt);
            document.getElementById('viewModalColor').textContent = getColorText(category.color);

            const statusElement = document.getElementById('viewModalStatus');
            statusElement.textContent = getStatusText(category.status);
            statusElement.className = `detail-value status ${category.status === 'active' ? 'status-active' : 'status-hidden'}`;

            document.getElementById('viewModal').style.display = 'flex';
        }

        function closeViewModal() {
            document.getElementById('viewModal').style.display = 'none';
            currentViewCategoryId = null;
        }

        function openEditModal(categoryId = null, isNew = false) {
            const modal = document.getElementById('editModal');
            const modalTitle = document.getElementById('editModalTitle');
            const statusToggle = document.getElementById('editStatus');
            const statusText = document.getElementById('statusText');

            if (isNew) {
                modalTitle.textContent = 'Add New Category';
                currentEditCategoryId = null;

                document.getElementById('editName').value = '';
                document.getElementById('editDescription').value = '';
                document.getElementById('editColor').value = 'maroon';
                document.getElementById('editIcon').value = 'fa-layer-group';
                document.getElementById('editCode').value = 'CAT-001';
                document.getElementById('editItemCount').value = '0';
                document.getElementById('editImage').value = '';
                statusToggle.checked = true;
                statusText.textContent = 'Active';
            } else {
                modalTitle.textContent = 'Edit Category';
                currentEditCategoryId = categoryId;

                const category = categoriesData.find(c => c.id === categoryId);
                if (!category) return;

                document.getElementById('editName').value = category.name;
                document.getElementById('editDescription').value = category.description;
                document.getElementById('editColor').value = category.color;
                document.getElementById('editIcon').value = category.icon;
                document.getElementById('editCode').value = category.code;
                document.getElementById('editItemCount').value = category.itemCount;
                document.getElementById('editImage').value = category.image || '';
                statusToggle.checked = category.status === 'active';
                statusText.textContent = category.status === 'active' ? 'Active' : 'Hidden';
            }

            modal.style.display = 'flex';
        }

        function closeEditModal() {
            document.getElementById('editModal').style.display = 'none';
            currentEditCategoryId = null;
        }

        function saveEditChanges() {
            const name = document.getElementById('editName').value.trim();
            const description = document.getElementById('editDescription').value.trim();
            const color = document.getElementById('editColor').value;
            const icon = document.getElementById('editIcon').value;
            const code = document.getElementById('editCode').value.trim();
            const itemCount = parseInt(document.getElementById('editItemCount').value);
            const image = document.getElementById('editImage').value.trim();
            const status = document.getElementById('editStatus').checked ? 'active' : 'hidden';

            if (!name || !description || !code) {
                showNotification('Please fill in all required fields!', 'error');
                return;
            }

            if (isNaN(itemCount) || itemCount < 0) {
                showNotification('Please enter a valid item count!', 'error');
                return;
            }

            if (currentEditCategoryId) {
                const category = categoriesData.find(c => c.id === currentEditCategoryId);
                if (category) {
                    category.name = name;
                    category.description = description;
                    category.color = color;
                    category.icon = icon;
                    category.code = code;
                    category.itemCount = itemCount;
                    category.image = image;
                    category.status = status;

                    showNotification(`${category.name} updated successfully!`, 'success');
                }
            } else {
                const newCategory = {
                    id: categoriesData.length > 0 ? Math.max(...categoriesData.map(c => c.id)) + 1 : 1,
                    name: name,
                    description: description,
                    color: color,
                    icon: icon,
                    code: code,
                    itemCount: itemCount,
                    image: image,
                    status: status,
                    createdAt: new Date().toISOString().split('T')[0]
                };

                categoriesData.push(newCategory);
                showNotification(`${newCategory.name} added successfully!`, 'success');
            }

            updateStats();
            renderCategories();
            closeEditModal();
        }

        function openDeleteModal(categoryId) {
            const category = categoriesData.find(c => c.id === categoryId);
            if (!category) return;

            document.getElementById('deleteMessage').innerHTML =
                `Are you sure you want to delete <strong>"${category.name}"</strong>?`;
            document.getElementById('deleteWarning').textContent =
                `This will remove ${category.itemCount} items from this category. This action cannot be undone.`;

            currentEditCategoryId = categoryId;
            document.getElementById('deleteModal').style.display = 'flex';
        }

        function closeDeleteModal() {
            document.getElementById('deleteModal').style.display = 'none';
            currentEditCategoryId = null;
        }

        function confirmDelete() {
            const category = categoriesData.find(c => c.id === currentEditCategoryId);
            if (!category) return;

            const index = categoriesData.findIndex(c => c.id === currentEditCategoryId);
            categoriesData.splice(index, 1);

            updateStats();
            renderCategories();
            showNotification(`${category.name} deleted successfully!`, 'success');
            closeDeleteModal();
        }

        function setupActionButtons() {
            document.addEventListener('click', function (e) {
                const editBtn = e.target.closest('.action-icon.edit');
                const deleteBtn = e.target.closest('.action-icon.delete');
                const viewBtn = e.target.closest('.action-icon.view');

                if (editBtn) {
                    e.preventDefault();
                    e.stopPropagation();

                    const card = editBtn.closest('.category-card');
                    const categoryId = parseInt(card.dataset.categoryId);
                    openEditModal(categoryId, false);
                    return false;
                }

                if (deleteBtn) {
                    e.preventDefault();
                    e.stopPropagation();

                    const card = deleteBtn.closest('.category-card');
                    const categoryId = parseInt(card.dataset.categoryId);
                    openDeleteModal(categoryId);
                    return false;
                }

                if (viewBtn) {
                    e.preventDefault();
                    e.stopPropagation();

                    const card = viewBtn.closest('.category-card');
                    const categoryId = parseInt(card.dataset.categoryId);
                    openViewModal(categoryId);
                    return false;
                }
            });
        }

        function setupModalHandlers() {
            document.getElementById('closeViewModal').addEventListener('click', closeViewModal);
            document.getElementById('closeViewBtn').addEventListener('click', closeViewModal);

            document.getElementById('closeEditModal').addEventListener('click', closeEditModal);
            document.getElementById('cancelEdit').addEventListener('click', closeEditModal);
            document.getElementById('saveEdit').addEventListener('click', saveEditChanges);

            document.getElementById('closeDeleteModal').addEventListener('click', closeDeleteModal);
            document.getElementById('cancelDelete').addEventListener('click', closeDeleteModal);
            document.getElementById('confirmDelete').addEventListener('click', confirmDelete);

            document.getElementById('addCategoryBtn').addEventListener('click', () => openEditModal(null, true));

            document.getElementById('viewModal').addEventListener('click', function (e) {
                if (e.target === this) closeViewModal();
            });

            document.getElementById('editModal').addEventListener('click', function (e) {
                if (e.target === this) closeEditModal();
            });

            document.getElementById('deleteModal').addEventListener('click', function (e) {
                if (e.target === this) closeDeleteModal();
            });

            document.getElementById('editStatus').addEventListener('change', function () {
                document.getElementById('statusText').textContent = this.checked ? 'Active' : 'Hidden';
            });

            document.addEventListener('keydown', function (e) {
                if (e.key === 'Escape') {
                    if (document.getElementById('viewModal').style.display === 'flex') closeViewModal();
                    if (document.getElementById('editModal').style.display === 'flex') closeEditModal();
                    if (document.getElementById('deleteModal').style.display === 'flex') closeDeleteModal();
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

        function formatDate(dateString) {
            const options = { year: 'numeric', month: 'short', day: 'numeric' };
            return new Date(dateString).toLocaleDateString('en-US', options);
        }

        function generateCategoryCode() {
            const existingCodes = categoriesData.map(c => c.code);
            let codeNumber = 1;

            while (true) {
                const newCode = `CAT-${codeNumber.toString().padStart(3, '0')}`;
                if (!existingCodes.includes(newCode)) {
                    document.getElementById('editCode').value = newCode;
                    break;
                }
                codeNumber++;
            }
        }

        document.addEventListener('DOMContentLoaded', function () {
            updateStats();
            renderCategories();
            initializeHoverIntent();

            document.getElementById('searchInput').addEventListener('input', handleSearch);
            document.getElementById('statusFilter').addEventListener('change', handleStatusFilter);
            document.getElementById('sortFilter').addEventListener('change', handleSortFilter);

            setupActionButtons();
            setupModalHandlers();

            document.getElementById('addCategoryBtn').addEventListener('click', generateCategoryCode);
        });
    </script>
</asp:Content>