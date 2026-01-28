<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/SuperAdmin.Master" AutoEventWireup="true" CodeBehind="DeliveryPersonnel.aspx.cs" Inherits="TasteNet.Users.SuperAdmin.DeliveryPersonnel" %>

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

        #delivery-mgmt-wrapper {
            background: var(--soft-cream) !important;
            padding: 30px 40px;
            width: 100%;
            min-height: 100vh;
            margin: 0;
            box-sizing: border-box;
            display: block;
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 45px;
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

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 30px;
            margin-bottom: 50px;
        }

        .stat-box {
            background: white;
            padding: 35px 30px;
            border-radius: var(--radius-2xl);
            display: flex;
            flex-direction: row-reverse;
            justify-content: space-between;
            align-items: center;
            box-shadow: var(--card-shadow);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            border: none;
            cursor: pointer;
        }

        .stat-box:hover { 
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
        }

        .stat-box:hover .stat-icon {
            transform: scale(1.1);
        }

        .icon-total { background: #f9ecee; color: var(--primary-maroon); }
        .icon-available { background: #edf7f4; color: var(--success-green); }
        .icon-delivery { background: #fff9e6; color: #d97706; }
        .icon-orders { background: #eff6ff; color: #3b82f6; }

        .stat-info span { 
            font-size: 16px; 
            color: var(--muted-text); 
            font-weight: 500; 
            display: block;
            margin-bottom: 8px;
        }
        
        .stat-info h3 { 
            font-size: 44px; 
            font-weight: 700; 
            color: var(--primary-maroon); 
            margin: 0;
            line-height: 1;
        }

        .filter-container {
            display: flex;
            gap: 25px;
            margin-bottom: 40px;
            align-items: center;
        }

        .inner-search {
            position: relative;
            display: flex;
            max-width: 500px; 
            width: 100%;
        }

        .inner-search i {
            position: absolute;
            left: 24px;
            top: 50%;
            transform: translateY(-50%);
            color: #aaa;
            font-size: 20px;
            z-index: 2;
        }

        .inner-search input {
            width: 100%;
            padding: 18px 25px 18px 65px;
            border: 2px solid #e2d1d1;
            border-radius: var(--radius-lg);
            outline: none;
            font-size: 16px;
            background: white;
            color: var(--text-dark);
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .inner-search input:focus {
            border-color: var(--primary-maroon);
            box-shadow: 0 0 0 4px rgba(107, 13, 30, 0.08);
        }

        .filter-select {
            padding: 16px 24px;
            border: 2px solid #e2d1d1;
            border-radius: var(--radius-lg);
            background: white;
            color: var(--text-dark);
            min-width: 200px;
            font-size: 16px;
            font-weight: 500;
            cursor: pointer;
            outline: none;
            transition: all 0.3s ease;
        }

        .filter-select:focus {
            border-color: var(--primary-maroon);
            box-shadow: 0 0 0 3px rgba(107, 13, 30, 0.05);
        }

        .table-container {
            background: white;
            border-radius: var(--radius-2xl);
            padding: 15px 25px 25px 25px;
            box-shadow: var(--card-shadow);
            overflow-x: auto;
        }

        .custom-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
        }

        .custom-table th {
            padding: 28px 20px;
            text-align: center;
            font-size: 17px;
            color: var(--muted-text);
            font-weight: 600;
            border-bottom: 2px solid #f3ebe0;
            letter-spacing: 0.3px;
        }

        .custom-table td {
            padding: 28px 20px;
            border-bottom: 1px solid #f9f4ee;
            text-align: center;
            color: var(--text-dark);
            font-size: 17px; 
            vertical-align: middle;
            transition: all 0.3s ease;
        }

        .custom-table tbody tr {
            transition: all 0.3s ease;
            border-radius: 12px;
        }

        .custom-table tbody tr:hover {
            background-color: #fefaf5;
            transform: scale(1.005);
            box-shadow: 0 4px 12px rgba(107, 13, 30, 0.05);
        }

        .rider-id { 
            color: var(--primary-maroon); 
            font-weight: 700; 
            font-size: 18px;
        }
        
        .rider-name { 
            font-weight: 700; 
            font-size: 20px; 
            display: block; 
            margin-bottom: 5px;
            color: var(--text-dark);
        }

        .rider-contact {
            font-size: 15px;
            color: var(--muted-text);
            display: block;
        }
        
        .badge-available { 
            background: #E6F4F1; 
            color: var(--success-green); 
            padding: 12px 24px; 
            border-radius: 16px; 
            font-size: 14px; 
            font-weight: 700; 
            display: inline-block;
            border: 2px solid #c6e9df;
        }
        
        .badge-delivery { 
            background: #FFF9E6; 
            color: #D97706; 
            padding: 12px 24px; 
            border-radius: 16px; 
            font-size: 14px; 
            font-weight: 700; 
            display: inline-block;
            border: 2px solid #ffe4b5;
        }

        .rating-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .rating-stars {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 4px;
            font-size: 18px;
        }

        .rating-stars i {
            color: #ffcc00;
        }

        .rating-value {
            font-weight: 700;
            font-size: 20px;
            color: #d97706;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .btn-maroon { 
            background: var(--primary-maroon); 
            color: white; 
            border: none; 
            border-radius: var(--radius-lg); 
            padding: 18px 35px; 
            font-weight: 600; 
            cursor: pointer; 
            font-size: 16px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(107, 13, 30, 0.2);
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        .btn-maroon:hover { 
            background: #5a0b19;
            transform: translateY(-2px);
            box-shadow: 0 6px 18px rgba(107, 13, 30, 0.3);
        }
        
        .btn-yellow { 
            background: #ffcc00; 
            color: #4a0e0e; 
            border: none; 
            border-radius: var(--radius-lg); 
            padding: 18px 35px; 
            font-weight: 600; 
            cursor: pointer; 
            font-size: 16px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(255, 204, 0, 0.2);
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        .btn-yellow:hover { 
            background: #e6b800;
            transform: translateY(-2px);
            box-shadow: 0 6px 18px rgba(255, 204, 0, 0.3);
        }
        
        .action-btns { 
            display: flex; 
            gap: 25px; 
            justify-content: center; 
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
        }

        .action-icon:hover {
            background: var(--primary-maroon);
            color: white;
            transform: scale(1.1);
            box-shadow: 0 4px 12px rgba(107, 13, 30, 0.2);
        }

        .action-icon.view:hover {
            background: #3b82f6;
        }

        .action-icon.edit:hover {
            background: #10b981;
        }

        .action-icon.delete:hover {
            background: #ef4444;
        }

        .stat-number {
            font-weight: 700;
            color: var(--primary-maroon);
            font-size: 22px;
        }

        .vehicle-badge {
            background: #f3ebe0;
            color: var(--text-dark);
            padding: 10px 18px;
            border-radius: 14px;
            font-size: 14px;
            font-weight: 600;
            display: inline-block;
            border: 2px solid #e2d1d1;
        }

        .completed-deliveries {
            font-weight: 700;
            color: var(--success-green);
            font-size: 20px;
        }

        .rating-column {
            min-width: 120px;
        }

        .custom-table td {
            text-align: center;
            vertical-align: middle;
        }
    </style>

    <div id="delivery-mgmt-wrapper">
        <div class="page-header">
            <div class="header-title">
                <h2>Delivery Personnel</h2>
                <p>Manage riders and delivery staff performance</p>
            </div>
            <div class="header-actions">
                <button type="button" class="btn-yellow"><i class="fa fa-plus me-2"></i>Add Rider</button>
                <button type="button" class="btn-maroon"><i class="fa fa-tasks me-2"></i>Assign Orders</button>
            </div>
        </div>

        <div class="stats-grid">
            <div class="stat-box">
                <div class="stat-icon icon-total"><i class="fa fa-user"></i></div>
                <div class="stat-info">
                    <span>Total Active Riders</span>
                    <h3>7</h3>
                </div>
            </div>
            <div class="stat-box">
                <div class="stat-icon icon-available"><i class="fa fa-clock"></i></div>
                <div class="stat-info">
                    <span>Available Now</span>
                    <h3>3</h3>
                </div>
            </div>
            <div class="stat-box">
                <div class="stat-icon icon-delivery"><i class="fa fa-motorcycle"></i></div>
                <div class="stat-info">
                    <span>On Delivery</span>
                    <h3>2</h3>
                </div>
            </div>
            <div class="stat-box">
                <div class="stat-icon icon-orders"><i class="fa fa-cube"></i></div>
                <div class="stat-info">
                    <span>Active Orders</span>
                    <h3>6</h3>
                </div>
            </div>
        </div>

        <div class="filter-container">
            <div class="inner-search">
                <i class="fa fa-search"></i>
                <input type="text" placeholder="Search by name, ID, or contact...">
            </div>
            <select class="filter-select">
                <option>All Status</option>
                <option>Available</option>
                <option>On Delivery</option>
                <option>Offline</option>
            </select>
            <select class="filter-select">
                <option>All Vehicles</option>
                <option>Motorcycle</option>
                <option>Bicycle</option>
            </select>
            <select class="filter-select">
                <option>Sort by: Rating</option>
                <option>Sort by: Completed Orders</option>
                <option>Sort by: Name</option>
                <option>Sort by: Date Joined</option>
            </select>
        </div>

        <div class="table-container">
            <table class="custom-table">
                <thead>
                    <tr>
                        <th>Rider ID</th>
                        <th>Full Name</th>
                        <th>Contact</th>
                        <th>Vehicle</th>
                        <th>Status</th>
                        <th>Assigned</th>
                        <th>Completed</th>
                        <th class="rating-column">Rating</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="rider-id">RDR-001</td>
                        <td>
                            <span class="rider-name">Zea Mae Sulit</span>
                            <span class="rider-contact">Joined: Jan 15, 2024</span>
                        </td>
                        <td>
                            <span class="rider-contact">0917-111-2222</span>
                            <span class="rider-contact" style="font-size:13px;">zeamae.s@email.com</span>
                        </td>
                        <td><span class="vehicle-badge">Motorcycle</span></td>
                        <td><span class="badge-available">AVAILABLE</span></td>
                        <td class="stat-number">2</td>
                        <td class="completed-deliveries">487</td>
                        <td>
                            <div class="rating-container">
                                <div class="rating-stars">
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star-half-alt"></i>
                                </div>
                                <div class="rating-value">4.8</div>
                            </div>
                        </td>
                        <td>
                            <div class="action-btns">
                                <div class="action-icon view" title="View Profile">
                                    <i class="fa fa-eye"></i>
                                </div>
                                <div class="action-icon edit" title="Edit Rider">
                                    <i class="fa fa-edit"></i>
                                </div>
                                <div class="action-icon delete" title="Remove Rider">
                                    <i class="fa fa-trash"></i>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="rider-id">RDR-002</td>
                        <td>
                            <span class="rider-name">Jay-r Casano</span>
                            <span class="rider-contact">Joined: Dec 22, 2023</span>
                        </td>
                        <td>
                            <span class="rider-contact">0918-222-3333</span>
                            <span class="rider-contact" style="font-size:13px;">jayr.c@email.com</span>
                        </td>
                        <td><span class="vehicle-badge">Motorcycle</span></td>
                        <td><span class="badge-delivery">ON DELIVERY</span></td>
                        <td class="stat-number">1</td>
                        <td class="completed-deliveries">523</td>
                        <td>
                            <div class="rating-container">
                                <div class="rating-stars">
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                </div>
                                <div class="rating-value">5.0</div>
                            </div>
                        </td>
                        <td>
                            <div class="action-btns">
                                <div class="action-icon view" title="View Profile">
                                    <i class="fa fa-eye"></i>
                                </div>
                                <div class="action-icon edit" title="Edit Rider">
                                    <i class="fa fa-edit"></i>
                                </div>
                                <div class="action-icon delete" title="Remove Rider">
                                    <i class="fa fa-trash"></i>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="rider-id">RDR-003</td>
                        <td>
                            <span class="rider-name">George Gonzaga</span>
                            <span class="rider-contact">Joined: Feb 10, 2024</span>
                        </td>
                        <td>
                            <span class="rider-contact">0919-333-4444</span>
                            <span class="rider-contact" style="font-size:13px;">gonzaga.g@email.com</span>
                        </td>
                        <td><span class="vehicle-badge">Bicycle</span></td>
                        <td><span class="badge-available">AVAILABLE</span></td>
                        <td class="stat-number">0</td>
                        <td class="completed-deliveries">156</td>
                        <td>
                            <div class="rating-container">
                                <div class="rating-stars">
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="far fa-star"></i>
                                </div>
                                <div class="rating-value">4.0</div>
                            </div>
                        </td>
                        <td>
                            <div class="action-btns">
                                <div class="action-icon view" title="View Profile">
                                    <i class="fa fa-eye"></i>
                                </div>
                                <div class="action-icon edit" title="Edit Rider">
                                    <i class="fa fa-edit"></i>
                                </div>
                                <div class="action-icon delete" title="Remove Rider">
                                    <i class="fa fa-trash"></i>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="rider-id">RDR-004</td>
                        <td>
                            <span class="rider-name">Lalaine Reyes</span>
                            <span class="rider-contact">Joined: Mar 05, 2024</span>
                        </td>
                        <td>
                            <span class="rider-contact">0920-444-5555</span>
                            <span class="rider-contact" style="font-size:13px;">laline.r@email.com</span>
                        </td>
                        <td><span class="vehicle-badge">Motorcycle</span></td>
                        <td><span class="badge-delivery">ON DELIVERY</span></td>
                        <td class="stat-number">3</td>
                        <td class="completed-deliveries">89</td>
                        <td>
                            <div class="rating-container">
                                <div class="rating-stars">
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star-half-alt"></i>
                                    <i class="far fa-star"></i>
                                </div>
                                <div class="rating-value">3.5</div>
                            </div>
                        </td>
                        <td>
                            <div class="action-btns">
                                <div class="action-icon view" title="View Profile">
                                    <i class="fa fa-eye"></i>
                                </div>
                                <div class="action-icon edit" title="Edit Rider">
                                    <i class="fa fa-edit"></i>
                                </div>
                                <div class="action-icon delete" title="Remove Rider">
                                    <i class="fa fa-trash"></i>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="rider-id">RDR-005</td>
                        <td>
                            <span class="rider-name">Bryce Magallano</span>
                            <span class="rider-contact">Joined: Apr 12, 2024</span>
                        </td>
                        <td>
                            <span class="rider-contact">0921-555-6666</span>
                            <span class="rider-contact" style="font-size:13px;">bryce.g@email.com</span>
                        </td>
                        <td><span class="vehicle-badge">Motorcycle</span></td>
                        <td><span class="badge-available">AVAILABLE</span></td>
                        <td class="stat-number">1</td>
                        <td class="completed-deliveries">312</td>
                        <td>
                            <div class="rating-container">
                                <div class="rating-stars">
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                </div>
                                <div class="rating-value">5.0</div>
                            </div>
                        </td>
                        <td>
                            <div class="action-btns">
                                <div class="action-icon view" title="View Profile">
                                    <i class="fa fa-eye"></i>
                                </div>
                                <div class="action-icon edit" title="Edit Rider">
                                    <i class="fa fa-edit"></i>
                                </div>
                                <div class="action-icon delete" title="Remove Rider">
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
        // hover effects to sa filter
        document.querySelectorAll('.filter-select').forEach(select => {
            select.addEventListener('focus', function () {
                this.style.borderColor = 'var(--primary-maroon)';
                this.style.boxShadow = '0 0 0 3px rgba(107, 13, 30, 0.1)';
            });

            select.addEventListener('blur', function () {
                this.style.borderColor = '#e2d1d1';
                this.style.boxShadow = 'none';
            });
        });

        // click effects sa stats box
        document.querySelectorAll('.stat-box').forEach(box => {
            box.addEventListener('click', function () {
                this.style.transform = 'translateY(-4px) scale(1.02)';
                setTimeout(() => {
                    this.style.transform = 'translateY(-8px)';
                }, 150);
            });
        });

        // ripple effects sa button
        document.querySelectorAll('.btn-maroon, .btn-yellow').forEach(button => {
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
