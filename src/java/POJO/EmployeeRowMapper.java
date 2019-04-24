package POJO;

import ExcelUpload.Employee;
import java.sql.ResultSet;
import java.sql.SQLException;
import org.springframework.jdbc.core.RowMapper;

public class EmployeeRowMapper implements RowMapper{

    @Override
    public Employee mapRow(ResultSet rs, int i) throws SQLException {
        Employee e = new Employee();
        e.setEmployeeID(rs.getString(1));
        e.setEmployeeName(rs.getString(2));
        e.setEmployeeEmail(rs.getString(3));
        e.setClassID(rs.getString(4));
        e.setManagerID(rs.getString(5));
        
        return e;
    }
    
}
