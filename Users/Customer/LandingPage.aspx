<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LandingPage.aspx.cs" Inherits="TasteNet.LandingPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>TasteNet | Sizzling Good Food Delivered Hot!</title>
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
    <style>
        :root {
            --primary-maroon: #7D0A22;
            --accent-yellow: #FFD700;
            --text-white: #FFFFFF;
            --glass-bg: rgba(0, 0, 0, 0.4);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Quicksand', sans-serif;
            overflow-x: hidden;
        }

        /* Hero Section with Background Overlay */
        .hero-container {
            position: relative;
            height: 100vh;
            width: 100%;
            background: linear-gradient(rgba(0,0,0,0.5), rgba(0,0,0,0.5)), 
                        url('https://i.imgur.com/your-image-here.jpg'); /* Replace with your image path */
            background-size: cover;
            background-position: center;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            color: var(--text-white);
            text-align: center;
            padding: 0 20px;
        }

        /* Navbar Overlay */
        .navbar {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 8%;
            background: linear-gradient(to bottom, rgba(0,0,0,0.7), transparent);
            z-index: 1000;
        }

        .logo-container {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .logo-img {
            height: 50px;
            width: 50px;
            border-radius: 50%;
        }

        .brand-name {
            font-size: 1.8rem;
            font-weight: 700;
            color: var(--accent-yellow);
        }

        .nav-links {
            display: flex;
            gap: 30px;
            list-style: none;
        }

        .nav-links a {
            text-decoration: none;
            color: var(--text-white);
            font-weight: 600;
            transition: 0.3s;
        }

        .nav-links a:hover {
            color: var(--accent-yellow);
        }

        .nav-icons {
            display: flex;
            gap: 20px;
            font-size: 1.2rem;
        }

        /* Hero Content */
        .hero-content h1 {
            font-size: 3.5rem;
            font-weight: 700;
            margin-bottom: 15px;
            text-shadow: 2px 2px 10px rgba(0,0,0,0.5);
        }

        .hero-content p {
            font-size: 1.2rem;
            max-width: 600px;
            margin: 0 auto 30px;
            line-height: 1.6;
            font-weight: 400;
        }

        /* Search Bar */
        .search-box {
            background: var(--text-white);
            border-radius: 50px;
            padding: 8px 10px 8px 25px;
            display: flex;
            align-items: center;
            width: 100%;
            max-width: 600px;
            margin-bottom: 30px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
        }

        .search-box i {
            color: var(--primary-maroon);
            font-size: 1.2rem;
            margin-right: 15px;
        }

        .search-input {
            border: none;
            outline: none;
            flex: 1;
            font-family: 'Quicksand', sans-serif;
            font-size: 1rem;
            color: #333;
        }

        .btn-search {
            background: var(--accent-yellow);
            border: none;
            padding: 12px 30px;
            border-radius: 50px;
            font-weight: 700;
            color: var(--primary-maroon);
            cursor: pointer;
            transition: 0.3s;
        }

        .btn-search:hover {
            background: #e6c200;
        }

        /* Action Buttons */
        .cta-group {
            display: flex;
            gap: 20px;
        }

        .btn-cta {
            padding: 15px 35px;
            border-radius: 10px;
            font-weight: 700;
            text-decoration: none;
            font-size: 1rem;
            transition: 0.3s;
        }

        .btn-order {
            background: var(--accent-yellow);
            color: var(--primary-maroon);
            border: 2px solid var(--accent-yellow);
        }

        .btn-menu {
            background: transparent;
            color: var(--accent-yellow);
            border: 2px solid var(--accent-yellow);
        }

        .btn-cta:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(255, 215, 0, 0.3);
        }

        .location-tag {
            position: absolute;
            bottom: 30px;
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 0.9rem;
            opacity: 0.9;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="hero-container">
            <nav class="navbar">
                <div class="logo-container">
                    <img src="https://via.placeholder.com/50" alt="Logo" class="logo-img" /> <span class="brand-name">TasteNet</span>
                </div>
                <ul class="nav-links">
                    <li><a href="#">Home</a></li>
                    <li><a href="#">About Us</a></li>
                    <li><a href="#">Menu</a></li>
                    <li><a href="#">Contact</a></li>
                </ul>
                <div class="nav-icons">
                    <a href="#" style="color:white;"><i class="fas fa-shopping-basket"></i></a>
                    <a href="#" style="color:white;"><i class="fas fa-user-circle"></i></a>
                </div>
            </nav>

            <div class="hero-content">
                <h1>Sizzling Good Food, Delivered Hot!</h1>
                <p>
                    Dasmariñas' Favorite Silog & Sizzling Meals<br />
                    <b>Lutong-Bahay Delivered to your Doorstep</b><br />
                    Authentic Filipino home-based meals from Dasmariñas City's finest kitchens
                </p>

                <div class="search-box">
                    <i class="fas fa-search"></i>
                    <input type="text" class="search-input" placeholder="Search for Tapsilog, Sisig, or your Favorite..." />
                    <button type="button" class="btn-search">Search</button>
                </div>

                <div class="cta-group">
                    <a href="#" class="btn-cta btn-order">Order Now!</a>
                    <a href="#" class="btn-cta btn-menu">Our Menu</a>
                </div>
            </div>

            <div class="location-tag">
                <i class="fas fa-map-marker-alt"></i>
                <span>Delivering in Dasmariñas City, Cavite</span>
            </div>
        </div>
    </form>
</body>
</html>