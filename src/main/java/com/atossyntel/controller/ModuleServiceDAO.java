package com.atossyntel.controller;


import java.util.List;
import javax.sql.DataSource;
import org.apache.log4j.Logger;
import org.springframework.jdbc.core.JdbcTemplate;

public class ModuleServiceDAO {
final static Logger logger = Logger.getLogger(ModuleServiceDAO.class);
    private JdbcTemplate jdbcTemplate;

    public void setDataSource(DataSource dataSource) {    
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }


    public List<String> getModuleNamesForStreamID(String streamID) {
        logger.info("getting module names for stream with ID: " + streamID);
        
        String sql = "SELECT module_name FROM modules WHERE stream_id = ?";
 
        return jdbcTemplate.query(sql, new ModuleNameExtracter(), streamID);
    }
}
