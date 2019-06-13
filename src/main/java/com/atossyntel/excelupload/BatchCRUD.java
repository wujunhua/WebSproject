package com.atossyntel.excelupload;
import java.util.List;

/**
 *
 * @author syntel
 */
public class BatchCRUD {
    public boolean insertBatch(){
        boolean retval = false;
        //insert into batch values(id, start, end, stream, country, city)
        return retval;
    }
    
    public boolean addEmployee(String batch_id, String employee_id){
        boolean retval = false;
        //insert into batches_have_employees values(b_id, e_id)
        return retval;
    }
    
    public List<Employee> getAllEmployees(String batch_id){
        List<Employee> employees = null;
        //get employees
        //select E.* from employees E, batches_have_employees BE 
            //where e.employee_id = be.employee_id and be.batch_id = b_id
            
        //get their module scores
        //select scores from employees_take_modules
            //where batch_id = b_id and employee_id = e_id
        return employees;
    }
    
    public boolean removeEmployee(String batch_id, String employee_id){
        boolean retval = false;
        //delete from employees_take_modules where batch_id = b_id and employee_id = e_id
        return retval;
    }
    
    public boolean deleteBatch(String batch_id){
        boolean retval = false;
        //delete from batches where batch_id = b_id
        return retval;
    }
}
