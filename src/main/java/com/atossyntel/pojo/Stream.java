
package com.atossyntel.pojo;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;


public class Stream {
    private String id;
    private String name;

    public Stream(ResultSet rs) {
        try {
            this.id = rs.getString("stream_id");
            this.name = rs.getString("stream_name");
        } catch (SQLException ex) {
            Logger.getLogger(Stream.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    
    public String getID() {
        return id;
    }

    public void setID(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    
    @Override
    public String toString() {
        return "Stream{" + "id=" + id + ", name=" + name + '}';
    }
}
