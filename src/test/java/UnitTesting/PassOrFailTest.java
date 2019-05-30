/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package UnitTesting;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Collections;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import org.junit.Test;
import org.junit.runners.Parameterized;


public class PassOrFailTest {
    public static Map getEmployeeJDBC(){
        Connection myOracleConnection=null;
        Statement myOracleStatement=null;
        ResultSet myOracleRS_employeeid;
        
        ArrayList <Integer> employeeIds= new ArrayList<>();
        Map<Integer,ArrayList<Integer>> records=null;
        try {            
            Class.forName("oracle.jdbc.driver.OracleDriver");
            myOracleConnection=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","Student_Performance","Student_Performance");
            myOracleStatement=myOracleConnection.createStatement(); 
            String employeeId_query= "select distinct(emplpyee_id) from employees_take_modules";
            myOracleRS_employeeid=myOracleStatement.executeQuery(employeeId_query);
            while(myOracleRS_employeeid.next()){
                  int employee_id=myOracleRS_employeeid.getInt("employee_id");
                  employeeIds.add(employee_id);
            }
            Collections.sort(employeeIds);
            for(Integer employeeId: employeeIds){
                
            }
            
        } catch (SQLException ex) {
            System.out.println("Exception:"+ex.getMessage());
        }catch (ClassNotFoundException ex) {
            System.out.println("Driver class not found");
            }
        finally{            
                try {
                    if(myOracleStatement!=null) myOracleStatement.close();
                    if(myOracleConnection!=null)myOracleConnection.close();
                } catch (SQLException ex) {
                    System.out.println(ex.getMessage()); 
            }                
        }
        return records;
    }
    
    public static Set<Integer> GetEmployeeModuleList(Statement myOracleStatement, int employeeId){
        Set<Integer> moduleSet= new HashSet<Integer>();
        String query= "select * from employees_take_modules where employee_id="+ employeeId+";";
        ResultSet myOracleRS=null;
        try {
            myOracleRS = myOracleStatement.executeQuery(query);
             while(myOracleRS.next()){
                  int module_id=myOracleRS.getInt("module_id");
                  int score=myOracleRS.getInt("scores");
                  if(score>70){
                    moduleSet.add(module_id);
                  }
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
      
        return moduleSet;
    }
    
    
    @Parameterized.Parameters
    public static Collection<Object[]> data(){
              
            
            
            
            Object[][] data = new Object[][]{};
            return Arrays.asList(data);
        }
    
   
    
    @Test
   public void hello() {
   
   }
}
