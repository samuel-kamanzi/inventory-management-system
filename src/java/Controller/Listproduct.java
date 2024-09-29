package Controller;

import Config.Connection;
import java.util.List;
import java.util.Map;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class Listproduct {

    private final JdbcTemplate jdbcTemplate;

    // Constructor to initialize JdbcTemplate
    public Listproduct() {
        // Establish a connection using your custom Connection class
        Connection con = new Connection();
        this.jdbcTemplate = new JdbcTemplate(con.Conectar());
    }

    @RequestMapping("productList.htm") // Ensure the path is correct
    public ModelAndView listProducts() {
        String sql = "SELECT * FROM product";

        try {
            // Execute the query and retrieve the results as a list of maps
            List<Map<String, Object>> products = this.jdbcTemplate.queryForList(sql);
            
            // Debug statement to print the contents of the products list
            System.out.println("Products: " + products);
            
            ModelAndView mav = new ModelAndView("productList");
            mav.addObject("productList", products);
            
            // Debug statement to print the contents of the ModelAndView object
            System.out.println("ModelAndView: " + mav.getModel());
            
            return mav;
        } catch (Exception e) {
            e.printStackTrace();
            // Handle exceptions
            return new ModelAndView("error"); // return an error view or handle it accordingly
        }
    }
}
