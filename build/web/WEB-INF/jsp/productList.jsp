<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Product List</title>
    <style>
        
        .action-buttons {
    display: flex;
    gap: 8px;
    align-items: center;
    justify-content: center;
}

.action-button {
    padding: 8px 12px;
    border-radius: 4px;
    text-align: center;
    cursor: pointer;
    font-size: 12px;
    color: #fff;
    text-decoration: none;
    display: inline-flex;
    align-items: center;
    justify-content: center;
}

.update-button {
    background-color: #28a745;
}

.delete-button {
    background-color: #dc3545;
}

.update-form {
    display: none;
    margin-top: 20px;
    background-color: #f9f9f9;
    padding: 15px;
    border-radius: 4px;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

.update-form label {
    display: block;
    margin-bottom: 6px;
    font-size: 12px;
}

.update-form input[type="text"] {
    width: calc(100% - 22px);
    padding: 8px;
    margin-bottom: 10px;
    border: 1px solid #ccc;
    border-radius: 4px;
    font-size: 12px;
}

.update-form button {
    padding: 8px 16px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 12px;
    color: #fff;
}

.save-button {
    background-color: #007bff;
}

.cancel-button {
    background-color: #dc3545;
    margin-left: 10px;
}

.back-button {
    display: inline-block;
    margin-top: 20px;
    padding: 10px 18px;
    background-color: #007bff;
    color: #fff;
    text-decoration: none;
    border-radius: 4px;
    font-size: 14px;
}

.no-products {
    text-align: center;
    color: #777;
    font-size: 14px;
}

        
        
        
        
        
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f8;
            margin: 0;
            padding: 20px;
        }
        .container {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            max-width: 900px;
            margin: 0 auto;
        }
        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
            font-size: 14px;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
            color: #666;
        }
        .action-buttons {
            display: flex;
            gap: 8px;
            justify-content: center;
        }
        .action-button {
            padding: 8px 12px;
            border-radius: 4px;
            text-align: center;
            cursor: pointer;
            font-size: 12px;
            color: #fff;
            text-decoration: none;
        }
        .update-button {
            background-color: #28a745;
        }
        .delete-button {
            background-color: #dc3545;
        }
        .update-form {
            display: none;
            margin-top: 20px;
            background-color: #f9f9f9;
            padding: 15px;
            border-radius: 4px;
        }
        .update-form label {
            display: block;
            margin-bottom: 6px;
            font-size: 12px;
        }
        .update-form input[type="text"] {
            width: calc(100% - 22px);
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 12px;
        }
        .update-form button {
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 12px;
            color: #fff;
        }
        .save-button {
            background-color: #007bff;
        }
        .cancel-button {
            background-color: #dc3545;
            margin-left: 10px;
        }
        .back-button {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 18px;
            background-color: #007bff;
            color: #fff;
            text-decoration: none;
            border-radius: 4px;
            font-size: 14px;
        }
        .no-products {
            text-align: center;
            color: #777;
            font-size: 14px;
        }
        .back-btn {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #007bff;
            color: #fff;
            text-decoration: none;
            border-radius: 4px;
            font-size: 14px;
            text-align: center;
            cursor: pointer;
            border: 1px solid #007bff;
            transition: background-color 0.3s, color 0.3s;
        }
        .back-btn:hover {
            background-color: #0056b3;
            color: #e0e0e0;
        }
    </style>
    <script>
        let currentOpenFormId = null;

        function confirmDelete(productId) {
            if (confirm('Are you sure you want to delete this product?')) {
                document.getElementById('deleteForm_' + productId).submit();
            }
        }

        function showUpdateForm(productId) {
            if (currentOpenFormId && currentOpenFormId !== productId) {
                hideUpdateForm(currentOpenFormId);
            }

            const form = document.getElementById('updateForm');
            form.style.display = 'block';

            // Populate the form fields with existing data
            document.getElementById('product_name').value = document.getElementById('product_name_text_' + productId).textContent;
            document.getElementById('description').value = document.getElementById('description_text_' + productId).textContent;
            document.getElementById('category').value = document.getElementById('category_text_' + productId).textContent;
            document.getElementById('status').value = document.getElementById('status_text_' + productId).textContent;
            document.getElementById('update_product_id').value = productId;

            currentOpenFormId = productId;
        }

        function hideUpdateForm(productId) {
            const form = document.getElementById('updateForm');
            form.style.display = 'none';
            currentOpenFormId = null;
        }
    </script>
