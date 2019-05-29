/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.atossyntel.pojo;

import javax.sql.DataSource;

/**
 *
 * @author syntel
 */
public interface UserDAO {
    
    public void setDataSource(DataSource ds);
    public User getUser(String id);
    public void setUserPassword(String id, String password);
    public DataSource getDataSource();

    
}
