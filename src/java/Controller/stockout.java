package Controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class stockout extends AbstractController {

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

                    // Check if there's enough stock
                    String checkStockSql = "SELECT product_name, quantity FROM stock WHERE product_id = ?";
                    pst = conn.prepareStatement(checkStockSql);
                    pst.setInt(1, Integer.parseInt(id));
                    rs = pst.executeQuery();

                    if (rs.next()) {
                        String productName = rs.getString("product_name");
                        int availableQuantity = rs.getInt("quantity");
                        int quantityToRemove = Integer.parseInt(quantity);

                        if (quantityToRemove <= availableQuantity) {
                            // Proceed with stockout
                            String insertStockoutSql = "INSERT INTO stockout (product_id, product_name, quantity, price) VALUES (?, ?, ?, ?)";
                            pst = conn.prepareStatement(insertStockoutSql);
                            pst.setInt(1, Integer.parseInt(id));
                            pst.setString(2, productName);  // Insert the retrieved product_name
                            pst.setInt(3, quantityToRemove);
                            pst.setDouble(4, Double.parseDouble(price));

                            int stockoutResult = pst.executeUpdate();

                            if (stockoutResult > 0) {
                                // Update the stock table by reducing the quantity
                                String updateStockSql = "UPDATE stock SET quantity = quantity - ? WHERE product_id = ?";
                                pst = conn.prepareStatement(updateStockSql);
                                pst.setInt(1, quantityToRemove);
                                pst.setInt(2, Integer.parseInt(id));

                                int stockResult = pst.executeUpdate();
                                if (stockResult > 0) {
                                    mv.addObject("message", "Data Inserted and Stock Updated Successfully");
                                } else {
                                    mv.addObject("message", "Stock Update Failed");
                                }
                            } else {
                                mv.addObject("message", "Data Insertion Failed");
                            }
                        } else {
                            // Not enough stock
                            mv.addObject("message", "Insufficient stock available. Operation failed.");
                        }
                    } else {
                        // product_id does not exist in stock table
                        mv.addObject("message", "Product ID does not exist in the stock table");
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