</head>
<body>
<div class="container">
    <h2>List all Products</h2>

    <%
        String dbURL = "jdbc:mariadb://localhost:3306/inventory";
        String dbUser = "root";
        String dbPassword = "";
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName("org.mariadb.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
            stmt = conn.createStatement();

            // Handle update request
            if (request.getParameter("updateProduct") != null) {
                String productId = request.getParameter("product_id");
                String productName = request.getParameter("product_name");
                String description = request.getParameter("description");
                String category = request.getParameter("category");
                String status = request.getParameter("status");

                String updateQuery = "UPDATE product SET product_name='" + productName + "', description='" + description + "', category='" + category + "', status='" + status + "' WHERE product_id=" + productId;
                stmt.executeUpdate(updateQuery);

                out.println("<p style='color:green;'>Product updated successfully!</p>");
            }

            // Handle delete request
            if (request.getParameter("deleteProduct") != null) {
                String productId = request.getParameter("product_id");

                String deleteQuery = "DELETE FROM product WHERE product_id=" + productId;
                stmt.executeUpdate(deleteQuery);

                out.println("<p style='color:red;'>Product deleted successfully!</p>");
            }

            // Fetch products to display
            String query = "SELECT * FROM product";
            rs = stmt.executeQuery(query);

            if (rs.next()) {
    %>

    <table>
        <thead>
            <tr>
                <th>PRODUCT-ID</th>
                <th>PRODUCT-NAME</th>
                <th>PRODUCT-DESCRIPTION</th>
                <th>PRODUCT-CATEGORY</th>
                <th>DATE-ADDED</th>
                <th>STATUS</th>
                <th>ACTIONS</th>
            </tr>
        </thead>
        <tbody>
            <%
                do {
                    int productId = rs.getInt("product_id");
            %>
            <tr>
                <td><%= productId %></td>
                <td id="product_name_text_<%= productId %>"><%= rs.getString("product_name") %></td>
                <td id="description_text_<%= productId %>"><%= rs.getString("description") %></td>
                <td id="category_text_<%= productId %>"><%= rs.getString("category") %></td>
                <td><%= rs.getDate("date_added") %></td>
                <td id="status_text_<%= productId %>"><%= rs.getString("status") %></td>
                <td class="action-buttons">
                    <a href="javascript:showUpdateForm(<%= productId %>)" class="action-button update-button">Update</a>
                    <form id="deleteForm_<%= productId %>" action="" method="post" style="display:inline;">
                        <input type="hidden" name="deleteProduct" value="true"/>
                        <input type="hidden" name="product_id" value="<%= productId %>"/>
                        <a href="javascript:confirmDelete(<%= productId %>)" class="action-button delete-button">Delete</a>
                    </form>
                </td>
            </tr>
            <%
                } while (rs.next());
            %>
        </tbody>
    </table>
    <%
        } else {
    %>
        <p class="no-products">No products found.</p>
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

    <div id="updateForm" class="update-form">
        <form action="" method="post">
            <input type="hidden" name="updateProduct" value="true"/>
            <input type="hidden" id="update_product_id" name="product_id"/>
            <label for="product_name">Product Name</label>
            <input type="text" id="product_name" name="product_name" required/>

            <label for="description">Description</label>
            <input type="text" id="description" name="description" required/>

            <label for="category">Category</label>
            <input type="text" id="category" name="category" required/>

            <label for="status">Status</label>
            <input type="text" id="status" name="status" required/>

            <button type="submit" class="save-button">Save</button>
            <button type="button" class="cancel-button" onclick="hideUpdateForm()">Cancel</button>
        </form>
    </div>

       <button class="back-button" onclick="window.history.back();">Back</button>
</div>
</body>
</html>
