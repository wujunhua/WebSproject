<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.ArrayList"%>
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
   
  } catch(Exception e) {
    out.println("Connection failed: " + e.toString() + "<P>");      
  }
  String sql;
  int numRowsAffected;
  Statement stmt = conn.createStatement();
  ResultSet rs;
  
  // select
  sql = "select user_id, isadmin from users";
  rs = stmt.executeQuery(sql);
  
  ArrayList usersList = new ArrayList();
  request.setAttribute("usersList", usersList);
  
  ArrayList isadminList = new ArrayList();
  request.setAttribute("isadminList", isadminList);
  
 
  
  while (rs.next()) {
        usersList.add(rs.getString("user_id"));
        isadminList.add(rs.getString("isadmin"));
        } // End while 
  
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
    <body class="bg-light">
        <jsp:include page="nav.jsp"/>
        <div id="admin"></div>
        <div id="redirect"></div>
        <div id="table-form"></div>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/babel-standalone/6.24.0/babel.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/react/15.4.2/react.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/react/15.4.2/react-dom.min.js"></script>
        
        <!-- jQuery -->
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <!-- Popper.js -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <!-- Bootstrap.js -->
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

        <script src="<c:url value="/resources/js/emailValidate.js" />"></script>
    </body>
</html>

<script type ="text/babel">
    class Admin extends React.Component {
      render() {
        return (
                <div className="container-fluid">
                  <div className="container mt-2 pt-4 pb-3">
                      <nav aria-label="breadcrumb">
                        <ol className="breadcrumb" style={{background: "transparent"}}>
                          <li className="breadcrumb-item"><a href="#">Admin</a></li>
                          <li className="breadcrumb-item active" aria-current="page">Users</li>
                        </ol>
                      </nav>
                  </div>
                </div>
        );
      }
    };
    
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
                                    <a className="nav-link" href="courses.htm">Courses</a>
                                </li>
                                <li className="nav-item">
                                    <a className="nav-link active" href="admin.htm">Users</a>
                                </li>
                            </ul>
                        </div>
                    </div>
            );
        }
    };
    
    class TableForm extends React.Component {
        render() {
            return (
                    <div className="container-fluid bg-white" style={{minHeight: "100vh"}}> 
                        <div className="container pb-5">
                          <div className="row py-3">
                            <div className="col-lg-12">
                              <form action="create-user.htm">
                                <div className="form">
                                  <div className="form-row">
                                    <div className="col-2">
                                      <button className="btn btn-sm mt-1 btn-primary no-border" onclick="checkDomain()" type="submit"><i className="fas fa-plus pr-2" />Insert User</button>
                                    </div>
                                    <div className="col-6">
                                      <input type="email" className="form-control" id="username" onchange="myFunction()" name="username" placeholder="Email" pattern="[a-zA-Z][a-zA-Z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$" title="Must be a valid atos or syntel email" required />
                                      <div><small id="ajaxconf" className="text-danger" /></div>
                                    </div>
                                    <div>
                                      <input type="hidden" className="form-control" id="password" name="password" defaultValue="syntel123" />
                                    </div>
                                    <div className="col-4">
                                      <div className="form-group pt-lg-2 pl-lg-2">
                                        <div className="custom-control custom-radio custom-control-inline">
                                          <input type="radio" className="custom-control-input" id="customRadio" name="example" defaultValue="Y" />
                                          <label className="custom-control-label" htmlFor="customRadio"><small>Admin</small></label>
                                        </div>
                                        <div className="custom-control custom-radio custom-control-inline">
                                          <input type="radio" className="custom-control-input" id="customRadio2" name="example" defaultValue="N" defaultChecked />
                                          <label className="custom-control-label" htmlFor="customRadio2"><small>Instructor</small></label>
                                        </div> 
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
                                <th scope="col">Email</th>
                                <th scope="col">Admin</th>
                            </tr>
                            </thead>
                            <tbody>
                                <c:set var="count" value="1"/>
                                <c:forEach items="${usersList}" var="user">
                                <tr value="${user}">
                                    <th scope="row">${count}</th>
                                    <td><a href="manage-user.htm?id=${user}">${user}</a></td>
                                    <td>${isadminList.get(count-1)}</td>
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
    
    ReactDOM.render(<Admin />, document.getElementById('admin'));
    ReactDOM.render(<Redirect />, document.getElementById('redirect'));
    ReactDOM.render(<TableForm />, document.getElementById('table-form'));
</script>

<script>
function myFunction()
{
  var uName = document.getElementById("username").value;
  
  var xhttp = new XMLHttpRequest();
  xhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
     document.getElementById("ajaxconf").innerHTML = this.responseText;
    }
  };
  
  xhttp.open("GET", "ajaxconf.htm?name="+encodeURIComponent(uName)+"&num=10", true);
  xhttp.send();
}
</script>