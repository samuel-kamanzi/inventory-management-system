<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Product</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .container {
            width: 50%;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #f9f9f9;
        }
        h2 {
            text-align: center;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
        }
        .form-group input, .form-group textarea, .form-group select {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
        }
        .form-group button {
            width: 100%;
            padding: 10px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .form-group button:hover {
            background-color: #0056b3;
        }
        .message {
            color: green;
            margin-bottom: 15px;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Edit Product</h2>
        
        <!-- Display success or error message -->
        <div class="message">
            <%= request.getAttribute("message") != null ? request.getAttribute("message") : "" %>
        </div>
        
        <form action="updateProduct" method="post">
            <input type="hidden" name="productId" value="<%= request.getAttribute("productId") %>" />
            
            <div class="form-group">
                <label for="productName">Product Name:</label>
                <input type="text" id="productName" name="productName" value="<%= request.getAttribute("productName") %>" required />
            </div>
            
            <div class="form-group">
                <label for="description">Description:</label>
                <textarea id="description" name="description" rows="4" required><%= request.getAttribute("description") %></textarea>
            </div>
            
            <div class="form-group">
                <label for="category">Category:</label>
                <select id="category" name="category" required>
                    <option value="Electronics" <%= "Electronics".equals(request.getAttribute("category")) ? "selected" : "" %>>Electronics</option>
                    <option value="Clothing" <%= "Clothing".equals(request.getAttribute("category")) ? "selected" : "" %>>Clothing</option>
                    <option value="Furniture" <%= "Furniture".equals(request.getAttribute("category")) ? "selected" : "" %>>Furniture</option>
                    <!-- Add more categories as needed -->
                </select>
            </div>
            
            <div class="form-group">
                <label for="price">Price:</label>
                <input type="number" id="price" name="price" value="<%= request.getAttribute("price") %>" required />
            </div>
            
            <div class="form-group">
                <label for="quantity">Quantity:</label>
                <input type="number" id="quantity" name="quantity" value="<%= request.getAttribute("quantity") %>" required />
            </div>
            
            <div class="form-group">
                <button type="submit">Update Product</button>
            </div>
        </form>
    </div>
</body>
</html>
