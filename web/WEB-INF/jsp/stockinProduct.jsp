<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.DataSource"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Purchase Product</title>
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
        .form-group textarea,
        .form-group select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }

        .form-group input:focus,
        .form-group textarea:focus,
        .form-group select:focus {
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
            text-decoration: none;
        }
    </style>   
</head>   
<body>
    <div class="container">
        <h1>Purchase Product</h1>
        <form action="stockin.htm" method="post">
            <div class="form-group">
                <label for="productid">Product ID</label>
                <select id="productid" name="productid" required>
                    <option value="">Select Product ID</option>
                    <% 
                    // Database connection setup
                    Connection conn = null;
                    PreparedStatement stmt = null;
                    ResultSet rs = null;
                    String dbURL = "jdbc:mariadb://localhost:3306/inventory"; // Update with your MariaDB URL
                    String dbUser = "root"; // Update with your database username
                    String dbPassword = ""; // Update with your database password

                    try {
                        Class.forName("org.mariadb.jdbc.Driver");
                        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
                        String sql = "SELECT product_id, product_name FROM product";
                        stmt = conn.prepareStatement(sql);
                        rs = stmt.executeQuery();
                        while (rs.next()) {
                            String productId = rs.getString("product_id");
                            String productName = rs.getString("product_name");
                    %>
                            <option value="<%= productId %>"><%= productId %> - <%= productName %></option>
                    <% 
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                        if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                    }
                    %>
                </select>
            </div>
            <div class="form-group">
                <label for="quantity">Quantity</label>
                <input type="number" id="quantity" name="quantity" required>
            </div>
            <div class="form-group">
                <label for="price">Price</label>
                <input type="number" id="price" name="price" required>
            </div>
            <div class="form-group">
                <button type="submit" class="btn">Record</button>
            </div>
        </form>
        <a class="back-btn" onclick="window.history.back();">Back</a>
        <div class="message">
            <%= request.getAttribute("message") != null ? request.getAttribute("message") : "" %>
        </div>
    </div>
</body>
</html>
