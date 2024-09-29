<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Inventory Management</title>
    <link rel="stylesheet" type="text/css" href="styles.css"> <!-- Link to your CSS file -->
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f0f4f8;
            margin: 0;
            padding: 0;
        }
        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #2c3e50;
            padding: 15px 30px;
            color: #ecf0f1;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .navbar h1 {
            margin: 0;
            font-size: 24px;
        }
        .navbar a {
            color: #ecf0f1;
            text-decoration: none;
            margin: 0 15px;
            font-size: 16px;
            transition: color 0.3s;
        }
        .navbar a:hover {
            color: #3498db;
        }
        .navbar .nav-items {
            display: flex;
        }
        .container {
            padding: 30px;
            max-width: 1200px;
            margin: auto;
        }
        .card {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            padding: 20px;
            margin-bottom: 20px;
        }
        .card h2 {
            margin-top: 0;
            color: #2c3e50;
        }
        .card p {
            color: #7f8c8d;
        }
        
         #footer{
            position: absolute;
            
            
            left: 0;
            right: 0;
            text-align: center;
            bottom: 0;
                
        }
    </style>
</head>
<body>
    <div class="navbar">
        <h1>Inventory Management</h1>
        <div class="nav-items">
           <a href="<c:url value='/homeController.htm'/>">Home</a>
            <a href="<c:url value='/productList.htm'/>">Product List</a>
            <a href="<c:url value='/addProduct.htm'/>">Add Product</a>
           
        </div>
    </div>

    <div class="container">
        <!-- Content for each menu item will be loaded here based on the navigation -->
        <div class="card">
              <h1>Welcome to the Inventory Management System</h1>

    <p>This system is designed to help you efficiently manage your inventory with ease and precision. Below is a brief guide to the options available in the menu:

Home: This is your dashboard, where you can get an overview of your inventory management tasks and quickly navigate to the different sections of the system.

Product List: This section provides a comprehensive list of all products currently in your inventory. You can view detailed information, including product IDs, names, quantities, and prices. It's a great way to keep track of what you have in stock.

Add Product: Need to add a new product to your inventory? This section allows you to input new products, complete with essential details like the product ID, name, quantity, and price. This feature ensures that your inventory stays up-to-date with the latest items.

Getting Started: To begin managing your inventory, simply select an option from the menu above. Whether you need to view your current stock, add new products, or perform other inventory-related tasks, this system is here to streamline your workflow and keep your business running smoothly.
        
    </p>
        </div>
    </div>
</body>
</html>
<label id="footer">
        &copy;inventory management system 2024
    </label>