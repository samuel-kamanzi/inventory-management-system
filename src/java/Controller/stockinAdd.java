package Controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class stockinAdd extends AbstractController {

    @Override
    protected ModelAndView handleRequestInternal(
            HttpServletRequest request,
            HttpServletResponse response) throws Exception {

        ModelAndView mv = new ModelAndView("stockinProduct");

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

                    // Check if product_id exists and retrieve product_name
                    String checkProductSql = "SELECT product_name FROM product WHERE product_id = ?";
                    pst = conn.prepareStatement(checkProductSql);
                    pst.setInt(1, Integer.parseInt(id));
                    rs = pst.executeQuery();

                    if (rs.next()) {
                        // product_id exists, retrieve the product_name
                        String productName = rs.getString("product_name");

                        // Insert data into stockin table
                        String insertStockinSql = "INSERT INTO stockin (product_id, product_name, quantity, price) VALUES (?, ?, ?, ?)";
                        pst = conn.prepareStatement(insertStockinSql);
                        pst.setInt(1, Integer.parseInt(id));
                        pst.setString(2, productName);  // Insert retrieved product_name
                        pst.setInt(3, Integer.parseInt(quantity));
                        pst.setDouble(4, Double.parseDouble(price));

                        int stockinResult = pst.executeUpdate();

                        if (stockinResult > 0) {
                            // Update the stock table with the new quantity
                            String updateStockSql = "UPDATE stock SET quantity = quantity + ? WHERE product_id = ?";
                            pst = conn.prepareStatement(updateStockSql);
                            pst.setInt(1, Integer.parseInt(quantity));
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
