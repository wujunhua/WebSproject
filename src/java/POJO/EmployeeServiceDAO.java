package POJO;

import ExcelUpload.Employee;
import java.util.ArrayList;
import javax.sql.DataSource;
import org.springframework.jdbc.core.JdbcTemplate;

public class EmployeeServiceDAO implements EmployeeDAO{
    private DataSource dataSource;
    private JdbcTemplate jdbcTemplateObject;
    
    @Override
    public void setDataSource(DataSource ds) {
        System.out.println("Setting the data source and creating JDBC Template interface");
        dataSource = ds;
        try { 
            jdbcTemplateObject = new JdbcTemplate(dataSource);
        } catch(Exception e) {
            System.out.println("EXCEPTION: [ " + e.getMessage() + " ]");
        }
    }

    @Override
    public void insertEmployee(String employeeID, String name, String email, String classID, String managerID) {
        String sql = "insert into employees values (?, ?, ?, ?, ?)";
        try {
            System.out.println("Insert into employees...");
            int row = jdbcTemplateObject.update(sql, employeeID, name, email, classID, managerID);
            System.out.println("* " + row + " row inserted.\n");
        } catch(Exception e) {
            System.out.println("EXCEPTION: [ " + e.getMessage() + " ]");
        }
    }

    //Returns Employee object
    @Override
    public Employee readEmployee(String employeeID) {
        String sql = "select * from employees where employee_id = ?";
        Employee emp = new Employee();
        try {
            System.out.println("Read from employees...");
            emp = (Employee) jdbcTemplateObject.queryForObject(sql, new Object[]{employeeID}, new EmployeeRowMapper());
            System.out.println(emp);
        } catch(Exception e) {
            System.out.println("EXCEPTION: [ " + e.getMessage() + " ]");
        }
        return emp;
    }
    
    public ArrayList<Employee> readAllEmployee(){
        ArrayList<Employee> list = new ArrayList<>();
        String sql = "select * from employees";
        try {
            System.out.println("Read from employees...");
            list = (ArrayList<Employee>) jdbcTemplateObject.query(sql, new EmployeeRowMapper());
            System.out.println(list);
        } catch(Exception e) {
            System.out.println("EXCEPTION: [ " + e.getMessage() + " ]");
        }
        return list;
    }
    
    @Override
    public ArrayList<Employee> readAllEmployeeFromCol(String col, String str){
        ArrayList<Employee> list = new ArrayList<>();
        String sql = "";
        switch(col){
            case "name":
                sql = "select * from employees where name = ?";
                break;
            case "email":
                sql = "select * from employees where email = ?";
                break;
            case "classID":
                sql = "select * from employees where class_id = ?";
                break;
        }
        try {
            System.out.println("Read from employees from searching a column...");
            list = (ArrayList<Employee>) jdbcTemplateObject.query(sql, 
                    new Object[]{str}, new EmployeeRowMapper());
                    
            System.out.println(list);
        } catch(Exception e) {
            System.out.println("EXCEPTION: [ " + e.getMessage() + " ]");
        }
        
        return list;
    }

    @Override
    public void updateEmployee(String employeeID, String name, String email, String managerID) {
        String sql = "update employees set employee_id = ?, name = ?, email = ?, manager_id = ? where employee_id = ?";
        try {
            System.out.println("Update employee...");
            int row = jdbcTemplateObject.update(sql, employeeID, name, email, managerID, employeeID);    
            System.out.println("* " + row + " row updated.\n");
        } catch(Exception e) {
            System.out.println("EXCEPTION: [ " + e.getMessage() + " ]");
        }
    }

    @Override
    public void deleteEmployee(String employeeID) {
        String sql = "delete from employees where employee_id = ?";
        try {
            System.out.println("Delete employee...");
            int row = jdbcTemplateObject.update(sql, employeeID);
            System.out.println("* " + row + " row deleted.\n");
        } catch(Exception e) {
            System.out.println("EXCEPTION: [ " + e.getMessage() + " ]");
        }
    }
    
}
