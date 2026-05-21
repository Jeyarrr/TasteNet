<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CustomerPortal.aspx.cs" Inherits="TasteNet.Users.Customer.CustomerPortal" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>TasteNet | Sizzling Good Food Delivered Hot!</title>
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@400;600;700&display=swap" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"/>
    
    <style>
        :root {
            --primary-maroon: #7D0A22;
            --accent-yellow: #FFD700;
            --text-white: #FFFFFF;
            --text-dark: #4A1A1A;
            --text-muted: #6D6D6D;
            --glass-bg: rgba(0, 0, 0, 0.4);
            --ripple-bg: rgba(255, 215, 0, 0.4);
            --card-shadow: 0 8px 25px rgba(125, 10, 34, 0.1);
            --transition-default: all 0.3s cubic-bezier(0.25, 0.46, 0.45, 0.94);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Quicksand', sans-serif;
            overflow-x: hidden;
            height: 100%;
            scroll-behavior: smooth;
            background: #fdfaf5;
        }

        html {
            height: 100%;
            scroll-behavior: smooth;
        }

        a, a:hover, a:visited, a:active,
        .add-to-cart-btn-text, .btn-browse-menu, .btn-order, .btn-cta-large,
        .footer-link, .nav-links a, .profile-dropdown-item,
        .btn-received, .remove-item-btn {
            text-decoration: none !important;
        }

        a, button, .logo-container, .nav-link, 
        .btn-order, .btn-search, .btn-cta-large, 
        .footer-link, .feature-card, .step-card, 
        .menu-container, .content-box {
            cursor: pointer !important;
            position: relative;
            overflow: hidden;
        }

        .ripple-effect {
            position: absolute;
            border-radius: 50%;
            background: var(--ripple-bg);
            transform: scale(0);
            animation: ripple-animation 0.6s linear;
            pointer-events: none;
            z-index: 10;
        }

        @keyframes ripple-animation {
            to {
                transform: scale(20);
                opacity: 0;
            }
        }

        .section-fade-in {
            opacity: 0;
            transform: translateY(40px);
            transition: opacity 0.8s ease, transform 0.8s ease;
        }

        .section-fade-in.visible {
            opacity: 1;
            transform: translateY(0);
        }

        .navbar.scrolled {
            background: linear-gradient(to bottom, rgba(0,0,0,0.75) 0%, rgba(0,0,0,0.55) 60%, rgba(0,0,0,0.35) 100%);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            padding: 8px 3%;
            box-shadow: 0 5px 20px rgba(0,0,0,0.2);
        }

        #home, #about, #menu, #contact {
            scroll-margin-top: 80px;
        }

        .nav-links a.active {
            color: var(--accent-yellow) !important;
            font-weight: 700;
        }

        .nav-links a.active:after {
            width: 80% !important;
            background: var(--accent-yellow);
        }

        .navbar {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 12px 3%;
            background: linear-gradient(to bottom, rgba(0,0,0,0.8) 0%, rgba(0,0,0,0.5) 50%, transparent 100%);
            z-index: 1000;
            backdrop-filter: blur(5px);
            transition: var(--transition-default);
        }

        .logo-container { 
            display: flex; 
            align-items: center; 
            gap: 10px; 
            transition: transform 0.3s ease;
            cursor: pointer;
        }
        
        .logo-container:hover {
            transform: scale(1.05);
        }
        
        .logo-img { 
            height: 50px; 
            width: 50px; 
            border-radius: 50%; 
            object-fit: cover; 
        }
        
        .brand-name { 
            font-size: 1.8rem; 
            font-weight: 700; 
            color: var(--accent-yellow); 
            text-shadow: 2px 2px 4px rgba(0,0,0,0.5); 
            transition: text-shadow 0.3s ease;
        }
        
        .logo-container:hover .brand-name {
            text-shadow: 0 0 15px rgba(255, 215, 0, 0.8);
        }

        .nav-links { 
            display: flex; 
            gap: 20px; 
            list-style: none; 
            margin-left: auto; 
            margin-right: 20px; 
        }
        
        .nav-links a { 
            text-decoration: none; 
            color: var(--text-white); 
            font-weight: 600; 
            font-size: 1rem; 
            transition: var(--transition-default); 
            padding: 6px 3px; 
            position: relative;
        }
        
        .nav-links a::after {
            content: '';
            position: absolute;
            width: 0;
            height: 3px;
            bottom: -2px;
            left: 50%;
            background: linear-gradient(90deg, transparent, #ff0000, #ff5555, #ff0000, transparent);
            transition: all 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            transform: translateX(-50%);
            border-radius: 2px;
        }

        .nav-links a:hover::after {
            width: 100%;
            animation: redPulse 1.5s infinite alternate;
        }

        @keyframes redPulse {
            0% { box-shadow: 0 0 10px rgba(255, 0, 0, 0.5); }
            100% { box-shadow: 0 0 25px rgba(255, 0, 0, 0.8); }
        }

        .nav-links a:hover { 
            color: #ff4444 !important;
            text-shadow: 0 0 10px rgba(255, 0, 0, 0.3);
            background: rgba(255, 215, 0, 0.1);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }

        .nav-icons { 
            display: flex; 
            gap: 3px; 
            font-size: 1.2rem; 
        }
        
        .nav-icons a { 
            color: var(--text-white); 
            transition: var(--transition-default); 
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            text-decoration: none;
            position: relative;
        }
        
        .nav-icons a:hover { 
            color: var(--accent-yellow); 
            background: rgba(255, 215, 0, 0.1);
            transform: translateY(-2px) scale(1.1);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }
        
        .nav-icons a::before {
            content: attr(data-tooltip);
            position: absolute;
            bottom: -40px;
            left: 50%;
            transform: translateX(-50%);
            background: rgba(0,0,0,0.9);
            color: white;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 0.75rem;
            white-space: nowrap;
            opacity: 0;
            visibility: hidden;
            transition: all 0.3s ease;
            pointer-events: none;
            z-index: 100;
        }
        
        .nav-icons a:hover::before {
            opacity: 1;
            visibility: visible;
            bottom: -35px;
        }

        .cart-icon-wrapper {
            position: relative;
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            transition: var(--transition-default);
            color: var(--text-white);
            text-decoration: none !important;
            overflow: visible !important;
            z-index: 1100;
        }
        
        .cart-badge {
            position: absolute;
            top: -6px;
            right: -6px;
            background: var(--accent-yellow);
            color: var(--primary-maroon);
            font-size: 0.68rem;
            font-weight: 900;
            min-width: 20px;
            height: 20px;
            padding: 0 4px;
            border-radius: 50px;
            display: none;
            align-items: center;
            justify-content: center;
            transition: all 0.3s ease;
            box-shadow: 0 2px 8px rgba(0,0,0,0.3);
            border: 2px solid rgba(0,0,0,0.15);
            z-index: 1200;
            pointer-events: none;
        }
        
        .cart-badge.pulse {
            animation: badgePulse 0.3s ease-in-out;
        }
        
        @keyframes badgePulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.3); }
        }

        .profile-dropdown-overlay {
            display: none;
            position: fixed;
            inset: 0;
            background: rgba(0, 0, 0, 0.45);
            z-index: 3000;
            opacity: 0;
            transition: opacity 0.25s ease;
        }

        .profile-dropdown-overlay.open {
            opacity: 1;
        }

        .profile-dropdown {
            position: fixed;
            top: 68px;
            right: 18px;
            width: 285px;
            background: white;
            border-radius: 14px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            z-index: 3001;
            border-left: 4px solid var(--primary-maroon);
            overflow: hidden;
            opacity: 0;
            transform: translateY(-12px) scale(0.97);
            transition: opacity 0.25s cubic-bezier(0.2, 0.9, 0.4, 1.1),
                        transform 0.25s cubic-bezier(0.2, 0.9, 0.4, 1.1);
            pointer-events: none;
        }

        .profile-dropdown.open {
            opacity: 1;
            transform: translateY(0) scale(1);
            pointer-events: auto;
        }
        
        .profile-dropdown-header {
            background: linear-gradient(135deg, var(--primary-maroon) 0%, #5a0819 100%);
            padding: 16px;
            text-align: center;
        }
        
        .profile-dropdown-header .profile-avatar-small {
            width: 50px;
            height: 50px;
            background: rgba(255, 215, 0, 0.2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 8px;
            border: 2px solid var(--accent-yellow);
            transition: transform 0.3s;
        }
        
        .profile-dropdown-header .profile-avatar-small i {
            font-size: 1.5rem;
            color: var(--accent-yellow);
        }
        
        .profile-dropdown-header .profile-name {
            font-size: 1rem;
            font-weight: 700;
            color: white;
            margin-bottom: 3px;
        }
        
        .profile-dropdown-header .profile-email {
            font-size: 0.7rem;
            color: rgba(255, 255, 255, 0.8);
        }
        
        .profile-dropdown-menu {
            padding: 8px 0;
            background: white;
        }
        
        .profile-dropdown-item {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 12px 18px;
            transition: all 0.25s ease;
            cursor: pointer;
            color: var(--text-dark);
            text-decoration: none;
            font-size: 0.9rem;
        }
        
        .profile-dropdown-item:hover {
            background: rgba(125, 10, 34, 0.06);
            padding-left: 22px;
        }
        
        .profile-dropdown-item i {
            width: 20px;
            color: var(--primary-maroon);
            transition: transform 0.2s;
        }
        
        .profile-dropdown-item:hover i {
            transform: scale(1.1);
            color: var(--accent-yellow);
        }
        
        .profile-dropdown-divider {
            height: 1px;
            background: #eee;
            margin: 5px 0;
        }
        
        .profile-dropdown-logout {
            color: #ff4444;
        }
        
        .profile-dropdown-logout i {
            color: #ff4444;
        }
        
        .profile-dropdown-logout:hover {
            background: rgba(255, 68, 68, 0.08);
        }

        .profile-modal {
            display: flex;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.6);
            z-index: 2005;
            justify-content: center;
            align-items: center;
            opacity: 0;
            pointer-events: none;
            transition: opacity 0.3s ease;
        }

        .profile-modal.open {
            opacity: 1;
            pointer-events: auto;
        }
        
        .profile-modal-content {
            background: white;
            width: 90%;
            max-width: 550px;
            max-height: 85vh;
            border-radius: 15px;
            overflow: hidden;
            border: 2px solid var(--accent-yellow);
            transform: translateY(-40px) scale(0.95);
            opacity: 0;
            transition: transform 0.35s cubic-bezier(0.2, 0.9, 0.4, 1.1),
                        opacity 0.35s cubic-bezier(0.2, 0.9, 0.4, 1.1);
        }

        .profile-modal.open .profile-modal-content {
            transform: translateY(0) scale(1);
            opacity: 1;
        }
        
        @keyframes slideInModal {
            from { transform: translateY(-50px) scale(0.95); opacity: 0; }
            to { transform: translateY(0) scale(1); opacity: 1; }
        }

        @keyframes fadeScaleIn {
            from { opacity: 0; transform: translate(-50%, -50%) scale(0.93); }
            to   { opacity: 1; transform: translate(-50%, -50%) scale(1); }
        }
        
        .profile-modal-header {
            background: linear-gradient(135deg, var(--primary-maroon) 0%, #5a0819 100%);
            color: white;
            padding: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 2px solid var(--accent-yellow);
        }
        
        .profile-modal-header h2 {
            margin: 0;
            font-size: 1.3rem;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .profile-modal-close {
            background: none;
            border: none;
            color: white;
            font-size: 1.8rem;
            cursor: pointer;
            width: 35px;
            height: 35px;
            border-radius: 50%;
            transition: all 0.3s;
        }
        
        .profile-modal-close:hover {
            background: rgba(255, 255, 255, 0.2);
            transform: rotate(90deg);
        }
        
        .profile-modal-body {
            padding: 20px;
            max-height: 60vh;
            overflow-y: auto;
        }
        
        .profile-panel {
            animation: panelFadeIn 0.25s ease;
        }
        
        @keyframes panelFadeIn {
            from { opacity: 0; transform: translateX(10px); }
            to { opacity: 1; transform: translateX(0); }
        }
        
        .profile-avatar {
            text-align: center;
            margin-bottom: 20px;
        }
        
        .profile-avatar i {
            font-size: 4rem;
            color: var(--primary-maroon);
            background: rgba(125, 10, 34, 0.1);
            border-radius: 50%;
            padding: 15px;
            border: 3px solid var(--accent-yellow);
            transition: all 0.3s;
        }
        
        .profile-avatar i:hover {
            transform: scale(1.05);
            box-shadow: 0 5px 15px rgba(125,10,34,0.2);
        }
        
        .form-group {
            margin-bottom: 15px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: 600;
            color: var(--primary-maroon);
            font-size: 0.85rem;
        }
        
        .form-group input, .form-group select, .form-group textarea {
            width: 100%;
            padding: 10px;
            border: 2px solid #eee;
            border-radius: 8px;
            font-family: inherit;
            font-size: 0.9rem;
            transition: all 0.3s;
        }
        
        .form-group input:focus, .form-group select:focus, .form-group textarea:focus {
            outline: none;
            border-color: var(--accent-yellow);
            box-shadow: 0 0 0 3px rgba(255, 215, 0, 0.1);
        }
        
        .btn-save, .btn-change-password {
            width: 100%;
            background: linear-gradient(135deg, var(--primary-maroon) 0%, #5a0819 100%);
            color: white;
            border: none;
            padding: 12px;
            border-radius: 8px;
            font-weight: 700;
            cursor: pointer;
            margin-top: 10px;
            transition: all 0.3s;
            position: relative;
            overflow: hidden;
        }
        
        .btn-save:hover, .btn-change-password:hover {
            background: var(--accent-yellow);
            color: var(--primary-maroon);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(125,10,34,0.2);
        }
        
        .password-wrapper {
            position: relative;
            display: flex;
            align-items: center;
        }
        
        .password-wrapper input {
            flex: 1;
            padding-right: 40px;
        }
        
        .toggle-password {
            position: absolute;
            right: 12px;
            cursor: pointer;
            color: var(--primary-maroon);
            font-size: 1rem;
            background: transparent;
            border: none;
            z-index: 10;
            transition: color 0.2s;
        }
        
        .toggle-password:hover {
            color: var(--accent-yellow);
        }
        
        .message {
            margin-top: 10px;
            padding: 10px;
            border-radius: 5px;
            text-align: center;
        }
        
        .message.success {
            background: #d4edda;
            color: #155724;
        }
        
        .message.error {
            background: #f8d7da;
            color: #721c24;
        }

        .cart-modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 2000;
        }

        .cart-modal-overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
        }

        .cart-modal-content {
            position: absolute;
            top: 80px;
            right: 20px;
            width: 380px;
            max-width: 90%;
            max-height: 80vh;
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.3);
            display: flex;
            flex-direction: column;
            overflow: hidden;
            animation: slideInCart 0.3s cubic-bezier(0.2, 0.9, 0.4, 1.1);
            border: 2px solid var(--accent-yellow);
        }
        
        @keyframes slideInCart {
            from { transform: translateX(50px); opacity: 0; }
            to { transform: translateX(0); opacity: 1; }
        }

        .cart-modal-header {
            background: linear-gradient(135deg, var(--primary-maroon) 0%, #5a0819 100%);
            color: white;
            padding: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 2px solid var(--accent-yellow);
        }

        .cart-modal-header h3 {
            margin: 0;
            font-size: 1.3rem;
            display: flex;
            align-items: center;
            gap: 10px;
            color: var(--accent-yellow);
        }

        .cart-close-btn {
            background: none;
            border: none;
            color: white;
            font-size: 2rem;
            cursor: pointer;
            width: 30px;
            height: 30px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            transition: all 0.3s ease;
        }

        .cart-close-btn:hover {
            background: rgba(255, 255, 255, 0.2);
            transform: rotate(90deg);
        }

        .cart-modal-body {
            flex: 1;
            overflow-y: auto;
            padding: 20px;
            background: #fdfaf5;
        }

        .cart-empty-state {
            text-align: center;
            padding: 40px 20px;
            color: var(--text-muted);
        }

        .cart-empty-state i {
            font-size: 3rem;
            color: var(--accent-yellow);
            margin-bottom: 15px;
            opacity: 0.7;
        }

        .btn-browse-menu {
            display: inline-block;
            background: var(--primary-maroon);
            color: white;
            padding: 10px 25px;
            border-radius: 50px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
            border: 2px solid var(--primary-maroon);
        }

        .btn-browse-menu:hover {
            background: white;
            color: var(--primary-maroon);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(125,10,34,0.2);
        }

        .cart-item {
            background: white;
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 15px;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.08);
            border-left: 4px solid var(--accent-yellow);
            animation: itemAppear 0.3s ease;
        }

        @keyframes itemAppear {
            from { opacity: 0; transform: translateX(-10px); }
            to { opacity: 1; transform: translateX(0); }
        }

        .cart-item-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 10px;
        }

        .cart-item-name {
            font-weight: 700;
            color: var(--primary-maroon);
            font-size: 0.95rem;
            flex: 1;
        }

        .cart-item-price {
            font-weight: 700;
            color: var(--primary-maroon);
            font-size: 1.1rem;
        }

        .cart-item-controls {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-top: 10px;
            padding-top: 10px;
            border-top: 1px solid #eee;
        }

        .quantity-controls {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .quantity-btn {
            width: 30px;
            height: 30px;
            border-radius: 50%;
            border: 2px solid var(--primary-maroon);
            background: white;
            color: var(--primary-maroon);
            font-weight: bold;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 1rem;
            text-decoration: none;
            transition: all 0.3s;
        }

        .quantity-btn:hover {
            background: var(--primary-maroon);
            color: white;
            transform: scale(1.1);
        }

        .quantity-value {
            font-weight: 700;
            min-width: 40px;
            text-align: center;
            color: var(--primary-maroon);
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 4px;
        }

        .remove-item-btn {
            background: none;
            border: none;
            color: #ff4444;
            cursor: pointer;
            font-size: 0.9rem;
            display: flex;
            align-items: center;
            gap: 5px;
            padding: 5px 10px;
            border-radius: 5px;
            text-decoration: none;
            transition: all 0.3s;
        }

        .remove-item-btn:hover {
            background: rgba(255, 68, 68, 0.1);
            transform: translateX(-2px);
        }

        .cart-modal-footer {
            background: white;
            border-top: 2px solid #eee;
            padding: 20px;
        }

        .cart-summary {
            margin-bottom: 20px;
        }

        .cart-summary-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
            padding-bottom: 10px;
            border-bottom: 1px dashed #eee;
        }

        .cart-total {
            font-size: 1.2rem;
            font-weight: 800;
            color: var(--primary-maroon);
            margin-top: 10px;
            padding-top: 10px;
            border-top: 2px solid var(--accent-yellow);
        }

        .cart-actions {
            display: flex;
            gap: 10px;
            margin-bottom: 15px;
            flex-wrap: wrap;
        }

        .btn-clear-cart {
            flex: 1;
            background: #f8f8f8;
            color: var(--text-muted);
            border: 2px solid #ddd;
            padding: 12px;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
        }

        .btn-clear-cart:hover {
            background: #ff4444;
            color: white;
            border-color: #ff4444;
            transform: translateY(-2px);
        }

        .btn-checkout {
            flex: 2;
            background: var(--accent-yellow);
            color: var(--primary-maroon);
            border: 2px solid var(--accent-yellow);
            padding: 12px;
            border-radius: 8px;
            font-weight: 800;
            cursor: pointer;
            transition: all 0.3s;
        }

        .btn-checkout:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }

        .btn-checkout:not(:disabled):hover {
            background: var(--primary-maroon);
            color: var(--accent-yellow);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(125,10,34,0.2);
        }

        .cart-delivery-info {
            margin-top: 10px;
            padding: 10px;
            background: #e8f4fd;
            border-radius: 8px;
            font-size: 0.8rem;
            text-align: center;
        }
        
        .checkout-modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 2100;
        }

        .checkout-modal-overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.6);
        }

        .checkout-modal-header {
            background: linear-gradient(135deg, var(--primary-maroon) 0%, #5a0819 100%);
            color: white;
            padding: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .checkout-modal-header h3 {
            margin: 0;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .checkout-close-btn {
            background: none;
            border: none;
            color: white;
            font-size: 1.8rem;
            cursor: pointer;
            transition: all 0.3s;
        }

        .checkout-close-btn:hover {
            transform: rotate(90deg);
        }

        .checkout-modal-body {
            flex: 1;
            overflow-y: auto;
            padding: 20px;
            background: #fdfaf5;
        }

        .checkout-section {
            background: white;
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 20px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            transition: all 0.3s;
        }
        
        .checkout-section:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        .checkout-section h4 {
            color: var(--primary-maroon);
            margin: 0 0 15px 0;
            padding-bottom: 10px;
            border-bottom: 2px solid var(--accent-yellow);
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .address-list {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .address-option {
            display: flex;
            align-items: flex-start;
            gap: 10px;
            padding: 12px;
            border: 2px solid #eee;
            border-radius: 8px;
            background: #f9f9f9;
            transition: all 0.3s;
        }
        
        .address-option:hover {
            border-color: var(--accent-yellow);
            background: #fff9f0;
        }

        .address-option-content {
            flex: 1;
        }

        .address-option-name {
            font-weight: 700;
            color: var(--primary-maroon);
        }

        .address-default-badge {
            background: var(--accent-yellow);
            color: var(--primary-maroon);
            padding: 2px 8px;
            border-radius: 12px;
            font-size: 0.7rem;
            font-weight: 700;
            display: inline-block;
            margin-left: 8px;
        }

        .new-address-toggle {
            margin: 15px 0;
            padding: 10px;
            background: #f8f9fa;
            border-radius: 8px;
        }
        
        .new-address-toggle input {
            margin-right: 8px;
            cursor: pointer;
        }

        .new-address-form {
            margin-top: 15px;
            padding-top: 15px;
            border-top: 1px solid #eee;
        }

        .payment-options {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .payment-option {
            display: flex;
            align-items: center;
            padding: 12px;
            border: 2px solid #eee;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s;
        }

        .payment-option:hover {
            border-color: var(--accent-yellow);
            background: #fff9f0;
            transform: translateX(5px);
        }

        .payment-option input[type="radio"] {
            margin-right: 12px;
            accent-color: var(--primary-maroon);
            cursor: pointer;
        }

        .payment-option-content {
            flex: 1;
            display: flex;
            align-items: center;
            gap: 10px;
            flex-wrap: wrap;
        }

        .payment-option-content i {
            font-size: 1.2rem;
            color: var(--primary-maroon);
        }

        .payment-option-disabled {
            filter: grayscale(100%);
            opacity: 0.45;
            cursor: not-allowed !important;
            pointer-events: none;
            border-color: #ccc !important;
            background: #f5f5f5 !important;
        }

        .payment-option-disabled:hover {
            transform: none !important;
            border-color: #ccc !important;
            background: #f5f5f5 !important;
            box-shadow: none !important;
        }

        .payment-option-disabled input[type="radio"] {
            cursor: not-allowed !important;
        }

        .badge-unavailable {
            display: inline-block;
            background: #999;
            color: #fff;
            font-size: 0.6rem;
            font-weight: 700;
            padding: 2px 8px;
            border-radius: 20px;
            margin-left: 8px;
            letter-spacing: 0.5px;
            text-transform: uppercase;
            vertical-align: middle;
        }

        .alert {
            padding: 12px;
            border-radius: 8px;
            font-size: 0.85rem;
        }

        .alert-info {
            background: #d1ecf1;
            color: #0c5460;
        }

        .checkout-modal-footer {
            background: white;
            border-top: 1px solid #eee;
            padding: 15px 20px;
            display: flex;
            gap: 10px;
            justify-content: flex-end;
        }

        .btn-secondary {
            background: #6c757d;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s;
        }

        .btn-secondary:hover {
            background: #5a6268;
            transform: translateY(-2px);
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--primary-maroon) 0%, #5a0819 100%);
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s;
            position: relative;
            overflow: hidden;
        }

        .btn-primary:hover {
            background: var(--accent-yellow);
            color: var(--primary-maroon);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(125,10,34,0.2);
        }
        
        .meal-detail-modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 2001;
        }

        .meal-modal-overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
        }

        .meal-modal-content {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 90%;
            max-width: 550px;
            max-height: 85vh;
            background: white;
            border-radius: 12px;
            border: 2px solid var(--accent-yellow);
            overflow: hidden;
            display: flex;
            flex-direction: column;
            animation: fadeScaleIn 0.3s cubic-bezier(0.2, 0.9, 0.4, 1.1) forwards;
        }

        .meal-modal-header {
            background: linear-gradient(135deg, var(--primary-maroon) 0%, #5a0819 100%);
            color: white;
            padding: 15px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .meal-modal-header h2 {
            margin: 0;
            font-size: 1.4rem;
            display: flex;
            align-items: center;
            gap: 8px;
            color: var(--accent-yellow);
        }

        .meal-close-btn {
            background: none;
            border: none;
            color: white;
            font-size: 1.5rem;
            cursor: pointer;
            width: 32px;
            height: 32px;
            border-radius: 50%;
            transition: all 0.3s;
        }

        .meal-close-btn:hover {
            background: rgba(255, 255, 255, 0.2);
            transform: rotate(90deg);
        }

        .meal-modal-body {
            flex: 1;
            overflow-y: auto;
            padding: 20px;
        }

        .meal-featured-img {
            width: 100%;
            max-width: 300px;
            height: 180px;
            border-radius: 8px;
            border: 2px solid var(--primary-maroon);
            object-fit: cover;
            display: block;
            margin: 0 auto;
            transition: all 0.3s;
        }
        
        .meal-featured-img:hover {
            transform: scale(1.02);
            border-color: var(--accent-yellow);
        }

        .meal-details {
            background: linear-gradient(135deg, #fdfaf5 0%, #fff9f0 100%);
            border-radius: 8px;
            padding: 15px;
            margin-top: 15px;
        }

        .meal-item-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
            flex-wrap: wrap;
        }

        .meal-item-name {
            font-size: 1.5rem;
            font-weight: 800;
            color: var(--primary-maroon);
        }

        .meal-item-price {
            font-size: 1.4rem;
            font-weight: 800;
            color: var(--accent-yellow);
            background: var(--primary-maroon);
            padding: 6px 12px;
            border-radius: 6px;
        }

        .meal-extra-options {
            display: flex;
            flex-direction: column;
            gap: 10px;
            margin: 15px 0;
        }

        .meal-extra-option {
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 8px 12px;
            background: white;
            border-radius: 6px;
            border: 1px solid #eee;
            transition: all 0.3s;
        }

        .meal-extra-option:hover {
            border-color: var(--accent-yellow);
            transform: translateX(5px);
        }

        .meal-extra-option input {
            width: 18px;
            height: 18px;
            accent-color: var(--primary-maroon);
            cursor: pointer;
        }

        .meal-extra-option label {
            font-size: 0.9rem;
            color: var(--text-dark);
            cursor: pointer;
            flex: 1;
        }

        .meal-additional-request {
            margin: 15px 0;
        }
        
        .meal-additional-request h4 {
            color: var(--primary-maroon);
            margin-bottom: 8px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .additional-request-textarea {
            width: 100%;
            padding: 10px;
            border: 2px solid #eee;
            border-radius: 8px;
            font-family: inherit;
            resize: vertical;
            transition: all 0.3s;
        }
        
        .additional-request-textarea:focus {
            outline: none;
            border-color: var(--accent-yellow);
            box-shadow: 0 0 0 3px rgba(255, 215, 0, 0.1);
        }

        .meal-modal-footer {
            background: white;
            border-top: 1px solid #eee;
            padding: 15px 20px;
        }

        .meal-quantity-selector {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 15px;
            flex-wrap: wrap;
        }

        .meal-quantity-controls {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .meal-qty-btn {
            width: 32px;
            height: 32px;
            border-radius: 50%;
            border: 2px solid var(--primary-maroon);
            background: white;
            color: var(--primary-maroon);
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s;
        }

        .meal-qty-btn:hover {
            background: var(--primary-maroon);
            color: white;
            transform: scale(1.1);
        }

        .meal-quantity-input {
            width: 50px;
            text-align: center;
            border: 1px solid #ddd;
            border-radius: 6px;
            padding: 5px;
        }

        .meal-modal-actions {
            display: flex;
            gap: 10px;
            justify-content: flex-end;
        }

        .btn-close-meal-modal, .btn-add-to-cart-meal {
            padding: 10px 20px;
            border-radius: 6px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            border: none;
        }

        .btn-close-meal-modal {
            background: #f8f8f8;
            color: var(--text-muted);
            border: 1px solid #ddd;
        }

        .btn-close-meal-modal:hover {
            background: #e0e0e0;
            transform: translateY(-2px);
        }

        .btn-add-to-cart-meal {
            background: var(--primary-maroon);
            color: white;
        }

        .btn-add-to-cart-meal:hover {
            background: var(--accent-yellow);
            color: var(--primary-maroon);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(125,10,34,0.2);
        }

        .rating-modal {
            display: none;
            position: fixed;
            top: 0; left: 0;
            width: 100%; height: 100%;
            z-index: 3000;
        }
        .rating-modal-overlay {
            position: absolute;
            top: 0; left: 0;
            width: 100%; height: 100%;
            background: rgba(0,0,0,0.65);
        }
        .rating-modal-content {
            position: absolute;
            top: 50%; left: 50%;
            transform: translate(-50%, -50%);
            width: 90%;
            max-width: 420px;
            background: white;
            border-radius: 20px;
            border: 3px solid var(--accent-yellow);
            overflow: hidden;
            animation: fadeScaleIn 0.3s cubic-bezier(0.2, 0.9, 0.4, 1.1) forwards;
        }
        .rating-modal-header {
            background: linear-gradient(135deg, var(--primary-maroon) 0%, #5a0819 100%);
            color: white;
            padding: 18px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 3px solid var(--accent-yellow);
        }
        .rating-modal-header h3 {
            margin: 0;
            font-size: 1.2rem;
            display: flex;
            align-items: center;
            gap: 8px;
            color: var(--accent-yellow);
        }
        .rating-close-btn {
            background: none;
            border: none;
            color: white;
            font-size: 1.8rem;
            cursor: pointer;
            width: 32px; height: 32px;
            border-radius: 50%;
            transition: all 0.3s;
        }
        .rating-close-btn:hover { background: rgba(255,255,255,0.2); transform: rotate(90deg); }
        .rating-modal-body {
            padding: 30px 25px;
            text-align: center;
            background: #fdfaf5;
        }
        .rating-order-info {
            background: white;
            border-radius: 12px;
            padding: 15px;
            margin-bottom: 20px;
            border: 2px solid var(--accent-yellow);
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .rating-question {
            font-size: 1.1rem;
            font-weight: 700;
            color: var(--primary-maroon);
            margin-bottom: 18px;
        }
        .star-rating-container {
            display: flex;
            justify-content: center;
            gap: 12px;
            margin-bottom: 15px;
        }
        .star {
            font-size: 2.5rem;
            color: #ddd;
            cursor: pointer;
            transition: all 0.2s ease;
            user-select: none;
        }
        .star:hover, .star.active { color: var(--accent-yellow); transform: scale(1.2); }
        .star.hovered { color: #ffb347; transform: scale(1.15); }
        .rating-label-text {
            font-size: 0.95rem;
            font-weight: 600;
            color: var(--text-muted);
            min-height: 22px;
            margin-bottom: 5px;
            transition: all 0.3s;
        }
        .rating-emoji {
            font-size: 2rem;
            min-height: 40px;
            transition: all 0.3s;
        }
        .rating-modal-footer {
            background: white;
            border-top: 1px solid #eee;
            padding: 15px 20px;
            display: flex;
            gap: 10px;
            justify-content: flex-end;
        }
        .btn-submit-rating:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }

        .btn-received {
            background: linear-gradient(135deg, #28a745, #20c997);
            color: white;
            border: none;
            padding: 8px 14px;
            border-radius: 6px;
            font-weight: 700;
            cursor: pointer;
            font-size: 0.8rem;
            transition: all 0.3s;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }
        .btn-received:hover {
            background: linear-gradient(135deg, #218838, #17a589);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(40,167,69,0.3);
            color: white;
        }

        .policy-modal {
            display: none;
            position: fixed;
            top: 0; left: 0;
            width: 100%; height: 100%;
            z-index: 3001;
        }
        .policy-modal-overlay {
            position: absolute;
            top: 0; left: 0;
            width: 100%; height: 100%;
            background: rgba(0,0,0,0.65);
        }
        .policy-modal-content {
            position: absolute;
            top: 50%; left: 50%;
            transform: translate(-50%, -50%);
            width: 90%;
            max-width: 600px;
            max-height: 85vh;
            background: white;
            border-radius: 16px;
            border: 2px solid var(--accent-yellow);
            overflow: hidden;
            display: flex;
            flex-direction: column;
            animation: fadeScaleIn 0.3s cubic-bezier(0.2, 0.9, 0.4, 1.1) forwards;
        }
        .policy-modal-header {
            background: linear-gradient(135deg, var(--primary-maroon) 0%, #5a0819 100%);
            color: white;
            padding: 18px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 3px solid var(--accent-yellow);
        }
        .policy-modal-header h3 {
            margin: 0;
            font-size: 1.2rem;
            display: flex;
            align-items: center;
            gap: 8px;
            color: var(--accent-yellow);
        }
        .policy-close-btn {
            background: none; border: none;
            color: white; font-size: 1.8rem; cursor: pointer;
            width: 32px; height: 32px; border-radius: 50%;
            transition: all 0.3s;
        }
        .policy-close-btn:hover { background: rgba(255,255,255,0.2); transform: rotate(90deg); }
        .policy-modal-body {
            flex: 1; overflow-y: auto;
            padding: 25px 25px 20px;
            background: #fdfaf5;
        }
        .policy-effective {
            font-size: 0.8rem;
            color: var(--text-muted);
            margin-bottom: 20px;
            padding: 8px 12px;
            background: #fff;
            border-radius: 6px;
            border-left: 3px solid var(--accent-yellow);
        }
        .policy-section {
            background: white;
            border-radius: 10px;
            padding: 15px 18px;
            margin-bottom: 15px;
            border: 1px solid #eee;
        }
        .policy-section h4 {
            color: var(--primary-maroon);
            font-size: 0.95rem;
            margin: 0 0 10px;
            display: flex;
            align-items: center;
            gap: 8px;
            padding-bottom: 8px;
            border-bottom: 2px solid var(--accent-yellow);
        }
        .policy-section p { font-size: 0.88rem; color: #555; line-height: 1.6; margin-bottom: 8px; }
        .policy-section ul { font-size: 0.88rem; color: #555; padding-left: 18px; line-height: 1.8; }
        .policy-section ul li { margin-bottom: 4px; }
        .policy-modal-footer {
            background: white;
            border-top: 1px solid #eee;
            padding: 15px 20px;
            display: flex;
            justify-content: flex-end;
        }

        @keyframes tnSlideIn {
            from { opacity: 0; transform: translateX(120px) scale(0.92); }
            to   { opacity: 1; transform: translateX(0)     scale(1); }
        }
        @keyframes tnSlideOut {
            from { opacity: 1; transform: translateX(0) scale(1); }
            to   { opacity: 0; transform: translateX(120px) scale(0.88); }
        }
        @keyframes tnBar {
            from { width: 100%; }
            to   { width: 0%; }
        }
        .tn-hide { animation: tnSlideOut 0.35s ease forwards !important; }
        .tn-toast-icon {
            font-size: 1.4rem;
            flex-shrink: 0;
            opacity: 0.92;
        }
        .tn-toast-body { flex: 1; }
        .tn-toast-message { line-height: 1.4; }
        .tn-toast-close {
            background: none;
            border: none;
            color: rgba(255,255,255,0.75);
            font-size: 1.2rem;
            cursor: pointer;
            line-height: 1;
            padding: 0 2px;
            flex-shrink: 0;
            transition: color 0.2s;
        }
        .tn-toast-close:hover { color: #fff; }

        @keyframes confettiFall {
            0% { transform: translateY(-100px) rotate(0deg); opacity: 1; }
            100% { transform: translateY(100vh) rotate(720deg); opacity: 0; }
        }
        .confetti-piece {
            position: fixed;
            width: 10px; height: 10px;
            top: -10px;
            animation: confettiFall linear forwards;
            pointer-events: none;
            z-index: 100000;
            border-radius: 2px;
        }


        .hero-container {
            position: relative;
            min-height: 100vh;
            width: 100%;
            background: linear-gradient(rgba(0,0,0,0.5), rgba(0,0,0,0.5)), 
            url('<%= ResolveUrl("~/Images/landingpage.jpg") %>');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            color: var(--text-white);
            text-align: center;
            padding: 80px 20px 60px;
        }

        /* Fix: background-attachment:fixed breaks on iOS/Android — falls back to scroll */
        @media (max-width: 768px) {
            .hero-container {
                background-attachment: scroll;
                min-height: 100svh;
            }
        }

        .hero-content { 
            max-width: 900px; 
            width: 100%; 
            animation: fadeInUp 1s ease;
        }
        
        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .hero-content h1 { 
            font-size: 3.5rem; 
            font-weight: 700; 
            margin-bottom: 20px; 
            text-shadow: 2px 2px 10px rgba(0,0,0,0.7); 
        }
        
        .hero-tagline { 
            font-size: 1.8rem; 
            font-weight: 600; 
            margin-bottom: 15px; 
            color: var(--accent-yellow);
            transition: all 0.3s;
        }
        
        .hero-tagline:hover {
            transform: scale(1.02);
            text-shadow: 0 0 15px rgba(255, 215, 0, 0.5);
        }
        
        .hero-subtitle { 
            font-size: 1.5rem; 
            font-weight: 600; 
            margin: 15px 0; 
        }
        
        .hero-description { 
            font-size: 1.2rem; 
            opacity: 0.95; 
            margin: 0 auto 30px; 
            max-width: 700px; 
        }

        .search-box {
            background: var(--text-white);
            border-radius: 50px;
            padding: 8px 10px 8px 25px;
            display: flex;
            align-items: center;
            width: 100%;
            max-width: 600px;
            margin: 30px auto;
            box-shadow: 0 10px 25px rgba(0,0,0,0.3);
            transition: all 0.3s;
        }
        
        .search-box:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.4);
        }
        
        .search-box i {
            transition: all 0.3s;
        }
        
        .search-box:hover i {
            transform: scale(1.2);
            color: var(--accent-yellow);
        }
        
        .search-input { 
            border: none; 
            outline: none; 
            flex: 1; 
            font-family: inherit; 
            font-size: 1rem; 
        }
        
        .btn-search { 
            background: var(--accent-yellow); 
            border: none; 
            padding: 12px 30px; 
            border-radius: 50px; 
            font-weight: 700; 
            color: var(--primary-maroon); 
            cursor: pointer; 
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }
        
        .btn-search:hover { 
            background: var(--primary-maroon); 
            color: var(--accent-yellow); 
            transform: translateY(-3px) scale(1.05);
            box-shadow: 0 10px 20px rgba(0,0,0,0.3);
        }

        .btn-order { 
            padding: 15px 35px; 
            border-radius: 10px; 
            font-weight: 700; 
            text-decoration: none; 
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275); 
            display: inline-block;
            background: var(--accent-yellow); 
            color: var(--primary-maroon); 
            border: 2px solid var(--accent-yellow);
            position: relative;
            overflow: hidden;
        }
        
        .btn-order:before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
            transition: left 0.6s ease;
        }
        
        .btn-order:hover:before {
            left: 100%;
        }
        
        .btn-order:hover { 
            background: var(--primary-maroon); 
            color: var(--accent-yellow); 
            transform: translateY(-5px) scale(1.05);
            box-shadow: 0 15px 25px rgba(0,0,0,0.3);
        }

        .about-section {
            background: #FFFFFF; 
            padding: 80px 8%;
        }

        .about-title {
            font-size: 2.8rem;
            font-weight: 700;
            color: var(--primary-maroon); 
            margin-bottom: 15px;
            border-left: 8px solid var(--primary-maroon); 
            padding-left: 20px;
            transition: all 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            display: inline-block;
        }
        
        .about-title:hover {
            transform: translateX(15px) scale(1.02);
            border-left-color: var(--accent-yellow);
            text-shadow: 2px 2px 8px rgba(125,10,34,0.2);
        }
        
        .about-tagline {
            font-size: 1.2rem;
            margin-bottom: 30px;
            color: var(--text-dark);
            font-weight: 600;
            transition: all 0.3s;
        }
        
        .about-tagline:hover {
            transform: translateY(-3px);
            color: var(--primary-maroon);
        }

        .content-box {
            background: linear-gradient(135deg, #fdfaf5 0%, #fff9f0 100%);
            border-radius: 15px;
            padding: 40px 50px;
            border-left: 8px solid var(--accent-yellow);
            transition: all 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            position: relative;
            overflow: hidden;
        }
        
        .content-box::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: linear-gradient(45deg, transparent 30%, rgba(255, 215, 0, 0.05) 50%, transparent 70%);
            transform: rotate(45deg);
            transition: transform 0.8s ease;
        }

        .content-box:hover {
            transform: translateY(-8px) scale(1.01);
            box-shadow: 0 20px 50px rgba(125, 10, 34, 0.15);
            border-left-color: var(--primary-maroon);
        }
        
        .content-box:hover::before {
            transform: rotate(405deg);
        }

        .content-text {
            font-size: 1.2rem;
            color: var(--text-dark);
            line-height: 1.8;
            position: relative;
            z-index: 1;
        }
        
        .content-text p {
            transition: all 0.4s ease;
            padding: 5px;
            border-radius: 5px;
        }
        
        .content-text p:hover {
            transform: translateX(10px);
            background: linear-gradient(90deg, rgba(255, 215, 0, 0.08), transparent);
        }

        .menu-display-section {
            padding: 80px 8% 40px;
            background-color: #fdfaf5;
            text-align: center;
        }
        
        .menu-header {
            font-size: 2.8rem;
            font-weight: 700;
            color: var(--primary-maroon);
            margin-bottom: 50px;
            position: relative;
            display: inline-block;
            padding-bottom: 15px;
            transition: all 0.3s;
        }
        
        .menu-header::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 100px;
            height: 4px;
            background: var(--primary-maroon);
            transition: all 0.5s;
            border-radius: 2px;
        }
        
        .menu-header:hover {
            transform: translateY(-3px);
        }
        
        .menu-header:hover::after {
            width: 100%;
            background: var(--accent-yellow);
            height: 5px;
        }
        
        .menu-category-container {
            margin-bottom: 60px;
        }

        .category-title {
            font-size: 2.2rem;
            font-weight: 800;
            color: var(--primary-maroon);
            margin-bottom: 30px;
            text-align: center;
            position: relative;
            padding-bottom: 15px;
            display: inline-block;
            transition: all 0.3s ease;
            cursor: default;
        }

        .category-title::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 150px;
            height: 4px;
            background: linear-gradient(90deg, var(--primary-maroon), var(--accent-yellow));
            border-radius: 2px;
            transition: all 0.5s ease;
        }

        .category-title:hover {
            transform: translateY(-3px);
            color: var(--primary-maroon);
        }

        .category-title:hover::after {
            width: 100%;
            background: linear-gradient(90deg, var(--accent-yellow), var(--primary-maroon), var(--accent-yellow));
            height: 5px;
        }

        .menu-category-container {
            text-align: center;
        }
        .menu-grid-container {
            display: grid;
            grid-template-columns: repeat(6, 1fr);
            gap: 25px;
            margin: 0 auto;
            justify-content: center;
        }

        .menu-grid-container:has(.menu-container:first-child:nth-last-child(-n+5)) {
            grid-template-columns: repeat(auto-fit, minmax(180px, 210px));
            justify-content: center;
        }
        
        .menu-container {
            background: #fff;
            padding: 20px 12px;
            border-radius: 20px;
            box-shadow: var(--card-shadow);
            transition: all 0.5s cubic-bezier(0.25, 0.46, 0.45, 0.94);
            text-align: center;
            border: 2px solid transparent;
            position: relative;
            overflow: hidden;
        }
        
        .menu-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, rgba(255, 215, 0, 0.05) 0%, rgba(125, 10, 34, 0.05) 100%);
            opacity: 0;
            transition: opacity 0.5s ease;
            z-index: 0;
        }

        .menu-container:hover {
            transform: translateY(-12px) scale(1.02);
            border-color: var(--accent-yellow);
            box-shadow: 0 20px 40px rgba(125, 10, 34, 0.2);
        }
        
        .menu-container:hover::before {
            opacity: 1;
        }

        .menu-featured-img {
            width: 130px;
            height: 130px;
            border-radius: 50%;
            object-fit: cover;
            border: 5px solid var(--primary-maroon);
            margin-bottom: 12px;
            transition: all 0.8s cubic-bezier(0.25, 0.46, 0.45, 0.94);
        }

        .menu-container:hover .menu-featured-img {
            transform: scale(1.05) rotate(3deg);
            border-color: var(--accent-yellow);
            box-shadow: 0 10px 25px rgba(125,10,34,0.2);
        }

        .menu-list-container {
            position: relative;
            z-index: 1;
        }

        .category-label {
            font-size: 1.1rem;
            font-weight: 800;
            color: var(--primary-maroon);
            margin-bottom: 4px;
        }

        .meal-description-short {
            font-size: 0.8rem;
            color: var(--text-muted);
            margin-bottom: 6px;
            line-height: 1.3;
        }

        .item-price-small {
            font-size: 1rem;
            font-weight: 700;
            color: var(--primary-maroon);
            background: rgba(255, 215, 0, 0.15);
            padding: 3px 8px;
            border-radius: 6px;
            display: inline-block;
        }

        .menu-item-buttons {
            display: flex;
            gap: 8px;
            justify-content: center;
            margin-top: 12px;
        }

        .view-btn, .add-to-cart-btn-text {
            padding: 6px 10px;
            border-radius: 20px;
            font-size: 0.7rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            border: 2px solid var(--primary-maroon);
            background: transparent;
            color: var(--primary-maroon);
            display: inline-flex;
            align-items: center;
            gap: 4px;
            text-decoration: none !important;
        }

        .view-btn:hover, .add-to-cart-btn-text:hover,
        .view-btn:focus, .add-to-cart-btn-text:focus,
        .view-btn:visited, .add-to-cart-btn-text:visited {
            text-decoration: none !important;
        }

        .view-btn:hover, .add-to-cart-btn-text:hover {
            background: var(--primary-maroon);
            color: white;
            transform: translateY(-3px);
            box-shadow: 0 5px 12px rgba(125,10,34,0.2);
        }
        
        .view-btn i, .add-to-cart-btn-text i {
            font-size: 0.7rem;
        }

        .love-us-section {
            background: linear-gradient(135deg, #fdfaf5 0%, #fff9f0 100%);
            padding: 60px 8% 40px;
            text-align: center;
        }

        .love-us-title {
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--primary-maroon);
            margin-bottom: 15px;
            position: relative;
            display: inline-block;
            padding-bottom: 10px;
            transition: all 0.3s;
        }
        
        .love-us-title::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 80px;
            height: 4px;
            background: var(--primary-maroon);
            transition: all 0.5s;
            border-radius: 2px;
        }
        
        .love-us-title:hover {
            transform: translateY(-3px);
        }
        
        .love-us-title:hover::after {
            width: 100%;
            background: var(--accent-yellow);
        }

        .features-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 25px;
            margin-top: 40px;
        }

        .feature-card {
            background: white;
            border-radius: 15px;
            padding: 25px 20px;
            text-align: center;
            box-shadow: 0 5px 15px rgba(125, 10, 34, 0.08);
            transition: all 0.4s cubic-bezier(0.25, 0.46, 0.45, 0.94);
            border: 1px solid transparent;
            position: relative;
            overflow: hidden;
        }
        
        .feature-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, rgba(255, 215, 0, 0.05) 0%, rgba(125, 10, 34, 0.05) 100%);
            opacity: 0;
            transition: opacity 0.5s;
        }

        .feature-card:hover {
            transform: translateY(-8px) scale(1.02);
            border-color: var(--accent-yellow);
            box-shadow: 0 15px 35px rgba(125, 10, 34, 0.15);
        }
        
        .feature-card:hover::before {
            opacity: 1;
        }

        .feature-icon {
            width: 55px;
            height: 55px;
            background: linear-gradient(135deg, var(--primary-maroon) 0%, #5a0819 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 15px;
            color: var(--accent-yellow);
            font-size: 1.5rem;
            transition: all 0.4s;
        }
        
        .feature-card:hover .feature-icon {
            transform: scale(1.1) rotate(5deg);
            box-shadow: 0 8px 20px rgba(125,10,34,0.25);
        }

        .compact-order-steps {
            background: #FFFFFF;
            padding: 60px 5% 40px;
            text-align: center;
        }

        .compact-steps-header {
            font-size: 2rem;
            font-weight: 700;
            color: var(--primary-maroon);
            margin-bottom: 40px;
            position: relative;
            display: inline-block;
            padding-bottom: 10px;
        }
        
        .compact-steps-header::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 80px;
            height: 3px;
            background: var(--primary-maroon);
            transition: all 0.5s;
        }
        
        .compact-steps-header:hover::after {
            width: 100%;
            background: var(--accent-yellow);
        }

        .compact-steps-grid {
            display: flex;
            justify-content: center;
            gap: 30px;
            flex-wrap: wrap;
        }

        .compact-step-card {
            flex: 1;
            min-width: 250px;
            max-width: 300px;
            background: white;
            border-radius: 15px;
            padding: 30px 20px;
            box-shadow: 0 5px 15px rgba(125, 10, 34, 0.08);
            transition: all 0.4s;
            border: 2px solid transparent;
        }

        .compact-step-card:hover {
            transform: translateY(-8px);
            border-color: var(--accent-yellow);
            box-shadow: 0 15px 30px rgba(125,10,34,0.15);
        }

        .compact-step-number {
            font-size: 2.8rem;
            font-weight: 800;
            color: var(--accent-yellow);
            margin-bottom: 15px;
        }
        
        .compact-step-title {
            font-size: 1.3rem;
            font-weight: 700;
            color: var(--primary-maroon);
            margin-bottom: 10px;
        }

        .cta-banner {
            background: linear-gradient(135deg, var(--primary-maroon) 0%, #5a0819 100%);
            border-radius: 15px;
            padding: 40px 30px;
            margin: 40px auto 0;
            color: white;
            transition: all 0.3s;
        }
        
        .cta-banner:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(0,0,0,0.2);
        }

        .btn-cta-large {
            display: inline-block;
            background: var(--accent-yellow);
            color: var(--primary-maroon);
            padding: 15px 40px;
            border-radius: 50px;
            font-size: 1.2rem;
            font-weight: 800;
            text-decoration: none;
            transition: all 0.3s;
            position: relative;
            overflow: hidden;
        }
        
        .btn-cta-large:before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: left 0.6s;
        }
        
        .btn-cta-large:hover:before {
            left: 100%;
        }

        .btn-cta-large:hover {
            background: white;
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.2);
        }

        .contact-map-section {
            background: var(--primary-maroon);
            color: white;
            padding: 80px 8% 40px;
        }
        
        .contact-map-header {
            text-align: center;
            margin-bottom: 40px;
        }
        
        .contact-map-header h1 {
            font-size: 2.5rem;
            font-weight: 800;
            color: var(--accent-yellow);
            margin-bottom: 10px;
        }

        .contact-map-content {
            display: flex;
            flex-direction: column;
            gap: 0;
        }

        .map-container-large {
            width: 100%;
            border-radius: 15px 15px 0 0;
            overflow: hidden;
            border: 3px solid var(--accent-yellow);
            border-bottom: none;
            transition: all 0.3s;
        }
        
        .map-container-large:hover {
            box-shadow: 0 -8px 30px rgba(0,0,0,0.3);
        }

        .map-wrapper-large {
            width: 100%;
            height: 520px;
        }

        .contact-info-sidebar {
            width: 100%;
            background: rgba(0, 0, 0, 0.2);
            border-radius: 0 0 15px 15px;
            padding: 30px 40px;
            border: 3px solid var(--accent-yellow);
            border-top: none;
            display: flex;
            flex-direction: row;
            gap: 60px;
            align-items: flex-start;
            transition: all 0.3s;
        }
        
        .contact-info-sidebar:hover {
            background: rgba(0, 0, 0, 0.3);
        }

        .contact-info-group {
            flex: 1;
            min-width: 180px;
        }

        .contact-info-group + .contact-info-group {
            border-left: 1px solid rgba(255, 215, 0, 0.3);
            padding-left: 40px;
        }

        .phone-large {
            font-size: 1.4rem;
            font-weight: 700;
            color: var(--accent-yellow);
            margin: 10px 0;
        }

        .main-footer {
            background: #5a0819;
            color: white;
            padding: 40px 5% 20px;
        }

        .footer-container {
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 40px;
            max-width: 1200px;
            margin: 0 auto;
        }
        
        .footer-logo-section {
            flex: 1;
            min-width: 200px;
        }
        
        .footer-logo-container {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 15px;
            transition: transform 0.3s;
        }
        
        .footer-logo-container:hover {
            transform: scale(1.03);
        }

        .footer-logo {
            height: 50px;
            width: 50px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid var(--accent-yellow);
        }

        .footer-brand-name {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--accent-yellow);
        }
        
        .footer-quick-links {
            flex: 1;
            min-width: 200px;
        }
        
        .footer-quick-links h3 {
            color: var(--accent-yellow);
            margin-bottom: 15px;
            font-size: 1.2rem;
        }
        
        .quick-links-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 10px;
        }
        
        .footer-link {
            color: white;
            text-decoration: none;
            font-size: 0.9rem;
            transition: all 0.3s;
            display: block;
            padding: 5px 0;
            position: relative;
            padding-left: 20px;
        }
        
        .footer-link:before {
            content: "›";
            position: absolute;
            left: 0;
            color: var(--accent-yellow);
            transition: transform 0.3s;
        }
        
        .footer-link:hover {
            color: var(--accent-yellow);
            transform: translateX(5px);
        }
        
        .footer-link:hover:before {
            transform: translateX(3px);
        }

        .footer-bottom {
            background: #4a1a1a;
            padding: 15px 5%;
            text-align: center;
            margin-top: 30px;
        }
        
        .footer-bottom-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
            max-width: 1200px;
            margin: 0 auto;
        }
        
        .delivery-tag {
            display: flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s;
        }
        
        .delivery-tag:hover {
            color: var(--accent-yellow);
            transform: scale(1.05);
        }

        .back-to-top {
            position: fixed;
            bottom: 30px;
            right: 30px;
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: var(--primary-maroon);
            color: var(--accent-yellow);
            border: 2px solid var(--accent-yellow);
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            z-index: 999;
            opacity: 0;
            visibility: hidden;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
        }
        
        .back-to-top::before {
            content: 'Back to Top';
            position: absolute;
            right: 60px;
            background: var(--primary-maroon);
            color: var(--accent-yellow);
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 0.75rem;
            white-space: nowrap;
            opacity: 0;
            visibility: hidden;
            transition: all 0.3s;
            pointer-events: none;
            border: 1px solid var(--accent-yellow);
        }
        
        .back-to-top:hover::before {
            opacity: 1;
            visibility: visible;
            right: 70px;
        }

        .back-to-top.visible {
            opacity: 1;
            visibility: visible;
        }

        .back-to-top:hover {
            background: var(--accent-yellow);
            color: var(--primary-maroon);
            transform: translateY(-5px) scale(1.1);
            box-shadow: 0 8px 25px rgba(255, 215, 0, 0.4);
        }

        .notification-toast {
            position: fixed;
            bottom: 20px;
            right: 20px;
            padding: 14px 24px;
            border-radius: 10px;
            z-index: 10000;
            animation: slideInRight 0.3s ease;
            font-weight: 600;
            box-shadow: 0 5px 20px rgba(0,0,0,0.2);
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        @keyframes slideInRight {
            from { transform: translateX(100%); opacity: 0; }
            to { transform: translateX(0); opacity: 1; }
        }

        .order-status {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
            color: white;
        }
        .status-open { background: #ffc107; color: #856404; }
        .status-cooking { background: #17a2b8; color: white; }
        .status-ready { background: #28a745; color: white; }
        .status-delivering { background: #fd7e14; color: white; }
        .status-completed { background: #28a745; color: white; }
        .status-cancelled { background: #dc3545; color: white; }
        
        .order-card {
            background: #f9f9f9;
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 15px;
            border-left: 4px solid var(--accent-yellow);
            transition: all 0.3s;
        }
        
        .order-card:hover {
            transform: translateX(5px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        .btn-reorder {
            background: linear-gradient(135deg, var(--accent-yellow), #e6c200) !important;
            color: var(--primary-maroon) !important;
            border: none !important;
            padding: 8px 14px !important;
            border-radius: 6px !important;
            font-weight: 700 !important;
            cursor: pointer !important;
            font-size: 0.8rem !important;
            transition: all 0.3s !important;
            text-decoration: none !important;
            display: inline-flex !important;
            align-items: center !important;
            gap: 5px !important;
        }

        .btn-reorder:hover {
            background: linear-gradient(135deg, #e6c200, #d4b000) !important;
            transform: translateY(-2px) !important;
            box-shadow: 0 5px 15px rgba(255, 215, 0, 0.4) !important;
            text-decoration: none !important;
        }
        
        .btn-cancel {
            background: #dc3545 !important;
            color: white !important;
            border: none !important;
            padding: 8px 14px !important;
            border-radius: 6px !important;
            font-weight: 700 !important;
            cursor: pointer !important;
            font-size: 0.8rem !important;
            transition: all 0.3s ease !important;
            text-decoration: none !important;  
            display: inline-flex !important;
            align-items: center !important;
            gap: 5px !important;
            margin: 0 3px !important;
        }

        .btn-cancel:hover {
            background: #bb2d3b !important; 
            transform: translateY(-2px) !important;
            box-shadow: 0 5px 15px rgba(220, 53, 69, 0.3) !important;
            color: white !important;
            text-decoration: none !important; 
        }

        .btn-cancel:focus,
        .btn-cancel:active,
        .btn-cancel:visited {
            text-decoration: none !important; 
            outline: none;
        }

        .btn-cancel i {
            text-decoration: none !important;
        }

        a.btn-cancel,
        asp\:LinkButton.btn-cancel,
        .btn-cancel[href] {
            text-decoration: none !important;
        }
        .btn-reorder { background: var(--accent-yellow); color: var(--primary-maroon); }
        .btn-reorder:hover { background: #ffed4e; transform: translateY(-2px); }

        @keyframes searchHighlight {
            0% { border-color: var(--accent-yellow); box-shadow: 0 0 0 0 rgba(255, 215, 0, 0.5); }
            50% { border-color: var(--accent-yellow); box-shadow: 0 0 0 15px rgba(255, 215, 0, 0); }
            100% { border-color: transparent; box-shadow: 0 0 0 0 rgba(255, 215, 0, 0); }
        }
        
        .search-highlight {
            animation: searchHighlight 1s ease-out;
            border-color: var(--accent-yellow) !important;
        }

        .special-instructions-section {
            border: 2px solid transparent;
            background: linear-gradient(white, white) padding-box,
                        linear-gradient(135deg, var(--accent-yellow), var(--primary-maroon)) border-box !important;
        }

        .special-instructions-wrapper {
            position: relative;
            display: flex;
            align-items: flex-start;
            gap: 10px;
            background: linear-gradient(135deg, #fdfaf5 0%, #fff9f0 100%);
            border-radius: 10px;
            padding: 4px 8px 4px 12px;
            border: 1.5px solid rgba(255, 215, 0, 0.4);
            transition: all 0.3s;
        }

        .special-instructions-wrapper:focus-within {
            border-color: var(--accent-yellow);
            box-shadow: 0 0 0 3px rgba(255, 215, 0, 0.15);
            background: #fff9f0;
        }

        .special-instructions-icon {
            color: var(--primary-maroon);
            font-size: 1rem;
            padding-top: 12px;
            opacity: 0.6;
            transition: opacity 0.3s;
            flex-shrink: 0;
        }

        .special-instructions-wrapper:focus-within .special-instructions-icon {
            opacity: 1;
            color: var(--accent-yellow);
        }

        .special-instructions-textarea {
            flex: 1;
            border: none !important;
            background: transparent !important;
            font-family: inherit;
            font-size: 0.9rem;
            resize: none;
            padding: 10px 8px;
            outline: none !important;
            color: var(--text-dark);
            line-height: 1.5;
            min-height: 70px;
        }

        .special-instructions-hints {
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
            margin-top: 10px;
        }

        .special-instructions-hints span {
            background: rgba(125, 10, 34, 0.06);
            color: var(--primary-maroon);
            border: 1.5px solid rgba(125, 10, 34, 0.15);
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.25s;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .special-instructions-hints span:hover {
            background: var(--primary-maroon);
            color: white;
            border-color: var(--primary-maroon);
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(125,10,34,0.2);
        }

        .checkout-modal-content {
            position: fixed !important;
            top: 50% !important;
            left: 50% !important;
            transform: translate(-50%, -50%) !important;
            width: 90%;
            max-width: 650px;
            max-height: 85vh;
            background: white;
            border-radius: 15px;
            overflow: hidden;
            display: flex;
            flex-direction: column;
            animation: checkoutEnter 0.3s cubic-bezier(0.2, 0.9, 0.4, 1.1) forwards;
        }

        @keyframes checkoutEnter {
            from { opacity: 0; transform: translate(-50%, -50%) scale(0.93); }
            to   { opacity: 1; transform: translate(-50%, -50%) scale(1); }
        }

        
        @media (max-width: 1200px) {
            .menu-grid-container { grid-template-columns: repeat(4, 1fr); }
            .features-grid { grid-template-columns: repeat(2, 1fr); }
        }
        
        @media (max-width: 992px) {
            .menu-grid-container { grid-template-columns: repeat(3, 1fr); }
        }
        
        @media (max-width: 768px) {
            .menu-grid-container { grid-template-columns: repeat(2, 1fr); }
            .features-grid { grid-template-columns: 1fr; }
            .cart-modal-content { width: 95%; right: 2.5%; }
            .hero-content h1 { font-size: 2.5rem; }
            .hero-tagline { font-size: 1.4rem; }
            .checkout-modal-content { width: 95%; }
            .footer-bottom-content { flex-direction: column; text-align: center; }
            .compact-steps-grid { flex-direction: column; align-items: center; }
            .compact-step-card { max-width: 350px; }
        }
        
        @media (max-width: 576px) {
            .menu-grid-container { grid-template-columns: 1fr; }
            .menu-container { max-width: 280px; margin: 0 auto; }
        }

        /* ── MOBILE HAMBURGER NAVBAR ── */
        .hamburger-btn {
            display: none;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            gap: 4.5px;
            width: 38px;
            height: 38px;
            border-radius: 50%;
            background: none;
            border: none;
            cursor: pointer;
            padding: 0;
            transition: background 0.2s;
            overflow: visible;
        }
        .hamburger-btn:hover { background: rgba(255, 215, 0, 0.15); }
        .hbar {
            width: 19px;
            height: 2px;
            background: var(--accent-yellow);
            border-radius: 2px;
            transition: all 0.25s ease;
            display: block;
        }
        .hamburger-btn.open .hbar:nth-child(1) { transform: translateY(6.5px) rotate(45deg); }
        .hamburger-btn.open .hbar:nth-child(2) { opacity: 0; transform: scaleX(0); }
        .hamburger-btn.open .hbar:nth-child(3) { transform: translateY(-6.5px) rotate(-45deg); }

        .mobile-nav-drawer {
            display: none;
            position: fixed;
            top: 56px;
            left: 0;
            right: 0;
            background: rgba(10, 2, 2, 0.97);
            backdrop-filter: blur(14px);
            -webkit-backdrop-filter: blur(14px);
            max-height: 0;
            overflow: hidden;
            transition: max-height 0.32s cubic-bezier(0.4, 0, 0.2, 1), border-top 0.3s;
            z-index: 998;
        }
        .mobile-nav-drawer.open {
            max-height: 280px;
            border-top: 1px solid rgba(255, 215, 0, 0.2);
        }
        .mobile-drawer-link {
            display: flex;
            align-items: center;
            gap: 14px;
            padding: 14px 22px;
            color: rgba(255, 255, 255, 0.85);
            font-size: 0.95rem;
            font-weight: 600;
            border-bottom: 0.5px solid rgba(255, 255, 255, 0.07);
            transition: all 0.18s;
            cursor: pointer;
            text-decoration: none !important;
        }
        .mobile-drawer-link:hover,
        .mobile-drawer-link.active {
            background: rgba(255, 215, 0, 0.08);
            color: var(--accent-yellow);
            padding-left: 28px;
        }
        .mobile-drawer-link i {
            font-size: 0.9rem;
            width: 18px;
            text-align: center;
            opacity: 0.75;
        }
        .mobile-drawer-link.active i { opacity: 1; }

        @media (max-width: 768px) {
            /* Hide desktop horizontal nav links */
            .nav-links { display: none !important; }
            /* Show hamburger button */
            .hamburger-btn { display: flex !important; }
            /* Show mobile drawer */
            .mobile-nav-drawer { display: block; }
            /* Compact navbar */
            .navbar { padding: 8px 12px !important; min-height: 56px; }
            /* Slightly smaller brand name */
            .brand-name { font-size: 1.3rem; }
            /* Tighten icon gap */
            .nav-icons { gap: 0px; }
            /* Hero text adjustments */
            .hero-content h1 { font-size: 2rem; }
            .hero-tagline { font-size: 1.2rem; }
            .hero-subtitle { font-size: 1.1rem; }
            .hero-description { font-size: 1rem; }
            /* About section */
            .about-title { font-size: 2rem; }
            .about-section { padding: 50px 5%; }
            .content-box { padding: 25px 20px; }
            /* Contact sidebar stack */
            .contact-info-sidebar { flex-direction: column; gap: 20px; padding: 20px; }
            .contact-info-group + .contact-info-group { border-left: none; padding-left: 0; border-top: 1px solid rgba(255,215,0,0.2); padding-top: 20px; }
            .map-wrapper-large { height: 300px; }
            /* Footer */
            .footer-container { flex-direction: column; gap: 20px; }
            .footer-bottom-content { flex-direction: column; text-align: center; }
            /* Steps */
            .compact-steps-grid { flex-direction: column; align-items: center; }
            .compact-step-card { max-width: 100%; }
            /* Cart modal */
            .cart-modal-content { width: 100%; right: 0; border-radius: 15px 15px 0 0; top: auto; bottom: 0; }
            /* Back to top */
            .back-to-top { bottom: 20px; right: 15px; width: 42px; height: 42px; }
        }

        .custom-confirm-overlay {
            display: none;
            position: fixed;
            inset: 0;
            background: rgba(0, 0, 0, 0.65);
            z-index: 9999;
            align-items: center;
            justify-content: center;
            backdrop-filter: blur(4px);
            -webkit-backdrop-filter: blur(4px);
            opacity: 0;
            transition: opacity 0.25s ease;
        }
        .custom-confirm-overlay.show {
            display: flex;
            opacity: 1;
        }
        .custom-confirm-box {
            background: linear-gradient(145deg, #7D0A22 0%, #5a0819 100%);
            border: 2px solid var(--accent-yellow);
            border-radius: 20px;
            padding: 36px 40px 30px;
            max-width: 420px;
            width: 90%;
            text-align: center;
            box-shadow: 0 25px 60px rgba(0,0,0,0.5), 0 0 0 1px rgba(255,215,0,0.15);
            transform: scale(0.92) translateY(10px);
            transition: transform 0.28s cubic-bezier(0.34, 1.56, 0.64, 1);
            position: relative;
            overflow: hidden;
        }
        .custom-confirm-overlay.show .custom-confirm-box {
            transform: scale(1) translateY(0);
        }
        .custom-confirm-box::before {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0;
            height: 3px;
            background: linear-gradient(90deg, transparent, var(--accent-yellow), transparent);
        }
        .custom-confirm-icon {
            width: 64px;
            height: 64px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 18px;
            font-size: 1.7rem;
        }
        .custom-confirm-icon.icon-warning {
            background: rgba(255, 215, 0, 0.15);
            border: 2px solid rgba(255, 215, 0, 0.4);
            color: var(--accent-yellow);
        }
        .custom-confirm-icon.icon-danger {
            background: rgba(220, 53, 69, 0.15);
            border: 2px solid rgba(220, 53, 69, 0.4);
            color: #ff6b7a;
        }
        .custom-confirm-icon.icon-success {
            background: rgba(40, 167, 69, 0.15);
            border: 2px solid rgba(40, 167, 69, 0.4);
            color: #5dd879;
        }
        .custom-confirm-box h3 {
            font-size: 1.25rem;
            font-weight: 800;
            color: var(--accent-yellow);
            margin-bottom: 10px;
            letter-spacing: 0.5px;
        }
        .custom-confirm-box p {
            color: rgba(255,255,255,0.85);
            font-size: 0.95rem;
            line-height: 1.6;
            margin-bottom: 28px;
        }
        .custom-confirm-box p strong {
            color: white;
        }
        .custom-confirm-actions {
            display: flex;
            gap: 12px;
            justify-content: center;
        }
        .custom-confirm-actions .btn-confirm-cancel {
            flex: 1;
            padding: 11px 20px;
            border-radius: 50px;
            border: 2px solid rgba(255,255,255,0.25);
            background: rgba(255,255,255,0.08);
            color: rgba(255,255,255,0.85);
            font-family: 'Quicksand', sans-serif;
            font-weight: 700;
            font-size: 0.9rem;
            cursor: pointer;
            transition: all 0.25s ease;
        }
        .custom-confirm-actions .btn-confirm-cancel:hover {
            background: rgba(255,255,255,0.15);
            border-color: rgba(255,255,255,0.5);
            color: white;
        }
        .custom-confirm-actions .btn-confirm-ok {
            flex: 1;
            padding: 11px 20px;
            border-radius: 50px;
            border: none;
            font-family: 'Quicksand', sans-serif;
            font-weight: 700;
            font-size: 0.9rem;
            cursor: pointer;
            transition: all 0.25s ease;
        }
        .custom-confirm-actions .btn-confirm-ok.ok-yellow {
            background: var(--accent-yellow);
            color: var(--primary-maroon);
        }
        .custom-confirm-actions .btn-confirm-ok.ok-yellow:hover {
            background: #ffed4e;
            box-shadow: 0 4px 15px rgba(255,215,0,0.4);
            transform: translateY(-1px);
        }
        .custom-confirm-actions .btn-confirm-ok.ok-danger {
            background: linear-gradient(135deg, #dc3545, #c82333);
            color: white;
        }
        .custom-confirm-actions .btn-confirm-ok.ok-danger:hover {
            background: linear-gradient(135deg, #e84050, #dc3545);
            box-shadow: 0 4px 15px rgba(220,53,69,0.4);
            transform: translateY(-1px);
        }
        .custom-confirm-actions .btn-confirm-ok.ok-success {
            background: linear-gradient(135deg, #28a745, #20883a);
            color: white;
        }
        .custom-confirm-actions .btn-confirm-ok.ok-success:hover {
            background: linear-gradient(135deg, #34c759, #28a745);
            box-shadow: 0 4px 15px rgba(40,167,69,0.4);
            transform: translateY(-1px);
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true"></asp:ScriptManager>
        
        <asp:HiddenField ID="hdnUserAddress" runat="server" />
        <asp:HiddenField ID="hdnSelectedMenuID" runat="server" />
        <asp:HiddenField ID="hdnSelectedMenuName" runat="server" />
        <asp:HiddenField ID="hdnSelectedMenuPrice" runat="server" />
        <asp:HiddenField ID="hdnSelectedQuantity" runat="server" />
        <asp:HiddenField ID="hdnSelectedSpecialRequest" runat="server" />
        <asp:HiddenField ID="hdnSelectedExtras" runat="server" />
        
        <div class="back-to-top" id="backToTopBtn">
            <i class="fas fa-arrow-up"></i>
        </div>

        <div id="profileDropdownOverlay" class="profile-dropdown-overlay"></div>

        <div class="profile-dropdown" id="profileDropdown">
            <div class="profile-dropdown-header">
                <div class="profile-avatar-small"><i class="fas fa-user"></i></div>
                <div class="profile-name"><asp:Literal ID="litFullName" runat="server">Customer</asp:Literal></div>
                <div class="profile-email"><asp:Literal ID="litEmail" runat="server">customer@example.com</asp:Literal></div>
            </div>
            <div class="profile-dropdown-menu">
                <a href="#" class="profile-dropdown-item" id="dropdownMyProfileLink" data-tooltip="Personal Info"><i class="fas fa-user-circle"></i><span>My Profile</span></a>
                <a href="#" class="profile-dropdown-item" id="dropdownSecurityLink" data-tooltip="Change Password"><i class="fas fa-shield-alt"></i><span>Security</span></a>
                <a href="#" class="profile-dropdown-item" id="dropdownOrdersLink" data-tooltip="Order History"><i class="fas fa-clipboard-list"></i><span>My Orders</span></a>
                <div class="profile-dropdown-divider"></div>
                <asp:HyperLink ID="logoutLink" runat="server" CssClass="profile-dropdown-item profile-dropdown-logout" NavigateUrl="~/Login.aspx"><i class="fas fa-sign-out-alt"></i><span>LOG OUT</span></asp:HyperLink>
            </div>
        </div>

        <div id="profileModal" class="profile-modal">
            <div class="profile-modal-content">
                <div class="profile-modal-header">
                    <h2 id="profileModalTitle"><i class="fas fa-user-circle"></i> My Profile</h2>
                    <button type="button" class="profile-modal-close" id="closeModalBtn">&times;</button>
                </div>
                <div class="profile-modal-body" id="profileModalBody">
                    <div id="panelPersonalInfo" class="profile-panel">
                        <div class="profile-avatar"><i class="fas fa-user-circle"></i></div>
                        
                        <div class="form-group">
                            <label>Full Name</label>
                            <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        
                        <div class="form-group">
                            <label>Email</label>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
                        </div>
                        
                        <div class="form-group">
                            <label>Phone</label>
                            <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        
                        <div class="form-group">
                            <label>Gender</label>
                            <asp:DropDownList ID="ddlGender" runat="server" CssClass="form-control">
                                <asp:ListItem Text="Select Gender" Value=""></asp:ListItem>
                                <asp:ListItem Text="Male" Value="Male"></asp:ListItem>
                                <asp:ListItem Text="Female" Value="Female"></asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <div style="margin-top: 1rem; border-top: 1px solid #eee; padding-top: 1rem;">
                            <h4 style="color: var(--primary-maroon); margin-bottom: 1rem; font-size: 1rem;">
                                <i class="fas fa-map-marker-alt"></i> Address Information
                            </h4>
                            
                            <div class="form-group">
                                <label>House/Building No.</label>
                                <asp:TextBox ID="txtHouseNo" runat="server" CssClass="form-control" placeholder="e.g., 123, Blk 84 Lot 10"></asp:TextBox>
                            </div>
                            
                            <div class="form-group">
                                <label>Street</label>
                                <asp:TextBox ID="txtStreet" runat="server" CssClass="form-control" placeholder="e.g., Bautista St"></asp:TextBox>
                            </div>
                            
                            <div class="form-group">
                                <label>Barangay</label>
                                <asp:DropDownList ID="ddlBarangay" runat="server" CssClass="form-control"></asp:DropDownList>
                            </div>
                            
                            <div class="form-group">
                                <label>City/Municipality</label>
                                <asp:TextBox ID="txtCity" runat="server" CssClass="form-control" Text="Dasmariñas" ReadOnly="true" BackColor="#F5F5F5"></asp:TextBox>
                            </div>
                        </div>

                        <asp:Button ID="btnSaveProfile" runat="server" Text="Save Changes" CssClass="btn-save" OnClick="btnSaveProfile_Click" />
                        <asp:Panel ID="pnlProfileMessage" runat="server" CssClass="message" Visible="false">
                            <asp:Literal ID="litProfileMessage" runat="server"></asp:Literal>
                        </asp:Panel>
                    </div>

                    <div id="panelSecurity" class="profile-panel" style="display:none;">
                        <div class="form-group">
                            <label>Current Password</label>
                            <div class="password-wrapper">
                                <asp:TextBox ID="txtCurrentPassword" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
                                <i class="fas fa-eye toggle-password" data-target="txtCurrentPassword"></i>
                            </div>
                        </div>
                        <div class="form-group">
                            <label>New Password</label>
                            <div class="password-wrapper">
                                <asp:TextBox ID="txtNewPassword" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
                                <i class="fas fa-eye toggle-password" data-target="txtNewPassword"></i>
                            </div>
                        </div>
                        <div class="form-group">
                            <label>Confirm Password</label>
                            <div class="password-wrapper">
                                <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
                                <i class="fas fa-eye toggle-password" data-target="txtConfirmPassword"></i>
                            </div>
                        </div>
                        <asp:Button ID="btnChangePassword" runat="server" Text="Update Password" CssClass="btn-change-password" OnClick="btnChangePassword_Click" />
                        <asp:Panel ID="pnlPasswordMessage" runat="server" CssClass="message" Visible="false">
                            <asp:Literal ID="litPasswordMessage" runat="server"></asp:Literal>
                        </asp:Panel>
                    </div>

                    <div id="panelOrders" class="profile-panel" style="display:none;">
                        <h3 style="color: var(--primary-maroon); margin-bottom: 15px;">Active Orders</h3>
                        <asp:Repeater ID="rptActiveOrders" runat="server" OnItemCommand="rptActiveOrders_ItemCommand">
                            <HeaderTemplate><div class="orders-list"></HeaderTemplate>
                            <ItemTemplate>
                                <div class="order-card">
                                    <div style="display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 10px;">
                                        <div>
                                            <strong style="color: var(--primary-maroon);">Order #:</strong> <%# Eval("TicketNumber") %><br />
                                            <strong>Status:</strong> 
                                            <span class="order-status status-<%# Eval("Status").ToString().ToLower() %>">
                                                <%# GetDisplayStatus(Eval("Status").ToString()) %>
                                            </span><br />
                                            <strong>Total:</strong> ₱<%# Convert.ToDecimal(Eval("TotalAmount")).ToString("F2") %><br />
                                            <strong>Delivery to:</strong> <%# Eval("DeliveryAddress") %>
                                        </div>
                                        <div>
                                            <asp:LinkButton ID="btnOrderReceived" runat="server" CommandName="Received" CommandArgument='<%# Eval("TicketNumber") %>' CssClass="btn-received" OnClientClick="return showCustomConfirm(event, 'confirmReceivedModal');"><i class="fas fa-check-circle"></i> Order Received</asp:LinkButton>
                                            <asp:LinkButton ID="btnCancelOrder" runat="server" CommandName="Cancel" CommandArgument='<%# Eval("TicketNumber") %>' CssClass="btn-cancel" OnClientClick="return showCustomConfirm(event, 'confirmCancelModal');"><i class="fas fa-times"></i> Cancel</asp:LinkButton>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                            <FooterTemplate>
                                </div>
                                <asp:PlaceHolder ID="phEmptyActive" runat="server" Visible='<%# (rptActiveOrders.Items.Count == 0) %>'>
                                    <div style="text-align: center; padding: 20px; color: var(--text-muted);">No active orders found.</div>
                                </asp:PlaceHolder>
                            </FooterTemplate>
                        </asp:Repeater>
                        
                        <h3 style="color: var(--primary-maroon); margin: 25px 0 15px;">Order History</h3>
                        <asp:Repeater ID="rptOrderHistory" runat="server" OnItemCommand="rptOrderHistory_ItemCommand">
                            <HeaderTemplate><div class="orders-list"></HeaderTemplate>
                            <ItemTemplate>
                                <div class="order-card" style="border-left-color: #ddd;">
                                    <div style="display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 10px;">
                                        <div>
                                            <strong style="color: var(--primary-maroon);"><%# Eval("TicketNumber") %></strong><br />
                                            <small><%# Convert.ToDateTime(Eval("CreatedAt")).ToString("MMM dd, yyyy hh:mm tt") %></small><br />
                                            <strong>Items:</strong> <%# Eval("ItemCount") %> | <strong>Total:</strong> ₱<%# Convert.ToDecimal(Eval("TotalAmount")).ToString("F2") %>
                                        </div>
                                        <div>
                                            <span class="order-status status-<%# Eval("Status").ToString().ToLower() %>"><%# Eval("Status") %></span>
                                            <asp:LinkButton ID="btnReorder" runat="server" CommandName="Reorder" CommandArgument='<%# Eval("TicketNumber") %>' CssClass="btn-reorder"><i class="fas fa-redo"></i> Reorder</asp:LinkButton>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                            <FooterTemplate>
                                </div>
                                <asp:PlaceHolder ID="phEmptyHistory" runat="server" Visible='<%# (rptOrderHistory.Items.Count == 0) %>'>
                                    <div style="text-align: center; padding: 20px; color: var(--text-muted);">No order history found.</div>
                                </asp:PlaceHolder>
                            </FooterTemplate>
                        </asp:Repeater>
                    </div>
                </div>
            </div>
        </div>

        <div class="cart-modal" id="cartModal">
            <div class="cart-modal-overlay" id="cartOverlay"></div>
            <div class="cart-modal-content">
                <div class="cart-modal-header">
                    <h3><i class="fas fa-shopping-basket"></i> Your Order</h3>
                    <button class="cart-close-btn" id="cartCloseBtn">&times;</button>
                </div>
                <div class="cart-modal-body">
                    <asp:UpdatePanel ID="upCart" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <asp:Panel ID="pnlEmptyCart" runat="server" Visible="false" CssClass="cart-empty-state">
                                <i class="fas fa-shopping-basket"></i>
                                <p>Your cart is empty</p>
                                <a href="#menu" class="btn-browse-menu">Browse Menu</a>
                            </asp:Panel>
                            <asp:Repeater ID="rptCart" runat="server" OnItemCommand="rptCart_ItemCommand">
                                <ItemTemplate>
                                    <div class="cart-item">
                                        <div class="cart-item-header">
                                            <div class="cart-item-name"><%# Eval("Name") %></div>
                                            <div class="cart-item-price">₱<%# Convert.ToDecimal(Eval("Price")) * Convert.ToInt32(Eval("Quantity")) %></div>
                                        </div>
                                        <div class="cart-item-controls">
                                            <div class="quantity-controls">
                                                <asp:LinkButton ID="btnMinus" runat="server" CommandName="Update" CommandArgument='<%# Eval("CartItemId") %>' CssClass="quantity-btn">-</asp:LinkButton>
                                                <asp:TextBox ID="txtQty" runat="server" Text='<%# Eval("Quantity") %>' CssClass="quantity-value" Width="50px" />
                                                <asp:LinkButton ID="btnPlus" runat="server" CommandName="Update" CommandArgument='<%# Eval("CartItemId") %>' CssClass="quantity-btn">+</asp:LinkButton>
                                            </div>
                                            <asp:LinkButton ID="btnRemove" runat="server" CommandName="Remove" CommandArgument='<%# Eval("CartItemId") %>' CssClass="remove-item-btn"><i class="fas fa-trash"></i> Remove</asp:LinkButton>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <div class="cart-modal-footer">
                    <div class="cart-summary">
                        <div class="cart-summary-row"><span>Subtotal</span><span>₱<asp:Literal ID="litSubtotal" runat="server" /></span></div>
                        <div class="cart-summary-row"><span>Delivery Fee</span><span><asp:Literal ID="litDeliveryFee" runat="server" /></span></div>
                        <div class="cart-summary-row cart-total"><span>Total</span><span>₱<asp:Literal ID="litTotal" runat="server" /></span></div>
                    </div>
                    <div class="cart-actions">
                        <asp:Button ID="btnClearCart" runat="server" Text="Clear Cart" CssClass="btn-clear-cart" OnClick="btnClearCart_Click" OnClientClick="return showCustomConfirm(event, 'confirmClearCartModal');" />
                        <asp:Button ID="btnCheckout" runat="server" Text="Checkout" CssClass="btn-checkout" OnClick="btnCheckout_Click" />
                    </div>
                    <div class="cart-delivery-info">
                        <i class="fas fa-info-circle"></i>
                        <span>Delivery fee is based on your barangay. Free delivery on orders over ₱500.</span>
                    </div>
                </div>
            </div>
        </div>

        <div class="checkout-modal" id="checkoutModal">
            <div class="checkout-modal-overlay" id="checkoutOverlay"></div>
            <div class="checkout-modal-content">
                <div class="checkout-modal-header">
                    <h3><i class="fas fa-clipboard-list"></i> Checkout</h3>
                    <button class="checkout-close-btn" id="checkoutCloseBtn">&times;</button>
                </div>
                <div class="checkout-modal-body">
                    <div class="checkout-section">
                        <h4><i class="fas fa-map-marker-alt"></i> Delivery Address</h4>
                        <div id="existingAddressesContainer" class="address-list">
                            <div class="address-option">
                                <div class="address-option-content">
                                    <div class="address-option-name">
                                        Default Delivery Address
                                        <span class="address-default-badge">From Profile</span>
                                    </div>
                                    <div class="address-option-text" id="defaultAddressDisplay">
                                        <asp:Literal ID="litDefaultAddress" runat="server" Text="No address set. Please update your profile." />
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="new-address-toggle">
                            <asp:CheckBox ID="useNewAddressCheckbox" runat="server" />
                            <label for="useNewAddressCheckbox">Use a different address</label>
                        </div>
                        
                        <div id="newAddressForm" style="display: none;" class="new-address-form">
                            <div class="form-group">
                                <label>House/Building No. *</label>
                                <asp:TextBox ID="txtNewHouseNo" runat="server" CssClass="form-control" placeholder="e.g., 123, Blk 84 Lot 10"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <label>Street *</label>
                                <asp:TextBox ID="txtNewStreet" runat="server" CssClass="form-control" placeholder="Enter street name"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <label>Barangay *</label>
                                <asp:DropDownList ID="ddlNewBarangay" runat="server" CssClass="form-control"></asp:DropDownList>
                            </div>
                            <div class="form-group">
                                <label>City/Municipality</label>
                                <asp:TextBox ID="txtNewCity" runat="server" CssClass="form-control" Text="Dasmariñas" Enabled="false" style="background-color: #f5f5f5;"></asp:TextBox>
                                <small style="color: var(--text-muted); font-size: 0.7rem;">Service area: Dasmariñas City only</small>
                            </div>
                            <div class="form-group">
                                <label>Landmark (Optional)</label>
                                <asp:TextBox ID="txtNewLandmark" runat="server" CssClass="form-control" placeholder="Nearby landmark"></asp:TextBox>
                            </div>
                        </div>
                    </div>

                    <div class="checkout-section">
                        <h4><i class="fas fa-credit-card"></i> Payment Method</h4>
                        <div class="payment-options">
                            <asp:Repeater ID="rptPaymentMethods" runat="server">
                                <ItemTemplate>
                                    <label class='payment-option <%# (string)Eval("Status") == "Inactive" || (string)Eval("Status") == "Disabled" ? "payment-option-disabled" : "" %>'
                                           title='<%# (string)Eval("Status") == "Inactive" || (string)Eval("Status") == "Disabled" ? "This payment method is currently unavailable." : "" %>'>
                                        <input type="radio" name="paymentMethod"
                                               value='<%# Eval("MethodName") %>'
                                               <%# (string)Eval("Status") == "Inactive" || (string)Eval("Status") == "Disabled" ? "disabled=\"disabled\"" : "" %> />
                                        <div class="payment-option-content">
                                            <i class='<%# GetPaymentIcon((string)Eval("MethodName")) %>'></i>
                                            <span><%# Eval("MethodName") %></span>
                                            <asp:PlaceHolder runat="server" Visible='<%# !string.IsNullOrEmpty((string)(Eval("AccountDetails") ?? "")) %>'>
                                                <small><%# Eval("AccountDetails") %></small>
                                            </asp:PlaceHolder>
                                            <%# (string)Eval("Status") == "Inactive" || (string)Eval("Status") == "Disabled" ? "<span class=\"badge-unavailable\">Unavailable</span>" : "" %>
                                        </div>
                                    </label>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <asp:PlaceHolder runat="server" Visible='<%# rptPaymentMethods.Items.Count == 0 %>'>
                                        <div style="padding:12px 8px;color:#999;font-size:0.85rem;text-align:center;">
                                            <i class="fas fa-exclamation-circle"></i> No payment methods available. Please contact support.
                                        </div>
                                    </asp:PlaceHolder>
                                </FooterTemplate>
                            </asp:Repeater>
                        </div>
                        <div id="paymentInfo" class="gcash-info" style="display: none;">
                            <div class="alert alert-info" id="paymentInfoText">
                                <i class="fas fa-info-circle"></i> <span id="paymentInfoMessage"></span>
                            </div>
                        </div>
                    </div>

                    <div class="checkout-section special-instructions-section">
                        <h4><i class="fas fa-comment-alt"></i> Special Instructions <span style="font-size:0.75rem;color:var(--text-muted);font-weight:500;">(Optional)</span></h4>
                        <div class="special-instructions-wrapper">
                            <div class="special-instructions-icon"><i class="fas fa-pen-fancy"></i></div>
                            <asp:TextBox ID="txtCheckoutInstructions" runat="server" CssClass="special-instructions-textarea" 
                                TextMode="MultiLine" Rows="3" 
                                placeholder="e.g. Please ring the bell, no chili, gate code 1234..."></asp:TextBox>
                        </div>
                        <div class="special-instructions-hints">
                            <span onclick="appendInstruction('No chili')"><i class="fas fa-pepper-hot"></i> No chili</span>
                            <span onclick="appendInstruction('Extra napkins')"><i class="fas fa-scroll"></i> Extra napkins</span>
                            <span onclick="appendInstruction('Ring the bell')"><i class="fas fa-bell"></i> Ring bell</span>
                            <span onclick="appendInstruction('Leave at door')"><i class="fas fa-door-open"></i> Leave at door</span>
                        </div>
                    </div>
                </div>
                <div class="checkout-modal-footer">
                    <button type="button" class="btn-secondary" id="cancelCheckoutBtn">Cancel</button>
                    <asp:Button ID="btnConfirmOrder" runat="server" Text="Confirm Order" CssClass="btn-primary" OnClick="btnConfirmOrder_Click" />
                </div>
            </div>
        </div>

        <div class="meal-detail-modal" id="mealDetailModal">
            <div class="meal-modal-overlay" id="mealOverlay"></div>
            <div class="meal-modal-content">
                <div class="meal-modal-header">
                    <h2 id="mealModalTitle"><i class="fas fa-utensils"></i> Meal Details</h2>
                    <button class="meal-close-btn" id="mealCloseBtn">&times;</button>
                </div>
                <div class="meal-modal-body" id="mealModalBody"></div>
                <div class="meal-modal-footer">
                    <div class="meal-quantity-selector">
                        <span>Quantity:</span>
                        <div class="meal-quantity-controls">
                            <button type="button" class="meal-qty-btn minus" id="modalMinusBtn">-</button>
                            <input type="number" class="meal-quantity-input" id="modalQuantity" value="1" min="1" max="10" />
                            <button type="button" class="meal-qty-btn plus" id="modalPlusBtn">+</button>
                        </div>
                    </div>
                    <div class="meal-modal-actions">
                        <button type="button" class="btn-close-meal-modal" id="closeMealModalBtn">Close</button>
                        <asp:LinkButton ID="btnAddToCartFromModal" runat="server" CssClass="btn-add-to-cart-meal" OnClick="btnAddToCartFromModal_Click"><i class="fas fa-cart-plus"></i> Add to Cart</asp:LinkButton>
                    </div>
                </div>
            </div>
        </div>

        <nav class="navbar" id="mainNavbar">
            <div class="logo-container" data-section="home">
                <img src='<%= ResolveUrl("~/Images/LOGO.png") %>' alt="Caballeros Logo" class="logo-img" />
                <span class="brand-name">Caballeros</span>
            </div>

            <%-- Desktop nav links — hidden on mobile via CSS --%>
            <ul class="nav-links">
                <li><a href="#home" class="nav-link active">Home</a></li>
                <li><a href="#about" class="nav-link">About Us</a></li>
                <li><a href="#menu" class="nav-link">Menu</a></li>
                <li><a href="#contact" class="nav-link">Contact</a></li>
            </ul>

            <div class="nav-icons">
                <a href="#" id="cartIcon" class="cart-icon-wrapper" data-tooltip="Shopping Cart">
                    <i class="fas fa-shopping-basket"></i>
                    <span class="cart-badge" id="cartBadge">0</span>
                </a>
                <a href="#" id="profileIcon" data-tooltip="My Account">
                    <i class="fas fa-user-circle"></i>
                </a>
                <%-- Hamburger button — visible on mobile only --%>
                <button type="button" class="hamburger-btn" id="hamburgerBtn" aria-label="Open menu" aria-expanded="false">
                    <span class="hbar"></span>
                    <span class="hbar"></span>
                    <span class="hbar"></span>
                </button>
            </div>

            <%-- Mobile slide-down drawer --%>
            <div class="mobile-nav-drawer" id="mobileNavDrawer" role="navigation" aria-label="Main menu">
                <a href="#home" class="mobile-drawer-link active" onclick="closeMobileDrawer()">
                    <i class="fas fa-home"></i> Home
                </a>
                <a href="#about" class="mobile-drawer-link" onclick="closeMobileDrawer()">
                    <i class="fas fa-info-circle"></i> About Us
                </a>
                <a href="#menu" class="mobile-drawer-link" onclick="closeMobileDrawer()">
                    <i class="fas fa-utensils"></i> Menu
                </a>
                <a href="#contact" class="mobile-drawer-link" onclick="closeMobileDrawer()">
                    <i class="fas fa-phone"></i> Contact
                </a>
            </div>
        </nav>

        <div id="home" class="hero-container section-fade-in">
            <div class="hero-content">
                <h1>Sizzling Good Food,<br />Delivered Hot!</h1>
                <div class="hero-tagline">Dasmariñas' Favorite Silog & Sizzling Meals</div>
                <div class="hero-subtitle">Lutong-Bahay Delivered to your Doorstep</div>
                <div class="hero-description">Authentic Filipino home-based meals from Dasmariñas City's finest kitchens</div>
                <div class="search-box">
                    <i class="fas fa-search"></i>
                    <input type="text" class="search-input" id="heroSearchInput" placeholder="Search for Tapsilog, Sisig, or your Favorite..." />
                    <button type="button" class="btn-search" id="heroSearchBtn">Search</button>
                </div>
                <div class="cta-group">
                    <a href="#menu" class="btn-order">Order Now!</a>
                </div>
            </div>
        </div>

        <section id="about" class="about-section section-fade-in">
            <div class="about-container">
                <h3 class="about-title">ABOUT CABALLEROS</h3>
                <p class="about-tagline">
                    Bringing The Authentic Taste Of Filipino Home Based Meals to your Doorstep
                </p>
                <div class="content-box">
                    <div class="content-text">
                        <p>Caballeros is a local food business dedicated to serving quality homemade meals made with care and passion. From humble beginnings, it has grown through hard work and the trust of loyal customers who value comfort food and genuine service.</p>
                        <p>By embracing modern solutions while keeping its home-style touch, Caballeros continues to bring delicious meals closer to the community—one order at a time.</p>
                    </div>
                </div>
            </div>
        </section>

        <section id="menu" class="menu-display-section section-fade-in">
            <h2 class="menu-header">DISCOVER OUR MENU</h2>
            <asp:Repeater ID="rptMenuCategories" runat="server" OnItemDataBound="rptMenuCategories_ItemDataBound">
                <ItemTemplate>
                    <div class="menu-category-container">
                        <h3 class="category-title"><%# Eval("FoodType") %></h3>
                        <div class="menu-grid-container">
                            <asp:Repeater ID="rptCategoryItems" runat="server">
                                <ItemTemplate>
                                    <div class="menu-container" data-menu-name='<%# Eval("Name") %>'>
                                        <img src='<%# GetImagePath(Eval("ImagePath"), Eval("Name").ToString()) %>' alt='<%# Eval("Name") %>' class="menu-featured-img" onerror="this.src='<%= ResolveUrl("~/Images/default-menu.jpg") %>'" />
                                        <div class="menu-list-container">
                                            <div class="category-label"><%# Eval("Name") %></div>
                                            <div class="meal-description-short"><%# Eval("Description") %></div>
                                            <div class="item-price-small">₱<%# Eval("Price", "{0:F2}") %></div>
                                            <div class="menu-item-buttons">
                                                <button type="button" class="view-btn" onclick='openMealModal("<%# Eval("MenuID") %>","<%# Eval("Name").ToString().Replace("'","\\x27") %>","<%# Eval("Price") %>","<%# Eval("Description").ToString().Replace("'","\\x27").Replace("\r","").Replace("\n"," ") %>","<%# GetImagePath(Eval("ImagePath"), Eval("Name").ToString()) %>")'><i class="fas fa-eye"></i> VIEW</button>
                                                <asp:LinkButton ID="btnAddToCart" runat="server" CssClass="add-to-cart-btn-text" OnClick="btnAddToCart_Click" CommandArgument='<%# Eval("MenuID") + "|" + Eval("Name") + "|" + Eval("Price") %>'><i class="fas fa-cart-plus"></i> ADD</asp:LinkButton>
                                            </div>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </section>

        <section class="love-us-section section-fade-in">
            <div class="love-us-container">
                <h2 class="love-us-title">Why Customers Love Us</h2>
                <p style="margin-bottom: 30px; max-width: 800px; margin-left: auto; margin-right: auto; color: var(--text-muted);">
                    Discover what makes TasteNet the trusted choice for authentic Filipino home-cooked meals
                </p>
                <div class="features-grid">
                    <div class="feature-card">
                        <div class="feature-icon"><i class="fas fa-leaf"></i></div>
                        <h3 class="feature-title">Fresh Daily</h3>
                        <p class="feature-description">We cook fresh meals every day using high-quality ingredients. No preservatives, just pure homemade goodness.</p>
                    </div>
                    <div class="feature-card">
                        <div class="feature-icon"><i class="fas fa-utensils"></i></div>
                        <h3 class="feature-title">Authentic Taste</h3>
                        <p class="feature-description">Traditional Filipino recipes with a twist. Experience the genuine flavors of home-cooked meals passed down through generations.</p>
                    </div>
                    <div class="feature-card">
                        <div class="feature-icon"><i class="fas fa-shipping-fast"></i></div>
                        <h3 class="feature-title">Quick Delivery</h3>
                        <p class="feature-description">Hot meals delivered fast to your doorstep. Our efficient delivery system ensures your food arrives fresh and sizzling hot.</p>
                    </div>
                    <div class="feature-card">
                        <div class="feature-icon"><i class="fas fa-user-check"></i></div>
                        <h3 class="feature-title">Cook Your Way</h3>
                        <p class="feature-description">Customize your meal just how you want it. Adjust spice levels, add extra toppings, or make special requests.</p>
                    </div>
                </div>
            </div>
        </section>

        <section class="compact-order-steps section-fade-in">
            <div class="steps-container">
                <h2 class="compact-steps-header">ORDER IN 3 EASY STEPS</h2>
                <div class="compact-steps-grid">
                    <div class="compact-step-card">
                        <div class="compact-step-number">01</div>
                        <h3 class="compact-step-title">Browse & Select</h3>
                        <p class="compact-step-description">Choose from our sizzling specials and silog meals. Explore our full menu and find your favorites.</p>
                    </div>
                    <div class="compact-step-card">
                        <div class="compact-step-number">02</div>
                        <h3 class="compact-step-title">Customize & Order</h3>
                        <p class="compact-step-description">Add to cart and place your order online. Customize your meal with extra toppings or special requests.</p>
                    </div>
                    <div class="compact-step-card">
                        <div class="compact-step-number">03</div>
                        <h3 class="compact-step-title">We Deliver Hot!</h3>
                        <p class="compact-step-description">We deliver with our trusted rider straight to your door. Hot and fresh, just like home cooking.</p>
                    </div>
                </div>
                <div class="cta-banner">
                    <h3 class="cta-title">Hungry? Order Now!</h3>
                    <p class="cta-subtitle">Free delivery on orders over ₱500. Delivery fee varies by barangay.</p>
                    <a href="#menu" class="btn-cta-large">Order Now</a>
                    <div style="margin-top: 20px;">
                        <p><i class="fas fa-phone"></i> Call us for inquiries:</p>
                        <div class="phone-numbers" style="color: var(--accent-yellow); font-weight: 700;">
                            046-473-9753 / 0912-368-7369
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section id="contact" class="contact-map-section section-fade-in">
            <div class="contact-map-container">
                <div class="contact-map-header">
                    <h1>FIND US HERE</h1>
                    <p class="tagline">Visit our location or contact us for orders</p>
                </div>
                <div class="contact-map-content">
                    <div class="map-container-large">
                        <div class="map-wrapper-large">
                           <iframe 
                                src="https://www.google.com/maps/embed?pb=!4v1770383773979!6m8!1m7!1s2PuvajbO79-J0wNyBbZLUg!2m2!1d14.32649854666237!2d120.9372845304983!3f91.56107397260273!4f3.452054794520592!5f0.4000000000000002" 
                                width="100%" 
                                height="100%" 
                                style="border:0;" 
                                allowfullscreen="" 
                                loading="lazy" 
                                referrerpolicy="no-referrer-when-downgrade"
                                title="Caballeros Location">
                            </iframe>
                        </div>
                    </div>
                    <div class="contact-info-sidebar">
                        <div class="contact-info-group">
                            <h3><i class="fas fa-phone"></i> Contact Numbers</h3>
                            <div class="contact-details-large">
                                <p>For inquiries</p>
                                <div class="phone-large">046-473-9753</div>
                                <div class="phone-large">0912-368-7369</div>
                            </div>
                        </div>
                        <div class="contact-info-group">
                            <h3><i class="fas fa-map-marker-alt"></i> Our Address</h3>
                            <div class="contact-details-large">
                                <p>Blk 84, Lot 10 Bautista St, Zone 9</p>
                                <p>Dasmariñas, 4114 Cavite</p>
                            </div>
                        </div>
                        <div class="contact-info-group">
                            <h3><i class="fas fa-clock"></i> Operating Hours</h3>
                            <div class="contact-details-large">
                                <p>Monday – Sunday</p>
                                <p>10:00 AM – 9:00 PM</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <footer class="main-footer section-fade-in">
            <div class="footer-container">
                <div class="footer-logo-section">
                    <div class="footer-logo-container">
                        <img src='<%= ResolveUrl("~/Images/LOGO.png") %>' alt="TasteNet Logo" class="footer-logo" />
                        <div class="footer-brand-name">TasteNet</div>
                    </div>
                    <p class="footer-tagline">Sizzling Good Food Delivered Hot to your Doorstep in Dasmariñas City</p>
                </div>
                <div class="footer-quick-links">
                    <h3>Quick Links</h3>
                    <div class="quick-links-grid">
                        <a href="#menu" class="footer-link">Menu</a>
                        <a href="#about" class="footer-link">About Us</a>
                        <a href="#contact" class="footer-link">Contact Us</a>
                        <a href="#" class="footer-link" id="termsFooterLink">Terms & Conditions</a>
                        <a href="#" class="footer-link" id="privacyFooterLink">Privacy Policy</a>
                    </div>
                </div>
            </div>
            <div class="footer-bottom">
                <div class="footer-bottom-content">
                    <div class="copyright">© 2025 TasteNet | Sizzling Good Food. All rights reserved.</div>
                    <div class="delivery-tag">
                        <i class="fas fa-map-marker-alt"></i>
                        <span>Delivering in Dasmariñas City, Cavite</span>
                    </div>
                </div>
            </div>
        </footer>

        <script>
            function createRipple(event) {
                const button = event.currentTarget;
                const rect = button.getBoundingClientRect();
                const size = Math.max(rect.width, rect.height);
                const x = event.clientX - rect.left - size / 2;
                const y = event.clientY - rect.top - size / 2;
                
                const ripple = document.createElement('span');
                ripple.style.position = 'absolute';
                ripple.style.width = ripple.style.height = size + 'px';
                ripple.style.left = x + 'px';
                ripple.style.top = y + 'px';
                ripple.style.borderRadius = '50%';
                ripple.style.background = 'rgba(255, 215, 0, 0.5)';
                ripple.style.transform = 'scale(0)';
                ripple.style.animation = 'ripple-animation 0.6s linear';
                ripple.style.pointerEvents = 'none';
                ripple.style.zIndex = '10';
                
                button.style.position = 'relative';
                button.style.overflow = 'hidden';
                button.appendChild(ripple);
                
                setTimeout(() => ripple.remove(), 600);
            }
            
            document.querySelectorAll('.btn-search, .btn-order, .btn-cta-large, .btn-save, .btn-change-password, .btn-checkout, .btn-clear-cart, .btn-primary, .btn-secondary, .view-btn, .add-to-cart-btn-text, .quantity-btn, .remove-item-btn, .meal-qty-btn, .btn-add-to-cart-meal, .btn-close-meal-modal, .btn-received, .btn-cancel, .btn-reorder').forEach(btn => {
                btn.addEventListener('click', createRipple);
            });
            
            document.querySelectorAll('.menu-container').forEach(card => {
                card.addEventListener('click', function(e) {
                    if (e.target.closest('.view-btn') || e.target.closest('.add-to-cart-btn-text')) return;
                    createRipple({ currentTarget: this, clientX: e.clientX, clientY: e.clientY });
                });
            });

            function checkScrollReveal() {
                const fadeElements = document.querySelectorAll('.section-fade-in');
                fadeElements.forEach(element => {
                    const elementTop = element.getBoundingClientRect().top;
                    const elementVisible = 150;
                    if (elementTop < window.innerHeight - elementVisible) {
                        element.classList.add('visible');
                    }
                });
            }

            // Fix 1: Run immediately so hero is never stuck invisible on page load/redirect
            checkScrollReveal();
            window.addEventListener('scroll', checkScrollReveal);
            window.addEventListener('load', checkScrollReveal);
            document.addEventListener('DOMContentLoaded', checkScrollReveal);

            const navbar = document.getElementById('mainNavbar');
            window.addEventListener('scroll', function() {
                if (window.scrollY > 50) {
                    navbar.classList.add('scrolled');
                } else {
                    navbar.classList.remove('scrolled');
                }
            });

            function setupPasswordToggles() {
                document.querySelectorAll('.toggle-password').forEach(toggle => {
                    const newToggle = toggle.cloneNode(true);
                    toggle.parentNode.replaceChild(newToggle, toggle);
                    
                    newToggle.addEventListener('click', function(e) {
                        e.preventDefault();
                        const inputId = this.getAttribute('data-target');
                        const input = document.getElementById(inputId);
                        if (input) {
                            if (input.type === 'password') {
                                input.type = 'text';
                                this.classList.remove('fa-eye');
                                this.classList.add('fa-eye-slash');
                            } else {
                                input.type = 'password';
                                this.classList.remove('fa-eye-slash');
                                this.classList.add('fa-eye');
                            }
                        }
                    });
                });
            }
            
            if (document.readyState === 'loading') {
                document.addEventListener('DOMContentLoaded', setupPasswordToggles);
            } else {
                setupPasswordToggles();
            }

            function showNotification(message, isError, type) {
                if (isError === undefined) isError = false;

                // type can be: 'success' | 'error' | 'info' | 'warning'
                if (!type) type = isError ? 'error' : 'success';

                const configs = {
                    success: { bg: 'linear-gradient(135deg, #28a745 0%, #20c997 100%)', icon: 'fa-check-circle',  accent: '#d4edda' },
                    error:   { bg: 'linear-gradient(135deg, #7D0A22 0%, #a01030 100%)', icon: 'fa-times-circle',   accent: '#f8d7da' },
                    warning: { bg: 'linear-gradient(135deg, #e67e22 0%, #f39c12 100%)', icon: 'fa-exclamation-triangle', accent: '#fff3cd' },
                    info:    { bg: 'linear-gradient(135deg, #2980b9 0%, #3498db 100%)', icon: 'fa-info-circle',   accent: '#d1ecf1' },
                    cart:    { bg: 'linear-gradient(135deg, #7D0A22 0%, #5a0819 100%)', icon: 'fa-cart-plus',     accent: '#FFD700' },
                };
                const cfg = configs[type] || configs.success;

                // Remove any existing toast
                document.querySelectorAll('.tn-toast').forEach(t => t.remove());

                const toast = document.createElement('div');
                toast.className = 'tn-toast';
                toast.innerHTML =
                    '<div class="tn-toast-icon"><i class="fas ' + cfg.icon + '"></i></div>' +
                    '<div class="tn-toast-body">' +
                        '<div class="tn-toast-message">' + message + '</div>' +
                    '</div>' +
                    '<button class="tn-toast-close" onclick="this.parentElement.classList.add(\'tn-hide\');setTimeout(()=>this.parentElement.remove(),350);">&times;</button>' +
                    '<div class="tn-toast-bar"></div>';

                toast.style.cssText = 'position:fixed;bottom:28px;right:22px;z-index:99999;display:flex;align-items:center;gap:12px;' +
                    'background:' + cfg.bg + ';color:#fff;padding:14px 16px 16px 16px;border-radius:14px;' +
                    'box-shadow:0 8px 32px rgba(0,0,0,0.25),0 2px 8px rgba(0,0,0,0.15);' +
                    'min-width:280px;max-width:360px;font-family:\'Quicksand\',sans-serif;font-size:0.93rem;font-weight:600;' +
                    'border-left:4px solid rgba(255,255,255,0.35);' +
                    'animation:tnSlideIn 0.35s cubic-bezier(0.2,0.9,0.4,1.1) forwards;overflow:hidden;';

                document.body.appendChild(toast);

                // Progress bar animation
                const bar = toast.querySelector('.tn-toast-bar');
                bar.style.cssText = 'position:absolute;bottom:0;left:0;height:3px;width:100%;background:rgba(255,255,255,0.45);border-radius:0 0 14px 14px;animation:tnBar 3s linear forwards;';

                setTimeout(() => {
                    toast.style.animation = 'tnSlideOut 0.35s ease forwards';
                    setTimeout(() => toast.remove(), 380);
                }, 3000);
            }

            function updateCartBadge(count) {
                const badge = document.getElementById('cartBadge');
                if (!badge) return;
                badge.textContent = count;
                if (count > 0) {
                    badge.style.display = 'flex';
                    badge.classList.add('pulse');
                    setTimeout(() => badge.classList.remove('pulse'), 300);
                } else {
                    badge.style.display = 'none';
                }
            }

            function animateCartBadge() {
                const badge = document.getElementById('cartBadge');
                if (badge && parseInt(badge.textContent) > 0) {
                    badge.classList.add('pulse');
                    setTimeout(() => badge.classList.remove('pulse'), 300);
                }
            }

            let currentPanel = 'personal';
            let _ordersPollingTimer = null;

            // ===== REAL-TIME ORDERS POLLING =====
            function startOrdersPolling() {
                stopOrdersPolling();
                _ordersPollingTimer = setInterval(function() {
                    const panelOrders = document.getElementById('panelOrders');
                    const modal = document.getElementById('profileModal');
                    // Only poll if modal is open and Orders tab is showing
                    if (!modal || !modal.classList.contains('open')) { stopOrdersPolling(); return; }
                    if (!panelOrders || panelOrders.style.display === 'none') { stopOrdersPolling(); return; }

                    // Try UpdatePanel refresh first; fall back to a lightweight fetch trick
                    try {
                        if (typeof __doPostBack === 'function') {
                            const upOrders = document.getElementById('UpdatePanelOrders');
                            if (upOrders) {
                                __doPostBack(upOrders.id, '');
                                return;
                            }
                        }
                    } catch(e) {}

                    // Fallback: silent fetch of the page, parse out the orders panel HTML and inject it
                    fetch(window.location.href, { method: 'GET', credentials: 'same-origin' })
                        .then(r => r.text())
                        .then(html => {
                            const parser = new DOMParser();
                            const doc = parser.parseFromString(html, 'text/html');
                            const newOrders = doc.getElementById('panelOrders');
                            const curOrders = document.getElementById('panelOrders');
                            if (newOrders && curOrders) {
                                // Preserve display state
                                const disp = curOrders.style.display;
                                curOrders.innerHTML = newOrders.innerHTML;
                                curOrders.style.display = disp;
                                // Re-attach button ripple effects
                                curOrders.querySelectorAll('.btn-cancel, .btn-reorder, .btn-received').forEach(btn => {
                                    btn.addEventListener('click', createRipple);
                                    btn.addEventListener('click', function() { savePageState('orders'); });
                                });
                                // Refresh cart badge from new page state too
                                const newBadge = doc.getElementById('cartBadge');
                                const curBadge = document.getElementById('cartBadge');
                                if (newBadge && curBadge) {
                                    const cnt = parseInt(newBadge.textContent) || 0;
                                    curBadge.textContent = cnt;
                                    curBadge.style.display = cnt > 0 ? 'flex' : 'none';
                                }
                            }
                        })
                        .catch(function() {}); // silent fail
                }, 60000); // poll every 60 seconds (reduced from 15s to prevent constant page activity)
            }

            function stopOrdersPolling() {
                if (_ordersPollingTimer) {
                    clearInterval(_ordersPollingTimer);
                    _ordersPollingTimer = null;
                }
            }
            
            function openProfileModal(panel) {
                const modal = document.getElementById('profileModal');
                const panelPersonal = document.getElementById('panelPersonalInfo');
                const panelSecurity = document.getElementById('panelSecurity');
                const panelOrders = document.getElementById('panelOrders');
                const modalTitle = document.getElementById('profileModalTitle');
                
                if (panelPersonal) panelPersonal.style.display = 'none';
                if (panelSecurity) panelSecurity.style.display = 'none';
                if (panelOrders) panelOrders.style.display = 'none';
                
                if (panel === 'personal') {
                    if (panelPersonal) panelPersonal.style.display = 'block';
                    if (modalTitle) modalTitle.innerHTML = '<i class="fas fa-user-circle"></i> My Profile';
                    currentPanel = 'personal';
                    stopOrdersPolling();
                } else if (panel === 'security') {
                    if (panelSecurity) panelSecurity.style.display = 'block';
                    if (modalTitle) modalTitle.innerHTML = '<i class="fas fa-shield-alt"></i> Security';
                    currentPanel = 'security';
                    stopOrdersPolling();
                    setTimeout(setupPasswordToggles, 100);
                } else if (panel === 'orders') {
                    if (panelOrders) panelOrders.style.display = 'block';
                    if (modalTitle) modalTitle.innerHTML = '<i class="fas fa-clipboard-list"></i> My Orders';
                    currentPanel = 'orders';
                    startOrdersPolling();
                }

                if (modal) {
                    document.body.style.overflow = 'hidden';
                    requestAnimationFrame(() => modal.classList.add('open'));
                }
            }
            
            function closeProfileModal() {
                const modal = document.getElementById('profileModal');
                if (modal) {
                    modal.classList.remove('open');
                    setTimeout(() => { document.body.style.overflow = 'auto'; }, 300);
                }
                stopOrdersPolling();
            }
            
            function openCartModal() {
                const modal = document.getElementById('cartModal');
                if (modal) {
                    modal.style.display = 'block';
                    document.body.style.overflow = 'hidden';
                }
            }
            
            function closeCartModal() {
                const modal = document.getElementById('cartModal');
                if (modal) {
                    modal.style.display = 'none';
                    document.body.style.overflow = 'auto';
                }
            }
            
            function openCheckoutModal() {
                const cartModal = document.getElementById('cartModal');
                if (cartModal) cartModal.style.display = 'none';

                const modal = document.getElementById('checkoutModal');
                if (modal) {
                    const content = modal.querySelector('.checkout-modal-content');
                    if (content) {
                        content.style.transition = 'none';
                        content.style.transform = 'translate(-50%, -50%)';
                        content.style.top = '50%';
                        content.style.left = '50%';
                    }
                    modal.style.display = 'block';
                    requestAnimationFrame(() => {
                        if (content) {
                            content.style.transition = '';
                            content.style.animation = 'slideInModal 0.3s cubic-bezier(0.2, 0.9, 0.4, 1.1)';
                        }
                    });
                    document.body.style.overflow = 'hidden';
                    // Ensure a payment method is always selected when modal opens
                    setTimeout(selectFirstPaymentMethod, 50);
                }
            }
            
            function closeCheckoutModal() {
                const modal = document.getElementById('checkoutModal');
                if (modal) {
                    modal.style.display = 'none';
                    document.body.style.overflow = 'auto';
                }
            }
            
            function openMealModal(menuId, name, price, description, imagePath) {
                document.getElementById('<%= hdnSelectedMenuID.ClientID %>').value = menuId;
                document.getElementById('<%= hdnSelectedMenuName.ClientID %>').value = name;
                document.getElementById('<%= hdnSelectedMenuPrice.ClientID %>').value = price;
                document.getElementById('<%= hdnSelectedQuantity.ClientID %>').value = '1';
                document.getElementById('<%= hdnSelectedSpecialRequest.ClientID %>').value = '';
                document.getElementById('<%= hdnSelectedExtras.ClientID %>').value = '';

                const title = document.getElementById('mealModalTitle');
                if (title) title.innerHTML = '<i class="fas fa-utensils"></i> ' + name;

                const body = document.getElementById('mealModalBody');
                if (body) {
                    let imgHtml = '';
                    if (imagePath && imagePath !== '') {
                        imgHtml = '<img src="' + imagePath + '" alt="' + name + '" class="meal-featured-img" onerror="this.style.display=\'none\'" />';
                    }

                    body.innerHTML = imgHtml +
                        '<div class="meal-details">' +
                            '<div class="meal-item-header">' +
                                '<div class="meal-item-name">' + name + '</div>' +
                                '<div class="meal-item-price">₱' + parseFloat(price).toFixed(2) + '</div>' +
                            '</div>' +
                            '<p style="color: var(--text-muted); font-size: 0.9rem; margin-bottom: 15px;">' + description + '</p>' +
                            '<div class="meal-extra-options">' +
                                '<div class="meal-extra-option"><input type="checkbox" class="meal-extra" id="ex1" data-price="15" /><label for="ex1">Extra Rice <small style="color:var(--text-muted)">(+₱15)</small></label></div>' +
                                '<div class="meal-extra-option"><input type="checkbox" class="meal-extra" id="ex2" data-price="10" /><label for="ex2">Add Egg <small style="color:var(--text-muted)">(+₱10)</small></label></div>' +
                                '<div class="meal-extra-option"><input type="checkbox" class="meal-extra" id="ex3" data-price="5" /><label for="ex3">Extra Spicy <small style="color:var(--text-muted)">(+₱5)</small></label></div>' +
                                '<div class="meal-extra-option"><input type="checkbox" class="meal-extra" id="ex4" data-price="10" /><label for="ex4">Extra Sauce <small style="color:var(--text-muted)">(+₱10)</small></label></div>' +
                            '</div>' +
                            '<div class="meal-additional-request">' +
                                '<h4><i class="fas fa-pen"></i> Special Request</h4>' +
                                '<textarea class="additional-request-textarea" id="mealSpecialRequest" rows="2" placeholder="e.g. less sugar, extra spicy..."></textarea>' +
                            '</div>' +
                        '</div>';

                    body.querySelectorAll('.meal-extra').forEach(cb => {
                        cb.addEventListener('change', function() {
                            const selected = [];
                            body.querySelectorAll('.meal-extra:checked').forEach(c => {
                                selected.push(c.nextElementSibling.firstChild.textContent.trim());
                            });
                            document.getElementById('<%= hdnSelectedExtras.ClientID %>').value = selected.join(',');
                            updateModalTotal();
                        });
                    });

                    const srInput = document.getElementById('mealSpecialRequest');
                    if (srInput) {
                        srInput.addEventListener('input', function() {
                            document.getElementById('<%= hdnSelectedSpecialRequest.ClientID %>').value = this.value;
                        });
                    }
                }

                const qtyInput = document.getElementById('modalQuantity');
                if (qtyInput) qtyInput.value = 1;
                updateModalTotal();

                const modal = document.getElementById('mealDetailModal');
                if (modal) {
                    modal.style.display = 'block';
                    document.body.style.overflow = 'hidden';
                }
            }

            function closeMealModal() {
                const modal = document.getElementById('mealDetailModal');
                if (modal) {
                    modal.style.display = 'none';
                    document.body.style.overflow = 'auto';
                }
            }
            
            function updateModalTotal() {
                const priceField = document.getElementById('<%= hdnSelectedMenuPrice.ClientID %>');
                const basePrice = priceField ? (parseFloat(priceField.value) || 0) : 0;
                const qty = parseInt(document.getElementById('modalQuantity').value) || 1;
                let extras = 0;
                document.querySelectorAll('.meal-extra:checked').forEach(cb => {
                    extras += parseFloat(cb.getAttribute('data-price'));
                });
                const total = (basePrice + extras) * qty;
                document.getElementById('<%= hdnSelectedQuantity.ClientID %>').value = qty;
                const btn = document.querySelector('.btn-add-to-cart-meal');
                if (btn) {
                    btn.innerHTML = '<i class="fas fa-cart-plus"></i> ₱' + total.toFixed(2);
                }
            }
            
            function changeModalQuantity(delta) {
                const input = document.getElementById('modalQuantity');
                let val = parseInt(input.value) || 1;
                val += delta;
                if (val < 1) val = 1;
                if (val > 10) val = 10;
                input.value = val;
                updateModalTotal();
            }
            
            const modalMinusBtn = document.getElementById('modalMinusBtn');
            const modalPlusBtn = document.getElementById('modalPlusBtn');
            if (modalMinusBtn) modalMinusBtn.addEventListener('click', () => changeModalQuantity(-1));
            if (modalPlusBtn) modalPlusBtn.addEventListener('click', () => changeModalQuantity(1));
            
            const modalQuantityInput = document.getElementById('modalQuantity');
            if (modalQuantityInput) {
                modalQuantityInput.addEventListener('change', function() {
                    let val = parseInt(this.value);
                    if (isNaN(val) || val < 1) val = 1;
                    if (val > 10) val = 10;
                    this.value = val;
                    updateModalTotal();
                });
            }
            
            function scrollToSection(sectionId) {
                const section = document.getElementById(sectionId);
                if (section) {
                    window.scrollTo({
                        top: section.offsetTop - 80,
                        behavior: 'smooth'
                    });
                    document.querySelectorAll('.nav-link').forEach(nav => nav.classList.remove('active'));
                    const activeLink = document.querySelector('.nav-link[href="#' + sectionId + '"]');
                    if (activeLink) activeLink.classList.add('active');
                }
            }
            
            function scrollToTop() {
                window.scrollTo({ top: 0, behavior: 'smooth' });
            }
            
            function performSearch() {
                const searchInput = document.getElementById('heroSearchInput');
                const searchTerm = searchInput ? searchInput.value.trim().toLowerCase() : '';

                if (searchTerm === '') {
                    scrollToSection('menu');
                    return;
                }
                
                let found = false;
                const menuContainers = document.querySelectorAll('.menu-container');
                
                menuContainers.forEach(container => {
                    const nameElem = container.querySelector('.category-label');
                    const descElem = container.querySelector('.meal-description-short');
                    const name = nameElem ? nameElem.innerText.toLowerCase() : '';
                    const desc = descElem ? descElem.innerText.toLowerCase() : '';
                    
                    if (name.includes(searchTerm) || desc.includes(searchTerm)) {
                        found = true;
                        container.classList.add('search-highlight');
                        setTimeout(() => container.classList.remove('search-highlight'), 2000);
                    }
                });
                
                scrollToSection('menu');
                
                if (!found) {
                    showNotification('No items found matching "' + searchTerm + '"', true);
                } else {
                    showNotification('Found items matching "' + searchTerm + '"', false);
                }
            }
            
            var launchConfetti = function() {};

            function showOrderConfirmedAnimation(ticketNumber, total, paymentMethod) {
                launchConfetti();

                const overlay = document.createElement('div');
                overlay.style.cssText = 'position:fixed;top:0;left:0;width:100%;height:100%;background:rgba(0,0,0,0.78);z-index:99999;display:flex;align-items:center;justify-content:center;';

                overlay.innerHTML =
                    '<div style="background:white;border-radius:24px;padding:40px 35px;max-width:440px;width:90%;text-align:center;box-shadow:0 25px 70px rgba(0,0,0,0.5);border:3px solid #FFD700;position:relative;">' +
                    '<button onclick="this.closest(\'[style*=fixed]\').remove();" ' +
                    'style="position:absolute;top:12px;right:14px;background:none;border:none;font-size:1.5rem;color:#aaa;cursor:pointer;line-height:1;transition:color 0.2s;" ' +
                    'onmouseover="this.style.color=\'#7D0A22\'" onmouseout="this.style.color=\'#aaa\'">' +
                    '&times;' +
                    '</button>' +
                    '<div style="position:relative;width:90px;height:90px;margin:0 auto 22px;">' +
                    '<div style="width:90px;height:90px;background:linear-gradient(135deg,#28a745,#20c997);border-radius:50%;display:flex;align-items:center;justify-content:center;box-shadow:0 8px 30px rgba(40,167,69,0.4);">' +
                    '<i class="fas fa-check" style="color:white;font-size:2.5rem;"></i>' +
                    '</div>' +
                    '<div style="position:absolute;top:-5px;right:-5px;width:28px;height:28px;background:#FFD700;border-radius:50%;display:flex;align-items:center;justify-content:center;font-size:0.9rem;">🎉</div>' +
                    '</div>' +
                    '<h2 style="color:#7D0A22;font-size:1.8rem;font-weight:800;margin-bottom:6px;">Order Confirmed!</h2>' +
                    '<p style="color:#6D6D6D;font-size:0.95rem;margin-bottom:22px;">Your delicious meal is now being prepared 🍳</p>' +
                    '<div style="background:#fdfaf5;border-radius:14px;padding:16px 20px;margin-bottom:18px;border:2px solid #FFD700;text-align:left;">' +
                    '<div style="display:flex;align-items:center;gap:8px;margin-bottom:12px;padding-bottom:10px;border-bottom:1px dashed #ddd;">' +
                    '<i class="fas fa-receipt" style="color:#7D0A22;"></i>' +
                    '<span style="font-weight:800;color:#7D0A22;font-size:0.95rem;">Order Summary</span>' +
                    '</div>' +
                    '<div style="display:flex;justify-content:space-between;margin-bottom:8px;">' +
                    '<span style="color:#6D6D6D;font-size:0.85rem;"><i class="fas fa-hashtag" style="width:14px;"></i> Ticket</span>' +
                    '<span style="color:#7D0A22;font-weight:700;font-size:0.85rem;">' + ticketNumber + '</span>' +
                    '</div>' +
                    '<div style="display:flex;justify-content:space-between;margin-bottom:8px;">' +
                    '<span style="color:#6D6D6D;font-size:0.85rem;"><i class="fas fa-peso-sign" style="width:14px;"></i> Total</span>' +
                    '<span style="color:#7D0A22;font-weight:700;font-size:0.85rem;">₱' + total + '</span>' +
                    '</div>' +
                    '<div style="display:flex;justify-content:space-between;">' +
                    '<span style="color:#6D6D6D;font-size:0.85rem;"><i class="fas fa-credit-card" style="width:14px;"></i> Payment</span>' +
                    '<span style="color:#7D0A22;font-weight:700;font-size:0.85rem;">' + paymentMethod + '</span>' +
                    '</div>' +
                    '</div>' +
                    '<div style="display:flex;align-items:center;gap:10px;background:linear-gradient(135deg,#e8f8ef,#d4f1e3);border-radius:12px;padding:13px 15px;margin-bottom:22px;border:1px solid #b2dfca;">' +
                    '<div style="width:12px;height:12px;background:#28a745;border-radius:50%;animation:badgePulse 1s infinite;flex-shrink:0;"></div>' +
                    '<span style="color:#155724;font-size:0.85rem;font-weight:600;">Your order is now in the kitchen! 🍽️</span>' +
                    '</div>' +
                    '<div style="display:flex;align-items:center;justify-content:center;gap:8px;margin-bottom:22px;color:#6D6D6D;font-size:0.82rem;">' +
                    '<i class="fas fa-clock" style="color:#FFD700;"></i>' +
                    '<span>Estimated delivery: <strong style="color:#7D0A22;">30–45 minutes</strong></span>' +
                    '</div>' +
                    '<div style="display:flex;gap:10px;">' +
                    '<button onclick="this.closest(\'[style*=fixed]\').remove(); if(typeof openProfileModal === \'function\') openProfileModal(\'orders\');" ' +
                    'style="flex:1;background:#f8f9fa;color:#7D0A22;border:2px solid var(--accent-yellow);padding:12px;border-radius:50px;font-weight:700;font-size:0.9rem;cursor:pointer;transition:all 0.3s;" ' +
                    'onmouseover="this.style.background=\'#FFD700\'" onmouseout="this.style.background=\'#f8f9fa\'">' +
                    '<i class="fas fa-clipboard-list"></i> My Orders' +
                    '</button>' +
                    '<button onclick="this.closest(\'[style*=fixed]\').remove();" ' +
                    'style="flex:1;background:linear-gradient(135deg,#7D0A22,#5a0819);color:white;border:none;padding:12px;border-radius:50px;font-weight:700;font-size:0.9rem;cursor:pointer;transition:all 0.3s;" ' +
                    'onmouseover="this.style.opacity=\'0.9\'" onmouseout="this.style.opacity=\'1\'">' +
                    '<i class="fas fa-utensils"></i> Order More' +
                    '</button>' +
                    '</div>' +
                    '</div>';

                document.body.appendChild(overlay);
                overlay.addEventListener('click', function (e) {
                    if (e.target === overlay) overlay.remove();
                });
            }
           

            const profileDropdown = document.getElementById('profileDropdown');
            const profileDropdownOverlay = document.getElementById('profileDropdownOverlay');
            const profileIcon = document.getElementById('profileIcon');

            function openProfileDropdown() {
                if (profileDropdown) profileDropdown.classList.add('open');
                if (profileDropdownOverlay) {
                    profileDropdownOverlay.style.display = 'block';
                    requestAnimationFrame(() => profileDropdownOverlay.classList.add('open'));
                }
            }

            function closeProfileDropdown() {
                if (profileDropdown) profileDropdown.classList.remove('open');
                if (profileDropdownOverlay) {
                    profileDropdownOverlay.classList.remove('open');
                    setTimeout(() => { profileDropdownOverlay.style.display = 'none'; }, 250);
                }
            }
            
            if (profileIcon) {
                profileIcon.addEventListener('click', function(e) {
                    e.preventDefault();
                    e.stopPropagation();
                    if (profileDropdown && profileDropdown.classList.contains('open')) {
                        closeProfileDropdown();
                    } else {
                        openProfileDropdown();
                    }
                });
            }

            if (profileDropdownOverlay) {
                profileDropdownOverlay.addEventListener('click', closeProfileDropdown);
            }

            document.addEventListener('click', function(e) {
                if (profileDropdown && profileIcon &&
                    !profileDropdown.contains(e.target) &&
                    !profileIcon.contains(e.target)) {
                    closeProfileDropdown();
                }
            });
            
            const dropdownMyProfile = document.getElementById('dropdownMyProfileLink');
            const dropdownSecurity = document.getElementById('dropdownSecurityLink');
            const dropdownOrders = document.getElementById('dropdownOrdersLink');
            
            if (dropdownMyProfile) {
                dropdownMyProfile.addEventListener('click', (e) => {
                    e.preventDefault();
                    closeProfileDropdown();
                    openProfileModal('personal');
                });
            }
            
            if (dropdownSecurity) {
                dropdownSecurity.addEventListener('click', (e) => {
                    e.preventDefault();
                    closeProfileDropdown();
                    openProfileModal('security');
                });
            }
            
            if (dropdownOrders) {
                dropdownOrders.addEventListener('click', (e) => {
                    e.preventDefault();
                    closeProfileDropdown();
                    openProfileModal('orders');
                });
            }
            
            const closeModalBtn = document.getElementById('closeModalBtn');
            if (closeModalBtn) closeModalBtn.addEventListener('click', closeProfileModal);
            
            window.addEventListener('click', function(e) {
                const profileModal = document.getElementById('profileModal');
                if (e.target === profileModal) closeProfileModal();
            });
            
            const cartIcon = document.getElementById('cartIcon');
            if (cartIcon) {
                cartIcon.addEventListener('click', (e) => {
                    e.preventDefault();
                    openCartModal();
                });
            }
            
            const cartCloseBtn = document.getElementById('cartCloseBtn');
            if (cartCloseBtn) cartCloseBtn.addEventListener('click', closeCartModal);
            
            const cartOverlay = document.getElementById('cartOverlay');
            if (cartOverlay) cartOverlay.addEventListener('click', closeCartModal);
            
            const checkoutCloseBtn = document.getElementById('checkoutCloseBtn');
            const checkoutOverlay = document.getElementById('checkoutOverlay');
            const cancelCheckoutBtn = document.getElementById('cancelCheckoutBtn');
            
            if (checkoutCloseBtn) checkoutCloseBtn.addEventListener('click', closeCheckoutModal);
            if (checkoutOverlay) checkoutOverlay.addEventListener('click', closeCheckoutModal);
            if (cancelCheckoutBtn) cancelCheckoutBtn.addEventListener('click', closeCheckoutModal);
            
            const newAddrCheckbox = document.getElementById('<%= useNewAddressCheckbox.ClientID %>');
            if (newAddrCheckbox) {
                newAddrCheckbox.addEventListener('change', function() {
                    const newForm = document.getElementById('newAddressForm');
                    const defaultAddressDiv = document.querySelector('#existingAddressesContainer .address-option');
                    if (this.checked) {
                        newForm.style.display = 'block';
                        if (defaultAddressDiv) defaultAddressDiv.style.opacity = '0.5';
                    } else {
                        newForm.style.display = 'none';
                        if (defaultAddressDiv) defaultAddressDiv.style.opacity = '1';
                    }
                });
            }
            
            const paymentRadios = document.querySelectorAll('input[name="paymentMethod"]');
            paymentRadios.forEach(radio => {
                radio.addEventListener('change', function() {
                    const infoDiv = document.getElementById('paymentInfo');
                    const msgSpan = document.getElementById('paymentInfoMessage');
                    if (!infoDiv || !msgSpan) return;
                    const val = this.value.toUpperCase();
                    if (val === 'GCASH' || val === 'MAYA' || val === 'PAYMAYA') {
                        msgSpan.textContent = 'Please scan the QR code or send payment to the account details shown. Include your order ticket number as reference.';
                        infoDiv.style.display = 'block';
                    } else if (val === 'BANK TRANSFER' || val === 'BANK') {
                        msgSpan.textContent = 'Please transfer the exact amount to the account provided and keep your transaction reference number.';
                        infoDiv.style.display = 'block';
                    } else {
                        infoDiv.style.display = 'none';
                    }
                });
            });
            // Auto-select first enabled payment method on load and every time checkout opens
            function selectFirstPaymentMethod() {
                const alreadyChecked = document.querySelector('input[name="paymentMethod"]:checked');
                if (!alreadyChecked) {
                    const firstEnabled = document.querySelector('input[name="paymentMethod"]:not([disabled])');
                    if (firstEnabled) firstEnabled.checked = true;
                }
            }
            setTimeout(selectFirstPaymentMethod, 200);
            
            const mealCloseBtn = document.getElementById('mealCloseBtn');
            const closeMealModalBtn = document.getElementById('closeMealModalBtn');
            const mealOverlay = document.getElementById('mealOverlay');
            
            if (mealCloseBtn) mealCloseBtn.addEventListener('click', closeMealModal);
            if (closeMealModalBtn) closeMealModalBtn.addEventListener('click', closeMealModal);
            if (mealOverlay) mealOverlay.addEventListener('click', closeMealModal);
            
            const checkoutBtn = document.getElementById('<%= btnCheckout.ClientID %>');
            if (checkoutBtn) {
                checkoutBtn.onclick = function(e) {
                    e.preventDefault();
                    openCheckoutModal();
                    return false;
                };
            }

            function savePageState(modalName) {
                sessionStorage.setItem('scrollPos', window.scrollY);
                if (modalName !== undefined) sessionStorage.setItem('openModal', modalName);
            }

            document.querySelectorAll('.add-to-cart-btn-text').forEach(btn => {
                btn.addEventListener('click', function() { savePageState('cart'); });
            });

            const addFromModalBtn = document.getElementById('<%= btnAddToCartFromModal.ClientID %>');
            if (addFromModalBtn) {
                addFromModalBtn.addEventListener('click', function() { savePageState('cart'); });
            }

            const saveProfileBtn = document.getElementById('<%= btnSaveProfile.ClientID %>');
            if (saveProfileBtn) {
                saveProfileBtn.addEventListener('click', function() { savePageState('profile_personal'); });
            }

            const changePwBtn = document.getElementById('<%= btnChangePassword.ClientID %>');
            if (changePwBtn) {
                changePwBtn.addEventListener('click', function() { savePageState('profile_security'); });
            }

            const confirmOrderBtn = document.getElementById('<%= btnConfirmOrder.ClientID %>');
            if (confirmOrderBtn) {
                confirmOrderBtn.addEventListener('click', function() { savePageState('confirm_order'); });
            }

            const clearCartBtn = document.getElementById('<%= btnClearCart.ClientID %>');
            if (clearCartBtn) {
                clearCartBtn.addEventListener('click', function() { savePageState(''); });
            }

            document.querySelectorAll('.btn-cancel, .btn-reorder, .btn-received').forEach(btn => {
                btn.addEventListener('click', function() { savePageState('orders'); });
            });

            (function restorePageState() {
                const pos = sessionStorage.getItem('scrollPos');
                const modal = sessionStorage.getItem('openModal');
                if (pos !== null) {
                    window.scrollTo(0, parseInt(pos));
                    sessionStorage.removeItem('scrollPos');
                }
                if (modal) {
                    sessionStorage.removeItem('openModal');
                    if (modal === 'cart') openCartModal();
                    else if (modal === 'profile_personal') openProfileModal('personal');
                    else if (modal === 'profile_security') openProfileModal('security');
                    else if (modal === 'orders') { openProfileModal('orders'); }
                    else if (modal === 'checkout') openCheckoutModal();
                }
            })();

            // Prevent double-click postback on server buttons
            (function preventDoubleSubmit() {
                document.querySelectorAll('input[type=submit], asp\\:Button').forEach(function(btn) {
                    btn.addEventListener('click', function() {
                        if (this.dataset.submitting) return false;
                        this.dataset.submitting = '1';
                        setTimeout(() => { delete this.dataset.submitting; }, 3000);
                    });
                });
            })();

            const searchBtn = document.getElementById('heroSearchBtn');
            const searchInputField = document.getElementById('heroSearchInput');

            if (searchBtn) searchBtn.addEventListener('click', performSearch);
            if (searchInputField) {
                searchInputField.addEventListener('keypress', function(e) {
                    if (e.key === 'Enter') performSearch();
                });
            }

            document.querySelectorAll('.nav-link, .logo-container, .btn-order, .btn-cta-large, .footer-link[href^="#"]').forEach(link => {
                link.addEventListener('click', function(e) {
                    const href = this.getAttribute('href');
                    if (href && href.startsWith('#')) {
                        e.preventDefault();
                        const sectionId = href.substring(1);
                        if (sectionId) scrollToSection(sectionId);
                    }
                });
            });

            const backToTopBtn = document.getElementById('backToTopBtn');
            window.addEventListener('scroll', function() {
                if (backToTopBtn) {
                    if (window.scrollY > 300) {
                        backToTopBtn.classList.add('visible');
                    } else {
                        backToTopBtn.classList.remove('visible');
                    }
                }
            });

            if (backToTopBtn) backToTopBtn.addEventListener('click', scrollToTop);

            window.addEventListener('scroll', function() {
                const sections = ['home', 'about', 'menu', 'contact'];
                let current = '';

                sections.forEach(sectionId => {
                    const section = document.getElementById(sectionId);
                    if (section) {
                        const sectionTop = section.offsetTop;
                        if (window.scrollY >= sectionTop - 100) {
                            current = sectionId;
                        }
                    }
                });

                document.querySelectorAll('.nav-link').forEach(link => {
                    link.classList.remove('active');
                    if (link.getAttribute('href') === '#' + current) {
                        link.classList.add('active');
                    }
                });
            });

            (function initCartBadge() {
                const badge = document.getElementById('cartBadge');
                if (badge) {
                    const count = parseInt(badge.textContent) || 0;
                    if (count === 0) {
                        badge.style.display = 'none';
                    } else {
                        badge.style.display = 'flex';
                    }
                }
            })();

            // Re-sync badge after any ASP.NET UpdatePanel partial postback
            if (typeof Sys !== 'undefined' && Sys.WebForms && Sys.WebForms.PageRequestManager) {
                Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function() {
                    const badge = document.getElementById('cartBadge');
                    if (badge) {
                        const count = parseInt(badge.textContent) || 0;
                        badge.style.display = count > 0 ? 'flex' : 'none';
                    }
                    // Re-run page state restore after postback
                    (function() {
                        const modal = sessionStorage.getItem('openModal');
                        if (modal) {
                            sessionStorage.removeItem('openModal');
                            if (modal === 'cart') openCartModal();
                            else if (modal === 'profile_personal') openProfileModal('personal');
                            else if (modal === 'profile_security') openProfileModal('security');
                            else if (modal === 'orders') { openProfileModal('orders'); startOrdersPolling(); }
                            else if (modal === 'checkout') openCheckoutModal();
                        }
                    })();
                });
            }

            // ── Mobile hamburger drawer ──
            const hamburgerBtn = document.getElementById('hamburgerBtn');
            const mobileNavDrawer = document.getElementById('mobileNavDrawer');

            function closeMobileDrawer() {
                if (!hamburgerBtn || !mobileNavDrawer) return;
                hamburgerBtn.classList.remove('open');
                mobileNavDrawer.classList.remove('open');
                hamburgerBtn.setAttribute('aria-expanded', 'false');
            }

            if (hamburgerBtn && mobileNavDrawer) {
                hamburgerBtn.addEventListener('click', function (e) {
                    e.stopPropagation();
                    const isOpen = mobileNavDrawer.classList.contains('open');
                    if (isOpen) {
                        closeMobileDrawer();
                    } else {
                        hamburgerBtn.classList.add('open');
                        mobileNavDrawer.classList.add('open');
                        hamburgerBtn.setAttribute('aria-expanded', 'true');
                    }
                });

                // Close when tapping anywhere outside the navbar
                document.addEventListener('click', function (e) {
                    const navbar = document.getElementById('mainNavbar');
                    if (navbar && !navbar.contains(e.target)) {
                        closeMobileDrawer();
                    }
                });

                // Close drawer when a section link is tapped (smooth scroll)
                document.querySelectorAll('.mobile-drawer-link').forEach(function (link) {
                    link.addEventListener('click', function (e) {
                        const href = this.getAttribute('href');
                        if (href && href.startsWith('#')) {
                            e.preventDefault();
                            closeMobileDrawer();
                            const target = document.getElementById(href.substring(1));
                            if (target) {
                                window.scrollTo({ top: target.offsetTop - 56, behavior: 'smooth' });
                            }
                        }
                    });
                });

                // Highlight active drawer link on scroll
                window.addEventListener('scroll', function () {
                    const sections = ['home', 'about', 'menu', 'contact'];
                    let current = '';
                    sections.forEach(function (id) {
                        const s = document.getElementById(id);
                        if (s && window.scrollY >= s.offsetTop - 80) current = id;
                    });
                    document.querySelectorAll('.mobile-drawer-link').forEach(function (link) {
                        const href = link.getAttribute('href');
                        link.classList.toggle('active', href === '#' + current);
                    });
                });
            }

        </script>

        <asp:HiddenField ID="hdnRatingTicket" runat="server" />
        <asp:HiddenField ID="hdnRatingValue" runat="server" />
        <div id="ratingModal" class="rating-modal">
            <div class="rating-modal-overlay" id="ratingOverlay"></div>
            <div class="rating-modal-content">
                <div class="rating-modal-header">
                    <h3><i class="fas fa-star"></i> Rate Your Meal</h3>
                    <button type="button" class="rating-close-btn" id="ratingCloseBtn">&times;</button>
                </div>
                <div class="rating-modal-body">
                    <div class="rating-order-info" id="ratingOrderInfo">
                        <i class="fas fa-receipt" style="font-size:2.5rem;color:var(--accent-yellow);margin-bottom:10px;"></i>
                        <p id="ratingTicketDisplay" style="font-weight:700;color:var(--primary-maroon);font-size:1.1rem;"></p>
                    </div>
                    <p class="rating-question">How was your order?</p>
                    <div class="star-rating-container" id="starRatingContainer">
                        <span class="star" data-value="1"><i class="fas fa-star"></i></span>
                        <span class="star" data-value="2"><i class="fas fa-star"></i></span>
                        <span class="star" data-value="3"><i class="fas fa-star"></i></span>
                        <span class="star" data-value="4"><i class="fas fa-star"></i></span>
                        <span class="star" data-value="5"><i class="fas fa-star"></i></span>
                    </div>
                    <div class="rating-label-text" id="ratingLabelText">Tap a star to rate</div>
                    <div class="rating-emoji" id="ratingEmoji"></div>
                </div>
                <div class="rating-modal-footer">
                    <button type="button" class="btn-secondary" id="skipRatingBtn">Skip</button>
                    <asp:Button ID="btnSubmitRating" runat="server" Text="Submit Rating" CssClass="btn-primary btn-submit-rating" OnClick="btnSubmitRating_Click" />
                </div>
            </div>
        </div>

        <div id="privacyModal" class="policy-modal">
            <div class="policy-modal-overlay" id="privacyOverlay"></div>
            <div class="policy-modal-content">
                <div class="policy-modal-header">
                    <h3><i class="fas fa-shield-alt"></i> Privacy Policy</h3>
                    <button type="button" class="policy-close-btn" id="privacyCloseBtn">&times;</button>
                </div>
                <div class="policy-modal-body">
                    <p class="policy-effective">Effective Date: January 1, 2025</p>
                    <div class="policy-section">
                        <h4><i class="fas fa-user-lock"></i> 1. Information We Collect</h4>
                        <p>When you register and use TasteNet (Caballeros), we collect the following personal information:</p>
                        <ul>
                            <li><strong>Account Information:</strong> Full name, email address, phone number, and gender.</li>
                            <li><strong>Delivery Information:</strong> Your delivery address within Dasmariñas City, Cavite.</li>
                            <li><strong>Order Information:</strong> Items ordered, special instructions, payment method, and order history.</li>
                        </ul>
                    </div>
                    <div class="policy-section">
                        <h4><i class="fas fa-cogs"></i> 2. How We Use Your Information</h4>
                        <p>We use your information solely to:</p>
                        <ul>
                            <li>Process and fulfill your food orders.</li>
                            <li>Send order status updates and confirmations.</li>
                            <li>Improve our menu and service quality.</li>
                            <li>Contact you regarding your account or orders.</li>
                        </ul>
                    </div>
                    <div class="policy-section">
                        <h4><i class="fas fa-lock"></i> 3. Data Security</h4>
                        <p>We are committed to protecting your personal information. Your data is stored securely and is never sold or shared with third parties for marketing purposes. Only authorized staff involved in order fulfillment can access customer information.</p>
                    </div>
                    <div class="policy-section">
                        <h4><i class="fas fa-cookie-bite"></i> 4. Cookies &amp; Sessions</h4>
                        <p>TasteNet uses session cookies to maintain your login state and shopping cart during your visit. These are temporary and removed when you close your browser or log out.</p>
                    </div>
                    <div class="policy-section">
                        <h4><i class="fas fa-user-edit"></i> 5. Your Rights</h4>
                        <p>You have the right to:</p>
                        <ul>
                            <li>Update or correct your personal information via your profile settings.</li>
                            <li>Request deletion of your account by contacting us.</li>
                            <li>Access the personal data we hold about you.</li>
                        </ul>
                    </div>
                    <div class="policy-section">
                        <h4><i class="fas fa-phone"></i> 6. Contact Us</h4>
                        <p>For any privacy concerns or questions, please contact us:</p>
                        <p><strong>Phone:</strong> 046-473-9753 / 0912-368-7369</p>
                        <p><strong>Address:</strong> Blk 84, Lot 10 Bautista St, Zone 9, Dasmariñas, 4114 Cavite</p>
                    </div>
                </div>
                <div class="policy-modal-footer">
                    <button type="button" class="btn-primary" id="privacyAcceptBtn">I Understand</button>
                </div>
            </div>
        </div>

        <div id="termsModal" class="policy-modal">
            <div class="policy-modal-overlay" id="termsOverlay"></div>
            <div class="policy-modal-content">
                <div class="policy-modal-header">
                    <h3><i class="fas fa-file-contract"></i> Terms &amp; Conditions</h3>
                    <button type="button" class="policy-close-btn" id="termsCloseBtn">&times;</button>
                </div>
                <div class="policy-modal-body">
                    <p class="policy-effective">Last Updated: January 1, 2025</p>
                    <div class="policy-section">
                        <h4><i class="fas fa-info-circle"></i> 1. Acceptance of Terms</h4>
                        <p>By using TasteNet (Caballeros online ordering system), you agree to be bound by these Terms and Conditions. If you do not agree with any part of these terms, please do not use our service.</p>
                    </div>
                    <div class="policy-section">
                        <h4><i class="fas fa-map-marker-alt"></i> 2. Service Area</h4>
                        <p>Our delivery service is exclusively available within <strong>Dasmariñas City, Cavite</strong>. Orders placed outside this area cannot be accommodated. The delivery address must be accurate and reachable.</p>
                    </div>
                    <div class="policy-section">
                        <h4><i class="fas fa-shopping-cart"></i> 3. Orders &amp; Payment</h4>
                        <ul>
                            <li>All orders are subject to availability and confirmation.</li>
                            <li>We accept <strong>Cash on Delivery (COD)</strong> and <strong>GCash</strong> payments.</li>
                            <li>Orders may only be cancelled while in "Open" or "Cooking" status.</li>
                            <li>A delivery fee based on your barangay applies to orders below ₱500. Orders of ₱500 and above qualify for free delivery.</li>
                        </ul>
                    </div>
                    <div class="policy-section">
                        <h4><i class="fas fa-clock"></i> 4. Delivery Times</h4>
                        <p>Delivery times are estimated and may vary depending on order volume, weather conditions, and distance within Dasmariñas City. We are not liable for delays caused by factors beyond our control.</p>
                    </div>
                    <div class="policy-section">
                        <h4><i class="fas fa-utensils"></i> 5. Food Quality &amp; Freshness</h4>
                        <p>All meals are freshly prepared upon order. If you have concerns about food quality upon receipt, please contact us immediately. We reserve the right to assess each concern on a case-by-case basis.</p>
                    </div>
                    <div class="policy-section">
                        <h4><i class="fas fa-star"></i> 6. Ratings &amp; Feedback</h4>
                        <p>After marking your order as received, you may rate your meal. Ratings are used solely to improve our menu quality and service. We appreciate honest and constructive feedback.</p>
                    </div>
                    <div class="policy-section">
                        <h4><i class="fas fa-ban"></i> 7. Prohibited Use</h4>
                        <p>You agree not to misuse the platform by placing fraudulent orders, providing false delivery information, or engaging in any activity that disrupts our service or harms other users.</p>
                    </div>
                    <div class="policy-section">
                        <h4><i class="fas fa-sync-alt"></i> 8. Changes to Terms</h4>
                        <p>Caballeros reserves the right to update these Terms and Conditions at any time. Continued use of the platform after changes constitutes acceptance of the revised terms.</p>
                    </div>
                </div>
                <div class="policy-modal-footer">
                    <button type="button" class="btn-primary" id="termsAcceptBtn">I Agree</button>
                </div>
            </div>
        </div>

        <script>
            function appendInstruction(text) {
                const ta = document.getElementById('<%= txtCheckoutInstructions.ClientID %>');
                if (!ta) return;
                const current = ta.value.trim();
                ta.value = current ? current + ', ' + text : text;
                ta.focus();
            }

            const ratingLabels = ['', 'Poor 😞', 'Fair 😐', 'Good 🙂', 'Great 😄', 'Excellent! 🤩'];
            const ratingEmojis = ['', '😞', '😐', '🙂', '😄', '🤩'];
            let selectedRating = 0;

            function openRatingModal(ticketNumber) {
                selectedRating = 0;
                document.getElementById('<%= hdnRatingTicket.ClientID %>').value = ticketNumber;
                document.getElementById('<%= hdnRatingValue.ClientID %>').value = '';
                document.getElementById('ratingTicketDisplay').textContent = 'Order #' + ticketNumber;
                document.getElementById('ratingLabelText').textContent = 'Tap a star to rate';
                document.getElementById('ratingEmoji').textContent = '';
                document.querySelectorAll('.star').forEach(s => s.classList.remove('active', 'hovered'));
                const modal = document.getElementById('ratingModal');
                if (modal) { modal.style.display = 'block'; document.body.style.overflow = 'hidden'; }
            }

            function closeRatingModal() {
                const modal = document.getElementById('ratingModal');
                if (modal) { modal.style.display = 'none'; document.body.style.overflow = 'auto'; }
            }

            const stars = document.querySelectorAll('.star');
            stars.forEach(star => {
                star.addEventListener('mouseenter', function() {
                    const val = parseInt(this.dataset.value);
                    stars.forEach(s => {
                        s.classList.remove('active', 'hovered');
                        if (parseInt(s.dataset.value) <= val) s.classList.add('hovered');
                    });
                    document.getElementById('ratingLabelText').textContent = ratingLabels[val];
                    document.getElementById('ratingEmoji').textContent = '';
                });
                star.addEventListener('mouseleave', function() {
                    stars.forEach(s => {
                        s.classList.remove('hovered');
                        if (parseInt(s.dataset.value) <= selectedRating) s.classList.add('active');
                    });
                    document.getElementById('ratingLabelText').textContent = selectedRating ? ratingLabels[selectedRating] : 'Tap a star to rate';
                    document.getElementById('ratingEmoji').textContent = selectedRating ? ratingEmojis[selectedRating] : '';
                });
                star.addEventListener('click', function() {
                    selectedRating = parseInt(this.dataset.value);
                    document.getElementById('<%= hdnRatingValue.ClientID %>').value = selectedRating;
                    stars.forEach(s => {
                        s.classList.remove('active', 'hovered');
                        if (parseInt(s.dataset.value) <= selectedRating) s.classList.add('active');
                    });
                    document.getElementById('ratingLabelText').textContent = ratingLabels[selectedRating];
                    document.getElementById('ratingEmoji').textContent = ratingEmojis[selectedRating];
                });
            });

            const ratingCloseBtn = document.getElementById('ratingCloseBtn');
            const skipRatingBtn = document.getElementById('skipRatingBtn');
            const ratingOverlay = document.getElementById('ratingOverlay');
            if (ratingCloseBtn) ratingCloseBtn.addEventListener('click', closeRatingModal);
            if (skipRatingBtn) skipRatingBtn.addEventListener('click', closeRatingModal);
            if (ratingOverlay) ratingOverlay.addEventListener('click', closeRatingModal);

            const submitRatingBtn = document.getElementById('<%= btnSubmitRating.ClientID %>');
            if (submitRatingBtn) {
                submitRatingBtn.addEventListener('click', function () {
                    sessionStorage.setItem('scrollPos', window.scrollY);
                    sessionStorage.setItem('openModal', 'orders');
                });
            }

            function openPrivacyModal() {
                document.getElementById('privacyModal').style.display = 'block';
                document.body.style.overflow = 'hidden';
            }
            function closePrivacyModal() {
                document.getElementById('privacyModal').style.display = 'none';
                document.body.style.overflow = 'auto';
            }
            function openTermsModal() {
                document.getElementById('termsModal').style.display = 'block';
                document.body.style.overflow = 'hidden';
            }
            function closeTermsModal() {
                document.getElementById('termsModal').style.display = 'none';
                document.body.style.overflow = 'auto';
            }

            document.getElementById('privacyCloseBtn').addEventListener('click', closePrivacyModal);
            document.getElementById('privacyAcceptBtn').addEventListener('click', closePrivacyModal);
            document.getElementById('privacyOverlay').addEventListener('click', closePrivacyModal);
            document.getElementById('termsCloseBtn').addEventListener('click', closeTermsModal);
            document.getElementById('termsAcceptBtn').addEventListener('click', closeTermsModal);
            document.getElementById('termsOverlay').addEventListener('click', closeTermsModal);

            const privacyFooterLink = document.getElementById('privacyFooterLink');
            const termsFooterLink = document.getElementById('termsFooterLink');
            if (privacyFooterLink) privacyFooterLink.addEventListener('click', function (e) { e.preventDefault(); openPrivacyModal(); });
            if (termsFooterLink) termsFooterLink.addEventListener('click', function (e) { e.preventDefault(); openTermsModal(); });

            // ========== CONFETTI FOR ORDER CONFIRMED ==========
            function launchConfetti() {
                const colors = ['#FFD700', '#7D0A22', '#28a745', '#ffffff', '#ff6b6b', '#ffa500'];
                for (let i = 0; i < 60; i++) {
                    setTimeout(() => {
                        const piece = document.createElement('div');
                        piece.className = 'confetti-piece';
                        piece.style.left = Math.random() * 100 + 'vw';
                        piece.style.background = colors[Math.floor(Math.random() * colors.length)];
                        piece.style.width = (Math.random() * 8 + 6) + 'px';
                        piece.style.height = (Math.random() * 8 + 6) + 'px';
                        piece.style.animationDuration = (Math.random() * 2.5 + 1.5) + 's';
                        piece.style.borderRadius = Math.random() > 0.5 ? '50%' : '2px';
                        document.body.appendChild(piece);
                        setTimeout(() => piece.remove(), 4000);
                    }, i * 40);
                }
            }

            // ========== CUSTOM CONFIRM MODAL ENGINE ==========
            let _pendingTriggerElement = null;

            function showCustomConfirm(event, modalId) {
                event.preventDefault();
                _pendingTriggerElement = event.currentTarget || event.target;
                const modal = document.getElementById(modalId);
                if (!modal) return false;
                modal.style.display = 'flex';
                requestAnimationFrame(() => modal.classList.add('show'));
                document.body.style.overflow = 'hidden';
                return false;
            }

            function closeCustomConfirm(modalId, confirmed) {
                const modal = document.getElementById(modalId);
                if (!modal) return;
                modal.classList.remove('show');
                setTimeout(() => { modal.style.display = 'none'; }, 280);
                document.body.style.overflow = '';
                if (confirmed && _pendingTriggerElement) {
                    const el = _pendingTriggerElement;
                    _pendingTriggerElement = null;
                    el.onclick = null;
                    el.click();
                } else {
                    _pendingTriggerElement = null;
                }
            }

            document.querySelectorAll('.custom-confirm-overlay').forEach(function (overlay) {
                overlay.addEventListener('click', function (e) {
                    if (e.target === overlay) closeCustomConfirm(overlay.id, false);
                });
            });

            document.addEventListener('keydown', function (e) {
                if (e.key === 'Escape') {
                    document.querySelectorAll('.custom-confirm-overlay.show').forEach(function (m) {
                        closeCustomConfirm(m.id, false);
                    });
                }
            });

        </script>

        <div id="confirmClearCartModal" class="custom-confirm-overlay" role="dialog" aria-modal="true">
            <div class="custom-confirm-box">
                <div class="custom-confirm-icon icon-warning">
                    <i class="fas fa-trash-alt"></i>
                </div>
                <h3>Clear Your Cart?</h3>
                <p>All items in your cart will be <strong>removed</strong>. This action cannot be undone.</p>
                <div class="custom-confirm-actions">
                    <button class="btn-confirm-cancel" onclick="closeCustomConfirm('confirmClearCartModal', false)">Keep Items</button>
                    <button class="btn-confirm-ok ok-danger" onclick="closeCustomConfirm('confirmClearCartModal', true)"><i class="fas fa-trash-alt"></i> Clear Cart</button>
                </div>
            </div>
        </div>

        <div id="confirmReceivedModal" class="custom-confirm-overlay" role="dialog" aria-modal="true">
            <div class="custom-confirm-box">
                <div class="custom-confirm-icon icon-success">
                    <i class="fas fa-check-circle"></i>
                </div>
                <h3>Order Received?</h3>
                <p>Confirm that you've received your order. You'll be asked to <strong>rate your meal</strong> — your feedback helps us improve!</p>
                <div class="custom-confirm-actions">
                    <button class="btn-confirm-cancel" onclick="closeCustomConfirm('confirmReceivedModal', false)">Not Yet</button>
                    <button class="btn-confirm-ok ok-success" onclick="closeCustomConfirm('confirmReceivedModal', true)"><i class="fas fa-check"></i> Yes, Received!</button>
                </div>
            </div>
        </div>

        <div id="confirmCancelModal" class="custom-confirm-overlay" role="dialog" aria-modal="true">
            <div class="custom-confirm-box">
                <div class="custom-confirm-icon icon-danger">
                    <i class="fas fa-times-circle"></i>
                </div>
                <h3>Cancel This Order?</h3>
                <p>Are you sure you want to <strong>cancel</strong> this order? This cannot be undone once confirmed.</p>
                <div class="custom-confirm-actions">
                    <button class="btn-confirm-cancel" onclick="closeCustomConfirm('confirmCancelModal', false)">Keep Order</button>
                    <button class="btn-confirm-ok ok-danger" onclick="closeCustomConfirm('confirmCancelModal', true)"><i class="fas fa-times"></i> Cancel Order</button>
                </div>
            </div>
        </div>

    </form>
</body>
</html>