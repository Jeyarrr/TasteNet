<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/SuperAdmin.Master" AutoEventWireup="true" CodeBehind="PromoCodes.aspx.cs" Inherits="TasteNet.Users.SuperAdmin.PromoCodes" %>
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

        #promo-mgmt-wrapper {
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
            padding: 10px 20px;
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
            min-height: 40px;
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
            border: none;
            box-shadow: var(--button-shadow);
        }

        .btn--primary:hover {
            background: var(--primary-maroon-dark);
            transform: translateY(-3px);
            box-shadow: var(--button-shadow-hover);
        }

        .btn--outline {
            background: white;
            color: var(--primary-maroon);
            border: 2px solid var(--primary-maroon);
        }

        .btn--outline:hover {
            background: var(--primary-maroon);
            color: white;
            transform: translateY(-3px);
            box-shadow: var(--button-shadow-hover);
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

        .stat-card__icon--active { background: var(--accent-pink); color: var(--primary-maroon); }
        .stat-card__icon--uses { background: var(--success-green-light); color: var(--success-green); }
        .stat-card__icon--revenue { background: var(--accent-yellow-light); color: var(--warning-orange); }
        .stat-card__icon--expiring { background: var(--accent-blue); color: var(--accent-blue-dark); }

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
            padding: 10px 15px 10px 40px;
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
            padding: 10px 35px 10px 15px;
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

        .filter-select.active {
            border-color: var(--primary-maroon);
            background-color: var(--soft-cream);
            box-shadow: 0 0 0 3px rgba(107, 13, 30, 0.1);
        }

        .section-title {
            color: var(--primary-maroon);
            font-weight: 700;
            margin: 30px 0 20px;
            font-size: 20px;
            letter-spacing: -0.3px;
        }

        .promo-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 30px;
            margin-bottom: 40px;
        }

        .promo-card {
            background: white;
            border-radius: var(--radius-xl);
            padding: 25px;
            box-shadow: var(--card-shadow);
            position: relative;
            transition: all 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
            border: 2px solid transparent;
        }

        .promo-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--card-shadow-hover);
            border-color: rgba(107, 13, 30, 0.1);
        }

        .promo-badge-header {
            display: flex;
            gap: 12px;
            align-items: center;
            margin-bottom: 20px;
        }

        .code-pill {
            background: var(--primary-maroon);
            color: white;
            padding: 8px 16px;
            border-radius: var(--radius-lg);
            font-weight: 700;
            font-size: 14px;
            box-shadow: 0 4px 8px rgba(107, 13, 30, 0.2);
            transition: transform 0.3s ease;
        }

        .promo-card:hover .code-pill {
            transform: scale(1.05);
        }

        .status-pill {
            padding: 6px 14px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 700;
            letter-spacing: 0.5px;
            display: inline-block;
        }

        .status-pill.active {
            background: var(--success-green-light);
            color: var(--success-green);
        }

        .status-pill.expired {
            background: var(--danger-red-light);
            color: var(--danger-red);
        }

        .status-pill.scheduled {
            background: var(--accent-blue);
            color: var(--accent-blue-dark);
        }

        .promo-badge-header i {
            margin-left: auto;
            color: var(--muted-text);
            font-size: 18px;
            cursor: pointer;
            padding: 8px;
            border-radius: 10px;
            background: #f9f4ee;
            transition: all 0.3s ease;
        }

        .promo-badge-header i:hover {
            color: var(--primary-maroon);
            background: #f3ebe0;
            transform: scale(1.1);
        }

        .promo-card b {
            color: var(--primary-maroon);
            font-size: 18px;
            font-weight: 700;
            display: block;
            margin-bottom: 8px;
        }

        .promo-card p.small {
            color: var(--muted-text);
            font-size: 14px;
            line-height: 1.5;
            margin-bottom: 20px;
        }

        .discount-box {
            background: var(--accent-yellow);
            width: fit-content;
            padding: 12px 24px;
            border-radius: var(--radius-lg);
            font-weight: 800;
            font-size: 24px;
            margin: 20px 0;
            box-shadow: 0 4px 12px rgba(255, 204, 0, 0.2);
            transition: transform 0.3s ease;
        }

        .promo-card:hover .discount-box {
            transform: scale(1.05);
        }

        .promo-stats-bar {
            display: flex;
            justify-content: space-between;
            background: #FEF9F0;
            padding: 18px;
            border-radius: var(--radius-lg);
            margin: 20px 0;
            border: 2px solid #f3ebe0;
        }

        .stat-group {
            display: flex;
            flex-direction: column;
            transition: transform 0.3s ease;
        }

        .promo-card:hover .stat-group {
            transform: translateY(-2px);
        }

        .stat-label {
            font-size: 12px;
            color: var(--muted-text);
            font-weight: 600;
            margin-bottom: 4px;
            letter-spacing: 0.3px;
        }

        .stat-value {
            font-size: 16px;
            font-weight: 700;
            color: var(--text-dark);
        }

        .progress-line {
            height: 6px;
            background: #e2d1d1;
            border-radius: 3px;
            width: 100%;
            margin-top: 8px;
            overflow: hidden;
        }

        .progress-fill {
            height: 100%;
            border-radius: 3px;
            transition: width 0.5s ease;
        }

        .progress-fill.active {
            background: var(--success-green);
        }

        .progress-fill.expired {
            background: var(--danger-red);
        }

        .progress-fill.scheduled {
            background: var(--accent-blue-dark);
        }

        .promo-actions {
            display: flex;
            gap: 10px;
            border-top: 2px solid #f3ebe0;
            padding-top: 20px;
            margin-top: 20px;
        }

        .btn-action {
            flex: 1;
            padding: 12px;
            border-radius: var(--radius-md);
            font-size: 13px;
            font-weight: 600;
            text-align: center;
            text-decoration: none !important;
            transition: all 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            border: 2px solid transparent;
            cursor: pointer;
        }

        .btn-action:hover {
            transform: translateY(-3px) scale(1.05);
        }

        .btn-edit {
            background: var(--primary-maroon);
            color: white !important;
            box-shadow: 0 4px 12px rgba(107, 13, 30, 0.2);
        }

        .btn-edit:hover {
            background: #5a0b19;
            box-shadow: 0 6px 18px rgba(107, 13, 30, 0.3);
        }

        .btn-view {
            border: 2px solid var(--primary-maroon);
            color: var(--primary-maroon) !important;
            background: white;
        }

        .btn-view:hover {
            background: var(--primary-maroon);
            color: white !important;
            box-shadow: 0 4px 12px rgba(107, 13, 30, 0.2);
        }

        .btn-deactivate {
            flex: 0.8;
            border: 2px solid #e2d1d1;
            color: var(--muted-text) !important;
            background: white;
        }

        .btn-deactivate:hover {
            border-color: #d97706;
            color: #d97706 !important;
            background: #fff9e6;
        }

        .btn-activate {
            flex: 0.8;
            border: 2px solid var(--success-green);
            color: var(--success-green) !important;
            background: white;
        }

        .btn-activate:hover {
            border-color: var(--success-green);
            background: var(--success-green);
            color: white !important;
        }

        .suggested-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 30px;
            margin-bottom: 30px;
        }

        .suggested-card {
            border: 2px dashed #D48C70;
            background: transparent;
            border-radius: var(--radius-xl);
            padding: 25px;
            transition: all 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
        }

        .suggested-card:hover {
            transform: translateY(-5px);
            border-color: var(--primary-maroon);
            box-shadow: var(--card-shadow);
            background: rgba(255, 255, 255, 0.8);
        }

        .suggested-card h4 {
            color: var(--primary-maroon);
            font-weight: 700;
            font-size: 18px;
            margin-bottom: 10px;
            letter-spacing: -0.2px;
        }

        .suggested-card p.small {
            color: var(--muted-text);
            font-size: 14px;
            line-height: 1.5;
            margin-bottom: 20px;
        }

        .btn-create-campaign {
            width: 100%;
            border: 2px solid var(--primary-maroon);
            background: white;
            color: var(--primary-maroon);
            padding: 14px;
            border-radius: var(--radius-md);
            font-weight: 600;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }

        .btn-create-campaign:hover {
            background: var(--primary-maroon);
            color: white;
            transform: translateY(-3px) scale(1.02);
            box-shadow: 0 6px 18px rgba(107, 13, 30, 0.2);
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

        .inner-search.loading i {
            animation: spin 1s linear infinite;
        }

        .filter-count {
            display: inline-block;
            background: var(--primary-maroon);
            color: white;
            font-size: 11px;
            padding: 2px 8px;
            border-radius: 10px;
            margin-left: 8px;
            font-weight: 600;
            min-width: 20px;
            text-align: center;
        }

        .active-filters {
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
            margin-top: 10px;
        }

        .filter-tag {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            background: var(--soft-cream);
            border: 1px solid var(--border-light);
            padding: 4px 12px;
            border-radius: var(--radius-sm);
            font-size: 12px;
            color: var(--text-dark);
        }

        .filter-tag .remove-filter {
            color: var(--muted-text);
            cursor: pointer;
            transition: color 0.2s;
        }

        .filter-tag .remove-filter:hover {
            color: var(--danger-red);
        }

        .clear-filters {
            background: none;
            border: none;
            color: var(--primary-maroon);
            font-size: 13px;
            cursor: pointer;
            padding: 4px 8px;
            border-radius: var(--radius-sm);
            transition: all 0.2s;
            display: flex;
            align-items: center;
            gap: 4px;
        }

        .clear-filters:hover {
            background: var(--bg-lighter);
        }

        .confirmation-modal .modal-container {
            max-width: 400px;
        }

        .confirmation-icon {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            margin: 0 auto 20px;
        }

        .confirmation-icon.warning {
            background: var(--warning-orange-light);
            color: var(--warning-orange);
        }

        .confirmation-icon.danger {
            background: var(--danger-red-light);
            color: var(--danger-red);
        }

        .confirmation-icon.success {
            background: var(--success-green-light);
            color: var(--success-green);
        }

        .confirmation-title {
            text-align: center;
            color: var(--text-dark);
            font-size: 20px;
            font-weight: 700;
            margin-bottom: 10px;
        }

        .confirmation-message {
            text-align: center;
            color: var(--muted-text);
            font-size: 14px;
            line-height: 1.5;
            margin-bottom: 30px;
        }

        .confirmation-actions {
            display: flex;
            gap: 12px;
            justify-content: center;
        }

        .confirmation-actions .btn {
            min-width: 120px;
        }

        .modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0, 0, 0, 0.5);
            backdrop-filter: blur(8px);
            -webkit-backdrop-filter: blur(8px);
            display: none;
            justify-content: center;
            align-items: center;
            z-index: 9999;
            opacity: 0;
            transition: opacity 0.3s ease;
            padding: 20px;
        }

        .modal-overlay.active {
            display: flex;
            opacity: 1;
            animation: fadeIn 0.3s ease;
        }

        .modal-container {
            background: white;
            border-radius: var(--radius-xl);
            box-shadow: 0 20px 60px rgba(107, 13, 30, 0.25);
            max-width: 500px;
            width: 100%;
            max-height: 90vh;
            overflow-y: auto;
            transform: translateY(20px);
            transition: transform 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
            position: relative;
        }

        .modal-overlay.active .modal-container {
            transform: translateY(0);
        }

        .modal-header {
            background: var(--primary-maroon);
            color: white;
            padding: 25px 30px 15px;
            border-bottom: 2px solid var(--border-light);
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-radius: var(--radius-xl) var(--radius-xl) 0 0;
        }

        .modal-header h3 {
            color: white;
            font-weight: 700;
            font-size: 22px;
            margin: 0;
            letter-spacing: -0.3px;
        }

        .modal-header h3 i {
            display: none;
        }

        .modal-close {
            background: none;
            border: none;
            color: white;
            font-size: 20px;
            cursor: pointer;
            width: 36px;
            height: 36px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all var(--transition-base);
        }

        .modal-close:hover {
            background: rgba(255, 255, 255, 0.2);
            color: white;
            transform: rotate(90deg);
        }

        .modal-body {
            padding: 25px 30px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: var(--text-dark);
            font-size: 14px;
        }

        .form-control {
            width: 100%;
            padding: 12px 16px;
            border: 2px solid var(--border-light);
            border-radius: var(--radius-md);
            font-family: 'Poppins', sans-serif;
            font-size: 14px;
            background: white;
            color: var(--text-dark);
            transition: all var(--transition-base);
            box-sizing: border-box;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--primary-maroon);
            box-shadow: 0 0 0 3px rgba(107, 13, 30, 0.1);
            transform: translateY(-1px);
        }

        .form-control::placeholder {
            color: var(--muted-text);
            opacity: 0.7;
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
        }

        .form-actions {
            display: flex;
            gap: 12px;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 2px solid var(--border-light);
        }

        .discount-type-selector {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 10px;
            margin-top: 8px;
        }

        .discount-option {
            padding: 12px;
            border: 2px solid var(--border-light);
            border-radius: var(--radius-md);
            text-align: center;
            cursor: pointer;
            transition: all var(--transition-base);
            font-weight: 500;
            background: white;
            color: var(--text-dark);
        }

        .discount-option:hover {
            border-color: var(--primary-maroon);
            transform: translateY(-2px);
            color: var(--text-dark);
        }

        .discount-option.active {
            border-color: var(--primary-maroon);
            background: var(--accent-pink);
            color: var(--primary-maroon);
            font-weight: 600;
        }

        .discount-value-input {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .discount-value-input span {
            padding: 12px;
            background: var(--bg-lighter);
            border-radius: var(--radius-md) 0 0 var(--radius-md);
            font-weight: 500;
            color: var(--text-dark);
            border: 2px solid var(--border-light);
            border-right: none;
        }

        .discount-value-input input {
            border-radius: 0 var(--radius-md) var(--radius-md) 0;
        }

        .date-input-group {
            position: relative;
        }

        .date-input-group i {
            position: absolute;
            right: 16px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--muted-text);
            pointer-events: none;
        }

        .form-control.error {
            border-color: var(--danger-red);
            background: var(--danger-red-light);
        }

        .error-message {
            color: var(--danger-red);
            font-size: 12px;
            margin-top: 5px;
            display: none;
        }

        .error-message.show {
            display: block;
            animation: fadeIn 0.3s ease;
        }

        .modal-loading {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(255, 255, 255, 0.9);
            display: none;
            justify-content: center;
            align-items: center;
            border-radius: var(--radius-xl);
            z-index: 10;
        }

        .modal-loading.active {
            display: flex;
        }

        .spinner {
            width: 40px;
            height: 40px;
            border: 3px solid var(--border-light);
            border-top-color: var(--primary-maroon);
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        .modal-container::-webkit-scrollbar {
            width: 6px;
        }

        .modal-container::-webkit-scrollbar-track {
            background: var(--soft-cream);
            border-radius: 3px;
        }

        .modal-container::-webkit-scrollbar-thumb {
            background: var(--border-light);
            border-radius: 3px;
        }

        .modal-container::-webkit-scrollbar-thumb:hover {
            background: var(--border-hover);
        }

        .analytics-modal .modal-container {
            max-width: 800px;
        }

        .analytics-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .analytics-code {
            background: var(--primary-maroon);
            color: white;
            padding: 8px 16px;
            border-radius: var(--radius-md);
            font-weight: 700;
            font-size: 14px;
        }

        .analytics-status {
            padding: 6px 12px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 700;
        }

        .analytics-status.active {
            background: var(--success-green-light);
            color: var(--success-green);
        }

        .analytics-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
            margin-bottom: 30px;
        }

        .analytics-card {
            background: var(--bg-lighter);
            padding: 20px;
            border-radius: var(--radius-lg);
            border: 1px solid var(--border-light);
        }

        .analytics-card h4 {
            color: var(--primary-maroon);
            font-size: 16px;
            margin: 0 0 10px 0;
            font-weight: 600;
        }

        .analytics-value {
            font-size: 28px;
            font-weight: 700;
            color: var(--primary-maroon);
            margin-bottom: 5px;
        }

        .analytics-label {
            font-size: 12px;
            color: var(--muted-text);
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .analytics-chart {
            background: var(--bg-lighter);
            padding: 20px;
            border-radius: var(--radius-lg);
            margin-bottom: 20px;
            border: 1px solid var(--border-light);
        }

        .chart-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }

        .chart-title {
            color: var(--primary-maroon);
            font-weight: 600;
            font-size: 16px;
        }

        .chart-placeholder {
            height: 200px;
            background: linear-gradient(180deg, var(--accent-pink) 0%, var(--soft-cream) 100%);
            border-radius: var(--radius-md);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--muted-text);
            font-size: 14px;
        }

        .usage-timeline {
            background: var(--bg-lighter);
            padding: 20px;
            border-radius: var(--radius-lg);
            border: 1px solid var(--border-light);
        }

        .timeline-item {
            display: flex;
            align-items: center;
            padding: 10px 0;
            border-bottom: 1px solid var(--border-light);
        }

        .timeline-item:last-child {
            border-bottom: none;
        }

        .timeline-date {
            width: 100px;
            color: var(--primary-maroon);
            font-weight: 600;
            font-size: 13px;
        }

        .timeline-details {
            flex: 1;
        }

        .timeline-usage {
            color: var(--text-dark);
            font-weight: 600;
        }

        .timeline-revenue {
            color: var(--muted-text);
            font-size: 12px;
        }

        .valid-until {
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 10px 15px;
            background: #f9f4ee;
            border-radius: var(--radius-lg);
            color: var(--primary-maroon);
            font-weight: 600;
            font-size: 14px;
            margin-bottom: 20px;
        }

        .valid-until i {
            color: var(--primary-maroon);
        }

        @keyframes spin {
            from { transform: translateY(-50%) rotate(0deg); }
            to { transform: translateY(-50%) rotate(360deg); }
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

        @keyframes pulse {
            0% { box-shadow: 0 0 0 0 rgba(107, 13, 30, 0.4); }
            70% { box-shadow: 0 0 0 10px rgba(107, 13, 30, 0); }
            100% { box-shadow: 0 0 0 0 rgba(107, 13, 30, 0); }
        }

        @media (max-width: 1400px) {
            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 1200px) {
            #promo-mgmt-wrapper {
                padding: 15px 20px;
            }
            
            .promo-grid,
            .suggested-grid {
                grid-template-columns: 1fr;
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
            
            .promo-actions {
                flex-direction: column;
            }
            
            .btn-action {
                width: 100%;
            }
            
            .btn-deactivate,
            .btn-activate {
                flex: 1;
            }
            
            .modal-container {
                max-width: 100%;
                margin: 10px;
            }
            
            .form-row {
                grid-template-columns: 1fr;
                gap: 20px;
            }
            
            .discount-type-selector {
                grid-template-columns: 1fr;
            }
            
            .modal-header {
                padding: 20px 20px 15px;
            }
            
            .modal-body {
                padding: 20px;
            }
            
            .form-actions {
                flex-direction: column;
            }
            
            .analytics-modal .modal-container {
                max-width: 100%;
            }
            
            .analytics-grid {
                grid-template-columns: 1fr;
            }
            
            .confirmation-actions {
                flex-direction: column;
            }
            
            .confirmation-actions .btn {
                width: 100%;
            }
        }

        @media (max-width: 480px) {
            #promo-mgmt-wrapper {
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
            
            .promo-card,
            .suggested-card {
                padding: 20px;
            }
            
            .btn {
                padding: 8px 16px;
                font-size: 12px;
                min-height: 36px;
            }
            
            .modal-overlay {
                padding: 10px;
            }
            
            .modal-header h3 {
                font-size: 18px;
            }
        }
    </style>

    <div id="deleteConfirmationModal" class="modal-overlay confirmation-modal">
        <div class="modal-container">
            <div class="modal-body">
                <div class="confirmation-icon danger">
                    <i class="fas fa-exclamation-triangle"></i>
                </div>
                <h3 class="confirmation-title">Delete Promotion</h3>
                <p class="confirmation-message" id="deleteConfirmationMessage">
                    Are you sure you want to delete this promotion? This action cannot be undone.
                </p>
                <div class="confirmation-actions">
                    <button type="button" class="btn btn--outline" onclick="closeDeleteConfirmation()">
                        Cancel
                    </button>
                    <button type="button" class="btn btn--primary" onclick="confirmDeletePromo()" style="background: var(--danger-red); border-color: var(--danger-red);">
                        <i class="fas fa-trash me-2"></i>Delete
                    </button>
                </div>
            </div>
        </div>
    </div>

    <div id="statusConfirmationModal" class="modal-overlay confirmation-modal">
        <div class="modal-container">
            <div class="modal-body">
                <div class="confirmation-icon warning" id="statusConfirmationIcon">
                    <i class="fas fa-exclamation-triangle"></i>
                </div>
                <h3 class="confirmation-title" id="statusConfirmationTitle">Deactivate Promotion</h3>
                <p class="confirmation-message" id="statusConfirmationMessage">
                    Are you sure you want to deactivate this promotion?
                </p>
                <div class="confirmation-actions">
                    <button type="button" class="btn btn--outline" onclick="closeStatusConfirmation()">
                        Cancel
                    </button>
                    <button type="button" class="btn btn--primary" id="statusConfirmButton" onclick="confirmStatusChange()">
                        <i class="fas fa-power-off me-2"></i>Confirm
                    </button>
                </div>
            </div>
        </div>
    </div>

    <div id="addPromoModal" class="modal-overlay">
        <div class="modal-container">
            <div class="modal-loading" id="modalLoading">
                <div class="spinner"></div>
            </div>
            
            <div class="modal-header">
                <h3>Create New Promotion</h3>
                <button type="button" class="modal-close" onclick="closeAddPromoModal()">
                    <i class="fas fa-times"></i>
                </button>
            </div>
            
            <div class="modal-body">
                <form id="promoForm" onsubmit="return false;">
                    <div class="form-group">
                        <label class="form-label" for="promoName">Promotion Name *</label>
                        <input type="text" id="promoName" class="form-control" 
                               placeholder="e.g., Summer Sale 2024" maxlength="100">
                        <div class="error-message" id="nameError">Please enter a promotion name</div>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label" for="promoCode">Promo Code *</label>
                        <input type="text" id="promoCode" class="form-control" 
                               placeholder="e.g., SUMMER24" maxlength="20" style="text-transform: uppercase;">
                        <div class="error-message" id="codeError">Please enter a promo code</div>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Discount Type *</label>
                        <div class="discount-type-selector">
                            <div class="discount-option active" data-type="percentage" onclick="selectDiscountType('percentage')">
                                <i class="fas fa-percentage me-2"></i>Percentage
                            </div>
                            <div class="discount-option" data-type="fixed" onclick="selectDiscountType('fixed')">
                                <i class="fas fa-peso-sign me-2"></i>Fixed Amount
                            </div>
                            <div class="discount-option" data-type="free" onclick="selectDiscountType('free')">
                                <i class="fas fa-gift me-2"></i>Free Item
                            </div>
                            <div class="discount-option" data-type="bundle" onclick="selectDiscountType('bundle')">
                                <i class="fas fa-box me-2"></i>Bundle Deal
                            </div>
                        </div>
                    </div>
                    
                    <div class="form-group" id="discountValueGroup">
                        <label class="form-label" for="discountValue">Discount Value *</label>
                        <div class="discount-value-input">
                            <span id="discountPrefix">%</span>
                            <input type="number" id="discountValue" class="form-control" 
                                   placeholder="e.g., 20" min="0" max="100" step="0.01">
                        </div>
                        <div class="error-message" id="valueError">Please enter a valid discount value</div>
                    </div>
                    
                    <div class="form-group" id="freeItemGroup" style="display: none;">
                        <label class="form-label" for="freeItem">Free Item Description</label>
                        <input type="text" id="freeItem" class="form-control" 
                               placeholder="e.g., Free soft drink with any meal">
                    </div>
                    
                    <div class="form-group" id="bundleDetailsGroup" style="display: none;">
                        <label class="form-label" for="bundleDetails">Bundle Details</label>
                        <textarea id="bundleDetails" class="form-control" 
                                  placeholder="Describe the bundle items and conditions" rows="3"></textarea>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label" for="promoDescription">Description</label>
                        <textarea id="promoDescription" class="form-control" 
                                  placeholder="Describe the promotion details and conditions" rows="3"></textarea>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label" for="maxUses">Maximum Uses</label>
                            <input type="number" id="maxUses" class="form-control" 
                                   placeholder="e.g., 100" min="0">
                            <div class="error-message" id="usesError">Please enter a valid number</div>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label" for="targetAudience">Target Audience</label>
                            <select id="targetAudience" class="form-control">
                                <option value="all">All Customers</option>
                                <option value="new">New Customers Only</option>
                                <option value="returning">Returning Customers</option>
                                <option value="vip">VIP Customers</option>
                                <option value="first-time">First-time Users</option>
                            </select>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label" for="startDate">Start Date</label>
                            <div class="date-input-group">
                                <input type="date" id="startDate" class="form-control">
                                <i class="far fa-calendar"></i>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label" for="endDate">End Date *</label>
                            <div class="date-input-group">
                                <input type="date" id="endDate" class="form-control">
                                <i class="far fa-calendar"></i>
                            </div>
                            <div class="error-message" id="dateError">Please select an end date</div>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label" for="category">Category</label>
                        <select id="category" class="form-control">
                            <option value="general">General</option>
                            <option value="food">Food Items</option>
                            <option value="beverage">Beverages</option>
                            <option value="new-customers">New Customers</option>
                            <option value="returning">Returning Customers</option>
                            <option value="seasonal">Seasonal</option>
                            <option value="bundle">Bundle Deals</option>
                        </select>
                    </div>
                    
                    <div class="form-actions">
                        <button type="button" class="btn btn--outline" onclick="closeAddPromoModal()">
                            Cancel
                        </button>
                        <button type="submit" class="btn btn--primary" onclick="submitPromoForm()">
                            <i class="fas fa-save me-2"></i>Create Promotion
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <div id="editPromoModal" class="modal-overlay">
        <div class="modal-container">
            <div class="modal-loading" id="editModalLoading">
                <div class="spinner"></div>
            </div>
            
            <div class="modal-header">
                <h3>Edit Promotion</h3>
                <button type="button" class="modal-close" onclick="closeEditPromoModal()">
                    <i class="fas fa-times"></i>
                </button>
            </div>
            
            <div class="modal-body">
                <form id="editPromoForm" onsubmit="return false;">
                    <div class="form-group">
                        <label class="form-label" for="editPromoName">Promotion Name *</label>
                        <input type="text" id="editPromoName" class="form-control" 
                               placeholder="e.g., Summer Sale 2024" maxlength="100">
                        <div class="error-message" id="editNameError">Please enter a promotion name</div>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label" for="editPromoCode">Promo Code *</label>
                        <input type="text" id="editPromoCode" class="form-control" 
                               placeholder="e.g., SUMMER24" maxlength="20" style="text-transform: uppercase;">
                        <div class="error-message" id="editCodeError">Please enter a promo code</div>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Discount Type *</label>
                        <div class="discount-type-selector" id="editDiscountTypeSelector">
                            <div class="discount-option" data-type="percentage" onclick="selectEditDiscountType('percentage')">
                                <i class="fas fa-percentage me-2"></i>Percentage
                            </div>
                            <div class="discount-option" data-type="fixed" onclick="selectEditDiscountType('fixed')">
                                <i class="fas fa-peso-sign me-2"></i>Fixed Amount
                            </div>
                            <div class="discount-option" data-type="free" onclick="selectEditDiscountType('free')">
                                <i class="fas fa-gift me-2"></i>Free Item
                            </div>
                            <div class="discount-option" data-type="bundle" onclick="selectEditDiscountType('bundle')">
                                <i class="fas fa-box me-2"></i>Bundle Deal
                            </div>
                        </div>
                    </div>
                    
                    <div class="form-group" id="editDiscountValueGroup">
                        <label class="form-label" for="editDiscountValue">Discount Value *</label>
                        <div class="discount-value-input">
                            <span id="editDiscountPrefix">%</span>
                            <input type="number" id="editDiscountValue" class="form-control" 
                                   placeholder="e.g., 20" min="0" max="100" step="0.01">
                        </div>
                        <div class="error-message" id="editValueError">Please enter a valid discount value</div>
                    </div>
                    
                    <div class="form-group" id="editFreeItemGroup" style="display: none;">
                        <label class="form-label" for="editFreeItem">Free Item Description</label>
                        <input type="text" id="editFreeItem" class="form-control" 
                               placeholder="e.g., Free soft drink with any meal">
                    </div>
                    
                    <div class="form-group" id="editBundleDetailsGroup" style="display: none;">
                        <label class="form-label" for="editBundleDetails">Bundle Details</label>
                        <textarea id="editBundleDetails" class="form-control" 
                                  placeholder="Describe the bundle items and conditions" rows="3"></textarea>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label" for="editPromoDescription">Description</label>
                        <textarea id="editPromoDescription" class="form-control" 
                                  placeholder="Describe the promotion details and conditions" rows="3"></textarea>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label" for="editMaxUses">Maximum Uses</label>
                            <input type="number" id="editMaxUses" class="form-control" 
                                   placeholder="e.g., 100" min="0">
                            <div class="error-message" id="editUsesError">Please enter a valid number</div>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label" for="editTargetAudience">Target Audience</label>
                            <select id="editTargetAudience" class="form-control">
                                <option value="all">All Customers</option>
                                <option value="new">New Customers Only</option>
                                <option value="returning">Returning Customers</option>
                                <option value="vip">VIP Customers</option>
                                <option value="first-time">First-time Users</option>
                            </select>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label" for="editStartDate">Start Date</label>
                            <div class="date-input-group">
                                <input type="date" id="editStartDate" class="form-control">
                                <i class="far fa-calendar"></i>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label" for="editEndDate">End Date *</label>
                            <div class="date-input-group">
                                <input type="date" id="editEndDate" class="form-control">
                                <i class="far fa-calendar"></i>
                            </div>
                            <div class="error-message" id="editDateError">Please select an end date</div>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label" for="editCategory">Category</label>
                        <select id="editCategory" class="form-control">
                            <option value="general">General</option>
                            <option value="food">Food Items</option>
                            <option value="beverage">Beverages</option>
                            <option value="new-customers">New Customers</option>
                            <option value="returning">Returning Customers</option>
                            <option value="seasonal">Seasonal</option>
                            <option value="bundle">Bundle Deals</option>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label" for="editStatus">Status</label>
                        <select id="editStatus" class="form-control">
                            <option value="active">Active</option>
                            <option value="scheduled">Scheduled</option>
                            <option value="expired">Expired</option>
                        </select>
                    </div>
                    
                    <div class="form-actions">
                        <button type="button" class="btn btn--outline" onclick="closeEditPromoModal()">
                            Cancel
                        </button>
                        <button type="button" class="btn btn--outline" onclick="showDeleteConfirmation()" style="background: var(--danger-red); color: white; border-color: var(--danger-red);">
                            <i class="fas fa-trash me-2"></i>Delete
                        </button>
                        <button type="submit" class="btn btn--primary" onclick="submitEditPromoForm()">
                            <i class="fas fa-save me-2"></i>Save Changes
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <div id="analyticsModal" class="modal-overlay analytics-modal">
        <div class="modal-container">
            <div class="modal-header">
                <h3>Promotion Analytics</h3>
                <button type="button" class="modal-close" onclick="closeAnalyticsModal()">
                    <i class="fas fa-times"></i>
                </button>
            </div>
            
            <div class="modal-body">
                <div class="analytics-header">
                    <div>
                        <h4 id="analyticsPromoName" style="color: var(--primary-maroon); margin: 0 0 5px 0;">20% Off All Silog Meals</h4>
                        <div class="analytics-code" id="analyticsPromoCode">SILOG20</div>
                    </div>
                    <div class="analytics-status active" id="analyticsPromoStatus">Active</div>
                </div>
                
                <div class="valid-until">
                    <i class="far fa-calendar-alt"></i>
                    <span>Valid until: <span id="analyticsValidUntil">Nov 30, 2025</span></span>
                </div>
                
                <div class="analytics-grid">
                    <div class="analytics-card">
                        <h4>Total Uses</h4>
                        <div class="analytics-value" id="analyticsTotalUses">45</div>
                        <div class="analytics-label">Current Usage</div>
                    </div>
                    
                    <div class="analytics-card">
                        <h4>Max Uses</h4>
                        <div class="analytics-value" id="analyticsMaxUses">100</div>
                        <div class="analytics-label">Usage Limit</div>
                    </div>
                    
                    <div class="analytics-card">
                        <h4>Revenue Generated</h4>
                        <div class="analytics-value" id="analyticsRevenue">₱12,450</div>
                        <div class="analytics-label">Total Revenue</div>
                    </div>
                    
                    <div class="analytics-card">
                        <h4>Average Order</h4>
                        <div class="analytics-value" id="analyticsAvgOrder">₱278</div>
                        <div class="analytics-label">Per Transaction</div>
                    </div>
                </div>
                
                <div class="analytics-chart">
                    <div class="chart-header">
                        <div class="chart-title">Usage Over Time</div>
                        <select class="filter-select" style="font-size: 12px; padding: 6px 12px; height: 36px;">
                            <option>Last 7 days</option>
                            <option>Last 30 days</option>
                            <option>Last 90 days</option>
                        </select>
                    </div>
                    <div class="chart-placeholder">
                        <i class="fas fa-chart-line" style="font-size: 48px; margin-right: 10px; color: var(--primary-maroon);"></i>
                        <span>Usage chart visualization would appear here</span>
                    </div>
                </div>
                
                <div class="usage-timeline">
                    <h4 style="color: var(--primary-maroon); margin: 0 0 15px 0;">Recent Usage</h4>
                    <div class="timeline-item">
                        <div class="timeline-date">Today</div>
                        <div class="timeline-details">
                            <div class="timeline-usage">5 uses</div>
                            <div class="timeline-revenue">Generated ₱1,390</div>
                        </div>
                    </div>
                    <div class="timeline-item">
                        <div class="timeline-date">Yesterday</div>
                        <div class="timeline-details">
                            <div class="timeline-usage">8 uses</div>
                            <div class="timeline-revenue">Generated ₱2,224</div>
                        </div>
                    </div>
                    <div class="timeline-item">
                        <div class="timeline-date">Nov 25</div>
                        <div class="timeline-details">
                            <div class="timeline-usage">12 uses</div>
                            <div class="timeline-revenue">Generated ₱3,336</div>
                        </div>
                    </div>
                    <div class="timeline-item">
                        <div class="timeline-date">Nov 24</div>
                        <div class="timeline-details">
                            <div class="timeline-usage">7 uses</div>
                            <div class="timeline-revenue">Generated ₱1,946</div>
                        </div>
                    </div>
                    <div class="timeline-item">
                        <div class="timeline-date">Nov 23</div>
                        <div class="timeline-details">
                            <div class="timeline-usage">9 uses</div>
                            <div class="timeline-revenue">Generated ₱2,502</div>
                        </div>
                    </div>
                </div>
                
                <div class="form-actions" style="margin-top: 30px;">
                    <button type="button" class="btn btn--outline" onclick="closeAnalyticsModal()">
                        Close
                    </button>
                    <button type="button" class="btn btn--primary" onclick="exportAnalytics()">
                        <i class="fas fa-download me-2"></i>Export Report
                    </button>
                </div>
            </div>
        </div>
    </div>

    <div id="promo-mgmt-wrapper">
        <div class="page-header">
            <div class="header-title">
                <h2>Promotions & Campaigns</h2>
                <p>Manage promo codes and marketing campaigns</p>
            </div>
            <div class="header-actions">
                <button type="button" class="btn btn--secondary" onclick="showAddPromoModal()">
                    <i class="fas fa-plus"></i>
                    Create New Promotion
                </button>
            </div>
        </div>

        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-card__header">
                    <span class="stat-card__label">Active Promos</span>
                    <div class="stat-card__icon stat-card__icon--active">
                        <i class="fas fa-bullhorn"></i>
                    </div>
                </div>
                <div class="stat-card__value" id="totalActive">0</div>
                <div class="stat-card__trend">All active promotions</div>
            </div>

            <div class="stat-card">
                <div class="stat-card__header">
                    <span class="stat-card__label">Total Uses</span>
                    <div class="stat-card__icon stat-card__icon--uses">
                        <i class="fas fa-users"></i>
                    </div>
                </div>
                <div class="stat-card__value" id="totalUses">0</div>
                <div class="stat-card__trend">Overall usage count</div>
            </div>

            <div class="stat-card">
                <div class="stat-card__header">
                    <span class="stat-card__label">Revenue Generated</span>
                    <div class="stat-card__icon stat-card__icon--revenue">
                        <i class="fas fa-peso-sign"></i>
                    </div>
                </div>
                <div class="stat-card__value" id="totalRevenue">₱0</div>
                <div class="stat-card__trend">From all promotions</div>
            </div>

            <div class="stat-card">
                <div class="stat-card__header">
                    <span class="stat-card__label">Expiring Soon</span>
                    <div class="stat-card__icon stat-card__icon--expiring">
                        <i class="fas fa-clock"></i>
                    </div>
                </div>
                <div class="stat-card__value" id="expiringSoon">0</div>
                <div class="stat-card__trend">Within 7 days</div>
            </div>
        </div>

        <div class="filter-container">
            <div class="inner-search" id="searchBox">
                <i class="fas fa-search"></i>
                <input type="text" id="searchInput" placeholder="Search by promo code, name, or description..." onkeyup="handleSearch()">
                <div id="searchCount" class="filter-count" style="display: none;">0</div>
            </div>
            <select class="filter-select" id="statusFilter" onchange="handleFilter()">
                <option value="all">All Status</option>
                <option value="active">Active</option>
                <option value="expired">Expired</option>
                <option value="scheduled">Scheduled</option>
            </select>
            <select class="filter-select" id="typeFilter" onchange="handleFilter()">
                <option value="all">All Types</option>
                <option value="percentage">Percentage Discount</option>
                <option value="fixed">Fixed Amount</option>
                <option value="free">Free Item</option>
                <option value="bundle">Bundle Deal</option>
            </select>
            <select class="filter-select" id="categoryFilter" onchange="handleFilter()">
                <option value="all">All Categories</option>
                <option value="food">Food Items</option>
                <option value="beverage">Beverages</option>
                <option value="new-customers">New Customers</option>
                <option value="returning">Returning Customers</option>
                <option value="seasonal">Seasonal</option>
            </select>
            <select class="filter-select" id="sortFilter" onchange="handleSort()">
                <option value="date-desc">Sort by: Newest</option>
                <option value="date-asc">Sort by: Oldest</option>
                <option value="uses-desc">Sort by: Most Used</option>
                <option value="uses-asc">Sort by: Least Used</option>
                <option value="revenue-desc">Sort by: Highest Revenue</option>
                <option value="revenue-asc">Sort by: Lowest Revenue</option>
                <option value="expiry-desc">Sort by: Expiring Soon</option>
                <option value="expiry-asc">Sort by: Expiring Last</option>
            </select>
        </div>

        <div id="activeFiltersContainer" class="active-filters" style="display: none;">
            <div id="activeFilters"></div>
            <button type="button" class="clear-filters" onclick="clearAllFilters()">
                <i class="fas fa-times"></i> Clear All
            </button>
        </div>

        <h3 class="section-title">
            Active Promotions 
            <span id="promoCount" class="filter-count">0</span>
        </h3>
        <div id="promoGrid" class="promo-grid">
        </div>

        <div class="no-results" id="noResultsMessage">
            <i class="fas fa-tag"></i>
            <h3>No promotions found</h3>
            <p>Try creating a new promotion or adjust your filters</p>
        </div>

        <h3 class="section-title">Suggested Campaign Ideas</h3>
        <div class="suggested-grid">
            <div class="suggested-card">
                <h4>Silog Saturday Special</h4>
                <p class="small text-muted">Weekly promotion for all Silog meals every Saturday</p>
                <div class="d-flex gap-4 mt-3" style="display: flex; gap: 20px; margin: 15px 0;">
                    <div><span class="stat-label">Suggested Discount</span><div class="discount-box" style="font-size: 20px; padding: 8px 16px;">25%</div></div>
                    <div><span class="stat-label">Target Audience</span><div class="stat-value mt-1">All customers</div></div>
                </div>
                <button type="button" class="btn-create-campaign" onclick="createSuggestedCampaign('silog-saturday')">
                    <i class="fas fa-plus me-2"></i>Create Campaign
                </button>
            </div>
            <div class="suggested-card">
                <h4>Sizzling Weekday Deals</h4>
                <p class="small text-muted">Monday to Friday exclusive deals on sizzling plates</p>
                <div class="d-flex gap-4 mt-3" style="display: flex; gap: 20px; margin: 15px 0;">
                    <div><span class="stat-label">Suggested Discount</span><div class="discount-box" style="font-size: 20px; padding: 8px 16px;">₱100 off</div></div>
                    <div><span class="stat-label">Target Audience</span><div class="stat-value mt-1">Returning customers</div></div>
                </div>
                <button type="button" class="btn-create-campaign" onclick="createSuggestedCampaign('sizzling-weekday')">
                    <i class="fas fa-plus me-2"></i>Create Campaign
                </button>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        let promoCodesData = [
            {
                id: "001",
                code: "SILOG20",
                name: "20% Off All Silog Meals",
                description: "Get 20% discount on all silog meal orders",
                discountType: "percentage",
                discountValue: 20,
                status: "active",
                currentUses: 45,
                maxUses: 100,
                revenue: 12450,
                avgOrder: 278,
                validUntil: "2025-11-30",
                createdDate: "2025-01-15",
                category: "food",
                targetAudience: "All customers",
                usagePercentage: 45
            },
            {
                id: "002",
                code: "SIZZLE50",
                name: "₱50 Off Sizzling Plates",
                description: "Fixed ₱50 discount on sizzling plate orders above ₱300",
                discountType: "fixed",
                discountValue: 50,
                status: "active",
                currentUses: 78,
                maxUses: 150,
                revenue: 18920,
                avgOrder: 243,
                validUntil: "2025-11-28",
                createdDate: "2025-02-10",
                category: "food",
                targetAudience: "All customers",
                usagePercentage: 52
            },
            {
                id: "003",
                code: "WELCOME10",
                name: "Welcome Discount",
                description: "10% off for new customers",
                discountType: "percentage",
                discountValue: 10,
                status: "active",
                currentUses: 120,
                maxUses: 500,
                revenue: 15800,
                avgOrder: 132,
                validUntil: "2025-12-31",
                createdDate: "2025-03-01",
                category: "new-customers",
                targetAudience: "New customers only",
                usagePercentage: 24
            },
            {
                id: "004",
                code: "FREEDRINK",
                name: "Free Drink with Meal",
                description: "Free soft drink with any meal purchase",
                discountType: "free",
                discountValue: 0,
                status: "expired",
                currentUses: 89,
                maxUses: 200,
                revenue: 21300,
                avgOrder: 239,
                validUntil: "2025-10-15",
                createdDate: "2025-04-05",
                category: "beverage",
                targetAudience: "All customers",
                usagePercentage: 44.5
            },
            {
                id: "005",
                code: "COMBO30",
                name: "30% Off Combos",
                description: "Special discount on combo meals",
                discountType: "percentage",
                discountValue: 30,
                status: "scheduled",
                currentUses: 0,
                maxUses: 200,
                revenue: 0,
                avgOrder: 0,
                validUntil: "2025-12-25",
                createdDate: "2025-11-01",
                category: "food",
                targetAudience: "All customers",
                usagePercentage: 0
            },
            {
                id: "006",
                code: "BREAKFAST25",
                name: "25% Off Breakfast Sets",
                description: "Morning special discount",
                discountType: "percentage",
                discountValue: 25,
                status: "active",
                currentUses: 32,
                maxUses: 100,
                revenue: 8600,
                avgOrder: 269,
                validUntil: "2025-11-25",
                createdDate: "2025-10-01",
                category: "food",
                targetAudience: "Early birds",
                usagePercentage: 32
            },
            {
                id: "007",
                code: "FAMILY100",
                name: "₱100 Family Bundle",
                description: "Discount on family-sized orders",
                discountType: "fixed",
                discountValue: 100,
                status: "active",
                currentUses: 15,
                maxUses: 50,
                revenue: 7500,
                avgOrder: 500,
                validUntil: "2025-12-15",
                createdDate: "2025-09-15",
                category: "bundle",
                targetAudience: "Family orders",
                usagePercentage: 30
            },
            {
                id: "008",
                code: "RETURN15",
                name: "15% Returning Customer",
                description: "Special discount for returning customers",
                discountType: "percentage",
                discountValue: 15,
                status: "expired",
                currentUses: 210,
                maxUses: 300,
                revenue: 31500,
                avgOrder: 150,
                validUntil: "2025-10-31",
                createdDate: "2025-05-01",
                category: "returning",
                targetAudience: "Returning customers",
                usagePercentage: 70
            }
        ];

        let allPromos = [];
        let currentPromoId = null;
        let editingPromoId = null;
        let viewingAnalyticsPromoId = null;
        let statusChangePromoId = null;
        let statusChangeAction = null;
        let currentFilters = {
            searchTerm: '',
            status: 'all',
            type: 'all',
            category: 'all',
            sortBy: 'date-desc'
        };

        function initializePromoTable() {
            const grid = document.getElementById('promoGrid');
            grid.innerHTML = '';

            promoCodesData.forEach(promo => {
                const promoCard = createPromoCard(promo);
                grid.appendChild(promoCard);
            });

            initializePromoData();
            applyFilters();
        }

        function createPromoCard(promo) {
            const card = document.createElement('div');
            card.className = 'promo-card';
            card.setAttribute('data-promo-id', promo.id);
            card.setAttribute('data-status', promo.status);
            card.setAttribute('data-type', promo.discountType);
            card.setAttribute('data-category', promo.category);
            card.setAttribute('data-uses', promo.currentUses);
            card.setAttribute('data-revenue', promo.revenue);
            card.setAttribute('data-date', promo.createdDate);
            card.setAttribute('data-expiry', promo.validUntil);
            card.setAttribute('data-code', promo.code.toLowerCase());
            card.setAttribute('data-name', promo.name.toLowerCase());
            card.setAttribute('data-description', promo.description.toLowerCase());

            const usagePercentage = (promo.currentUses / promo.maxUses) * 100;
            const discountDisplay = promo.discountType === 'percentage'
                ? `${promo.discountValue}%`
                : promo.discountType === 'fixed'
                    ? `₱${promo.discountValue}`
                    : promo.discountType === 'free'
                        ? 'Free Item'
                        : 'Bundle Deal';

            const statusClass = promo.status;
            const statusText = promo.status.charAt(0).toUpperCase() + promo.status.slice(1);

            const actionButton = promo.status === 'active'
                ? `<button type="button" class="btn-action btn-deactivate" onclick="showStatusConfirmation('${promo.id}', 'deactivate')">Deactivate</button>`
                : promo.status === 'expired'
                    ? `<button type="button" class="btn-action btn-activate" onclick="showStatusConfirmation('${promo.id}', 'activate')">Reactivate</button>`
                    : `<button type="button" class="btn-action btn-deactivate" onclick="showStatusConfirmation('${promo.id}', 'cancel')">Cancel</button>`;

            card.innerHTML = `
                <div class="promo-badge-header">
                    <span class="code-pill">${promo.code}</span>
                    <span class="status-pill ${statusClass}">${statusText}</span>
                    <i class="far fa-copy ms-auto" title="Copy Code" onclick="copyPromoCode('${promo.code}')"></i>
                </div>
                <b>${promo.name}</b>
                <p class="small text-muted mb-2">${promo.description}</p>
                <div class="discount-box">${discountDisplay}</div>
                <div class="promo-stats-bar">
                    <div class="stat-group" style="flex: 1.5;">
                        <span class="stat-label">Usage</span>
                        <span class="stat-value">${promo.currentUses}/${promo.maxUses}</span>
                        <div class="progress-line"><div class="progress-fill ${statusClass}" style="width: ${usagePercentage}%;"></div></div>
                    </div>
                    <div class="stat-group">
                        <span class="stat-label">Revenue</span>
                        <span class="stat-value">₱${promo.revenue.toLocaleString()}</span>
                    </div>
                    <div class="stat-group">
                        <span class="stat-label">Avg Order</span>
                        <span class="stat-value">₱${promo.avgOrder}</span>
                    </div>
                </div>
                <div class="valid-until">
                    <i class="far fa-calendar-alt"></i>
                    <span>Valid until ${formatDate(promo.validUntil)}</span>
                </div>
                <div class="promo-actions">
                    <button type="button" class="btn-action btn-edit" onclick="editPromo('${promo.id}')">
                        <i class="far fa-edit me-1"></i> Edit
                    </button>
                    <button type="button" class="btn-action btn-view" onclick="viewPromoAnalytics('${promo.id}')">
                        View Analytics
                    </button>
                    ${actionButton}
                </div>
            `;

            return card;
        }

        function initializePromoData() {
            const cards = document.querySelectorAll('.promo-card');
            allPromos = [];

            cards.forEach(card => {
                const id = card.getAttribute('data-promo-id');
                const promo = promoCodesData.find(p => p.id === id);

                if (promo) {
                    allPromos.push({
                        element: card,
                        id: id,
                        code: promo.code,
                        name: promo.name,
                        description: promo.description,
                        discountType: promo.discountType,
                        discountValue: promo.discountValue,
                        status: promo.status,
                        currentUses: promo.currentUses,
                        maxUses: promo.maxUses,
                        revenue: promo.revenue,
                        avgOrder: promo.avgOrder,
                        validUntil: promo.validUntil,
                        createdDate: promo.createdDate,
                        category: promo.category,
                        targetAudience: promo.targetAudience,
                        usagePercentage: promo.usagePercentage
                    });
                }
            });
        }

        function handleSearch() {
            const searchInput = document.getElementById('searchInput');
            const searchTerm = searchInput.value.toLowerCase().trim();
            currentFilters.searchTerm = searchTerm;

            const searchBox = document.getElementById('searchBox');
            searchBox.classList.add('loading');

            setTimeout(() => {
                applyFilters();
                updateFilterDisplay();
                searchBox.classList.remove('loading');
            }, 300);
        }

        function handleFilter() {
            const statusFilter = document.getElementById('statusFilter');
            const typeFilter = document.getElementById('typeFilter');
            const categoryFilter = document.getElementById('categoryFilter');

            currentFilters.status = statusFilter.value;
            currentFilters.type = typeFilter.value;
            currentFilters.category = categoryFilter.value;

            applyFilters();
            updateFilterDisplay();
        }

        function handleSort() {
            const sortFilter = document.getElementById('sortFilter');
            currentFilters.sortBy = sortFilter.value;

            applyFilters();
        }

        function applyFilters() {
            let visiblePromos = allPromos.filter(promo => {
                if (currentFilters.searchTerm) {
                    const searchMatch =
                        promo.code.toLowerCase().includes(currentFilters.searchTerm) ||
                        promo.name.toLowerCase().includes(currentFilters.searchTerm) ||
                        promo.description.toLowerCase().includes(currentFilters.searchTerm);
                    if (!searchMatch) return false;
                }

                if (currentFilters.status !== 'all' && promo.status !== currentFilters.status) {
                    return false;
                }

                if (currentFilters.type !== 'all' && promo.discountType !== currentFilters.type) {
                    return false;
                }

                if (currentFilters.category !== 'all' && promo.category !== currentFilters.category) {
                    return false;
                }

                return true;
            });

            visiblePromos.sort((a, b) => {
                switch (currentFilters.sortBy) {
                    case 'date-desc':
                        return new Date(b.createdDate) - new Date(a.createdDate);
                    case 'date-asc':
                        return new Date(a.createdDate) - new Date(b.createdDate);
                    case 'uses-desc':
                        return b.currentUses - a.currentUses;
                    case 'uses-asc':
                        return a.currentUses - b.currentUses;
                    case 'revenue-desc':
                        return b.revenue - a.revenue;
                    case 'revenue-asc':
                        return a.revenue - b.revenue;
                    case 'expiry-desc':
                        return new Date(a.validUntil) - new Date(b.validUntil);
                    case 'expiry-asc':
                        return new Date(b.validUntil) - new Date(a.validUntil);
                    default:
                        return 0;
                }
            });

            allPromos.forEach(promo => {
                promo.element.style.display = 'none';
            });

            visiblePromos.forEach((promo, index) => {
                promo.element.style.display = '';
                promo.element.style.animation = `fadeIn 0.3s ease ${index * 0.05}s`;
            });

            const noResultsMessage = document.getElementById('noResultsMessage');
            if (visiblePromos.length === 0) {
                noResultsMessage.style.display = 'block';
            } else {
                noResultsMessage.style.display = 'none';
            }

            document.getElementById('promoCount').textContent = visiblePromos.length;
            document.getElementById('promoCount').style.display = visiblePromos.length > 0 ? 'inline-block' : 'none';

            updateStats(visiblePromos);
        }

        function updateFilterDisplay() {
            const activeFiltersContainer = document.getElementById('activeFiltersContainer');
            const activeFiltersDiv = document.getElementById('activeFilters');
            activeFiltersDiv.innerHTML = '';

            const filters = [];

            if (currentFilters.searchTerm) {
                filters.push({
                    type: 'search',
                    label: `Search: "${currentFilters.searchTerm}"`,
                    value: currentFilters.searchTerm
                });
            }

            if (currentFilters.status !== 'all') {
                filters.push({
                    type: 'status',
                    label: `Status: ${currentFilters.status.charAt(0).toUpperCase() + currentFilters.status.slice(1)}`,
                    value: currentFilters.status
                });
            }

            if (currentFilters.type !== 'all') {
                filters.push({
                    type: 'type',
                    label: `Type: ${currentFilters.type.charAt(0).toUpperCase() + currentFilters.type.slice(1)}`,
                    value: currentFilters.type
                });
            }

            if (currentFilters.category !== 'all') {
                filters.push({
                    type: 'category',
                    label: `Category: ${currentFilters.category.charAt(0).toUpperCase() + currentFilters.category.slice(1)}`,
                    value: currentFilters.category
                });
            }

            filters.forEach(filter => {
                const filterTag = document.createElement('div');
                filterTag.className = 'filter-tag';
                filterTag.innerHTML = `
                    ${filter.label}
                    <span class="remove-filter" onclick="removeFilter('${filter.type}')">
                        <i class="fas fa-times"></i>
                    </span>
                `;
                activeFiltersDiv.appendChild(filterTag);
            });

            if (filters.length > 0) {
                activeFiltersContainer.style.display = 'flex';
            } else {
                activeFiltersContainer.style.display = 'none';
            }
        }

        function removeFilter(filterType) {
            switch (filterType) {
                case 'search':
                    currentFilters.searchTerm = '';
                    document.getElementById('searchInput').value = '';
                    break;
                case 'status':
                    currentFilters.status = 'all';
                    document.getElementById('statusFilter').value = 'all';
                    break;
                case 'type':
                    currentFilters.type = 'all';
                    document.getElementById('typeFilter').value = 'all';
                    break;
                case 'category':
                    currentFilters.category = 'all';
                    document.getElementById('categoryFilter').value = 'all';
                    break;
            }

            applyFilters();
            updateFilterDisplay();
        }

        function clearAllFilters() {
            currentFilters = {
                searchTerm: '',
                status: 'all',
                type: 'all',
                category: 'all',
                sortBy: 'date-desc'
            };

            document.getElementById('searchInput').value = '';
            document.getElementById('statusFilter').value = 'all';
            document.getElementById('typeFilter').value = 'all';
            document.getElementById('categoryFilter').value = 'all';
            document.getElementById('sortFilter').value = 'date-desc';

            applyFilters();
            updateFilterDisplay();
        }

        function updateStats(visiblePromos = allPromos) {
            const activePromos = visiblePromos.filter(p => p.status === 'active').length;
            const totalUses = visiblePromos.reduce((sum, promo) => sum + promo.currentUses, 0);
            const totalRevenue = visiblePromos.reduce((sum, promo) => sum + promo.revenue, 0);

            const today = new Date();
            const expiringSoon = visiblePromos.filter(promo => {
                if (promo.status !== 'active') return false;
                const validUntil = new Date(promo.validUntil);
                const diffTime = validUntil - today;
                const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
                return diffDays <= 7 && diffDays >= 0;
            }).length;

            document.getElementById('totalActive').textContent = activePromos;
            document.getElementById('totalUses').textContent = totalUses.toLocaleString();

            if (totalRevenue >= 1000000) {
                document.getElementById('totalRevenue').textContent = `₱${(totalRevenue / 1000000).toFixed(1)}M`;
            } else if (totalRevenue >= 1000) {
                document.getElementById('totalRevenue').textContent = `₱${(totalRevenue / 1000).toFixed(0)}K`;
            } else {
                document.getElementById('totalRevenue').textContent = `₱${totalRevenue}`;
            }

            document.getElementById('expiringSoon').textContent = expiringSoon;
        }

        function formatDate(dateString) {
            const date = new Date(dateString);
            return date.toLocaleDateString('en-US', {
                month: 'short',
                day: 'numeric',
                year: 'numeric'
            });
        }

        function copyPromoCode(code) {
            navigator.clipboard.writeText(code).then(() => {
                showNotification(`Copied: ${code}`, 'success');
            }).catch(err => {
                console.error('Failed to copy: ', err);
                showNotification('Failed to copy code', 'error');
            });
        }

        function editPromo(promoId) {
            editingPromoId = promoId;
            const promo = promoCodesData.find(p => p.id === promoId);

            if (!promo) {
                showNotification('Promotion not found!', 'error');
                return;
            }

            showEditPromoModal(promo);
        }

        function showEditPromoModal(promo) {
            const modal = document.getElementById('editPromoModal');
            modal.classList.add('active');
            document.body.style.overflow = 'hidden';

            document.getElementById('editPromoName').value = promo.name;
            document.getElementById('editPromoCode').value = promo.code;
            document.getElementById('editPromoDescription').value = promo.description;
            document.getElementById('editMaxUses').value = promo.maxUses;
            document.getElementById('editTargetAudience').value = promo.targetAudience;
            document.getElementById('editStartDate').value = promo.createdDate;
            document.getElementById('editEndDate').value = promo.validUntil;
            document.getElementById('editCategory').value = promo.category;
            document.getElementById('editStatus').value = promo.status;

            selectEditDiscountType(promo.discountType);

            if (promo.discountType === 'percentage' || promo.discountType === 'fixed') {
                document.getElementById('editDiscountValue').value = promo.discountValue;
            } else if (promo.discountType === 'free') {
                document.getElementById('editFreeItem').value = promo.description;
            } else if (promo.discountType === 'bundle') {
                document.getElementById('editBundleDetails').value = promo.description;
            }

            setTimeout(() => {
                document.getElementById('editPromoName').focus();
            }, 300);
        }

        function selectEditDiscountType(type) {
            document.querySelectorAll('#editDiscountTypeSelector .discount-option').forEach(option => {
                option.classList.remove('active');
            });

            const targetOption = document.querySelector(`#editDiscountTypeSelector .discount-option[data-type="${type}"]`);
            if (targetOption) {
                targetOption.classList.add('active');
            }

            const discountPrefix = document.getElementById('editDiscountPrefix');
            const discountValueInput = document.getElementById('editDiscountValue');

            switch (type) {
                case 'percentage':
                    discountPrefix.textContent = '%';
                    discountValueInput.placeholder = 'e.g., 20';
                    discountValueInput.min = '0';
                    discountValueInput.max = '100';
                    document.getElementById('editDiscountValueGroup').style.display = 'block';
                    document.getElementById('editFreeItemGroup').style.display = 'none';
                    document.getElementById('editBundleDetailsGroup').style.display = 'none';
                    break;

                case 'fixed':
                    discountPrefix.textContent = '₱';
                    discountValueInput.placeholder = 'e.g., 100';
                    discountValueInput.min = '0';
                    discountValueInput.max = '10000';
                    document.getElementById('editDiscountValueGroup').style.display = 'block';
                    document.getElementById('editFreeItemGroup').style.display = 'none';
                    document.getElementById('editBundleDetailsGroup').style.display = 'none';
                    break;

                case 'free':
                    document.getElementById('editDiscountValueGroup').style.display = 'none';
                    document.getElementById('editFreeItemGroup').style.display = 'block';
                    document.getElementById('editBundleDetailsGroup').style.display = 'none';
                    break;

                case 'bundle':
                    document.getElementById('editDiscountValueGroup').style.display = 'none';
                    document.getElementById('editFreeItemGroup').style.display = 'none';
                    document.getElementById('editBundleDetailsGroup').style.display = 'block';
                    break;
            }
        }

        function showDeleteConfirmation() {
            const promo = promoCodesData.find(p => p.id === editingPromoId);
            if (!promo) {
                showNotification('Promotion not found!', 'error');
                return;
            }

            closeEditPromoModal();

            setTimeout(() => {
                document.getElementById('deleteConfirmationMessage').textContent =
                    `Are you sure you want to delete "${promo.code} - ${promo.name}"? This action cannot be undone.`;

                const modal = document.getElementById('deleteConfirmationModal');
                modal.classList.add('active');
                document.body.style.overflow = 'hidden';
            }, 300);
        }

        function closeDeleteConfirmation() {
            const modal = document.getElementById('deleteConfirmationModal');
            modal.classList.remove('active');
            document.body.style.overflow = 'auto';
        }

        function confirmDeletePromo() {
            if (!editingPromoId) {
                showNotification('Promotion not found!', 'error');
                closeDeleteConfirmation();
                return;
            }

            closeDeleteConfirmation();

            const promoIndex = promoCodesData.findIndex(p => p.id === editingPromoId);
            if (promoIndex === -1) {
                showNotification('Promotion not found!', 'error');
                return;
            }

            const promoCode = promoCodesData[promoIndex].code;

            promoCodesData.splice(promoIndex, 1);

            initializePromoTable();

            showNotification(`Promotion "${promoCode}" deleted successfully!`, 'success');

            editingPromoId = null;
        }

        function showStatusConfirmation(promoId, action) {
            statusChangePromoId = promoId;
            statusChangeAction = action;

            const promo = promoCodesData.find(p => p.id === promoId);
            if (!promo) {
                showNotification('Promotion not found!', 'error');
                return;
            }

            const modal = document.getElementById('statusConfirmationModal');
            const icon = document.getElementById('statusConfirmationIcon');
            const title = document.getElementById('statusConfirmationTitle');
            const message = document.getElementById('statusConfirmationMessage');
            const confirmButton = document.getElementById('statusConfirmButton');

            if (action === 'deactivate') {
                icon.className = 'confirmation-icon warning';
                icon.innerHTML = '<i class="fas fa-exclamation-triangle"></i>';
                title.textContent = 'Deactivate Promotion';
                message.textContent = `Are you sure you want to deactivate "${promo.code} - ${promo.name}"?`;
                confirmButton.innerHTML = '<i class="fas fa-power-off me-2"></i>Deactivate';
                confirmButton.style.background = 'var(--warning-orange)';
                confirmButton.style.borderColor = 'var(--warning-orange)';
            } else if (action === 'activate') {
                icon.className = 'confirmation-icon success';
                icon.innerHTML = '<i class="fas fa-check-circle"></i>';
                title.textContent = 'Activate Promotion';
                message.textContent = `Are you sure you want to activate "${promo.code} - ${promo.name}"?`;
                confirmButton.innerHTML = '<i class="fas fa-power-off me-2"></i>Activate';
                confirmButton.style.background = 'var(--success-green)';
                confirmButton.style.borderColor = 'var(--success-green)';
            } else if (action === 'cancel') {
                icon.className = 'confirmation-icon danger';
                icon.innerHTML = '<i class="fas fa-times-circle"></i>';
                title.textContent = 'Cancel Promotion';
                message.textContent = `Are you sure you want to cancel "${promo.code} - ${promo.name}"?`;
                confirmButton.innerHTML = '<i class="fas fa-ban me-2"></i>Cancel';
                confirmButton.style.background = 'var(--danger-red)';
                confirmButton.style.borderColor = 'var(--danger-red)';
            }

            modal.classList.add('active');
            document.body.style.overflow = 'hidden';
        }

        function closeStatusConfirmation() {
            const modal = document.getElementById('statusConfirmationModal');
            modal.classList.remove('active');
            document.body.style.overflow = 'auto';
            statusChangePromoId = null;
            statusChangeAction = null;
        }

        function confirmStatusChange() {
            if (!statusChangePromoId || !statusChangeAction) {
                showNotification('Invalid action!', 'error');
                closeStatusConfirmation();
                return;
            }

            const promo = promoCodesData.find(p => p.id === statusChangePromoId);
            if (!promo) {
                showNotification('Promotion not found!', 'error');
                closeStatusConfirmation();
                return;
            }

            let newStatus = '';
            let actionText = '';

            if (statusChangeAction === 'deactivate') {
                newStatus = 'expired';
                actionText = 'deactivated';
            } else if (statusChangeAction === 'activate') {
                newStatus = 'active';
                actionText = 'activated';
            } else if (statusChangeAction === 'cancel') {
                newStatus = 'cancelled';
                actionText = 'cancelled';
            }

            promo.status = newStatus;

            closeStatusConfirmation();

            initializePromoTable();

            showNotification(`Promotion "${promo.code}" ${actionText} successfully!`, 'success');
        }

        function closeEditPromoModal() {
            const modal = document.getElementById('editPromoModal');
            modal.classList.remove('active');
            document.body.style.overflow = 'auto';

            resetEditPromoForm();
            editingPromoId = null;
        }

        function resetEditPromoForm() {
            document.getElementById('editPromoForm').reset();
            document.querySelectorAll('#editPromoForm .error-message').forEach(error => {
                error.classList.remove('show');
            });
            document.querySelectorAll('#editPromoForm .form-control').forEach(input => {
                input.classList.remove('error');
            });
        }

        function viewPromoAnalytics(promoId) {
            viewingAnalyticsPromoId = promoId;
            const promo = promoCodesData.find(p => p.id === promoId);

            if (!promo) {
                showNotification('Promotion not found!', 'error');
                return;
            }

            showAnalyticsModal(promo);
        }

        function showAnalyticsModal(promo) {
            const modal = document.getElementById('analyticsModal');
            modal.classList.add('active');
            document.body.style.overflow = 'hidden';

            document.getElementById('analyticsPromoName').textContent = promo.name;
            document.getElementById('analyticsPromoCode').textContent = promo.code;
            document.getElementById('analyticsValidUntil').textContent = formatDate(promo.validUntil);
            document.getElementById('analyticsTotalUses').textContent = promo.currentUses;
            document.getElementById('analyticsMaxUses').textContent = promo.maxUses;
            document.getElementById('analyticsRevenue').textContent = `₱${promo.revenue.toLocaleString()}`;
            document.getElementById('analyticsAvgOrder').textContent = `₱${promo.avgOrder}`;

            const statusElement = document.getElementById('analyticsPromoStatus');
            statusElement.textContent = promo.status.charAt(0).toUpperCase() + promo.status.slice(1);
            statusElement.className = 'analytics-status ' + promo.status;
        }

        function closeAnalyticsModal() {
            const modal = document.getElementById('analyticsModal');
            modal.classList.remove('active');
            document.body.style.overflow = 'auto';
            viewingAnalyticsPromoId = null;
        }

        function exportAnalytics() {
            const promo = promoCodesData.find(p => p.id === viewingAnalyticsPromoId);
            if (promo) {
                showNotification(`Exporting analytics for ${promo.code}...`, 'success');
            }
        }

        function validateEditForm() {
            let isValid = true;

            document.querySelectorAll('#editPromoForm .error-message').forEach(error => {
                error.classList.remove('show');
            });
            document.querySelectorAll('#editPromoForm .form-control').forEach(input => {
                input.classList.remove('error');
            });

            const promoName = document.getElementById('editPromoName').value.trim();
            if (!promoName) {
                document.getElementById('editNameError').classList.add('show');
                document.getElementById('editPromoName').classList.add('error');
                isValid = false;
            }

            const promoCode = document.getElementById('editPromoCode').value.trim().toUpperCase();
            if (!promoCode) {
                document.getElementById('editCodeError').classList.add('show');
                document.getElementById('editPromoCode').classList.add('error');
                isValid = false;
            }

            const currentPromo = promoCodesData.find(p => p.id === editingPromoId);
            if (promoCodesData.some(promo => promo.code === promoCode && promo.id !== editingPromoId)) {
                document.getElementById('editCodeError').textContent = 'Promo code already exists';
                document.getElementById('editCodeError').classList.add('show');
                document.getElementById('editPromoCode').classList.add('error');
                isValid = false;
            }

            const discountType = document.querySelector('#editDiscountTypeSelector .discount-option.active').getAttribute('data-type');
            if (discountType === 'percentage' || discountType === 'fixed') {
                const discountValue = document.getElementById('editDiscountValue').value;
                if (!discountValue || parseFloat(discountValue) <= 0) {
                    document.getElementById('editValueError').classList.add('show');
                    document.getElementById('editDiscountValue').classList.add('error');
                    isValid = false;
                }
            }

            const endDate = document.getElementById('editEndDate').value;
            if (!endDate) {
                document.getElementById('editDateError').classList.add('show');
                document.getElementById('editEndDate').classList.add('error');
                isValid = false;
            }

            const maxUses = document.getElementById('editMaxUses').value;
            if (maxUses && parseInt(maxUses) < 0) {
                document.getElementById('editUsesError').classList.add('show');
                document.getElementById('editMaxUses').classList.add('error');
                isValid = false;
            }

            return isValid;
        }

        function submitEditPromoForm() {
            if (!validateEditForm()) {
                return;
            }

            document.getElementById('editModalLoading').classList.add('active');

            setTimeout(() => {
                const promoIndex = promoCodesData.findIndex(p => p.id === editingPromoId);
                if (promoIndex === -1) {
                    showNotification('Promotion not found!', 'error');
                    document.getElementById('editModalLoading').classList.remove('active');
                    return;
                }

                const discountType = document.querySelector('#editDiscountTypeSelector .discount-option.active').getAttribute('data-type');

                promoCodesData[promoIndex] = {
                    ...promoCodesData[promoIndex],
                    code: document.getElementById('editPromoCode').value.trim().toUpperCase(),
                    name: document.getElementById('editPromoName').value.trim(),
                    description: document.getElementById('editPromoDescription').value.trim(),
                    discountType: discountType,
                    discountValue: discountType === 'percentage' || discountType === 'fixed'
                        ? parseFloat(document.getElementById('editDiscountValue').value)
                        : 0,
                    status: document.getElementById('editStatus').value,
                    maxUses: document.getElementById('editMaxUses').value
                        ? parseInt(document.getElementById('editMaxUses').value)
                        : promoCodesData[promoIndex].maxUses,
                    validUntil: document.getElementById('editEndDate').value,
                    category: document.getElementById('editCategory').value,
                    targetAudience: document.getElementById('editTargetAudience').value
                };

                initializePromoTable();

                document.getElementById('editModalLoading').classList.remove('active');

                closeEditPromoModal();

                showNotification(`Promotion "${promoCodesData[promoIndex].code}" updated successfully!`, 'success');

            }, 1000);
        }

        function showAddPromoModal() {
            const modal = document.getElementById('addPromoModal');
            modal.classList.add('active');
            document.body.style.overflow = 'hidden';

            const today = new Date().toISOString().split('T')[0];
            document.getElementById('startDate').value = today;

            const futureDate = new Date();
            futureDate.setDate(futureDate.getDate() + 30);
            document.getElementById('endDate').value = futureDate.toISOString().split('T')[0];

            setTimeout(() => {
                document.getElementById('promoName').focus();
            }, 300);
        }

        function closeAddPromoModal() {
            const modal = document.getElementById('addPromoModal');
            modal.classList.remove('active');
            document.body.style.overflow = 'auto';

            resetPromoForm();
        }

        function selectDiscountType(type) {
            document.querySelectorAll('.discount-option').forEach(option => {
                option.classList.remove('active');
            });
            event.target.closest('.discount-option').classList.add('active');

            const discountPrefix = document.getElementById('discountPrefix');
            const discountValueInput = document.getElementById('discountValue');

            switch (type) {
                case 'percentage':
                    discountPrefix.textContent = '%';
                    discountValueInput.placeholder = 'e.g., 20';
                    discountValueInput.min = '0';
                    discountValueInput.max = '100';
                    document.getElementById('discountValueGroup').style.display = 'block';
                    document.getElementById('freeItemGroup').style.display = 'none';
                    document.getElementById('bundleDetailsGroup').style.display = 'none';
                    break;

                case 'fixed':
                    discountPrefix.textContent = '₱';
                    discountValueInput.placeholder = 'e.g., 100';
                    discountValueInput.min = '0';
                    discountValueInput.max = '10000';
                    document.getElementById('discountValueGroup').style.display = 'block';
                    document.getElementById('freeItemGroup').style.display = 'none';
                    document.getElementById('bundleDetailsGroup').style.display = 'none';
                    break;

                case 'free':
                    document.getElementById('discountValueGroup').style.display = 'none';
                    document.getElementById('freeItemGroup').style.display = 'block';
                    document.getElementById('bundleDetailsGroup').style.display = 'none';
                    break;

                case 'bundle':
                    document.getElementById('discountValueGroup').style.display = 'none';
                    document.getElementById('freeItemGroup').style.display = 'none';
                    document.getElementById('bundleDetailsGroup').style.display = 'block';
                    break;
            }
        }

        function validateForm() {
            let isValid = true;

            document.querySelectorAll('.error-message').forEach(error => {
                error.classList.remove('show');
            });
            document.querySelectorAll('.form-control').forEach(input => {
                input.classList.remove('error');
            });

            const promoName = document.getElementById('promoName').value.trim();
            if (!promoName) {
                document.getElementById('nameError').classList.add('show');
                document.getElementById('promoName').classList.add('error');
                isValid = false;
            }

            const promoCode = document.getElementById('promoCode').value.trim().toUpperCase();
            if (!promoCode) {
                document.getElementById('codeError').classList.add('show');
                document.getElementById('promoCode').classList.add('error');
                isValid = false;
            }

            if (promoCodesData.some(promo => promo.code === promoCode)) {
                document.getElementById('codeError').textContent = 'Promo code already exists';
                document.getElementById('codeError').classList.add('show');
                document.getElementById('promoCode').classList.add('error');
                isValid = false;
            }

            const discountType = document.querySelector('.discount-option.active').getAttribute('data-type');
            if (discountType === 'percentage' || discountType === 'fixed') {
                const discountValue = document.getElementById('discountValue').value;
                if (!discountValue || parseFloat(discountValue) <= 0) {
                    document.getElementById('valueError').classList.add('show');
                    document.getElementById('discountValue').classList.add('error');
                    isValid = false;
                }
            }

            const endDate = document.getElementById('endDate').value;
            if (!endDate) {
                document.getElementById('dateError').classList.add('show');
                document.getElementById('endDate').classList.add('error');
                isValid = false;
            }

            const maxUses = document.getElementById('maxUses').value;
            if (maxUses && parseInt(maxUses) < 0) {
                document.getElementById('usesError').classList.add('show');
                document.getElementById('maxUses').classList.add('error');
                isValid = false;
            }

            return isValid;
        }

        function submitPromoForm() {
            if (!validateForm()) {
                return;
            }

            document.getElementById('modalLoading').classList.add('active');

            setTimeout(() => {
                const discountType = document.querySelector('.discount-option.active').getAttribute('data-type');

                const newPromo = {
                    id: generatePromoId(),
                    code: document.getElementById('promoCode').value.trim().toUpperCase(),
                    name: document.getElementById('promoName').value.trim(),
                    description: document.getElementById('promoDescription').value.trim(),
                    discountType: discountType,
                    discountValue: discountType === 'percentage' || discountType === 'fixed'
                        ? parseFloat(document.getElementById('discountValue').value)
                        : 0,
                    status: 'active',
                    currentUses: 0,
                    maxUses: document.getElementById('maxUses').value
                        ? parseInt(document.getElementById('maxUses').value)
                        : 9999,
                    revenue: 0,
                    avgOrder: 0,
                    validUntil: document.getElementById('endDate').value,
                    createdDate: new Date().toISOString().split('T')[0],
                    category: document.getElementById('category').value,
                    targetAudience: document.getElementById('targetAudience').value,
                    usagePercentage: 0
                };

                promoCodesData.unshift(newPromo);

                initializePromoTable();

                document.getElementById('modalLoading').classList.remove('active');

                closeAddPromoModal();

                showNotification(`Promotion "${newPromo.code}" created successfully!`, 'success');

                setTimeout(() => {
                    const newCard = document.querySelector(`[data-promo-id="${newPromo.id}"]`);
                    if (newCard) {
                        newCard.scrollIntoView({ behavior: 'smooth', block: 'center' });
                        newCard.style.animation = 'pulse 2s';
                    }
                }, 100);

            }, 1000);
        }

        function generatePromoId() {
            const ids = promoCodesData.map(promo => parseInt(promo.id));
            const maxId = ids.length > 0 ? Math.max(...ids) : 0;
            return String(maxId + 1).padStart(3, '0');
        }

        function resetPromoForm() {
            document.getElementById('promoForm').reset();
            document.querySelectorAll('.error-message').forEach(error => {
                error.classList.remove('show');
            });
            document.querySelectorAll('.form-control').forEach(input => {
                input.classList.remove('error');
            });

            document.querySelectorAll('.discount-option').forEach(option => {
                option.classList.remove('active');
            });
            document.querySelector('[data-type="percentage"]').classList.add('active');
            selectDiscountType('percentage');
        }

        function createSuggestedCampaign(type) {
            let campaignName = '';
            let discountValue = '';

            if (type === 'silog-saturday') {
                campaignName = 'Silog Saturday Special';
                discountValue = '25%';
            } else if (type === 'sizzling-weekday') {
                campaignName = 'Sizzling Weekday Deals';
                discountValue = '₱100';
            }

            showNotification(`Creating campaign: ${campaignName}`, 'success');
        }

        function showNotification(message, type) {
            const notification = document.createElement('div');
            notification.style.cssText = `
                position: fixed;
                top: 20px;
                right: 20px;
                padding: 15px 20px;
                background: ${type === 'success' ? 'var(--success-green)' :
                    type === 'error' ? 'var(--danger-red)' :
                        'var(--primary-maroon)'};
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
                <i class="fas ${type === 'success' ? 'fa-check-circle' :
                    type === 'error' ? 'fa-exclamation-circle' :
                        'fa-info-circle'}"></i>
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

        document.getElementById('addPromoModal').addEventListener('click', function (e) {
            if (e.target === this) {
                closeAddPromoModal();
            }
        });

        document.getElementById('editPromoModal').addEventListener('click', function (e) {
            if (e.target === this) {
                closeEditPromoModal();
            }
        });

        document.getElementById('analyticsModal').addEventListener('click', function (e) {
            if (e.target === this) {
                closeAnalyticsModal();
            }
        });

        document.getElementById('deleteConfirmationModal').addEventListener('click', function (e) {
            if (e.target === this) {
                closeDeleteConfirmation();
            }
        });

        document.getElementById('statusConfirmationModal').addEventListener('click', function (e) {
            if (e.target === this) {
                closeStatusConfirmation();
            }
        });

        document.addEventListener('keydown', function (e) {
            if (e.key === 'Escape') {
                if (document.getElementById('addPromoModal').classList.contains('active')) {
                    closeAddPromoModal();
                }
                if (document.getElementById('editPromoModal').classList.contains('active')) {
                    closeEditPromoModal();
                }
                if (document.getElementById('analyticsModal').classList.contains('active')) {
                    closeAnalyticsModal();
                }
                if (document.getElementById('deleteConfirmationModal').classList.contains('active')) {
                    closeDeleteConfirmation();
                }
                if (document.getElementById('statusConfirmationModal').classList.contains('active')) {
                    closeStatusConfirmation();
                }
            }
        });

        document.getElementById('promoName').addEventListener('input', function () {
            const name = this.value.trim();
            if (name && !document.getElementById('promoCode').value) {
                const code = name.toUpperCase()
                    .replace(/[^A-Z0-9]/g, '')
                    .substring(0, 8);
                document.getElementById('promoCode').value = code;
            }
        });

        document.addEventListener('DOMContentLoaded', function () {
            const today = new Date().toISOString().split('T')[0];
            document.getElementById('startDate').min = today;
            document.getElementById('endDate').min = today;
            document.getElementById('editStartDate').min = today;
            document.getElementById('editEndDate').min = today;

            console.log("Page loaded - initializing promo table with filters");
            initializePromoTable();
        });
    </script>
</asp:Content>