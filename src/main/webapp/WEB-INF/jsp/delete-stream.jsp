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
  String stream_name = request.getParameter("stream_id");
  
  
  
  // delete
  try {
    sql = "delete from stream where stream_name = '" + stream_name + "'";
    numRowsAffected = stmt.executeUpdate(sql);
    //out.println(numRowsAffected + " stream(s) deleted. <BR>");
  } catch (SQLException e) {
    out.println("Error encountered during deletion of employee: " + e.toString() + "<BR>");
  } 
  

  out.println("<P>");
  
  //rs.close();
  stmt.close();

  //commit
  conn.commit();
  
  //disconnect
  conn.close();
  
  String site = "streams.htm";
  response.setStatus(response.SC_MOVED_TEMPORARILY);
  response.setHeader("Location", site);

  
%>  


