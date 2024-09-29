package Controller;

import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class logout {

    ModelAndView mav = new ModelAndView();

    @RequestMapping("logout1.htm")
    public ModelAndView logout(HttpSession session) {
        // Invalidate the user's session to log them out
        session.invalidate();

        // Redirect to the login page after logout
        mav.setViewName("index"); // Assuming index.jsp is your login page
        return mav;
    }
}
