<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.ArrayList"%>
<%@ page import="java.sql.*" %>
<% 
    
    String okay = request.getParameter("id"); 
    //out.println(okay);
    
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
   
  } catch(Exception e) {
    out.println("Connection failed: " + e.toString() + "<P>");      
  }
 
  String sql = "select m.module_name from modules m, stream s where m.stream_id = s.stream_id AND s.stream_name LIKE '" + okay + "'";
  
  Statement stmt = conn.createStatement();
  ResultSet rs;
//  out.println(streamname);
  rs = stmt.executeQuery(sql);
  ArrayList fullmodList = new ArrayList();
  while (rs.next()){
      fullmodList.add(rs.getString("module_name"));
  }
  request.setAttribute("fullmodList", fullmodList);
  
//out.println(fullmodList);
%>
<!--<p>${streamname}</p>-->


                  <select class="custom-select" name= "modulename" id="modulename">
                    <c:forEach items="${fullmodList}" var="modder">
                        <option value="${modder}">
                            ${modder}
                        </option>
                    </c:forEach>
                    </select>
               

