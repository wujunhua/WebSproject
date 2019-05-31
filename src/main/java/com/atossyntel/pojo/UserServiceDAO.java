/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.atossyntel.pojo;

import javax.sql.DataSource;
import org.apache.log4j.Logger;
import org.springframework.jdbc.core.JdbcTemplate;

/**
 *
 * @author syntel
 */
public class UserServiceDAO implements UserDAO{
    static final Logger logger = Logger.getLogger(UserDAO.class);

    private DataSource dataSource;
    private JdbcTemplate jdbcTemplateObject;
    
    @Override
    public void setDataSource(DataSource ds){
        logger.info("Setting the Data Source and creating JDBC Template instance");
        dataSource = ds;
        jdbcTemplateObject = new JdbcTemplate(dataSource);
    }
    @Override
    public User getUser(String id){
        String sql = "select * from users where user_id = ?";
        return jdbcTemplateObject.queryForObject(sql, new Object[]{id}, new UserRowMapper());
        
        
    }
    
    public DataSource getDataSource(){
        return dataSource;
    }

    @Override
    public void setUserPassword(String id, String password) {
        String sql = "update users set password = ? where user_id = ?";
        
        jdbcTemplateObject.update(sql, password, id);
    }
    
    

    
}
