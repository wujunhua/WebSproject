package com.atossyntel.pojo;

import java.sql.ResultSet;
import java.sql.SQLException;
import org.springframework.jdbc.core.RowMapper;

import com.atossyntel.excelupload.Employee;

public class EmployeeRowMapper implements RowMapper<Employee>{

    @Override
    public Employee mapRow(ResultSet rs, int i) throws SQLException {
        Employee e = new Employee();
        e.setEmployeeID(rs.getString(1));
        e.setEmployeeName(rs.getString(2));
        e.setEmployeeEmail(rs.getString(3));
        return e;
    }
    
}
