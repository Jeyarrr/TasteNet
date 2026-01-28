<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/SuperAdmin.Master" AutoEventWireup="true" CodeBehind="AllOrders.aspx.cs" Inherits="TasteNet.Users.SuperAdmin.AllOrders" %>
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
            --info-blue: #3182CE;
            --radius-lg: 16px;
            --radius-xl: 20px;
            --radius-2xl: 25px;
        }

        body, form { 
            background-color: var(--soft-cream) !important; 
            font-family: 'Poppins', sans-serif !important;
            margin: 0 !important;
            padding: 0 !important;
        }

        .page-container {
            padding: 40px; 
            min-height: 100vh;
            box-sizing: border-box;
        }

        .header-section {
            display: flex; 
            justify-content: space-between; 
            align-items: center; 
            margin-bottom: 45px; 
        }

        .header-section h1 { 
            font-size: 36px; 
            color: var(--text-dark); 
            font-weight: 700; 
            margin: 0;
            letter-spacing: -0.5px;
        }

        .header-section p {
            color: var(--muted-text);
            margin: 8px 0 0 0;
            font-size: 18px;
        }

        .btn-export {
            background-color: var(--primary-maroon);
            color: white;
            border: none;
            padding: 18px 35px;
            border-radius: var(--radius-lg);
            font-weight: 600;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 12px;
            font-size: 16px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(107, 13, 30, 0.2);
        }

        .btn-export:hover {
            background-color: #5a0b19;
            transform: translateY(-2px);
            box-shadow: 0 6px 18px rgba(107, 13, 30, 0.3);
        }

        .filter-container { 
            display: flex; 
            gap: 25px; 
            margin-bottom: 40px; 
            align-items: center; 
            justify-content: flex-start;
            width: 100%;
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
            outline: none; 
            font-size: 16px;
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

        .filter-input { 
            padding: 16px 24px; 
            border: 2px solid #E2D1D1; 
            border-radius: var(--radius-lg); 
            color: var(--text-dark); 
            background: white; 
            width: 220px;
            font-size: 16px;
            outline: none;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .filter-input:focus {
            border-color: var(--primary-maroon);
            box-shadow: 0 0 0 3px rgba(107, 13, 30, 0.05);
        }

        .btn-more-filters { 
            border: 2px solid var(--primary-maroon); 
            color: var(--primary-maroon); 
            background: transparent; 
            padding: 16px 28px; 
            border-radius: var(--radius-lg); 
            display: flex; 
            align-items: center; 
            gap: 12px; 
            cursor: pointer; 
            font-weight: 600;
            font-size: 16px;
            transition: all 0.3s ease;
        }

        .btn-more-filters:hover {
            background-color: var(--primary-maroon);
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(107, 13, 30, 0.2);
        }

        .tabs {
            display: flex;
            gap: 40px; 
            border-bottom: 2px solid #E2D1D1; 
            margin-bottom: 0; 
            padding-bottom: 0;
        }

        .tab-item { 
            padding: 20px 10px;
            cursor: pointer;
            color: var(--muted-text);
            font-weight: 500; 
            font-size: 16px; 
            position: relative; 
            border-bottom: 4px solid transparent;
            transition: all 0.3s ease;
        }

        .tab-item:hover {
            color: var(--primary-maroon);
        }

        .tab-item.active { 
            color: var(--primary-maroon);
            border-bottom-color: var(--primary-maroon); 
            font-weight: 700; 
        }

        .tab-count { 
            background: #eee; 
            font-size: 12px; 
            padding: 6px 12px; 
            border-radius: 12px; 
            margin-left: 12px; 
            font-weight: 700; 
        }

        .tab-item.active .tab-count {
            background: #FFD333;
            color: var(--text-dark);
        }

        .orders-card { 
            background: white; 
            border-radius: 0 0 var(--radius-2xl) var(--radius-2xl); 
            box-shadow: var(--card-shadow); 
            overflow: hidden; 
            margin-top: -2px;
        }

        .orders-table { 
            width: 100%; 
            border-collapse: separate;
            border-spacing: 0;
            text-align: left;
        }

        .orders-table th { 
            background: #fff; 
            padding: 28px 24px; 
            color: var(--muted-text); 
            font-size: 16px; 
            font-weight: 600; 
            border-bottom: 2px solid #F3EBE0; 
            letter-spacing: 0.3px;
            text-align: center;
        }

        .orders-table td {
            padding: 28px 24px;
            border-bottom: 1px solid #F9F4EE; 
            font-size: 16px; 
            vertical-align: middle;
            transition: all 0.3s ease;
            text-align: center;
        }

        .orders-table tbody tr {
            transition: all 0.3s ease;
        }

        .orders-table tbody tr:hover {
            background-color: #fefaf5;
            transform: scale(1.005);
            box-shadow: 0 4px 12px rgba(107, 13, 30, 0.05);
        }
        
        .order-id { 
            color: var(--error-red); 
            font-weight: 700; 
            text-decoration: none; 
            font-size: 17px;
            transition: color 0.3s ease;
        }

        .order-id:hover {
            color: var(--primary-maroon);
            text-decoration: underline;
        }

        .text-muted { 
            color: var(--muted-text); 
            font-size: 14px; 
        }

        .amount-text { 
            font-weight: 700; 
            color: var(--primary-maroon);
            font-size: 18px;
        }

        .status-badge { 
            padding: 12px 24px; 
            border-radius: 16px; 
            font-size: 13px; 
            font-weight: 800; 
            text-transform: uppercase; 
            display: inline-block;
            border: 2px solid transparent;
        }

        .status-completed { 
            background: #E6F4F1; 
            color: var(--success-green);
            border-color: #c6e9df;
        }

        .status-active { 
            background: #E1F0F7; 
            color: var(--info-blue);
            border-color: #b3d7f0;
        }

        .status-cancelled { 
            background: #FEE2E2; 
            color: var(--error-red);
            border-color: #fecaca;
        }

        .status-pending { 
            background: #FFF3E0; 
            color: var(--warning-orange);
            border-color: #ffe4b5;
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

        .chubby-checkbox {
            width: 24px;
            height: 24px;
            border-radius: 8px;
            border: 2px solid #e2d1d1;
            background: white;
            cursor: pointer;
            appearance: none;
            position: relative;
            transition: all 0.3s ease;
        }

        .chubby-checkbox:checked {
            background: var(--primary-maroon);
            border-color: var(--primary-maroon);
        }

        .chubby-checkbox:checked::after {
            content: '✓';
            position: absolute;
            color: white;
            font-size: 14px;
            font-weight: bold;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
        }

        .pagination-container { 
            display: flex; 
            justify-content: space-between; 
            align-items: center; 
            margin-top: 35px; 
        }

        .pagination-text {
            color: var(--muted-text);
            font-size: 15px;
            font-weight: 500;
        }

        .pagination-buttons {
            display: flex;
            gap: 10px;
        }

        .page-btn { 
            padding: 14px 22px; 
            border: 2px solid #E2D1D1; 
            background: white; 
            border-radius: 14px; 
            cursor: pointer; 
            font-family: 'Poppins';
            font-weight: 600;
            font-size: 15px;
            color: var(--text-dark);
            transition: all 0.3s ease;
            min-width: 50px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .page-btn:hover {
            border-color: var(--primary-maroon);
            background: #fefaf5;
            transform: translateY(-2px);
        }

        .page-btn.active { 
            background: var(--primary-maroon); 
            color: white; 
            border-color: var(--primary-maroon);
            box-shadow: 0 4px 12px rgba(107, 13, 30, 0.2);
        }

        .page-btn.active:hover {
            background: #5a0b19;
            transform: translateY(-2px);
        }

        @media (max-width: 1200px) {
            .filter-container {
                flex-wrap: wrap;
            }
            
            .search-wrapper {
                width: 100%;
            }
            
            .filter-input {
                width: calc(33.333% - 16.67px);
            }
            
            .btn-more-filters {
                width: 100%;
                justify-content: center;
            }
        }

        @media (max-width: 768px) {
            .page-container {
                padding: 25px;
            }
            
            .header-section {
                flex-direction: column;
                align-items: flex-start;
                gap: 20px;
            }
            
            .header-section h1 {
                font-size: 28px;
            }
            
            .tabs {
                overflow-x: auto;
                gap: 20px;
            }
            
            .orders-table {
                display: block;
                overflow-x: auto;
            }
            
            .pagination-container {
                flex-direction: column;
                gap: 20px;
                align-items: flex-start;
            }
        }
    </style>

    <div class="page-container">
        <div class="header-section">
            <div>
                <h1>Orders Management</h1>
                <p>View and manage all customer orders</p>
            </div>
            <button class="btn-export"><i class="fa fa-download"></i> Export Orders</button>
        </div>

        <div class="filter-container">
            <div class="search-wrapper">
                <i class="fa fa-search"></i>
                <input type="text" placeholder="Search by order ID, customer, or restaurant...">
            </div>
            <input type="date" class="filter-input">
            <select class="filter-input">
                <option>All Payment Methods</option>
                <option>Cash On Delivery</option>
                <option>GCash</option>
                <option>Paypal</option>
                <option>GoTyme</option>
            </select>
            <button class="btn-more-filters"><i class="fa fa-filter"></i> More Filters</button>
        </div>

        <div class="tabs">
            <div class="tab-item active">All Orders <span class="tab-count">8</span></div>
            <div class="tab-item">Active Orders <span class="tab-count">2</span></div>
            <div class="tab-item">Completed Orders <span class="tab-count">4</span></div>
            <div class="tab-item">Cancelled Orders <span class="tab-count">1</span></div>
            <div class="tab-item">Pending Orders <span class="tab-count">1</span></div>
        </div>

        <div class="orders-card">
            <table class="orders-table">
                <thead>
                    <tr>
                        <th style="width: 60px;"><input type="checkbox" class="chubby-checkbox"></th>
                        <th>Order ID</th>
                        <th>Date & Time</th>
                        <th>Customer</th>
                        <th>Items</th>
                        <th>Amount</th>
                        <th>Payment</th>
                        <th>Status</th>
                        <th style="width: 80px;">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <asp:Repeater ID="rptOrders" runat="server">
                        <ItemTemplate>
                            <tr>
                                <td><input type="checkbox" class="chubby-checkbox"></td>
                                <td><a href="#" class="order-id">#<%# Eval("OrderNumber") %></a></td>
                                <td>
                                    <div style="font-weight:600; color:var(--text-dark); font-size: 16px;"><%# Eval("OrderDate", "{0:MMM dd, yyyy}") %></div>
                                    <div class="text-muted"><%# Eval("OrderDate", "{0:t}") %></div>
                                </td>
                                <td style="font-weight:600; color:var(--text-dark);"><%# Eval("CustomerName") %></td>
                                <td class="text-muted"><%# Eval("ItemsSummary") %></td>
                                <td class="amount-text">₱<%# Eval("TotalAmount") %></td>
                                <td style="font-weight:500; color:var(--text-dark);"><%# Eval("PaymentMethod") %></td>
                                <td>
                                    <span class='status-badge status-<%# Eval("OrderStatus").ToString().ToLower() %>'>
                                        <%# Eval("OrderStatus") %>
                                    </span>
                                </td>
                                <td>
                                    <div class="action-icon" title="View Order Details">
                                        <i class="fa fa-eye"></i>
                                    </div>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </tbody>
            </table>
        </div>

        <div class="pagination-container">
            <span class="pagination-text">Showing 8 of 8 orders</span>
            <div class="pagination-buttons">
                <button class="page-btn"><i class="fas fa-chevron-left"></i></button>
                <button class="page-btn active">1</button>
                <button class="page-btn">2</button>
                <button class="page-btn">3</button>
                <button class="page-btn"><i class="fas fa-chevron-right"></i></button>
            </div>
        </div>
    </div>

    <script>
        // tab switching effect
        document.querySelectorAll('.tab-item').forEach(tab => {
            tab.addEventListener('click', function () {
                document.querySelectorAll('.tab-item').forEach(t => t.classList.remove('active'));
                this.classList.add('active');
            });
        });

        const selectAllCheckbox = document.querySelector('thead .chubby-checkbox');
        const rowCheckboxes = document.querySelectorAll('tbody .chubby-checkbox');

        if (selectAllCheckbox) {
            selectAllCheckbox.addEventListener('change', function () {
                const isChecked = this.checked;
                rowCheckboxes.forEach(checkbox => {
                    checkbox.checked = isChecked;
                    checkbox.style.transform = isChecked ? 'scale(1.1)' : 'scale(1)';
                });
            });
        }

        // checkbox effects
        rowCheckboxes.forEach(checkbox => {
            checkbox.addEventListener('change', function () {
                this.style.transform = this.checked ? 'scale(1.1)' : 'scale(1)';
            });
        });

        document.querySelectorAll('.btn-export, .btn-more-filters, .page-btn').forEach(button => {
            button.addEventListener('click', function (e) {
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

        document.querySelectorAll('.filter-input, .search-wrapper input').forEach(input => {
            input.addEventListener('focus', function () {
                this.style.borderColor = 'var(--primary-maroon)';
                this.style.boxShadow = '0 0 0 3px rgba(107, 13, 30, 0.05)';
            });

            input.addEventListener('blur', function () {
                this.style.borderColor = '#E2D1D1';
                this.style.boxShadow = 'none';
            });
        });

        // row hover effectss
        document.querySelectorAll('.orders-table tbody tr').forEach(row => {
            row.addEventListener('mouseenter', function () {
                this.style.transform = 'scale(1.005)';
            });

            row.addEventListener('mouseleave', function () {
                this.style.transform = 'scale(1)';
            });
        });

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