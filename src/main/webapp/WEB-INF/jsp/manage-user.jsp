<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.sql.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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
        conn = DriverManager.getConnection(dbURL, dbUser, dbPasswd);
        //out.println(" Connection status: " + conn + "<P>");
    } catch (Exception e) {
        out.println("Connection failed: " + e.toString() + "<P>");
    }

    String sql;
    int numRowsAffected;
    Statement stmt = conn.createStatement();
    ResultSet rs;
    String user_id = request.getParameter("id");

    sql = "select  user_id from users where user_id='" + user_id + "'";
    rs = stmt.executeQuery(sql);

    boolean userCantBeUpdated = rs.next();
%>

<!DOCTYPE html>
<html>
    <jsp:include page="head-tag.jsp"/>
    <body class="bg-light">
        <jsp:include page="nav.jsp"/>
        <div id="admin"></div>
        <div id="redirect"></div>
        <div id="manage"></div>
    
    
        <script src="https://cdnjs.cloudflare.com/ajax/libs/babel-standalone/6.24.0/babel.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/react/15.4.2/react.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/react/15.4.2/react-dom.min.js"></script>

        <!-- jQuery -->
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <!-- Popper.js -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <!-- Bootstrap.js -->
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

        <script type="text/javascript">
            function checkDomain() {
                var x = document.getElementById("inputEmail3").value;
                x = x.toLowerCase();
                x = x.split('@');
                x = x[1];
                if (x === "syntelinc.com")
                {
                    return true;
                } else if (x === "atos.net")
                {
                    return true;
                } else
                {
                    alert("Not a valid atos or syntel email");
                    event.preventDefault();
                }
            }
        </script>
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
                          <li className="breadcrumb-item"><a href="admin.htm">Admin</a></li>
                          <li className="breadcrumb-item active">Users</li>
                          <li className="breadcrumb-item active" aria-current="page">Manage User</li>
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
    
    class Manage extends React.Component {
        constructor() {
            super();
            this.state = {
                selectedOption: 'N'
            };
            this.radioChange = this.radioChange.bind(this);
        }
        
        radioChange(event) {
            this.setState({
                selectedOption: event.target.value
            });
        }
        
        render() {
            return (
                    <div className="container-fluid bg-white" style={{minHeight: "100vh"}}>
                        <div className="container pb-5">
                            <div className="row justify-content-center">
                                <div className="card col-md-6 col-sm-12 col-lg-5 mt-4 py-3 shadow">
                                    <div className="card-header text-muted noto bg-white">
                                        <i className="fas fa-user pr-2"></i>Edit User
                                        <span style={{float: "right"}}>
                                            <form action="delete-user.htm">
                                                <div className="col-sm-9">
                                                    <input type="hidden" className="form-control" id="inputEmail4" name="oldusername" value="${param.id}" />
                                                </div>
                                                <button type="submit" className="btn btn-sm btn-danger">
                                                    <span style={{whiteSpace: "nowrap"}}><i className="fas fa-user-minus"></i>Delete</span>
                                                </button>
                                            </form>
                                        </span>
                                    </div>
                                    <form>
                                        <div className="form-group row mt-3">
                                            <label for="inputEmail3" className="col-sm-3 col-form-label">Email</label>
                                            <div className="col-sm-9">
                                                <input type="email" className="form-control" id="inputEmail3" onchange="myFunction()" name="newusername" value="${param.id}" pattern="[a-zA-Z][a-zA-Z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$" title="Must be a valid atos or syntel email" required />
                                                <div><small id="jackson_1" className="text-danger"></small></div>
                                            </div>
                                            <div className="col-sm-9">
                                                <input type="hidden" className="form-control" id="inputEmail4" name="oldusername" value="${param.id}" required />
                                            </div>
                                        </div>
                                        <div className="form-group row mt-1">
                                            <label for="inputEmail3" className="col-sm-4 col-form-label">User Level</label>
                                            <div className="col-sm-8 pt-2">
                                                <div className="form-check form-check-inline">
                                                    <input type="radio" id="customRadio1" name="radio1" value="N" checked={this.state.selectedOption === "N"} onChange={this.radioChange} />
                                                    <label  for="customRadio1"><small>Instructor</small></label>
                                                </div>
                                                <div className="form-check form-check-inline">
                                                    <input type="radio"  id="customRadio2" name="radio2" value="Y" checked={this.state.selectedOption === "Y"} onChange={this.radioChange} />
                                                    <label  for="customRadio2"><small>Admin</small></label>
                                                </div>
                                            </div>
                                        </div>
                                        <div className="row justify-content-center mt-1">
                                            <div className="row pt-3">
                                                <div className="col-6">
                                                    <button className="btn btn-sm btn-secondary" type="submit" onclick="checkDomain()">
                                                        <span style={{whiteSpace: "nowrap"}}><i className="fas fa-user-edit"></i>Update</span>
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
    
    ReactDOM.render(<Admin />, document.getElementById('admin'));
    ReactDOM.render(<Redirect />, document.getElementById('redirect'));
    ReactDOM.render(<Manage />, document.getElementById('manage'));
</script>

<script>
    function myFunction()
    {
        var oName = document.getElementById("inputEmail4").value;
        var nName = document.getElementById("inputEmail3").value;

        var xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = function () {
            if (this.readyState == 4 && this.status == 200) {
                document.getElementById("ajaxconf").innerHTML = this.responseText;
            }
        };

        xhttp.open("GET", "ajaxconf.htm?oldUn=" + encodeURIComponent(oName) + "&newUn=" + encodeURIComponent(nName) + "&num=5", true);
        xhttp.send();
    }
</script>