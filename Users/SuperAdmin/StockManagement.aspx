<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/SuperAdmin.Master" AutoEventWireup="true" CodeBehind="StockManagement.aspx.cs" Inherits="TasteNet.Users.SuperAdmin.StockManagement" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-maroon: #6b0d1e;
            --soft-cream: #fffaf3;
            --text-dark: #4a0e0e;
            --muted-text: #8a6d6d;
            --card-shadow: 0 10px 30px rgba(107, 13, 30, 0.05);
            --success-green: #2d9d78;
            --warning-orange: #d97706;
            --error-red: #b91c1c;
            --radius-lg: 16px;
            --radius-xl: 20px;
            --radius-2xl: 25px;
        }

        html, body, form { 
            margin: 0 !important; 
            padding: 0 !important; 
            background-color: var(--soft-cream) !important; 
            width: 100%;
            font-family: 'Poppins', sans-serif;
        }

        #full-page-wrapper { 
            background-color: var(--soft-cream); 
            min-height: 100vh; 
            width: 100%;  
            padding: 40px; 
            box-sizing: border-box; 
            display: flex; 
            flex-direction: column; 
        }

        .page-header { 
            display: flex; 
            justify-content: space-between; 
            align-items: center; 
            margin-bottom: 45px; 
            width: 100%; 
        }

        .header-title h2 { 
            color: var(--text-dark); 
            font-weight: 700; 
            margin: 0; 
            font-size: 36px; 
            letter-spacing: -0.5px;
        }

        .header-title p { 
            color: var(--muted-text); 
            margin: 12px 0 0 0; 
            font-size: 18px; 
        }

        .header-actions {
            display: flex;
            gap: 25px;
            align-items: center;
        }

        .btn-yellow { 
            background-color: #FFD333; 
            color: #2D0A0A; 
            font-weight: 600; 
            border: none; 
            padding: 18px 35px; 
            border-radius: var(--radius-lg); 
            cursor: pointer; 
            font-size: 16px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(255, 211, 51, 0.2);
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .btn-yellow:hover { 
            background-color: #f0c420;
            transform: translateY(-2px);
            box-shadow: 0 6px 18px rgba(255, 211, 51, 0.3);
        }

        .btn-maroon { 
            background-color: var(--primary-maroon); 
            color: #fff; 
            font-weight: 600; 
            border: none; 
            padding: 18px 35px; 
            border-radius: var(--radius-lg); 
            cursor: pointer; 
            font-size: 16px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(107, 13, 30, 0.2);
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .btn-maroon:hover { 
            background-color: #5a0b19;
            transform: translateY(-2px);
            box-shadow: 0 6px 18px rgba(107, 13, 30, 0.3);
        }

        .stats-grid { 
            display: grid; 
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); 
            gap: 30px; 
            margin-bottom: 50px; 
            width: 100%; 
        }

        .stat-card { 
            background: #fff; 
            padding: 35px 30px; 
            border-radius: var(--radius-2xl); 
            display: flex; 
            justify-content: space-between; 
            align-items: center; 
            box-shadow: var(--card-shadow);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            cursor: pointer;
        }

        .stat-card:hover { 
            transform: translateY(-8px); 
            box-shadow: 0 15px 40px rgba(107, 13, 30, 0.12);
        }

        .stat-icon { 
            width: 65px; 
            height: 65px; 
            border-radius: 18px; 
            display: flex; 
            align-items: center; 
            justify-content: center; 
            font-size: 26px; 
            transition: transform 0.3s ease;
            order: 2;
        }

        .stat-card:hover .stat-icon {
            transform: scale(1.1);
        }

        .icon-items { 
            background: #F9ECEE; 
            color: var(--primary-maroon); 
        }
        .icon-low { 
            background: #FFF3E0; 
            color: var(--warning-orange); 
        }
        .icon-out { 
            background: #FEE2E2; 
            color: var(--error-red); 
        }
        .icon-sales { 
            background: #E6F4F1; 
            color: var(--success-green); 
        }

        .stat-info { 
            text-align: left;
            order: 1;
        }

        .stat-info span { 
            color: var(--muted-text); 
            font-size: 15px; 
            font-weight: 500; 
            text-transform: uppercase; 
            display: block;
            margin-bottom: 8px;
        }

        .stat-info h3 { 
            font-size: 44px; 
            font-weight: 700; 
            color: var(--text-dark); 
            margin: 0;
            line-height: 1;
        }

        .filter-container { 
            display: flex; 
            gap: 25px; 
            margin-bottom: 40px; 
            width: 100%; 
            align-items: center; 
        }

        .search-wrapper { 
            position: relative; 
            width: 450px; 
        }

        .search-wrapper i { 
            position: absolute; 
            left: 24px;
            top: 50%; 
            transform: translateY(-50%); 
            color: #aaa; 
            font-size: 20px;
            z-index: 2;
        }

        .search-wrapper input { 
            width: 100%; 
            padding: 18px 20px 18px 60px; 
            border: 2px solid #E2D1D1; 
            border-radius: var(--radius-lg); 
            font-size: 16px; 
            outline: none; 
            box-sizing: border-box; 
            background: white;
            color: var(--text-dark);
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .search-wrapper input:focus {
            border-color: var(--primary-maroon);
            box-shadow: 0 0 0 4px rgba(107, 13, 30, 0.08);
        }

        .filter-dropdown { 
            padding: 16px 24px; 
            border: 2px solid #E2D1D1; 
            border-radius: var(--radius-lg); 
            background: #fff; 
            font-size: 16px; 
            color: var(--text-dark); 
            width: 240px; 
            font-weight: 500;
            cursor: pointer;
            outline: none;
            transition: all 0.3s ease;
        }

        .filter-dropdown:focus {
            border-color: var(--primary-maroon);
            box-shadow: 0 0 0 3px rgba(107, 13, 30, 0.05);
        }

        .tab-bar { 
            display: flex; 
            gap: 40px; 
            border-bottom: 2px solid #E2D1D1; 
            margin-bottom: 0; 
            padding-bottom: 0; 
            width: 100%; 
        }

        .tab-link { 
            padding: 20px 10px; 
            cursor: pointer; 
            color: var(--muted-text); 
            font-weight: 500; 
            font-size: 16px; 
            position: relative; 
            border-bottom: 4px solid transparent;
            transition: all 0.3s ease;
        }

        .tab-link:hover {
            color: var(--primary-maroon);
        }

        .tab-link.active { 
            color: var(--primary-maroon); 
            font-weight: 700; 
            border-bottom-color: var(--primary-maroon); 
        }

        .tab-badge { 
            background: #FFD333; 
            color: var(--text-dark); 
            font-size: 12px; 
            padding: 6px 12px; 
            border-radius: 12px; 
            margin-left: 12px; 
            font-weight: 700; 
        }

        .table-wrapper { 
            background: #fff; 
            border-radius: 0 0 var(--radius-2xl) var(--radius-2xl); 
            box-shadow: var(--card-shadow); 
            overflow: hidden; 
            width: 100%; 
            margin-top: -2px;
        }

        .full-table { 
            width: 100%; 
            border-collapse: separate;
            border-spacing: 0;
        }

        .full-table th { 
            padding: 28px 24px; 
            text-align: left; 
            background: #fff; 
            color: var(--muted-text); 
            font-weight: 600; 
            font-size: 16px; 
            border-bottom: 2px solid #F3EBE0; 
        }

        .full-table td { 
            padding: 28px 24px; 
            border-bottom: 1px solid #F9F4EE; 
            vertical-align: middle; 
            transition: all 0.3s ease;
        }

        .full-table tbody tr {
            transition: all 0.3s ease;
        }

        .full-table tbody tr:hover {
            background-color: #fefaf5;
            transform: scale(1.005);
            box-shadow: 0 4px 12px rgba(107, 13, 30, 0.05);
        }

        .item-box { 
            width: 60px; 
            height: 60px; 
            background: var(--primary-maroon); 
            color: #fff; 
            border-radius: 16px; 
            display: flex; 
            align-items: center; 
            justify-content: center; 
            font-weight: 700; 
            font-size: 24px; 
            transition: all 0.3s ease;
        }

        .full-table tbody tr:hover .item-box {
            transform: scale(1.1);
            background: #5a0b19;
        }

        .item-name { 
            font-weight: 600; 
            font-size: 18px;
            color: var(--text-dark);
            margin-bottom: 4px;
            display: block;
        }

        .item-category { 
            font-size: 14px; 
            color: var(--muted-text);
            display: block;
        }

        .stock-badge { 
            padding: 12px 24px; 
            border-radius: 16px; 
            font-size: 13px; 
            font-weight: 800; 
            text-transform: uppercase; 
            display: inline-block;
            border: 2px solid transparent;
        }

        .in-stock { 
            background: #E6F4F1; 
            color: var(--success-green); 
            border-color: #c6e9df;
        }

        .low-stock { 
            background: #FFF3E0; 
            color: var(--warning-orange); 
            border-color: #ffe4b5;
        }

        .out-of-stock { 
            background: #FEE2E2; 
            color: var(--error-red); 
            border-color: #fecaca;
        }

        .quantity-controls {
            display: flex;
            align-items: center;
            gap: 16px;
            background: #f9f4ee;
            padding: 10px 16px;
            border-radius: var(--radius-lg);
            border: 2px solid #e2d1d1;
            width: fit-content;
        }

        .qty-btn {
            width: 40px;
            height: 40px;
            border-radius: 12px;
            background: white;
            border: 2px solid #e2d1d1;
            color: var(--primary-maroon);
            font-size: 20px;
            font-weight: 700;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.3s ease;
        }

        .qty-btn:hover {
            background: var(--primary-maroon);
            color: white;
            border-color: var(--primary-maroon);
        }

        .quantity-value {
            font-weight: 700;
            color: var(--primary-maroon);
            font-size: 22px;
            min-width: 40px;
            text-align: center;
        }

        .switch { 
            position: relative; 
            display: inline-block; 
            width: 60px; 
            height: 30px; 
        }

        .switch input { 
            opacity: 0; 
            width: 0; 
            height: 0; 
        }

        .slider { 
            position: absolute; 
            cursor: pointer; 
            top: 0; 
            left: 0; 
            right: 0; 
            bottom: 0; 
            background-color: #ccc; 
            transition: .4s; 
            border-radius: 34px;
            border: 2px solid #e2d1d1;
        }

        .slider:before { 
            position: absolute; 
            content: ""; 
            height: 22px; 
            width: 22px; 
            left: 4px; 
            bottom: 2px; 
            background-color: white; 
            transition: .4s; 
            border-radius: 50%;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
        }

        input:checked + .slider { 
            background-color: var(--success-green); 
            border-color: #2d9d78;
        }

        input:checked + .slider:before { 
            transform: translateX(28px); 
        }

        .action-icons {
            display: flex;
            gap: 25px;
        }

        .action-icon {
            width: 50px;
            height: 50px;
            background: #f9f4ee;
            border-radius: 14px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.3s ease;
            color: var(--muted-text);
            font-size: 18px;
        }

        .action-icon:hover {
            background: var(--primary-maroon);
            color: white;
            transform: scale(1.1);
            box-shadow: 0 4px 12px rgba(107, 13, 30, 0.2);
        }

        .action-icon.edit:hover {
            background: #10b981;
        }

        .action-icon.delete:hover {
            background: #ef4444;
        }

        .item-price {
            font-weight: 700;
            color: var(--primary-maroon);
            font-size: 20px;
        }

        .sold-today {
            font-weight: 700;
            color: var(--primary-maroon);
            font-size: 20px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .sold-today i {
            color: var(--success-green);
            font-size: 16px;
        }
    </style>

    <div id="full-page-wrapper">
        <div class="page-header">
            <div class="header-title">
                <h2>Menu & Stock Management</h2>
                <p>Manage menu items and inventory levels</p>
            </div>
            <div class="header-actions">
                <button type="button" class="btn-yellow"><i class="fa fa-plus me-2"></i>Add New Item</button>
                <button type="button" class="btn-maroon"><i class="fa fa-sync-alt me-2"></i>Bulk Update Stock</button>
            </div>
        </div>

        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-info">
                    <span>TOTAL MENU ITEMS</span>
                    <h3>17</h3>
                </div>
                <div class="stat-icon icon-items"><i class="fa fa-utensils"></i></div>
            </div>
            <div class="stat-card">
                <div class="stat-info">
                    <span>LOW STOCK ALERTS</span>
                    <h3>2</h3>
                </div>
                <div class="stat-icon icon-low"><i class="fa fa-exclamation-triangle"></i></div>
            </div>
            <div class="stat-card">
                <div class="stat-info">
                    <span>OUT OF STOCK</span>
                    <h3>1</h3>
                </div>
                <div class="stat-icon icon-out"><i class="fa fa-times-circle"></i></div>
            </div>
            <div class="stat-card">
                <div class="stat-info">
                    <span>TOTAL SALES TODAY</span>
                    <h3>₱11,625</h3>
                </div>
                <div class="stat-icon icon-sales"><i class="fa fa-peso-sign"></i></div>
            </div>
        </div>

        <div class="filter-container">
            <div class="search-wrapper">
                <i class="fa fa-search"></i>
                <input type="text" placeholder="Search by menu item name...">
            </div>
            <select class="filter-dropdown">
                <option>Filter by Category</option>
                <option>Sizzling Specials</option>
                <option>Silog Meals</option>
                <option>Special Meals</option>
                <option>Drinks</option>
            </select>
            <select class="filter-dropdown">
                <option>All Stock Status</option>
                <option>In Stock</option>
                <option>Low Stock</option>
                <option>Out of Stock</option>
            </select>
        </div>

        <div class="tab-bar">
            <div class="tab-link active">All Items <span class="tab-badge">17</span></div>
            <div class="tab-link">Sizzling Specials <span class="tab-badge" style="background:#eee">4</span></div>
            <div class="tab-link">Silog Meals <span class="tab-badge" style="background:#eee">9</span></div>
            <div class="tab-link">Special Meals <span class="tab-badge" style="background:#eee">4</span></div>
        </div>

        <div class="table-wrapper">
            <table class="full-table">
                <thead>
                    <tr>
                        <th style="width: 80px;">Image</th>
                        <th>Item Name</th>
                        <th style="width: 120px;">Price</th>
                        <th style="width: 140px;">Stock Status</th>
                        <th style="width: 180px;">Quantity</th>
                        <th style="width: 140px;">Sold Today</th>
                        <th style="width: 120px;">Available</th>
                        <th style="width: 140px;">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><div class="item-box">S</div></td>
                        <td>
                            <span class="item-name">Sizzling Sisig</span>
                            <span class="item-category">Sizzling Specials</span>
                        </td>
                        <td class="item-price">₱150.00</td>
                        <td><span class="stock-badge in-stock">IN STOCK</span></td>
                        <td>
                            <div class="quantity-controls">
                                <button type="button" class="qty-btn">-</button>
                                <span class="quantity-value">45</span>
                                <button type="button" class="qty-btn">+</button>
                            </div>
                        </td>
                        <td class="sold-today"><i class="fas fa-fire"></i> 12</td>
                        <td><label class="switch"><input type="checkbox" checked><span class="slider"></span></label></td>
                        <td>
                            <div class="action-icons">
                                <div class="action-icon edit" title="Edit Item">
                                    <i class="fa fa-edit"></i>
                                </div>
                                <div class="action-icon delete" title="Delete Item">
                                    <i class="fa fa-trash"></i>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td><div class="item-box">G</div></td>
                        <td>
                            <span class="item-name">Sizzling Tofu</span>
                            <span class="item-category">Sizzling Specials</span>
                        </td>
                        <td class="item-price">₱220.00</td>
                        <td><span class="stock-badge low-stock">LOW STOCK</span></td>
                        <td>
                            <div class="quantity-controls">
                                <button type="button" class="qty-btn">-</button>
                                <span class="quantity-value">3</span>
                                <button type="button" class="qty-btn">+</button>
                            </div>
                        </td>
                        <td class="sold-today"><i class="fas fa-fire"></i> 51</td>
                        <td><label class="switch"><input type="checkbox" checked><span class="slider"></span></label></td>
                        <td>
                            <div class="action-icons">
                                <div class="action-icon edit" title="Edit Item">
                                    <i class="fa fa-edit"></i>
                                </div>
                                <div class="action-icon delete" title="Delete Item">
                                    <i class="fa fa-trash"></i>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td><div class="item-box">P</div></td>
                        <td>
                            <span class="item-name">Arrozcaldo</span>
                            <span class="item-category">Special Meals</span>
                        </td>
                        <td class="item-price">₱165.00</td>
                        <td><span class="stock-badge out-of-stock">OUT OF STOCK</span></td>
                        <td>
                            <div class="quantity-controls">
                                <button type="button" class="qty-btn">-</button>
                                <span class="quantity-value">0</span>
                                <button type="button" class="qty-btn">+</button>
                            </div>
                        </td>
                        <td class="sold-today"><i class="fas fa-fire"></i> 80</td>
                        <td><label class="switch"><input type="checkbox"><span class="slider"></span></label></td>
                        <td>
                            <div class="action-icons">
                                <div class="action-icon edit" title="Edit Item">
                                    <i class="fa fa-edit"></i>
                                </div>
                                <div class="action-icon delete" title="Delete Item">
                                    <i class="fa fa-trash"></i>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td><div class="item-box">T</div></td>
                        <td>
                            <span class="item-name">Tapsilog</span>
                            <span class="item-category">Silog Meals</span>
                        </td>
                        <td class="item-price">₱175.00</td>
                        <td><span class="stock-badge in-stock">IN STOCK</span></td>
                        <td>
                            <div class="quantity-controls">
                                <button type="button" class="qty-btn">-</button>
                                <span class="quantity-value">28</span>
                                <button type="button" class="qty-btn">+</button>
                            </div>
                        </td>
                        <td class="sold-today"><i class="fas fa-fire"></i> 32</td>
                        <td><label class="switch"><input type="checkbox" checked><span class="slider"></span></label></td>
                        <td>
                            <div class="action-icons">
                                <div class="action-icon edit" title="Edit Item">
                                    <i class="fa fa-edit"></i>
                                </div>
                                <div class="action-icon delete" title="Delete Item">
                                    <i class="fa fa-trash"></i>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td><div class="item-box">B</div></td>
                        <td>
                            <span class="item-name">Bangsilog</span>
                            <span class="item-category">Silog Meals</span>
                        </td>
                        <td class="item-price">₱190.00</td>
                        <td><span class="stock-badge low-stock">LOW STOCK</span></td>
                        <td>
                            <div class="quantity-controls">
                                <button type="button" class="qty-btn">-</button>
                                <span class="quantity-value">5</span>
                                <button type="button" class="qty-btn">+</button>
                            </div>
                        </td>
                        <td class="sold-today"><i class="fas fa-fire"></i> 76</td>
                        <td><label class="switch"><input type="checkbox" checked><span class="slider"></span></label></td>
                        <td>
                            <div class="action-icons">
                                <div class="action-icon edit" title="Edit Item">
                                    <i class="fa fa-edit"></i>
                                </div>
                                <div class="action-icon delete" title="Delete Item">
                                    <i class="fa fa-trash"></i>
                                </div>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

    <script>
        // Quantity controls functionality
        document.querySelectorAll('.qty-btn').forEach(button => {
            button.addEventListener('click', function() {
                const controls = this.closest('.quantity-controls');
                const valueSpan = controls.querySelector('.quantity-value');
                let currentValue = parseInt(valueSpan.textContent);
                
                if (this.textContent === '+') {
                    currentValue++;
                } else if (this.textContent === '-') {
                    currentValue = Math.max(0, currentValue - 1);
                }
                
                valueSpan.textContent = currentValue;
                
                // Update stock badge based on quantity
                const row = this.closest('tr');
                const stockBadge = row.querySelector('.stock-badge');
                
                if (currentValue === 0) {
                    stockBadge.className = 'stock-badge out-of-stock';
                    stockBadge.textContent = 'OUT OF STOCK';
                } else if (currentValue <= 5) {
                    stockBadge.className = 'stock-badge low-stock';
                    stockBadge.textContent = 'LOW STOCK';
                } else {
                    stockBadge.className = 'stock-badge in-stock';
                    stockBadge.textContent = 'IN STOCK';
                }
                
                // Button animation
                this.style.transform = 'scale(0.9)';
                setTimeout(() => {
                    this.style.transform = 'scale(1)';
                }, 150);
            });
        });

        // Tab switching functionality
        document.querySelectorAll('.tab-link').forEach(tab => {
            tab.addEventListener('click', function() {
                document.querySelectorAll('.tab-link').forEach(t => t.classList.remove('active'));
                this.classList.add('active');
            });
        });

        // Search input focus effect
        const searchInput = document.querySelector('.search-wrapper input');
        if (searchInput) {
            searchInput.addEventListener('focus', function() {
                this.parentElement.style.transform = 'scale(1.02)';
            });
            
            searchInput.addEventListener('blur', function() {
                this.parentElement.style.transform = 'scale(1)';
            });
        }

        // Toggle switch click effect
        document.querySelectorAll('.switch input').forEach(toggle => {
            toggle.addEventListener('change', function() {
                const slider = this.nextElementSibling;
                slider.style.transform = 'scale(0.95)';
                setTimeout(() => {
                    slider.style.transform = 'scale(1)';
                }, 200);
            });
        });

        // click effect sa stat card
        document.querySelectorAll('.stat-card').forEach(card => {
            card.addEventListener('click', function() {
                this.style.transform = 'translateY(-4px) scale(1.02)';
                setTimeout(() => {
                    this.style.transform = 'translateY(-8px)';
                }, 150);
            });
        });

        // ripple effects sa button
        document.querySelectorAll('.btn-yellow, .btn-maroon').forEach(button => {
            button.addEventListener('click', function(e) {
                let ripple = document.createElement('span');
                let rect = this.getBoundingClientRect();
                let size = Math.max(rect.width, rect.height);
                let x = e.clientX - rect.left - size / 2;
                let y = e.clientY - rect.top - size / 2;
                
                ripple.style.cssText = `
                    position: absolute;
                    border-radius: 50%;
                    background: rgba(255, 255, 255, 0.3);
                    transform: scale(0);
                    animation: ripple 0.6s linear;
                    width: ${size}px;
                    height: ${size}px;
                    top: ${y}px;
                    left: ${x}px;
                `;
                
                this.style.position = 'relative';
                this.style.overflow = 'hidden';
                this.appendChild(ripple);
                
                setTimeout(() => {
                    ripple.remove();
                }, 600);
            });
        });

        // ripple animation
        const style = document.createElement('style');
        style.textContent = `
            @keyframes ripple {
                to {
                    transform: scale(4);
                    opacity: 0;
                }
            }
        `;
        document.head.appendChild(style);
    </script>
</asp:Content>
