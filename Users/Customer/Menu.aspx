<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Menu.aspx.cs" Inherits="TasteNet.Users.Customer.Menu" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>TasteNet Menu</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
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
            --bg-cream: #fdf5e6;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Quicksand', sans-serif;
            background-color: var(--bg-cream);
            color: var(--text-dark);
            scroll-behavior: smooth;
            padding-top: 80px; /* Space for fixed navbar */
        }

        /* Navigation Bar - Copied from Landing Page */
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

        .nav-links a.active {
            color: var(--accent-yellow) !important;
            font-weight: 700;
        }

        .nav-links a.active:after {
            width: 80% !important;
            background: var(--accent-yellow);
        }

        /* Header & Search Section - Updated */
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px 30px;
        }

        .header {
            text-align: center;
            margin-bottom: 30px;
        }
        
        /* Our Menu Header with Hover Effects */
        .header h1 {
            color: var(--primary-maroon);
            font-size: 3.5rem;
            margin: 0;
            text-transform: uppercase;
            letter-spacing: 1px;
            position: relative;
            display: inline-block;
            padding-bottom: 15px;
            transition: all 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        }
        
        .header h1::after {
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
        
        .header h1:hover {
            color: #5a0819;
            transform: translateY(-3px);
            text-shadow: 0 3px 10px rgba(125, 10, 34, 0.2);
        }
        
        .header h1:hover::after {
            width: 100%;
            background: var(--accent-yellow);
            height: 6px;
            box-shadow: 0 4px 15px rgba(255, 215, 0, 0.3);
        }
        
        .header p { 
            font-size: 1.2rem; 
            color: var(--text-muted);
            margin-top: 15px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .header:hover p {
            color: var(--primary-maroon);
            transform: translateY(2px);
        }

        /* Search Bar with Icon - Updated */
        .search-container {
            display: flex;
            justify-content: center;
            margin: 30px auto 40px;
            max-width: 600px;
            position: relative;
        }
        
        .search-bar {
            width: 100%;
            padding: 15px 50px 15px 60px;
            border-radius: 50px;
            border: 2px solid transparent;
            outline: none;
            font-family: 'Quicksand', sans-serif;
            font-size: 1rem;
            background: white;
            box-shadow: 0 5px 20px rgba(125, 10, 34, 0.08);
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        }
        
        .search-bar:focus {
            border-color: var(--accent-yellow);
            box-shadow: 0 8px 30px rgba(125, 10, 34, 0.15);
            transform: translateY(-2px);
        }
        
        .search-bar::placeholder {
            color: #999;
            font-size: 0.95rem;
        }
        
        .search-icon {
            position: absolute;
            left: 25px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--primary-maroon);
            font-size: 1.2rem;
            z-index: 10;
            transition: all 0.3s ease;
        }
        
        .search-bar:focus + .search-icon {
            color: var(--accent-yellow);
            transform: translateY(-50%) scale(1.1);
        }

        /* Filter Chips - Enhanced */
        .filter-group {
            display: flex;
            gap: 15px;
            justify-content: center;
            margin-bottom: 40px;
            flex-wrap: wrap;
        }
        
        .filter-chip {
            padding: 12px 25px;
            border-radius: 30px;
            background: white;
            border: 2px solid var(--primary-maroon);
            color: var(--primary-maroon);
            cursor: pointer;
            font-weight: 700;
            font-size: 0.95em;
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            position: relative;
            overflow: hidden;
            z-index: 1;
        }
        
        .filter-chip:before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 215, 0, 0.2), transparent);
            transition: all 0.6s ease;
            z-index: -1;
        }
        
        .filter-chip:hover:before {
            left: 100%;
        }
        
        .filter-chip:hover {
            background: var(--primary-maroon);
            color: var(--accent-yellow);
            transform: translateY(-3px) scale(1.05);
            box-shadow: 0 10px 20px rgba(125, 10, 34, 0.2);
        }
        
        .filter-chip.active {
            background: var(--primary-maroon);
            color: var(--accent-yellow);
            box-shadow: 0 5px 15px rgba(125, 10, 34, 0.2);
            animation: pulse 2s infinite;
        }
        
        @keyframes pulse {
            0%, 100% {
                box-shadow: 0 5px 15px rgba(125, 10, 34, 0.2);
            }
            50% {
                box-shadow: 0 5px 20px rgba(125, 10, 34, 0.3), 0 0 0 5px rgba(255, 215, 0, 0.1);
            }
        }

        /* Category Headers - Enhanced */
        .category-header {
            display: flex;
            align-items: center;
            gap: 20px;
            margin: 60px 0 30px 0;
            padding: 20px;
            background: white;
            border-radius: 15px;
            border-left: 6px solid var(--accent-yellow);
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            transition: all 0.3s ease;
        }
        
        .category-header:hover {
            transform: translateX(10px);
            box-shadow: 0 10px 25px rgba(125, 10, 34, 0.1);
        }
        
        .category-header h2 {
            color: var(--primary-maroon);
            font-size: 2.2rem;
            margin: 0;
            position: relative;
        }
        
        .category-icon {
            width: 50px;
            height: 50px;
            background: linear-gradient(135deg, var(--primary-maroon) 0%, #5a0819 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--accent-yellow);
            font-size: 1.5rem;
            box-shadow: 0 5px 15px rgba(125, 10, 34, 0.15);
            transition: all 0.3s ease;
        }
        
        .category-header:hover .category-icon {
            transform: scale(1.1) rotate(10deg);
            box-shadow: 0 8px 20px rgba(125, 10, 34, 0.2);
        }

        /* Menu Grid - Enhanced */
        .menu-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 30px;
            margin-bottom: 60px;
        }

        /* Menu Card - Enhanced with Landing Page Effects */
        .menu-card {
            background: white;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(125, 10, 34, 0.08);
            display: flex;
            flex-direction: column;
            transition: all 0.5s cubic-bezier(0.25, 0.46, 0.45, 0.94);
            border: 2px solid transparent;
            position: relative;
            overflow: hidden;
            z-index: 1;
        }
        
        .menu-card:hover {
            transform: translateY(-10px) scale(1.02);
            border-color: var(--accent-yellow);
            box-shadow: 0 20px 50px rgba(125, 10, 34, 0.15);
        }
        
        .menu-card::before {
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
        
        .menu-card:hover::before {
            opacity: 1;
        }

        .item-image {
            width: 100%;
            height: 220px;
            background: linear-gradient(135deg, var(--primary-maroon) 0%, #5a0819 100%);
            object-fit: cover;
            transition: all 0.5s ease;
            position: relative;
        }
        
        .menu-card:hover .item-image {
            transform: scale(1.05);
            filter: brightness(1.1);
        }
        
        .item-image:after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(to bottom, rgba(0,0,0,0.1) 0%, rgba(0,0,0,0.3) 100%);
            opacity: 0;
            transition: opacity 0.5s ease;
        }
        
        .menu-card:hover .item-image:after {
            opacity: 1;
        }

        .card-content {
            padding: 25px;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
        }

        .item-title { 
            font-size: 1.5rem; 
            font-weight: 800; 
            color: var(--primary-maroon); 
            margin-bottom: 8px;
            transition: color 0.3s ease;
        }
        
        .menu-card:hover .item-title {
            color: #5a0819;
        }
        
        .rating-row { 
            color: var(--accent-yellow); 
            font-size: 0.9em; 
            margin-bottom: 10px; 
            font-weight: bold;
        }
        .rating-row span { 
            color: var(--text-muted); 
            font-weight: normal; 
        }
        
        .description {
            font-size: 0.95em;
            color: var(--text-muted);
            line-height: 1.6;
            margin-bottom: 20px;
            flex-grow: 1;
            transition: all 0.3s ease;
        }
        
        .menu-card:hover .description {
            transform: translateX(5px);
            color: var(--text-dark);
        }

        .price-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding: 15px;
            background: linear-gradient(90deg, rgba(255, 215, 0, 0.05), rgba(125, 10, 34, 0.05));
            border-radius: 10px;
            transition: all 0.3s ease;
        }
        
        .menu-card:hover .price-row {
            background: linear-gradient(90deg, rgba(255, 215, 0, 0.1), rgba(125, 10, 34, 0.1));
            transform: translateX(-5px);
        }
        
        .price { 
            font-size: 1.8rem; 
            font-weight: 900; 
            color: var(--primary-maroon); 
            text-shadow: 0 2px 5px rgba(125, 10, 34, 0.1);
            transition: all 0.3s ease;
        }
        
        .menu-card:hover .price {
            transform: scale(1.1);
            color: #5a0819;
            animation: pricePulse 0.8s ease;
        }
        
        @keyframes pricePulse {
            0%, 100% {
                transform: scale(1);
            }
            50% {
                transform: scale(1.15);
            }
        }
        
        .price-sub { 
            font-size: 0.9em; 
            text-align: center;
            color: var(--text-dark);
        }
        .price-sub span { 
            display: block; 
            font-weight: bold; 
            color: var(--primary-maroon);
            font-size: 1.2rem;
            transition: color 0.3s ease;
        }
        
        .menu-card:hover .price-sub span {
            color: #5a0819;
        }

        /* Buttons - Enhanced with Landing Page Effects */
        .btn-container {
            display: grid;
            grid-template-columns: 1fr 1.5fr;
            gap: 15px;
        }
        
        .btn {
            padding: 14px;
            border-radius: 12px;
            border: none;
            font-weight: 800;
            cursor: pointer;
            text-align: center;
            font-family: 'Quicksand', sans-serif;
            font-size: 1rem;
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            position: relative;
            overflow: hidden;
            z-index: 1;
        }
        
        .btn:before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: all 0.6s ease;
            z-index: -1;
        }
        
        .btn:hover:before {
            left: 100%;
        }
        
        .btn-carbs { 
            background: linear-gradient(135deg, var(--primary-maroon) 0%, #5a0819 100%);
            color: var(--accent-yellow); 
            border: 2px solid var(--primary-maroon);
        }
        
        .btn-carbs:hover {
            background: var(--accent-yellow);
            color: var(--primary-maroon);
            transform: translateY(-3px) scale(1.05);
            box-shadow: 0 10px 25px rgba(125, 10, 34, 0.25);
            border-color: var(--accent-yellow);
        }
        
        .btn-add { 
            background: linear-gradient(135deg, var(--accent-yellow) 0%, #ffed4e 100%);
            color: var(--primary-maroon); 
            border: 2px solid var(--accent-yellow);
            font-size: 1.1rem;
        }
        
        .btn-add:hover {
            background: var(--primary-maroon);
            color: var(--accent-yellow);
            transform: translateY(-3px) scale(1.05);
            box-shadow: 0 10px 25px rgba(125, 10, 34, 0.25);
            border-color: var(--primary-maroon);
            animation: pulseGlow 1.2s infinite;
        }
        
        @keyframes pulseGlow {
            0%, 100% {
                box-shadow: 0 10px 25px rgba(125, 10, 34, 0.25);
            }
            50% {
                box-shadow: 0 10px 25px rgba(125, 10, 34, 0.25), 0 0 15px rgba(255, 215, 0, 0.3);
            }
        }

        /* Responsive Design */
        @media (max-width: 992px) {
            .menu-grid {
                grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
                gap: 25px;
            }
            
            .header h1 {
                font-size: 2.8rem;
            }
            
            .category-header h2 {
                font-size: 1.8rem;
            }
        }

        @media (max-width: 768px) {
            .container {
                padding: 20px 15px;
            }
            
            .header h1 {
                font-size: 2.2rem;
            }
            
            .menu-grid {
                grid-template-columns: 1fr;
                gap: 20px;
            }
            
            .filter-group {
                gap: 10px;
            }
            
            .filter-chip {
                padding: 10px 20px;
                font-size: 0.85em;
            }
            
            .category-header {
                flex-direction: column;
                text-align: center;
                gap: 15px;
                padding: 20px 15px;
            }
            
            .btn-container {
                grid-template-columns: 1fr;
            }
            
            .nav-links {
                display: none; /* Consider adding mobile menu toggle */
            }
            
            .search-bar {
                padding: 12px 50px 12px 50px;
                font-size: 0.9rem;
            }
            
            .search-icon {
                left: 20px;
                font-size: 1.1rem;
            }
        }

        @media (max-width: 480px) {
            .header h1 {
                font-size: 1.8rem;
            }
            
            .search-bar {
                padding: 12px 45px 12px 45px;
                font-size: 0.85rem;
            }
            
            .search-icon {
                left: 15px;
                font-size: 1rem;
            }
            
            .card-content {
                padding: 20px;
            }
            
            .item-title {
                font-size: 1.3rem;
            }
            
            .price {
                font-size: 1.5rem;
            }
        }

        /* Section fade-in animation */
        .section-fade-in {
            opacity: 0;
            transform: translateY(30px);
            transition: opacity 0.8s ease, transform 0.8s ease;
        }

        .section-fade-in.visible {
            opacity: 1;
            transform: translateY(0);
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- Navigation Bar - Copied from Landing Page -->
        <nav class="navbar">
            <div class="logo-container" onclick="window.location.href='<%= ResolveUrl("~/LandingPage.aspx") %>'">
                <img src='<%= ResolveUrl("~/Images/LOGO.png") %>' alt="TasteNet Logo" class="logo-img" />
                <span class="brand-name">TasteNet</span>
            </div>
            <ul class="nav-links">
                <li><a href='<%= ResolveUrl("~/LandingPage.aspx#home") %>' class="nav-link">Home</a></li>
                <li><a href='<%= ResolveUrl("~/LandingPage.aspx#about") %>' class="nav-link">About Us</a></li>
                <li><a href="#menu" class="nav-link active">Menu</a></li>
                <li><a href='<%= ResolveUrl("~/LandingPage.aspx#contact") %>' class="nav-link">Contact</a></li>
            </ul>
            <div class="nav-icons">
                <a href="#" data-tooltip="Cart"><i class="fas fa-shopping-basket"></i></a>
                <a href="<%= ResolveUrl("~/Login.aspx") %>" data-tooltip="Account"><i class="fas fa-user-circle"></i></a>
            </div>
        </nav>

        <div class="container section-fade-in" id="menu">
            <div class="header">
                <h1>Our Menu</h1>
                <p>All your Filipino favorites delivered hot and fresh</p>
            </div>

            <div class="search-container">
                <i class="fas fa-search search-icon"></i>
                <input type="text" class="search-bar" placeholder="Search for Tapsilog, Sisig, or your Favorite..." />
            </div>

            <div class="filter-group">
                <button type="button" class="filter-chip active">All Items (18)</button>
                <button type="button" class="filter-chip">Sizzling Specials (2)</button>
                <button type="button" class="filter-chip">Silog Meals (9)</button>
                <button type="button" class="filter-chip">Special Meals (4)</button>
            </div>

            <div class="category-header">
                <div class="category-icon">🍳</div>
                <h2>Silog Meals</h2>
            </div>

            <div class="menu-grid">
                <div class="menu-card">
                    <img src="tapsilog.jpg" alt="Tapsilog" class="item-image" />
                    <div class="card-content">
                        <div class="item-title">Tapsilog</div>
                        <div class="rating-row">★★★★★ 4.9 <span>(96 Reviews)</span></div>
                        <p class="description">A classic Filipino favorite featuring savory, marinated beef tapa—tender and slightly sweet—served with garlic fried rice and a sunny-side-up egg.</p>
                        <div class="price-row">
                            <span class="price">₱120.00</span>
                        </div>
                        <div class="btn-container">
                            <asp:Button ID="btnV1" runat="server" Text="View Carbs" CssClass="btn btn-carbs" />
                            <asp:Button ID="btnAdd1" runat="server" Text="+ Add to cart" CssClass="btn btn-add" />
                        </div>
                    </div>
                </div>

                <div class="menu-card">
                    <img src="hotsilog.jpg" alt="Hotsilog" class="item-image" />
                    <div class="card-content">
                        <div class="item-title">Hotsilog</div>
                        <div class="rating-row">★★★★★ 4.8 <span>(132 Reviews)</span></div>
                        <p class="description">Classic Filipino-style hotdog, lightly sweet and smoky, pan-fried and served with garlic rice and a sunny-side-up egg.</p>
                        <div class="price-row">
                            <span class="price">₱65.00</span>
                        </div>
                        <div class="btn-container">
                            <asp:Button ID="btnV2" runat="server" Text="View Carbs" CssClass="btn btn-carbs" />
                            <asp:Button ID="btnAdd2" runat="server" Text="+ Add to cart" CssClass="btn btn-add" />
                        </div>
                    </div>
                </div>

                <div class="menu-card">
                    <img src="bangsilog.jpg" alt="Bangsilog" class="item-image" />
                    <div class="card-content">
                        <div class="item-title">Bangsilog</div>
                        <div class="rating-row">★★★★★ 4.8 <span>(132 Reviews)</span></div>
                        <p class="description">Crispy fried bangus (milkfish), seasoned and cooked to golden perfection, served with garlic fried rice and a sunny-side-up egg.</p>
                        <div class="price-row">
                            <span class="price">₱85.00</span>
                        </div>
                        <div class="btn-container">
                            <asp:Button ID="btnV3" runat="server" Text="View Carbs" CssClass="btn btn-carbs" />
                            <asp:Button ID="btnAdd3" runat="server" Text="+ Add to cart" CssClass="btn btn-add" />
                        </div>
                    </div>
                </div>
            </div>

            <div class="category-header">
                <div class="category-icon">🥘</div>
                <h2>Sizzling Specials</h2>
            </div>

            <div class="menu-grid">
                <div class="menu-card">
                    <img src="sisig.jpg" alt="Pork Sisig" class="item-image" />
                    <div class="card-content">
                        <div class="item-title">Sizzling Pork Sisig</div>
                        <div class="rating-row">★★★★★ 4.9 <span>(195 Reviews)</span></div>
                        <p class="description">Crispy, savory chopped pork face and ears seasoned with calamansi and chili. Served on a sizzling plate.</p>
                        <div class="price-row">
                            <div class="price-sub">Platter <span>₱155.00</span></div>
                            <div class="price-sub">Meal <span>₱120.00</span></div>
                        </div>
                        <div class="btn-container">
                            <asp:Button ID="btnV4" runat="server" Text="View Carbs" CssClass="btn btn-carbs" />
                            <asp:Button ID="btnAdd4" runat="server" Text="+ Add to cart" CssClass="btn btn-add" />
                        </div>
                    </div>
                </div>
            </div>

        </div>

        <script>
            // Section fade-in animation
            window.addEventListener('scroll', function () {
                const fadeElements = document.querySelectorAll('.section-fade-in');
                fadeElements.forEach(element => {
                    const elementTop = element.getBoundingClientRect().top;
                    const elementVisible = 150;

                    if (elementTop < window.innerHeight - elementVisible) {
                        element.classList.add('visible');
                    }
                });
            });

            // Initialize on load
            document.addEventListener('DOMContentLoaded', function () {
                const fadeElements = document.querySelectorAll('.section-fade-in');
                fadeElements.forEach(element => {
                    const elementTop = element.getBoundingClientRect().top;
                    const elementVisible = 150;

                    if (elementTop < window.innerHeight - elementVisible) {
                        element.classList.add('visible');
                    }
                });

                // Add ripple effect to buttons
                const buttons = document.querySelectorAll('.btn');
                buttons.forEach(btn => {
                    btn.addEventListener('click', function (e) {
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

                // Add ripple animation style
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
            });

            // Filter chip functionality
            document.querySelectorAll('.filter-chip').forEach(chip => {
                chip.addEventListener('click', function () {
                    document.querySelectorAll('.filter-chip').forEach(c => c.classList.remove('active'));
                    this.classList.add('active');
                });
            });

            // Active nav link
            const currentPage = window.location.pathname;
            if (currentPage.includes('Menu.aspx')) {
                document.querySelectorAll('.nav-link').forEach(link => {
                    link.classList.remove('active');
                    if (link.getAttribute('href') && link.getAttribute('href').includes('#menu')) {
                        link.classList.add('active');
                    }
                });
            }
        </script>

    </form>
</body>
</html>