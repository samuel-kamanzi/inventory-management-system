<%@ page import="java.sql.*, java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <title>Stock status</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }
        .container {
            width: 80%;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            text-align: center;
            color: #333;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #4CAF50;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tr:hover {
            background-color: #f1f1f1;
        }
        .back-button {
            display: block;
            width: 100px;
            margin: 20px auto;
            padding: 10px;
            text-align: center;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            font-size: 16px;
        }
        .back-button:hover {
            background-color: #45a049;
        }
        .no-products {
            text-align: center;
            font-size: 18px;
            color: #666;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Stock status</h2>
        <%
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;
            boolean hasProducts = false;
            try {
                Class.forName("org.mariadb.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/inventory", "root", "");
                stmt = conn.createStatement();
                // Updated SQL query to select product_name directly from the stock table
                String sql = "SELECT product_id, product_name, quantity, date_created FROM stock";
                rs = stmt.executeQuery(sql);
                if (rs.isBeforeFirst()) { // Check if there are any rows
                    hasProducts = true;
        %>
                    <table>
                        <thead>
                            <tr>
                                <th>PRODUCT-ID</th>
                                <th>PRODUCT-NAME</th>
                                <th>QUANTITY</th>
                                <th>CREATED-DATE</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                while (rs.next()) {
                            %>
                            <tr>
                                <td><%= rs.getInt("product_id") %></td>
                                <td><%= rs.getString("product_name") %></td>
                                <td><%= rs.getInt("quantity") %></td>
                                <td><%= rs.getDate("date_created") %></td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
            if (!hasProducts) {
        %>
            <p class="no-products">No products found.</p>
        <%
            }
        %>
        <a href="javascript:history.back()" class="back-button">Back</a>
    </div>
</body>
</html>
