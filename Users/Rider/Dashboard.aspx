<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Rider.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="TasteNet.Users.Rider.Dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <%-- Leaflet.js — free map (OpenStreetMap tiles, no API key) --%>
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
    
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

        .dashboard-wrapper {
            padding: 20px 30px;
            max-width: 1400px;
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
            padding-bottom: 15px;
            border-bottom: 1px solid var(--border-light);
        }

        .header-title h1 {
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

        .online-status {
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 8px 16px;
            background: var(--success-green-light);
            color: var(--success-green);
            border-radius: var(--radius-md);
            font-size: 13px;
            font-weight: 600;
            border: 1px solid var(--success-green);
        }

        .online-status.offline {
            background: var(--bg-lighter);
            color: var(--muted-text);
            border-color: var(--border-light);
        }

        .status-dot {
            width: 8px;
            height: 8px;
            border-radius: 50%;
            background: var(--success-green);
            animation: pulse 2s infinite;
        }

        .online-status.offline .status-dot {
            background: var(--muted-text);
            animation: none;
        }

        .status-card {
            background: white;
            padding: 25px 30px;
            border-radius: var(--radius-xl);
            box-shadow: var(--card-shadow);
            margin-bottom: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border: 1px solid var(--border-light);
            transition: all var(--transition-base);
            animation: fadeIn 0.5s ease-out;
        }

        .status-card:hover {
            transform: translateY(-2px);
            box-shadow: var(--card-shadow-hover);
        }

        .status-info {
            flex: 1;
        }

        .status-info strong {
            font-size: 18px;
            font-weight: 600;
            color: var(--text-dark);
            display: block;
            margin-bottom: 5px;
        }

        .status-info small {
            color: var(--muted-text);
            font-size: 13px;
            font-weight: 400;
        }

        .toggle-container {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .toggle-switch {
            width: 65px;
            height: 32px;
            background: var(--bg-lighter);
            border-radius: 16px;
            position: relative;
            cursor: pointer;
            border: 2px solid var(--border-light);
            transition: all var(--transition-base);
            flex-shrink: 0;
        }

        .toggle-switch.active {
            background: var(--success-green);
            border-color: var(--success-green);
        }

        .toggle-knob {
            width: 24px;
            height: 24px;
            background: white;
            border-radius: 50%;
            position: absolute;
            top: 2px;
            left: 2px;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            transition: all var(--transition-base);
            transform-origin: center;
        }

        .toggle-switch.active .toggle-knob {
            left: calc(100% - 26px);
            background: white;
            transform: scale(1.1);
        }

        .toggle-knob i {
            font-size: 10px;
            color: var(--muted-text);
            transition: all var(--transition-base);
        }

        .toggle-switch.active .toggle-knob i {
            color: var(--success-green);
        }

        .toggle-switch:hover {
            transform: scale(1.05);
        }

        .status-indicator {
            font-size: 13px;
            font-weight: 600;
            color: var(--muted-text);
            min-width: 60px;
            text-align: right;
        }

        .status-indicator.online {
            color: var(--success-green);
        }

        .status-indicator.offline {
            color: var(--muted-text);
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: white;
            padding: 25px;
            border-radius: var(--radius-xl);
            box-shadow: var(--card-shadow);
            transition: all var(--transition-base);
            border: 1px solid var(--border-light);
            animation: fadeIn 0.5s ease-out;
            animation-fill-mode: both;
        }

        .stat-card:nth-child(1) { animation-delay: 0.1s; }
        .stat-card:nth-child(2) { animation-delay: 0.2s; }
        .stat-card:nth-child(3) { animation-delay: 0.3s; }
        .stat-card:nth-child(4) { animation-delay: 0.4s; }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--card-shadow-hover);
        }

        .stat-card__content {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 10px;
        }

        .stat-label {
            font-size: 12px;
            font-weight: 500;
            color: var(--muted-text);
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 8px;
        }

        .stat-value {
            font-size: 32px;
            font-weight: 700;
            color: var(--primary-maroon);
            margin: 0;
            line-height: 1;
        }

        .icon-circle {
            width: 48px;
            height: 48px;
            border-radius: var(--radius-lg);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 18px;
            background: var(--accent-pink);
            color: var(--primary-maroon);
            transition: all var(--transition-base);
            flex-shrink: 0;
        }

        .stat-card:hover .icon-circle {
            transform: scale(1.1) rotate(5deg);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
        }

        .trend-up, .trend-down {
            font-size: 11px;
            font-weight: 600;
            margin-top: 6px;
            display: flex;
            align-items: center;
            gap: 4px;
        }

        .trend-up { color: var(--success-green); }
        .trend-down { color: var(--danger-red); }

        .active-delivery-section {
            margin-top: 30px;
            animation: slideUp 0.4s ease-out;
            display: none;
        }

        .active-delivery-section.active {
            display: block;
        }

        .active-delivery-card {
            background: white;
            border-radius: var(--radius-xl);
            padding: 25px;
            box-shadow: var(--card-shadow);
            border: 1px solid var(--border-light);
            transition: all var(--transition-base);
            border-left: 4px solid var(--success-green);
        }

        .active-delivery-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .active-delivery-id {
            font-size: 16px;
            font-weight: 700;
            color: var(--primary-maroon);
            font-family: 'Courier New', monospace;
            background: var(--accent-pink);
            padding: 6px 12px;
            border-radius: var(--radius-sm);
        }

        .active-delivery-status {
            padding: 6px 12px;
            border-radius: var(--radius-sm);
            font-size: 11px;
            font-weight: 700;
            text-transform: uppercase;
            background: var(--success-green-light);
            color: var(--success-green);
            border: 1px solid var(--success-green);
        }

        .active-delivery-content {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-bottom: 20px;
        }

        .location-section {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .location-row {
            display: flex;
            align-items: flex-start;
            gap: 12px;
        }

        .location-icon {
            width: 36px;
            height: 36px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            background: var(--accent-pink);
            color: var(--primary-maroon);
            font-size: 14px;
            flex-shrink: 0;
            margin-top: 2px;
        }

        .location-info {
            flex: 1;
        }

        .location-label {
            font-size: 11px;
            font-weight: 600;
            color: var(--muted-text);
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 4px;
        }

        .location-value {
            font-size: 14px;
            font-weight: 600;
            color: var(--text-dark);
            line-height: 1.4;
        }

        .delivery-details-section {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        .detail-row {
            display: flex;
            justify-content: space-between;
            padding: 8px 0;
            border-bottom: 1px dashed var(--border-light);
        }

        .detail-row:last-child {
            border-bottom: none;
        }

        .detail-label {
            color: var(--muted-text);
            font-size: 12px;
            font-weight: 500;
        }

        .detail-value {
            color: var(--text-dark);
            font-weight: 600;
            font-size: 13px;
        }

        .detail-value.highlight {
            color: var(--success-green);
        }

        .customer-contact-section {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 15px;
            background: var(--accent-blue);
            border-radius: var(--radius-lg);
            margin-bottom: 20px;
            border: 1px solid var(--accent-blue-dark);
        }

        .contact-icon {
            width: 36px;
            height: 36px;
            border-radius: 50%;
            background: var(--accent-blue-dark);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 14px;
        }

        .contact-info {
            flex: 1;
        }

        .contact-label {
            font-size: 11px;
            color: var(--muted-text);
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .contact-number {
            font-size: 14px;
            font-weight: 600;
            color: var(--text-dark);
        }

        .action-buttons {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 12px;
        }

        .action-btn {
            padding: 13px 12px;
            border-radius: var(--radius-md);
            font-weight: 600;
            font-size: 13px;
            cursor: pointer;
            border: none;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            min-height: 46px;
            transition: all var(--transition-base);
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .action-btn:hover {
            transform: translateY(-2px);
        }

        .btn-navigate {
            background: var(--primary-maroon);
            color: white;
        }

        .btn-navigate:hover {
            background: var(--primary-maroon-dark);
        }

        .btn-delivered {
            background: var(--success-green);
            color: white;
        }

        .btn-delivered:hover {
            background: #248a68;
        }

        .btn-call {
            background: var(--accent-blue-dark);
            color: white;
        }

        .btn-call:hover {
            background: #2563eb;
        }

        .hero-section {
            background: white;
            border-radius: var(--radius-xl);
            padding: 40px;
            box-shadow: var(--card-shadow);
            text-align: center;
            margin-top: 20px;
            border: 1px solid var(--border-light);
            animation: fadeIn 0.5s ease-out;
            transition: all var(--transition-base);
        }

        .hero-section:hover {
            box-shadow: var(--card-shadow-hover);
        }

        .hero-section.offline {
            background: white;
        }

        .hero-section.online {
            background: linear-gradient(135deg, white 0%, var(--success-green-light) 100%);
        }

        .icon-lg {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 25px;
            font-size: 32px;
            transition: all var(--transition-base);
        }

        .hero-section.offline .icon-lg {
            background: var(--accent-pink);
            color: var(--primary-maroon);
        }

        .hero-section.online .icon-lg {
            background: var(--success-green-light);
            color: var(--success-green);
            animation: pulse 2s infinite;
        }

        .hero-section h2 {
            font-size: 24px;
            font-weight: 600;
            margin: 10px 0;
            color: var(--text-dark);
        }

        .hero-section p {
            color: var(--muted-text);
            font-size: 14px;
            margin-bottom: 30px;
            max-width: 500px;
            margin-left: auto;
            margin-right: auto;
            line-height: 1.6;
        }

        .btn {
            padding: 12px 28px;
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

        .btn--success {
            background: var(--success-green);
            color: white;
            box-shadow: 0 4px 12px rgba(45, 157, 120, 0.2);
        }

        .btn--success:hover {
            background: #248a68;
            transform: translateY(-3px);
            box-shadow: 0 6px 18px rgba(45, 157, 120, 0.3);
        }

        .btn--danger {
            background: var(--danger-red-light);
            color: var(--danger-red);
            border-color: rgba(185, 28, 28, 0.2);
        }

        .btn--danger:hover {
            background: var(--danger-red);
            color: white;
        }

        .deliveries-section {
            margin-top: 30px;
            animation: fadeIn 0.5s ease-out;
        }

        .section-title {
            font-size: 20px;
            color: var(--text-dark);
            font-weight: 600;
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .view-all-link {
            font-size: 13px;
            color: var(--primary-maroon);
            text-decoration: none;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 6px;
            transition: all var(--transition-fast);
        }

        .view-all-link:hover {
            color: var(--primary-maroon-dark);
            gap: 8px;
        }

        .deliveries-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }

        .delivery-card {
            background: white;
            border-radius: var(--radius-xl);
            padding: 25px;
            box-shadow: var(--card-shadow);
            border: 1px solid var(--border-light);
            transition: all var(--transition-base);
            animation: slideUp 0.4s ease-out;
            animation-fill-mode: both;
        }

        .delivery-card:nth-child(1) { animation-delay: 0.1s; }
        .delivery-card:nth-child(2) { animation-delay: 0.2s; }

        .delivery-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--card-shadow-hover);
            border-color: var(--border-hover);
        }

        .delivery-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .delivery-id {
            font-size: 14px;
            font-weight: 700;
            color: var(--primary-maroon);
            font-family: 'Courier New', monospace;
            padding: 4px 10px;
            background: var(--accent-pink);
            border-radius: var(--radius-sm);
            display: inline-block;
        }

        .delivery-status {
            padding: 6px 12px;
            border-radius: var(--radius-sm);
            font-size: 10px;
            font-weight: 700;
            display: inline-block;
            text-transform: uppercase;
            letter-spacing: 0.3px;
            min-width: 70px;
            text-align: center;
            line-height: 1.2;
            border: 1px solid transparent;
            transition: all var(--transition-fast);
        }

        .status-pending {
            background: var(--warning-orange-light);
            color: var(--warning-orange);
            border-color: var(--warning-orange);
        }

        .status-active {
            background: var(--success-green-light);
            color: var(--success-green);
            border-color: var(--success-green);
        }

        .delivery-info {
            margin: 20px 0;
        }

        .info-row {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
            border-bottom: 1px dashed var(--border-light);
            align-items: center;
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
            font-size: 13px;
            text-align: right;
        }

        .info-value.highlight {
            color: var(--primary-maroon);
            font-size: 14px;
        }

        .delivery-actions {
            display: flex;
            gap: 10px;
            margin-top: 20px;
        }

        .btn-action {
            flex: 1;
            padding: 12px;
            border-radius: var(--radius-md);
            font-weight: 600;
            cursor: pointer;
            transition: all var(--transition-base);
            font-size: 13px;
            border: none;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 6px;
        }

        .modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0,0,0,0.5);
            z-index: 10001;
            animation: fadeIn 0.3s ease;
            display: none;
            backdrop-filter: blur(3px);
        }

        .modal-overlay.active {
            display: block;
        }

        .completion-modal {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: white;
            padding: 30px;
            border-radius: var(--radius-xl);
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            z-index: 10002;
            width: 90%;
            max-width: 400px;
            text-align: center;
            animation: modalSlideIn 0.3s ease;
            border: 1px solid var(--border-light);
            display: none;
            box-sizing: border-box;
        }

        .completion-modal.active {
            display: block;
            animation: modalSlideIn 0.3s ease;
        }

        .modal-icon {
            width: 70px;
            height: 70px;
            border-radius: 50%;
            background: var(--success-green-light);
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            border: 2px solid var(--success-green);
        }

        .modal-icon i {
            font-size: 32px;
            color: var(--success-green);
        }

        .modal-title {
            margin: 0 0 12px 0;
            color: var(--text-dark);
            font-size: 20px;
            font-weight: 600;
            line-height: 1.3;
        }

        .modal-message {
            color: var(--muted-text);
            font-size: 14px;
            margin: 0 0 25px 0;
            line-height: 1.5;
            padding: 0 5px;
        }

        .modal-actions {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 12px;
            margin-top: 20px;
        }

        .modal-btn {
            padding: 14px;
            border-radius: var(--radius-md);
            cursor: pointer;
            font-weight: 600;
            transition: all 0.2s ease;
            font-size: 14px;
            font-family: 'Poppins', sans-serif;
            border: 2px solid transparent;
            min-height: 44px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .modal-btn-cancel {
            border: 2px solid var(--border-light);
            background: white;
            color: var(--muted-text);
        }

        .modal-btn-cancel:hover {
            background: var(--bg-lighter);
            border-color: var(--border-hover);
            transform: translateY(-1px);
        }

        .modal-btn-confirm {
            background: var(--success-green);
            color: white;
            border: 2px solid var(--success-green);
        }

        .modal-btn-confirm:hover {
            background: #248a68;
            border-color: #248a68;
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(45, 157, 120, 0.2);
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
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

        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.1); }
            100% { transform: scale(1); }
        }

        @keyframes modalSlideIn {
            from { 
                opacity: 0;
                transform: translate(-50%, -50%) scale(0.9);
            }
            to { 
                opacity: 1;
                transform: translate(-50%, -50%) scale(1);
            }
        }

        /* ── Responsive: Tablet landscape (≤1200px) ─────────────────── */
        @media (max-width: 1200px) {
            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
            }
            .deliveries-grid,
            .active-delivery-content,
            .action-buttons {
                grid-template-columns: 1fr;
            }
        }

        /* ── Responsive: Tablet portrait (≤992px) ───────────────────── */
        @media (max-width: 992px) {
            .dashboard-wrapper {
                padding: 20px;
            }
            .page-header {
                flex-direction: column;
                align-items: stretch;
                gap: 15px;
            }
            .header-title h1 {
                font-size: 24px;
            }
            .status-card {
                flex-direction: column;
                gap: 20px;
                text-align: center;
                padding: 20px;
            }
            .toggle-container {
                width: 100%;
                justify-content: center;
            }

            /* Map modal: full-width on tablet */
            .map-modal {
                width: 96%;
                max-width: 96%;
                max-height: 90vh;
            }
            #mapFrame {
                height: calc(90vh - 180px);
                min-height: 220px;
                max-height: 380px;
            }
        }

        /* ── Responsive: Mobile (≤768px) ────────────────────────────── */
        @media (max-width: 768px) {
            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
                gap: 12px;
            }
            .hero-section {
                padding: 30px 20px;
            }
            .icon-lg {
                width: 70px;
                height: 70px;
                font-size: 28px;
            }
            .delivery-card,
            .active-delivery-card {
                padding: 18px;
            }
            .delivery-actions {
                flex-direction: row;
                flex-wrap: wrap;
            }
            .btn-action {
                flex: 1 1 calc(50% - 5px);
                min-width: 120px;
            }
            .action-buttons {
                grid-template-columns: 1fr;
                gap: 10px;
            }
            .action-buttons .btn-delivered {
                grid-column: auto;
            }
            .action-btn {
                width: 100%;
                min-height: 48px;
                font-size: 14px;
                padding: 13px 16px;
            }
            .completion-modal {
                padding: 20px;
                width: 92%;
                max-width: 400px;
            }
            .modal-icon {
                width: 60px;
                height: 60px;
            }
            .modal-icon i {
                font-size: 28px;
            }
            .modal-title {
                font-size: 18px;
            }

            /* Map modal: bottom sheet on mobile */
            .map-modal {
                width: 100%;
                max-width: 100%;
                top: auto;
                bottom: 0;
                left: 0;
                right: 0;
                transform: none;
                border-radius: var(--radius-xl) var(--radius-xl) 0 0;
                max-height: 90vh;
                animation: slideUpModal 0.3s ease;
            }
            .map-modal.active {
                display: flex;
            }
            #mapFrame {
                height: calc(90vh - 195px);
                min-height: 180px;
                max-height: 320px;
            }
            .map-distance-bar {
                flex-wrap: wrap;
            }
            .map-distance-item {
                flex: 1 1 33%;
                padding: 10px 8px;
            }
            .map-distance-value {
                font-size: 14px;
            }
            .map-modal-footer {
                flex-direction: column;
                gap: 8px;
                padding: 12px 16px;
            }
            .map-open-gmaps-btn,
            .map-close-btn {
                width: 100%;
                justify-content: center;
            }
        }

        /* ── Responsive: Small mobile (≤480px) ──────────────────────── */
        @media (max-width: 480px) {
            .dashboard-wrapper {
                padding: 12px;
            }
            .header-title h1 {
                font-size: 20px;
            }
            .stats-grid {
                grid-template-columns: 1fr;
                gap: 10px;
            }
            .stat-value {
                font-size: 28px;
            }
            .stat-card {
                padding: 18px;
            }
            .icon-circle {
                width: 40px;
                height: 40px;
                font-size: 16px;
            }
            .btn {
                width: 100%;
                justify-content: center;
            }
            .section-title {
                flex-direction: column;
                align-items: flex-start;
                gap: 10px;
            }
            .view-all-link {
                align-self: flex-end;
            }
            .modal-actions {
                grid-template-columns: 1fr;
            }
            .completion-modal {
                padding: 20px 15px;
                width: 96%;
                max-width: 360px;
            }
            .active-delivery-content {
                grid-template-columns: 1fr;
                gap: 16px;
            }
            .action-buttons {
                grid-template-columns: 1fr;
                gap: 8px;
            }
            .action-buttons .btn-delivered {
                grid-column: auto;
            }
            .action-btn {
                width: 100%;
                min-height: 50px;
                font-size: 14px;
                padding: 14px 16px;
                border-radius: var(--radius-md);
            }
            .delivery-actions {
                flex-direction: column;
            }
            .btn-action {
                width: 100%;
                flex: none;
            }
            .info-label,
            .info-value {
                font-size: 12px;
            }
            .delivery-card {
                padding: 15px;
            }

            /* Map modal: full bottom sheet on small phones */
            .map-modal {
                max-height: 92vh;
            }
            #mapFrame {
                height: calc(92vh - 210px);
                min-height: 150px;
                max-height: 270px;
            }
            .map-distance-item {
                flex: 1 1 50%;
                padding: 9px 8px;
            }
            .map-distance-label {
                font-size: 9px;
            }
            .map-distance-value {
                font-size: 13px;
            }
            .map-modal-header {
                padding: 13px 16px;
            }
            .map-modal-title {
                font-size: 14px;
            }
        }

        /* ── Responsive: Extra small (≤360px) ───────────────────────── */
        @media (max-width: 360px) {
            .dashboard-wrapper {
                padding: 10px;
            }
            .header-title h1 {
                font-size: 18px;
            }
            .stat-value {
                font-size: 24px;
            }
            #mapFrame {
                height: calc(92vh - 230px);
                min-height: 130px;
                max-height: 230px;
            }
            .map-distance-item {
                flex: 1 1 100%;
                border-right: none;
                border-bottom: 1px solid rgba(255,255,255,0.15);
                padding: 8px 12px;
            }
            .map-distance-item:last-child {
                border-bottom: none;
            }
        }

        @keyframes slideUpModal {
            from { transform: translateY(100%); opacity: 0; }
            to   { transform: translateY(0);    opacity: 1; }
        }


        /* ── Map Modal ──────────────────────────────────────────────── */
        .map-modal-overlay {
            position: fixed;
            inset: 0;
            background: rgba(0,0,0,0.6);
            z-index: 10003;
            display: none;
            backdrop-filter: blur(4px);
            animation: fadeIn 0.3s ease;
        }
        .map-modal-overlay.active { display: block; }

        .map-modal {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: white;
            border-radius: var(--radius-xl);
            box-shadow: 0 25px 70px rgba(0,0,0,0.35);
            z-index: 10004;
            width: 92%;
            max-width: 560px;
            display: none;
            flex-direction: column;
            overflow: hidden;
            overflow-y: auto;
            animation: modalSlideIn 0.3s ease;
            box-sizing: border-box;
            max-height: 95vh;
            -webkit-overflow-scrolling: touch;
        }
        .map-modal.active { display: flex; }

        .map-modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 16px 20px;
            border-bottom: 1px solid var(--border-light);
            background: var(--soft-cream);
            flex-shrink: 0;
        }

        .map-modal-title {
            font-size: 16px;
            font-weight: 700;
            color: var(--text-dark);
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .map-modal-title i {
            color: var(--primary-maroon);
            font-size: 15px;
        }

        .map-modal-close {
            width: 32px;
            height: 32px;
            border-radius: 50%;
            border: none;
            background: var(--bg-light);
            color: var(--muted-text);
            font-size: 14px;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all var(--transition-fast);
            font-family: 'Poppins', sans-serif;
        }
        .map-modal-close:hover {
            background: var(--danger-red);
            color: white;
        }

        .map-distance-bar {
            display: flex;
            gap: 0;
            padding: 0;
            background: var(--primary-maroon);
            flex-shrink: 0;
        }

        .map-distance-item {
            flex: 1;
            padding: 12px 16px;
            text-align: center;
            border-right: 1px solid rgba(255,255,255,0.15);
        }
        .map-distance-item:last-child { border-right: none; }

        .map-distance-label {
            font-size: 10px;
            font-weight: 600;
            color: rgba(255,255,255,0.7);
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 3px;
        }

        .map-distance-value {
            font-size: 16px;
            font-weight: 700;
            color: white;
            line-height: 1.2;
        }

        .map-distance-value.loading {
            font-size: 12px;
            opacity: 0.7;
            animation: pulse 1.5s infinite;
        }

        #mapFrame {
            width: 100%;
            height: 340px;
            min-height: 200px;
            border: none;
            flex-shrink: 1;
            flex-grow: 1;
            display: block;
            touch-action: pan-x pan-y;
            -webkit-tap-highlight-color: transparent;
        }

        .map-modal-footer {
            padding: 14px 20px;
            border-top: 1px solid var(--border-light);
            display: flex;
            gap: 10px;
            flex-shrink: 0;
            background: white;
        }

        .map-open-gmaps-btn {
            flex: 1;
            padding: 11px;
            background: var(--primary-maroon);
            color: white;
            border: none;
            border-radius: var(--radius-md);
            font-size: 13px;
            font-weight: 600;
            font-family: 'Poppins', sans-serif;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 7px;
            transition: all var(--transition-fast);
        }
        .map-open-gmaps-btn:hover {
            background: var(--primary-maroon-dark);
            transform: translateY(-1px);
        }

        .map-close-btn {
            padding: 11px 18px;
            background: var(--bg-lighter);
            color: var(--muted-text);
            border: 1.5px solid var(--border-light);
            border-radius: var(--radius-md);
            font-size: 13px;
            font-weight: 600;
            font-family: 'Poppins', sans-serif;
            cursor: pointer;
            transition: all var(--transition-fast);
        }
        .map-close-btn:hover {
            background: var(--bg-light);
            border-color: var(--border-hover);
        }

        .map-track-btn {
            padding: 11px 14px;
            background: var(--accent-blue);
            color: var(--accent-blue-dark);
            border: 1.5px solid var(--accent-blue-dark);
            border-radius: var(--radius-md);
            font-size: 13px;
            font-weight: 600;
            font-family: 'Poppins', sans-serif;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 7px;
            transition: all var(--transition-fast);
            white-space: nowrap;
        }
        .map-track-btn:hover {
            background: var(--accent-blue-dark);
            color: white;
            transform: translateY(-1px);
        }
        .map-track-btn.tracking {
            background: var(--success-green);
            color: white;
            border-color: var(--success-green);
            animation: trackPulse 2s infinite;
        }
        .map-track-btn.tracking:hover {
            background: #248a68;
            border-color: #248a68;
        }
        @keyframes trackPulse {
            0%, 100% { box-shadow: 0 0 0 0 rgba(45,157,120,0.4); }
            50% { box-shadow: 0 0 0 6px rgba(45,157,120,0); }
        }
        /* ─────────────────────────────────────────────────────── */
        /* ── Proof of Delivery ─────────────────────────────────── */
        .completion-modal {
            max-width: 420px !important;
        }

        .proof-upload-area {
            border: 2px dashed var(--border-light);
            border-radius: var(--radius-lg);
            padding: 20px;
            margin: 0 0 20px 0;
            cursor: pointer;
            transition: border-color var(--transition-fast), background var(--transition-fast);
            position: relative;
            min-height: 140px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            gap: 10px;
            background: var(--bg-lighter);
        }

        .proof-upload-area:hover {
            border-color: var(--primary-maroon);
            background: var(--accent-pink);
        }

        .proof-upload-area.has-photo {
            border-style: solid;
            border-color: var(--success-green);
            background: var(--success-green-light);
            padding: 10px;
        }

        .proof-placeholder {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 10px;
            color: var(--muted-text);
            pointer-events: none;
        }

        .proof-placeholder i {
            font-size: 36px;
            color: var(--primary-maroon);
            opacity: 0.5;
        }

        .proof-placeholder span {
            font-size: 13px;
            font-weight: 500;
        }

        .proof-preview {
            width: 100%;
            max-height: 200px;
            object-fit: cover;
            border-radius: var(--radius-md);
            display: block;
        }

        .proof-retake-btn {
            margin-top: 8px;
            background: none;
            border: 1px solid var(--border-light);
            border-radius: var(--radius-sm);
            padding: 6px 14px;
            font-size: 12px;
            font-weight: 600;
            color: var(--muted-text);
            cursor: pointer;
            font-family: 'Poppins', sans-serif;
            transition: all var(--transition-fast);
        }

        .proof-retake-btn:hover {
            border-color: var(--primary-maroon);
            color: var(--primary-maroon);
        }

        .modal-btn-confirm:disabled {
            background: var(--bg-light);
            border-color: var(--border-light);
            color: var(--muted-text);
            cursor: not-allowed;
            box-shadow: none;
            transform: none !important;
        }
        /* ─────────────────────────────────────────────────────── */

        .completion-modal {
            position: fixed !important;
            top: 50% !important;
            left: 50% !important;
            transform: translate(-50%, -50%) !important;
            margin: 0 !important;
            box-sizing: border-box !important;
            display: none !important;
        }

        .completion-modal.active {
            display: block !important;
            animation: modalSlideIn 0.3s ease !important;
        }

        #completionModal {
            transform: translate(-50%, -50%) !important;
            z-index: 99999 !important;
        }

        /* ── Order Items List inside delivery card ───────────────────────── */
        .order-items-section {
            margin: 14px 0 4px;
            border: 1px solid var(--border-light);
            border-radius: var(--radius-md);
            overflow: hidden;
        }

        .order-items-toggle {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 9px 14px;
            background: var(--accent-pink);
            cursor: pointer;
            user-select: none;
            font-size: 12px;
            font-weight: 700;
            color: var(--primary-maroon);
            border: none;
            width: 100%;
            text-align: left;
            transition: background var(--transition-fast);
        }

        .order-items-toggle:hover { background: #f3dde1; }

        .order-items-toggle i.toggle-arrow {
            transition: transform var(--transition-fast);
            font-size: 11px;
        }

        .order-items-toggle.open i.toggle-arrow {
            transform: rotate(180deg);
        }

        .order-items-body {
            display: none;
            background: #fff;
        }

        .order-items-body.open { display: block; }

        .order-item-row {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            padding: 9px 14px;
            border-bottom: 1px dashed var(--border-light);
            gap: 8px;
        }

        .order-item-row:last-child { border-bottom: none; }

        .order-item-name {
            font-size: 12px;
            font-weight: 600;
            color: var(--text-dark);
            flex: 1;
            line-height: 1.4;
        }

        .order-item-note {
            font-size: 10px;
            color: var(--muted-text);
            font-style: italic;
            display: block;
            margin-top: 2px;
        }

        .order-item-right {
            text-align: right;
            flex-shrink: 0;
        }

        .order-item-qty {
            font-size: 11px;
            color: var(--muted-text);
            font-weight: 500;
        }

        .order-item-subtotal {
            font-size: 12px;
            font-weight: 700;
            color: var(--primary-maroon);
            display: block;
        }

        /* Fix Pin button pulse when in drag mode */
        #pinFixBanner { display: none; }
        #pinFixBanner.active { display: flex !important; }

        #fixPinBtn:hover { background: #d97706 !important; }

        /* Make draggable cursor obvious when fixing pin */
        .leaflet-marker-draggable { cursor: grab !important; }
        .leaflet-marker-draggable:active { cursor: grabbing !important; }

        /* Saved-pin indicator badge on the map modal title */
        .pin-saved-badge {
            display: inline-block;
            background: #2d9d78;
            color: #fff;
            font-size: 9px;
            font-weight: 700;
            padding: 2px 7px;
            border-radius: 99px;
            margin-left: 8px;
            vertical-align: middle;
            letter-spacing: 0.5px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%-- Enable ASP.NET Page WebMethods so JS can call SaveState --%>
    <%-- ── Map / Distance Modal ─────────────────────────────────────────── --%>
    <div class="map-modal-overlay" id="mapModalOverlay"></div>
    <div class="map-modal" id="mapModal">
        <div class="map-modal-header">
            <span class="map-modal-title">
                <i class="fas fa-map-marked-alt"></i>
                Route to Customer
            </span>
            <button type="button" class="map-modal-close" id="mapModalCloseX">
                <i class="fas fa-times"></i>
            </button>
        </div>

        <div class="map-distance-bar">
            <div class="map-distance-item">
                <div class="map-distance-label">Distance</div>
                <div class="map-distance-value loading" id="mapDistanceValue">Calculating...</div>
            </div>
            <div class="map-distance-item">
                <div class="map-distance-label">Est. Travel Time</div>
                <div class="map-distance-value loading" id="mapDurationValue">Calculating...</div>
            </div>
            <div class="map-distance-item">
                <div class="map-distance-label">Origin</div>
                <div class="map-distance-value" style="font-size:11px;opacity:0.9;line-height:1.4;">TasteNet Store</div>
            </div>
        </div>

        <div id="mapFrame" style="width:100%;height:340px;background:var(--bg-lighter);"></div>

        <%-- Pin correction banner (shown when in drag-to-fix mode) --%>
        <div id="pinFixBanner" style="
            display:none;
            background:#fef3c7;border-top:1px solid #f59e0b;
            padding:8px 14px;font-size:12px;color:#92400e;
            display:none;align-items:center;gap:8px;flex-wrap:wrap;">
            <i class="fas fa-hand-point-up"></i>
            <span style="flex:1;">Drag the <strong style="color:#2d9d78;">green pin</strong> to the correct location, then tap <strong>Save Pin</strong>.</span>
            <button type="button" id="savePinBtn" style="
                background:#2d9d78;color:#fff;border:none;border-radius:6px;
                padding:5px 12px;font-size:11px;font-weight:700;cursor:pointer;">
                <i class="fas fa-check"></i> Save Pin
            </button>
            <button type="button" id="cancelFixBtn" style="
                background:#e5e7eb;color:#374151;border:none;border-radius:6px;
                padding:5px 10px;font-size:11px;font-weight:700;cursor:pointer;">
                Cancel
            </button>
        </div>

        <div class="map-modal-footer">
            <button type="button" class="map-open-gmaps-btn" id="openGoogleMapsBtn">
                <i class="fas fa-external-link-alt"></i>
                Open in Google Maps
            </button>
            <button type="button" class="map-track-btn" id="trackLocationBtn">
                <i class="fas fa-crosshairs"></i>
                Use My Location
            </button>
            <button type="button" id="fixPinBtn" style="
                background:#f59e0b;color:#fff;border:none;border-radius:8px;
                padding:8px 14px;font-size:12px;font-weight:700;cursor:pointer;
                display:flex;align-items:center;gap:6px;">
                <i class="fas fa-map-pin"></i>
                Fix Pin
            </button>
            <button type="button" class="map-close-btn" id="mapModalCloseBtn">
                Close
            </button>
        </div>
    </div>
    <%-- ──────────────────────────────────────────────────────────────────── --%>

    <div class="modal-overlay" id="completionOverlay"></div>
    <div class="completion-modal" id="completionModal">
        <div class="modal-icon">
            <i class="fas fa-camera"></i>
        </div>
        <h3 class="modal-title">Proof of Delivery Required</h3>
        <p class="modal-message">Please upload a photo as proof before marking this delivery as completed.</p>

        <%-- Photo upload / preview area --%>
        <div class="proof-upload-area" id="proofUploadArea">
            <input type="file" id="proofPhotoInput" accept="image/*" capture="environment" style="display:none;" />
            <div class="proof-placeholder" id="proofPlaceholder">
                <i class="fas fa-camera-retro"></i>
                <span>Tap to take or upload a photo</span>
            </div>
            <img id="proofPreview" class="proof-preview" src="" alt="Proof of delivery preview" style="display:none;" />
            <button type="button" class="proof-retake-btn" id="proofRetakeBtn" style="display:none;">
                <i class="fas fa-redo"></i> Retake Photo
            </button>
        </div>

        <div class="modal-actions">
            <button type="button" class="modal-btn modal-btn-cancel" id="cancelCompletion">
                <i class="fas fa-times"></i>
                Cancel
            </button>
            <button type="button" class="modal-btn modal-btn-confirm" id="confirmCompletion" disabled>
                <i class="fas fa-check"></i>
                Confirm Delivered
            </button>
        </div>
    </div>

    <div class="dashboard-wrapper">
        <div class="page-header">
            <div class="header-title">
                <h1>Delivery Dashboard</h1>
                <p>Manage your deliveries and track performance</p>
            </div>
            <div class="online-status offline" id="onlineStatus">
                <span class="status-dot"></span>
                <span id="statusTextHeader">OFFLINE</span>
            </div>
        </div>

        <div class="status-card">
            <div class="status-info">
                <strong>Availability Status</strong>
                <small id="statusText">Currently offline</small>
            </div>
            <div class="toggle-container">
                <span class="status-indicator offline" id="statusIndicator">OFFLINE</span>
                <div class="toggle-switch" id="availabilityToggle">
                    <div class="toggle-knob">
                        <i class="fas fa-times"></i>
                    </div>
                </div>
            </div>
        </div>

        <div class="stats-grid">

            <%-- ── Total Deliveries ── --%>
            <div class="stat-card">
                <div>
                    <div class="stat-card__content">
                        <div>
                            <div class="stat-label">Total Deliveries</div>
                            <div class="stat-value" id="statTotalDeliveries">
                                <asp:Literal ID="litTotalDeliveries" runat="server" Text="0" />
                            </div>
                        </div>
                        <div class="icon-circle">
                            <i class="fas fa-box"></i>
                        </div>
                    </div>
                    <div id="trendTotalDeliveries" class="trend-up">
                        <asp:Literal ID="litTrendTotalDeliveries" runat="server" />
                    </div>
                </div>
            </div>

            <%-- ── Completed Today ── --%>
            <div class="stat-card">
                <div>
                    <div class="stat-card__content">
                        <div>
                            <div class="stat-label">Completed Today</div>
                            <div class="stat-value" id="statCompletedToday">
                                <asp:Literal ID="litCompletedToday" runat="server" Text="0" />
                            </div>
                        </div>
                        <div class="icon-circle">
                            <i class="fas fa-check-circle"></i>
                        </div>
                    </div>
                    <div id="trendCompletedToday" class="trend-up">
                        <asp:Literal ID="litTrendCompletedToday" runat="server" />
                    </div>
                </div>
            </div>

            <%-- ── Pending Deliveries ── --%>
            <div class="stat-card">
                <div>
                    <div class="stat-card__content">
                        <div>
                            <div class="stat-label">Pending</div>
                            <div class="stat-value" id="statPending">
                                <asp:Literal ID="litPending" runat="server" Text="0" />
                            </div>
                        </div>
                        <div class="icon-circle">
                            <i class="fas fa-clock"></i>
                        </div>
                    </div>
                    <div id="trendPending" class="trend-up">
                        <asp:Literal ID="litTrendPending" runat="server" />
                    </div>
                </div>
            </div>

        </div>

        <div class="active-delivery-section" id="activeDeliverySection">
            <div class="section-title">
                <span>Active Delivery</span>
            </div>
            
            <div class="active-delivery-card">
                <div class="active-delivery-header">
                    <span class="active-delivery-id" id="activeDeliveryId">#—</span>
                    <span class="active-delivery-status">On Delivery</span>
                </div>
                
                <div class="active-delivery-content">
                    <div class="location-section">
                        <div class="location-row">
                            <div class="location-icon">
                                <i class="fas fa-map-marker-alt"></i>
                            </div>
                            <div class="location-info">
                                <div class="location-label">Pickup Location</div>
                                <div class="location-value" id="pickupLocation">—</div>
                            </div>
                        </div>
                        
                        <div class="location-row">
                            <div class="location-icon">
                                <i class="fas fa-flag-checkered"></i>
                            </div>
                            <div class="location-info">
                                <div class="location-label">Drop-off Location</div>
                                <div class="location-value" id="dropoffLocation">—</div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="delivery-details-section">
                        <div class="detail-row">
                            <span class="detail-label">Delivery Fee</span>
                            <span class="detail-value highlight" id="deliveryFee">—</span>
                        </div>
                    </div>
                </div>
                
                <div class="customer-contact-section">
                    <div class="contact-icon">
                        <i class="fas fa-phone"></i>
                    </div>
                    <div class="contact-info">
                        <div class="contact-label">Customer Contact</div>
                        <div class="contact-number" id="customerContact">—</div>
                    </div>
                </div>

                <%-- ── Order Items (populated by JS on Accept) ── --%>
                <div class="order-items-section" id="activeOrderItemsSection" style="margin:14px 0 4px;">
                    <button type="button" class="order-items-toggle" onclick="toggleOrderItems(this)">
                        <span>
                            <i class="fas fa-utensils" style="margin-right:6px;"></i>
                            Order Items
                            <span id="activeItemCount" style="
                                background:var(--primary-maroon);color:#fff;
                                border-radius:99px;font-size:10px;
                                padding:1px 7px;margin-left:6px;font-weight:700;">0</span>
                        </span>
                        <i class="fas fa-chevron-down toggle-arrow"></i>
                    </button>
                    <div class="order-items-body open" id="activeOrderItemsBody">
                        <%-- rows injected by acceptDelivery() --%>
                    </div>
                </div>

                <div class="action-buttons">
                    <button type="button" class="action-btn btn-navigate" id="navigateBtn">
                        <i class="fas fa-directions"></i>
                        Navigate
                    </button>
                    <button type="button" class="action-btn btn-delivered" id="markDeliveredBtn">
                        <i class="fas fa-check-circle"></i>
                        Mark as Delivered
                    </button>
                    <button type="button" class="action-btn btn-call" id="callCustomerBtn">
                        <i class="fas fa-address-book"></i>
                        Contact Customer
                    </button>
                </div>
            </div>
        </div>

        <div class="hero-section offline" id="heroSection">
            <div class="icon-lg">
                <i class="fas fa-clock"></i>
            </div>
            <h2 id="heroTitle">Ready to Start?</h2>
            <p id="heroText">Turn on your availability to start receiving delivery requests and earning rewards.</p>
            <button type="button" class="btn btn--primary" id="goOnlineBtn">
                <i class="fas fa-power-off"></i>
                <span id="btnText">Go Online</span>
            </button>
        </div>

        <div class="deliveries-section" id="deliveriesSection" style="display: none;">
            <div class="section-title">
                <span>My Assigned Deliveries</span>
                <a href="#" class="view-all-link">
                    View All 
                    <i class="fas fa-arrow-right"></i>
                </a>
            </div>
            
            <div class="deliveries-grid" id="availableDeliveriesGrid">

                <%-- ── ASP Repeater: pulls Delivery tickets from [Delivery System].[dbo].[Tickets] ── --%>
                <asp:Repeater ID="rptDeliveries" runat="server">
                    <ItemTemplate>

                        <div class="delivery-card"
                             data-delivery-id='<%# Eval("TicketNumber") %>'>

                            <div class="delivery-header">
                                <span class="delivery-id">
                                    #<%# Eval("TicketNumber") %>
                                </span>
                                <span class='delivery-status <%# GetStatusCss(Eval("Status").ToString()) %>'>
                                    <%# Eval("Status") %>
                                </span>
                            </div>

                            <div class="delivery-info">
                                <div class="info-row">
                                    <span class="info-label">Order #:</span>
                                    <span class="info-value"><%# Eval("OrderNumber") %></span>
                                </div>
                                <div class="info-row">
                                    <span class="info-label">Delivery Address:</span>
                                    <span class="info-value"><%# Eval("DeliveryAddress") %></span>
                                </div>
                                <div class="info-row">
                                    <span class="info-label">Priority:</span>
                                    <span class="info-value"><%# Eval("Priority") %></span>
                                </div>
                                <div class="info-row">
                                    <span class="info-label">Customer:</span>
                                    <span class="info-value">
                                        <i class="fas fa-user" style="color:var(--muted-text);margin-right:4px;font-size:11px;"></i>
                                        <%# Eval("CustomerUsername") ?? Eval("CreatedBy") %>
                                    </span>
                                </div>
                                <div class="info-row">
                                    <span class="info-label">Phone:</span>
                                    <span class="info-value">
                                        <i class="fas fa-phone" style="color:var(--muted-text);margin-right:4px;font-size:11px;"></i>
                                        <%# string.IsNullOrEmpty(Eval("CustomerPhone")?.ToString()) ? "—" : Eval("CustomerPhone").ToString() %>
                                    </span>
                                </div>
                                <div class="info-row">
                                    <span class="info-label">Created At:</span>
                                    <span class="info-value"><%# Eval("CreatedAt", "{0:MMM dd, yyyy hh:mm tt}") %></span>
                                </div>
                                <div class="info-row">
                                    <span class="info-label">Total Amount:</span>
                                    <span class="info-value highlight">
                                        ₱<%# Eval("TotalAmount", "{0:N2}") %>
                                    </span>
                                </div>
                                <div class="info-row">
                                    <span class="info-label">Delivery Fee:</span>
                                    <span class="info-value highlight">
                                        <%# (Eval("DeliveryFee") == DBNull.Value || Eval("DeliveryFee") == null) ? "—" : "₱" + Convert.ToDecimal(Eval("DeliveryFee")).ToString("N2") %>
                                    </span>
                                </div>
                            </div>

                            <div class="delivery-actions">
                                <button type="button" class="btn-action btn--success accept-btn"
                                        data-ticket='<%# Eval("TicketNumber") %>'
                                        data-order='<%# Eval("OrderNumber") %>'
                                        data-address='<%# Eval("DeliveryAddress") %>'
                                        data-amount='<%# Eval("TotalAmount", "₱{0:N2}") %>'
                                        data-deliveryfee='<%# (Eval("DeliveryFee") == DBNull.Value || Eval("DeliveryFee") == null) ? "—" : "₱" + Convert.ToDecimal(Eval("DeliveryFee")).ToString("N2") %>'
                                        data-status='<%# Eval("Status") %>'
                                        data-priority='<%# Eval("Priority") %>'
                                        data-created='<%# Eval("CreatedAt", "{0:MMM dd, yyyy hh:mm tt}") %>'
                                        data-customer='<%# Eval("CustomerUsername") ?? Eval("CreatedBy") %>'
                                        data-phone='<%# string.IsNullOrEmpty(Eval("CustomerPhone")?.ToString()) ? "—" : Eval("CustomerPhone").ToString() %>'
                                        data-itemcount='<%# Eval("ItemCount") %>'
                                        data-items='<%# Server.HtmlEncode(Eval("ItemsHtml").ToString()) %>'>
                                    <i class="fas fa-check"></i>
                                    Accept
                                </button>
                                <button type="button" class="btn-action btn--danger decline-btn">
                                    <i class="fas fa-times"></i>
                                    Decline
                                </button>
                            </div>

                        </div>

                    </ItemTemplate>

                    <FooterTemplate>
                        <%-- Empty state shown when no rows are returned --%>
                        <asp:Panel ID="pnlEmpty" runat="server"
                                   Visible='<%# rptDeliveries.Items.Count == 0 %>'
                                   style="text-align:center;padding:40px;color:var(--muted-text);grid-column:1/-1;">
                            <i class="fas fa-inbox" style="font-size:48px;margin-bottom:12px;display:block;"></i>
                            No deliveries assigned to you right now.
                        </asp:Panel>
                    </FooterTemplate>
                </asp:Repeater>
                <%-- ────────────────────────────────────────────────────────────────────────── --%>

            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const toggleSwitch = document.getElementById('availabilityToggle');
            const goOnlineBtn = document.getElementById('goOnlineBtn');
            const heroSection = document.getElementById('heroSection');
            const deliveriesSection = document.getElementById('deliveriesSection');
            const activeDeliverySection = document.getElementById('activeDeliverySection');
            const statusText = document.getElementById('statusText');
            const statusTextHeader = document.getElementById('statusTextHeader');
            const onlineStatus = document.getElementById('onlineStatus');
            const statusIndicator = document.getElementById('statusIndicator');
            const heroTitle = document.getElementById('heroTitle');
            const heroText = document.getElementById('heroText');
            const btnText = document.getElementById('btnText');

            const activeDeliveryId = document.getElementById('activeDeliveryId');
            const pickupLocation = document.getElementById('pickupLocation');
            const dropoffLocation = document.getElementById('dropoffLocation');
            const deliveryFee = document.getElementById('deliveryFee');
            const customerContact = document.getElementById('customerContact');

            const navigateBtn = document.getElementById('navigateBtn');
            const markDeliveredBtn = document.getElementById('markDeliveredBtn');
            const callCustomerBtn = document.getElementById('callCustomerBtn');

            const completionModal = document.getElementById('completionModal');
            const completionOverlay = document.getElementById('completionOverlay');
            const cancelCompletionBtn = document.getElementById('cancelCompletion');
            const confirmCompletionBtn = document.getElementById('confirmCompletion');

            // ── Restore state from sessionStorage (persists across refresh) ──────────
            let isOnline = sessionStorage.getItem('rider_isOnline') === 'true';

            let activeDelivery = null;
            const savedTicket = sessionStorage.getItem('rider_ticketNumber');
            if (savedTicket) {
                activeDelivery = {
                    id: savedTicket,
                    order: sessionStorage.getItem('rider_orderNumber') || '',
                    address: sessionStorage.getItem('rider_address') || '',
                    amount: sessionStorage.getItem('rider_amount') || '',
                    deliveryFee: sessionStorage.getItem('rider_deliveryFee') || '—',
                    status: sessionStorage.getItem('rider_status') || '',
                    priority: sessionStorage.getItem('rider_priority') || '',
                    created: sessionStorage.getItem('rider_created') || '',
                    customer: sessionStorage.getItem('rider_customer') || '—',
                    phone: sessionStorage.getItem('rider_phone') || '—',
                    itemCount: sessionStorage.getItem('rider_itemCount') || '0',
                    itemsHtml: sessionStorage.getItem('rider_itemsHtml') || ''
                };
            }
            // ─────────────────────────────────────────────────────────────────────

            toggleSwitch.addEventListener('click', function () {
                isOnline = !isOnline;
                sessionStorage.setItem('rider_isOnline', isOnline ? 'true' : 'false');
                // Sync availability to DB (available ↔ offline)
                if (!activeDelivery) setRiderStatus(isOnline ? 'available' : 'offline');
                updateUI();
            });

            goOnlineBtn.addEventListener('click', function () {
                isOnline = !isOnline;
                sessionStorage.setItem('rider_isOnline', isOnline ? 'true' : 'false');
                // Sync availability to DB (available ↔ offline)
                if (!activeDelivery) setRiderStatus(isOnline ? 'available' : 'offline');
                updateUI();
            });

            document.addEventListener('click', function (e) {
                if (e.target.closest('.accept-btn')) {
                    const acceptBtn = e.target.closest('.accept-btn');
                    const deliveryCard = acceptBtn.closest('.delivery-card');

                    // Read all data directly from the button's data-* attributes (set by Repeater)
                    const deliveryData = {
                        id: acceptBtn.dataset.ticket,
                        order: acceptBtn.dataset.order,
                        address: acceptBtn.dataset.address,
                        amount: acceptBtn.dataset.amount,
                        deliveryFee: acceptBtn.dataset.deliveryfee || '—',
                        status: acceptBtn.dataset.status,
                        priority: acceptBtn.dataset.priority,
                        created: acceptBtn.dataset.created,
                        customer: acceptBtn.dataset.customer || '—',
                        phone: acceptBtn.dataset.phone || '—',
                        itemCount: acceptBtn.dataset.itemcount || '0',
                        itemsHtml: acceptBtn.dataset.items || ''
                    };

                    acceptDelivery(deliveryData, deliveryCard);
                }

                if (e.target.closest('.decline-btn')) {
                    const declineBtn = e.target.closest('.decline-btn');
                    const deliveryCard = declineBtn.closest('.delivery-card');

                    declineDelivery(deliveryCard);
                }
            });

            // ── Map Modal — Leaflet + OpenStreetMap (100% free, no API key) ───
            var STORE_LAT = 14.3298;
            var STORE_LNG = 120.9407;
            var STORE_ADDRESS = 'Zone 9, Blk 84, Lot 10 Bautista St, Zone 9, Dasmariñas, 4114 Cavite, Philippines';
            var BIAS_LAT = 14.3298;   // location bias center for Photon
            var BIAS_LNG = 120.9407;

            // ── DOM refs ──────────────────────────────────────────────────────
            var mapModal = document.getElementById('mapModal');
            var mapModalOverlay = document.getElementById('mapModalOverlay');
            var mapDistanceVal = document.getElementById('mapDistanceValue');
            var mapDurationVal = document.getElementById('mapDurationValue');
            var openGoogleMapsBtn = document.getElementById('openGoogleMapsBtn');
            var trackLocationBtn = document.getElementById('trackLocationBtn');
            var fixPinBtn = document.getElementById('fixPinBtn');
            var savePinBtn = document.getElementById('savePinBtn');
            var cancelFixBtn = document.getElementById('cancelFixBtn');
            var pinFixBanner = document.getElementById('pinFixBanner');

            // ── State ─────────────────────────────────────────────────────────
            var leafletMap = null;
            var routeLayer = null;
            var markersLayer = null;
            var storeMarker = null;
            var customerMarker = null;   // ← kept so Fix Pin can drag it
            var riderMarker = null;
            var riderCircle = null;
            var _watchId = null;
            var _isTracking = false;
            var _riderLat = null;
            var _riderLng = null;
            var _destLat = null;
            var _destLng = null;
            var _currentAddr = '';
            var _fixPinMode = false;
            var _geocodeCache = {};
            var PIN_KEY = 'tastenet_pins_v1';

            // ── localStorage pin store ────────────────────────────────────────
            function getSavedPin(addr) {
                try { return (JSON.parse(localStorage.getItem(PIN_KEY) || '{}')[addr]) || null; }
                catch (e) { return null; }
            }
            function savePin(addr, lat, lng) {
                try {
                    var s = JSON.parse(localStorage.getItem(PIN_KEY) || '{}');
                    s[addr] = { lat: lat, lng: lng };
                    localStorage.setItem(PIN_KEY, JSON.stringify(s));
                    _geocodeCache[addr] = { lat: lat, lng: lng, source: 'saved' };
                } catch (e) { }
            }

            // ── Leaflet init (once) ───────────────────────────────────────────
            function initLeafletMap() {
                if (leafletMap) return;
                leafletMap = L.map('mapFrame', { scrollWheelZoom: false })
                    .setView([STORE_LAT, STORE_LNG], 13);
                L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                    attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a>',
                    maxZoom: 19
                }).addTo(leafletMap);
                markersLayer = L.layerGroup().addTo(leafletMap);
            }

            // ── Custom circle-with-icon marker ────────────────────────────────
            function makeIcon(bg, glyph, size) {
                size = size || 34;
                return L.divIcon({
                    className: '',
                    html: '<div style="background:' + bg + ';width:' + size + 'px;height:' + size + 'px;'
                        + 'border-radius:50%;border:3px solid #fff;box-shadow:0 2px 8px rgba(0,0,0,.4);'
                        + 'display:flex;align-items:center;justify-content:center;'
                        + 'color:#fff;font-size:' + Math.round(size * 0.42) + 'px;">'
                        + glyph + '</div>',
                    iconSize: [size, size], iconAnchor: [size / 2, size / 2], popupAnchor: [0, -(size / 2)]
                });
            }

            // ── Geocoder: Photon (location-biased) → Nominatim fallback ──────
            function geocodeAddress(addr) {
                if (_geocodeCache[addr]) return Promise.resolve(_geocodeCache[addr]);

                var parts = addr.split(',').map(function (p) { return p.trim(); }).filter(Boolean);
                var addrPH = (addr.toLowerCase().indexOf('philippines') === -1)
                    ? addr + ', Philippines' : addr;

                // Pass 1: Photon with Dasmariñas bias
                function tryPhoton() {
                    return fetch('https://photon.komoot.io/api/?q=' + encodeURIComponent(addrPH)
                        + '&limit=1&lat=' + BIAS_LAT + '&lon=' + BIAS_LNG + '&lang=en')
                        .then(function (r) { return r.json(); })
                        .then(function (d) {
                            if (d.features && d.features.length) {
                                var c = d.features[0].geometry.coordinates;
                                return { lat: c[1], lng: c[0], source: 'photon' };
                            }
                            return tryNominatimStructured(0);
                        })
                        .catch(function () { return tryNominatimStructured(0); });
                }

                // Pass 2: Nominatim structured (city + country separately)
                var structCandidates = [];
                for (var i = Math.max(0, parts.length - 3); i < parts.length - 1; i++) {
                    structCandidates.push({ street: parts.slice(0, i + 1).join(', '), city: parts[i + 1] });
                }
                structCandidates.push({ city: parts[parts.length - 1] });

                function tryNominatimStructured(idx) {
                    if (idx >= structCandidates.length) return tryNominatimFree(0);
                    var c = structCandidates[idx];
                    var url = 'https://nominatim.openstreetmap.org/search?format=json&limit=1&countrycodes=ph'
                        + (c.street ? '&street=' + encodeURIComponent(c.street) : '')
                        + '&city=' + encodeURIComponent(c.city) + '&country=Philippines';
                    return fetch(url, { headers: { 'Accept-Language': 'en' } })
                        .then(function (r) { return r.json(); })
                        .then(function (d) {
                            if (d && d.length) return { lat: parseFloat(d[0].lat), lng: parseFloat(d[0].lon), source: 'nominatim-structured' };
                            return tryNominatimStructured(idx + 1);
                        })
                        .catch(function () { return tryNominatimStructured(idx + 1); });
                }

                // Pass 3: Nominatim free-text progressive
                var freeCandidates = [];
                for (var j = 0; j < parts.length; j++) {
                    var sl = parts.slice(j).join(', ');
                    if (sl.toLowerCase().indexOf('philippines') === -1) sl += ', Philippines';
                    freeCandidates.push(sl);
                }
                if (parts[parts.length - 1].toLowerCase().indexOf('cavite') === -1)
                    freeCandidates.push(parts[parts.length - 1] + ', Cavite, Philippines');

                function tryNominatimFree(idx) {
                    if (idx >= freeCandidates.length)
                        return Promise.reject(new Error('Address not found'));
                    var url = 'https://nominatim.openstreetmap.org/search?format=json&limit=1&countrycodes=ph'
                        + '&q=' + encodeURIComponent(freeCandidates[idx]);
                    return fetch(url, { headers: { 'Accept-Language': 'en' } })
                        .then(function (r) { return r.json(); })
                        .then(function (d) {
                            if (d && d.length) return { lat: parseFloat(d[0].lat), lng: parseFloat(d[0].lon), source: 'nominatim-free' };
                            return tryNominatimFree(idx + 1);
                        })
                        .catch(function () { return tryNominatimFree(idx + 1); });
                }

                return tryPhoton().then(function (r) { _geocodeCache[addr] = r; return r; });
            }

            // ── OSRM route ────────────────────────────────────────────────────
            function drawRoute(fLat, fLng, tLat, tLng) {
                return fetch('https://router.project-osrm.org/route/v1/driving/'
                    + fLng + ',' + fLat + ';' + tLng + ',' + tLat
                    + '?overview=full&geometries=geojson')
                    .then(function (r) { return r.json(); })
                    .then(function (d) {
                        if (!d.routes || !d.routes.length) throw new Error('No route');
                        var route = d.routes[0];
                        var distKm = (route.distance / 1000).toFixed(1);
                        var durMins = Math.round(route.duration / 60);
                        var durText = durMins >= 60
                            ? Math.floor(durMins / 60) + ' hr ' + (durMins % 60) + ' min'
                            : durMins + ' min';
                        if (routeLayer) leafletMap.removeLayer(routeLayer);
                        routeLayer = L.geoJSON(route.geometry, {
                            style: { color: '#6b0d1e', weight: 5, opacity: 0.85 }
                        }).addTo(leafletMap);
                        leafletMap.fitBounds(routeLayer.getBounds(), { padding: [40, 40] });
                        return { distKm: distKm, durText: durText };
                    });
            }

            // ── Update Google Maps button ─────────────────────────────────────
            function wireGoogleMapsBtn(destLat, destLng, rawAddress) {
                openGoogleMapsBtn.onclick = function () {
                    var origin = (_riderLat !== null)
                        ? (_riderLat + ',' + _riderLng)
                        : (STORE_LAT + ',' + STORE_LNG);
                    // If we have a saved/corrected pin use coords; otherwise raw address
                    var dest = (destLat !== null)
                        ? (destLat + ',' + destLng)
                        : rawAddress;
                    window.open('https://www.google.com/maps/dir/?api=1'
                        + '&origin=' + encodeURIComponent(origin)
                        + '&destination=' + encodeURIComponent(dest)
                        + '&travelmode=driving', '_blank');
                };
            }

            // ── Open modal ────────────────────────────────────────────────────
            function openMapModal(destinationAddress) {
                if (!destinationAddress || destinationAddress === '—') {
                    showNotification('No delivery address found.', 'warning');
                    return;
                }
                _currentAddr = destinationAddress;
                _destLat = null; _destLng = null;
                customerMarker = null;
                exitFixPinMode(false);

                // Show/hide "Saved Pin" badge
                var titleEl = document.querySelector('.map-modal-title');
                var oldBadge = titleEl ? titleEl.querySelector('.pin-saved-badge') : null;
                if (oldBadge) oldBadge.remove();

                var saved = getSavedPin(destinationAddress);
                if (saved) {
                    _geocodeCache[destinationAddress] = { lat: saved.lat, lng: saved.lng, source: 'saved' };
                    if (titleEl) {
                        var badge = document.createElement('span');
                        badge.className = 'pin-saved-badge';
                        badge.textContent = '📍 Saved';
                        titleEl.appendChild(badge);
                    }
                }

                // Reset stats bar
                mapDistanceVal.textContent = 'Calculating...';
                mapDistanceVal.className = 'map-distance-value loading';
                mapDurationVal.textContent = 'Calculating...';
                mapDurationVal.className = 'map-distance-value loading';

                document.body.style.overflow = 'hidden';
                mapModal.classList.add('active');
                mapModalOverlay.classList.add('active');

                setTimeout(function () {
                    initLeafletMap();
                    leafletMap.invalidateSize();

                    // Clear previous markers & route
                    markersLayer.clearLayers();
                    customerMarker = null;
                    if (routeLayer) { leafletMap.removeLayer(routeLayer); routeLayer = null; }

                    // Store origin marker
                    storeMarker = L.marker([STORE_LAT, STORE_LNG], {
                        icon: makeIcon('#6b0d1e', '&#x2302;')
                    }).bindPopup('<strong>TasteNet Store</strong><br>' + STORE_ADDRESS)
                        .addTo(markersLayer);

                    // Default Google Maps button to raw address (works even if geocode fails)
                    wireGoogleMapsBtn(null, null, destinationAddress);

                    // Geocode → place customer pin → draw route
                    geocodeAddress(destinationAddress)
                        .then(function (dest) {
                            _destLat = dest.lat;
                            _destLng = dest.lng;

                            // Place draggable customer marker (dragging off by default)
                            customerMarker = L.marker([dest.lat, dest.lng], {
                                icon: makeIcon('#2d9d78', '&#x25CF;'),
                                draggable: false,
                                autoPan: true
                            })
                                .bindPopup('<strong>Customer</strong><br>'
                                    + destinationAddress
                                    + (dest.source === 'saved' ? '<br><em style="color:#2d9d78;">📍 Saved pin</em>' : ''))
                                .openPopup()
                                .addTo(markersLayer);

                            // Update Google Maps btn with geocoded coords
                            wireGoogleMapsBtn(dest.lat, dest.lng, destinationAddress);

                            var fromLat = _riderLat !== null ? _riderLat : STORE_LAT;
                            var fromLng = _riderLng !== null ? _riderLng : STORE_LNG;
                            return drawRoute(fromLat, fromLng, dest.lat, dest.lng);
                        })
                        .then(function (info) {
                            mapDistanceVal.textContent = info.distKm + ' km';
                            mapDistanceVal.className = 'map-distance-value';
                            mapDurationVal.textContent = info.durText;
                            mapDurationVal.className = 'map-distance-value';
                        })
                        .catch(function () {
                            mapDistanceVal.textContent = 'Unavailable';
                            mapDistanceVal.className = 'map-distance-value';
                            mapDurationVal.textContent = 'Unavailable';
                            mapDurationVal.className = 'map-distance-value';
                            showNotification('Could not locate address. Try Fix Pin.', 'warning');
                        });
                }, 120);
            }

            // ── Close modal ───────────────────────────────────────────────────
            function closeMapModal() {
                exitFixPinMode(false);
                if (_isTracking) stopTracking();
                mapModal.classList.remove('active');
                mapModalOverlay.classList.remove('active');
                document.body.style.overflow = '';
            }

            document.getElementById('mapModalCloseX').addEventListener('click', closeMapModal);
            document.getElementById('mapModalCloseBtn').addEventListener('click', closeMapModal);
            mapModalOverlay.addEventListener('click', closeMapModal);
            document.addEventListener('keydown', function (e) {
                if (e.key === 'Escape' && mapModal.classList.contains('active')) closeMapModal();
            });
            window.addEventListener('resize', function () {
                if (leafletMap && mapModal.classList.contains('active'))
                    setTimeout(function () { leafletMap.invalidateSize(); }, 200);
            });

            // ── Fix Pin (drag to correct) ─────────────────────────────────────
            function enterFixPinMode() {
                if (!customerMarker) {
                    showNotification('Wait for the pin to load first.', 'warning');
                    return;
                }
                _fixPinMode = true;
                customerMarker.dragging.enable();
                customerMarker.setOpacity(0.8);
                pinFixBanner.style.display = 'flex';
                fixPinBtn.style.display = 'none';
                leafletMap.scrollWheelZoom.enable();
                showNotification('Drag the green pin to the correct spot, then tap Save Pin.', 'info');
            }

            function exitFixPinMode(doSave) {
                if (!_fixPinMode) return;
                _fixPinMode = false;
                pinFixBanner.style.display = 'none';
                fixPinBtn.style.display = '';

                if (!customerMarker) return;
                customerMarker.dragging.disable();
                customerMarker.setOpacity(1);
                leafletMap.scrollWheelZoom.disable();

                if (doSave) {
                    var ll = customerMarker.getLatLng();
                    _destLat = ll.lat;
                    _destLng = ll.lng;
                    savePin(_currentAddr, ll.lat, ll.lng);
                    wireGoogleMapsBtn(ll.lat, ll.lng, _currentAddr);
                    showNotification('Pin saved! Will use this location next time.', 'success');

                    // Redraw route from corrected pin
                    var fromLat = _riderLat !== null ? _riderLat : STORE_LAT;
                    var fromLng = _riderLng !== null ? _riderLng : STORE_LNG;
                    mapDistanceVal.textContent = 'Calculating...';
                    mapDurationVal.textContent = 'Calculating...';
                    drawRoute(fromLat, fromLng, ll.lat, ll.lng)
                        .then(function (info) {
                            mapDistanceVal.textContent = info.distKm + ' km';
                            mapDurationVal.textContent = info.durText;
                        }).catch(function () { });
                } else {
                    // Revert to last good position
                    if (_destLat !== null) customerMarker.setLatLng([_destLat, _destLng]);
                }
            }

            fixPinBtn.addEventListener('click', function () { enterFixPinMode(); });
            savePinBtn.addEventListener('click', function () { exitFixPinMode(true); });
            cancelFixBtn.addEventListener('click', function () { exitFixPinMode(false); });

            // ── Live Rider Tracking ───────────────────────────────────────────
            function updateRiderOnMap(lat, lng, accuracy) {
                _riderLat = lat; _riderLng = lng;

                if (riderMarker) {
                    riderMarker.setLatLng([lat, lng]);
                    if (riderCircle) riderCircle.setLatLng([lat, lng]).setRadius(accuracy);
                } else {
                    riderMarker = L.marker([lat, lng], {
                        icon: makeIcon('#3b82f6', '<i class="fas fa-motorcycle" style="font-size:13px;"></i>', 36),
                        zIndexOffset: 1000
                    }).bindPopup('<strong>You (Rider)</strong><br>Live location').addTo(markersLayer);
                    riderCircle = L.circle([lat, lng], {
                        radius: accuracy, color: '#3b82f6',
                        fillColor: '#3b82f6', fillOpacity: 0.1, weight: 1
                    }).addTo(markersLayer);
                }

                if (_destLat !== null) {
                    drawRoute(lat, lng, _destLat, _destLng)
                        .then(function (info) {
                            mapDistanceVal.textContent = info.distKm + ' km (from you)';
                            mapDurationVal.textContent = info.durText;
                        }).catch(function () { });
                } else {
                    leafletMap.setView([lat, lng], 15);
                }
            }

            function startTracking() {
                if (!navigator.geolocation) {
                    showNotification('Geolocation not supported.', 'warning');
                    return;
                }
                _isTracking = true;
                trackLocationBtn.classList.add('tracking');
                trackLocationBtn.innerHTML = '<i class="fas fa-crosshairs"></i> Tracking...';
                showNotification('Live tracking started!', 'success');
                _watchId = navigator.geolocation.watchPosition(
                    function (pos) { updateRiderOnMap(pos.coords.latitude, pos.coords.longitude, pos.coords.accuracy); },
                    function (err) { showNotification('GPS error: ' + err.message, 'warning'); stopTracking(); },
                    { enableHighAccuracy: true, maximumAge: 5000, timeout: 10000 }
                );
            }

            function stopTracking() {
                if (_watchId !== null) { navigator.geolocation.clearWatch(_watchId); _watchId = null; }
                _isTracking = false;
                _riderLat = null; _riderLng = null;
                trackLocationBtn.classList.remove('tracking');
                trackLocationBtn.innerHTML = '<i class="fas fa-crosshairs"></i> Use My Location';
                if (riderMarker) { markersLayer.removeLayer(riderMarker); riderMarker = null; }
                if (riderCircle) { markersLayer.removeLayer(riderCircle); riderCircle = null; }
                showNotification('Tracking stopped.', 'info');
            }

            trackLocationBtn.addEventListener('click', function () {
                if (_isTracking) stopTracking(); else startTracking();
            });
            // ─────────────────────────────────────────────────────────────────

            navigateBtn.addEventListener('click', function () {
                if (!activeDelivery || !activeDelivery.address) {
                    showNotification('No delivery address found.', 'warning');
                    return;
                }
                var dest = activeDelivery.address;
                if (dest.toLowerCase().indexOf('philippines') === -1) dest += ', Philippines';
                var origin = encodeURIComponent(STORE_ADDRESS);
                window.open('https://www.google.com/maps/dir/?api=1'
                    + '&origin=' + origin
                    + '&destination=' + encodeURIComponent(dest)
                    + '&travelmode=driving', '_blank');
            });
            // ─────────────────────────────────────────────────────────────────────

            // ─────────────────────────────────────────────────────────────────────

            markDeliveredBtn.addEventListener('click', function () {
                showDeliveryCompletionModal();
            });

            callCustomerBtn.addEventListener('click', function () {
                if (!activeDelivery) return;
                var phone = activeDelivery.phone || '';
                if (!phone || phone === '—') {
                    showNotification('No contact number available.', 'warning');
                    return;
                }
                if (navigator.clipboard && navigator.clipboard.writeText) {
                    navigator.clipboard.writeText(phone).then(function () {
                        showNotification('Contact number copied: ' + phone, 'success');
                    }).catch(function () {
                        fallbackCopy(phone);
                    });
                } else {
                    fallbackCopy(phone);
                }
            });

            function fallbackCopy(text) {
                var ta = document.createElement('textarea');
                ta.value = text;
                ta.style.cssText = 'position:fixed;top:-999px;left:-999px;opacity:0;';
                document.body.appendChild(ta);
                ta.select();
                try {
                    document.execCommand('copy');
                    showNotification('Contact number copied: ' + text, 'success');
                } catch (e) {
                    showNotification('Could not copy. Number: ' + text, 'warning');
                }
                document.body.removeChild(ta);
            }

            // ── Proof of Delivery setup ─────────────────────────────
            const proofUploadArea = document.getElementById('proofUploadArea');
            const proofPhotoInput = document.getElementById('proofPhotoInput');
            const proofPlaceholder = document.getElementById('proofPlaceholder');
            const proofPreview = document.getElementById('proofPreview');
            const proofRetakeBtn = document.getElementById('proofRetakeBtn');

            proofUploadArea.addEventListener('click', function (e) {
                if (e.target === proofRetakeBtn || proofRetakeBtn.contains(e.target)) return;
                proofPhotoInput.click();
            });

            proofRetakeBtn.addEventListener('click', function (e) {
                e.stopPropagation();
                resetProof();
                proofPhotoInput.click();
            });

            proofPhotoInput.addEventListener('change', function () {
                const file = proofPhotoInput.files[0];
                if (!file) return;

                const reader = new FileReader();
                reader.onload = function (ev) {
                    proofPreview.src = ev.target.result;
                    proofPreview.style.display = 'block';
                    proofPlaceholder.style.display = 'none';
                    proofRetakeBtn.style.display = 'inline-flex';
                    proofUploadArea.classList.add('has-photo');
                    confirmCompletionBtn.disabled = false;
                };
                reader.readAsDataURL(file);
            });

            function resetProof() {
                proofPhotoInput.value = '';
                proofPreview.src = '';
                proofPreview.style.display = 'none';
                proofPlaceholder.style.display = 'flex';
                proofRetakeBtn.style.display = 'none';
                proofUploadArea.classList.remove('has-photo');
                confirmCompletionBtn.disabled = true;
            }
            // ────────────────────────────────────────────────────────

            function showDeliveryCompletionModal() {
                if (!activeDelivery) {
                    showNotification('No active delivery to mark as delivered', 'warning');
                    return;
                }

                resetProof();
                document.body.style.overflow = 'hidden';
                completionModal.classList.add('active');
                completionOverlay.classList.add('active');

                setTimeout(() => { cancelCompletionBtn.focus(); }, 100);
            }

            function hideDeliveryCompletionModal() {
                document.body.style.overflow = '';

                completionModal.classList.remove('active');
                completionOverlay.classList.remove('active');
            }

            document.addEventListener('keydown', function (e) {
                if (e.key === 'Escape' && completionModal.classList.contains('active')) {
                    hideDeliveryCompletionModal();
                    showNotification('Delivery completion cancelled', 'info');
                }
            });

            cancelCompletionBtn.addEventListener('click', function () {
                hideDeliveryCompletionModal();
                showNotification('Delivery completion cancelled', 'info');
            });

            confirmCompletionBtn.addEventListener('click', function () {
                hideDeliveryCompletionModal();
                completeDelivery();
            });

            completionOverlay.addEventListener('click', function () {
                hideDeliveryCompletionModal();
                showNotification('Delivery completion cancelled', 'info');
            });

            // ── Sync rider status to DB so admin dashboard reflects it ───────────
            function setRiderStatus(status) {
                fetch(window.location.pathname + '?setStatus=' + encodeURIComponent(status), {
                    method: 'POST',
                    credentials: 'same-origin'
                }).catch(function () {
                    // Silent fail — the UI is already updated; DB sync is best-effort
                });
            }
            // ─────────────────────────────────────────────────────────────────────

            function acceptDelivery(deliveryData, deliveryCard) {
                activeDelivery = deliveryData;

                // Persist to sessionStorage so a page refresh restores the active delivery
                sessionStorage.setItem('rider_ticketNumber', deliveryData.id);
                sessionStorage.setItem('rider_orderNumber', deliveryData.order);
                sessionStorage.setItem('rider_address', deliveryData.address);
                sessionStorage.setItem('rider_amount', deliveryData.amount);
                sessionStorage.setItem('rider_deliveryFee', deliveryData.deliveryFee || '—');
                sessionStorage.setItem('rider_status', deliveryData.status);
                sessionStorage.setItem('rider_priority', deliveryData.priority);
                sessionStorage.setItem('rider_created', deliveryData.created);
                sessionStorage.setItem('rider_customer', deliveryData.customer || '—');
                sessionStorage.setItem('rider_phone', deliveryData.phone || '—');
                sessionStorage.setItem('rider_itemCount', deliveryData.itemCount || '0');
                sessionStorage.setItem('rider_itemsHtml', deliveryData.itemsHtml || '');
                sessionStorage.setItem('rider_isOnline', 'true');

                // ── Sync status to DB so admin dashboard shows "On Delivery" ──────
                setRiderStatus('delivery');
                // ─────────────────────────────────────────────────────────────────

                // Populate the active delivery panel with real DB data
                activeDeliveryId.textContent = '#' + deliveryData.id;
                pickupLocation.textContent = 'Order #' + deliveryData.order;
                dropoffLocation.textContent = deliveryData.address;
                deliveryFee.textContent = deliveryData.deliveryFee || '—';
                customerContact.innerHTML =
                    '<strong>' + (deliveryData.customer || '—') + '</strong>' +
                    '<span style="display:block;font-size:12px;color:var(--muted-text);margin-top:2px;">' +
                    '<i class="fas fa-phone" style="margin-right:4px;font-size:10px;"></i>' +
                    (deliveryData.phone || '—') + '</span>';

                // ── Inject order items into the active delivery panel ──────────
                var activeItemCount = document.getElementById('activeItemCount');
                var activeItemsBody = document.getElementById('activeOrderItemsBody');
                if (activeItemCount) activeItemCount.textContent = deliveryData.itemCount || '0';
                if (activeItemsBody) {
                    // itemsHtml was HTML-encoded by Server.HtmlEncode on the data-* attr — decode it
                    var decoded = document.createElement('textarea');
                    decoded.innerHTML = deliveryData.itemsHtml || '';
                    activeItemsBody.innerHTML = decoded.value ||
                        '<div class="order-item-row"><span class="order-item-name" style="color:var(--muted-text);font-style:italic;">No items found.</span></div>';
                }
                // ─────────────────────────────────────────────────────────────

                activeDeliverySection.classList.add('active');
                deliveriesSection.style.display = 'none';

                // Animate card out
                deliveryCard.style.opacity = '0.5';
                deliveryCard.style.pointerEvents = 'none';
                setTimeout(() => {
                    deliveryCard.style.transform = 'translateX(100%)';
                    deliveryCard.style.opacity = '0';
                    setTimeout(() => { deliveryCard.style.display = 'none'; }, 300);
                }, 100);

                showNotification('Ticket #' + deliveryData.id + ' accepted! Heading to ' + deliveryData.address, 'success');
            }

            function declineDelivery(deliveryCard) {
                // Disable interactions immediately
                deliveryCard.style.pointerEvents = 'none';

                // Fade + shrink out (works inside CSS grid unlike translateX)
                deliveryCard.style.transition = 'opacity 0.3s ease, transform 0.3s ease';
                deliveryCard.style.opacity = '0';
                deliveryCard.style.transform = 'scale(0.92)';

                setTimeout(() => {
                    // Collapse height so grid reflows smoothly
                    deliveryCard.style.transition = 'all 0.25s ease';
                    deliveryCard.style.overflow = 'hidden';
                    deliveryCard.style.maxHeight = deliveryCard.offsetHeight + 'px';
                    // Force reflow
                    deliveryCard.offsetHeight;
                    deliveryCard.style.maxHeight = '0';
                    deliveryCard.style.padding = '0';
                    deliveryCard.style.margin = '0';
                    deliveryCard.style.border = 'none';

                    setTimeout(() => {
                        deliveryCard.remove();
                    }, 250);
                }, 300);

                showNotification('Delivery declined', 'info');
            }

            function completeDelivery() {
                if (!activeDelivery) {
                    showNotification('No active delivery to complete', 'warning');
                    return;
                }

                const ticketNumber = activeDelivery.id;
                if (!ticketNumber) {
                    showNotification('Could not find ticket number.', 'warning');
                    return;
                }

                // ── POST with FormData — sends ticket number + proof photo ──────
                const completeUrl = window.location.pathname + '?completeTicket=' + encodeURIComponent(ticketNumber);

                const formData = new FormData();
                // Attach the proof photo selected in the modal (field name must match
                // Request.Files["proofPhoto"] in the code-behind)
                const proofInput = document.getElementById('proofPhotoInput');
                if (proofInput && proofInput.files && proofInput.files[0]) {
                    formData.append('proofPhoto', proofInput.files[0]);
                }

                fetch(completeUrl, {
                    method: 'POST',
                    credentials: 'same-origin',
                    body: formData   // browser sets multipart/form-data + boundary automatically
                })
                    .then(r => {
                        if (r.status === 403) throw new Error('FORBIDDEN');
                        return r.text();
                    })
                    .then(response => {
                        if (response.trim() !== 'OK') {
                            showNotification('Could not update ticket. Please try again.', 'warning');
                            return;
                        }

                        // Clear sessionStorage before reload so panel does not restore
                        sessionStorage.removeItem('rider_ticketNumber');
                        sessionStorage.removeItem('rider_orderNumber');
                        sessionStorage.removeItem('rider_address');
                        sessionStorage.removeItem('rider_amount');
                        sessionStorage.removeItem('rider_deliveryFee');
                        sessionStorage.removeItem('rider_status');
                        sessionStorage.removeItem('rider_priority');
                        sessionStorage.removeItem('rider_created');
                        sessionStorage.removeItem('rider_customer');
                        sessionStorage.removeItem('rider_phone');

                        // ── Sync status back to available in DB ───────────────────
                        setRiderStatus('available');
                        // ─────────────────────────────────────────────────────────

                        window.location.reload();
                    })
                    .catch(err => {
                        if (err.message === 'FORBIDDEN')
                            showNotification('This delivery is not assigned to you.', 'warning');
                        else
                            showNotification('Network error. Please try again.', 'warning');
                    });
                // ─────────────────────────────────────────────────────────────

                showNotification('Marking delivery as completed...', 'info');
            }

            // ── Toggle order items collapsible ──────────────────────────────
            function toggleOrderItems(btn) {
                btn.classList.toggle('open');
                const body = btn.nextElementSibling;
                body.classList.toggle('open');
            }

            // Flash animation when a stat value updates
            function animateStat(el) {
                el.style.transition = 'color 0.2s ease, transform 0.2s ease';
                el.style.color = 'var(--success-green)';
                el.style.transform = 'scale(1.15)';
                setTimeout(() => {
                    el.style.color = '';
                    el.style.transform = '';
                }, 800);
            }

            // Recompute a trend label from new vs old values
            function updateTrendLabel(trendId, newVal, oldVal, label) {
                const el = document.getElementById(trendId);
                if (!el) return;

                if (oldVal === 0) {
                    el.className = 'trend-up';
                    el.innerHTML = '<i class="fas fa-minus"></i> No data yesterday';
                    return;
                }

                const pct = ((newVal - oldVal) / oldVal * 100).toFixed(1);
                const up = parseFloat(pct) >= 0;
                el.className = up ? 'trend-up' : 'trend-down';
                el.innerHTML = '<i class="fas ' + (up ? 'fa-arrow-up' : 'fa-arrow-down') + '"></i> '
                    + (up ? '+' : '') + pct + '% ' + label;
            }

            function updateUI() {
                if (isOnline) {
                    statusTextHeader.textContent = 'ONLINE';
                    onlineStatus.className = 'online-status';

                    statusText.textContent = 'Currently online';
                    statusText.style.color = 'var(--success-green)';

                    statusIndicator.textContent = 'ONLINE';
                    statusIndicator.className = 'status-indicator online';

                    toggleSwitch.classList.add('active');
                    toggleSwitch.querySelector('.toggle-knob i').className = 'fas fa-check';
                    toggleSwitch.querySelector('.toggle-knob i').style.color = 'var(--success-green)';

                    heroSection.className = 'hero-section online';
                    heroSection.querySelector('.icon-lg').innerHTML = '<i class="fas fa-bolt"></i>';
                    heroTitle.textContent = "You're Online!";
                    heroText.textContent = "You're now receiving delivery requests. Stay alert for new orders!";
                    btnText.textContent = "Go Offline";
                    goOnlineBtn.querySelector('i').className = 'fas fa-power-off';

                    if (!activeDelivery) {
                        deliveriesSection.style.display = 'block';
                    }

                    if (!activeDelivery) {
                        activeDeliverySection.classList.remove('active');
                    }

                    showNotification('You are now online and receiving orders!', 'success');
                } else {
                    statusTextHeader.textContent = 'OFFLINE';
                    onlineStatus.className = 'online-status offline';

                    statusText.textContent = 'Currently offline';
                    statusText.style.color = 'var(--muted-text)';

                    statusIndicator.textContent = 'OFFLINE';
                    statusIndicator.className = 'status-indicator offline';

                    toggleSwitch.classList.remove('active');
                    toggleSwitch.querySelector('.toggle-knob i').className = 'fas fa-times';
                    toggleSwitch.querySelector('.toggle-knob i').style.color = '#999';

                    heroSection.className = 'hero-section offline';
                    heroSection.querySelector('.icon-lg').innerHTML = '<i class="fas fa-clock"></i>';
                    heroTitle.textContent = "Ready to Start?";
                    heroText.textContent = "Turn on your availability to start receiving delivery requests and earning rewards.";
                    btnText.textContent = "Go Online";
                    goOnlineBtn.querySelector('i').className = 'fas fa-power-off';

                    deliveriesSection.style.display = 'none';
                    if (!activeDelivery) {
                        activeDeliverySection.classList.remove('active');
                    }

                    showNotification('You are now offline', 'info');
                }
            }

            function showNotification(message, type) {
                const notification = document.createElement('div');
                notification.style.cssText = `
                    position: fixed;
                    top: 20px;
                    right: 20px;
                    padding: 15px 20px;
                    background: ${type === 'success' ? 'var(--success-green)' :
                        type === 'info' ? 'var(--accent-blue-dark)' :
                            type === 'warning' ? 'var(--warning-orange)' :
                                'var(--danger-red)'};
                    color: white;
                    border-radius: var(--radius-md);
                    box-shadow: 0 4px 12px rgba(0,0,0,0.15);
                    z-index: 10001;
                    animation: slideInRight 0.3s ease;
                    display: flex;
                    align-items: center;
                    gap: 10px;
                    max-width: 300px;
                    font-family: 'Poppins', sans-serif;
                `;
                notification.innerHTML = `
                    <i class="fas ${type === 'success' ? 'fa-check-circle' :
                        type === 'info' ? 'fa-info-circle' :
                            type === 'warning' ? 'fa-exclamation-triangle' :
                                'fa-exclamation-circle'}"></i>
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



            // On page load — if there was an active delivery, restore the UI panel
            if (activeDelivery) {
                activeDeliveryId.textContent = '#' + activeDelivery.id;
                pickupLocation.textContent = 'Order #' + activeDelivery.order;
                dropoffLocation.textContent = activeDelivery.address;
                deliveryFee.textContent = activeDelivery.deliveryFee || '—';
                customerContact.innerHTML =
                    '<strong>' + (activeDelivery.customer || '—') + '</strong>' +
                    '<span style="display:block;font-size:12px;color:var(--muted-text);margin-top:2px;">' +
                    '<i class="fas fa-phone" style="margin-right:4px;font-size:10px;"></i>' +
                    (activeDelivery.phone || '—') + '</span>';
                // Restore order items (fixes items going blank/zero on tab switch)
                var activeItemCount = document.getElementById('activeItemCount');
                var activeItemsBody = document.getElementById('activeOrderItemsBody');
                if (activeItemCount) activeItemCount.textContent = activeDelivery.itemCount || '0';
                if (activeItemsBody) {
                    var decoded = document.createElement('textarea');
                    decoded.innerHTML = activeDelivery.itemsHtml || '';
                    activeItemsBody.innerHTML = decoded.value ||
                        '<div class="order-item-row"><span class="order-item-name" style="color:var(--muted-text);font-style:italic;">No items found.</span></div>';
                }

                activeDeliverySection.classList.add('active');
            }

            updateUI();
        });
    </script>
</asp:Content>