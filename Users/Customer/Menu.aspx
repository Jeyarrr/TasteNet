<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Menu.aspx.cs" Inherits="TasteNet.Users.Customer.Menu" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>TasteNet Menu</title>
    <style>
        :root {
            --primary-maroon: #800000;
            --secondary-yellow: #f4c542;
            --bg-cream: #fdf5e6;
            --text-dark: #333;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background-color: var(--bg-cream);
            color: var(--text-dark);
        }

        .container {
            max-width: 1100px;
            margin: 0 auto;
            padding: 20px;
        }

        /* Header & Search Section */
        .header {
            text-align: center;
            margin-bottom: 20px;
        }
        .header h1 {
            color: var(--primary-maroon);
            font-size: 3em;
            margin: 0;
        }
        .header p { font-size: 1.1em; color: #555; }

        .search-container {
            display: flex;
            justify-content: center;
            margin-bottom: 20px;
        }
        .search-bar {
            width: 100%;
            max-width: 500px;
            padding: 12px 20px;
            border-radius: 25px;
            border: 1px solid #ccc;
            outline: none;
        }

        /* Filter Chips */
        .filter-group {
            display: flex;
            gap: 10px;
            justify-content: center;
            margin-bottom: 30px;
            flex-wrap: wrap;
        }
        .filter-chip {
            padding: 8px 18px;
            border-radius: 20px;
            background: var(--secondary-yellow);
            border: none;
            cursor: pointer;
            font-weight: bold;
            font-size: 0.9em;
        }
        .filter-chip.active { background: var(--primary-maroon); color: white; }

        /* Category Headers */
        .category-header {
            display: flex;
            align-items: center;
            gap: 15px;
            margin: 40px 0 20px 0;
        }
        .category-header h2 {
            color: var(--primary-maroon);
            font-size: 2em;
            margin: 0;
        }
        .category-icon { width: 40px; height: 40px; }

        /* Grid Layout */
        .menu-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 25px;
        }

        /* Menu Card */
        .menu-card {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            display: flex;
            flex-direction: column;
            transition: transform 0.2s;
        }
        .menu-card:hover { transform: translateY(-5px); }

        .item-image {
            width: 100%;
            height: 200px;
            background-color: #eee;
            object-fit: cover;
        }

        .card-content {
            padding: 15px;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
        }

        .item-title { font-size: 1.3em; font-weight: 800; color: #000; margin-bottom: 5px; }
        .rating-row { color: #ff9800; font-size: 0.85em; margin-bottom: 8px; font-weight: bold; }
        .rating-row span { color: #888; font-weight: normal; }
        
        .description {
            font-size: 0.9em;
            color: #666;
            line-height: 1.4;
            margin-bottom: 15px;
            flex-grow: 1;
        }

        .price-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }
        .price { font-size: 1.2em; font-weight: 800; color: var(--primary-maroon); }
        .price-sub { font-size: 0.9em; text-align: center; }
        .price-sub span { display: block; font-weight: bold; color: var(--primary-maroon); }

        .btn-container {
            display: grid;
            grid-template-columns: 1fr 1.5fr;
            gap: 10px;
        }
        .btn {
            padding: 10px;
            border-radius: 8px;
            border: none;
            font-weight: bold;
            cursor: pointer;
            text-align: center;
        }
        .btn-carbs { background-color: var(--primary-maroon); color: white; }
        .btn-add { background-color: var(--primary-maroon); color: white; }

    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="header">
                <h1>Our Menu</h1>
                <p>All your Filipino favorites in one place</p>
            </div>

            <div class="search-container">
                <input type="text" class="search-bar" placeholder="🔍 Search Menu" />
            </div>

            <div class="filter-group">
                <button type="button" class="filter-chip active">All (18)</button>
                <button type="button" class="filter-chip">Sizzling Special (2)</button>
                <button type="button" class="filter-chip">Silog Meals (9)</button>
                <button type="button" class="filter-chip">Special Meals (4)</button>
            </div>

            <div class="category-header">
                <span class="category-icon">🍳</span>
                <h2>Silog Meals</h2>
            </div>

            <div class="menu-grid">
                <div class="menu-card">
                    <img src="tapsilog.jpg" alt="Tapsilog" class="item-image" />
                    <div class="card-content">
                        <div class="item-title">Tapsilog</div>
                        <div class="rating-row">★ 4.9 <span>(96 Reviews)</span></div>
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
                        <div class="rating-row">★ 4.8 <span>(132 Reviews)</span></div>
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
                        <div class="rating-row">★ 4.8 <span>(132 Reviews)</span></div>
                        <p class="description">Crispy fried bangus (milkfish), seasoned and cooked to golden perfection, served with garlic fried rice and a sunny-side-up egg.</p>
                        <div class="price-row">
                            <span class="price">₱65.00</span>
                        </div>
                        <div class="btn-container">
                            <asp:Button ID="btnV3" runat="server" Text="View Carbs" CssClass="btn btn-carbs" />
                            <asp:Button ID="btnAdd3" runat="server" Text="+ Add to cart" CssClass="btn btn-add" />
                        </div>
                    </div>
                </div>
            </div>

            <div class="category-header">
                <span class="category-icon">🥘</span>
                <h2>Sizzling Specials</h2>
            </div>

            <div class="menu-grid">
                <div class="menu-card">
                    <img src="sisig.jpg" alt="Pork Sisig" class="item-image" />
                    <div class="card-content">
                        <div class="item-title">Sizzling Pork Sisig</div>
                        <div class="rating-row">★ 4.9 <span>(195 Reviews)</span></div>
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
    </form>
</body>
</html>