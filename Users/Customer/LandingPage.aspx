<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LandingPage.aspx.cs" Inherits="TasteNet.LandingPage" %>

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
        .menu-container, .content-box, .view-all-menu-btn {
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
            padding: 80px 8% 60px;
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
            grid-template-columns: repeat(2, 1fr) !important;
            grid-template-rows: repeat(2, 1fr)!important;
            gap: 30px!important;
            margin-top: 40px!important;
            margin-left: auto!important;
            margin-right: auto!important;
        }

        .feature-card {
            background: white;
            border-radius: 15px;
            padding: 30px 20px;
            text-align: center;
            box-shadow: 0 8px 25px rgba(125, 10, 34, 0.08);
            transition: all 0.4s cubic-bezier(0.25, 0.46, 0.45, 0.94);
            border: 2px solid transparent;
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
            width: 70px;
            height: 70px;
            background: linear-gradient(135deg, var(--primary-maroon) 0%, #5a0819 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            color: var(--accent-yellow);
            font-size: 1.8rem;
            box-shadow: 0 6px 15px rgba(125, 10, 34, 0.15);
            transition: all 0.4s cubic-bezier(0.25, 0.46, 0.45, 0.94);
        }
        .feature-card:hover .feature-icon {
            transform: scale(1.08) rotate(5deg);
            box-shadow: 0 10px 20px rgba(125, 10, 34, 0.25);
        }

        .feature-title {
            font-size: 1.4rem;
            font-weight: 700;
            color: var(--primary-maroon);
            margin-bottom: 12px;
            transition: color 0.3s ease;
        }
        .feature-card:hover .feature-title {
            color: #5a0819;
        }

        .feature-description {
            font-size: 0.95rem;
            color: var(--text-muted);
            line-height: 1.5;
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
        
        .menu-grid-container {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 30px;
            margin: 0 5% 50px;
            width: 90%;
        }
        
        .menu-container {
            background: #fff;
            padding: 30px;
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
            width: 200px;
            height: 200px;
            border-radius: 50%;
            object-fit: cover;
            border: 8px solid var(--primary-maroon);
            margin-bottom: 25px;
            transition: all 0.8s cubic-bezier(0.25, 0.46, 0.45, 0.94);
            position: relative;
        }

        .menu-container:hover .menu-featured-img {
            transform: scale(1.05) rotate(3deg);
            border-color: var(--accent-yellow);
            box-shadow: 0 10px 25px rgba(125, 10, 34, 0.15);
        }

        .menu-featured-img:after {
            content: '';
            position: absolute;
            top: -10px;
            left: -10px;
            right: -10px;
            bottom: -10px;
            border-radius: 50%;
            background: radial-gradient(circle, rgba(255,215,0,0.2) 0%, transparent 70%);
            opacity: 0;
            transition: opacity 0.6s ease;
            z-index: -1;
        }

        .menu-container:hover .menu-featured-img:after {
            opacity: 0.8;
        }

        .menu-list-container { 
            width: 100%;
            text-align: center;
        }
        
        .category-label {
            color: var(--primary-maroon);
            font-size: 1.8rem;
            font-weight: 800;
            margin-bottom: 20px;
            transition: all 0.4s ease;
            position: relative;
            display: inline-block;
        }

        .category-label:after {
            content: '';
            position: absolute;
            bottom: -5px;
            left: 50%;
            width: 0;
            height: 3px;
            background: var(--accent-yellow);
            transform: translateX(-50%);
            transition: width 0.4s ease;
        }

        .menu-container:hover .category-label {
            color: #5a0819;
            transform: translateY(-1px);
        }

        .menu-container:hover .category-label:after {
            width: 100%;
        }
        
        .menu-item-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 12px;
            border-bottom: 2px solid #f0f0f0;
            padding-bottom: 8px;
            transition: all 0.4s ease;
            position: relative;
        }

        .menu-item-row:hover {
            transform: translateX(5px);
            border-bottom-color: var(--accent-yellow);
            padding-left: 5px;
            padding-right: 5px;
        }

        .menu-item-row:before {
            content: '';
            position: absolute;
            top: 0;
            left: -10px;
            right: -10px;
            bottom: 0;
            background: linear-gradient(90deg, 
                rgba(255, 215, 0, 0.1) 0%,
                transparent 100%);
            opacity: 0;
            transition: opacity 0.4s ease;
            border-radius: 5px;
            z-index: -1;
        }

        .menu-item-row:hover:before {
            opacity: 1;
        }
        
        .item-name {
            font-weight: 600;
            color: #333;
            font-size: 1rem;
            text-transform: uppercase;
            transition: all 0.4s ease;
            position: relative;
        }

        .menu-item-row:hover .item-name {
            color: var(--primary-maroon);
            font-weight: 700;
        }

        .menu-item-row:hover .item-name:before {
            content: '🍴';
            position: absolute;
            left: -25px;
            opacity: 0;
            animation: foodIconAppear 0.4s ease forwards;
        }

        @keyframes foodIconAppear {
            0% {
                opacity: 0;
                transform: translateX(-10px) rotate(-90deg);
            }
            100% {
                opacity: 1;
                transform: translateX(0) rotate(0deg);
            }
        }
        
        .item-price {
            font-weight: 700;
            color: var(--primary-maroon);
            font-size: 1rem;
            transition: all 0.4s ease;
            position: relative;
        }

        .menu-item-row:hover .item-price {
            color: var(--accent-yellow);
            transform: scale(1.1);
            text-shadow: 0 1px 5px rgba(255, 215, 0, 0.2);
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

        .view-all-menu-container {
            text-align: center;
            margin-top: 30px;
            margin-bottom: 0;
            padding-bottom: 0;
        }

        .view-all-menu-btn {
            display: inline-block;
            background: var(--primary-maroon);
            color: var(--accent-yellow);
            padding: 18px 50px;
            border-radius: 50px;
            font-size: 1.3rem;
            font-weight: 800;
            text-decoration: none;
            transition: all 0.6s cubic-bezier(0.25, 0.46, 0.45, 0.94);
            border: 2px solid var(--primary-maroon);
            margin: 0;
            position: relative;
            overflow: hidden;
            z-index: 1;
            box-shadow: 0 10px 25px rgba(125, 10, 34, 0.2);
        }

        .view-all-menu-btn:hover {
            background: var(--accent-yellow);
            color: var(--primary-maroon);
            transform: translateY(-5px) scale(1.05);
            box-shadow: 0 15px 30px rgba(125, 10, 34, 0.25);
            border-color: var(--accent-yellow);
            animation: pulseGlow 1.2s infinite;
        }

        .view-all-menu-btn:before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
            transition: all 0.8s ease;
            z-index: -1;
        }

        .view-all-menu-btn:hover:before {
            left: 100%;
        }

        .menu-display-section:after {
            content: '';
            display: block;
            height: 0;
            clear: both;
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

        @keyframes pulseGlow {
            0%, 100% {
                box-shadow: 0 15px 30px rgba(125, 10, 34, 0.25), 0 0 0 0 rgba(255, 215, 0, 0.4);
            }
            50% {
                box-shadow: 0 15px 30px rgba(125, 10, 34, 0.25), 0 0 10px 3px rgba(255, 215, 0, 0.2);
            }
        }
        
        @media (max-width: 1200px) {
            .features-grid {
                grid-template-columns: repeat(4, 1fr);
                gap: 15px;
            }
            .menu-grid-container {
                grid-template-columns: repeat(2, 1fr);
                gap: 25px;
            }
        }

        @media (max-width: 992px) {
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
            
            .menu-grid-container {
                grid-template-columns: 1fr;
                width: 90%;
                margin: 0 5% 50px;
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
                grid-template-columns: 1fr;
                gap: 20px;
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
                font-size: 1.2rem;
                color: var(--text-muted);
                margin-bottom: 40px;
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
            
            .menu-featured-img {
                width: 180px;
                height: 180px;
            }
            
            .menu-container {
                padding: 25px;
            }
            
            .view-all-menu-btn {
                padding: 15px 35px;
                font-size: 1.1rem;
            }
        }
        
        @media (max-width: 480px) {
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
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <nav class="navbar">
            <div class="logo-container" onclick="scrollToSection('home')">
                <img src='<%= ResolveUrl("~/Images/LOGO.png") %>' alt="TasteNet Logo" class="logo-img" />
                <span class="brand-name">TasteNet</span>
            </div>
            <ul class="nav-links">
                <li><a href="#home" class="nav-link active">Home</a></li>
                <li><a href="#about" class="nav-link">About Us</a></li>
                <li><a href="#menu" class="nav-link">Menu</a></li>
                <li><a href="#contact" class="nav-link">Contact</a></li>
            </ul>
            <div class="nav-icons">
                <a href="#" data-tooltip="Cart"><i class="fas fa-shopping-basket"></i></a>
                <a href="<%= ResolveUrl("~/Login.aspx") %>" data-tooltip="Account"><i class="fas fa-user-circle"></i></a>
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
                <h2 class="about-title">ABOUT CABALLEROS</h2>
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
            <h2 class="menu-header">DISCOVER MENU</h2>
            
            <div class="menu-grid-container">
                <div class="menu-container">
                    <img src='<%= ResolveUrl("~/Images/Hotsilog.jpg") %>' alt="Featured Silog Meal" class="menu-featured-img" />
                    <div class="menu-list-container">
                        <div class="category-label">Silog Meals</div>
                        <div class="menu-item-row"><span class="item-name">Tapsilog</span><span class="item-price">₱100.00</span></div>
                        <div class="menu-item-row"><span class="item-name">Baconsilog</span><span class="item-price">₱75.00</span></div>
                        <div class="menu-item-row"><span class="item-name">Bangsilog (Boneless)</span><span class="item-price">₱85.00</span></div>
                        <div class="menu-item-row"><span class="item-name">Hamsilog</span><span class="item-price">₱55.00</span></div>
                        <div class="menu-item-row"><span class="item-name">Hotsilog (Purefoods)</span><span class="item-price">₱55.00</span></div>
                        <div class="menu-item-row"><span class="item-name">Longsilog</span><span class="item-price">₱85.00</span></div>
                        <div class="menu-item-row"><span class="item-name">Malingsilog</span><span class="item-price">₱60.00</span></div>
                        <div class="menu-item-row"><span class="item-name">Porksilog</span><span class="item-price">₱85.00</span></div>
                        <div class="menu-item-row"><span class="item-name">Tocilog</span><span class="item-price">₱80.00</span></div>
                    </div>
                </div>
                
                <div class="menu-container">
                    <img src='<%= ResolveUrl("~/Images/Sisig.jpg") %>' alt="Featured Sizzling Meal" class="menu-featured-img" />
                    <div class="menu-list-container">
                        <div class="category-label">Sizzling Meals</div>
                        <div class="menu-item-row"><span class="item-name">Sizzling Sisig</span><span class="item-price">₱150.00</span></div>
                        <div class="menu-item-row"><span class="item-name">Sizzling Pork Steak</span><span class="item-price">₱140.00</span></div>
                        <div class="menu-item-row"><span class="item-name">Sizzling Chicken</span><span class="item-price">₱130.00</span></div>
                        <div class="menu-item-row"><span class="item-name">Sizzling Tofu</span><span class="item-price">₱120.00</span></div>
                        <div class="menu-item-row"><span class="item-name">Sizzling Bangus</span><span class="item-price">₱145.00</span></div>
                        <div class="menu-item-row"><span class="item-name">Sizzling Liempo</span><span class="item-price">₱155.00</span></div>
                        <div class="menu-item-row"><span class="item-name">Sizzling Mix Platter</span><span class="item-price">₱180.00</span></div>
                        <div class="menu-item-row"><span class="item-name">Sizzling Gambas</span><span class="item-price">₱160.00</span></div>
                        <div class="menu-item-row"><span class="item-name">Sizzling Kangkong</span><span class="item-price">₱110.00</span></div>
                    </div>
                </div>
                
                <div class="menu-container">
                    <img src='<%= ResolveUrl("~/Images/Goto.jpg") %>' alt="Featured Special Meal" class="menu-featured-img" />
                    <div class="menu-list-container">
                        <div class="category-label">Special Meals</div>
                        <div class="menu-item-row"><span class="item-name">Special Goto</span><span class="item-price">₱120.00</span></div>
                        <div class="menu-item-row"><span class="item-name">Special Lugaw</span><span class="item-price">₱100.00</span></div>
                        <div class="menu-item-row"><span class="item-name">Special Arroz Caldo</span><span class="item-price">₱110.00</span></div>
                        <div class="menu-item-row"><span class="item-name">Special Bulalo</span><span class="item-price">₱250.00</span></div>
                        <div class="menu-item-row"><span class="item-name">Special Kare-Kare</span><span class="item-price">₱220.00</span></div>
                        <div class="menu-item-row"><span class="item-name">Special Sinigang</span><span class="item-price">₱180.00</span></div>
                        <div class="menu-item-row"><span class="item-name">Special Adobo</span><span class="item-price">₱160.00</span></div>
                        <div class="menu-item-row"><span class="item-name">Special Caldereta</span><span class="item-price">₱190.00</span></div>
                        <div class="menu-item-row"><span class="item-name">Special Bicol Express</span><span class="item-price">₱170.00</span></div>
                    </div>
                </div>
            </div>
            
            <div class="view-all-menu-container">
                <a href="<%= ResolveUrl("~/Users/Customer/Menu.aspx") %>" class="view-all-menu-btn">
                    <span>View All Menu</span>
                </a>
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
                        <p><i class="fas fa-phone"></i> Call us for orders or inquiries:</p>
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
                                src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3863.2589348285697!2d120.9394618!3d14.4652547!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3397cd96b0e4a3cb%3A0x43cbd8b1bd78e1f5!2sBlk%2084%2C%20lot%2010%20Bautista%20St%2C%20zone%209%2C%20Dasmari%C3%B1as%2C%204114%20Cavite!5e0!3m2!1sen!2sph!4v1648123456789!5m2!1sen!2sph" 
                                width="100%" 
                                height="100%" 
                                style="border:0;" 
                                allowfullscreen="" 
                                loading="lazy" 
                                referrerpolicy="no-referrer-when-downgrade"
                                title="TasteNet Location - Blk 84, Lot 10 Bautista St, Zone 9, Dasmariñas, Cavite">
                            </iframe>
                        </div>
                    </div>
                    
                    <div class="contact-info-sidebar">
                        <div class="contact-info-group">
                            <h3><i class="fas fa-phone"></i> Contact Numbers</h3>
                            <div class="contact-details-large">
                                <p>For inquiries and orders:</p>
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
            document.querySelectorAll('.nav-link, .logo-container, .btn-menu, .footer-link[href^="#"]').forEach(link => {
                link.addEventListener('click', function (e) {
                    e.preventDefault();

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
                    document.querySelector(`.nav-link[href="#${sectionId}"]`).classList.add('active');
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
                'a, button, .logo-container, .nav-link, .btn-order, .btn-search, .btn-cta-large, .footer-link, .feature-card, .step-card, .menu-container, .content-box, .view-all-menu-btn'
            );

            interactiveElements.forEach(el => {
                el.addEventListener('click', function (e) {
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

            const viewAllBtn = document.querySelector('.view-all-menu-btn');
            if (viewAllBtn) {
                viewAllBtn.addEventListener('mouseenter', function () {
                    this.style.animation = 'pulseGlow 1.2s infinite';
                });

                viewAllBtn.addEventListener('mouseleave', function () {
                    this.style.animation = 'pulseGlow 2s infinite';
                });
            }

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