<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/SuperAdmin.Master" AutoEventWireup="true" CodeBehind="Categories.aspx.cs" Inherits="TasteNet.Users.SuperAdmin.Categories" %>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@400;600;700&display=swap" rel="stylesheet">

    <style>
        body { font-family: 'Quicksand', sans-serif; background-color: #fdfaf7; }
        .card-shadow { box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05); }
        .btn-yellow { background-color: #ffd43b; }
        .text-maroon { color: #800020; }
        .bg-maroon { background-color: #800020; }
        .bg-maroon-light { background-color: #a33b4d; }
        .bg-maroon-pale { background-color: #cc6677; }
    </style>

    <div class="p-8">
        <div class="flex justify-between items-center mb-8">
            <div>
                <h1 class="text-4xl font-bold text-gray-800">Category Management</h1>
                <p class="text-gray-500 mt-1">Organize and manage menu categories</p>
            </div>
            <button class="btn-yellow hover:bg-yellow-400 text-gray-800 font-bold py-3 px-6 rounded-xl flex items-center shadow-sm">
                <span class="mr-2 text-xl">+</span> Add Category
            </button>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-10">
            <div class="bg-white p-6 rounded-2xl card-shadow flex flex-col justify-between h-40 relative">
                <div class="flex justify-between items-start">
                    <div class="bg-maroon p-2 rounded-full text-white">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" /></svg>
                    </div>
                    <span class="text-gray-500 font-semibold text-sm">Total Categories</span>
                </div>
                <h2 class="text-6xl font-bold text-maroon">5</h2>
            </div>

            <div class="bg-white p-6 rounded-2xl card-shadow flex flex-col justify-between h-40">
                <div class="flex justify-between items-start">
                    <div class="bg-green-100 p-2 rounded-full text-green-600">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" /><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" /></svg>
                    </div>
                    <span class="text-gray-500 font-semibold text-sm">Active</span>
                </div>
                <h2 class="text-6xl font-bold text-maroon">3</h2>
            </div>

            <div class="bg-white p-6 rounded-2xl card-shadow flex flex-col justify-between h-40">
                <div class="flex justify-between items-start">
                    <div class="bg-gray-200 p-2 rounded-full text-gray-500">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13.875 18.825A10.05 10.05 0 0112 19c-4.478 0-8.268-2.943-9.543-7a9.97 9.97 0 011.563-3.029m5.858.908a3 3 0 114.243 4.243M9.878 9.878l4.242 4.242M9.88 9.88l-3.29-3.29m7.532 7.532l3.29 3.29M3 3l18 18" /></svg>
                    </div>
                    <span class="text-gray-500 font-semibold text-sm">Hidden</span>
                </div>
                <h2 class="text-6xl font-bold text-maroon">2</h2>
            </div>

            <div class="bg-white p-6 rounded-2xl card-shadow flex flex-col justify-between h-40">
                <div class="flex justify-between items-start">
                    <div class="bg-blue-100 p-2 rounded-full text-blue-400">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16m-7 6h7" /></svg>
                    </div>
                    <span class="text-gray-500 font-semibold text-sm">Total Items</span>
                </div>
                <h2 class="text-6xl font-bold text-maroon">17</h2>
            </div>
        </div>

        <div class="flex gap-4 mb-8">
            <div class="relative flex-grow">
                <span class="absolute inset-y-0 left-0 pl-3 flex items-center text-gray-400">
                    <svg class="h-5 w-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path></svg>
                </span>
                <input type="text" placeholder="Search by category name or description..." class="w-full pl-10 pr-4 py-3 border border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-maroon-pale" />
            </div>
            <select class="border border-gray-200 rounded-xl px-4 py-3 bg-white text-gray-600 focus:outline-none">
                <option>All Status</option>
            </select>
            <select class="border border-gray-200 rounded-xl px-4 py-3 bg-white text-gray-600 focus:outline-none">
                <option>Sort by: Date Created</option>
            </select>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
            <div class="bg-white rounded-3xl overflow-hidden card-shadow">
                <div class="bg-maroon h-44 flex flex-col items-center justify-center text-white p-4">
                    <svg class="h-10 w-10 mb-2 opacity-80" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16"></path></svg>
                    <h3 class="text-2xl font-bold">Sizzling Specials</h3>
                </div>
                <div class="p-6">
                    <div class="flex justify-between items-center mb-4">
                        <span class="text-maroon font-bold">CAT-001</span>
                        <span class="bg-green-100 text-green-600 text-xs px-3 py-1 rounded-full font-bold">ACTIVE</span>
                    </div>
                    <p class="text-gray-500 text-sm leading-relaxed">Premium sizzling plate meals featuring authentic flavors and high-quality ingredients.</p>
                </div>
            </div>

            <div class="bg-white rounded-3xl overflow-hidden card-shadow">
                <div class="bg-maroon-light h-44 flex flex-col items-center justify-center text-white p-4">
                     <svg class="h-10 w-10 mb-2 opacity-80" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16"></path></svg>
                    <h3 class="text-2xl font-bold">Silog Meals</h3>
                </div>
                <div class="p-6">
                    <div class="flex justify-between items-center mb-4">
                        <span class="text-maroon font-bold">CAT-002</span>
                        <span class="bg-green-100 text-green-600 text-xs px-3 py-1 rounded-full font-bold">ACTIVE</span>
                    </div>
                    <p class="text-gray-500 text-sm leading-relaxed">Classic Filipino breakfast combinations with rice, egg, and your choice of protein.</p>
                </div>
            </div>

            <div class="bg-white rounded-3xl overflow-hidden card-shadow">
                <div class="bg-maroon-pale h-44 flex flex-col items-center justify-center text-white p-4">
                     <svg class="h-10 w-10 mb-2 opacity-80" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16"></path></svg>
                    <h3 class="text-2xl font-bold">Special Meals</h3>
                </div>
                <div class="p-6">
                    <div class="flex justify-between items-center mb-4">
                        <span class="text-maroon font-bold">CAT-003</span>
                        <span class="bg-green-100 text-green-600 text-xs px-3 py-1 rounded-full font-bold">ACTIVE</span>
                    </div>
                    <p class="text-gray-500 text-sm leading-relaxed">Comfort food and traditional Filipino favorites prepared with a special twist.</p>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
