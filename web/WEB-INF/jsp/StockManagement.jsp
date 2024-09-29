<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Stock Management - Stock Management System</title>
    <style>
        /* General Styles */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            color: #333;
            background-color: #f4f4f4;
        }

        header {
            background-color: #004d99;
            color: #fff;
            padding: 1rem;
        }

        nav ul {
            list-style: none;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
        }

        nav ul li {
            margin: 0 1rem;
        }

        nav ul li a {
            color: #fff;
            text-decoration: none;
            font-size: 1.2rem;
        }

        nav ul li a:hover {
            text-decoration: underline;
        }

        main {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 1rem;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        h1 {
            color: #004d99;
            font-size: 2rem;
            margin-bottom: 1rem;
        }

        p {
            line-height: 1.6;
            margin-bottom: 1rem;
        }

        /* Form Styles */
        form {
            margin-top: 1rem;
        }

        form label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: bold;
        }

        form input, form select, form textarea {
            width: 100%;
            padding: 0.8rem;
            margin-bottom: 1rem;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        form button {
            padding: 0.8rem 1.2rem;
            border: none;
            border-radius: 4px;
            background-color: #004d99;
            color: #fff;
            font-size: 1rem;
            cursor: pointer;
        }

        form button:hover {
            background-color: #003366;
        }
        
        .subtle-text {
            color: rgba(0, 0, 0, 0.3);
            text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.5);
            font-size: 16px;
            line-height: 1.6;
        }

        .subtle-text h1 {
            font-size: 24px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <header>
        <nav>
            <ul>
                  <li> <a href="<c:url value='/homeController.htm'/>">Home</a></li>
             
                <li> <a href="<c:url value='/stockinProduct.htm'/>">stock in</a></li>
                <li><a href="<c:url value='/stockoutProduct.htm'/>">stock out</a></li>
                  <li><a href="<c:url value='/stockinList.htm'/>">view stock in</a></li>
                    <li><a href="<c:url value='/stockoutList.htm'/>">view stock out</a></li>
                <li><a href="<c:url value='/stockList.htm'/>">Stock status</a></li>
            </ul>
        </nav>
    </header>
    <main>
   

        <h1 class="subtle-text">Welcome to the Inventory Management System</h1>

        <p class="subtle-text">This system is designed to help you efficiently manage your inventory with ease and precision. Below is a brief guide to the options available in the menu:

Home: This is your dashboard, where you can get an overview of your inventory management tasks and quickly navigate to the different sections of the system.

Product List: This section provides a comprehensive list of all products currently in your inventory. You can view detailed information, including product IDs, names, quantities, and prices. It's a great way to keep track of what you have in stock.

Add Product: Need to add a new product to your inventory? This section allows you to input new products, complete with essential details like the product ID, name, quantity, and price. This feature ensures that your inventory stays up-to-date with the latest items.

Getting Started: To begin managing your inventory, simply select an option from the menu above. Whether you need to view your current stock, add new products, or perform other inventory-related tasks, this system is here to streamline your workflow and keep your business running smoothly.
        
    </p>
    </main>
</body>
</html>
