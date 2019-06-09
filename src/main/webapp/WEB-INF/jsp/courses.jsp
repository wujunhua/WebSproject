<jsp:include page="head-tag.jsp"/>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.ArrayList"%>
<%@ page import="java.sql.*" %>

<%
  
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
  String sql;
  int numRowsAffected;
  Statement stmt = conn.createStatement();
  ResultSet rs;
  
  // insert
  /*try {
    
    sql = "insert into users values ('chris@syntelinc.com', 'password', 'N')";
    numRowsAffected = stmt.executeUpdate(sql);
    out.println(numRowsAffected + " user(s) inserted. <BR>");
  
  } catch (SQLException e) {
    
    out.println("Error encountered during row insertion for employee: " + e.toString() + "<BR>");
  
  }*/
  
  
  // select
  sql = "select c.course_name as course, s.stream_name as stream, m.module_name as module from courses c, modules m, stream s where c.module_id = m.module_id AND s.stream_id=m.stream_id";
  rs = stmt.executeQuery(sql);
  
  ArrayList courseList = new ArrayList();
  request.setAttribute("courseList", courseList);
  
  ArrayList modList = new ArrayList();
  request.setAttribute("modList", modList);
  
  ArrayList streamList = new ArrayList();
  request.setAttribute("streamList", streamList);
  
 
  
  while (rs.next()) {
        courseList.add(rs.getString("course"));
        streamList.add(rs.getString("stream"));
        modList.add(rs.getString("module"));
        
        //out.println("User Id = " + rs.getString("user_id") + "<BR>"); 
        } // End while 
  
  sql = "select stream_name from stream";
  rs = stmt.executeQuery(sql);
  
  ArrayList fullstreamList = new ArrayList();
  request.setAttribute("fullstreamList", fullstreamList);
  
 
  
  while (rs.next()) {
        fullstreamList.add(rs.getString("stream_name"));
        //out.println("User Id = " + rs.getString("user_id") + "<BR>"); 
        }
  String var = (String)request.getAttribute("stream_name");
  //out.println(var);
  sql = "select m.module_name from modules m, stream s where m.stream_id=s.stream_id AND stream_name LIKE '"+var+"'";
  rs = stmt.executeQuery(sql);
  
  ArrayList fullmodList = new ArrayList();
  request.setAttribute("fullmodList", fullmodList);
  
 
  
  while (rs.next()) {
        fullmodList.add(rs.getString("module_name"));
        //out.println("User Id = " + rs.getString("user_id") + "<BR>"); 
        }
  
// End while 
   //out.println(courseList.get(0));
 
  // delete
  /* try {
    sql = "delete from users";
    numRowsAffected = stmt.executeUpdate(sql);
    out.println(numRowsAffected + " user(s) deleted. <BR>");
  } catch (SQLException e) {
    out.println("Error encountered during deletion of employee: " + e.toString() + "<BR>");
  
  }  
  out.println("<P>"); */
  
  rs.close();
  stmt.close();
  //commit
  conn.commit();
  
  //disconnect
  conn.close();
%>  
<html>
    <head>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/babel-standalone/6.24.0/babel.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/react/15.4.2/react.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/react/15.4.2/react-dom.min.js"></script>
    </head>
