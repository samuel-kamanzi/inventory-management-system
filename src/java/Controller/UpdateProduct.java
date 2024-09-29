
package Controller;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;


public class UpdateProduct extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String productId = request.getParameter("product_id");
        String productName = request.getParameter("product_name");
        String description = request.getParameter("description");
        String category = request.getParameter("category");
        String status = request.getParameter("status");

        Connection conn = null;
        PreparedStatement pstmt = null;
        String updateMessage = null;
        String errorMessage = null;

        try {
            // Load database driver
            Class.forName("org.mariadb.jdbc.Driver");
            
            // Establish database connection
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/inventory", "root", "");

            // Prepare SQL update statement
            String sql = "UPDATE product SET product_name = ?, description = ?, category = ?, status = ? WHERE product_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, productName);
            pstmt.setString(2, description);
            pstmt.setString(3, category);
            pstmt.setString(4, status);
            pstmt.setString(5, productId);

            // Execute update
            int rowsUpdated = pstmt.executeUpdate();
            if (rowsUpdated > 0) {
                updateMessage = "Product updated successfully.";
            } else {
                errorMessage = "Failed to update product. Product ID might not exist.";
            }
        } catch (Exception e) {
            e.printStackTrace();
            errorMessage = "An error occurred while updating the product.";
        } finally {
            // Clean up resources
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        // Set attributes and forward to JSP
        request.setAttribute("updateMessage", updateMessage);
        request.setAttribute("errorMessage", errorMessage);
        RequestDispatcher dispatcher = request.getRequestDispatcher("productList.htm");
        dispatcher.forward(request, response);
    }
}
