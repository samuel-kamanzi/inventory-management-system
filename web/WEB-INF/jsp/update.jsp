<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String productId = request.getParameter("product_id");
    String productName = request.getParameter("product_name");
    String description = request.getParameter("description");
    String category = request.getParameter("category");
    String status = request.getParameter("status");

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        // Load the JDBC driver (this is just an example, replace it with your own driver)
        Class.forName("com.mysql.cj.jdbc.Driver");
        
        // Establish the connection (replace with your actual database URL, username, and password)
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/your_database", "username", "password");

        // Prepare the SQL update query
        String sql = "UPDATE products SET product_name = ?, description = ?, category = ?, status = ? WHERE product_id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, productName);
        pstmt.setString(2, description);
        pstmt.setString(3, category);
        pstmt.setString(4, status);
        pstmt.setString(5, productId);

        // Execute the update
        int rowsUpdated = pstmt.executeUpdate();

        // Check if the update was successful
        if (rowsUpdated > 0) {
            out.println("<script>alert('Product updated successfully!');</script>");
        } else {
            out.println("<script>alert('Error updating product. Please try again.');</script>");
        }

    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('An error occurred while updating the product.');</script>");
    } finally {
        if (pstmt != null) {
            try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
        if (conn != null) {
            try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }

    // Redirect back to the product list page
    response.sendRedirect("productList.jsp");
%>
