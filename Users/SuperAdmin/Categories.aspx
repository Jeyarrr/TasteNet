<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/SuperAdmin.Master" AutoEventWireup="true" CodeBehind="Categories.aspx.cs" Inherits="TasteNet.Users.SuperAdmin.Categories" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        /* Specific Styles for the Content Area */
        :root {
            --brand-maroon: #800020;
            --brand-yellow: #FFC107;
            --bg-light: #FDF9F3;
        }

        .category-management-container { background-color: var(--bg-light); min-height: 100vh; padding: 20px; }
        
        /* Stats Cards */
        .stat-card { border: none; border-radius: 12px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); background: white; }
        .stat-card h2 { font-weight: bold; font-size: 2.2rem; color: var(--brand-maroon); margin: 0; }
        
        /* Category Item Cards */
        .category-card { border-radius: 15px; overflow: hidden; border: none; box-shadow: 0 4px 15px rgba(0,0,0,0.1); transition: 0.3s; background: white; }
        .category-card:hover { transform: translateY(-5px); }
        .category-header { background-color: var(--brand-maroon); color: white; padding: 25px; text-align: center; }
        .category-title { font-size: 1.5rem; font-weight: 500; }
        
        .status-badge { font-size: 0.7rem; background: #D1E7DD; color: #0F5132; padding: 2px 8px; border-radius: 4px; font-weight: bold; }
        .btn-yellow { background-color: var(--brand-yellow); border: none; font-weight: 600; color: #000; }
        .btn-yellow:hover { background-color: #e6af06; }
    </style>

    <div class="category-management-container">
        <div class="d-flex justify-content-between align-items-end mb-4">
            <div>
                <h2 style="color:var(--brand-maroon); font-weight: 700;">Category Management</h2>
                <p class="text-muted">Organize and manage menu categories</p>
            </div>
            <button type="button" class="btn btn-yellow px-4 py-2 shadow-sm">
                <i class="fas fa-plus me-2"></i>Add Category
            </button>
        </div>

        <div class="row g-3 mb-4">
            <div class="col-md-3">
                <div class="card stat-card p-3 text-center">
                    <div class="d-flex justify-content-between align-items-center mb-2">
                         <div class="p-2 rounded bg-danger bg-opacity-10 text-danger"><i class="fas fa-bars"></i></div>
                         <small class="text-muted">Total Categories</small>
                    </div>
                    <div class="text-start"><h2>5</h2></div>
                </div>
            </div>
            </div>

        <div class="row g-2 mb-4">
            <div class="col-md-4">
                <div class="input-group">
                    <span class="input-group-text bg-white border-end-0"><i class="fas fa-search text-muted"></i></span>
                    <input type="text" class="form-control border-start-0" placeholder="Search by category name..." />
                </div>
            </div>
            <div class="col-md-2">
                <select class="form-select"><option>All Status</option></select>
            </div>
            <div class="col-md-2">
                <select class="form-select"><option>Sort by: Date Created</option></select>
            </div>
        </div>

        <div class="row g-4">
            <asp:Repeater ID="rptCategories" runat="server">
                <ItemTemplate>
                    <div class="col-md-4">
                        <div class="card category-card">
                            <div class="category-header">
                                <i class="fas fa-bars fa-2x mb-2 opacity-75"></i>
                                <div class="category-title"><%# Eval("CategoryName") %></div>
                            </div>
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-center mb-2">
                                    <small class="text-muted fw-bold text-uppercase"><%# Eval("ID") %></small>
                                    <span class="status-badge">ACTIVE</span>
                                </div>
                                <p class="text-muted small" style="height: 40px; overflow: hidden; line-height: 1.2;">
                                    <%# Eval("Description") %>
                                </p>
                                <hr class="my-3 opacity-25" />
                                <div class="row">
                                    <div class="col-6">
                                        <small class="text-muted d-block">Items</small>
                                        <h5 class="fw-bold mb-0"><%# Eval("ItemCount") %></h5>
                                    </div>
                                    <div class="col-6 text-end">
                                        <small class="text-muted d-block">Created</small>
                                        <small class="fw-bold">May 2023</small>
                                    </div>
                                </div>
                                <div class="d-flex gap-2 mt-3">
                                    <button type="button" class="btn btn-yellow flex-grow-1"><i class="fas fa-edit me-1"></i> Edit</button>
                                    <button type="button" class="btn btn-outline-secondary btn-sm"><i class="fas fa-eye-slash"></i></button>
                                    <button type="button" class="btn btn-outline-danger btn-sm"><i class="fas fa-trash"></i></button>
                                </div>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
</asp:Content>
