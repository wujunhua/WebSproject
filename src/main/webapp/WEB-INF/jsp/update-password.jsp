<%-- 
    Document   : update-password
    Created on : Apr 23, 2019, 12:11:54 PM
    Author     : syntel
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.ArrayList"%>
<%@ page import="java.sql.*" %>

<%
  
  //initialize driver class
  try {    
    Class.forName("oracle.jdbc.driver.OracleDriver");
  } catch (Exception e) {
    out.println("Fail to initialize Oracle JDBC driver: " + e.toString() + "<P>");
  }
  
  String dbUser = "Student_Performance";
  String dbPasswd = "Student_Performance";
  String dbURL = "jdbc:oracle:thin:@localhost:1521:XE";

  //connect
  Connection conn = null;
  try {
    conn = DriverManager.getConnection(dbURL,dbUser,dbPasswd);
    //out.println(" Connection status: " + conn + "<P>");
  } catch(Exception e) {
    out.println("Connection failed: " + e.toString() + "<P>");      
  }

  String sql;
  int numRowsAffected;
  Statement stmt = conn.createStatement();
  ResultSet rs;
  String user_name = (String)session.getAttribute("currentUserName");
  String new_password = request.getParameter("newpassword");
  
 
    
  //insert
   try {
    
        sql = "UPDATE Student_Performance.Users SET password ='" + new_password + "' WHERE user_id ='" + user_name + "'";
        numRowsAffected = stmt.executeUpdate(sql);
  
        } catch (SQLException e) {
        out.println("Error encountered during row insertion for users: " + e.toString() + "<BR>");
        }
    
  
  
  
  //rs.close();
  stmt.close();

  //commit
  conn.commit();
  
  //disconnect
  conn.close();
  
String site = "passwordChangeSuccess.htm" ;
response.setStatus(response.SC_MOVED_TEMPORARILY);
response.setHeader("Location", site);
  
%>  
