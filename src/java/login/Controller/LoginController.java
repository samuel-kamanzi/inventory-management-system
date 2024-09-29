//package login.Controller;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.PostMapping;
//import org.springframework.web.bind.annotation.RequestParam;
//import org.springframework.web.servlet.mvc.support.RedirectAttributes;
//import login.Service.UserService;
//
//@Controller
//public class LoginController {
//
//    @Autowired
//    private UserService userService;
//
//    @PostMapping("/login")
//    public String login(@RequestParam("username") String username,
//                        @RequestParam("password") String password,
//                        RedirectAttributes redirectAttributes) {
//        boolean isAuthenticated = userService.authenticate(username, password);
//        if (isAuthenticated) {
//            return "redirect:/welcome"; // Redirect to a welcome page or dashboard
//        } else {
//            redirectAttributes.addFlashAttribute("errorMessage", "Invalid username or password.");
//            return "redirect:/index"; // Redirect back to the login page
//        }
//    }
//}
