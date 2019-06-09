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
        conn = DriverManager.getConnection(dbURL, dbUser, dbPasswd);
        //out.println(" Connection status: " + conn + "<P>");
    } catch (Exception e) {
        out.println("Connection failed: " + e.toString() + "<P>");
    }

    String sql;
    int numRowsAffected;
    Statement stmt = conn.createStatement();
    ResultSet rs;

    sql = "select category_name from category";
    rs = stmt.executeQuery(sql);

    ArrayList categoryList = new ArrayList();
    request.setAttribute("categoryList", categoryList);

    ArrayList cleanedCategoryList = new ArrayList();
    request.setAttribute("cleanedCategoryList", cleanedCategoryList);

    String cleanedString;

    while (rs.next()) {
        categoryList.add(rs.getString("category_name"));

        cleanedString = rs.getString("category_name");
        cleanedString = cleanedString.trim();
        //replacing + with %2B
        cleanedString = cleanedString.replaceAll("\\+", "%2B");
        //replacing spaces with %20
        cleanedString = cleanedString.replaceAll("\\s", "+");
        //replacing # with %23
        cleanedString = cleanedString.replaceAll("\\#", "%23");

        cleanedCategoryList.add(cleanedString);
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
              <li className="breadcrumb-item"><a href="#">Admin</a></li>
              <li className="breadcrumb-item active" aria-current="page">Category</li>
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
    }

    class Category3 extends React.Component{	
        render() {
                return (
                        <div className="container-fluid bg-white" style={{minHeight: "100vh"}}>
                            <div className="container pb-5">
                                <div className="row py-3">
                                    <div className="col-sm-12">
                                        <form action="create-category.htm">
                                            <div className="form-row">
                                                <div className="col-sm-2">
                                                    <button className="btn btn-sm btn-primary mt-1 no-border" type="submit"><i className="fas fa-plus pr-2"></i>Insert Category</button>
                                                </div>
                                                <div className="col-sm-10">
                                                    <input type="text" className="form-control" id ="CategoryName" onchange="myFunction()" name="categoryName" placeholder="Category Name" pattern="[a-zA-Z][a-zA-Z0-9-_.+#* ]{2,20}" title="Name must start with a letter and can only contain letters, numbers, hyphens, underscores, periods, hashtag, plus, star and be between 3 and 45 characters." required />
                                                    <div><small id="ajaxconf" className="text-danger"></small></div>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                                
                                <table className="table table-striped table-bordered">
                                    <thead>
                                        <tr>
                                            <th scope="col" style={{width: "10%"}}>#</th>
                                            <th scope="col">Category</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:set var ="count" value="1"/>
                                        <c:forEach items ="${categoryList}" var="cat">
                                            <tr value ="${cat}">
                                                <th scope = "row"> ${count}</th>
                                                <td>
                                                    <a href="manage-category.htm?id=${cleanedCategoryList.get(count-1)}">${cat}</a>
                                                </td>
                                            </tr>
                                        <c:set var="count" value = "${count+1}"/>    
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>

            );
        }
    };
    
    ReactDOM.render(<Category />, document.getElementById('category'));
    ReactDOM.render(<Category2 />, document.getElementById('category2'));
    ReactDOM.render(<Category3 />, document.getElementById("category3"));
                                                
</script> 
 

      
    <script>
    function myFunction()
    {
                                var catName = document.getElementById("CategoryName").value;

                                var xhttp = new XMLHttpRequest();
                                xhttp.onreadystatechange = function () {
                                    if (this.readyState == 4 && this.status == 200) {
                                        document.getElementById("ajaxconf").innerHTML = this.responseText;
        }
        };
        
        xhttp.open("GET", "ajaxconf.htm?name="+encodeURIComponent(catName)+"&num=9", true);
        xhttp.send();
        }
</script>
