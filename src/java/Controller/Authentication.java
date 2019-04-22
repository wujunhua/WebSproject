/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import POJO.User;
import POJO.UserServiceDAO;
import java.io.Console;
import java.io.IOException;
import static java.lang.System.console;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.validation.BindException;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.context.support.XmlWebApplicationContext;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;
import org.springframework.web.servlet.mvc.SimpleFormController;
import org.springframework.web.servlet.view.RedirectView;

/**
 *
 * @author LS5028230
 */
public class Authentication extends SimpleFormController{

    
    public Authentication() {
        setCommandClass(User.class);
        setCommandName("user");
    }

    @Override
    protected ModelAndView onSubmit(HttpServletRequest request,
                                HttpServletResponse response,
                                Object command,
                                BindException errors)
                         throws Exception {
        
        User user = (User) command;
        
        ServletContext context = this.getServletContext();
        WebApplicationContext ctx = 
            WebApplicationContextUtils.getRequiredWebApplicationContext(context);
        
        UserServiceDAO usrDAO = (UserServiceDAO)ctx.getBean("user1");
        System.out.println("User Form: " + user);
        
        String errorMessage = "NO_ERROR_SET";
        User userMatcher;
        
        try {
            userMatcher = usrDAO.getUser(user.getUserName());
            System.out.println("user retrieved, about to check if password matches");
            if (userMatcher.getPassword().trim().equals(user.getPassword().trim())) {
                
                ModelAndView userNameAndStatus = new ModelAndView();
                
                // available during this session, to check for admin capabilities
                request.getSession().setAttribute("currentUserName", userMatcher.getUserName());
                request.getSession().setAttribute("isAdmin", userMatcher.isAdmin());
                
                if (userMatcher.isAdmin()) {
                    userNameAndStatus = new ModelAndView(new RedirectView("streams.htm"));
                }
                else {
                    userNameAndStatus = new ModelAndView(new RedirectView("createclass.htm"));
                }
                return userNameAndStatus;
            }
            else {
                System.out.println("password did not match one in the DB");
                errorMessage = "<div class=\"alert alert-danger mx-5 alert-dismissible fade show\" role=\"alert\">\n"
                        + "  <strong>Error:</strong> password did not match\n"
                        + "  <button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\">\n"
                        + "    <span aria-hidden=\"true\">&times;</span>\n"
                        + "  </button>\n"
                        + "</div>";
                return new ModelAndView("Login", "errorMessage", errorMessage);
            }
            
        }catch(Exception e) {
            System.err.println(e);
            System.out.println("in exception, the user was not in the DB");
            errorMessage = "<div class=\"alert alert-danger mx-5 alert-dismissible fade show\" role=\"alert\">\n"
                    + "  <strong>Error:</strong> user was not in the database\n"
                    + "  <button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\">\n"
                    + "    <span aria-hidden=\"true\">&times;</span>\n"
                    + "  </button>\n"
                    + "</div>";
            return new ModelAndView("Login", "errorMessage", errorMessage);
        }
    }
      
}
