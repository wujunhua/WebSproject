<%@ taglib uri="http://www.springframework.org/tags/form" prefix="s"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri = "http://www.springframework.org/tags/form" prefix = "form"%>

<%@page import="java.util.ArrayList"%>
<%@ page import="com.atossyntel.excelupload.Module" %>
<%@ page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
  
  // select
  sql = "select email, name from employees";
  rs = stmt.executeQuery(sql);
  
  ArrayList usersList = new ArrayList();
  request.setAttribute("usersList", usersList);
  ArrayList nameList = new ArrayList();
  request.setAttribute("nameList", nameList);
  
  while (rs.next()) {
        usersList.add(rs.getString("email"));
        nameList.add(rs.getString("name"));
        //out.println("User Id = " + rs.getString("user_id") + "<BR>"); 
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
        <div id="instructor"></div>
        <div id="redirect"></div>
        <div id="email"></div>
        
        <script src="https://cdnjs.cloudflare.com/ajax/libs/babel-standalone/6.24.0/babel.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/react/15.4.2/react.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/react/15.4.2/react-dom.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/react-router-dom/5.0.1/react-router-dom.min.js"></script>
        <!-- jQuery -->
        <script src="https://code.jquery.com/jquery-3.3.1.min.js" crossorigin="anonymous"></script>
        <!-- Popper.js -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <!-- Bootstrap.js -->
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    </body>
</html>
<script type="text/javascript">
    $(document).ready(function(){
        //Clear modure score drop down when modal is closed.
        $(document).on("hidden.bs.modal", function(){
            $("#selectModule").empty();
            $("#editModuleScore").val("");
            $("#editModuleID").val("");
        });
        //Update module score when drop box of module name is changed.
        $(document).on("change", "#selectModule", function(){
            $("#editModuleScore").val($("#selectModule option:selected").data("modscore"));
            $("#editModuleID").val($("#selectModule option:selected").data("modid"));
        });
        //Send data to edit modal
        $(document).on("click", "#deleteButton", function(){
            $("#deleteModalButton").val($(this).data("id"));
        });
        //Send data to delete modal
        $(document).on("click", "#editButton", function(){
            $("#editModalButton").val($(this).data("id"));
            $("#editName").val($(this).data("name"));
            $("#editEmail").val($(this).data("email"));

            //Parse out arraylist of modules
            var scoreArr = $(this).data("modulescores").toString();
            //Remove []
            scoreArr = scoreArr.toString().substring(1, scoreArr.length);
            scoreArr = scoreArr.toString().substring(0, scoreArr.length-2);
            //Spilt into single modules
            var s = scoreArr.split("], ");
            //Extract module name and score
            for(i = 0; i < s.length; i++){ 
               //Seperate module name and score for each module name
               var str = s[i].substring(8, s[i].length).split(", ");
               var name = str[0].substring(9, str[0].length);
               var scoreVal = str[1].substring(12, str[1].length);
               var scoreID = str[2].substring(9, str[2].length);

               //Create new option in select tag for drop down
               var o = new Option(name, name);  
               $(o).html(name);   //inner html
               $(o).attr("data-modscore", scoreVal); //Add data attr of score.
               $(o).attr("data-modid", scoreID); //Add data attr of id.
               $("#selectModule").append(o);                           
            }
            //If scores not empty then display score of selected.
            if(s.length>0){
                //Set to first option.
                $("#selectModule>option:eq(0)").attr("selected", true);
                $("#editModuleScore").val($("#selectModule option:selected").data("modscore"));
                $("#editModuleID").val($("#selectModule option:selected").data("modid"));
            }
        });
     });
</script>

<script type ="text/babel">
    class Instructor extends React.Component {
      render() {
        return (
                <div className="container-fluid">
                    <div className="container mt-2 pt-4 pb-3">
                        <nav aria-label="breadcrumb">
                            <ol className="breadcrumb" style={{background: "transparent"}}>
                                <li className="breadcrumb-item"><a href="#">Instructor</a></li>
                                <li className="breadcrumb-item active" aria-current="page">Employees</li>
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
                                    <a className="nav-link" href="createclass.htm">Create Class</a>
                                </li>
                                <li className="nav-item">
                                    <a className="nav-link" href="email.htm">Email Hub</a>
                                </li>
                                <li className="nav-item">
                                    <a className="nav-link active" href="showEmployees.htm">Employees</a>
                                </li>
                            </ul>
                        </div>
                    </div>
            );
        }
    };
    
    $.ajaxSetup({
        async: false
    });

    function GetEmployees() {
        var empData;
        $.getJSON("http://localhost:8084/WebAPI/getAllEmployees", function(data) {
            empData = data;
        });
        var etmData;
        $.getJSON("http://localhost:8084/WebAPI/getAllEmployeeTakeModule", function(data) {
            etmData = data;
        });
        var modData;
        $.getJSON("http://localhost:8084/WebAPI/getAllModules", function(data) {
            modData = data;
        });
        
        var modName = [];

        modData.forEach(function(mod){
                modName.push(Object.values(mod)[1]);
        });
        
        function getModName(modId){
            return modName[modId-1];
        }
        function modScores(empid){
            var modDetails = [];
            etmData.forEach(function(data){
                    modDetails.push(Object.values(data));
            });
            var bigString = "";
            modDetails.forEach(function(det){
                if(det[1]==empid){
                    bigString += "Module [moduleId= " + getModName(det[2]) 
                            + ", moduleScore=" + det[0] 
                            + ", moduleID=" + det[3] + "], ";
                }
            });
            
            return bigString;
        }
        var count = 1;
        const tablebody = empData.map((emp) =>
            <tr key={emp.employeeId}>
                <td>
                    <a href="#" id="editButton" data-toggle="modal" data-target="#editModal" 
                       data-target="#editModal" data-id={emp.employeeId} data-name={emp.name}
                       data-email={emp.email} data-modulescores={modScores(emp.employeeId)}>{emp.name}
                    </a>
                </td>
                <td>{emp.email}</td>
                <td>
                    <button id="deleteButton" type="button" className="btn btn-danger" data-toggle="modal"
                            data-target="#deleteModal" data-id={emp.employeeId}>Delete</button>
                </td>
            </tr>
        );

        return(
            <tbody>
                {tablebody}
            </tbody>
        );
    }
    
    class Email extends React.Component {
        render() {
            return(
                    <div className="container-fluid bg-white" style={{height: "100vh"}}>
                        <div className="container pb-5 pt-3">
                            <form:form method="post" action="searchEmployees.htm" className="form-inline pt-1 pb-2 w-100"> 
                                <button className="btn btn-primary rounded-0 px-3 mr-2 my-1" type="submit"><i className="fas fa-search pr-1"></i>Search</button>
                                <select name="col" className="custom-select my-1 mr-sm-2">
                                    <option value="name">Name</option>
                                    <option value="email">Email</option>
                                </select>
                                <input type="text" placeholder="Search.." name="search" className="form-control my-1 mr-sm-2" />
                            </form:form>
                            <table className="table table-striped table-sm table-bordered">
                                <thead>
                                    <tr>
                                        <th>Name</th>
                                        <th>Email</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <GetEmployees />
                            </table>
                            <div className="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="editModalLabel" aria-hidden="true">
                                <div className="modal-dialog" role="document">
                                    <div className="modal-content">
                                        <div className="modal-header">
                                            <h5 className="modal-title" id="editModalLabel">Edit Employee</h5>
                                            <button type="button" className="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                        <form:form method="post" action="editEmployees.htm">
                                            <div className="modal-body">
                                                <div className="form-group">
                                                    <label for="editName">Employee Name: 
                                                    </label> <input type="text" id="editName" name="editName" className="form-control" pattern="[A-Za-z]+ [A-Za-z]+" />
                                                </div>
                                                <div className="form-group">
                                                    <label for="editEmail">Employee Email: </label> 
                                                    <input type="text" id="editEmail" name="editEmail" className="form-control" pattern="[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[a-z]{2,4}$" />
                                                </div>   
                                                <div className="form-group">
                                                    <label for="selectModule">Module Name: </label> 
                                                    <select id="selectModule" name="selectModule" className="custom-select my-1 mr-sm-2"></select>
                                                    <label for="editModuleModule">Module Score: </label>
                                                    <input type="number" id="editModuleScore" name="editModuleScore" className="form-control my-1 mr-sm-2" step="0.01" />
                                                    <input type="hidden" id="editModuleID" name="editModuleID" />
                                                 </div>
                                            </div>
                                            <div className="modal-footer">
                                                <button type="button" id="editCloseModalButton" className="btn btn-secondary" data-dismiss="modal">Close</button>
                                                <button name="editModalButton" type="submit" id="editModalButton" className="btn btn-primary btn-primary">
                                                    Confirm Update
                                                </button>
                                            </div>
                                        </form:form>
                                    </div>
                                </div>
                            </div> 
                            <div className="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="deleteModalLabel" aria-hidden="true">
                                <div className="modal-dialog" role="document">
                                    <div className="modal-content">
                                        <div className="modal-header">
                                            <h5 className="modal-title" id="deleteModalLabel">Confirm Delete</h5>
                                            <button type="button" className="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                        <div className="modal-body">
                                            Are you sure you want to delete this employee?
                                        </div>
                                        <div className="modal-footer">
                                            <form method="post" action="deleteEmployees.htm">
                                                <button type="button" className="btn btn-secondary" data-dismiss="modal">Close</button>
                                                <button name="deleteModalButton" type="submit" id="deleteModalButton" className="btn btn-primary btn-danger">
                                                    Confirm Delete
                                                </button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
            );
        }
    }
    

    ReactDOM.render(<Instructor />, document.getElementById('instructor'));
    ReactDOM.render(<Redirect />, document.getElementById('redirect'));
    ReactDOM.render(<Email />, document.getElementById('email'));
</script>

