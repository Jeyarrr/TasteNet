<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/SuperAdmin.Master" AutoEventWireup="true" CodeBehind="RecipeManager.aspx.cs" Inherits="TasteNet.Users.SuperAdmin.RecipeManager" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<style>
    *{margin:0;padding:0;box-sizing:border-box;}
    :root{
        --maroon:#6b0d1e;--maroon-dark:#5a0b19;--cream:#fffaf3;
        --text-dark:#4a0e0e;--muted:#8a6d6d;--green:#2d9d78;
        --orange:#d97706;--red:#b91c1c;--red-light:#fee2e2;
        --border:#e2d1d1;--bg-light:#f3ebe0;--bg-lighter:#f9f4ee;--white:#ffffff;
        --shadow:0 10px 30px rgba(107,13,30,0.06);
        --radius:12px;--radius-sm:8px;--transition:0.25s ease;
    }
    body,form{background:var(--cream)!important;font-family:'Poppins',sans-serif;}
    #rmWrapper{max-width:1400px;margin:0 auto;padding:24px 30px;min-height:100vh;}
    .rm-header{display:flex;justify-content:space-between;align-items:center;margin-bottom:28px;flex-wrap:wrap;gap:12px;}
    .rm-header h2{font-size:26px;font-weight:700;color:var(--text-dark);letter-spacing:-0.5px;}
    .rm-header p{font-size:13px;color:var(--muted);margin-top:4px;}
    .rm-layout{display:grid;grid-template-columns:340px 1fr;gap:24px;align-items:start;}
    .rm-panel{background:var(--white);border-radius:var(--radius);box-shadow:var(--shadow);overflow:hidden;}
    .rm-panel-head{padding:18px 20px;border-bottom:1px solid var(--bg-light);display:flex;justify-content:space-between;align-items:center;}
    .rm-panel-head h3{font-size:14px;font-weight:600;color:var(--text-dark);}
    .rm-panel-body{padding:12px;}
    .rm-search{position:relative;margin-bottom:10px;}
    .rm-search input{width:100%;padding:9px 14px 9px 36px;border:1.5px solid var(--border);border-radius:var(--radius-sm);font-family:'Poppins',sans-serif;font-size:13px;outline:none;transition:all var(--transition);}
    .rm-search input:focus{border-color:var(--maroon);box-shadow:0 0 0 3px rgba(107,13,30,0.08);}
    .rm-search i{position:absolute;left:11px;top:50%;transform:translateY(-50%);color:var(--muted);font-size:13px;}
    .rm-menu-item{display:flex;align-items:center;justify-content:space-between;padding:11px 12px;border-radius:var(--radius-sm);cursor:pointer;transition:all var(--transition);border:1.5px solid transparent;margin-bottom:4px;text-decoration:none;width:100%;}
    .rm-menu-item:hover{background:var(--bg-lighter);border-color:var(--border);}
    .rm-menu-item.active{background:#f9ecee;border-color:var(--maroon);}
    .rm-menu-left{display:flex;align-items:center;gap:10px;}
    .rm-avatar{width:36px;height:36px;border-radius:var(--radius-sm);background:var(--bg-light);display:flex;align-items:center;justify-content:center;font-size:13px;font-weight:600;color:var(--maroon);flex-shrink:0;}
    .rm-menu-item.active .rm-avatar{background:var(--maroon);color:white;}
    .rm-menu-name{font-size:13px;font-weight:500;color:var(--text-dark);}
    .rm-menu-id{font-size:11px;color:var(--muted);}
    .rm-count{font-size:11px;background:var(--bg-light);color:var(--muted);padding:2px 8px;border-radius:20px;font-weight:500;}
    .rm-menu-item.active .rm-count{background:rgba(107,13,30,0.1);color:var(--maroon);}
    .rm-no-recipe{font-size:11px;color:var(--orange);}
    .rm-empty{display:flex;flex-direction:column;align-items:center;justify-content:center;padding:70px 20px;text-align:center;color:var(--muted);}
    .rm-empty i{font-size:42px;margin-bottom:14px;opacity:0.25;}
    .rm-empty h3{font-size:15px;font-weight:600;color:var(--text-dark);margin-bottom:6px;}
    .rm-empty p{font-size:13px;}
    .rm-editor-head{padding:20px 24px;border-bottom:1px solid var(--bg-light);}
    .rm-editor-head h3{font-size:16px;font-weight:600;color:var(--text-dark);}
    .rm-editor-head p{font-size:12px;color:var(--muted);margin-top:3px;}
    .rm-editor-body{padding:20px 24px;}
    .rm-add-row{display:grid;grid-template-columns:1fr 110px 80px auto;gap:10px;align-items:end;margin-bottom:20px;padding:16px;background:var(--bg-lighter);border-radius:var(--radius-sm);border:1.5px dashed var(--border);}
    .rm-add-row label{font-size:11px;font-weight:600;color:var(--muted);text-transform:uppercase;letter-spacing:0.4px;display:block;margin-bottom:5px;}
    .rm-control{width:100%;padding:9px 12px;border:1.5px solid var(--border);border-radius:var(--radius-sm);font-family:'Poppins',sans-serif;font-size:13px;outline:none;background:white;transition:all var(--transition);color:var(--text-dark);}
    .rm-control:focus{border-color:var(--maroon);box-shadow:0 0 0 3px rgba(107,13,30,0.08);}
    .rm-btn-add{background:var(--maroon);color:white;border:none;padding:9px 16px;border-radius:var(--radius-sm);font-family:'Poppins',sans-serif;font-size:13px;font-weight:600;cursor:pointer;white-space:nowrap;transition:all var(--transition);align-self:flex-end;}
    .rm-btn-add:hover{background:var(--maroon-dark);}
    .rm-table{width:100%;border-collapse:collapse;}
    .rm-table th{text-align:left;font-size:11px;font-weight:600;color:var(--muted);text-transform:uppercase;letter-spacing:0.4px;padding:8px 12px;border-bottom:2px solid var(--bg-light);}
    .rm-table td{padding:12px;border-bottom:1px solid var(--bg-lighter);font-size:13px;color:var(--text-dark);vertical-align:middle;}
    .rm-table tr:last-child td{border-bottom:none;}
    .rm-table tbody tr:hover td{background:var(--bg-lighter);}
    .rm-ing-name{font-weight:500;}
    .rm-unit{color:var(--muted);font-size:12px;}
    .rm-qty{background:var(--bg-light);color:var(--text-dark);padding:3px 10px;border-radius:20px;font-weight:600;font-size:12px;}
    .rm-empty-table{text-align:center;padding:32px;color:var(--muted);font-size:13px;}
    .rm-del-btn{background:none;border:none;color:var(--red);cursor:pointer;padding:6px 8px;border-radius:6px;transition:all var(--transition);font-size:13px;}
    .rm-del-btn:hover{background:var(--red-light);}
    .rm-toast{position:fixed;top:20px;right:20px;padding:14px 20px;border-radius:var(--radius-sm);color:white;z-index:9999;display:flex;align-items:center;gap:10px;font-family:'Poppins',sans-serif;font-size:13px;font-weight:500;animation:rmSlideIn 0.3s ease;max-width:320px;box-shadow:0 8px 24px rgba(0,0,0,0.15);}
    @keyframes rmSlideIn{from{transform:translateX(110%);opacity:0}to{transform:translateX(0);opacity:1}}
    @keyframes rmSlideOut{from{transform:translateX(0);opacity:1}to{transform:translateX(110%);opacity:0}}
    .rm-overlay{display:none;position:fixed;inset:0;background:rgba(0,0,0,0.45);z-index:8000;align-items:center;justify-content:center;}
    .rm-overlay.show{display:flex;}
    .rm-confirm{background:white;border-radius:var(--radius);padding:30px;max-width:360px;width:90%;text-align:center;}
    .rm-confirm i{font-size:36px;color:var(--red);display:block;margin-bottom:12px;}
    .rm-confirm h4{font-size:16px;font-weight:600;color:var(--text-dark);margin-bottom:6px;}
    .rm-confirm p{font-size:13px;color:var(--muted);margin-bottom:20px;}
    .rm-confirm-btns{display:flex;gap:10px;justify-content:center;}
    .rm-btn-yes{background:var(--red);color:white;border:none;padding:9px 22px;border-radius:var(--radius-sm);font-family:'Poppins',sans-serif;font-size:13px;font-weight:600;cursor:pointer;}
    .rm-btn-no{background:transparent;color:var(--text-dark);border:1.5px solid var(--border);padding:9px 22px;border-radius:var(--radius-sm);font-family:'Poppins',sans-serif;font-size:13px;font-weight:600;cursor:pointer;}
    .rm-btn-no:hover{background:var(--bg-lighter);}
    @media(max-width:900px){.rm-layout{grid-template-columns:1fr;}.rm-add-row{grid-template-columns:1fr 1fr;}}
</style>

<asp:HiddenField ID="hfSelectedMenuID" runat="server" Value="0" />

<div id="rmWrapper">
    <div class="rm-header">
        <div>
            <h2><i class="fas fa-book-open" style="color:var(--maroon);margin-right:10px;"></i>Recipe Manager</h2>
            <p>Set up ingredients for each menu item — deducted automatically when an order starts</p>
        </div>
    </div>

    <div class="rm-layout">

        <!-- LEFT: Menu list -->
        <div class="rm-panel">
            <div class="rm-panel-head">
                <h3><i class="fas fa-utensils" style="margin-right:6px;color:var(--maroon);"></i>Menu Items</h3>
                <span style="font-size:12px;color:var(--muted);"><asp:Literal ID="litMenuCount" runat="server" /> items</span>
            </div>
            <div class="rm-panel-body">
                <div class="rm-search">
                    <i class="fas fa-search"></i>
                    <input type="text" placeholder="Search menu..." onkeyup="rmFilterMenu(this.value)" />
                </div>
                <div id="rmMenuList">
                    <asp:Repeater ID="rptMenuList" runat="server" OnItemCommand="rptMenuList_ItemCommand">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnSelectMenu" runat="server"
                                CommandName="SelectMenu"
                                CommandArgument='<%# Eval("MenuID") %>'
                                CssClass='<%# "rm-menu-item" + (Eval("MenuID").ToString() == hfSelectedMenuID.Value ? " active" : "") %>'
                                style="text-decoration:none;">
                                <div class="rm-menu-left">
                                    <div class="rm-avatar"><%# GetInitials(Eval("FoodName").ToString()) %></div>
                                    <div>
                                        <div class="rm-menu-name"><%# Eval("FoodName") %></div>
                                        <div class="rm-menu-id">MenuID: <%# Eval("MenuID") %></div>
                                    </div>
                                </div>
                                <div>
                                    <%# Convert.ToInt32(Eval("RecipeCount")) > 0
                                        ? "<span class='rm-count'>" + Eval("RecipeCount") + " ingredients</span>"
                                        : "<span class='rm-no-recipe'><i class='fas fa-exclamation-circle'></i> No recipe</span>" %>
                                </div>
                            </asp:LinkButton>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </div>

        <!-- RIGHT: Editor -->
        <div class="rm-panel">

            <asp:Panel ID="pnlEmpty" runat="server" Visible="true">
                <div class="rm-empty">
                    <i class="fas fa-hand-pointer"></i>
                    <h3>Select a menu item</h3>
                    <p>Click any dish on the left to set up or edit its ingredients</p>
                </div>
            </asp:Panel>

            <asp:Panel ID="pnlEditor" runat="server" Visible="true" Style="display:none;">
                <div class="rm-editor-head">
                    <h3><asp:Literal ID="litMenuName" runat="server" /></h3>
                    <p>Add every ingredient this dish uses — quantity needed per 1 serving</p>
                </div>
                <div class="rm-editor-body">

                    <!-- Add row -->
                    <div class="rm-add-row">
                        <div>
                            <label>Ingredient</label>
                            <asp:DropDownList ID="ddlIngredient" runat="server" CssClass="rm-control"
                                onchange="rmSyncUnit(this)" />
                        </div>
                        <div>
                            <label>Qty / serving</label>
                            <asp:TextBox ID="txtQty" runat="server" CssClass="rm-control" Text="1" TextMode="Number" />
                        </div>
                        <div>
                            <label>Unit</label>
                            <asp:TextBox ID="txtUnit" runat="server" CssClass="rm-control" ReadOnly="true"
                                style="background:var(--bg-lighter);color:var(--muted);cursor:default;" />
                        </div>
                        <asp:Button ID="btnAddIngredient" runat="server" Text="＋ Add"
                            CssClass="rm-btn-add" OnClick="btnAddIngredient_Click" />
                    </div>

                    <!-- Ingredients table -->
                    <table class="rm-table">
                        <thead>
                            <tr>
                                <th>Ingredient</th>
                                <th>Qty per serving</th>
                                <th>Unit</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="rptRecipeItems" runat="server" OnItemCommand="rptRecipeItems_ItemCommand">
                                <ItemTemplate>
                                    <tr>
                                        <td><span class="rm-ing-name"><%# Eval("ItemName") %></span></td>
                                        <td><span class="rm-qty"><%# Eval("QuantityRequired") %></span></td>
                                        <td><span class="rm-unit"><%# Eval("UnitOfMeasure") %></span></td>
                                        <td>
                                            <asp:LinkButton ID="btnRemove" runat="server"
                                                CssClass="rm-del-btn"
                                                CommandName="RemoveIngredient"
                                                CommandArgument='<%# Eval("RecipeID") %>'
                                                OnClientClick="return rmConfirmDelete(this);"
                                                ToolTip="Remove ingredient">
                                                <i class="fas fa-trash-alt"></i>
                                            </asp:LinkButton>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <asp:Panel ID="pnlNoIngredients" runat="server"
                                        Visible='<%# rptRecipeItems.Items.Count == 0 %>'>
                                        <tr>
                                            <td colspan="4" class="rm-empty-table">
                                                <i class="fas fa-leaf" style="font-size:22px;opacity:0.2;display:block;margin-bottom:8px;"></i>
                                                No ingredients added yet — use the form above
                                            </td>
                                        </tr>
                                    </asp:Panel>
                                </FooterTemplate>
                            </asp:Repeater>
                        </tbody>
                    </table>
                </div>
            </asp:Panel>
        </div>
    </div>

    <!-- Delete confirm overlay -->
    <div class="rm-overlay" id="rmDeleteOverlay">
        <div class="rm-confirm">
            <i class="fas fa-trash-alt"></i>
            <h4>Remove ingredient?</h4>
            <p>This ingredient will no longer be deducted when this dish is ordered.</p>
            <div class="rm-confirm-btns">
                <button class="rm-btn-yes" id="rmBtnYes">Yes, remove</button>
                <button class="rm-btn-no" onclick="rmCloseOverlay()">Cancel</button>
            </div>
        </div>
    </div>

    <asp:Label ID="lblToast" runat="server" Style="display:none;" />
</div>

<script type="text/javascript">
    // ── Unit auto-fill ───────────────────────────────────────────────
    function rmSyncUnit(ddl) {
        var val = ddl.options[ddl.selectedIndex].value;
        var box = document.getElementById('<%= txtUnit.ClientID %>');
        if (box) box.value = (typeof rmUnitMap !== 'undefined' && rmUnitMap[val]) ? rmUnitMap[val] : '';
    }

    window.addEventListener('load', function () {
        var ddl = document.getElementById('<%= ddlIngredient.ClientID %>');
        if (ddl) rmSyncUnit(ddl);

        var lbl = document.getElementById('<%= lblToast.ClientID %>');
        if (lbl && lbl.innerText.trim()) {
            var parts = lbl.innerText.split('|');
            if (parts.length === 2) rmShowToast(parts[0], parts[1]);
            lbl.innerText = '';
        }
    });

    // ── Menu search ──────────────────────────────────────────────────
    function rmFilterMenu(val) {
        val = val.toLowerCase();
        document.querySelectorAll('.rm-menu-item').forEach(function (item) {
            var name = item.querySelector('.rm-menu-name');
            if (name) item.style.display = name.textContent.toLowerCase().includes(val) ? '' : 'none';
        });
    }

    // ── Delete confirm ───────────────────────────────────────────────
    var _rmPendingHref = null;

    function rmConfirmDelete(btn) {
        _rmPendingHref = btn.href; // e.g. javascript:__doPostBack('ctl00$...$btnRemove','')
        document.getElementById('rmDeleteOverlay').classList.add('show');
        return false;
    }

    document.getElementById('rmBtnYes').addEventListener('click', function () {
        rmCloseOverlay();
        if (_rmPendingHref) {
            // Strip "javascript:" prefix and execute
            var code = _rmPendingHref.replace(/^javascript:/i, '');
            eval(code);
            _rmPendingHref = null;
        }
    });

    function rmCloseOverlay() {
        document.getElementById('rmDeleteOverlay').classList.remove('show');
    }

    window.addEventListener('click', function (e) {
        var ov = document.getElementById('rmDeleteOverlay');
        if (e.target === ov) rmCloseOverlay();
    });

    // ── Toast ────────────────────────────────────────────────────────
    function rmShowToast(msg, type) {
        var colors = { success: '#2d9d78', error: '#b91c1c', warning: '#d97706' };
        var icons = { success: 'fa-check-circle', error: 'fa-exclamation-circle', warning: 'fa-exclamation-triangle' };
        var t = document.createElement('div');
        t.className = 'rm-toast';
        t.style.background = colors[type] || colors.success;
        t.innerHTML = '<i class="fas ' + (icons[type] || icons.success) + '"></i><span>' + msg + '</span>';
        document.body.appendChild(t);
        setTimeout(function () {
            t.style.animation = 'rmSlideOut 0.3s ease forwards';
            setTimeout(function () { if (t.parentNode) t.parentNode.removeChild(t); }, 300);
        }, 3000);
    }
</script>

</asp:Content>
