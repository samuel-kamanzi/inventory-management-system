<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Product</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 50%;
            margin: 0 auto;
            padding: 20px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        h1 {
            font-size: 24px;
            margin-bottom: 20px;
            color: #333;
            text-align: center;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
            color: #555;
        }

        .form-group input,
        .form-group textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }

        .form-group input:focus,
        .form-group textarea:focus {
            border-color: #007bff;
            outline: none;
            box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
        }

        .btn {
            background-color: #007bff;
            color: #fff;
            border: none;
            padding: 10px 15px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }

        .btn:hover {
            background-color: #0056b3;
        }

        .back-btn {
            display: block;
            margin-top: 20px;
            text-align: center;
            color: #007bff;
            text-decoration: none;
            cursor: pointer;
            font-size: 16px;
            background: #f4f4f9;
            border: 1px solid #ddd;
            padding: 10px;
            border-radius: 4px;
            transition: background-color 0.3s;
        }

        .back-btn:hover {
            text-decoration: underline;
            background-color: #e2e6ea;
        }

        .message {
            font-size: 18px;
            color: #333;
            text-align: center;
            margin-top: 20px;
        }
        a:hover{
            text-decoration: none
        }
    </style>   
</head>   
<body>
    <div class="container">
        <h1>Add New Product</h1>
        <form action="addproductController.htm" method="post">
            <div class="form-group">
                <label for="productName">Product Name</label>
                <input type="text" id="productName" name="productName" required>
            </div>
            <div class="form-group">
                <label for="description">Description</label>
                <textarea id="description" name="description" rows="4" required></textarea>
            </div>
            <div class="form-group">
                <label for="category">Category</label>
                <input type="text" id="price" name="category"  required><br><br><br>
          
            <div class="form-group">
                <button type="submit" class="btn">Add Product</button>
            </div>
        </form>
        <a class="back-btn" onclick="window.history.back();">Back</a>
<div class="message">
    <%= request.getAttribute("message") != null ? request.getAttribute("message") : "" %>
</div>

    </div>
</body>
</html>
