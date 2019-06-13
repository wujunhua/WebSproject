package com.atossyntel.pojo;

import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;
import org.apache.log4j.Logger;
import org.springframework.jdbc.core.JdbcTemplate;

import com.atossyntel.excelupload.Employee;
import com.atossyntel.excelupload.Module;

public class EmployeeServiceDAO implements EmployeeDAO{
    static final Logger logger = Logger.getLogger(EmployeeServiceDAO.class);
    private JdbcTemplate jdbcTemplateObject;
    
    @Override
    public void setDataSource(DataSource ds) {
        logger.info("Setting the data source and creating JDBC Template interface");
        DataSource dataSource = ds;
        try { 
            jdbcTemplateObject = new JdbcTemplate(dataSource);
        } catch(Exception e) {

            logger.error(e.getMessage());
        }
    }

    @Override
    public void insertEmployee(String employeeID, String name, String email) {
        String sql = "insert into employees values (?, ?, ?)";
        try {
            logger.info("Insert into employees...");
            int row = jdbcTemplateObject.update(sql, employeeID, name, email);
            logger.info("* " + row + " row inserted.\n");
        } catch(Exception e) {
            logger.error(e.getMessage());
        }
    }

    //Returns Employee object
    @Override
    public Employee readEmployee(String employeeID) {
        String sql = "select * from employees where employee_id = ?";
        Employee emp = new Employee();
        try {
            logger.info("Read from employees...");
            emp = jdbcTemplateObject.queryForObject(sql, new Object[]{employeeID}, new EmployeeRowMapper());            
        } catch(Exception e) {
            logger.error(e.getMessage());
        }
        return emp;
    }
    
    @Override
    public List<Employee> readAllEmployee(){
        List<Employee> list = new ArrayList<>();
        String sql = "select * from employees";
        try {
            logger.info("Read from employees...");
            list = jdbcTemplateObject.query(sql, new EmployeeRowMapper());
            //For each employee get modules and set employee scores.
            for(int i=0; i<list.size(); i++){
                list.get(i).setModScores(getModuleIDAndScore(list.get(i).getEmployeeID()));
            }            
        } catch(Exception e) {
            logger.error(e.getMessage());
        }
        return list;
    }
    
    //Get arraylist of module for employee.
    public List<Module> getModuleIDAndScore(String id){
        List<Module> list = new ArrayList<>();
        String sql = "select m.module_name, etm.scores, m.module_id from Employees e, "
                + "Modules m, Employees_take_Modules etm where e.employee_id = etm.employee_id "
                + "AND etm.module_id = m.module_id AND e.employee_id = ?";
        
        try {
            logger.info("Get Employee Module and Scores...");
            list = jdbcTemplateObject.query(sql, new Object[]{id}, new ModuleListRowMapper());
        } catch(Exception e) {
            logger.error(e.getMessage());
        }
        return list;        
    }
 
    @Override
    public List<Employee> readAllEmployeeFromCol(String searchBy, String searchTerm) {
        
        ArrayList<Employee> matchingEmps = new ArrayList<>();
        String sql = "";
        
        switch(searchBy){
            case "name":
                sql = "select * from employees where lower(name) like ?";
                break;
            case "email":
                sql = "select * from employees where lower(email) like ?";
                break;
            case "classID":
                sql = "select * from employees where lower(class_id) like ?";
                break;
            default:
            	break;
            
        }
        try {
            logger.info("Read from employees from searching a column...");
            
            matchingEmps = (ArrayList<Employee>) jdbcTemplateObject.query(sql, 
                    new Object[]{"%" + searchTerm.toLowerCase() + "%"}, new EmployeeRowMapper());
                    
        } catch(Exception e) {
            logger.error(e.getMessage());
        }
        
        return matchingEmps;
    }

    @Override
    public void updateEmployee(String employeeID, String name, String email) {
        String sql = "update employees set employee_id = ?, name = ?, email = ? where employee_id = ?";
        try {
            logger.info("Update employee...");
            int row = jdbcTemplateObject.update(sql, employeeID, name, email, employeeID);    
            logger.info("* " + row + " row updated.\n");
        } catch(Exception e) {
            logger.error(e.getMessage());
        }
    }
    
    @Override
    public void updateEmployeeModule(String score, String employeeID, String name, String moduleID){
        String sql = "update employees_take_modules set scores = ? where employee_id = ? AND module_id = ?";
        try {
            int row = jdbcTemplateObject.update(sql, score, employeeID, moduleID);    
            logger.info("* " + row + " row updated.\n");
        } catch(Exception e) {
            logger.error(e.getMessage());
        }        
    }

    @Override
    public void deleteEmployee(String employeeID) {
        String sql = "delete from employees where employee_id = ?";
        try {
            logger.info("Delete employee...");
            int row = jdbcTemplateObject.update(sql, employeeID);
            logger.info("* " + row + " row deleted.\n");
        } catch(Exception e) {
            logger.error(e.getMessage());
        }
    }
    
}
