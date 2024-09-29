package Controller;

import Config.Connection;
import java.util.List;
import javax.servlet.http.HttpSession;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class Controlador {

    Connection con = new Connection();
    JdbcTemplate jdbctemplate = new JdbcTemplate(con.Conectar());
    ModelAndView mav = new ModelAndView();

    @RequestMapping("index.htm")
    public ModelAndView Listar() {
        String sql = "SELECT * FROM admin";
        List<?> datos = this.jdbctemplate.queryForList(sql);
        mav.addObject("lista", datos);
        mav.setViewName("index");
        return mav;
    }

    @RequestMapping(value = "login.htm", method = RequestMethod.POST)
    public ModelAndView login(@RequestParam("username") String username,
                              @RequestParam("password") String password,
                              HttpSession session) {
        // Check if username exists
        String sqlCheckUser = "SELECT COUNT(*) FROM admin WHERE username = ?";
        int userCount = this.jdbctemplate.queryForObject(sqlCheckUser, new Object[]{username}, Integer.class);

        if (userCount == 0) {
            mav.addObject("message", "Username does not exist");
            mav.setViewName("index");
            return mav;
        }

        // Check if username and password match
        String sqlCheckCredentials = "SELECT * FROM admin WHERE username = ? AND password = ?";
        List<?> userList = this.jdbctemplate.query(sqlCheckCredentials, new Object[]{username, password}, 
            (rs, rowNum) -> rs.getString("username"));

        if (!userList.isEmpty()) {
            session.setAttribute("username", username); // Store username in session
            mav.setViewName("Home"); // Assuming Home.jsp is the target after successful login
        } else {
            mav.addObject("message", "Incorrect password");
            mav.setViewName("index");
        }
        return mav;
    }

    @RequestMapping("logout.htm")
    public ModelAndView logout(HttpSession session) {
        session.invalidate(); // Invalidate the session
        mav.setViewName("index"); // Redirect to the login page
        return mav;
    }
}
