package Controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class LogoutController extends AbstractController {

    @Override
    protected ModelAndView handleRequestInternal(
            HttpServletRequest request,
            HttpServletResponse response) throws Exception {

        ModelAndView mv = new ModelAndView("stockoutProduct");

        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String id = request.getParameter("productid");
            String quantity = request.getParameter("quantity");
            String price = request.getParameter("price");

            // Validate inputs to ensure they are numeric
            if (isNumeric(id) && isNumeric(quantity) && isNumeric(price)) {

                Connection conn = null;
                PreparedStatement pst = null;
                ResultSet rs = null;

                try {
                    String url = "jdbc:mariadb://localhost:3306/inventory";
                    String user = "root";
                    String pass = "";

                    Class.forName("org.mariadb.jdbc.Driver");
                    conn = DriverManager.getConnection(url, user, pass);

                    // Check if product_id exists in the product table
                    String checkProductSql = "SELECT * FROM product WHERE product_id = ?";
                    pst = conn.prepareStatement(checkProductSql);
                    pst.setInt(1, Integer.parseInt(id));
                    rs = pst.executeQuery();

                    if (rs.next()) {
                        // product_id exists, check if the quantity is available
                        String checkStockSql = "SELECT quantity FROM stock WHERE product_id = ?";
                        pst = conn.prepareStatement(checkStockSql);
                        pst.setInt(1, Integer.parseInt(id));
                        rs = pst.executeQuery();

                        if (rs.next()) {
                            int availableQuantity = rs.getInt("quantity");
                            int requestedQuantity = Integer.parseInt(quantity);

                            if (requestedQuantity <= availableQuantity) {
                                // Quantity is available, proceed with stockout and update
                                String insertStockoutSql = "INSERT INTO stockout (product_id, quantity, price) VALUES (?, ?, ?)";
                                pst = conn.prepareStatement(insertStockoutSql);
                                pst.setInt(1, Integer.parseInt(id));
                                pst.setInt(2, requestedQuantity);
                                pst.setDouble(3, Double.parseDouble(price));

                                int stockoutResult = pst.executeUpdate();

                                if (stockoutResult > 0) {
                                    // Update the stock table by subtracting the quantity
                                    String updateStockSql = "UPDATE stock SET quantity = quantity - ? WHERE product_id = ?";
                                    pst = conn.prepareStatement(updateStockSql);
                                    pst.setInt(1, requestedQuantity);
                                    pst.setInt(2, Integer.parseInt(id));

                                    int stockResult = pst.executeUpdate();
                                    if (stockResult > 0) {
                                        mv.addObject("message", "Stock Updated and Data Inserted Successfully");
                                    } else {
                                        mv.addObject("message", "Stock Update Failed");
                                    }
                                } else {
                                    mv.addObject("message", "Data Insertion Failed");
                                }
                            } else {
                                // Requested quantity is not available
                                mv.addObject("message", "Insufficient stock quantity. Available: " + availableQuantity);
                            }
                        } else {
                            mv.addObject("message", "Stock data not found for the given product ID");
                        }
                    } else {
                        // product_id does not exist
                        mv.addObject("message", "Product ID does not exist in the product table");
                    }

                } catch (Exception e) {
                    mv.addObject("message", "Error: " + e.getMessage());
                } finally {
                    // Ensure resources are closed
                    if (rs != null) {
                        try {
                            rs.close();
                        } catch (Exception e) {
                            /* ignored */
                        }
                    }
                    if (pst != null) {
                        try {
                            pst.close();
                        } catch (Exception e) {
                            /* ignored */
                        }
                    }
                    if (conn != null) {
                        try {
                            conn.close();
                        } catch (Exception e) {
                            /* ignored */
                        }
                    }
                }
            } else {
                mv.addObject("message", "Invalid input: All fields must be numeric.");
            }
        }

        return mv;
    }

    // Utility method to check if a string is numeric
    private boolean isNumeric(String str) {
        try {
            Double.parseDouble(str);
            return true;
        } catch (NumberFormatException e) {
            return false;
        }
    }
}
