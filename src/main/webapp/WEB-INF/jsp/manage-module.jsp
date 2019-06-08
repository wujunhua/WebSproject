
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
  String sql, sql3;
  int numRowsAffected;
  Statement stmt = conn.createStatement();
  ResultSet rs;    
// select
  sql = "select stream_Name from stream";
  rs = stmt.executeQuery(sql);
    
 ArrayList streamName = new ArrayList();
  request.setAttribute("streamName", streamName);
  
  while (rs.next()) {
        streamName.add(rs.getString("stream_Name"));
        //out.println("User Id = " + rs.getString("user_id") + "<BR>"); 
        } // End while 
  sql = "select Category_Name from Category";
  rs = stmt.executeQuery(sql);
  
  ArrayList allCategoryName = new ArrayList();
  request.setAttribute("allCategoryName",allCategoryName);
  
 while (rs.next()) {
        allCategoryName.add(rs.getString("Category_Name"));
        //out.println("User Id = " + rs.getString("user_id") + "<BR>"); 
        } // End while
 
//check to see if it can be deleted
String id = request.getParameter("id");
String mn = request.getParameter("okay");
sql3 = "select c.course_name from courses c, modules m where c.module_id=m.module_id and m.module_name = '" + mn + "'";
rs = stmt.executeQuery(sql3);

boolean moduleCanBeDeleted = rs.next();

%>


<html>
    <head>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/babel-standalone/6.24.0/babel.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/react/15.4.2/react.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/react/15.4.2/react-dom.min.js"></script>
    </head>
<jsp:include page="head-tag.jsp"/>

<body class="bg-light">
    
  <jsp:include page="nav.jsp"/>
  <div id="root"></div>
  <div id="root2"></div>
  <div id="root3"></div>
  
  <script type="text/babel">
      class Cat1 extends React.Component {
          render(){
              return(
                      <div className="container-fluid">
                        <div className="container mt-2 pt-4 pb-3">
                          <nav aria-label="breadcrumb">
                            <ol className="breadcrumb" style={{background: "transparent"}}>
                              <li className="breadcrumb-item"><a href="admin.htm">Admin</a></li>
                              <li className="breadcrumb-item active">Modules</li>
                              <li className="breadcrumb-item active" aria-current="page">Manage Module</li>
                            </ol>
                          </nav>
                        </div>
                      </div>
                    );
          }
      };
      
      class Cat2 extends React.Component {
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
                              <a className="nav-link active" href="modules.htm">Modules</a>
                            </li>
                            <li className="nav-item">
                              <a className="nav-link" href="courses.htm">Courses</a>
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
        class Cat3 extends React.Component {
          render(){
              return(
                      <div className="container-fluid bg-white" style={{minHeight: "100vh"}}>
                        <div className="container pb-5">
                          <div className="row justify-content-center">
                            <div className="card col-md-6 col-sm-12 col-lg-5 mt-4 py-3 shadow">
                              <div className="card-header text-muted noto bg-white">
                                <i className="fas fa-layer-group pr-2"></i> Manage Module 
                                <span style={{float: "right"}}>
                                  <form action="deleteModule.htm">
                                      <input type="hidden" name='moduleName' id ="moduleName" value='${param.okay}' />
                                      <input type="hidden" name='moduleIdd' id ="moduleIdd" value='${param.id}' />
                                       <% if(moduleCanBeDeleted){%>
                                       <button className="btn btn-sm btn-danger" type ="submit" title="This module contains courses and cannot be deleted" disabled >
                                        <%} else{%>
                                        <button className="btn btn-sm btn-danger" type="submit" >
                                        <%}%>
                                      <span style={{whiteSpace: "nowrap"}}><i className="fas fa-user-minus"></i> Delete </span>
                                      </button>
                                  </form>
                                </span>
                              </div>
                              <form action="updateModule.htm">
                                  <input type="hidden" name='moduleId' id ="moduleId" value='${param.id}' />
                                <div className="form-group row mt-3">
                                  <label for="new_module" className="col-sm-3 col-form-label">Module</label>
                                  <div className="col-sm-9">
                                    <input type="text" className="form-control" id="modName" onchange="myFunction()" name ="modName" placeholder="" value="${param.okay}" required />
                                    <div><small id="ajaxconf" className="text-danger"></small></div>
                                  </div>
                                </div>
                                  <div className="form-group row mt-3">
                                  <label for="new_module" className="col-sm-3 col-form-label">Category</label>
                                  <div className="col-sm-9">
                                      <select id="inputState" className="form-control" required="" name ="cat">
                                          <option selected hidden value="${param.name}">${param.name}</option>
                                            <c:forEach items="${allCategoryName}" var="catNam">
                                                <option value="${catNam}">
                                                    ${catNam}
                                                </option>
                                            </c:forEach>
                                        </select>
                                  </div>
                                </div>
                                <div className="form-group row mt-3">
                                  <label for="new_stream_id" className="col-sm-3 col-form-label">Stream Name</label>
                                  <div className="col-sm-9">
                                      <select id="inputState2" className="form-control" required="" onchange="myFunction()" name ="streamName" id ="streamName">
                                        <option selected hidden value="${param.stream}">${param.stream}</option>
                                          <c:forEach items="${streamName}" var="stream">
                                              <option value="${stream}">
                                                  ${stream}
                                              </option>
                                          </c:forEach>
                                      </select>
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
      };
      
        ReactDOM.render(<Cat1 />, document.getElementById("root"));
        ReactDOM.render(<Cat2 />, document.getElementById("root2"));
        ReactDOM.render(<Cat3 />, document.getElementById("root3"));
  </script>

<!-- Optional JavaScript -->

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
  var modName = document.getElementById("modName").value;
  var modId = document.getElementById("moduleId").value;
  var sName = document.getElementById("inputState2").value;
  
  var xhttp = new XMLHttpRequest();
  xhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
     document.getElementById("ajaxconf").innerHTML = this.responseText;
    }
  };
  
  xhttp.open("GET", "ajaxconf.htm?modName="+encodeURIComponent(modName)+"&modId="+encodeURIComponent(modId)+"&sName="+encodeURIComponent(sName)+"&num=1", true);
  xhttp.send();
}
</script>