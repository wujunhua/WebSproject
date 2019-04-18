package ExcelUpload;


import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.sql.*;
import java.text.ParseException;





public class Runner {
    
    public static ArrayList<Employee> ExcelUpload(File FILE_PATH, String loc, String site, String stream, String insEmail, String startDate, String endDate) throws IOException, ParseException {
        
        ExcelPuller pul = new ExcelPuller();
        ArrayList<Employee> emps = new ArrayList<>();
        EmployeeCRUD empCrud = new EmployeeCRUD();
        ClassCRUD cCrud = new ClassCRUD();
        ETMCrud eCrud= new ETMCrud();
        emps = pul.generateEmployees(FILE_PATH, loc, site, stream);
        

        
        try {
        	
        	Class.forName("oracle.jdbc.driver.OracleDriver");
        	Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","Student_Performance","Student_Performance");
        	Statement st = con.createStatement();
        	cCrud.insertClass(st, emps.get(0).getClassID(), stream, insEmail, startDate, endDate);
                
      
                //Iterates through the created employees to upload their data
        	for(Employee x: emps) {
            	
                    empCrud.insertEmployee(st, x.getEmployeeID(), x.getEmployeeName(), x.getEmployeeEmail(), x.getClassID());
                    
                   
                    for(Module z: x.getModScores()) {
                        eCrud.insertETM(st, z.getModuleID(), z.getmoduleScore(), x.getEmployeeID()); //Uploads the scores from the list in the employees
                    }
        	}
                con.close();
        } catch(ClassNotFoundException | SQLException e){
        	e.printStackTrace();
        }
  
      return emps;
    }
    
    
}
