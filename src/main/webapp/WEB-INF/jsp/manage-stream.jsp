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

String sql, sql2;
int numRowsAffected;
Statement stmt = conn.createStatement();
ResultSet rs, rs2;
String stream_name = request.getParameter("id");

sql = "select m.module_name from modules m, stream s where s.stream_id = m.stream_id and stream_name ='" + stream_name + "'";
rs = stmt.executeQuery(sql);

boolean streamCantBeDeleted = rs.next();

%>

<body class="bg-light">

  <jsp:include page="nav.jsp"/>
 <div id="category"></div>
        <div id="category2"></div> 
        <div id="category3"></div> 
        <script src="https://cdnjs.cloudflare.com/ajax/libs/babel-standalone/6.24.0/babel.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/react/15.4.2/react.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/react/15.4.2/react-dom.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <!-- Popper.js -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <!-- Bootstrap.js -->
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    </body>
</html>
            
        <script type ="text/babel">
        class Category extends React.Component {	
            render() {
                return (
                    <div className="container-fluid">
    <div className="container mt-2 pt-4 pb-3">
      <nav aria-label="breadcrumb">
        <ol className="breadcrumb" style={{background: "transparent"}}>
          <li className="breadcrumb-item"><a href="admin.htm">Admin</a></li>
          <li className="breadcrumb-item active">Streams</li>
          <li className="breadcrumb-item active" aria-current="page">Manage Stream</li>
        </ol>
      </nav>
    </div>
  </div>
    );
    }
};

    class Category2 extends React.Component {
        render(){
            return (
                        <div className="container-fluid">
    <div className="container">
      <ul className="nav nav-tabs">
        <li className="nav-item">
          <a className="nav-link active" href="streams.htm">Streams</a>
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
          <a className="nav-link" href="admin.htm">Users</a>
        </li>
      </ul>
    </div>
  </div>
                    );
        }
    }

    class Category3 extends React.Component{	
        render() {
                return (
                        <div className="container-fluid bg-white" style={{minHeight: "100vh"}}>
    <div className="container pb-5">

      <div className="row justify-content-center">
        <div className="card col-md-6 col-sm-12 col-lg-5 mt-4 py-3 shadow">
          <div className="card-header text-muted noto bg-white">
            <i className="fas fa-water pr-2"></i> Manage Stream 
            <span style={{float: "right"}}>
              <form action = "delete-stream.htm">
                <input type='hidden' name='stream_id' id="stream_id" value='${param.id}' />
                <% if(streamCantBeDeleted){%>
                <button className="btn btn-sm btn-danger" type="submit" title="This stream contains modules and cannot be deleted" disabled>
                <%} else{%>
                <button className="btn btn-sm btn-danger" type="submit" >
                <%}%>
                  <span style={{whiteSpace: "nowrap"}}><i className="fas fa-user-minus"></i> Delete </span>
                </button>
              </form>
            </span>
          </div>
          <form action ="update-stream.htm">
            <div className="form-group row mt-3">
              <label for="new_stream_name" className="col-sm-3 col-form-label">Stream</label>
              <div class="col-sm-9">
                  <input type ="hidden" name="stream_name" id="stream_name" value='${param.id}'/>
                <input type="text" className="form-control" id="new_stream_name" onchange="myFunction()" name ="new_stream_name" value="${param.id}" pattern="[a-zA-Z][a-zA-Z0-9-_.+#* ]{2,20}" title="Name must start with a letter and can only contain letters, numbers, hyphens, underscores, periods, hashtag, plus, star and be between 3 than 20 characters." required />
                <div><small id="ajaxconf" className="text-danger"></small></div>
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
    
    ReactDOM.render(<Category />, document.getElementById('category'));
    ReactDOM.render(<Category2 />, document.getElementById('category2'));
    ReactDOM.render(<Category3 />, document.getElementById("category3"));
                                                
</script> 
  <!-- /Tabs -->

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
  var sName = document.getElementById("new_stream_name").value;
  
  var xhttp = new XMLHttpRequest();
  xhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
     document.getElementById("ajaxconf").innerHTML = this.responseText;
    }
  };
  
  xhttp.open("GET", "ajaxconf.htm?streamName="+encodeURIComponent(sName)+"&num=2", true);
  xhttp.send();
}
</script>