package com.atossyntel.excelupload;


import com.atossyntel.excelupload.Module;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.sql.*;
import java.text.ParseException;
import org.apache.log4j.Logger;





public class Runner {
    final static Logger logger = Logger.getLogger(Runner.class);
    
    public static List<Employee> ExcelUpload(File filePath, String loc, String site, String stream, String insEmail, String startDate, String endDate) throws IOException, ParseException {
        
        PassOrFail pof = new PassOrFail();
        ExcelPuller pul = new ExcelPuller();
        List<Employee> emps = new ArrayList<>();
        EmployeeCRUD empCrud = new EmployeeCRUD();
        ClassCRUD cCrud = new ClassCRUD();
        ETMCrud eCrud= new ETMCrud();
        emps = pul.generateEmployees(filePath, loc, site, stream);
        

        try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e1) {
			e1.getMessage();
		}
        
        try (Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","Student_Performance","Student_Performance");
        	Statement st = con.createStatement();) {
        	cCrud.insertClass(st, emps.get(0).getClassID(), stream, insEmail, startDate, endDate);
                
      
                //Iterates through the created employees to upload their data
        	for(Employee employee: emps) {
                  
                 List<Module> passingModules;
                 
                 //returns a list of only passing modules, and filters out any retakes
                 passingModules = pof.passingOrFailing(employee);
                 
                  //If pof returns null then the employee failed the module and the retakes
                  //and therefore does not get inserted into the database
                  if (passingModules != null){
                      boolean inserted =  empCrud.insertEmployee(st, employee);
                      
                      //if the employee is already in the database, then it updates the classID for that employee
                      if(!inserted){
                        empCrud.updateClass(st, employee);
                      }
                      
                      //inserts all the passing modules into the database
                      for(Module module: passingModules) {
                          eCrud.insertETM(st,  module, employee.getEmployeeID(), stream); //Uploads the scores from the list in the employees
                      }
                      
                  } else{
                      logger.info("Employee " + employee.getEmployeeName()+ " failed");
                  }
                }
        } catch(SQLException e){
        	e.getMessage();
        }
  
      return emps;
    }
    
    
}