<body class="bg-light" onload="loadDoc()">

  <jsp:include page="nav.jsp"/>
  
  <div id="root"></div>
  <div id="root2"></div>
  <div id="root3"></div>
  
  <script type ="text/babel">
      class HeadingLinks extends React.Component {
          render(){
              return(
                    <div className="container-fluid">
                     <div className="container mt-2 pt-4 pb-3">
                       <nav aria-label="breadcrumb">
                         <ol className="breadcrumb" style={{background: "transparent"}}>
                           <li className="breadcrumb-item"><a href="#">Admin</a></li>
                           <li className="breadcrumb-item active" aria-current="page">Courses</li>
                         </ol>
                       </nav>
                     </div>
                   </div> 
                    );
          }
      };
      
      class Tabs extends React.Component {
          render(){
              return(
                        <div className="container-fluid">
                            <div className="container">
                              <ul className="nav nav-tabs">
                                <li className="nav-item">
                                  <a className="nav-link" href="streams.htm">Streams</a>
                                </li>  
                                <li className="nav-item">
                                  <a className="nav-link" href="category.htm">Category</a>
                                </li>
                                <li className="nav-item">
                                  <a className="nav-link" href="modules.htm">Modules</a>
                                </li>
                                <li className="nav-item">
                                  <a className="nav-link active" href="courses.htm">Courses</a>
                                </li>
                                <li className="nav-item">
                                  <a className="nav-link" href="admin.htm">Users</a>
                                </li>
                              </ul>
                            </div>
                          </div>

                    );
          }
      };
      
      class Content extends React.Component {
          render(){
              return(
                    <div className="container-fluid bg-white" style={{minHeight: "100vh"}}>
                      <div className="container pb-5">
                        <div className="row py-3">
                          <div className="col-lg-12">
                            <form action="create-courses.htm">
                              <div className="form">
                                <div className="form-row">
                                  <div className="col-lg-2">
                                    <button className="btn btn-sm btn-primary mt-1 no-border" type="submit"><i className="fas fa-plus pr-2"></i>Insert Course</button>
                                  </div>
                                  <div className="col-lg-3">
                                    <input type="text" name="coursename" id="coursename" className="form-control" onchange="myFunction()" placeholder="Course Name" pattern="[a-zA-Z][a-zA-Z0-9-_.+#* ]{0,45}" title="Name must start with a letter and can only contain letters, numbers, hyphens, underscores, periods, hashtag, plus, star and be between 1 and 45 characters." required />
                                  <div><small id="ajaxconf" className="text-danger"></small></div>
                                  </div>
                                    <div className="form-group col-md-3">
                                        <select className="custom-select" name="streamname" id="streamname" onchange="loadDoc()" >
                                            <c:forEach items="${fullstreamList}" var="streamer">
                                                <option value="${streamer}">
                                                    ${streamer}
                                                </option>
                                            </c:forEach>
                                      </select>
                                  </div>
                                  <div className="form-group col-md-3">
                                    <div id="dropdown_stuff">
                                          <select className="custom-select" name= "modulename" id="modulename" onChange="myFunction()">
                                      <c:forEach items="${fullmodList}" var="modder">
                                          <option value="${modder}">
                                              ${modder}
                                          </option>
                                      </c:forEach>
                                      </select>
                                      </div>
                                  </div>
                                </div>
                              </div>
                            </form>
                          </div>
                        </div>
                        <table className="table table-striped table-bordered">
                          <thead>
                            <tr>
                              <th scope="col" style={{width: "10%"}}>#</th>
                              <th scope="col">Course Name</th>
                              <th scope="col">Stream Name</th>
                              <th scope="col">Module Name</th>
                            </tr>
                          </thead>
                          <tbody>
                            <c:set var="count" value="1"/>
                           <c:forEach items="${courseList}" var="course">
                             <tr value="${course}">
                                 <th scope="row">${count}</th>
                                 <td>
                                     <a href="manage-course.htm?id=${course}&name=${streamList.get(count-1)}&name2=${modList.get(count-1)}">${course}</a>
                                 </td>
                                 <td>
                                  ${streamList.get(count-1)}
                                 </td>
                                 <td>
                                 ${modList.get(count-1)}
                                 </td>
                             </tr>
                             <c:set var="count" value="${count + 1}"/>
                         </c:forEach>
                          </tbody>
                        </table>
                      </div>
                    </div>           
                    );
          }
      };
      
      ReactDOM.render(<HeadingLinks />, document.getElementById("root"));
      ReactDOM.render(<Tabs />, document.getElementById("root2"));
      ReactDOM.render(<Content />, document.getElementById("root3"));
  </script>
  <!-- /Tabs -->

  <!-- Optional JavaScript -->
  <script>
    function loadDoc() {
      //myFunction();
      var xhttp = new XMLHttpRequest();
      
      xhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
         document.getElementById("dropdown_stuff").innerHTML = this.responseText;
        }
      };
      
      var okay = document.getElementById("streamname").value;
      //alert("Value= "+okay);
      xhttp.open("GET", "ajax.htm?id="+okay, true);
      xhttp.send();
      
    }
</script>

  <!-- jQuery -->
  <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
  <!-- Popper.js -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
  <!-- Bootstrap.js -->
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

</body>
</html>

<script>
function myFunction()
{
  var cName = document.getElementById("coursename").value;
  var sName = document.getElementById("modulename").value;
  
  var xhttp = new XMLHttpRequest();
  xhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
     document.getElementById("ajaxconf").innerHTML = this.responseText;
    }
  };
  
  xhttp.open("GET", "ajaxconf.htm?name="+encodeURIComponent(cName)+"&sname="+encodeURIComponent(sName)+"&num=8", true);
  xhttp.send();
}
</script>