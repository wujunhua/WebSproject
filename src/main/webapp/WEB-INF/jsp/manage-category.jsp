<jsp:include page="head-tag.jsp"/>
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
String category_name = request.getParameter("id");

sql = "select m.module_name from modules m, category c where m.category_id = c.category_id and category_name ='" + category_name + "'";
rs = stmt.executeQuery(sql);

boolean categoryCanBeDeleted = rs.next();

%>


<html>
<body class="bg-light">
  <jsp:include page="nav.jsp"/>
  <div id="managecategory"></div>
  <div id="managecategory2"></div>
  <div id="managecategory3"></div>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/babel-standalone/6.24.0/babel.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/react/15.4.2/react.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/react/15.4.2/react-dom.min.js"></script>
  <!-- jQuery -->
  <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
  <!-- Popper.js -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
  <!-- Bootstrap.js -->
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
</body>
</html>
  
 <script type ="text/babel">
 class ManageCategory extends React.Component {	
            render() {
                return (
  <div className="container-fluid">
    <div className="container mt-2 pt-4 pb-3">
      <nav aria-label="breadcrumb">
        <ol className="breadcrumb" style={{background: "transparent"}}>
          <li className="breadcrumb-item"><a href="admin.htm">Admin</a></li>
          <li className="breadcrumb-item active">Category</li>
          <li className="breadcrumb-item active" aria-current="page">Manage Category</li>
        </ol>
      </nav>
    </div>
  </div>
  );
        }
    };
   class ManageCategory2 extends React.Component {	
            render() {
                return (
  <div className="container-fluid">
    <div className="container">
      <ul className="nav nav-tabs">
        <li className="nav-item">
          <a className="nav-link" href="streams.htm">Streams</a>
        </li>  
        <li className="nav-item">
          <a className="nav-link active" href="category.htm">Category</a>
        </li>
        <li className="nav-item">
          <a className="nav-link" href="modules.htm">Modules</a>
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
    class ManageCategory3 extends React.Component {	
            constructor(props){
            super(props);
            this.state = {value:'${param.id}'};
            this.handleChange = this.handleChange.bind(this);
        }

        handleChange(event){
            this.setState({value: event.target.value});
        }
        
            render() {
                return (

  <div className="container-fluid bg-white" style={{minHeight: "100vh"}}>
    <div className="container pb-5">

      <div className="row justify-content-center">
        <div className="card col-md-6 col-sm-12 col-lg-5 mt-4 py-3 shadow">
          <div className="card-header text-muted noto bg-white">
            <i className="fas fa-water pr-2"></i> Manage Category 
            <span style={{float: "right"}}>
              <form action = "delete-category.htm">
                    <input type="hidden" name="category_name" id="category_name" value="${param.id}" />
                        <% if(categoryCanBeDeleted){%>
                        <button className="btn btn-sm btn-danger" type="submit" title="This category contains modules and cannot be deleted" disabled>
                        <%} else{%>
                        <button className="btn btn-sm btn-danger" type="submit">
                        <% } %>
                        <span style={{whiteSpace: "nowrap"}}><i className="fas fa-user-minus"></i> Delete </span>                
                        
                        </button>
                        
              </form>
            </span>
          </div>
          <form action ="update-category.htm">
            <div className="form-group row mt-3">
              <label for="new_stream_name" className="col-sm-3 col-form-label">Category</label>
              <div className="col-sm-9">
                  <input type ="hidden" name="category_name" id="category_name" value="${param.id}"/>
                <input type="text" className="form-control" id="new_category_name" onChange={this.handleChange} name="new_category_name" value={this.state.value} pattern="[a-zA-Z][a-zA-Z0-9-_.+#* ]{2,20}" title="Name must start with a letter and can only contain letters, numbers, hyphens, underscores, periods, hashtag, plus, star and be between 3 than 20 characters." required/>
                <div><small id="ajaxconf" className="text-danger"></small></div>
              </div>
            </div>
            <div className="row justify-content-center mt-1">
              <div className="row pt-3">
                <div className="col-6">
                    <button className="btn btn-sm btn-secondary" type="submit">
                      <span style={{whiteSpace: "nowrap"}}><i className="fas fa-user-edit"></i> Update</span>
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
    
    ReactDOM.render(<ManageCategory />, document.getElementById('managecategory'));
    ReactDOM.render(<ManageCategory2 />, document.getElementById('managecategory2'));
    ReactDOM.render(<ManageCategory3 />, document.getElementById('managecategory3'));
 </script> 
  


<script>
function myFunction()
{
  var nName = document.getElementById("new_category_name").value;
  
  var xhttp = new XMLHttpRequest();
  xhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
     document.getElementById("ajaxconf").innerHTML = this.responseText;
    }
  };
  
  xhttp.open("GET", "ajaxconf.htm?newCat="+encodeURIComponent(nName)+"&num=3", true);
  xhttp.send();
}
</script>
