<%-- 
    Document   : create-courses
    Created on : Apr 11, 2019, 4:50:50 PM
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
  String module_name = request.getParameter("modulename"); 
  int module_id=0;
  
  sql = "select module_id from modules where module_name ='" + module_name +"'";
  numRowsAffected = stmt.executeUpdate(sql);
  rs = stmt.executeQuery(sql);
  
  while (rs.next()) {
        module_id = rs.getInt("module_id");
        }
  
        
  String course_name = request.getParameter("coursename");
  String sqlcId = "select count(*) from courses";
  ResultSet rse = stmt.executeQuery(sqlcId);
  int Cid=0;
    while (rse.next()) {
        Cid = rse.getInt("COUNT(*)");
        }
  
  String course_id = Integer.toString(Cid+1);
  
      String mName = request.getParameter("sname");
      String sql2, sqlid;
      int sqlid2;
      
      sqlid = "select module_id from modules where module_name='" + mName + "'";
      rs = stmt.executeQuery(sqlid);
      
      sqlid2 = 0;
      
      while(rs.next())
      {
        sqlid2 = Integer.parseInt(rs.getString("module_id"));
      }

  out.println(course_name);
  out.println("=================");
 
  ResultSet rs2;
 // Statement stmt2 = conn.createStatement();  
 sql2 = "select course_name from courses where course_name='" + course_name + "' and module_id=" + sqlid2;
  
 rs2 = stmt.executeQuery(sql2);
  
 if(rs2.next() == false)
 {
  //insert
   try {
    
        sql = "insert into courses values ('" + course_id + "',  '" + course_name + "', " + module_id + ")";
        numRowsAffected = stmt.executeUpdate(sql);
        
  
        } catch (SQLException e) {
        out.println("Error encountered during row insertion for users: " + e.toString() + "<BR>");
        } 
 }
  
  
  //rs.close();
  stmt.close();

  //commit
  conn.commit();
  
  //disconnect
  conn.close();
  
String site = "courses.htm" ;
response.setStatus(response.SC_MOVED_TEMPORARILY);
response.setHeader("Location", site);
  
%>  