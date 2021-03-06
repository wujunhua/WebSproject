<jsp:include page="head-tag.jsp"/>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.ArrayList"%>
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
    conn = DriverManager.getConnection(dbURL,dbUser,dbPasswd);
    //out.println(" Connection status: " + conn + "<P>");
  } catch(Exception e) {
    out.println("Connection failed: " + e.toString() + "<P>");      
  }

String sql;
Statement stmt = conn.createStatement();
ResultSet rs;
String user_id = (String)session.getAttribute("currentUserName");

ArrayList oldpassCheck = new ArrayList();
request.setAttribute("oldpassCheck", oldpassCheck);

sql = "select password from users where user_id='" + user_id + "'";
rs = stmt.executeQuery(sql);

while(rs.next())
{
   oldpassCheck.add(rs.getString("password"));
}


%>

<body class="bg-light">

  <jsp:include page="nav.jsp"/>
  <div id="category"></div>
        <div id="category2"></div> 
        <script src="https://cdnjs.cloudflare.com/ajax/libs/babel-standalone/6.24.0/babel.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/react/15.4.2/react.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/react/15.4.2/react-dom.min.js"></script>
 

  <script type ="text/babel">
        class Category extends React.Component {	
            render() {
                return (
                    <div className="container-fluid">
    <div className="container mt-2 pt-4 pb-3">
    </div>
  </div>
    );
    }
};

        
    class Category2 extends React.Component {
        render() {
                return (
                   <div className="container-fluid bg-white" style={{minHeight: "100vh"}}>
    <div className="container pb-5">
      <div className="row justify-content-center">
        <div className="card col-md-6 col-sm-12 col-lg-5 mt-4 py-3 shadow">
          <div className="card-header text-muted noto bg-white">
            <i className="fas fa-user pr-2"></i> Change Password
          </div>
            
          <form idName="changePass" action="update-password.htm">
            <div className="form-group row mt-3">
              <label for="oldpassword" className="col-sm-3 col-form-label">Current Password</label>
              <div className="col-sm-9">
                <input type="password" className="form-control" id="oldpassword"  name="oldpassword" placeholder="Enter Current Password" required/>
              <font color="red"><span id="oldpass"></span></font>
              </div>
              <div className="col-sm-9">
                <input type="hidden" className="form-control" id="oldpasscheck" name="oldpasscheck" value="${oldpassCheck.get(0)}" />
              </div>
            </div>
            <div className="form-group row mt-3">
              <label for="oldpassword" className="col-sm-3 col-form-label">New Password</label>
              <div className="col-sm-9">
                <input type="password" className="form-control" id="newpassword" name="newpassword" placeholder="Enter New Password" title="password must be 8-15 characters & contain atleast one alphanumric character" required pattern="(?=.*\d)(?=.*[A-Za-z]).{8,}" minlength = "8" maxlength = "15" required />
              </div>
            </div>
              
            <div className="form-group row mt-3">
              <label for="oldpassword" className="col-sm-3 col-form-label">Repeat Password</label>
              <div className="col-sm-9">
                <input type="password" className="form-control" id="newpasscheck" name="newpasscheck" placeholder="Repeat New Password" required />
                <font color="red"><span id="passMatch"></span></font>
              </div>
            </div>
              <div className="row justify-content-center mt-1">
              <div className="row pt-3">
                <div className="col-6">
                    <button className="btn btn-sm btn-secondary" type="button" onclick="checkPass()">
                      <span style={{whiteSpace: "nowrap"}}><i className="fas fa-user-edit"></i> Change Password </span>
                    </button>
                    <button className="btn btn-sm btn-secondary" id="clickButton" style={{display: "none"}} type="submit">
                      <span style={{whiteSpace: "nowrap"}}><i clasNames="fas fa-user-edit"></i></span>
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
                                                
</script> 
  <!-- /Tabs -->

  <!-- Optional JavaScript -->

  <!-- jQuery -->
  <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
  <!-- Popper.js -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
  <!-- Bootstrap.js -->
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

  <script type="text/javascript">
   function checkPass() {
        var newPassword = document.getElementById("newpassword").value;
        var newPasswordCheck = document.getElementById("newpasscheck").value;
        var oldPassword = document.getElementById("oldpassword").value;
        var oldPasswordCheck = document.getElementById("oldpasscheck").value;
        document.getElementById("oldpass").innerHTML = "";
        document.getElementById("passMatch").innerHTML = "";
        
        if(!(oldPassword == oldPasswordCheck))
        {
            document.getElementById("oldpass").innerHTML = "Incorrect password";
            return;
        }
        else if(!(newPassword == newPasswordCheck))        
        {
            document.getElementById("passMatch").innerHTML = "The repeated password does not match";
            return;
        }
        else 
            document.getElementById("clickButton").click();  
    }   
 </script>
 
</body>
</html>


