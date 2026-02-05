<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Rider.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="TasteNet.Users.Rider.Dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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

        .dashboard-wrapper {
            background: var(--soft-cream) !important;
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
            grid-template-columns: repeat(4, 1fr);
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
            padding: 12px;
            border-radius: var(--radius-md);
            font-weight: 600;
            font-size: 12px;
            cursor: pointer;
            border: none;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            transition: all var(--transition-base);
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
        }

        @media (max-width: 768px) {
            .stats-grid {
                grid-template-columns: 1fr;
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
                padding: 20px;
            }
            
            .delivery-actions {
                flex-direction: column;
            }
            
            .btn-action {
                width: 100%;
            }

            .completion-modal {
                padding: 20px;
                max-width: 350px;
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
        }

        @media (max-width: 480px) {
            .dashboard-wrapper {
                padding: 15px;
            }
            
            .header-title h1 {
                font-size: 20px;
            }
            
            .stat-value {
                font-size: 28px;
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
                max-width: 320px;
            }
        }

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
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="modal-overlay" id="completionOverlay"></div>
    <div class="completion-modal" id="completionModal">
        <div class="modal-icon">
            <i class="fas fa-check-circle"></i>
        </div>
        <h3 class="modal-title">Mark Delivery as Completed?</h3>
        <p class="modal-message">This will mark the current delivery as delivered and update your earnings.</p>
        <div class="modal-actions">
            <button type="button" class="modal-btn modal-btn-cancel" id="cancelCompletion">
                <i class="fas fa-times"></i>
                Cancel
            </button>
            <button type="button" class="modal-btn modal-btn-confirm" id="confirmCompletion">
                <i class="fas fa-check"></i>
                Yes, Mark Delivered
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
            <div class="stat-card">
                <div>
                    <div class="stat-card__content">
                        <div>
                            <div class="stat-label">Total Deliveries</div>
                            <div class="stat-value">156</div>
                        </div>
                        <div class="icon-circle">
                            <i class="fas fa-box"></i>
                        </div>
                    </div>
                    <div class="trend-up">
                        <i class="fas fa-arrow-up"></i>
                        +12% from yesterday
                    </div>
                </div>
            </div>

            <div class="stat-card">
                <div>
                    <div class="stat-card__content">
                        <div>
                            <div class="stat-label">Earnings Today</div>
                            <div class="stat-value">₱2,450</div>
                        </div>
                        <div class="icon-circle">
                            <i class="fas fa-peso-sign"></i>
                        </div>
                    </div>
                    <div class="trend-up">
                        <i class="fas fa-arrow-up"></i>
                        +8% from yesterday
                    </div>
                </div>
            </div>

            <div class="stat-card">
                <div>
                    <div class="stat-card__content">
                        <div>
                            <div class="stat-label">Completed</div>
                            <div class="stat-value">148</div>
                        </div>
                        <div class="icon-circle">
                            <i class="fas fa-check-circle"></i>
                        </div>
                    </div>
                    <div class="trend-up">
                        <i class="fas fa-arrow-up"></i>
                        +23 new today
                    </div>
                </div>
            </div>

            <div class="stat-card">
                <div>
                    <div class="stat-card__content">
                        <div>
                            <div class="stat-label">Avg. Time</div>
                            <div class="stat-value">18 min</div>
                        </div>
                        <div class="icon-circle">
                            <i class="fas fa-clock"></i>
                        </div>
                    </div>
                    <div class="trend-up">
                        <i class="fas fa-chart-line"></i>
                        Excellent timing
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
                    <span class="active-delivery-id" id="activeDeliveryId">#DL-4567</span>
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
                                <div class="location-value" id="pickupLocation">Caballeros, Dasma</div>
                            </div>
                        </div>
                        
                        <div class="location-row">
                            <div class="location-icon">
                                <i class="fas fa-flag-checkered"></i>
                            </div>
                            <div class="location-info">
                                <div class="location-label">Drop-off Location</div>
                                <div class="location-value" id="dropoffLocation">Pala-Pala, Dasma</div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="delivery-details-section">
                        <div class="detail-row">
                            <span class="detail-label">Distance</span>
                            <span class="detail-value" id="deliveryDistance">2.5 km</span>
                        </div>
                        <div class="detail-row">
                            <span class="detail-label">Delivery Fee</span>
                            <span class="detail-value highlight" id="deliveryFee">₱85</span>
                        </div>
                        <div class="detail-row">
                            <span class="detail-label">Est. Time</span>
                            <span class="detail-value" id="deliveryTime">15 min</span>
                        </div>
                    </div>
                </div>
                
                <div class="customer-contact-section">
                    <div class="contact-icon">
                        <i class="fas fa-phone"></i>
                    </div>
                    <div class="contact-info">
                        <div class="contact-label">Customer Contact</div>
                        <div class="contact-number" id="customerContact">(+63) 917-111-2222</div>
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
                        <i class="fas fa-phone-alt"></i>
                        Call Customer
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
                <span>Available Deliveries</span>
                <a href="#" class="view-all-link">
                    View All 
                    <i class="fas fa-arrow-right"></i>
                </a>
            </div>
            
            <div class="deliveries-grid" id="availableDeliveriesGrid">
                <div class="delivery-card" data-delivery-id="DL-4567">
                    <div class="delivery-header">
                        <span class="delivery-id">#DL-4567</span>
                        <span class="delivery-status status-pending">Pending</span>
                    </div>
                    <div class="delivery-info">
                        <div class="info-row">
                            <span class="info-label">Customer:</span>
                            <span class="info-value">Jester Parker</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Pickup:</span>
                            <span class="info-value">Caballeros, Dasma</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Drop-off:</span>
                            <span class="info-value">Pala-Pala, Dasma</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Distance:</span>
                            <span class="info-value">2.5 km</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Earnings:</span>
                            <span class="info-value highlight">₱85</span>
                        </div>
                    </div>
                    <div class="delivery-actions">
                        <button type="button" class="btn-action btn--success accept-btn">
                            <i class="fas fa-check"></i>
                            Accept
                        </button>
                        <button type="button" class="btn-action btn--danger decline-btn">
                            <i class="fas fa-times"></i>
                            Decline
                        </button>
                    </div>
                </div>

                <div class="delivery-card" data-delivery-id="DL-4568">
                    <div class="delivery-header">
                        <span class="delivery-id">#DL-4568</span>
                        <span class="delivery-status status-pending">Pending</span>
                    </div>
                    <div class="delivery-info">
                        <div class="info-row">
                            <span class="info-label">Customer:</span>
                            <span class="info-value">Syren mukang kambing</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Pickup:</span>
                            <span class="info-value">Caballeros, Dasma</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Drop-off:</span>
                            <span class="info-value">Salitran, Dasma</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Distance:</span>
                            <span class="info-value">1.8 km</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Earnings:</span>
                            <span class="info-value highlight">₱65</span>
                        </div>
                    </div>
                    <div class="delivery-actions">
                        <button type="button" class="btn-action btn--success accept-btn">
                            <i class="fas fa-check"></i>
                            Accept
                        </button>
                        <button type="button" class="btn-action btn--danger decline-btn">
                            <i class="fas fa-times"></i>
                            Decline
                        </button>
                    </div>
                </div>
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
            const deliveryDistance = document.getElementById('deliveryDistance');
            const deliveryFee = document.getElementById('deliveryFee');
            const deliveryTime = document.getElementById('deliveryTime');
            const customerContact = document.getElementById('customerContact');

            const navigateBtn = document.getElementById('navigateBtn');
            const markDeliveredBtn = document.getElementById('markDeliveredBtn');
            const callCustomerBtn = document.getElementById('callCustomerBtn');

            const completionModal = document.getElementById('completionModal');
            const completionOverlay = document.getElementById('completionOverlay');
            const cancelCompletionBtn = document.getElementById('cancelCompletion');
            const confirmCompletionBtn = document.getElementById('confirmCompletion');

            let isOnline = false;
            let activeDelivery = null;
            let availableDeliveries = [
                {
                    id: 'DL-4567',
                    customer: 'Jester Parker',
                    pickup: 'Caballeros, Dasma',
                    dropoff: 'Pala-Pala, Dasma',
                    distance: '2.5 km',
                    fee: '₱85',
                    time: '15 min',
                    items: '2 Tapsilog Meals',
                    contact: '(+63) 917-111-2222'
                },
                {
                    id: 'DL-4568',
                    customer: 'Syren mukang kambing',
                    pickup: 'Caballeros, Dasma',
                    dropoff: 'Salitran, Dasma',
                    distance: '1.8 km',
                    fee: '₱65',
                    time: '12 min',
                    items: '2 meals',
                    contact: '(+63) 918-222-3333'
                }
            ];

            toggleSwitch.addEventListener('click', function () {
                isOnline = !isOnline;
                updateUI();
            });

            goOnlineBtn.addEventListener('click', function () {
                isOnline = true;
                updateUI();
            });

            document.addEventListener('click', function (e) {
                if (e.target.closest('.accept-btn')) {
                    const acceptBtn = e.target.closest('.accept-btn');
                    const deliveryCard = acceptBtn.closest('.delivery-card');
                    const deliveryId = deliveryCard.dataset.deliveryId;

                    acceptDelivery(deliveryId);
                }

                if (e.target.closest('.decline-btn')) {
                    const declineBtn = e.target.closest('.decline-btn');
                    const deliveryCard = declineBtn.closest('.delivery-card');

                    declineDelivery(deliveryCard);
                }
            });

            navigateBtn.addEventListener('click', function () {
                showNotification('Opening navigation to destination...', 'info');
            });

            markDeliveredBtn.addEventListener('click', function () {
                showDeliveryCompletionModal();
            });

            callCustomerBtn.addEventListener('click', function () {
                if (activeDelivery) {
                    showNotification(`Calling ${activeDelivery.contact}...`, 'info');
                }
            });

            function showDeliveryCompletionModal() {
                if (!activeDelivery) {
                    showNotification('No active delivery to mark as delivered', 'warning');
                    return;
                }

                document.body.style.overflow = 'hidden';

                completionModal.classList.add('active');
                completionOverlay.classList.add('active');

                setTimeout(() => {
                    cancelCompletionBtn.focus();
                }, 100);
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

            function acceptDelivery(deliveryId) {
                const deliveryData = availableDeliveries.find(d => d.id === deliveryId);
                if (!deliveryData) return;

                activeDelivery = deliveryData;

                activeDeliveryId.textContent = `#${deliveryData.id}`;
                pickupLocation.textContent = deliveryData.pickup;
                dropoffLocation.textContent = deliveryData.dropoff;
                deliveryDistance.textContent = deliveryData.distance;
                deliveryFee.textContent = deliveryData.fee;
                deliveryTime.textContent = deliveryData.time;
                customerContact.textContent = deliveryData.contact;

                activeDeliverySection.classList.add('active');

                deliveriesSection.style.display = 'none';

                const deliveryCard = document.querySelector(`[data-delivery-id="${deliveryId}"]`);
                if (deliveryCard) {
                    deliveryCard.style.opacity = '0.5';
                    deliveryCard.style.pointerEvents = 'none';

                    setTimeout(() => {
                        deliveryCard.style.transform = 'translateX(100%)';
                        deliveryCard.style.opacity = '0';

                        setTimeout(() => {
                            deliveryCard.style.display = 'none';
                        }, 300);
                    }, 100);
                }

                showNotification(`Delivery ${deliveryId} accepted! You're now heading to ${deliveryData.dropoff}`, 'success');
            }

            function declineDelivery(deliveryCard) {
                deliveryCard.style.opacity = '0.5';
                deliveryCard.style.pointerEvents = 'none';

                setTimeout(() => {
                    deliveryCard.style.transform = 'translateX(100%)';
                    deliveryCard.style.opacity = '0';

                    setTimeout(() => {
                        deliveryCard.style.display = 'none';
                    }, 300);
                }, 100);

                showNotification('Delivery declined', 'info');
            }

            function completeDelivery() {
                if (!activeDelivery) {
                    showNotification('No active delivery to complete', 'warning');
                    return;
                }

                const totalDeliveries = document.querySelector('.stat-card:nth-child(1) .stat-value');
                const earningsToday = document.querySelector('.stat-card:nth-child(2) .stat-value');
                const completedToday = document.querySelector('.stat-card:nth-child(3) .stat-value');

                const currentTotal = parseInt(totalDeliveries.textContent);
                totalDeliveries.textContent = (currentTotal + 1).toString();

                const currentEarnings = parseInt(earningsToday.textContent.replace('₱', '').replace(',', ''));
                const deliveryEarnings = parseInt(activeDelivery.fee.replace('₱', '').replace(',', ''));
                earningsToday.textContent = `₱${(currentEarnings + deliveryEarnings).toLocaleString()}`;

                const currentCompleted = parseInt(completedToday.textContent);
                completedToday.textContent = (currentCompleted + 1).toString();

                activeDeliverySection.classList.remove('active');

                if (isOnline) {
                    deliveriesSection.style.display = 'block';
                }

                activeDelivery = null;

                showNotification('Delivery marked as completed! Earnings added.', 'success');
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
                    activeDeliverySection.classList.remove('active');

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

            updateUI();
        });
    </script>
</asp:Content>