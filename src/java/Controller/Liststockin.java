package Controller;

import Config.Connection;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import model.stocklnn;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class Liststockin {

    private final JdbcTemplate jdbcTemplate;

    // Constructor to initialize JdbcTemplate
    public Liststockin() {
        // Establish a connection using your custom Connection class
        Connection con = new Connection();
        this.jdbcTemplate = new JdbcTemplate(con.Conectar());
    }

    @RequestMapping("Liststockin.htm")
    public ModelAndView listProducts() {
        String sql = "SELECT * FROM stockin";

        try {
            List<Map<String, Object>> products = this.jdbcTemplate.queryForList(sql);

            List<stocklnn> stockInList = new ArrayList<>();
            for (Map<String, Object> product : products) {
                stocklnn stockIn = new stocklnn(); // Corrected class name
                stockIn.setProductId((int) product.get("product_id"));
                stockIn.setQuantity((int) product.get("quantity"));
                stockIn.setPrice((double) product.get("price"));
                stockIn.setCreatedDate((Date) product.get("created_date"));
                stockInList.add(stockIn);
            }

            ModelAndView mav = new ModelAndView("stockinList");
            mav.addObject("stockinList", stockInList);

            return mav;
        } catch (Exception e) {
            e.printStackTrace();
            return new ModelAndView("error");
        }
    }
}
