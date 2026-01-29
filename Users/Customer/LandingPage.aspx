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
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Quicksand', sans-serif;
            overflow-x: hidden;
            height: 100%;
        }

        html {
            height: 100%;
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

        .navbar {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 8%;
            background: linear-gradient(to bottom, rgba(0,0,0,0.8) 0%, rgba(0,0,0,0.5) 50%, transparent 100%);
            z-index: 1000;
            backdrop-filter: blur(5px);
        }

        .logo-container { 
            display: flex; 
            align-items: center; 
            gap: 10px; 
            transition: transform 0.3s ease;
        }
        .logo-container:hover {
            transform: scale(1.05);
        }
        .logo-img { 
            height: 50px; 
            width: 50px; 
            border-radius: 50%; 
            object-fit: cover; 
            transition: transform 0.3s ease;
        }
        .logo-container:hover .logo-img {
            transform: rotate(10deg);
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
            gap: 30px; 
            list-style: none; 
            margin-left: auto; 
            margin-right: 30px; 
        }
        .nav-links a { 
            text-decoration: none; 
            color: var(--text-white); 
            font-weight: 600; 
            font-size: 1.1rem; 
            transition: all 0.3s ease; 
            padding: 8px 12px; 
            border-radius: 5px;
            position: relative;
        }
        .nav-links a:hover { 
            color: var(--accent-yellow); 
            background: rgba(255, 215, 0, 0.1);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }
        .nav-links a:after {
            content: '';
            position: absolute;
            width: 0;
            height: 2px;
            bottom: 0;
            left: 50%;
            background: var(--accent-yellow);
            transition: all 0.3s ease;
            transform: translateX(-50%);
        }
        .nav-links a:hover:after {
            width: 80%;
        }

        .nav-icons { 
            display: flex; 
            gap: 20px; 
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

        .cta-group { display: flex; gap: 20px; justify-content: center; }
        .btn-cta { 
            padding: 15px 35px; 
            border-radius: 10px; 
            font-weight: 700; 
            text-decoration: none; 
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275); 
            flex: 1; 
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
        .btn-menu { 
            border: 2px solid var(--accent-yellow); 
            color: var(--accent-yellow); 
            background: transparent;
        }
        .btn-menu:hover { 
            background: var(--accent-yellow); 
            color: var(--primary-maroon); 
            transform: translateY(-5px) scale(1.05);
            box-shadow: 0 15px 25px rgba(0,0,0,0.3);
        }

        .about-section {
            background: #FFFFFF; 
            padding: 100px 8%;
        }

        .about-container {
            max-width: 1200px;
            margin: 0 auto;
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
        }

        .about-tagline {
            font-size: 1.4rem;
            margin-bottom: 60px;
            color: var(--text-dark); 
            line-height: 1.5;
            max-width: 800px;
            font-weight: 600;
        }

        .content-box {
            width: 100%;
            background: linear-gradient(135deg, #fdfaf5 0%, #fff9f0 100%);
            border-radius: 15px;
            padding: 40px 50px;
            border-left: 8px solid var(--accent-yellow);
            box-shadow: 0 10px 30px rgba(0,0,0,0.08);
            transition: all 0.3s ease;
            margin: 0 auto;
            max-width: 900px;
        }

        .content-box:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 40px rgba(0,0,0,0.12);
            border-left: 8px solid var(--primary-maroon);
        }

        .content-text {
            font-size: 1.2rem;
            color: var(--text-dark);
            line-height: 1.8;
            text-align: justify;
        }

        .content-text p {
            margin-bottom: 20px;
        }

        .content-text p:last-child {
            margin-bottom: 0;
        }

        .love-us-section {
            background: linear-gradient(135deg, #fdfaf5 0%, #fff9f0 100%);
            padding: 100px 8%;
            position: relative;
        }

        .love-us-container {
            max-width: 1200px;
            margin: 0 auto;
            text-align: center;
        }

        .love-us-title {
            font-size: 3rem;
            font-weight: 800;
            color: var(--primary-maroon);
            margin-bottom: 20px;
            text-transform: uppercase;
            position: relative;
            display: inline-block;
        }

        .love-us-title::after {
            content: '';
            display: block;
            width: 80px;
            height: 4px;
            background: var(--accent-yellow);
            margin: 15px auto 30px;
        }

        .love-us-tagline {
            font-size: 1.4rem;
            color: var(--text-dark);
            margin-bottom: 60px;
            max-width: 800px;
            margin-left: auto;
            margin-right: auto;
            line-height: 1.6;
            font-weight: 600;
        }

        .features-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            grid-template-rows: repeat(2, 1fr);
            gap: 30px;
            margin-top: 40px;
            max-width: 1000px;
            margin-left: auto;
            margin-right: auto;
        }

        .feature-card {
            background: white;
            border-radius: 20px;
            padding: 35px 25px;
            text-align: center;
            box-shadow: 0 10px 30px rgba(125, 10, 34, 0.08);
            transition: all 0.3s ease;
            border: 2px solid transparent;
            height: 100%;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }

        .feature-card:hover {
            transform: translateY(-10px);
            border-color: var(--accent-yellow);
            box-shadow: 0 15px 40px rgba(125, 10, 34, 0.15);
        }

        .feature-icon {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, var(--primary-maroon) 0%, #5a0819 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 25px;
            color: var(--accent-yellow);
            font-size: 2rem;
            box-shadow: 0 8px 20px rgba(125, 10, 34, 0.2);
            transition: all 0.3s ease;
        }
        .feature-card:hover .feature-icon {
            transform: scale(1.1) rotate(5deg);
            box-shadow: 0 12px 25px rgba(125, 10, 34, 0.3);
        }

        .feature-title {
            font-size: 1.8rem;
            font-weight: 700;
            color: var(--primary-maroon);
            margin-bottom: 15px;
            transition: color 0.3s ease;
        }
        .feature-card:hover .feature-title {
            color: #5a0819;
        }

        .feature-description {
            font-size: 1.1rem;
            color: var(--text-muted);
            line-height: 1.6;
            padding: 0 10px;
        }

        .menu-display-section {
            padding: 80px 8%;
            background-color: #fdfaf5;
            text-align: center;
        }
        .menu-header {
            font-size: 3rem;
            font-weight: 800;
            margin-bottom: 50px;
            color: #000;
            text-transform: uppercase;
        }
        .menu-header::after {
            content: '';
            display: block;
            width: 100px;
            height: 5px;
            background: var(--primary-maroon);
            margin: 15px auto;
        }
        .menu-container {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 60px;
            max-width: 1100px;
            margin: 0 auto;
            background: #fff;
            padding: 50px;
            border-radius: 30px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.05);
            transition: all 0.3s ease;
            margin-bottom: 50px;
        }
        .menu-container:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
        }
        .menu-featured-img {
            width: 350px;
            height: 350px;
            border-radius: 50%;
            object-fit: cover;
            border: 10px solid var(--primary-maroon);
            transition: all 0.5s ease;
        }
        .menu-container:hover .menu-featured-img {
            transform: scale(1.03) rotate(2deg);
            border-color: var(--accent-yellow);
        }
        .menu-list-container { flex: 1; text-align: left; }
        .category-label { 
            color: #f2a900; 
            font-size: 2rem; 
            font-weight: 800; 
            margin-bottom: 25px; 
            transition: color 0.3s ease;
        }
        .menu-container:hover .category-label {
            color: var(--primary-maroon);
        }
        .menu-item-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
            border-bottom: 2px dotted #ddd;
            padding-bottom: 5px;
            transition: all 0.3s ease;
        }
        .menu-item-row:hover {
            transform: translateX(5px);
            border-bottom-color: var(--accent-yellow);
        }
        .item-name { 
            font-weight: 700; 
            color: #333; 
            font-size: 1.1rem; 
            text-transform: uppercase; 
            transition: color 0.3s ease;
        }
        .menu-item-row:hover .item-name {
            color: var(--primary-maroon);
        }
        .item-price { 
            font-weight: 800; 
            color: var(--primary-maroon); 
            font-size: 1.1rem; 
            transition: all 0.3s ease;
        }
        .menu-item-row:hover .item-price {
            color: var(--accent-yellow);
            transform: scale(1.1);
        }

        .order-steps-section {
            padding: 100px 8%;
            background: linear-gradient(135deg, #fdfaf5 0%, #fff9f0 100%);
            text-align: center;
            position: relative;
        }

        .steps-container {
            max-width: 1200px;
            margin: 0 auto;
        }

        .steps-header {
            font-size: 3rem;
            font-weight: 800;
            color: var(--primary-maroon);
            margin-bottom: 20px;
            text-transform: uppercase;
            position: relative;
            display: inline-block;
        }

        .steps-header::after {
            content: '';
            display: block;
            width: 80px;
            height: 4px;
            background: var(--accent-yellow);
            margin: 15px auto 40px;
        }

        .steps-grid {
            display: flex;
            justify-content: space-between;
            gap: 30px;
            max-width: 1200px;
            margin: 0 auto 60px;
            flex-wrap: wrap;
            position: relative;
        }

        .step-card {
            flex: 1;
            min-width: 300px;
            max-width: 350px;
            background: white;
            border-radius: 20px;
            padding: 40px 30px;
            text-align: center;
            box-shadow: 0 10px 30px rgba(125, 10, 34, 0.08);
            transition: all 0.3s ease;
            border: 2px solid transparent;
            position: relative;
            overflow: hidden;
            z-index: 1;
        }

        .step-card:hover {
            transform: translateY(-10px);
            border-color: var(--accent-yellow);
            box-shadow: 0 15px 40px rgba(125, 10, 34, 0.15);
        }

        .step-number {
            font-size: 4rem;
            font-weight: 800;
            color: var(--accent-yellow);
            margin-bottom: 20px;
            position: relative;
            display: inline-block;
        }

        .step-number::after {
            content: '';
            position: absolute;
            width: 60px;
            height: 60px;
            background: rgba(125, 10, 34, 0.1);
            border-radius: 50%;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            z-index: -1;
        }

        .step-title {
            font-size: 1.8rem;
            font-weight: 700;
            color: var(--primary-maroon);
            margin-bottom: 15px;
            transition: color 0.3s ease;
        }

        .step-card:hover .step-title {
            color: #5a0819;
        }

        .step-description {
            font-size: 1.1rem;
            color: var(--text-muted);
            line-height: 1.6;
        }

        .steps-grid::before {
            content: '';
            position: absolute;
            top: 200px;
            left: 50%;
            transform: translateX(-50%);
            width: 70%;
            height: 2px;
            background: linear-gradient(to right, transparent, var(--accent-yellow), transparent);
            z-index: 0;
        }

        .cta-banner {
            background: linear-gradient(135deg, var(--primary-maroon) 0%, #5a0819 100%);
            border-radius: 20px;
            padding: 60px 40px;
            max-width: 1200px;
            margin: 0 auto;
            color: var(--text-white);
            text-align: center;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            transition: all 0.3s ease;
        }

        .cta-banner:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.3);
        }

        .cta-title {
            font-size: 2.5rem;
            font-weight: 800;
            margin-bottom: 15px;
            color: var(--accent-yellow);
        }

        .cta-subtitle {
            font-size: 1.3rem;
            margin-bottom: 30px;
            opacity: 0.9;
        }

        .btn-cta-large {
            display: inline-block;
            background: var(--accent-yellow);
            color: var(--primary-maroon);
            padding: 18px 50px;
            border-radius: 50px;
            font-size: 1.3rem;
            font-weight: 800;
            text-decoration: none;
            transition: all 0.3s;
            border: 2px solid var(--accent-yellow);
            position: relative;
            overflow: hidden;
            z-index: 1;
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
            margin-top: 40px;
            font-size: 1.2rem;
            color: rgba(255,255,255,0.9);
        }

        .contact-info i {
            margin-right: 10px;
            color: var(--accent-yellow);
        }

        .phone-numbers {
            margin-top: 10px;
            font-size: 1.3rem;
            font-weight: 600;
            color: var(--accent-yellow);
        }

        .divider {
            width: 90%;
            height: 2px;
            background: linear-gradient(to right, transparent, var(--accent-yellow), transparent);
            margin: 60px auto;
        }

        .contact-map-section {
            background: var(--primary-maroon);
            color: var(--text-white);
            padding: 80px 8% 40px;
        }

        .contact-map-container {
            max-width: 1200px;
            margin: 0 auto;
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
            padding: 50px 8%;
        }

        .footer-container {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            flex-wrap: wrap;
            gap: 40px;
        }

        .footer-logo-section {
            flex: 1;
            min-width: 250px;
        }

        .footer-logo-container {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 20px;
            transition: transform 0.3s ease;
        }
        .footer-logo-container:hover {
            transform: scale(1.05);
        }

        .footer-logo {
            height: 70px;
            width: 70px;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid var(--accent-yellow);
            transition: all 0.3s ease;
        }
        .footer-logo-container:hover .footer-logo {
            transform: rotate(10deg);
            border-color: #ffed4e;
        }

        .footer-brand-name {
            font-size: 2rem;
            font-weight: 800;
            color: var(--accent-yellow);
            transition: all 0.3s ease;
        }
        .footer-logo-container:hover .footer-brand-name {
            color: #ffed4e;
            text-shadow: 0 0 10px rgba(255, 237, 78, 0.5);
        }

        .footer-tagline {
            font-size: 1.1rem;
            opacity: 0.9;
            margin-top: 10px;
            max-width: 300px;
            line-height: 1.5;
            transition: opacity 0.3s ease;
        }
        .footer-logo-section:hover .footer-tagline {
            opacity: 1;
        }

        .footer-quick-links {
            flex: 2;
            min-width: 300px;
        }

        .footer-quick-links h3 {
            color: var(--accent-yellow);
            font-size: 1.5rem;
            margin-bottom: 25px;
            text-transform: uppercase;
            padding-bottom: 10px;
            border-bottom: 2px solid rgba(255, 215, 0, 0.3);
            transition: all 0.3s ease;
        }
        .footer-quick-links:hover h3 {
            color: #ffed4e;
            border-bottom-color: rgba(255, 237, 78, 0.5);
        }

        .quick-links-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 15px;
        }

        .footer-link {
            color: var(--text-white);
            text-decoration: none;
            font-size: 1.1rem;
            transition: all 0.3s;
            padding: 8px 0;
            display: block;
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
            padding: 20px 8%;
            text-align: center;
            color: rgba(255, 255, 255, 0.7);
            font-size: 0.9rem;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            margin-top: 40px;
        }

        .footer-bottom-content {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 20px;
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
            gap: 10px;
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
            margin-left: 15px;
            transition: all 0.3s ease;
        }

        .footer-legal a:hover {
            opacity: 0.8;
            text-decoration: underline;
            color: #ffed4e;
        }

        .security-notice {
            position: fixed;
            top: 80px;
            right: 20px;
            background: rgba(0,0,0,0.7);
            color: #ffccbc;
            padding: 5px 10px;
            border-radius: 5px;
            font-size: 12px;
            z-index: 1001;
            transition: all 0.3s ease;
        }
        .security-notice:hover {
            background: rgba(0,0,0,0.9);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.3);
        }

        @media (max-width: 992px) {
            .steps-grid {
                justify-content: center;
                gap: 30px;
            }
            
            .steps-grid::before {
                display: none;
            }
            
            .step-card {
                max-width: 450px;
            }
            
            .menu-container { flex-direction: column; text-align: center; }
            .menu-list-container { width: 100%; }
            .contact-content {
                flex-direction: column;
                text-align: center;
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
            .order-steps-section {
                padding: 60px 5%;
            }
            
            .steps-header {
                font-size: 2.2rem;
            }
            
            .step-card {
                min-width: 100%;
                padding: 30px 20px;
            }
            
            .cta-banner {
                border-radius: 15px;
                padding: 40px 20px;
            }
            
            .cta-title {
                font-size: 2rem;
            }
            
            .step-number {
                font-size: 3.5rem;
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
            .about-title { font-size: 2.2rem; }
            .hero-content h1 { font-size: 2.5rem; }
            .love-us-title { font-size: 2.2rem; }
            .love-us-tagline { font-size: 1.2rem; }
            .feature-card { padding: 30px 20px; }
            .contact-header { font-size: 2.2rem; }
            .contact-subtitle { font-size: 1.5rem; }
            .contact-details { font-size: 1.1rem; }
            .map-wrapper { height: 300px; }
            .map-placeholder i { font-size: 3rem; }
            .map-placeholder h3 { font-size: 1.5rem; }
            .security-notice {
                top: 70px;
                right: 10px;
                font-size: 10px;
            }
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
                grid-template-columns: 1fr;
                grid-template-rows: auto;
                gap: 25px;
            }
            
            .menu-featured-img {
                width: 280px;
                height: 280px;
            }
            
            .menu-container {
                padding: 30px;
                gap: 40px;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="security-notice">
            Not secure | https://localhost:44348/Users/Customer/LandingPage
        </div>

        <nav class="navbar">
            <div class="logo-container">
                <img src='<%= ResolveUrl("~/Images/LOGO.png") %>' alt="TasteNet Logo" class="logo-img" />
                <span class="brand-name">TasteNet</span>
            </div>
            <ul class="nav-links">
                <li><a href="#">Home</a></li>
                <li><a href="#">About Us</a></li>
                <li><a href="#">Menu</a></li>
                <li><a href="#">Contact</a></li>
            </ul>
            <div class="nav-icons">
                <a href="#" data-tooltip="Cart"><i class="fas fa-shopping-basket"></i></a>
                <a href="#" data-tooltip="Account"><i class="fas fa-user-circle"></i></a>
            </div>
        </nav>

        <div class="hero-container">
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
                    <a href="#" class="btn-cta btn-order">Order Now!</a>
                    <a href="#" class="btn-cta btn-menu">Our Menu</a>
                </div>
            </div>
        </div>

        <section class="about-section">
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

        <section class="menu-display-section">
            <h2 class="menu-header">Discover Menu</h2>
            
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
        </section>

        <section class="order-steps-section">
            <div class="steps-container">
                <h2 class="steps-header">Order in 3 Easy Steps</h2>
                
                <div class="steps-grid">
                    <div class="step-card">
                        <div class="step-number">01</div>
                        <h3 class="step-title">Browse & Select</h3>
                        <p class="step-description">
                            Choose from our sizzling specials and silog meals. Explore our full menu and find your favorites.
                        </p>
                    </div>
                    
                    <div class="step-card">
                        <div class="step-number">02</div>
                        <h3 class="step-title">Customize & Order</h3>
                        <p class="step-description">
                            Add to cart and place your order online. Customize your meal with extra toppings or special requests.
                        </p>
                    </div>
                    
                    <div class="step-card">
                        <div class="step-number">03</div>
                        <h3 class="step-title">We Deliver Hot!</h3>
                        <p class="step-description">
                            We deliver with our trusted rider straight to your door. Hot and fresh, just like home cooking.
                        </p>
                    </div>
                </div>
                
                <div class="divider"></div>
                
                <div class="cta-banner">
                    <h3 class="cta-title">Hungry? Order Now!</h3>
                    <p class="cta-subtitle">Free delivery on orders over ₱500</p>
                    <a href="#" class="btn-cta-large">Order Now</a>
                    
                    <div class="contact-info">
                        <p><i class="fas fa-phone"></i> Call us for orders or inquiries:</p>
                        <div class="phone-numbers">
                            046-473-9753 / 0912-368-7369
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section class="love-us-section">
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

        <section class="contact-map-section">
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

        <footer class="main-footer">
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
                        <a href="#" class="footer-link">Menu</a>
                        <a href="#" class="footer-link">About Us</a>
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

    </form>
</body>
</html>