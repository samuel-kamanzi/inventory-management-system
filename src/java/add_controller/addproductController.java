package add_controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class addproductController extends AbstractController {

    @Override
    protected ModelAndView handleRequestInternal(
            HttpServletRequest request,
            HttpServletResponse response) throws Exception {

        ModelAndView mv = new ModelAndView("addProduct");

        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String name = request.getParameter("productName");
            String description = request.getParameter("description");
            String category = request.getParameter("category");

            Connection conn = null;
            PreparedStatement pst = null;
            PreparedStatement pst2 = null;
            PreparedStatement pst3 = null;
            ResultSet rs = null;

            try {
                String url = "jdbc:mariadb://localhost:3306/inventory";
                String user = "root";
                String pass = "";

                Class.forName("org.mariadb.jdbc.Driver");
                conn = DriverManager.getConnection(url, user, pass);

                // Insert into the product table
                String sql = "INSERT INTO product (product_name, description, category) VALUES (?, ?, ?)";
                pst = conn.prepareStatement(sql);
                pst.setString(1, name);
                pst.setString(2, description);
                pst.setString(3, category);
                
                int result = pst.executeUpdate();

                if (result > 0) {
                    // Get the last inserted product_id
                    String lastInsertIdSql = "SELECT LAST_INSERT_ID() AS last_id";
                    pst2 = conn.prepareStatement(lastInsertIdSql);
                    rs = pst2.executeQuery();
                    int lastInsertId = 0;
                    if (rs.next()) {
                        lastInsertId = rs.getInt("last_id");
                    }

                    // Insert into the stock table with the product name and product_id
                    String sql2 = "INSERT INTO stock (product_id, product_name, quantity) VALUES (?, ?, ?)";
                    pst3 = conn.prepareStatement(sql2);
                    pst3.setInt(1, lastInsertId);
                    pst3.setString(2, name);
                    pst3.setInt(3, 0);  // Assuming quantity is initially set to 0

                    int result2 = pst3.executeUpdate();

                    if (result2 > 0) {
                        mv.addObject("message", "Data Inserted Successfully");
                    } else {
                        mv.addObject("message", "Data Insertion into Stock Failed");
                    }
                } else {
                    mv.addObject("message", "Data Insertion into Product Failed");
                }

            } catch (Exception e) {
                mv.addObject("message", "Error: " + e.getMessage());
            } finally {
                // Ensure resources are closed
                if (rs != null) {
                    try { rs.close(); } catch (Exception e) { /* ignored */ }
                }
                if (pst != null) {
                    try { pst.close(); } catch (Exception e) { /* ignored */ }
                }
                if (pst2 != null) {
                    try { pst2.close(); } catch (Exception e) { /* ignored */ }
                }
                if (pst3 != null) {
                    try { pst3.close(); } catch (Exception e) { /* ignored */ }
                }
                if (conn != null) {
                    try { conn.close(); } catch (Exception e) { /* ignored */ }
                }
            }
        }

        return mv;
    }
}
