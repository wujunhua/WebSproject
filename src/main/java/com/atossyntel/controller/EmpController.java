/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.atossyntel.controller;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.SimpleFormController;

import com.atossyntel.pojo.EmployeeServiceDAO;

/**
 *
 * @author syntel
 */
public class EmpController extends SimpleFormController {

	private String objectName = "emplist";
	private String namedView = "showEmployees";
	
    @Override
    public ModelAndView handleRequest(HttpServletRequest request,
                                HttpServletResponse response){       
        
        int lengthOfExt = 4; // to account for .htm, .jsp at the end of the path
        String servletPath = request.getServletPath();
        String viewName = servletPath.substring(1, (servletPath.length() - lengthOfExt));
        
        //EmployeeServiceDAO
        ServletContext context = this.getServletContext();
        WebApplicationContext ctx = WebApplicationContextUtils.getRequiredWebApplicationContext(context);
        EmployeeServiceDAO esd = (EmployeeServiceDAO) ctx.getBean("empdb");
        
        //Go to right ModelAndView
        switch (viewName) {
            case "searchEmployees":
                return searchEmployees(esd, request);
            case "editEmployees":
                return editEmployee(esd, request);
            case "deleteEmployees":
                return deleteEmployee(esd, request);
            default:
                break;
        }
 
        return showEmployees(viewName, esd);
    }
    
    public ModelAndView searchEmployees(EmployeeServiceDAO esd, HttpServletRequest request){
        ModelAndView mav = new ModelAndView();
        mav.setViewName(namedView);       
        mav.addObject(objectName,  esd.readAllEmployeeFromCol(request.getParameter("col"),
                request.getParameter("search").trim()));
        
        return mav;
    }
    
    public ModelAndView showEmployees(String viewName, EmployeeServiceDAO esd){
        ModelAndView mav = new ModelAndView();
        mav.setViewName(viewName);
        mav.addObject(objectName, esd.readAllEmployee());
        
        return mav;
    }
    
    public ModelAndView editEmployee(EmployeeServiceDAO esd, HttpServletRequest request){
        ModelAndView mav = new ModelAndView();
        mav.setViewName(namedView);
        
        esd.updateEmployee(request.getParameter("editModalButton"), 
                request.getParameter("editName").trim(), request.getParameter("editEmail").trim()
                ,request.getParameter("editManagerID").trim());
        
        esd.updateEmployeeModule(request.getParameter("editModuleScore"), 
               request.getParameter("editModalButton"), request.getParameter("selectModule"),
               request.getParameter("editModuleID"));
        
        mav.addObject(objectName, esd.readAllEmployee());
       
        return mav;
    }
    
    public ModelAndView deleteEmployee(EmployeeServiceDAO esd, HttpServletRequest request){
        ModelAndView mav = new ModelAndView();
        mav.setViewName(namedView);
        esd.deleteEmployee(request.getParameter("deleteModalButton"));
        mav.addObject(objectName, esd.readAllEmployee());
        
        return mav;
    }                      
}
