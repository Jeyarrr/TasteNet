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
        }

        * {
            cursor: auto !important;
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        .custom-cursor, .cursor-dot {
            display: none;
        }

        body {
            font-family: 'Quicksand', sans-serif;
            overflow-x: hidden;
            height: 100%;
            scroll-behavior: smooth;
        }

        html {
            height: 100%;
            scroll-behavior: smooth;
        }

        a, button, .logo-container, .nav-link, 
        .btn-order, .btn-search, .btn-cta-large, 
        .footer-link, .feature-card, .step-card, 
        .menu-container, .content-box {
            cursor: pointer !important;
        }

        #home {
            scroll-margin-top: 80px;
        }

        #about {
            scroll-margin-top: 80px;
        }

        #menu {
            scroll-margin-top: 80px;
        }

        #contact {
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
            transition: all 0.3s ease;
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
            transition: none;
        }
        
        .brand-name { 
            font-size: 1.8rem; 
            font-weight: 700; 
            color: var(--accent-yellow); 
            text-shadow: 2px 2px 4px rgba(0,0,0,0.5); 
            transition: text-shadow 0.3s ease;
        }
        
        .logo-container:hover .brand-name {
            text-shadow: 0 0 10px rgba(255, 215, 0, 0.7), 2px 2px 4px rgba(0,0,0,0.5);
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
            transition: all 0.3s ease; 
            padding: 6px 3px; 
            border-radius: 5px;
            position: relative;
        }
        
        .nav-links a::after {
            content: '';
            position: absolute;
            width: 0;
            height: 3px;
            bottom: -2px;
            left: 50%;
            background: linear-gradient(90deg, 
                transparent, 
                #ff0000, 
                #ff5555, 
                #ff0000, 
                transparent);
            transition: all 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            transform: translateX(-50%);
            border-radius: 2px;
            box-shadow: 0 0 15px rgba(255, 0, 0, 0.5);
        }

        .nav-links a:hover::after {
            width: 100%;
            animation: redPulse 1.5s infinite alternate;
        }

        @keyframes redPulse {
            0% {
                box-shadow: 0 0 10px rgba(255, 0, 0, 0.5);
                background: linear-gradient(90deg, transparent, #ff0000, #ff5555, #ff0000, transparent);
            }
            100% {
                box-shadow: 0 0 25px rgba(255, 0, 0, 0.8);
                background: linear-gradient(90deg, transparent, #ff5555, #ff8888, #ff5555, transparent);
            }
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
            transition: all 0.3s ease; 
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            position: relative;
        }
        
        .nav-icons a:hover { 
            color: var(--accent-yellow); 
            background: rgba(255, 215, 0, 0.1);
            transform: translateY(-2px) scale(1.1);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }
        
        .nav-icons a:before {
            content: attr(data-tooltip);
            position: absolute;
            bottom: -40px;
            left: 50%;
            transform: translateX(-50%);
            background: rgba(0,0,0,0.8);
            color: white;
            padding: 5px 10px;
            border-radius: 5px;
            font-size: 0.8rem;
            white-space: nowrap;
            opacity: 0;
            visibility: hidden;
            transition: all 0.3s ease;
        }
        
        .nav-icons a:hover:before {
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
            transition: all 0.3s ease;
        }

        .cart-badge {
            position: absolute;
            top: -5px;
            right: -5px;
            background: var(--accent-yellow);
            color: var(--primary-maroon);
            font-size: 0.7rem;
            font-weight: 800;
            width: 20px;
            height: 20px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.3s ease;
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
        }

        .cart-icon-wrapper:hover .cart-badge {
            transform: scale(1.2);
            box-shadow: 0 0 10px rgba(255, 215, 0, 0.7);
        }

        .cart-modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 2000;
            animation: fadeIn 0.3s ease;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        .cart-modal-overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.7);
            backdrop-filter: blur(3px);
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
            animation: slideIn 0.3s ease;
            border: 2px solid var(--accent-yellow);
        }

        @keyframes slideIn {
            from {
                transform: translateY(-20px) translateX(20px);
                opacity: 0;
            }
            to {
                transform: translateY(0) translateX(0);
                opacity: 1;
            }
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

        .cart-empty-state p {
            margin: 10px 0;
            font-size: 1.1rem;
        }

        .cart-empty-subtitle {
            font-size: 0.9rem !important;
            color: var(--text-muted);
            margin-bottom: 25px !important;
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
            box-shadow: 0 5px 15px rgba(125, 10, 34, 0.2);
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
            from {
                opacity: 0;
                transform: translateX(-10px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
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
            font-size: 1rem;
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
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.3s ease;
        }

        .quantity-btn:hover {
            background: var(--primary-maroon);
            color: white;
            transform: scale(1.1);
        }

        .quantity-value {
            font-weight: 700;
            min-width: 30px;
            text-align: center;
            color: var(--primary-maroon);
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
            transition: all 0.3s ease;
            padding: 5px 10px;
            border-radius: 5px;
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

        .cart-summary-row:last-child {
            border-bottom: none;
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
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
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
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .btn-checkout:disabled {
            opacity: 0.5;
            cursor: not-allowed;
            background: #ddd;
            color: #888;
            border-color: #ddd;
        }

        .btn-checkout:not(:disabled):hover {
            background: var(--primary-maroon);
            color: var(--accent-yellow);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(125, 10, 34, 0.2);
        }

        .cart-delivery-info {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            color: var(--primary-maroon);
            font-size: 0.9rem;
            padding: 10px;
            background: rgba(255, 215, 0, 0.1);
            border-radius: 8px;
            margin-top: 10px;
        }

        .cart-delivery-info i {
            color: var(--accent-yellow);
        }

        .meal-additional-request {
            margin-top: 20px;
            margin-bottom: 15px;
        }

        .meal-additional-request h4 {
            color: var(--primary-maroon);
            font-size: 1.1rem;
            margin-bottom: 8px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .meal-additional-request h4 i {
            color: var(--accent-yellow);
            font-size: 0.9rem;
        }

        .additional-request-textarea {
            width: 100%;
            padding: 12px;
            border: 2px solid #eee;
            border-radius: 8px;
            font-family: 'Quicksand', sans-serif;
            font-size: 0.9rem;
            resize: vertical;
            transition: all 0.3s ease;
        }

        .additional-request-textarea:focus {
            outline: none;
            border-color: var(--accent-yellow);
            box-shadow: 0 0 0 3px rgba(255, 215, 0, 0.1);
        }

        .meal-detail-modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 2001;
            animation: fadeIn 0.3s ease;
        }

        .meal-modal-overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.7);
            backdrop-filter: blur(3px);
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
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.25);
            border: 2px solid var(--accent-yellow);
            animation: slideInUp 0.3s ease;
            overflow: hidden;
            display: flex;
            flex-direction: column;
        }

        @keyframes slideInUp {
            from {
                transform: translate(-50%, -45%);
                opacity: 0;
            }
            to {
                transform: translate(-50%, -50%);
                opacity: 1;
            }
        }

        .meal-modal-header {
            background: linear-gradient(135deg, var(--primary-maroon) 0%, #5a0819 100%);
            color: white;
            padding: 15px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid var(--accent-yellow);
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
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            transition: all 0.3s ease;
        }

        .meal-close-btn:hover {
            background: rgba(255, 255, 255, 0.2);
            transform: rotate(90deg);
        }

        .meal-modal-body {
            flex: 1;
            overflow-y: auto;
            padding: 20px;
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        .meal-image-container {
            text-align: center;
            margin-bottom: 15px;
        }

        .meal-featured-img {
            width: 100%;
            max-width: 300px;
            height: 180px;
            border-radius: 8px;
            border: 2px solid var(--primary-maroon);
            box-shadow: 0 5px 15px rgba(125, 10, 34, 0.1);
            margin-bottom: 8px;
            object-fit: cover;
        }

        .meal-details {
            background: linear-gradient(135deg, #fdfaf5 0%, #fff9f0 100%);
            border-radius: 8px;
            padding: 15px;
            border-left: 3px solid var(--accent-yellow);
        }

        .meal-item-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 1px solid rgba(125, 10, 34, 0.1);
            flex-wrap: wrap;
        }

        .meal-item-name {
            font-size: 1.5rem;
            font-weight: 800;
            color: var(--primary-maroon);
            margin: 0;
            flex: 1;
            min-width: 200px;
        }

        .meal-item-price {
            font-size: 1.4rem;
            font-weight: 800;
            color: var(--accent-yellow);
            background: var(--primary-maroon);
            padding: 6px 12px;
            border-radius: 6px;
            box-shadow: 0 3px 10px rgba(125, 10, 34, 0.15);
            margin-left: 10px;
            white-space: nowrap;
        }

        .meal-description,
        .meal-ingredients,
        .meal-texture,
        .meal-extras {
            margin-bottom: 15px;
        }

        .meal-description p,
        .meal-ingredients p,
        .meal-texture p {
            font-size: 0.95rem;
            line-height: 1.5;
            color: var(--text-dark);
            margin: 8px 0;
        }

        .meal-ingredients h4,
        .meal-texture h4,
        .meal-extras h4 {
            color: var(--primary-maroon);
            font-size: 1.1rem;
            margin-bottom: 8px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .meal-ingredients h4 i,
        .meal-texture h4 i,
        .meal-extras h4 i {
            color: var(--accent-yellow);
            font-size: 0.9rem;
        }

        .meal-extra-options {
            display: flex;
            flex-direction: column;
            gap: 10px;
            margin-top: 10px;
        }

        .meal-extra-option {
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 10px 12px;
            background: white;
            border-radius: 6px;
            border: 1px solid #eee;
            transition: all 0.3s ease;
        }

        .meal-extra-option:hover {
            border-color: var(--accent-yellow);
            transform: translateX(3px);
        }

        .meal-extra-option input[type="checkbox"] {
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
            padding: 12px;
            background: #f8f8f8;
            border-radius: 8px;
            flex-wrap: wrap;
        }

        .meal-quantity-label {
            font-size: 1rem;
            font-weight: 600;
            color: var(--primary-maroon);
            margin-right: 10px;
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
            border: 1.5px solid var(--primary-maroon);
            background: white;
            color: var(--primary-maroon);
            font-size: 1rem;
            font-weight: bold;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.3s ease;
        }

        .meal-qty-btn:hover {
            background: var(--primary-maroon);
            color: white;
            transform: scale(1.05);
        }

        .meal-quantity-input {
            width: 50px;
            height: 32px;
            text-align: center;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 1rem;
            font-weight: 600;
            color: var(--primary-maroon);
        }

        .meal-quantity-input:focus {
            outline: none;
            border-color: var(--accent-yellow);
            box-shadow: 0 0 0 2px rgba(255, 215, 0, 0.2);
        }

        .meal-modal-actions {
            display: flex;
            gap: 10px;
            justify-content: flex-end;
            flex-wrap: wrap;
        }

        .btn-close-meal-modal {
            background: #f8f8f8;
            color: var(--text-muted);
            border: 1px solid #ddd;
            padding: 10px 20px;
            border-radius: 6px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 6px;
            min-width: 100px;
            justify-content: center;
            font-size: 0.9rem;
        }

        .btn-close-meal-modal:hover {
            background: #e0e0e0;
            color: var(--primary-maroon);
            transform: translateY(-1px);
            box-shadow: 0 3px 8px rgba(0, 0, 0, 0.1);
        }

        .btn-add-to-cart-meal {
            background: linear-gradient(135deg, var(--primary-maroon) 0%, #5a0819 100%);
            color: white;
            border: 1.5px solid var(--primary-maroon);
            padding: 10px 20px;
            border-radius: 6px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 6px;
            min-width: 150px;
            justify-content: center;
            font-size: 0.95rem;
        }

        .btn-add-to-cart-meal:hover {
            background: var(--accent-yellow);
            color: var(--primary-maroon);
            border-color: var(--accent-yellow);
            transform: translateY(-1px);
            box-shadow: 0 5px 15px rgba(125, 10, 34, 0.15);
        }

        .section-fade-in {
            opacity: 0;
            transform: translateY(30px);
            transition: opacity 0.8s ease, transform 0.8s ease;
        }

        .section-fade-in.visible {
            opacity: 1;
            transform: translateY(0);
        }

        .hero-container {
            position: relative;
            min-height: 100vh;
            width: 100%;
            background: linear-gradient(rgba(0,0,0,0.5), rgba(0,0,0,0.5)), 
            url('<%= ResolveUrl("~/Images/landingpage.jpg") %>');
            background-size: cover;
            background-position: center;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            color: var(--text-white);
            text-align: center;
            padding: 80px 20px 60px;
        }

        .hero-content { max-width: 900px; width: 100%; }
        .hero-content h1 { 
            font-size: 3.5rem; 
            font-weight: 700; 
            margin-bottom: 20px; 
            text-shadow: 2px 2px 10px rgba(0,0,0,0.7); 
            line-height: 1.2; 
        }
        .hero-tagline { 
            font-size: 1.8rem; 
            font-weight: 600; 
            margin-bottom: 15px; 
            color: var(--accent-yellow); 
            transition: all 0.3s ease;
        }
        .hero-tagline:hover {
            transform: scale(1.02);
            text-shadow: 0 0 10px rgba(255, 215, 0, 0.5);
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
            line-height: 1.6; 
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
            transition: all 0.3s ease;
        }
        .search-box:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.4);
        }
        .search-box i { 
            color: var(--primary-maroon); 
            margin-right: 15px; 
            transition: all 0.3s ease;
        }
        .search-box:hover i {
            color: var(--accent-yellow);
            transform: scale(1.2);
        }
        .search-input { 
            border: none; 
            outline: none; 
            flex: 1; 
            font-family: inherit; 
            font-size: 1rem; 
            transition: all 0.3s ease;
        }
        .search-input:focus {
            color: var(--primary-maroon);
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
        .btn-search:after {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 5px;
            height: 5px;
            background: rgba(255, 255, 255, 0.5);
            opacity: 0;
            border-radius: 100%;
            transform: scale(1, 1) translate(-50%);
            transform-origin: 50% 50%;
        }
        .btn-search:focus:not(:active)::after {
            animation: ripple 1s ease-out;
        }
        @keyframes ripple {
            0% {
                transform: scale(0, 0);
                opacity: 0.5;
            }
            100% {
                transform: scale(20, 20);
                opacity: 0;
            }
        }

        .cta-group { 
            display: flex; 
            gap: 20px; 
            justify-content: center; 
            gap: 0;
            justify-content: center;
        }
        .btn-cta { 
            padding: 15px 35px; 
            border-radius: 10px; 
            font-weight: 700; 
            text-decoration: none; 
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275); 
            max-width: 200px; 
            text-align: center;
            position: relative;
            overflow: hidden;
            z-index: 1;
        }
        .btn-cta:before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: all 0.6s ease;
            z-index: -1;
        }
        .btn-cta:hover:before {
            left: 100%;
        }
        .btn-order { 
            background: var(--accent-yellow); 
            color: var(--primary-maroon); 
            border: 2px solid var(--accent-yellow);
        }
        .btn-order:hover { 
            background: var(--primary-maroon); 
            color: var(--accent-yellow); 
            border-color: var(--accent-yellow);
            transform: translateY(-5px) scale(1.05);
            box-shadow: 0 15px 25px rgba(0,0,0,0.3);
        }

        .about-section {
            background: #FFFFFF; 
            padding: 100px 8%;
        }

        .about-container {
            width: 100%;
            text-align: left; 
        }

        .about-title {
            font-size: 2.8rem;
            font-weight: 700;
            color: var(--primary-maroon); 
            margin-bottom: 15px;
            letter-spacing: 1px;
            text-transform: uppercase;
            position: relative;
            padding-left: 20px;
            border-left: 8px solid var(--primary-maroon); 
            transition: all 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            display: inline-block;
        }

        .about-title:hover {
            transform: translateX(15px) scale(1.02);
            color: #5a0819;
            border-left: 8px solid var(--accent-yellow);
            text-shadow: 2px 2px 8px rgba(125, 10, 34, 0.2);
        }

        .about-title::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 0;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 215, 0, 0.1), transparent);
            transition: width 0.5s ease;
            z-index: -1;
        }

        .about-title:hover::before {
            width: 100%;
        }

        .about-tagline {
            font-size: 1.4rem;
            margin-bottom: 60px;
            color: var(--text-dark); 
            line-height: 1.5;
            font-weight: 600;
            position: relative;
            transition: all 0.4s ease;
            padding: 10px 0;
        }

        .about-tagline:hover {
            transform: translateY(-5px);
            color: var(--primary-maroon);
            letter-spacing: 0.5px;
        }

        .about-tagline::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 0;
            height: 2px;
            background: linear-gradient(90deg, var(--primary-maroon), var(--accent-yellow));
            transition: width 0.5s ease;
        }

        .about-tagline:hover::after {
            width: 100%;
        }

        .content-box {
            width: 100%;
            background: linear-gradient(135deg, #fdfaf5 0%, #fff9f0 100%);
            border-radius: 15px;
            padding: 40px 50px;
            border-left: 8px solid var(--accent-yellow);
            box-shadow: 0 10px 30px rgba(0,0,0,0.08);
            transition: all 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            margin: 0 auto;
            position: relative;
            overflow: hidden;
        }

        .content-box:hover {
            transform: translateY(-10px) scale(1.01);
            box-shadow: 0 20px 50px rgba(125, 10, 34, 0.15);
            border-left: 8px solid var(--primary-maroon);
        }

        .content-box::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: linear-gradient(
                45deg,
                transparent 30%,
                rgba(255, 215, 0, 0.05) 50%,
                transparent 70%
            );
            transform: rotate(45deg);
            transition: transform 0.8s ease;
            z-index: 0;
        }

        .content-box:hover::before {
            transform: rotate(405deg);
        }

        .content-text {
            font-size: 1.2rem;
            color: var(--text-dark);
            line-height: 1.8;
            text-align: justify;
            position: relative;
            z-index: 1;
        }

        .content-text p {
            margin-bottom: 20px;
            transition: all 0.4s ease;
            padding: 5px;
            border-radius: 5px;
        }

        .content-text p:hover {
            transform: translateX(10px);
            background: linear-gradient(90deg, rgba(255, 215, 0, 0.05), transparent);
            box-shadow: 5px 0 15px rgba(125, 10, 34, 0.1);
        }

        .content-text p:last-child {
            margin-bottom: 0;
        }

        @keyframes float {
            0%, 100% {
                transform: translateY(0);
            }
            50% {
                transform: translateY(-5px);
            }
        }

        .content-text p:nth-child(1) {
            animation: float 3s ease-in-out infinite;
        }

        .content-text p:nth-child(2) {
            animation: float 3s ease-in-out infinite 0.5s;
        }

       .love-us-section {
            background: linear-gradient(135deg, #fdfaf5 0%, #fff9f0 100%);
            padding: 60px 8% 40px;
            position: relative;
        }

        .love-us-container {
            width: 100%;
            text-align: center;
        }

        .love-us-title {
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--primary-maroon);
            margin-bottom: 15px;
            letter-spacing: 1px;
            text-transform: uppercase;
            position: relative;
            display: inline-block;
            padding-bottom: 10px;
            transition: all 0.3s ease;
        }

        .love-us-title::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            width: 100px;
            height: 5px;
            background: var(--primary-maroon);
            transition: all 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            transform: translateX(-50%);
            border-radius: 2px;
        }

        .love-us-title:hover {
            color: #5a0819;
            transform: translateY(-3px);
        }

        .love-us-title:hover::after {
            width: 100%;
            background: var(--accent-yellow);
            height: 6px;
            box-shadow: 0 4px 15px rgba(255, 215, 0, 0.3);
        }

        .features-grid {
            display: grid !important;
            grid-template-columns: repeat(4, 1fr) !important;
            grid-template-rows: 1fr !important;
            gap: 20px!important;
            margin-top: 40px!important;
            margin-left: auto!important;
            margin-right: auto!important;
        }

        .feature-card {
            background: white;
            border-radius: 12px;
            padding: 20px 15px;
            text-align: center;
            box-shadow: 0 5px 15px rgba(125, 10, 34, 0.08);
            transition: all 0.4s cubic-bezier(0.25, 0.46, 0.45, 0.94);
            border: 1px solid transparent;
            height: 100%;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: flex-start;
            position: relative;
            overflow: hidden;
            z-index: 1;
        }

        .feature-card:hover {
            transform: translateY(-8px) scale(1.02);
            border-color: var(--accent-yellow);
            box-shadow: 0 12px 35px rgba(125, 10, 34, 0.15);
        }

        .feature-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, 
                rgba(255, 215, 0, 0.05) 0%,
                rgba(125, 10, 34, 0.05) 100%);
            opacity: 0;
            transition: opacity 0.5s ease;
            z-index: -1;
            border-radius: 20px;
        }

        .feature-card:hover::before {
            opacity: 1;
        }

        .feature-icon {
            width: 50px;
            height: 50px;
            background: linear-gradient(135deg, var(--primary-maroon) 0%, #5a0819 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 15px;
            color: var(--accent-yellow);
            font-size: 1.4rem;
            box-shadow: 0 6px 15px rgba(125, 10, 34, 0.15);
            transition: all 0.4s cubic-bezier(0.25, 0.46, 0.45, 0.94);
        }
        .feature-card:hover .feature-icon {
            transform: scale(1.08) rotate(5deg);
            box-shadow: 0 10px 20px rgba(125, 10, 34, 0.25);
        }

        .feature-title {
            font-size: 1.1rem;
            font-weight: 700;
            color: var(--primary-maroon);
            margin-bottom: 10px;
            transition: color 0.3s ease;
        }
        .feature-card:hover .feature-title {
            color: #5a0819;
        }

        .feature-description {
            font-size: 0.85rem;
            color: var(--text-muted);
            line-height: 1.4;
            padding: 0 5px;
        }

        .menu-display-section {
            padding: 80px 8% 40px;
            background-color: #fdfaf5;
            text-align: center;
            position: relative;
        }
        
        .menu-header {
            font-size: 2.8rem;
            font-weight: 700;
            color: var(--primary-maroon);
            margin-bottom: 50px;
            letter-spacing: 1px;
            text-transform: uppercase;
            position: relative;
            display: inline-block;
            padding-bottom: 15px;
            transition: all 0.3s ease;
        }

        .menu-header::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            width: 100px;
            height: 5px;
            background: var(--primary-maroon);
            transition: all 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            transform: translateX(-50%);
            border-radius: 2px;
        }

        .menu-header:hover {
            color: #5a0819;
            transform: translateY(-3px);
        }

        .menu-header:hover::after {
            width: 100%;
            background: var(--accent-yellow);
            height: 6px;
            box-shadow: 0 4px 15px rgba(255, 215, 0, 0.3);
        }
        
        /* Menu Category Containers */
        .menu-category-container {
            margin-bottom: 60px;
            width: 100%;
            max-width: 1400px;
            margin-left: auto;
            margin-right: auto;
            padding: 0 20px;
        }

        .category-title {
            font-size: 2.2rem;
            font-weight: 800;
            color: var(--primary-maroon);
            margin-bottom: 30px;
            text-align: center;
            position: relative;
            padding-bottom: 15px;
            text-transform: uppercase;
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
        }

        /* Updated grid for 6 per row */
        .menu-grid-container.six-per-row {
            display: grid;
            grid-template-columns: repeat(6, 1fr);
            gap: 20px;
            margin: 0 auto 30px;
            width: 100%;
            justify-items: center;
        }
        
        /* Updated menu container for 6 per row */
        .menu-container {
            background: #fff;
            padding: 15px 12px;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(125, 10, 34, 0.08);
            transition: all 0.5s cubic-bezier(0.25, 0.46, 0.45, 0.94);
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
            border: 2px solid transparent;
            position: relative;
            overflow: hidden;
            z-index: 1;
            width: 100%;
            max-width: 280px;
            min-height: 420px;
        }

        .menu-container:hover {
            transform: translateY(-10px) scale(1.02);
            border-color: var(--accent-yellow);
            box-shadow: 0 15px 40px rgba(125, 10, 34, 0.15);
        }

        .menu-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, 
                rgba(255, 215, 0, 0.05) 0%,
                rgba(125, 10, 34, 0.05) 100%);
            opacity: 0;
            transition: opacity 0.5s ease;
            z-index: -1;
            border-radius: 20px;
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
            position: relative;
        }

        .menu-container:hover .menu-featured-img {
            transform: scale(1.05) rotate(3deg);
            border-color: var(--accent-yellow);
            box-shadow: 0 10px 25px rgba(125, 10, 34, 0.15);
        }

        .menu-list-container { 
            width: 100%;
            text-align: center;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .category-label {
            color: var(--primary-maroon);
            font-size: 1.1rem;
            font-weight: 800;
            margin-bottom: 4px;
            transition: all 0.4s ease;
            min-height: 45px;
            display: flex;
            align-items: center;
            justify-content: center;
            line-height: 1.2;
            padding: 0 2px;
        }

        /* New meal description style */
        .meal-description-short {
            font-size: 0.8rem;
            color: var(--text-muted);
            margin-bottom: 6px;
            line-height: 1.2;
            padding: 0 3px;
            min-height: 30px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        /* Price and rating row */
        .price-rating-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            width: 100%;
            margin: 6px 0 8px;
            padding: 0 3px;
        }

        /* Updated rating stars - just one star with number */
        .rating-stars {
            display: flex;
            align-items: center;
            gap: 3px;
            color: var(--accent-yellow);
            font-size: 0.8rem;
        }

        .rating-stars i {
            color: var(--accent-yellow);
            font-size: 0.85rem;
        }

        .rating-stars span {
            color: var(--text-muted);
            font-size: 0.8rem;
            font-weight: 600;
        }

        /* Updated price style - smaller */
        .item-price-small {
            font-size: 1rem;
            font-weight: 700;
            color: var(--primary-maroon);
            background: rgba(255, 215, 0, 0.15);
            padding: 3px 8px;
            border-radius: 6px;
            display: inline-block;
        }

        /* Updated button container - adjusted for better fit */
        .menu-item-buttons {
            display: flex;
            gap: 6px;
            justify-content: center;
            margin-top: 10px;
            padding-top: 8px;
            border-top: 1px solid #eee;
            width: 100%;
        }

        /* Updated view button - more compact */
        .view-btn {
            background: transparent;
            color: var(--primary-maroon);
            border: 2px solid var(--primary-maroon);
            border-radius: 20px;
            padding: 5px 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 3px;
            font-size: 0.7rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            flex: 1;
            height: 32px;
            white-space: nowrap;
        }

        .view-btn:hover {
            background: var(--primary-maroon);
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(125, 10, 34, 0.2);
        }

        .view-btn i {
            font-size: 0.8rem;
        }

        /* Updated add to cart button - more compact */
        .add-to-cart-btn-text {
            background: var(--accent-yellow);
            color: var(--primary-maroon);
            border: 2px solid var(--accent-yellow);
            border-radius: 20px;
            padding: 5px 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 3px;
            font-size: 0.7rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            flex: 1.2;
            height: 32px;
            white-space: nowrap;
        }

        .add-to-cart-btn-text:hover {
            background: var(--primary-maroon);
            color: var(--accent-yellow);
            border-color: var(--primary-maroon);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(125, 10, 34, 0.2);
        }

        .add-to-cart-btn-text i {
            font-size: 0.8rem;
        }

        /* Floating Back to Top Button */
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
            transition: all 0.3s ease;
            z-index: 999;
            opacity: 0;
            visibility: hidden;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
        }

        .back-to-top.visible {
            opacity: 1;
            visibility: visible;
        }

        .back-to-top:hover {
            background: var(--accent-yellow);
            color: var(--primary-maroon);
            transform: translateY(-5px) scale(1.1);
            box-shadow: 0 6px 20px rgba(255, 215, 0, 0.4);
        }

        .back-to-top i {
            font-size: 1.5rem;
            transition: transform 0.3s ease;
        }

        .back-to-top:hover i {
            transform: translateY(-3px);
        }

        /* Tooltip for back to top button */
        .back-to-top::before {
            content: 'Back to Top';
            position: absolute;
            right: 60px;
            background: var(--primary-maroon);
            color: var(--accent-yellow);
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
            white-space: nowrap;
            opacity: 0;
            visibility: hidden;
            transition: all 0.3s ease;
            border: 1px solid var(--accent-yellow);
            pointer-events: none;
        }

        .back-to-top:hover::before {
            opacity: 1;
            visibility: visible;
            right: 70px;
        }

        @keyframes floatMenu {
            0%, 100% {
                transform: translateY(-10px) scale(1.02);
            }
            50% {
                transform: translateY(-12px) scale(1.02);
            }
        }

        .menu-container:hover {
            animation: floatMenu 4s ease-in-out infinite;
        }

        .compact-order-steps {
            background: #FFFFFF;
            padding: 50px 5% 30px;
            text-align: center;
            position: relative;
            width: 100%;
            border-radius: 0;
            box-shadow: 0 10px 30px rgba(125, 10, 34, 0.08);
        }

        .compact-steps-header {
            font-size: 2rem;
            font-weight: 700;
            color: var(--primary-maroon);
            margin-bottom: 30px;
            letter-spacing: 1px;
            text-transform: uppercase;
            position: relative;
            display: inline-block;
            padding-bottom: 10px;
        }

        .compact-steps-header::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            width: 60px;
            height: 3px;
            background: var(--primary-maroon);
            transition: all 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            transform: translateX(-50%);
            border-radius: 2px;
        }

        .compact-steps-header:hover::after {
            width: 100%;
            background: var(--accent-yellow);
            height: 4px;
        }

        .compact-steps-grid {
            display: flex;
            justify-content: center;
            gap: 20px;
            flex-wrap: wrap;
            margin: 0 auto 30px;
            position: relative;
        }

        .compact-steps-grid::before {
            content: '';
            position: absolute;
            top: 50px;
            left: 50%;
            transform: translateX(-50%);
            width: 70%;
            height: 3px;
            background: linear-gradient(90deg, 
                transparent 10%, 
                var(--primary-maroon) 20%, 
                var(--primary-maroon) 80%, 
                transparent 90%);
            z-index: 0;
            border-radius: 2px;
            box-shadow: 0 2px 5px rgba(125, 10, 34, 0.2);
        }

        .compact-step-card {
            flex: 1;
            min-width: 250px;
            max-width: 300px;
            background: white;
            border-radius: 15px;
            padding: 25px 20px;
            text-align: center;
            box-shadow: 0 5px 15px rgba(125, 10, 34, 0.08);
            transition: all 0.4s ease;
            border: 2px solid transparent;
            position: relative;
            overflow: hidden;
            z-index: 1;
        }

        .compact-step-card:hover {
            transform: translateY(-5px) scale(1.02);
            border-color: var(--accent-yellow);
            box-shadow: 0 10px 25px rgba(125, 10, 34, 0.12);
        }

        .compact-step-number {
            font-size: 2.5rem;
            font-weight: 800;
            color: var(--accent-yellow);
            margin-bottom: 15px;
            position: relative;
            display: inline-block;
            z-index: 2;
        }

        .compact-step-number::after {
            content: '';
            position: absolute;
            width: 40px;
            height: 40px;
            background: rgba(125, 10, 34, 0.1);
            border-radius: 50%;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            z-index: -1;
        }

        .compact-step-title {
            font-size: 1.3rem;
            font-weight: 700;
            color: var(--primary-maroon);
            margin-bottom: 12px;
            transition: color 0.3s ease;
        }

        .compact-step-card:hover .compact-step-title {
            color: #5a0819;
        }

        .compact-step-description {
            font-size: 0.95rem;
            color: var(--text-muted);
            line-height: 1.5;
        }

        .cta-banner {
            background: linear-gradient(135deg, var(--primary-maroon) 0%, #5a0819 100%);
            border-radius: 15px;
            padding: 40px 30px;
            margin: 30px auto 0;
            color: var(--text-white);
            text-align: center;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            transition: all 0.3s ease;
            width: 90%;
        }

        .cta-banner:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.3);
        }

        .cta-title {
            font-size: 2rem;
            font-weight: 800;
            margin-bottom: 15px;
            color: var(--accent-yellow);
        }

        .cta-subtitle {
            font-size: 1.2rem;
            margin-bottom: 25px;
            opacity: 0.9;
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
            border: 2px solid var(--accent-yellow);
            position: relative;
            overflow: hidden;
            z-index: 1;
            margin-bottom: 25px;
        }

        .btn-cta-large:hover {
            background: transparent;
            color: var(--accent-yellow);
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.2);
        }

        .btn-cta-large:before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: all 0.6s ease;
            z-index: -1;
        }

        .btn-cta-large:hover:before {
            left: 100%;
        }

        .contact-info {
            margin-top: 20px;
            font-size: 1.1rem;
            color: rgba(255,255,255,0.9);
        }

        .contact-info i {
            margin-right: 10px;
            color: var(--accent-yellow);
        }

        .phone-numbers {
            margin-top: 10px;
            font-size: 1.2rem;
            font-weight: 600;
            color: var(--accent-yellow);
        }

        .divider {
            width: 90%;
            height: 2px;
            background: linear-gradient(to right, transparent, var(--accent-yellow), transparent);
            margin: 30px auto;
        }

        .contact-map-section {
            background: var(--primary-maroon);
            color: var(--text-white);
            padding: 80px 8% 40px;
        }

        .contact-map-container {
            width: 100%;
        }

        .contact-map-header {
            text-align: center;
            margin-bottom: 40px;
        }

        .contact-map-header h1 {
            font-size: 2.5rem;
            font-weight: 800;
            color: var(--accent-yellow);
            margin-bottom: 15px;
            text-transform: uppercase;
        }

        .contact-map-header .tagline {
            font-size: 1.3rem;
            opacity: 0.9;
        }

        .contact-map-content {
            display: flex;
            gap: 40px;
            flex-wrap: wrap;
            margin-bottom: 40px;
        }

        .map-container-large {
            flex: 2;
            min-width: 300px;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            border: 3px solid var(--accent-yellow);
            transition: all 0.3s ease;
        }
        .map-container-large:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.4);
            border-color: #ffed4e;
        }

        .map-wrapper-large {
            width: 100%;
            height: 400px;
            position: relative;
        }

        .contact-info-sidebar {
            flex: 1;
            min-width: 250px;
            background: rgba(0, 0, 0, 0.2);
            border-radius: 15px;
            padding: 30px;
            border: 2px solid var(--accent-yellow);
            transition: all 0.3s ease;
        }
        .contact-info-sidebar:hover {
            background: rgba(0, 0, 0, 0.3);
            transform: translateY(-5px);
            border-color: #ffed4e;
            box-shadow: 0 10px 25px rgba(0,0,0,0.3);
        }

        .contact-info-group {
            margin-bottom: 30px;
        }

        .contact-info-group h3 {
            color: var(--accent-yellow);
            font-size: 1.4rem;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 10px;
            transition: color 0.3s ease;
        }
        .contact-info-sidebar:hover .contact-info-group h3 {
            color: #ffed4e;
        }

        .contact-info-group h3 i {
            font-size: 1.3rem;
        }

        .contact-details-large {
            font-size: 1.1rem;
            line-height: 1.8;
        }

        .contact-details-large p {
            margin-bottom: 10px;
            padding-left: 25px;
            transition: transform 0.3s ease;
        }
        .contact-info-sidebar:hover .contact-details-large p {
            transform: translateX(5px);
        }

        .phone-large {
            font-size: 1.4rem;
            font-weight: 700;
            color: var(--accent-yellow);
            margin: 10px 0;
            padding-left: 25px;
            transition: all 0.3s ease;
        }
        .contact-info-sidebar:hover .phone-large {
            color: #ffed4e;
            transform: scale(1.05);
        }

        .main-footer {
            background: #5a0819;
            color: var(--text-white);
            padding: 30px 5% 20px;
            width: 100%;
            max-width: 100%;
        }

        .footer-container {
            width: 100%;
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            flex-wrap: wrap;
            gap: 30px;
        }

        .footer-logo-section {
            flex: 1;
            min-width: 200px;
        }

        .footer-logo-container {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 15px;
            transition: transform 0.3s ease;
        }
        .footer-logo-container:hover {
            transform: scale(1.05);
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
            transition: all 0.3s ease;
        }
        .footer-logo-container:hover .footer-brand-name {
            color: #ffed4e;
            text-shadow: 0 0 10px rgba(255, 237, 78, 0.5);
        }

        .footer-tagline {
            font-size: 0.9rem;
            opacity: 0.85;
            margin-top: 8px;
            line-height: 1.4;
            max-width: 300px;
        }
        .footer-logo-section:hover .footer-tagline {
            opacity: 1;
        }

        .footer-quick-links {
            flex: 2;
            min-width: 250px;
        }

        .footer-quick-links h3 {
            color: var(--accent-yellow);
            font-size: 1.2rem;
            margin-bottom: 15px;
            text-transform: uppercase;
            padding-bottom: 8px;
            border-bottom: 1px solid rgba(255, 215, 0, 0.3);
        }
        .footer-quick-links:hover h3 {
            color: #ffed4e;
            border-bottom-color: rgba(255, 237, 78, 0.5);
        }

        .quick-links-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 10px;
        }

        .footer-link {
            color: rgba(255, 255, 255, 0.9);
            text-decoration: none;
            font-size: 0.9rem;
            transition: all 0.3s;
            padding: 3px 0;
            display: block;
            position: relative;
            padding-left: 18px;
        }

        .footer-link:before {
            content: "›";
            position: absolute;
            left: 0;
            color: var(--accent-yellow);
            font-size: 0.9rem;
        }

        .footer-link:hover {
            color: var(--accent-yellow);
            transform: translateX(3px);
        }

        .footer-link:hover:before {
            transform: translateX(3px);
        }

        .footer-bottom {
            background: #4a1a1a;
            padding: 15px 5%;
            text-align: center;
            color: rgba(255, 255, 255, 0.7);
            font-size: 0.8rem;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            margin-top: 25px;
            width: 100%;
        }

        .footer-bottom-content {
            width: 100%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
        }

        .copyright {
            flex: 1;
            text-align: left;
            min-width: 200px;
        }

        .delivery-tag {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            flex: 1;
            min-width: 200px;
            transition: all 0.3s ease;
        }
        .delivery-tag:hover {
            color: var(--accent-yellow);
            transform: scale(1.05);
        }

        .delivery-tag i {
            color: var(--accent-yellow);
            transition: transform 0.3s ease;
        }
        .delivery-tag:hover i {
            transform: scale(1.2);
        }

        .footer-legal {
            flex: 1;
            text-align: right;
            min-width: 200px;
        }

        .footer-legal a {
            color: var(--accent-yellow);
            text-decoration: none;
            font-size: 0.8rem;
            margin-left: 12px;
        }

        .footer-legal a:hover {
            opacity: 0.8;
            text-decoration: underline;
            color: #ffed4e;
        }

        /* Updated menu container adjustments for 6 per row */
        .menu-grid-container.six-per-row .menu-container {
            max-width: 100%;
            min-height: 420px;
            padding: 15px 12px;
        }

        .menu-grid-container.six-per-row .menu-featured-img {
            width: 130px;
            height: 130px;
            margin-bottom: 12px;
        }

        .menu-grid-container.six-per-row .category-label {
            font-size: 1.1rem;
            min-height: 45px;
            margin-bottom: 4px;
        }

        /* Responsive adjustments for 6 per row */
        @media (max-width: 1400px) {
            .menu-grid-container.six-per-row {
                grid-template-columns: repeat(5, 1fr);
            }
        }

        @media (max-width: 1200px) {
            .menu-grid-container.six-per-row {
                grid-template-columns: repeat(4, 1fr);
            }
            
            .features-grid {
                grid-template-columns: repeat(2, 1fr) !important; 
                grid-template-rows: repeat(2, 1fr) !important;
                gap: 15px;
            }
        }

        @media (max-width: 992px) {
            .menu-grid-container.six-per-row {
                grid-template-columns: repeat(3, 1fr);
            }
            
            .features-grid {
                grid-template-columns: repeat(2, 1fr);
                gap: 20px;
            }
            .compact-steps-grid {
                justify-content: center;
                gap: 30px;
            }
            
            .compact-steps-grid::before {
                display: none;
            }
            
            .compact-step-card {
                max-width: 450px;
            }
            
            .contact-map-content {
                flex-direction: column;
            }
            .map-container-large {
                width: 100%;
            }
            .footer-container {
                flex-direction: column;
                text-align: center;
            }
            .footer-logo-container {
                justify-content: center;
            }
            .footer-tagline {
                margin: 10px auto;
            }
            .quick-links-grid {
                grid-template-columns: repeat(2, 1fr);
            }
            .footer-bottom-content {
                flex-direction: column;
                gap: 15px;
                text-align: center;
            }
            .copyright, .delivery-tag, .footer-legal {
                text-align: center;
            }
            .footer-legal a {
                margin: 0 7px;
            }
        }

        @media (max-width: 768px) {
            .meal-modal-content {
                width: 95%;
                max-height: 85vh;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
            }
            
            .meal-modal-body {
                padding: 15px;
                flex-direction: column;
            }
            
            .meal-item-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 10px;
            }
            
            .meal-item-name {
                font-size: 1.3rem;
            }
            
            .meal-item-price {
                font-size: 1.2rem;
                align-self: flex-start;
            }
            
            .meal-modal-actions {
                flex-direction: column;
            }
            
            .btn-close-meal-modal,
            .btn-add-to-cart-meal {
                width: 100%;
                min-width: auto;
            }
            
            .meal-featured-img {
                max-width: 100%;
                height: 160px;
            }
            
            .meal-quantity-selector {
                flex-direction: column;
                align-items: flex-start;
                gap: 10px;
            }
            
            .meal-quantity-controls {
                align-self: stretch;
                justify-content: center;
            }
            
            .menu-grid-container.six-per-row {
                grid-template-columns: repeat(2, 1fr);
                padding: 0 10px;
            }
            
            .menu-container {
                max-width: 100%;
                padding: 15px 10px;
                min-height: 380px;
            }
            
            .menu-featured-img {
                width: 120px;
                height: 120px;
            }
            
            .category-label {
                font-size: 1rem;
                min-height: 40px;
            }
            
            .meal-description-short {
                font-size: 0.75rem;
                min-height: 28px;
            }
            
            .price-rating-row {
                flex-direction: column;
                gap: 3px;
                margin: 4px 0;
            }
            
            .item-price-small {
                font-size: 0.9rem;
                padding: 2px 6px;
            }
            
            .menu-item-buttons {
                flex-direction: column;
                gap: 5px;
                margin-top: 8px;
                padding-top: 6px;
            }
            
            .view-btn, .add-to-cart-btn-text {
                width: 100%;
                padding: 4px 6px;
                height: 28px;
                font-size: 0.65rem;
            }
            
            .cart-modal-content {
                width: 95%;
                right: 2.5%;
                top: 70px;
            }
            
            .cart-actions {
                flex-direction: column;
            }
            
            .love-us-section {
                padding: 60px 5% 40px;
            }
            
            .love-us-title {
                font-size: 2rem;
            }
            
            .love-us-tagline {
                font-size: 1.1rem;
                margin-bottom: 30px;
            }
            
            .features-grid {
                 grid-template-columns: 1fr !important;
                grid-template-rows: repeat(4, auto) !important;
                gap: 15px !important;
            }
            
            .feature-card {
                max-width: 350px;
                margin: 0 auto;
            }
            
            .compact-order-steps {
                padding: 40px 5% 20px;
            }

            .compact-steps-header {
                font-size: 1.8rem;
                margin-bottom: 25px;
            }

            .compact-step-card {
                min-width: 100%;
                padding: 20px 15px;
            }

            .compact-step-number {
                font-size: 2.2rem;
            }
            
            .cta-banner {
                padding: 30px 20px;
                width: 95%;
            }
            
            .cta-title {
                font-size: 1.8rem;
            }
            
            .cta-subtitle {
                font-size: 1.1rem;
            }
            
            .contact-map-section {
                padding: 60px 5% 30px;
            }
            .contact-map-header h1 {
                font-size: 2rem;
            }
            .contact-map-header .tagline {
                font-size: 1.1rem;
            }
            .map-wrapper-large {
                height: 300px;
            }
            .contact-info-sidebar {
                padding: 20px;
            }
            .about-title { 
                font-size: 2.2rem;
                padding-left: 15px;
            }
            .about-title:hover {
                transform: translateX(10px) scale(1.02);
            }
            .hero-content h1 { font-size: 2.5rem; }
            .love-us-title { font-size: 2.2rem; }
            .love-us-tagline {  
                font-size: 1.1rem;
                color: var(--text-muted);
                margin-bottom: 30px;
                max-width: 800px;
                margin-left: auto;
                margin-right: auto;
                line-height: 1.5; 
            }
            .feature-card { padding: 30px 20px; }
            
            .footer-logo {
                height: 60px;
                width: 60px;
            }
            .footer-brand-name {
                font-size: 1.7rem;
            }
            .quick-links-grid {
                grid-template-columns: 1fr;
            }
            
            .content-box {
                padding: 30px 25px;
            }
            .content-text {
                font-size: 1.1rem;
            }
            
            .features-grid {
                display: grid;
                grid-template-columns: repeat(4, 1fr);
                gap: 25px;
                margin-top: 40px;
                margin-left: auto;
                margin-right: auto;
                width: 100%;
                max-width: 1200px;
            }
            
            .menu-header {
                font-size: 2.2rem;
                padding-bottom: 10px;
                text-align: center;
            }
            
            .menu-header:hover {
                transform: translateY(-2px);
            }
            
            .menu-container {
                padding: 25px;
            }

            .back-to-top {
                bottom: 20px;
                right: 20px;
                width: 45px;
                height: 45px;
            }

            .back-to-top i {
                font-size: 1.3rem;
            }

            .back-to-top::before {
                display: none;
            }
        }
        
        @media (max-width: 576px) {
            .menu-grid-container.six-per-row {
                grid-template-columns: 1fr;
            }
            
            .category-title {
                font-size: 1.8rem;
            }
            
            .menu-grid-container.six-per-row .menu-container {
                max-width: 280px;
            }
        }

        @media (max-width: 480px) {
            .meal-modal-header {
                padding: 12px 15px;
            }
            
            .meal-modal-header h2 {
                font-size: 1.2rem;
            }
            
            .meal-modal-body {
                padding: 12px;
            }
            
            .meal-details {
                padding: 12px;
            }
            
            .meal-modal-footer {
                padding: 12px;
            }
            
            .meal-item-name {
                font-size: 1.2rem;
            }
            
            .meal-item-price {
                font-size: 1.1rem;
                padding: 5px 10px;
            }
            
            .meal-featured-img {
                height: 140px;
            }
            
            .cart-modal-content {
                width: 100%;
                right: 0;
                border-radius: 0;
                top: 60px;
                height: calc(100vh - 60px);
                max-height: calc(100vh - 60px);
            }
            
            .cart-item {
                padding: 12px;
            }
            
            .cart-item-name {
                font-size: 0.9rem;
            }
            
            .cart-item-price {
                font-size: 1rem;
            }
            
            .main-footer {
                padding: 20px 3% 12px;
            }
            
            .footer-logo-section {
                min-width: 100%;
            }
            
            .footer-quick-links {
                min-width: 100%;
            }
            
            .footer-bottom-content {
                gap: 8px;
            }
            
            .copyright, .delivery-tag, .footer-legal {
                min-width: 100%;
            }

            .back-to-top {
                bottom: 15px;
                right: 15px;
                width: 40px;
                height: 40px;
            }

            .back-to-top i {
                font-size: 1.2rem;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- Floating Back to Top Button -->
        <div class="back-to-top" id="backToTopBtn" onclick="scrollToTop()">
            <i class="fas fa-arrow-up"></i>
        </div>

        <nav class="navbar">
            <div class="logo-container" onclick="scrollToSection('home')">
                <img src='<%= ResolveUrl("~/Images/LOGO.png") %>' alt="TasteNet Logo" class="logo-img" />
                <span class="brand-name">Caballeros</span>
            </div>
            <ul class="nav-links">
                <li><a href="#home" class="nav-link active">Home</a></li>
                <li><a href="#about" class="nav-link">About Us</a></li>
                <li><a href="#menu" class="nav-link">Menu</a></li>
                <li><a href="#contact" class="nav-link">Contact</a></li>
            </ul>
            <div class="nav-icons">
                <a href="#" data-tooltip="Cart" id="cartIcon" class="cart-icon-wrapper">
                    <i class="fas fa-shopping-basket"></i>
                    <span class="cart-badge" id="cartBadge">0</span>
                </a>
                <a href="<%= ResolveUrl("~/Login.aspx") %>" data-tooltip="Account"><i class="fas fa-user-circle"></i></a>
            </div>
        </nav>

        <div class="cart-modal" id="cartModal">
            <div class="cart-modal-overlay" id="cartOverlay"></div>
            <div class="cart-modal-content">
                <div class="cart-modal-header">
                    <h3><i class="fas fa-shopping-basket"></i> Your Order</h3>
                    <button class="cart-close-btn" id="cartCloseBtn">&times;</button>
                </div>
                
                <div class="cart-modal-body" id="cartItems">
                    <div class="cart-empty-state">
                        <i class="fas fa-shopping-basket"></i>
                        <p>Your cart is empty</p>
                        <p class="cart-empty-subtitle">Add some delicious items to get started!</p>
                        <a href="#menu" class="btn-browse-menu">Browse Menu</a>
                    </div>
                </div>
                
                <div class="cart-modal-footer">
                    <div class="cart-summary">
                        <div class="cart-summary-row">
                            <span>Subtotal</span>
                            <span id="cartSubtotal">₱0.00</span>
                        </div>
                        <div class="cart-summary-row">
                            <span>Delivery Fee</span>
                            <span id="deliveryFee">₱0.00</span>
                        </div>
                        <div class="cart-summary-row cart-total">
                            <span>Total</span>
                            <span id="cartTotal">₱0.00</span>
                        </div>
                    </div>
                    
                    <div class="cart-actions">
                        <button class="btn-clear-cart" id="clearCartBtn">
                            <i class="fas fa-trash"></i> Clear Cart
                        </button>
                        <button class="btn-checkout" id="checkoutBtn" disabled>
                            <i class="fas fa-shopping-bag"></i> Checkout - ₱0.00
                        </button>
                    </div>
                    
                    <div class="cart-delivery-info">
                        <i class="fas fa-info-circle"></i>
                        <span>Free delivery on orders over ₱500</span>
                    </div>
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
                
                <div class="meal-modal-body" id="mealModalBody">
                </div>
                
                <div class="meal-modal-footer">
                    <div class="meal-quantity-selector">
                        <span class="meal-quantity-label">Quantity:</span>
                        <div class="meal-quantity-controls">
                            <button class="meal-qty-btn minus" type="button">-</button>
                            <input type="number" class="meal-quantity-input" value="1" min="1" max="10" />
                            <button class="meal-qty-btn plus" type="button">+</button>
                        </div>
                    </div>
                    
                    <div class="meal-modal-actions">
                        <button class="btn-close-meal-modal" id="closeMealModalBtn">
                            <i class="fas fa-times"></i> Close
                        </button>
                        <button class="btn-add-to-cart-meal" id="addToCartMealBtn">
                            <i class="fas fa-cart-plus"></i> ₱0.00
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <div id="home" class="hero-container section-fade-in">
            <div class="hero-content">
                <h1>Sizzling Good Food,<br />Delivered Hot!</h1>
                <div class="hero-tagline">Dasmariñas' Favorite Silog & Sizzling Meals</div>
                <div class="hero-subtitle">Lutong-Bahay Delivered to your Doorstep</div>
                <div class="hero-description">Authentic Filipino home-based meals from Dasmariñas City's finest kitchens</div>

                <div class="search-box">
                    <i class="fas fa-search"></i>
                    <input type="text" class="search-input" placeholder="Search for Tapsilog, Sisig, or your Favorite..." />
                    <button type="button" class="btn-search">Search</button>
                </div>

                <div class="cta-group">
                    <a href="#menu" class="btn-cta btn-order">Order Now!</a>
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
            
            <div class="menu-category-container">
                <h3 class="category-title">Silog Meals</h3>
                <div class="menu-grid-container six-per-row">
                    <div class="menu-container">
                        <img src='<%= ResolveUrl("~/Images/tapsilog.jpg") %>' alt="Tapsilog" class="menu-featured-img" />
                        <div class="menu-list-container">
                            <div class="category-label">Tapsilog</div>
                            <div class="meal-description-short">Tender cured beef with garlic rice and egg</div>
                            <div class="price-rating-row">
                                <div class="rating-stars">
                                    <i class="fas fa-star"></i>
                                    <span>4.5</span>
                                </div>
                                <div class="item-price-small">₱100</div>
                            </div>
                            <div class="menu-item-buttons">
                                <button class="view-btn" data-name="Tapsilog" title="View Details">
                                    <i class="fas fa-eye"></i> VIEW
                                </button>
                                <button class="add-to-cart-btn-text" data-name="Tapsilog" data-price="100.00" title="Add to Cart">
                                    <i class="fas fa-cart-plus"></i> ADD
                                </button>
                            </div>
                        </div>
                    </div>
                    
                    <div class="menu-container">
                        <img src='<%= ResolveUrl("~/Images/baconsilog.jpg") %>' alt="Baconsilog" class="menu-featured-img" />
                        <div class="menu-list-container">
                            <div class="category-label">Baconsilog</div>
                            <div class="meal-description-short">Crispy bacon with garlic rice and egg</div>
                            <div class="price-rating-row">
                                <div class="rating-stars">
                                    <i class="fas fa-star"></i>
                                    <span>5.0</span>
                                </div>
                                <div class="item-price-small">₱75</div>
                            </div>
                            <div class="menu-item-buttons">
                                <button class="view-btn" data-name="Baconsilog" title="View Details">
                                    <i class="fas fa-eye"></i> VIEW
                                </button>
                                <button class="add-to-cart-btn-text" data-name="Baconsilog" data-price="75.00" title="Add to Cart">
                                    <i class="fas fa-cart-plus"></i> ADD
                                </button>
                            </div>
                        </div>
                    </div>
                    
                    <div class="menu-container">
                        <img src='<%= ResolveUrl("~/Images/Bangsilog.jpg") %>' alt="Bangsilog (Boneless)" class="menu-featured-img" />
                        <div class="menu-list-container">
                            <div class="category-label">Bangsilog (Boneless)</div>
                            <div class="meal-description-short">Boneless milkfish with garlic rice and egg</div>
                            <div class="price-rating-row">
                                <div class="rating-stars">
                                    <i class="fas fa-star"></i>
                                    <span>4.3</span>
                                </div>
                                <div class="item-price-small">₱85</div>
                            </div>
                            <div class="menu-item-buttons">
                                <button class="view-btn" data-name="Bangsilog (Boneless)" title="View Details">
                                    <i class="fas fa-eye"></i> VIEW
                                </button>
                                <button class="add-to-cart-btn-text" data-name="Bangsilog (Boneless)" data-price="85.00" title="Add to Cart">
                                    <i class="fas fa-cart-plus"></i> ADD
                                </button>
                            </div>
                        </div>
                    </div>
                    
                    <div class="menu-container">
                        <img src='<%= ResolveUrl("~/Images/porksilog.jpg") %>' alt="Porksilog" class="menu-featured-img" />
                        <div class="menu-list-container">
                            <div class="category-label">Porksilog</div>
                            <div class="meal-description-short">Tender ham slices with garlic rice and egg</div>
                            <div class="price-rating-row">
                                <div class="rating-stars">
                                    <i class="fas fa-star"></i>
                                    <span>4.8</span>
                                </div>
                                <div class="item-price-small">₱55</div>
                            </div>
                            <div class="menu-item-buttons">
                                <button class="view-btn" data-name="Porksilog" title="View Details">
                                    <i class="fas fa-eye"></i> VIEW
                                </button>
                                <button class="add-to-cart-btn-text" data-name="Porksilog" data-price="55.00" title="Add to Cart">
                                    <i class="fas fa-cart-plus"></i> ADD
                                </button>
                            </div>
                        </div>
                    </div>
                    
                    <div class="menu-container">
                        <img src='<%= ResolveUrl("~/Images/Hotsilog.jpg") %>' alt="Hotsilog (Purefoods)" class="menu-featured-img" />
                        <div class="menu-list-container">
                            <div class="category-label">Hotsilog (Purefoods)</div>
                            <div class="meal-description-short">Purefoods hotdog with garlic rice and egg</div>
                            <div class="price-rating-row">
                                <div class="rating-stars">
                                    <i class="fas fa-star"></i>
                                    <span>4.4</span>
                                </div>
                                <div class="item-price-small">₱55</div>
                            </div>
                            <div class="menu-item-buttons">
                                <button class="view-btn" data-name="Hotsilog (Purefoods)" title="View Details">
                                    <i class="fas fa-eye"></i> VIEW
                                </button>
                                <button class="add-to-cart-btn-text" data-name="Hotsilog (Purefoods)" data-price="55.00" title="Add to Cart">
                                    <i class="fas fa-cart-plus"></i> ADD
                                </button>
                            </div>
                        </div>
                    </div>
                    
                    <div class="menu-container">
                        <img src='<%= ResolveUrl("~/Images/tocilog.jpg") %>' alt="Tocisilog" class="menu-featured-img" />
                        <div class="menu-list-container">
                            <div class="category-label">Tocisilog</div>
                            <div class="meal-description-short">Homemade longganisa with garlic rice and egg</div>
                            <div class="price-rating-row">
                                <div class="rating-stars">
                                    <i class="fas fa-star"></i>
                                    <span>4.9</span>
                                </div>
                                <div class="item-price-small">₱85</div>
                            </div>
                            <div class="menu-item-buttons">
                                <button class="view-btn" data-name="Tocisilog" title="View Details">
                                    <i class="fas fa-eye"></i> VIEW
                                </button>
                                <button class="add-to-cart-btn-text" data-name="Tocisilog" data-price="85.00" title="Add to Cart">
                                    <i class="fas fa-cart-plus"></i> ADD
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="menu-category-container">
                <h3 class="category-title">Sizzling Meals</h3>
                <div class="menu-grid-container six-per-row">
                    <div class="menu-container">
                        <img src='<%= ResolveUrl("~/Images/sizzling.jpg") %>' alt="Sizzling" class="menu-featured-img" />
                        <div class="menu-list-container">
                            <div class="category-label">Sizzling Sisig</div>
                            <div class="meal-description-short">Sizzling chopped pork with onions and chili</div>
                            <div class="price-rating-row">
                                <div class="rating-stars">
                                    <i class="fas fa-star"></i>
                                    <span>4.7</span>
                                </div>
                                <div class="item-price-small">₱150</div>
                            </div>
                            <div class="menu-item-buttons">
                                <button class="view-btn" data-name="Sizzling Sisig" title="View Details">
                                    <i class="fas fa-eye"></i> VIEW
                                </button>
                                <button class="add-to-cart-btn-text" data-name="Sizzling Sisig" data-price="150.00" title="Add to Cart">
                                    <i class="fas fa-cart-plus"></i> ADD
                                </button>
                            </div>
                        </div>
                    </div>
                    
                    <div class="menu-container">
                        <img src='<%= ResolveUrl("~/Images/porksteak.jpg") %>' alt="Sizzling Pork Steak" class="menu-featured-img" />
                        <div class="menu-list-container">
                            <div class="category-label">Sizzling Pork Steak</div>
                            <div class="meal-description-short">Juicy pork steak with savory gravy</div>
                            <div class="price-rating-row">
                                <div class="rating-stars">
                                    <i class="fas fa-star"></i>
                                    <span>4.6</span>
                                </div>
                                <div class="item-price-small">₱140</div>
                            </div>
                            <div class="menu-item-buttons">
                                <button class="view-btn" data-name="Sizzling Pork Steak" title="View Details">
                                    <i class="fas fa-eye"></i> VIEW
                                </button>
                                <button class="add-to-cart-btn-text" data-name="Sizzling Pork Steak" data-price="140.00" title="Add to Cart">
                                    <i class="fas fa-cart-plus"></i> ADD
                                </button>
                            </div>
                        </div>
                    </div>
                    
                    <div class="menu-container">
                        <img src='<%= ResolveUrl("~/Images/chicken.jpg") %>' alt="Sizzling Chicken" class="menu-featured-img" />
                        <div class="menu-list-container">
                            <div class="category-label">Sizzling Chicken</div>
                            <div class="meal-description-short">Tender chicken with special sizzling sauce</div>
                            <div class="price-rating-row">
                                <div class="rating-stars">
                                    <i class="fas fa-star"></i>
                                    <span>4.4</span>
                                </div>
                                <div class="item-price-small">₱130</div>
                            </div>
                            <div class="menu-item-buttons">
                                <button class="view-btn" data-name="Sizzling Chicken" title="View Details">
                                    <i class="fas fa-eye"></i> VIEW
                                </button>
                                <button class="add-to-cart-btn-text" data-name="Sizzling Chicken" data-price="130.00" title="Add to Cart">
                                    <i class="fas fa-cart-plus"></i> ADD
                                </button>
                            </div>
                        </div>
                    </div>
                    
                    <div class="menu-container">
                        <img src='<%= ResolveUrl("~/Images/tofu.jpg") %>' alt="Sizzling Tofu" class="menu-featured-img" />
                        <div class="menu-list-container">
                            <div class="category-label">Sizzling Tofu</div>
                            <div class="meal-description-short">Crispy tofu with savory sizzling sauce</div>
                            <div class="price-rating-row">
                                <div class="rating-stars">
                                    <i class="fas fa-star"></i>
                                    <span>4.5</span>
                                </div>
                                <div class="item-price-small">₱120</div>
                            </div>
                            <div class="menu-item-buttons">
                                <button class="view-btn" data-name="Sizzling Tofu" title="View Details">
                                    <i class="fas fa-eye"></i> VIEW
                                </button>
                                <button class="add-to-cart-btn-text" data-name="Sizzling Tofu" data-price="120.00" title="Add to Cart">
                                    <i class="fas fa-cart-plus"></i> ADD
                                </button>
                            </div>
                        </div>
                    </div>
                    
                    <div class="menu-container">
                        <img src='<%= ResolveUrl("~/Images/pork.jpg") %>' alt="Sizzling Pork Sisig" class="menu-featured-img" />
                        <div class="menu-list-container">
                            <div class="category-label">Sizzling Pork Sisig</div>
                            <div class="meal-description-short">Traditional sizzling pork sisig with egg</div>
                            <div class="price-rating-row">
                                <div class="rating-stars">
                                    <i class="fas fa-star"></i>
                                    <span>4.9</span>
                                </div>
                                <div class="item-price-small">₱145</div>
                            </div>
                            <div class="menu-item-buttons">
                                <button class="view-btn" data-name="Sizzling Pork Sisig" title="View Details">
                                    <i class="fas fa-eye"></i> VIEW
                                </button>
                                <button class="add-to-cart-btn-text" data-name="Sizzling Pork Sisig" data-price="145.00" title="Add to Cart">
                                    <i class="fas fa-cart-plus"></i> ADD
                                </button>
                            </div>
                        </div>
                    </div>
                    
                    <div class="menu-container">
                        <img src='<%= ResolveUrl("~/Images/liempo.jpg") %>' alt="Sizzling Liempo" class="menu-featured-img" />
                        <div class="menu-list-container">
                            <div class="category-label">Sizzling Liempo</div>
                            <div class="meal-description-short">Grilled pork belly with special sauce</div>
                            <div class="price-rating-row">
                                <div class="rating-stars">
                                    <i class="fas fa-star"></i>
                                    <span>4.8</span>
                                </div>
                                <div class="item-price-small">₱155</div>
                            </div>
                            <div class="menu-item-buttons">
                                <button class="view-btn" data-name="Sizzling Liempo" title="View Details">
                                    <i class="fas fa-eye"></i> VIEW
                                </button>
                                <button class="add-to-cart-btn-text" data-name="Sizzling Liempo" data-price="155.00" title="Add to Cart">
                                    <i class="fas fa-cart-plus"></i> ADD
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="menu-category-container">
                <h3 class="category-title">Special Meals</h3>
                <div class="menu-grid-container six-per-row">
                    <div class="menu-container">
                        <img src='<%= ResolveUrl("~/Images/bulalo.jpg") %>' alt="Special Bulalo" class="menu-featured-img" />
                        <div class="menu-list-container">
                            <div class="category-label">Special Bulalo</div>
                            <div class="meal-description-short">Beef shank soup with vegetables</div>
                            <div class="price-rating-row">
                                <div class="rating-stars">
                                    <i class="fas fa-star"></i>
                                    <span>5.0</span>
                                </div>
                                <div class="item-price-small">₱120</div>
                            </div>
                            <div class="menu-item-buttons">
                                <button class="view-btn" data-name="Special Bulalo" title="View Details">
                                    <i class="fas fa-eye"></i> VIEW
                                </button>
                                <button class="add-to-cart-btn-text" data-name="Special Bulalo" data-price="120.00" title="Add to Cart">
                                    <i class="fas fa-cart-plus"></i> ADD
                                </button>
                            </div>
                        </div>
                    </div>
                    
                    <div class="menu-container">
                        <img src='<%= ResolveUrl("~/Images/sinigang.jpg") %>' alt="Special Sinigang" class="menu-featured-img" />
                        <div class="menu-list-container">
                            <div class="category-label">Special Sinigang</div>
                            <div class="meal-description-short">Sour soup with pork and vegetables</div>
                            <div class="price-rating-row">
                                <div class="rating-stars">
                                    <i class="fas fa-star"></i>
                                    <span>4.7</span>
                                </div>
                                <div class="item-price-small">₱100</div>
                            </div>
                            <div class="menu-item-buttons">
                                <button class="view-btn" data-name="Special Sinigang" title="View Details">
                                    <i class="fas fa-eye"></i> VIEW
                                </button>
                                <button class="add-to-cart-btn-text" data-name="Special Sinigang" data-price="100.00" title="Add to Cart">
                                    <i class="fas fa-cart-plus"></i> ADD
                                </button>
                            </div>
                        </div>
                    </div>
                    
                    <div class="menu-container">
                        <img src='<%= ResolveUrl("~/Images/tokwa.jpg") %>' alt="Special Tokwat Baboy" class="menu-featured-img" />
                        <div class="menu-list-container">
                            <div class="category-label">Special Tokwat Baboy</div>
                            <div class="meal-description-short">Tofu and pork with savory sauce</div>
                            <div class="price-rating-row">
                                <div class="rating-stars">
                                    <i class="fas fa-star"></i>
                                    <span>4.3</span>
                                </div>
                                <div class="item-price-small">₱110</div>
                            </div>
                            <div class="menu-item-buttons">
                                <button class="view-btn" data-name="Special Tokwat Baboy" title="View Details">
                                    <i class="fas fa-eye"></i> VIEW
                                </button>
                                <button class="add-to-cart-btn-text" data-name="Special Tokwat Baboy" data-price="110.00" title="Add to Cart">
                                    <i class="fas fa-cart-plus"></i> ADD
                                </button>
                            </div>
                        </div>
                    </div>
                    
                    <div class="menu-container">
                        <img src='<%= ResolveUrl("~/Images/arroz.jpg") %>' alt="Special Arrozcaldo" class="menu-featured-img" />
                        <div class="menu-list-container">
                            <div class="category-label">Special Arrozcaldo</div>
                            <div class="meal-description-short">Chicken rice porridge with ginger</div>
                            <div class="price-rating-row">
                                <div class="rating-stars">
                                    <i class="fas fa-star"></i>
                                    <span>4.6</span>
                                </div>
                                <div class="item-price-small">₱250</div>
                            </div>
                            <div class="menu-item-buttons">
                                <button class="view-btn" data-name="Special Arrozcaldo" title="View Details">
                                    <i class="fas fa-eye"></i> VIEW
                                </button>
                                <button class="add-to-cart-btn-text" data-name="Special Arrozcaldo" data-price="250.00" title="Add to Cart">
                                    <i class="fas fa-cart-plus"></i> ADD
                                </button>
                            </div>
                        </div>
                    </div>
                    
                    <div class="menu-container">
                        <img src='<%= ResolveUrl("~/Images/gotoover.jpg") %>' alt="Special Goto Overload" class="menu-featured-img" />
                        <div class="menu-list-container">
                            <div class="category-label">Special Goto Overload</div>
                            <div class="meal-description-short">Beef tripe porridge with extra toppings</div>
                            <div class="price-rating-row">
                                <div class="rating-stars">
                                    <i class="fas fa-star"></i>
                                    <span>4.8</span>
                                </div>
                                <div class="item-price-small">₱220</div>
                            </div>
                            <div class="menu-item-buttons">
                                <button class="view-btn" data-name="Special Goto Overload" title="View Details">
                                    <i class="fas fa-eye"></i> VIEW
                                </button>
                                <button class="add-to-cart-btn-text" data-name="Special Goto Overload" data-price="220.00" title="Add to Cart">
                                    <i class="fas fa-cart-plus"></i> ADD
                                </button>
                            </div>
                        </div>
                    </div>
                    
                    <div class="menu-container">
                        <img src='<%= ResolveUrl("~/Images/Goto.jpg") %>' alt="Special Goto" class="menu-featured-img" />
                        <div class="menu-list-container">
                            <div class="category-label">Special Goto</div>
                            <div class="meal-description-short">Classic beef tripe porridge</div>
                            <div class="price-rating-row">
                                <div class="rating-stars">
                                    <i class="fas fa-star"></i>
                                    <span>4.5</span>
                                </div>
                                <div class="item-price-small">₱180</div>
                            </div>
                            <div class="menu-item-buttons">
                                <button class="view-btn" data-name="Special Goto" title="View Details">
                                    <i class="fas fa-eye"></i> VIEW
                                </button>
                                <button class="add-to-cart-btn-text" data-name="Special Goto" data-price="180.00" title="Add to Cart">
                                    <i class="fas fa-cart-plus"></i> ADD
                                </button>
                            </div>
                        </div>
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
                        <p class="compact-step-description">
                            Choose from our sizzling specials and silog meals. Explore our full menu and find your favorites.
                        </p>
                    </div>
                    
                    <div class="compact-step-card">
                        <div class="compact-step-number">02</div>
                        <h3 class="compact-step-title">Customize & Order</h3>
                        <p class="compact-step-description">
                            Add to cart and place your order online. Customize your meal with extra toppings or special requests.
                        </p>
                    </div>
                    
                    <div class="compact-step-card">
                        <div class="compact-step-number">03</div>
                        <h3 class="compact-step-title">We Deliver Hot!</h3>
                        <p class="compact-step-description">
                            We deliver with our trusted rider straight to your door. Hot and fresh, just like home cooking.
                        </p>
                    </div>
                </div>
                
                <div class="divider"></div>
                
                <div class="cta-banner">
                    <h3 class="cta-title">Hungry? Order Now!</h3>
                    <p class="cta-subtitle">Free delivery on orders over ₱500</p>
                    <a href="<%= ResolveUrl("~/Users/Customer/Menu.aspx") %>" class="btn-cta-large">Order Now</a>
                    
                    <div class="contact-info">
                        <p><i class="fas fa-phone"></i> Call us for inquiries:</p>
                        <div class="phone-numbers">
                            046-473-9753 / 0912-368-7369
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section class="love-us-section section-fade-in">
            <div class="love-us-container">
                <h2 class="love-us-title">Why Customers Love Us</h2>
                <p class="love-us-tagline">
                    Discover what makes TasteNet the trusted choice for authentic Filipino home-cooked meals
                </p>
                
                <div class="features-grid">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-leaf"></i>
                        </div>
                        <h3 class="feature-title">Fresh Daily</h3>
                        <p class="feature-description">
                            We cook fresh meals every day using high-quality ingredients. No preservatives, just pure homemade goodness.
                        </p>
                    </div>
                    
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-utensils"></i>
                        </div>
                        <h3 class="feature-title">Authentic Taste</h3>
                        <p class="feature-description">
                            Traditional Filipino recipes with a twist. Experience the genuine flavors of home-cooked meals passed down through generations.
                        </p>
                    </div>
                    
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-shipping-fast"></i>
                        </div>
                        <h3 class="feature-title">Quick Delivery</h3>
                        <p class="feature-description">
                            Hot meals delivered fast to your doorstep. Our efficient delivery system ensures your food arrives fresh and sizzling hot.
                        </p>
                    </div>
                    
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-user-check"></i>
                        </div>
                        <h3 class="feature-title">Cook Your Way</h3>
                        <p class="feature-description">
                            Customize your meal just how you want it. Adjust spice levels, add extra toppings, or make special requests.
                        </p>
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
                                title="Your Location Name">
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
                        <a href="#" class="footer-link">Order Tracking</a>
                        <a href="#" class="footer-link">Become a Vendor</a>
                        <a href="#" class="footer-link">Terms & Conditions</a>
                        <a href="#" class="footer-link">Privacy Policy</a>
                    </div>
                </div>
            </div>

            <div class="footer-bottom">
                <div class="footer-bottom-content">
                    <div class="copyright">
                        © 2023 TasteNet | Sizzling Good Food. All rights reserved.
                    </div>
                    <div class="delivery-tag">
                        <i class="fas fa-map-marker-alt"></i>
                        <span>Delivering in Dasmariñas City, Cavite</span>
                    </div>
                    <div class="footer-legal">
                        <a href="#">Terms & Conditions</a>
                        <a href="#">Privacy Policy</a>
                    </div>
                </div>
            </div>
        </footer>

        <script>
            const mealData = {
                "Tapsilog": {
                    category: "Silog Meals",
                    price: 100,
                    description: "This is beef that has been cured or marinated. Traditionally, it's a mix of salty, sweet, and tangy.",
                    ingredients: "Usually calamansi (Filipino lime), soy sauce, sugar, minced garlic, and black pepper.",
                    texture: "It can be served 'soft and juicy' or 'crispy/shredded,' depending on the restaurant's style.",
                    image: '<%= ResolveUrl("~/Images/tapsilog.jpg") %>',
                    extras: [
                        { name: "Extra Rice", price: 15 },
                        { name: "Add Egg", price: 10 },
                        { name: "Make it Spicy", price: 5 }
                    ]
                },
                "Baconsilog": {
                    category: "Silog Meals",
                    price: 75,
                    description: "Crispy bacon served with garlic fried rice and sunny-side-up egg.",
                    ingredients: "Premium bacon, garlic rice, egg, cooking oil, spices.",
                    texture: "Crispy bacon with fluffy rice and runny egg yolk.",
                    image: '<%= ResolveUrl("~/Images/baconsilog.jpg") %>',
                    extras: [
                        { name: "Extra Rice", price: 15 },
                        { name: "Add Egg", price: 10 }
                    ]
                },
                "Bangsilog (Boneless)": {
                    category: "Silog Meals",
                    price: 85,
                    description: "Boneless bangus (milkfish) marinated and fried to perfection.",
                    ingredients: "Boneless bangus, vinegar, garlic, pepper, soy sauce.",
                    texture: "Crispy outside, tender and flaky inside.",
                    image: '<%= ResolveUrl("~/Images/Bangsilog.jpg") %>',
                    extras: [
                        { name: "Extra Rice", price: 15 },
                        { name: "Add Egg", price: 10 }
                    ]
                },
                "Porksilog": {
                    category: "Silog Meals",
                    price: 55,
                    description: "Tasty ham slices with garlic rice and egg.",
                    ingredients: "Ham slices, garlic rice, egg, cooking oil.",
                    texture: "Soft ham with aromatic garlic rice.",
                    image: '<%= ResolveUrl("~/Images/porksilog.jpg") %>',
                    extras: [
                        { name: "Extra Rice", price: 15 },
                        { name: "Add Egg", price: 10 }
                    ]
                },
                "Hotsilog (Purefoods)": {
                    category: "Silog Meals",
                    price: 55,
                    description: "Purefoods hotdog with garlic rice and sunny-side-up egg.",
                    ingredients: "Purefoods hotdog, garlic rice, egg, cooking oil.",
                    texture: "Juicy hotdog with fluffy rice.",
                    image: '<%= ResolveUrl("~/Images/Hotsilog.jpg") %>',
                    extras: [
                        { name: "Extra Rice", price: 15 },
                        { name: "Add Egg", price: 10 }
                    ]
                },
                "Tocisilog": {
                    category: "Silog Meals",
                    price: 85,
                    description: "Homemade longganisa (Filipino sausage) with garlic rice and egg.",
                    ingredients: "Longganisa, garlic rice, egg, vinegar dip.",
                    texture: "Juicy sausage with garlic-infused rice.",
                    image: '<%= ResolveUrl("~/Images/tocilog.jpg") %>',
                    extras: [
                        { name: "Extra Rice", price: 15 },
                        { name: "Add Egg", price: 10 }
                    ]
                },
                "Sizzling Sisig": {
                    category: "Sizzling Meals",
                    price: 150,
                    description: "A sizzling plate of chopped pork parts seasoned with calamansi, onions, and chili peppers.",
                    ingredients: "Pork face, ears, liver, onions, calamansi, chili peppers.",
                    texture: "Crispy, savory, and slightly chewy with a zesty kick.",
                    image: '<%= ResolveUrl("~/Images/sizzling.jpg") %>',
                    extras: [
                        { name: "Extra Rice", price: 15 },
                        { name: "Add Egg", price: 10 },
                        { name: "Extra Spicy", price: 5 }
                    ]
                },
                "Sizzling Pork Steak": {
                    category: "Sizzling Meals",
                    price: 140,
                    description: "Juicy pork steak served on a sizzling plate with savory gravy.",
                    ingredients: "Pork steak, soy sauce, calamansi, onions, bell peppers.",
                    texture: "Tender pork with rich gravy sauce.",
                    image: '<%= ResolveUrl("~/Images/porksteak.jpg") %>',
                    extras: [
                        { name: "Extra Rice", price: 15 },
                        { name: "Extra Gravy", price: 10 }
                    ]
                },
                "Sizzling Chicken": {
                    category: "Sizzling Meals",
                    price: 130,
                    description: "Chicken cooked on a sizzling plate with special sauce.",
                    ingredients: "Chicken pieces, soy sauce, oyster sauce, vegetables.",
                    texture: "Tender chicken with savory sauce.",
                    image: '<%= ResolveUrl("~/Images/chicken.jpg") %>',
                    extras: [
                        { name: "Extra Rice", price: 15 },
                        { name: "Extra Sauce", price: 10 }
                    ]
                },
                "Sizzling Tofu": {
                    category: "Sizzling Meals",
                    price: 120,
                    description: "Crispy tofu served sizzling hot with special sauce.",
                    ingredients: "Tofu, soy sauce, garlic, vegetables.",
                    texture: "Crispy outside, soft inside with savory sauce.",
                    image: '<%= ResolveUrl("~/Images/tofu.jpg") %>',
                    extras: [
                        { name: "Extra Rice", price: 15 },
                        { name: "Extra Sauce", price: 10 }
                    ]
                },
                "Sizzling Pork Sisig": {
                    category: "Sizzling Meals",
                    price: 145,
                    description: "Traditional sizzling pork sisig with egg.",
                    ingredients: "Pork face, ears, liver, onions, calamansi, chili peppers.",
                    texture: "Crispy, savory, and slightly chewy with a zesty kick.",
                    image: '<%= ResolveUrl("~/Images/pork.jpg") %>',
                    extras: [
                        { name: "Extra Rice", price: 15 },
                        { name: "Add Egg", price: 10 },
                        { name: "Extra Spicy", price: 5 }
                    ]
                },
                "Sizzling Liempo": {
                    category: "Sizzling Meals",
                    price: 155,
                    description: "Grilled pork belly served sizzling with special sauce.",
                    ingredients: "Pork belly, soy sauce, calamansi, spices.",
                    texture: "Crispy skin with tender meat.",
                    image: '<%= ResolveUrl("~/Images/liempo.jpg") %>',
                    extras: [
                        { name: "Extra Rice", price: 15 },
                        { name: "Extra Sauce", price: 10 }
                    ]
                },
                
                "Special Bulalo": {
                    category: "Special Meals",
                    price: 120,
                    description: "Hearty beef shank soup with vegetables.",
                    ingredients: "Beef shank, bone marrow, corn, cabbage, potatoes.",
                    texture: "Tender beef with rich broth.",
                    image: '<%= ResolveUrl("~/Images/bulalo.jpg") %>',
                    extras: [
                        { name: "Extra Rice", price: 15 },
                        { name: "Extra Vegetables", price: 20 }
                    ]
                },
                "Special Sinigang": {
                    category: "Special Meals",
                    price: 100,
                    description: "Sour soup with pork and vegetables.",
                    ingredients: "Pork, tamarind, vegetables, onions, tomatoes.",
                    texture: "Tender pork in tangy broth.",
                    image: '<%= ResolveUrl("~/Images/sinigang.jpg") %>',
                    extras: [
                        { name: "Extra Rice", price: 15 },
                        { name: "Extra Vegetables", price: 15 }
                    ]
                },
                "Special Tokwat Baboy": {
                    category: "Special Meals",
                    price: 110,
                    description: "Tofu and pork with savory sauce.",
                    ingredients: "Tofu, pork, soy sauce, vinegar, onions, chili.",
                    texture: "Crispy tofu with tender pork in tangy sauce.",
                    image: '<%= ResolveUrl("~/Images/tokwa.jpg") %>',
                    extras: [
                        { name: "Extra Rice", price: 15 },
                        { name: "Extra Sauce", price: 10 }
                    ]
                },
                "Special Arrozcaldo": {
                    category: "Special Meals",
                    price: 250,
                    description: "Chicken rice porridge with ginger and garlic.",
                    ingredients: "Rice, chicken, ginger, garlic, saffron, egg.",
                    texture: "Aromatic and creamy porridge.",
                    image: '<%= ResolveUrl("~/Images/arroz.jpg") %>',
                    extras: [
                        { name: "Extra Chicken", price: 20 },
                        { name: "Extra Egg", price: 10 }
                    ]
                },
                "Special Goto Overload": {
                    category: "Special Meals",
                    price: 220,
                    description: "Beef tripe porridge with extra toppings.",
                    ingredients: "Beef tripe, rice, garlic, ginger, egg, chicharon.",
                    texture: "Creamy porridge with tender tripe.",
                    image: '<%= ResolveUrl("~/Images/gotoover.jpg") %>',
                    extras: [
                        { name: "Extra Tripe", price: 20 },
                        { name: "Extra Egg", price: 10 },
                        { name: "Extra Chicharon", price: 15 }
                    ]
                },
                "Special Goto": {
                    category: "Special Meals",
                    price: 180,
                    description: "Classic beef tripe porridge.",
                    ingredients: "Beef tripe, rice, garlic, ginger, scallions.",
                    texture: "Creamy porridge with tender tripe.",
                    image: '<%= ResolveUrl("~/Images/Goto.jpg") %>',
                    extras: [
                        { name: "Extra Tripe", price: 20 },
                        { name: "Extra Egg", price: 10 }
                    ]
                }
            };

            const mealModal = {
                currentMeal: null,

                init: function () {
                    this.setupEventListeners();
                    this.addViewButtons();
                },

                setupEventListeners: function () {
                    const closeBtn = document.getElementById('mealCloseBtn');
                    const closeModalBtn = document.getElementById('closeMealModalBtn');
                    const overlay = document.getElementById('mealOverlay');

                    if (closeBtn) closeBtn.addEventListener('click', (e) => {
                        e.preventDefault();
                        e.stopPropagation();
                        this.closeModal();
                    });

                    if (closeModalBtn) closeModalBtn.addEventListener('click', (e) => {
                        e.preventDefault();
                        e.stopPropagation();
                        this.closeModal();
                    });

                    if (overlay) overlay.addEventListener('click', (e) => {
                        e.preventDefault();
                        e.stopPropagation();
                        this.closeModal();
                    });

                    document.addEventListener('click', (e) => {
                        const minusBtn = e.target.closest('.meal-qty-btn.minus');
                        const plusBtn = e.target.closest('.meal-qty-btn.plus');

                        if (minusBtn || plusBtn) {
                            e.preventDefault();
                            e.stopPropagation();
                            const quantityInput = document.querySelector('.meal-quantity-input');
                            let currentValue = parseInt(quantityInput.value) || 1;

                            if (minusBtn && currentValue > 1) {
                                quantityInput.value = currentValue - 1;
                                this.updatePrice();
                            } else if (plusBtn && currentValue < 10) {
                                quantityInput.value = currentValue + 1;
                                this.updatePrice();
                            }
                        }
                    });

                    document.addEventListener('input', (e) => {
                        if (e.target.classList.contains('.meal-quantity-input')) {
                            let value = parseInt(e.target.value);
                            if (isNaN(value) || value < 1) value = 1;
                            if (value > 10) value = 10;
                            e.target.value = value;
                            this.updatePrice();
                        }
                    });

                    document.addEventListener('change', (e) => {
                        if (e.target.closest('.meal-extra-option input[type="checkbox"]')) {
                            this.updatePrice();
                        }
                    });

                    const addToCartBtn = document.getElementById('addToCartMealBtn');
                    if (addToCartBtn) addToCartBtn.addEventListener('click', (e) => {
                        e.preventDefault();
                        e.stopPropagation();
                        this.addToCart();
                    });

                    document.addEventListener('keydown', (e) => {
                        if (e.key === 'Escape' && document.getElementById('mealDetailModal').style.display === 'flex') {
                            this.closeModal();
                        }
                    });
                },

                addViewButtons: function () {
                    document.querySelectorAll('.menu-container').forEach((container) => {
                        const viewButton = container.querySelector('.view-btn');
                        const addButton = container.querySelector('.add-to-cart-btn-text');

                        if (viewButton && !viewButton.hasEventListener) {
                            viewButton.hasEventListener = true;
                            viewButton.addEventListener('click', (e) => {
                                e.preventDefault();
                                e.stopPropagation();
                                const mealName = e.target.closest('.view-btn').dataset.name;
                                this.openModal(mealName);
                            });
                        }

                        if (addButton && !addButton.hasEventListener) {
                            addButton.hasEventListener = true;
                            addButton.addEventListener('click', (e) => {
                                e.preventDefault();
                                e.stopPropagation();
                                const button = e.target.closest('.add-to-cart-btn-text');
                                const mealName = button.dataset.name;
                                const mealPrice = parseFloat(button.dataset.price);

                                const item = {
                                    id: `item-${mealName.toLowerCase().replace(/\s+/g, '-')}`,
                                    name: mealName,
                                    price: mealPrice,
                                    quantity: 1
                                };

                                cart.addItem(item);

                                if (cart.items.length === 1) {
                                    cart.openCart();
                                }
                            });
                        }
                    });
                },

                openModal: function (mealName) {
                    this.currentMeal = mealData[mealName];
                    if (!this.currentMeal) return;

                    const modal = document.getElementById('mealDetailModal');
                    const title = document.getElementById('mealModalTitle');
                    const body = document.getElementById('mealModalBody');

                    if (!modal || !title || !body) return;

                    title.innerHTML = `<i class="fas fa-utensils"></i> ${this.currentMeal.category}`;

                    let extrasHTML = '';
                    if (this.currentMeal.extras && this.currentMeal.extras.length > 0) {
                        extrasHTML = `
                            <div class="meal-extras">
                                <h4><i class="fas fa-plus-circle"></i> Serving Options:</h4>
                                <div class="meal-extra-options">
                                    ${this.currentMeal.extras.map((extra, index) => `
                                        <div class="meal-extra-option">
                                            <input type="checkbox" id="extra${index}" name="extra${index}" data-name="${extra.name}" data-price="${extra.price}" />
                                            <label for="extra${index}">${extra.name} (+₱${extra.price})</label>
                                        </div>
                                    `).join('')}
                                </div>
                            </div>
                        `;
                    }

                    body.innerHTML = `
                        <div class="meal-image-container">
                            <img src="${this.currentMeal.image}" alt="${mealName}" class="meal-featured-img" />
                        </div>
                        
                        <div class="meal-details">
                            <div class="meal-item-header">
                                <h3 class="meal-item-name">${mealName}</h3>
                                <div class="meal-item-price">₱${this.currentMeal.price.toFixed(2)}</div>
                            </div>
                            
                            <div class="meal-description">
                                <p>${this.currentMeal.description}</p>
                            </div>
                            
                            <div class="meal-ingredients">
                                <h4><i class="fas fa-list"></i> Ingredients:</h4>
                                <p>${this.currentMeal.ingredients}</p>
                            </div>
                            
                            <div class="meal-texture">
                                <h4><i class="fas fa-cookie-bite"></i> Texture:</h4>
                                <p>${this.currentMeal.texture}</p>
                            </div>
                            
                            ${extrasHTML}
                            
                            <div class="meal-additional-request">
                                <h4><i class="fas fa-comment-alt"></i> Additional Requests:</h4>
                                <textarea 
                                    class="additional-request-textarea" 
                                    placeholder="Any special requests or instructions for your order (e.g., less spicy, extra sauce, etc.)"
                                    rows="3"
                                ></textarea>
                            </div>
                        </div>
                    `;

                    document.querySelector('.meal-quantity-input').value = 1;
                    document.querySelectorAll('.meal-extra-option input[type="checkbox"]').forEach(checkbox => {
                        checkbox.checked = false;
                    });
                    document.querySelector('.additional-request-textarea').value = '';

                    this.updatePrice();

                    modal.style.display = 'flex';
                    document.body.style.overflow = 'hidden';
                },

                closeModal: function () {
                    const modal = document.getElementById('mealDetailModal');
                    if (modal) {
                        modal.style.display = 'none';
                        document.body.style.overflow = 'auto';
                        this.currentMeal = null;
                    }
                },

                updatePrice: function () {
                    if (!this.currentMeal) return;

                    const basePrice = this.currentMeal.price;
                    const quantity = parseInt(document.querySelector('.meal-quantity-input').value) || 1;
                    let extras = 0;
                    let extrasDescription = [];

                    document.querySelectorAll('.meal-extra-option input[type="checkbox"]:checked').forEach(checkbox => {
                        const extraPrice = parseFloat(checkbox.dataset.price);
                        extras += extraPrice;
                        extrasDescription.push(checkbox.dataset.name);
                    });

                    const totalPrice = (basePrice + extras) * quantity;
                    const addToCartBtn = document.getElementById('addToCartMealBtn');

                    if (addToCartBtn) {
                        addToCartBtn.innerHTML = `<i class="fas fa-cart-plus"></i> ₱${totalPrice.toFixed(2)}`;
                    }
                },

                addToCart: function () {
                    if (!this.currentMeal) return;

                    const mealName = Object.keys(mealData).find(key => mealData[key] === this.currentMeal);
                    const quantity = parseInt(document.querySelector('.meal-quantity-input').value) || 1;
                    const basePrice = this.currentMeal.price;
                    let extras = 0;
                    let extrasDescription = [];

                    document.querySelectorAll('.meal-extra-option input[type="checkbox"]:checked').forEach(checkbox => {
                        const extraPrice = parseFloat(checkbox.dataset.price);
                        extras += extraPrice;
                        extrasDescription.push(checkbox.dataset.name);
                    });

                    const additionalRequest = document.querySelector('.additional-request-textarea').value.trim();

                    let itemName = mealName;
                    if (extrasDescription.length > 0) {
                        itemName += ' (' + extrasDescription.join(', ') + ')';
                    }
                    if (additionalRequest) {
                        itemName += ' - Note: ' + additionalRequest;
                    }

                    const item = {
                        id: `item-${mealName.toLowerCase().replace(/\s+/g, '-')}-${Date.now()}`,
                        name: itemName,
                        price: basePrice + extras,
                        quantity: quantity
                    };

                    cart.addItem(item);
                    this.closeModal();

                    if (cart.items.length === 1) {
                        cart.openCart();
                    }
                }
            };

            const cart = {
                items: [],
                subtotal: 0,
                deliveryFee: 50,
                freeDeliveryThreshold: 500,

                init: function () {
                    this.loadFromStorage();
                    this.updateCartUI();
                    this.setupEventListeners();
                },

                loadFromStorage: function () {
                    const savedCart = localStorage.getItem('tastenetCart');
                    if (savedCart) {
                        const parsed = JSON.parse(savedCart);
                        this.items = parsed.items || [];
                        this.updateSubtotal();
                    }
                },

                saveToStorage: function () {
                    const cartData = {
                        items: this.items,
                        subtotal: this.subtotal
                    };
                    localStorage.setItem('tastenetCart', JSON.stringify(cartData));
                },

                addItem: function (item) {
                    const existingItem = this.items.find(i => i.id === item.id);

                    if (existingItem) {
                        existingItem.quantity += item.quantity;
                    } else {
                        this.items.push({
                            ...item
                        });
                    }

                    this.updateSubtotal();
                    this.saveToStorage();
                    this.updateCartUI();
                    this.showAddToCartAnimation(item);
                },

                removeItem: function (itemId) {
                    this.items = this.items.filter(item => item.id !== itemId);
                    this.updateSubtotal();
                    this.saveToStorage();
                    this.updateCartUI();
                },

                updateQuantity: function (itemId, newQuantity) {
                    if (newQuantity < 1) {
                        this.removeItem(itemId);
                        return;
                    }

                    const item = this.items.find(i => i.id === itemId);
                    if (item) {
                        item.quantity = newQuantity;
                        this.updateSubtotal();
                        this.saveToStorage();
                        this.updateCartUI();
                    }
                },

                clearCart: function () {
                    this.items = [];
                    this.updateSubtotal();
                    this.saveToStorage();
                    this.updateCartUI();
                },

                updateSubtotal: function () {
                    this.subtotal = this.items.reduce((total, item) => {
                        return total + (item.price * item.quantity);
                    }, 0);
                },

                getTotalItems: function () {
                    return this.items.reduce((total, item) => total + item.quantity, 0);
                },

                getDeliveryFee: function () {
                    return this.subtotal >= this.freeDeliveryThreshold ? 0 : this.deliveryFee;
                },

                getTotal: function () {
                    return this.subtotal + this.getDeliveryFee();
                },

                updateCartUI: function () {
                    const badge = document.getElementById('cartBadge');
                    if (badge) {
                        const totalItems = this.getTotalItems();
                        badge.textContent = totalItems;
                        badge.style.display = totalItems > 0 ? 'flex' : 'none';
                    }

                    this.updateCartModal();
                },

                updateCartModal: function () {
                    const cartItemsContainer = document.getElementById('cartItems');
                    const cartSubtotal = document.getElementById('cartSubtotal');
                    const deliveryFee = document.getElementById('deliveryFee');
                    const cartTotal = document.getElementById('cartTotal');
                    const checkoutBtn = document.getElementById('checkoutBtn');
                    const clearCartBtn = document.getElementById('clearCartBtn');

                    if (!cartItemsContainer) return;

                    if (cartSubtotal) cartSubtotal.textContent = `₱${this.subtotal.toFixed(2)}`;
                    if (deliveryFee) {
                        const fee = this.getDeliveryFee();
                        deliveryFee.textContent = fee === 0 ? 'FREE' : `₱${fee.toFixed(2)}`;
                        deliveryFee.style.color = fee === 0 ? 'green' : '';
                    }
                    if (cartTotal) cartTotal.textContent = `₱${this.getTotal().toFixed(2)}`;

                    if (checkoutBtn) {
                        checkoutBtn.disabled = this.items.length === 0;
                        checkoutBtn.innerHTML = `<i class="fas fa-shopping-bag"></i> Checkout - ₱${this.getTotal().toFixed(2)}`;
                    }

                    if (clearCartBtn) {
                        clearCartBtn.disabled = this.items.length === 0;
                    }

                    if (this.items.length === 0) {
                        cartItemsContainer.innerHTML = `
                    <div class="cart-empty-state">
                        <i class="fas fa-shopping-basket"></i>
                        <p>Your cart is empty</p>
                        <p class="cart-empty-subtitle">Add some delicious items to get started!</p>
                        <a href="#menu" class="btn-browse-menu">Browse Menu</a>
                    </div>
                `;

                        setTimeout(() => {
                            const browseBtn = document.querySelector('.btn-browse-menu');
                            if (browseBtn) {
                                browseBtn.addEventListener('click', (e) => {
                                    e.preventDefault();
                                    e.stopPropagation();
                                    this.closeCart();
                                    scrollToSection('menu');
                                });
                            }
                        }, 100);

                        return;
                    }

                    let itemsHTML = '';
                    this.items.forEach(item => {
                        itemsHTML += `
                    <div class="cart-item" data-id="${item.id}">
                        <div class="cart-item-header">
                            <div class="cart-item-name">${item.name}</div>
                            <div class="cart-item-price">₱${(item.price * item.quantity).toFixed(2)}</div>
                        </div>
                        <div class="cart-item-controls">
                            <div class="quantity-controls">
                                <button class="quantity-btn minus" data-id="${item.id}" type="button">-</button>
                                <span class="quantity-value">${item.quantity}</span>
                                <button class="quantity-btn plus" data-id="${item.id}" type="button">+</button>
                            </div>
                            <button class="remove-item-btn" data-id="${item.id}" type="button">
                                <i class="fas fa-trash"></i> Remove
                            </button>
                        </div>
                    </div>
                `;
                    });

                    cartItemsContainer.innerHTML = itemsHTML;

                    cartItemsContainer.querySelectorAll('.quantity-btn.minus').forEach(btn => {
                        btn.addEventListener('click', (e) => {
                            e.preventDefault();
                            e.stopPropagation();
                            const itemId = e.target.dataset.id;
                            const item = this.items.find(i => i.id === itemId);
                            if (item) {
                                this.updateQuantity(itemId, item.quantity - 1);
                            }
                        });
                    });

                    cartItemsContainer.querySelectorAll('.quantity-btn.plus').forEach(btn => {
                        btn.addEventListener('click', (e) => {
                            e.preventDefault();
                            e.stopPropagation();
                            const itemId = e.target.dataset.id;
                            const item = this.items.find(i => i.id === itemId);
                            if (item) {
                                this.updateQuantity(itemId, item.quantity + 1);
                            }
                        });
                    });

                    cartItemsContainer.querySelectorAll('.remove-item-btn').forEach(btn => {
                        btn.addEventListener('click', (e) => {
                            e.preventDefault();
                            e.stopPropagation();
                            const itemId = e.target.dataset.id;
                            this.removeItem(itemId);
                        });
                    });
                },

                showAddToCartAnimation: function (item) {
                    const animation = document.createElement('div');
                    animation.className = 'add-to-cart-animation';
                    animation.innerHTML = `<i class="fas fa-check"></i> Added ${item.name}`;

                    Object.assign(animation.style, {
                        position: 'fixed',
                        top: '100px',
                        right: '20px',
                        background: 'linear-gradient(135deg, var(--primary-maroon) 0%, #5a0819 100%)',
                        color: 'white',
                        padding: '15px 20px',
                        borderRadius: '10px',
                        boxShadow: '0 5px 20px rgba(0,0,0,0.3)',
                        zIndex: '3000',
                        display: 'flex',
                        alignItems: 'center',
                        gap: '10px',
                        border: '2px solid var(--accent-yellow)',
                        animation: 'slideInRight 0.3s ease, slideOutRight 0.3s ease 2s forwards'
                    });

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

                    document.body.appendChild(animation);

                    setTimeout(() => {
                        if (animation.parentNode) {
                            animation.parentNode.removeChild(animation);
                        }
                    }, 2500);
                },

                openCart: function () {
                    const modal = document.getElementById('cartModal');
                    if (modal) {
                        modal.style.display = 'block';
                        document.body.style.overflow = 'hidden';
                        this.updateCartModal();
                    }
                },

                closeCart: function () {
                    const modal = document.getElementById('cartModal');
                    if (modal) {
                        modal.style.display = 'none';
                        document.body.style.overflow = 'auto';
                    }
                },

                setupEventListeners: function () {
                    const cartIcon = document.getElementById('cartIcon');
                    if (cartIcon) {
                        cartIcon.addEventListener('click', (e) => {
                            e.preventDefault();
                            e.stopPropagation();
                            this.openCart();
                        });
                    }

                    const closeBtn = document.getElementById('cartCloseBtn');
                    if (closeBtn) {
                        closeBtn.addEventListener('click', (e) => {
                            e.preventDefault();
                            e.stopPropagation();
                            this.closeCart();
                        });
                    }

                    const overlay = document.getElementById('cartOverlay');
                    if (overlay) {
                        overlay.addEventListener('click', (e) => {
                            e.preventDefault();
                            e.stopPropagation();
                            this.closeCart();
                        });
                    }

                    const clearBtn = document.getElementById('clearCartBtn');
                    if (clearBtn) {
                        clearBtn.addEventListener('click', (e) => {
                            e.preventDefault();
                            e.stopPropagation();
                            if (this.items.length > 0 && confirm('Are you sure you want to clear your cart?')) {
                                this.clearCart();
                            }
                        });
                    }

                    const checkoutBtn = document.getElementById('checkoutBtn');
                    if (checkoutBtn) {
                        checkoutBtn.addEventListener('click', (e) => {
                            e.preventDefault();
                            e.stopPropagation();
                            if (this.items.length > 0) {
                                alert(`Order placed successfully!\nTotal: ₱${this.getTotal().toFixed(2)}\n\nThank you for your order!`);
                                this.clearCart();
                                this.closeCart();
                            }
                        });
                    }

                    document.addEventListener('keydown', (e) => {
                        if (e.key === 'Escape' && document.getElementById('cartModal').style.display === 'block') {
                            this.closeCart();
                        }
                    });
                }
            };

            // Back to Top Button Functionality
            const backToTopBtn = document.getElementById('backToTopBtn');

            window.addEventListener('scroll', function () {
                if (window.scrollY > 300) {
                    backToTopBtn.classList.add('visible');
                } else {
                    backToTopBtn.classList.remove('visible');
                }
            });

            function scrollToTop() {
                window.scrollTo({
                    top: 0,
                    behavior: 'smooth'
                });
            }

            document.querySelectorAll('.nav-link, .logo-container, .btn-menu, .footer-link[href^="#"]').forEach(link => {
                link.addEventListener('click', function (e) {
                    e.preventDefault();
                    e.stopPropagation();

                    const targetId = this.getAttribute('href');
                    if (targetId === '#') return;

                    const targetSection = document.querySelector(targetId);
                    if (targetSection) {
                        document.querySelectorAll('.nav-link').forEach(nav => nav.classList.remove('active'));
                        this.classList.add('active');

                        window.scrollTo({
                            top: targetSection.offsetTop - 80,
                            behavior: 'smooth'
                        });
                    }
                });
            });

            document.querySelector('.btn-search')?.addEventListener('click', function (e) {
                e.preventDefault();
                e.stopPropagation();
            });

            document.querySelectorAll('button:not([type="submit"])').forEach(button => {
                button.addEventListener('click', function (e) {
                    if (this.type !== 'submit') {
                        e.preventDefault();
                        e.stopPropagation();
                    }
                });
            });

            window.addEventListener('scroll', function () {
                const sections = document.querySelectorAll('section, .hero-container');
                const navLinks = document.querySelectorAll('.nav-link');

                let current = '';
                sections.forEach(section => {
                    const sectionTop = section.offsetTop;
                    const sectionHeight = section.clientHeight;
                    if (scrollY >= (sectionTop - 150)) {
                        current = section.getAttribute('id');
                    }
                });

                navLinks.forEach(link => {
                    link.classList.remove('active');
                    if (link.getAttribute('href') === `#${current}`) {
                        link.classList.add('active');
                    }
                });

                const fadeElements = document.querySelectorAll('.section-fade-in');
                fadeElements.forEach(element => {
                    const elementTop = element.getBoundingClientRect().top;
                    const elementVisible = 150;

                    if (elementTop < window.innerHeight - elementVisible) {
                        element.classList.add('visible');
                    }
                });
            });

            function scrollToSection(sectionId) {
                const section = document.getElementById(sectionId);
                if (section) {
                    window.scrollTo({
                        top: section.offsetTop - 80,
                        behavior: 'smooth'
                    });

                    document.querySelectorAll('.nav-link').forEach(nav => nav.classList.remove('active'));
                    const navLink = document.querySelector(`.nav-link[href="#${sectionId}"]`);
                    if (navLink) {
                        navLink.classList.add('active');
                    }
                }
            }

            document.addEventListener('DOMContentLoaded', function () {
                const fadeElements = document.querySelectorAll('.section-fade-in');
                fadeElements.forEach(element => {
                    const elementTop = element.getBoundingClientRect().top;
                    const elementVisible = 150;

                    if (elementTop < window.innerHeight - elementVisible) {
                        element.classList.add('visible');
                    }
                });

                cart.init();

                mealModal.init();
            });

            const navLinks = document.querySelectorAll('.nav-link');
            navLinks.forEach(link => {
                link.addEventListener('mouseenter', function () {
                    this.style.transform = 'translateY(-2px)';
                });

                link.addEventListener('mouseleave', function () {
                    this.style.transform = 'translateY(0)';
                });
            });

            const interactiveElements = document.querySelectorAll(
                'a, button, .logo-container, .nav-link, .btn-order, .btn-search, .btn-cta-large, .footer-link, .feature-card, .step-card, .menu-container, .content-box'
            );

            interactiveElements.forEach(el => {
                el.addEventListener('click', function (e) {
                    if (this.tagName === 'A' && this.getAttribute('href')?.startsWith('#')) {
                        return;
                    }

                    if (this.tagName === 'BUTTON' && this.type !== 'submit') {
                        e.preventDefault();
                        e.stopPropagation();
                    }

                    const ripple = document.createElement('span');
                    const rect = this.getBoundingClientRect();

                    ripple.style.position = 'absolute';
                    ripple.style.width = '20px';
                    ripple.style.height = '20px';
                    ripple.style.borderRadius = '50%';
                    ripple.style.background = 'rgba(255, 215, 0, 0.6)';
                    ripple.style.transform = 'translate(-50%, -50%)';
                    ripple.style.animation = 'ripple 0.6s linear';
                    ripple.style.pointerEvents = 'none';

                    ripple.style.left = (e.clientX - rect.left) + 'px';
                    ripple.style.top = (e.clientY - rect.top) + 'px';

                    this.style.position = 'relative';
                    this.style.overflow = 'hidden';
                    this.appendChild(ripple);

                    setTimeout(() => {
                        ripple.remove();
                    }, 600);
                });
            });

            const style = document.createElement('style');
            style.textContent = `
        @keyframes ripple {
            to {
                transform: translate(-50%, -50%) scale(10);
                opacity: 0;
            }
        }
    `;
            document.head.appendChild(style);
        </script>

    </form>
</body>
</html>