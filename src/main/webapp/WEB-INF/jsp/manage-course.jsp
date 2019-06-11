<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.ArrayList"%>
<%@ page import="java.sql.*" %>

<%!
    public String updateModules(String stream_name){
    String sql = "select m.module_name from modules m, stream s where m.stream_id = s.stream_id AND s.stream_name LIKE '"+stream_name+"'";
 /*
 ResultSet rs = stmt.executeQuery(sql);
  
  ArrayList fullmodList = new ArrayList();
  request.setAttribute("fullmodList", fullmodList);
  
 
  
  while (rs.next()) {
        fullmodList.add(rs.getString("module_name"));
        //out.println("User Id = " + rs.getString("user_id") + "<BR>"); 
        }
*/
    return sql;
}
    %>
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
  
 String url = "http://www.google.com";
 
 
  
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
  /*
  sql = "select module_name from modules";
  rs = stmt.executeQuery(sql);
  */
  ArrayList fullmodList = new ArrayList();
  //request.setAttribute("fullmodList", fullmodList);
  
 /*
  
  while (rs.next()) {
        fullmodList.add(rs.getString("module_name"));
        //out.println("User Id = " + rs.getString("user_id") + "<BR>"); 
        } // End while 
   //out.println(courseList.get(0));
  */
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

<!DOCTYPE html>
<html>
    <jsp:include page="head-tag.jsp"/>

    <body class="bg-light" onload="loadDoc()">
        <jsp:include page="nav.jsp"/>
        
        <div id="courses"></div>
        <div id="redirect"></div>
        <div id="courses-form"></div>
        
        <script src="https://cdnjs.cloudflare.com/ajax/libs/babel-standalone/6.24.0/babel.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/react/15.4.2/react.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/react/15.4.2/react-dom.min.js"></script>
 
        <!-- Optional JavaScript -->
        <script>
          function loadDoc() {
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
  var oName = document.getElementById("course_name").value;
  var nName = document.getElementById("new_course_name").value;
  var sName = document.getElementById("modulename").value;
  
  var xhttp = new XMLHttpRequest();
  xhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
     document.getElementById("ajaxconf").innerHTML = this.responseText;
    }
  };
  
  xhttp.open("GET", "ajaxconf.htm?newC="+encodeURIComponent(nName)+"&oldC="+encodeURIComponent(oName)+"&sName="+encodeURIComponent(sName)+"&num=4", true);
  xhttp.send();
}
</script>

<script type="text/babel">
    class Courses extends React.Component {
        render() {
            return (
                    <div className="container-fluid">
                        <div className="container mt-2 pt-4 pb-3">
                            <nav aria-label="breadcrumb">
                                <ol className="breadcrumb" style={{background: "transparent"}}>
                                    <li className="breadcrumb-item"><a href="admin.htm">Admin</a></li>
                                    <li className="breadcrumb-item active">Courses</li>
                                    <li className="breadcrumb-item active" aria-current="page">Manage Course</li>
                                </ol>
                            </nav>
                        </div>
                     </div>
            );
        }
    }

    class Redirect extends React.Component {
        render() {
            return (
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
    }

    class CoursesForm extends React.Component {
        render() {
            return (
                    <div className="container-fluid bg-white" style={{minHeight: "100vh"}}>
                        <div className="container pb-5">
                            <div className="row justify-content-center">
                                <div className="card col-md-6 col-sm-12 col-lg-5 mt-4 py-3 shadow">
                                        <div className="card-header text-muted noto bg-white">
                                            <i className="fas fa-book-open pr-2"></i> Manage Course
                                            <span style={{float: "right"}}>
                                                <form action="delete-courses.htm">
                                                    <input type='hidden' name='course_id' id="course_id" value='${param.id}' />
                                                    <button className="btn btn-sm btn-danger" type="submit">
                                                        <span style={{whiteSpace: "nowrap"}}><i className="fas fa-user-minus"></i> Delete </span>
                                                    </button>        
                                                </form>
                                            </span>
                                        </div>
                                        <form action="update-courses.htm">
                                            <div className="form-group row mt-3">
                                                <label for="new_course_name" className="col-sm-3 col-form-label">Course</label>
                                                <div className="col-sm-9">
                                                    <input type="hidden" name="course_name" id="course_name" value='${param.id}' />
                                                    <input type="text" className="form-control" id="new_course_name" onchange="myFunction()" name="new_course_name" value="${param.id}" required />
                                                    <div><small id="ajaxconf" className="text-danger"></small></div>
                                                </div>
                                            </div>
                                            <div className="form-group row mt-3">
                                                <label for="new_id" className="col-sm-3 col-form-label">Stream</label>
                                                <div className="form-group col-md-9">
                                                    <select className="custom-select" name= "streamname" id="streamname" placeholder="Select a Stream">
                                                    <option selected hidden value="${param.name}">${param.name}</option>
                                                        <c:forEach items="${fullstreamList}" var="streamer">
                                                            <option value="${streamer}">
                                                                ${streamer}
                                                            </option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                            </div>
                                            <div className="form-group row mt-3">
                                                <label for="new_id" className="col-sm-3 col-form-label">Module</label>
                                                <div className="form-group col-md-9">
                                                    <div id="dropdown_stuff">
                                                        <select className="custom-select" name= "modulename" id="modulename">
                                                            <option value="${param.name2}">${param.name2}</option>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                            <div className="row justify-content-center mt-1">
                                                <div className="row pt-3">
                                                    <div className="col-6">
                                                        <button className="btn btn-sm btn-secondary" type="submit">
                                                            <span style={{whiteSpace: "nowrap"}}><i className="fas fa-user-edit"></i> Update </span>
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>               
            );
        }
    }
    
    ReactDOM.render(<Courses />, document.getElementById('courses'));
    ReactDOM.render(<Redirect />, document.getElementById('redirect'));
    ReactDOM.render(<CoursesForm />, document.getElementById('courses-form'));
</script>






