/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import POJO.EmployeeServiceDAO;
import POJO.UserServiceDAO;
import java.io.IOException;
import java.util.Arrays;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.SimpleFormController;

/**
 *
 * @author LS5028230
 */
public class AuthEmails extends SimpleFormController{

    @Override
    public ModelAndView handleRequest(HttpServletRequest request,
                                HttpServletResponse response) throws IOException{       
        
        int lengthOfExt = 4; // to account for .htm, .jsp at the end of the path
        String servletPath = request.getServletPath();
        String viewName = servletPath.substring(1, (servletPath.length() - lengthOfExt));
        
        //EmployeeServiceDAO
        ServletContext context = this.getServletContext();
        WebApplicationContext ctx = WebApplicationContextUtils.getRequiredWebApplicationContext(context);
        EmployeeServiceDAO esd = (EmployeeServiceDAO) ctx.getBean("empdb");
     
        //Load filtered email hub page.
        ModelAndView mav = new ModelAndView();
        if(viewName.equals("searchEmailEmployees")){      
            mav.setViewName("Email");       
            mav.addObject("empList", esd.readAllEmployeeFromCol(request.getParameter("col"), request.getParameter("search").trim()));

            return mav;
        }
        
        //Email employees if checkboxes selected.
        String line; 
        String store = "";
        String[] emails;
        while((line = request.getReader().readLine()) != null) {
            store = line;  
        }
        //If there is any checked employees sent.
        if(store.length() > 0){
            //Extract emails.
            store = "&" + store;
            store = store.replaceAll("%", "@");
            store = store.replaceAll("40", "");
            emails = store.split("&emailChecked=");
            emails = Arrays.copyOfRange(emails, 1, emails.length);

            for (String email : emails)
                System.out.println(email);
            
            createPDFs(emails);
            
            for(int i = 0; i<emails.length; ++i)
                SendEmail.sendIdividualEmail(emails[i], SendEmail.getEmpId(emails[i]));
            
            return new ModelAndView("emailSuccess");
        }
        
        //Load email hub page
        mav.setViewName("Email");       
        mav.addObject("empList", esd.readAllEmployee());
        return mav;
    }
    
    void createPDFs(String[] ids){
        try{
            ServletContext context = this.getServletContext();
            WebApplicationContext ctx;
            ctx =  WebApplicationContextUtils.getRequiredWebApplicationContext(context);
            UserServiceDAO usrDAO = (UserServiceDAO)ctx.getBean("user1");

           
            
            PDF temp = new PDF(usrDAO.getDataSource());
            //temp.setDataSource(usrDAO.getDataSource());

            for(int i=0; i<ids.length; ++i)
                temp.generate(SendEmail.getEmpId(ids[i]));            
      
        }catch(Exception ex){
            System.out.println("invalid error in create PDFs");
            System.out.println(ex);
        }
        
    }

      
}
