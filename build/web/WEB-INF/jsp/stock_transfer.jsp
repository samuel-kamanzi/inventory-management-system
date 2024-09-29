<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Stock Transfer - Stock Management System</title>
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
    </style>
</head>
<body>
    <header>
        <nav>
            <ul>
                <li><a href="manage_stock.jsp">Stock Management</a></li>
                <li><a href="receive_stock.jsp">Receive Stock</a></li>
                <li><a href="issue_stock.jsp">Issue Stock</a></li>
                <li><a href="stock_transfer.jsp">Stock Transfer</a></li>
            </ul>
        </nav>
    </header>
    <main>
        <h1>Stock Transfer</h1>
        <p>Transfer stock between locations here.</p>
        <form action="process_stock_transfer.jsp" method="post">
            <label for="stockId">Stock ID:</label>
            <input type="text" id="stockId" name="stockId" required>
            
            <label for="stockName">Stock Name:</label>
            <input type="text" id="stockName" name="stockName" required>
            
            <label for="sourceLocation">Source Location:</label>
            <input type="text" id="sourceLocation" name="sourceLocation" required>
            
            <label for="destinationLocation">Destination Location:</label>
            <input type="text" id="destinationLocation" name="destinationLocation" required>
            
            <label for="stockQuantity">Quantity Transferred:</label>
            <input type="number" id="stockQuantity" name="stockQuantity" required>
            
            <button type="submit">Transfer Stock</button>
        </form>
    </main>
</body>
</html>
