<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Admin.Master" AutoEventWireup="true" CodeBehind="UpdateMenu.aspx.cs" Inherits="TasteNet.Users.Admin.UpdateMenu" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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
            --accent-yellow: #e6b08c;
            --accent-yellow-dark: #d39c73;
            --accent-yellow-light: #f3e0d0;
            --accent-brown: #6b2c2c;
            --accent-brown-light: #f9ecee;
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

        * {
            box-sizing: border-box;
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

        .add-menu-item-btn {
            background: var(--primary-maroon);
            color: white;
            box-shadow: var(--button-shadow);
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
        }

        .add-menu-item-btn:hover {
            background: var(--primary-maroon-dark);
            transform: translateY(-3px);
            box-shadow: 
                0 8px 20px rgba(107, 13, 30, 0.25),
                0 0 0 1px rgba(107, 13, 30, 0.1);
            color: white;
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
            grid-template-columns: repeat(3, 1fr);
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

        .stat-card:hover {
            transform: translateY(-8px) scale(1.02);
            box-shadow: 
                0 20px 40px rgba(107, 13, 30, 0.15),
                0 8px 16px rgba(107, 13, 30, 0.1),
                0 0 0 1px rgba(107, 13, 30, 0.05);
            z-index: 2;
            border-color: var(--border-light);
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

        .stat-value-green {
            color: var(--success-green) !important;
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
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='14' height='14' fill='%238a6d6d' viewBox='0 0 16 16'%3E%3Cpath d='M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z'/%3E%3C/svg%3E");
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

        .categories-nav {
            display: flex;
            gap: 8px;
            margin-bottom: 25px;
            flex-wrap: wrap;
            padding: 4px;
            background: var(--bg-lighter);
            border-radius: var(--radius-lg);
        }

        .category-tab {
            padding: 12px 24px;
            border-radius: var(--radius-md);
            border: none;
            background: transparent;
            font-size: 13px;
            font-weight: 500;
            cursor: pointer;
            color: var(--muted-text);
            transition: all var(--transition-base);
            position: relative;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .category-tab:hover {
            color: var(--primary-maroon);
            background: var(--bg-light);
        }

        .category-tab.active {
            background: white;
            color: var(--primary-maroon);
            box-shadow: 0 4px 12px rgba(107, 13, 30, 0.1);
        }

        .category-tab.active::before {
            content: '';
            position: absolute;
            bottom: -4px;
            left: 50%;
            transform: translateX(-50%);
            width: 20px;
            height: 3px;
            background: var(--primary-maroon);
            border-radius: 2px;
        }

        .category-tab i {
            font-size: 14px;
        }

        .menu-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 25px;
            width: 100%;
        }

        .menu-card {
            background: white;
            border-radius: var(--radius-xl);
            box-shadow: var(--card-shadow);
            overflow: hidden;
            transition: all var(--transition-base);
            position: relative;
            border: 2px solid transparent;
            height: 100%;
            display: flex;
            flex-direction: column;
        }

        .menu-card:hover {
            transform: translateY(-8px) scale(1.02);
            box-shadow: var(--card-shadow-hover);
            border-color: var(--border-light);
            z-index: 2;
        }

        .menu-card__header {
            height: 180px;
            position: relative;
            overflow: hidden;
        }

        .menu-card__image {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform var(--transition-base);
        }

        .menu-card:hover .menu-card__image {
            transform: scale(1.05);
        }

        .menu-card__status {
            position: absolute;
            top: 15px;
            right: 15px;
            background: rgba(255, 255, 255, 0.9);
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 10px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            z-index: 2;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .status-available {
            background: var(--success-green-light);
            color: var(--success-green);
            border: 1px solid var(--success-green);
        }

        .status-unavailable {
            background: var(--danger-red-light);
            color: var(--danger-red);
            border: 1px solid var(--danger-red);
        }

        .menu-card__category {
            position: absolute;
            bottom: 15px;
            left: 15px;
            background: rgba(255, 255, 255, 0.9);
            padding: 6px 12px;
            border-radius: var(--radius-sm);
            font-size: 11px;
            font-weight: 600;
            color: var(--primary-maroon);
            z-index: 2;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .menu-card__body {
            padding: 20px;
            flex: 1;
            display: flex;
            flex-direction: column;
        }

        .menu-card__title {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 10px;
        }

        .menu-card__name {
            font-size: 18px;
            font-weight: 700;
            color: var(--text-dark);
            line-height: 1.3;
        }

        .menu-card__price {
            font-size: 20px;
            font-weight: 700;
            color: var(--primary-maroon);
            white-space: nowrap;
        }

        .menu-card__description {
            font-size: 13px;
            color: var(--muted-text);
            line-height: 1.6;
            margin-bottom: 20px;
            flex: 1;
        }

        .menu-card__meta {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-top: auto;
            padding-top: 15px;
            border-top: 1px solid var(--bg-light);
        }

        .menu-card__meta-item {
            display: flex;
            align-items: center;
            gap: 6px;
            font-size: 12px;
            color: var(--muted-text);
        }

        .menu-card__meta-item i {
            font-size: 12px;
            color: var(--primary-maroon);
        }

        .menu-card__footer {
            padding: 15px 20px;
            border-top: 2px solid var(--bg-lighter);
            display: flex;
            justify-content: flex-end;
            gap: 8px;
        }

        .menu-card__btn-icon {
            width: 36px;
            height: 36px;
            background: var(--soft-cream);
            border-radius: var(--radius-md);
            display: inline-flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all var(--transition-base);
            color: var(--muted-text);
            font-size: 14px;
            border: none;
            position: relative;
            overflow: hidden;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
        }

        .menu-card__btn-icon::before {
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

        .menu-card__btn-icon:active::before {
            width: 200px;
            height: 200px;
        }

        .menu-card__btn-icon:hover {
            transform: translateY(-2px) scale(1.1);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .menu-card__btn-icon--view:hover {
            background: var(--primary-maroon);
            color: white;
        }

        .menu-card__btn-icon--edit:hover {
            background: var(--accent-yellow);
            color: var(--text-dark);
        }

        .menu-card__btn-icon--delete:hover {
            background: var(--danger-red);
            color: white;
        }

        .menu-card__btn-icon[title]:hover::after {
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

        .menu-card__btn-icon[title]:hover::before {
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

        .view-modal-price {
            background: rgba(255, 255, 255, 0.2);
            padding: 6px 16px;
            border-radius: 20px;
            font-size: 18px;
            font-weight: 700;
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

        .detail-value.status-available {
            background: var(--success-green-light);
            color: var(--success-green);
        }

        .detail-value.status-unavailable {
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

        @media (max-width: 1400px) {
            .menu-grid {
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
            
            .menu-grid {
                grid-template-columns: 1fr;
                max-width: 600px;
                margin-left: auto;
                margin-right: auto;
            }

            .form-row {
                grid-template-columns: 1fr;
            }
            
            .view-modal-details {
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
            
            .categories-nav {
                overflow-x: auto;
                padding-bottom: 10px;
            }
            
            .category-tab {
                white-space: nowrap;
            }

            .edit-modal-body,
            .view-modal-body {
                padding: 20px;
            }
            
            .modal-footer {
                padding: 15px 20px;
                flex-direction: column;
            }
            
            .btn, .add-menu-item-btn {
                width: 100%;
            }

            .menu-card__footer {
                justify-content: center;
            }
            
            .menu-card__btn-icon {
                width: 32px;
                height: 32px;
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
            
            .btn, .add-menu-item-btn {
                padding: 10px 20px;
                font-size: 13px;
                min-height: 40px;
            }

            .menu-card__body {
                padding: 15px;
            }

            .menu-card__name {
                font-size: 16px;
            }

            .menu-card__price {
                font-size: 16px;
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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="full-page-wrapper">
        <div class="page-header">
            <div class="header-title">
                <h1>Menu Editor</h1>
                <p>Manage your restaurant menu items</p>
            </div>
            <div class="header-actions">
                <button type="button" class="add-menu-item-btn" id="addMenuItemBtn">
                    <i class="fas fa-plus"></i>Add Menu Item
                </button>
            </div>
        </div>

        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-card__value" id="totalItems">24</div>
                <div class="stat-card__subtitle">Total Items</div>
            </div>
            <div class="stat-card">
                <div class="stat-card__value stat-value-green" id="availableItems">23</div>
                <div class="stat-card__subtitle">Available Items</div>
            </div>
            <div class="stat-card">
                <div class="stat-card__value" id="totalCategories">3</div>
                <div class="stat-card__subtitle">Categories</div>
            </div>
        </div>

        <div class="filter-container">
            <div class="search-wrapper" id="searchBox">
                <i class="fas fa-search"></i>
                <input type="text" id="searchInput" placeholder="Search menu items...">
            </div>
            <select class="filter-dropdown" id="statusFilter">
                <option value="all">All Status</option>
                <option value="available">Available</option>
                <option value="unavailable">Unavailable</option>
            </select>
            <select class="filter-dropdown" id="sortFilter">
                <option value="price-high">Price: High to Low</option>
                <option value="price-low">Price: Low to High</option>
                <option value="name-asc">Name: A to Z</option>
                <option value="name-desc">Name: Z to A</option>
            </select>
        </div>

        <div class="categories-nav">
            <button class="category-tab active" data-category="all">
                <i class="fas fa-layer-group"></i> All Items
            </button>
            <button class="category-tab" data-category="silog">
                <i class="fas fa-utensils"></i> Silog Meals
            </button>
            <button class="category-tab" data-category="sizzling">
                <i class="fas fa-fire"></i> Sizzling Meals
            </button>
            <button class="category-tab" data-category="special">
                <i class="fas fa-star"></i> Special Meals
            </button>
        </div>

        <div class="menu-grid" id="menuGrid">
        </div>
        
        <div class="no-results" id="noResultsMessage">
            <i class="fas fa-search"></i>
            <h3>No menu items found</h3>
            <p>Try adjusting your search or filters</p>
        </div>
    </div>

    <div class="modal-overlay" id="viewModal">
        <div class="modal-content view-modal-content">
            <div class="view-modal-header">
                <img src="" alt="" class="view-modal-image" id="viewModalImage">
                <div class="view-modal-overlay">
                    <i class="fas" id="viewModalIcon"></i>
                    <h3 class="view-modal-title" id="viewModalTitle">Menu Item Name</h3>
                    <div class="view-modal-price" id="viewModalPrice">₱0.00</div>
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
                            <span class="detail-value status" id="viewModalStatus">AVAILABLE</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">Category</span>
                            <span class="detail-value" id="viewModalCategory">Silog Meals</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">Preparation Time</span>
                            <span class="detail-value" id="viewModalPrepTime">15 mins</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">Calories</span>
                            <span class="detail-value" id="viewModalCalories">500 cal</span>
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
                <h3 id="editModalTitle">Add New Menu Item</h3>
                <button class="modal-close" id="closeEditModal">&times;</button>
            </div>
            <div class="edit-modal-body">
                <div class="form-group">
                    <label for="editName">Menu Item Name</label>
                    <input type="text" id="editName" class="form-control" placeholder="Enter menu item name">
                </div>
                <div class="form-group">
                    <label for="editDescription">Description</label>
                    <textarea id="editDescription" class="form-control" placeholder="Enter item description" rows="3"></textarea>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label for="editCategory">Category</label>
                        <select id="editCategory" class="form-control">
                            <option value="sizzling">Sizzling Meals</option>
                            <option value="silog">Silog Meals</option>
                            <option value="special">Special Meals</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="editPrice">Price (₱)</label>
                        <input type="number" id="editPrice" class="form-control" placeholder="0.00" min="0" step="0.01">
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label for="editPrepTime">Prep Time (minutes)</label>
                        <input type="number" id="editPrepTime" class="form-control" placeholder="15" min="1">
                    </div>
                    <div class="form-group">
                        <label for="editCalories">Calories</label>
                        <input type="number" id="editCalories" class="form-control" placeholder="500" min="0">
                    </div>
                </div>
                <div class="form-group">
                    <label for="editImage">Image URL</label>
                    <input type="text" id="editImage" class="form-control" placeholder="https://example.com/image.jpg">
                </div>
                <div class="form-group">
                    <label for="editStatus">Status</label>
                    <div class="flex items-center gap-4">
                        <label class="switch">
                            <input type="checkbox" id="editStatus" checked>
                            <span class="slider"></span>
                        </label>
                        <span id="statusText" class="text-sm font-medium">Available</span>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn--outline" id="cancelEdit">Cancel</button>
                <button type="button" class="btn btn--primary" id="saveEdit">Save Item</button>
            </div>
        </div>
    </div>

    <div class="modal-overlay" id="deleteModal">
        <div class="modal-content">
            <div class="modal-header">
                <h3>Delete Menu Item</h3>
                <button class="modal-close" id="closeDeleteModal">&times;</button>
            </div>
            <div class="edit-modal-body">
                <div class="text-center mb-6">
                    <div class="delete-icon mb-4">
                        <i class="fas fa-trash" style="color: var(--danger-red); font-size: 48px;"></i>
                    </div>
                    <p class="text-lg font-semibold mb-2" id="deleteMessage">
                        Are you sure you want to delete this menu item?
                    </p>
                    <p class="text-gray-600 text-sm" id="deleteWarning">
                        This action cannot be undone. Customers will no longer see this item.
                    </p>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn--outline" id="cancelDelete">Cancel</button>
                <button type="button" class="btn btn--danger" id="confirmDelete">Delete Item</button>
            </div>
        </div>
    </div>

    <script>
        let menuData = [
            { id: 1, name: "Tapsilog", price: 100.00, category: "silog", description: "Traditional Filipino breakfast with beef tapa, garlic rice, and sunny-side-up egg.", prepTime: 20, calories: 520, status: "available", image: "https://images.unsplash.com/photo-1563379926898-05f4575a45d8?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80" },
            { id: 2, name: "Baconsilog", price: 75.00, category: "silog", description: "Crispy bacon strips with garlic rice and fried egg.", prepTime: 15, calories: 480, status: "available", image: "https://images.unsplash.com/photo-1551024709-8f23befc6f87?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80" },
            { id: 3, name: "Bangsilog", price: 85.00, category: "silog", description: "Fried milkfish with garlic rice and fried egg.", prepTime: 25, calories: 450, status: "available", image: "https://images.unsplash.com/photo-1586190848861-99aa4a171e90?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80" },
            { id: 4, name: "Hamsilog", price: 55.00, category: "silog", description: "Ham slices with garlic rice and fried egg.", prepTime: 10, calories: 380, status: "available", image: "https://images.unsplash.com/photo-1563245372-f21724e3856d?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80" },
            { id: 5, name: "Hotsilog (Purefoods)", price: 55.00, category: "silog", description: "Purefoods hotdog with garlic rice and fried egg.", prepTime: 12, calories: 420, status: "available", image: "https://images.unsplash.com/photo-1565299624946-b28f40a0ca4b?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80" },
            { id: 6, name: "Longsilog", price: 85.00, category: "silog", description: "Filipino longganisa with garlic rice and fried egg.", prepTime: 18, calories: 510, status: "available", image: "https://images.unsplash.com/photo-1603360946369-dc9bb6258143?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80" },
            { id: 7, name: "Malingsilog", price: 60.00, category: "silog", description: "Filipino-style corned beef with garlic rice and fried egg.", prepTime: 15, calories: 450, status: "available", image: "https://images.unsplash.com/photo-1565299507177-b0ac66763828?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80" },
            { id: 8, name: "Porksilog", price: 85.00, category: "silog", description: "Grilled pork chop with garlic rice and fried egg.", prepTime: 20, calories: 580, status: "available", image: "https://images.unsplash.com/photo-1504674900247-0877df9cc836?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80" },
            { id: 9, name: "Tocilog", price: 80.00, category: "silog", description: "Sweet cured pork tocino with garlic rice and fried egg.", prepTime: 18, calories: 510, status: "available", image: "https://images.unsplash.com/photo-1598866594230-a7c12756260f?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80" },
            { id: 10, name: "Sizzling Sisig", price: 150.00, category: "sizzling", description: "Authentic Filipino pork sisig served sizzling hot.", prepTime: 20, calories: 550, status: "available", image: "https://images.unsplash.com/photo-1565299507177-b0ac66763828?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80" },
            { id: 11, name: "Sizzling Pork Steak (Boneless)", price: 140.00, category: "sizzling", description: "Tender boneless pork steak served on a sizzling plate.", prepTime: 25, calories: 480, status: "available", image: "https://images.unsplash.com/photo-1504674900247-0877df9cc836?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80" },
            { id: 12, name: "Sizzling Chicken", price: 130.00, category: "sizzling", description: "Grilled chicken served sizzling with special sauce.", prepTime: 22, calories: 420, status: "available", image: "https://images.unsplash.com/photo-1598866594230-a7c12756260f?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80" },
            { id: 13, name: "Sizzling Tofu", price: 120.00, category: "sizzling", description: "Tofu and vegetables served on a sizzling plate.", prepTime: 15, calories: 320, status: "available", image: "https://images.unsplash.com/photo-1552539618-7eec9f4e1556?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80" },
            { id: 14, name: "Sizzling Bangus", price: 145.00, category: "sizzling", description: "Boneless milkfish served sizzling with onions and tomatoes.", prepTime: 20, calories: 380, status: "available", image: "https://images.unsplash.com/photo-1563805042-7684c019e1cb?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80" },
            { id: 15, name: "Sizzling Liempo", price: 155.00, category: "sizzling", description: "Grilled pork belly served sizzling with special sauce.", prepTime: 25, calories: 620, status: "available", image: "https://images.unsplash.com/photo-1563379926898-05f4575a45d8?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80" },
            { id: 16, name: "Sizzling Mix Platter", price: 180.00, category: "sizzling", description: "Mixed seafood and meat served on a sizzling plate.", prepTime: 30, calories: 720, status: "available", image: "https://images.unsplash.com/photo-1552539618-7eec9f4e1556?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80" },
            { id: 17, name: "Sizzling Gambas", price: 160.00, category: "sizzling", description: "Prawns in garlic butter sauce served sizzling.", prepTime: 20, calories: 380, status: "available", image: "https://images.unsplash.com/photo-1563805042-7684c019e1cb?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80" },
            { id: 18, name: "Sizzling Kangkong", price: 110.00, category: "sizzling", description: "Water spinach in oyster sauce served sizzling.", prepTime: 15, calories: 180, status: "available", image: "https://images.unsplash.com/photo-1563379926898-05f4575a45d8?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80" },
            { id: 19, name: "Special Goto", price: 120.00, category: "special", description: "Rich and savory Filipino rice porridge with tripe.", prepTime: 30, calories: 380, status: "available", image: "https://images.unsplash.com/photo-1551024709-8f23befc6f87?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80" },
            { id: 20, name: "Special Lugaw", price: 100.00, category: "special", description: "Filipino rice porridge with chicken and egg.", prepTime: 25, calories: 320, status: "available", image: "https://images.unsplash.com/photo-1586190848861-99aa4a171e90?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80" },
            { id: 21, name: "Special Arroz Caldo", price: 110.00, category: "special", description: "Filipino chicken rice porridge with ginger and garlic.", prepTime: 30, calories: 350, status: "available", image: "https://images.unsplash.com/photo-1563245372-f21724e3856d?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80" },
            { id: 22, name: "Special Bulalo", price: 250.00, category: "special", description: "Beef marrow soup with corn and vegetables.", prepTime: 45, calories: 550, status: "available", image: "https://images.unsplash.com/photo-1565299624946-b28f40a0ca4b?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80" },
            { id: 23, name: "Special Kare-Kare", price: 220.00, category: "special", description: "Filipino oxtail stew in peanut sauce.", prepTime: 60, calories: 620, status: "available", image: "https://images.unsplash.com/photo-1603360946369-dc9bb6258143?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80" },
            { id: 24, name: "Special Sinigang", price: 180.00, category: "special", description: "Filipino sour soup with pork and vegetables.", prepTime: 40, calories: 420, status: "available", image: "https://images.unsplash.com/photo-1586190848861-99aa4a171e90?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80" },
            { id: 25, name: "Special Adobo", price: 160.00, category: "special", description: "Classic Filipino chicken and pork adobo.", prepTime: 50, calories: 480, status: "available", image: "https://images.unsplash.com/photo-1563245372-f21724e3856d?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80" },
            { id: 26, name: "Special Caldereta", price: 190.00, category: "special", description: "Filipino goat stew with potatoes and bell peppers.", prepTime: 60, calories: 550, status: "available", image: "https://images.unsplash.com/photo-1565299624946-b28f40a0ca4b?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80" },
            { id: 27, name: "Special Bicol Express", price: 170.00, category: "special", description: "Spicy Filipino pork dish with coconut milk and chili.", prepTime: 45, calories: 520, status: "available", image: "https://images.unsplash.com/photo-1603360946369-dc9bb6258143?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80" }
        ];

        let currentFilters = {
            search: '',
            status: 'all',
            sort: 'name-asc',
            category: 'all'
        };

        let currentEditItemId = null;
        let currentViewItemId = null;

        function getCategoryIcon(category) {
            switch (category) {
                case 'silog': return 'fa-utensils';
                case 'sizzling': return 'fa-fire';
                case 'special': return 'fa-star';
                default: return 'fa-utensils';
            }
        }

        function getCategoryName(category) {
            switch (category) {
                case 'silog': return 'Silog Meals';
                case 'sizzling': return 'Sizzling Meals';
                case 'special': return 'Special Meals';
                default: return 'Unknown';
            }
        }

        function getStatusClass(status) {
            return status === 'available' ? 'status-available' : 'status-unavailable';
        }

        function getStatusText(status) {
            return status === 'available' ? 'AVAILABLE' : 'UNAVAILABLE';
        }

        function updateStats() {
            const totalItems = menuData.length;
            const availableItems = menuData.filter(item => item.status === 'available').length;

            document.getElementById('totalItems').textContent = totalItems;
            document.getElementById('availableItems').textContent = availableItems;
        }

        function renderMenuItems() {
            const grid = document.getElementById('menuGrid');
            grid.innerHTML = '';

            let filteredItems = [...menuData];

            if (currentFilters.category !== 'all') {
                filteredItems = filteredItems.filter(item => item.category === currentFilters.category);
            }

            if (currentFilters.search) {
                const searchTerm = currentFilters.search.toLowerCase();
                filteredItems = filteredItems.filter(item =>
                    item.name.toLowerCase().includes(searchTerm) ||
                    item.description.toLowerCase().includes(searchTerm)
                );
            }

            if (currentFilters.status !== 'all') {
                filteredItems = filteredItems.filter(item => item.status === currentFilters.status);
            }

            filteredItems.sort((a, b) => {
                switch (currentFilters.sort) {
                    case 'price-high':
                        return b.price - a.price;
                    case 'price-low':
                        return a.price - b.price;
                    case 'name-asc':
                        return a.name.localeCompare(b.name);
                    case 'name-desc':
                        return b.name.localeCompare(a.name);
                    default:
                        return 0;
                }
            });

            if (filteredItems.length === 0) {
                document.getElementById('noResultsMessage').style.display = 'block';
            } else {
                document.getElementById('noResultsMessage').style.display = 'none';

                filteredItems.forEach(item => {
                    const card = document.createElement('div');
                    card.className = 'menu-card';
                    card.setAttribute('data-item-id', item.id);
                    card.setAttribute('data-category', item.category);
                    card.setAttribute('data-status', item.status);

                    card.innerHTML = `
                        <div class="menu-card__header">
                            <img src="${item.image}" alt="${item.name}" class="menu-card__image">
                            <div class="menu-card__status ${getStatusClass(item.status)}">
                                ${getStatusText(item.status)}
                            </div>
                            <div class="menu-card__category">
                                <i class="fas ${getCategoryIcon(item.category)}"></i> ${getCategoryName(item.category)}
                            </div>
                        </div>
                        <div class="menu-card__body">
                            <div class="menu-card__title">
                                <h3 class="menu-card__name">${item.name}</h3>
                                <div class="menu-card__price">₱${item.price.toFixed(2)}</div>
                            </div>
                            <p class="menu-card__description">${item.description}</p>
                            <div class="menu-card__meta">
                                <div class="menu-card__meta-item">
                                    <i class="fas fa-clock"></i> ${item.prepTime} mins
                                </div>
                                <div class="menu-card__meta-item">
                                    <i class="fas fa-fire"></i> ${item.calories} cal
                                </div>
                            </div>
                        </div>
                        <div class="menu-card__footer">
                            <button class="menu-card__btn-icon menu-card__btn-icon--view" title="View Details">
                                <i class="fas fa-eye"></i>
                            </button>
                            <button class="menu-card__btn-icon menu-card__btn-icon--edit" title="Edit Item">
                                <i class="fas fa-edit"></i>
                            </button>
                            <button class="menu-card__btn-icon menu-card__btn-icon--delete" title="Delete Item">
                                <i class="fas fa-trash"></i>
                            </button>
                        </div>
                    `;

                    grid.appendChild(card);
                });
            }

            updateStats();
        }

        function openViewModal(itemId) {
            currentViewItemId = itemId;
            const item = menuData.find(i => i.id === itemId);

            if (!item) return;

            document.getElementById('viewModalImage').src = item.image || '';
            document.getElementById('viewModalImage').alt = item.name;
            document.getElementById('viewModalIcon').className = `fas ${getCategoryIcon(item.category)} view-modal-icon`;
            document.getElementById('viewModalTitle').textContent = item.name;
            document.getElementById('viewModalPrice').textContent = `₱${item.price.toFixed(2)}`;
            document.getElementById('viewModalDescription').textContent = item.description;
            document.getElementById('viewModalCategory').textContent = getCategoryName(item.category);
            document.getElementById('viewModalPrepTime').textContent = `${item.prepTime} mins`;
            document.getElementById('viewModalCalories').textContent = `${item.calories} cal`;

            const statusElement = document.getElementById('viewModalStatus');
            statusElement.textContent = getStatusText(item.status);
            statusElement.className = `detail-value status ${getStatusClass(item.status)}`;

            document.getElementById('viewModal').style.display = 'flex';
        }

        function closeViewModal() {
            document.getElementById('viewModal').style.display = 'none';
            currentViewItemId = null;
        }

        function openEditModal(itemId = null, isNew = false) {
            const modal = document.getElementById('editModal');
            const modalTitle = document.getElementById('editModalTitle');
            const statusToggle = document.getElementById('editStatus');
            const statusText = document.getElementById('statusText');

            if (isNew) {
                modalTitle.textContent = 'Add New Menu Item';
                currentEditItemId = null;

                document.getElementById('editName').value = '';
                document.getElementById('editDescription').value = '';
                document.getElementById('editCategory').value = 'silog';
                document.getElementById('editPrice').value = '';
                document.getElementById('editPrepTime').value = '15';
                document.getElementById('editCalories').value = '500';
                document.getElementById('editImage').value = '';
                statusToggle.checked = true;
                statusText.textContent = 'Available';
            } else {
                modalTitle.textContent = 'Edit Menu Item';
                currentEditItemId = itemId;

                const item = menuData.find(i => i.id === itemId);
                if (!item) return;

                document.getElementById('editName').value = item.name;
                document.getElementById('editDescription').value = item.description;
                document.getElementById('editCategory').value = item.category;
                document.getElementById('editPrice').value = item.price;
                document.getElementById('editPrepTime').value = item.prepTime;
                document.getElementById('editCalories').value = item.calories;
                document.getElementById('editImage').value = item.image || '';
                statusToggle.checked = item.status === 'available';
                statusText.textContent = item.status === 'available' ? 'Available' : 'Unavailable';
            }

            modal.style.display = 'flex';
        }

        function closeEditModal() {
            document.getElementById('editModal').style.display = 'none';
            currentEditItemId = null;
        }

        function saveEditChanges() {
            const name = document.getElementById('editName').value.trim();
            const description = document.getElementById('editDescription').value.trim();
            const category = document.getElementById('editCategory').value;
            const price = parseFloat(document.getElementById('editPrice').value);
            const prepTime = parseInt(document.getElementById('editPrepTime').value);
            const calories = parseInt(document.getElementById('editCalories').value);
            const image = document.getElementById('editImage').value.trim();
            const status = document.getElementById('editStatus').checked ? 'available' : 'unavailable';

            if (!name || !description || isNaN(price) || price < 0 || isNaN(prepTime) || prepTime < 1 || isNaN(calories) || calories < 0) {
                showNotification('Please fill in all required fields with valid values!', 'error');
                return;
            }

            if (currentEditItemId) {
                const item = menuData.find(i => i.id === currentEditItemId);
                if (item) {
                    item.name = name;
                    item.description = description;
                    item.category = category;
                    item.price = price;
                    item.prepTime = prepTime;
                    item.calories = calories;
                    item.image = image;
                    item.status = status;

                    showNotification(`${item.name} updated successfully!`, 'success');
                }
            } else {
                const newItem = {
                    id: menuData.length > 0 ? Math.max(...menuData.map(i => i.id)) + 1 : 1,
                    name: name,
                    description: description,
                    category: category,
                    price: price,
                    prepTime: prepTime,
                    calories: calories,
                    image: image,
                    status: status
                };

                menuData.push(newItem);
                showNotification(`${newItem.name} added successfully!`, 'success');
            }

            renderMenuItems();
            closeEditModal();
        }

        function openDeleteModal(itemId) {
            const item = menuData.find(i => i.id === itemId);
            if (!item) return;

            document.getElementById('deleteMessage').innerHTML =
                `Are you sure you want to delete <strong>"${item.name}"</strong>?`;

            currentEditItemId = itemId;
            document.getElementById('deleteModal').style.display = 'flex';
        }

        function closeDeleteModal() {
            document.getElementById('deleteModal').style.display = 'none';
            currentEditItemId = null;
        }

        function confirmDelete() {
            const item = menuData.find(i => i.id === currentEditItemId);
            if (!item) return;

            const index = menuData.findIndex(i => i.id === currentEditItemId);
            menuData.splice(index, 1);

            renderMenuItems();
            showNotification(`${item.name} deleted successfully!`, 'success');
            closeDeleteModal();
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

        document.addEventListener('DOMContentLoaded', function () {
            const categoryTabs = document.querySelectorAll('.category-tab');
            categoryTabs.forEach(tab => {
                tab.addEventListener('click', function () {
                    categoryTabs.forEach(t => t.classList.remove('active'));
                    this.classList.add('active');
                    currentFilters.category = this.dataset.category;
                    renderMenuItems();
                });
            });

            document.getElementById('searchInput').addEventListener('input', function () {
                currentFilters.search = this.value.toLowerCase().trim();
                renderMenuItems();
            });

            document.getElementById('statusFilter').addEventListener('change', function () {
                currentFilters.status = this.value;
                renderMenuItems();
            });

            document.getElementById('sortFilter').addEventListener('change', function () {
                currentFilters.sort = this.value;
                renderMenuItems();
            });

            document.getElementById('addMenuItemBtn').addEventListener('click', () => {
                openEditModal(null, true);
            });

            document.getElementById('closeViewModal').addEventListener('click', closeViewModal);
            document.getElementById('closeViewBtn').addEventListener('click', closeViewModal);
            document.getElementById('closeEditModal').addEventListener('click', closeEditModal);
            document.getElementById('cancelEdit').addEventListener('click', closeEditModal);
            document.getElementById('saveEdit').addEventListener('click', saveEditChanges);
            document.getElementById('closeDeleteModal').addEventListener('click', closeDeleteModal);
            document.getElementById('cancelDelete').addEventListener('click', closeDeleteModal);
            document.getElementById('confirmDelete').addEventListener('click', confirmDelete);

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
                document.getElementById('statusText').textContent = this.checked ? 'Available' : 'Unavailable';
            });

            document.addEventListener('keydown', function (e) {
                if (e.key === 'Escape') {
                    if (document.getElementById('viewModal').style.display === 'flex') closeViewModal();
                    if (document.getElementById('editModal').style.display === 'flex') closeEditModal();
                    if (document.getElementById('deleteModal').style.display === 'flex') closeDeleteModal();
                }
            });

            document.addEventListener('click', function (e) {
                const viewBtn = e.target.closest('.menu-card__btn-icon--view');
                const editBtn = e.target.closest('.menu-card__btn-icon--edit');
                const deleteBtn = e.target.closest('.menu-card__btn-icon--delete');

                if (viewBtn) {
                    const card = viewBtn.closest('.menu-card');
                    const itemId = parseInt(card.dataset.itemId);
                    openViewModal(itemId);
                }

                if (editBtn) {
                    const card = editBtn.closest('.menu-card');
                    const itemId = parseInt(card.dataset.itemId);
                    openEditModal(itemId, false);
                }

                if (deleteBtn) {
                    const card = deleteBtn.closest('.menu-card');
                    const itemId = parseInt(card.dataset.itemId);
                    openDeleteModal(itemId);
                }
            });

            renderMenuItems();
        });
    </script>
</asp:Content>