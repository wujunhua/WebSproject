/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package POJO;

import ExcelUpload.Module;
import java.sql.ResultSet;
import java.sql.SQLException;
import org.springframework.jdbc.core.RowMapper;


public class ModuleListRowMapper implements RowMapper{

    @Override
    public Module mapRow(ResultSet rs, int i) throws SQLException {
        Module m = new Module();
        m.setModuleID(rs.getString(1));
        m.setmoduleScore(rs.getDouble(2));
        
        return m;
    }
    
}
