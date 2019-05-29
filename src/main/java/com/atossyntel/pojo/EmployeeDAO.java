package com.atossyntel.pojo;

import java.util.List;

import javax.sql.DataSource;

import com.atossyntel.excelupload.Employee;

public interface EmployeeDAO {
    public void setDataSource(DataSource ds);
    public void insertEmployee(String employeeID, String name, String email, String classID, String managerID);
    public Employee readEmployee(String employeeID);
    public List<Employee> readAllEmployee();
    public List<Employee> readAllEmployeeFromCol(String col, String str);
    public void updateEmployee(String employeeID, String name, String email, String managerID);
    public void updateEmployeeModule(String score, String employeeID, String name, String moduleID);
    public void deleteEmployee(String employeeID);
}
