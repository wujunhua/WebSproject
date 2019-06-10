<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
    <jsp:include page="head-tag.jsp"/>
    <body class="bg-light" onload="loadDoc()">
        <jsp:include page="nav.jsp"/>
        <div id="root"></div>
        <div id="root2"></div>
        <div id="root3"></div>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/babel-standalone/6.24.0/babel.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/react/15.4.2/react.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/react/15.4.2/react-dom.min.js"></script>
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
      
    $.ajaxSetup({
        async: false
    });

    function InsertOptionStreams() {
        var jsonData;
        $.getJSON("http://localhost:8084/WebAPI/getAllStreams", function(data) {
            jsonData = data;
        });
        const options = jsonData.map((stream) =>
            <option key={stream.streamId} value={stream.streamId}>{stream.streamName}</option>
        );
        return(
            <select className="custom-select" name="streamname" id="streamname" onChange="loadDoc()">
                {options}
            </select>
        );
    }
    
    function InsertOptionModules() {
        var jsonData;
        $.getJSON("http://localhost:8084/WebAPI/getAllModules", function(data) {
            jsonData = data;
        });
        const options = jsonData.map((module) =>
            <option key={module.moduleId} value={module.moduleName}>{module.moduleName}</option>
        );
        return(
                <div>
                    <select className="custom-select" name="modulename" id="modulename" onChange="myFunction()">
                        {options}
                    </select>
                </div>
        );
    }
    
   
    
    function CoursesTable() {
        var courseData;
        $.getJSON("http://localhost:8084/WebAPI/getAllCourses", function(data) {
            courseData = data;
        });
        var streamData;
        $.getJSON("http://localhost:8084/WebAPI/getAllStreams", function(data) {
            streamData = data;
        });
        var moduleData;
        $.getJSON("http://localhost:8084/WebAPI/getAllModules", function(data) {
            moduleData = data;
        });
        
        
        var modIds = [];
        courseData.forEach(function(mod) {
            modIds.push(Object.values(mod)[1]);
        });
        
        var streamIds = [];
        modIds.forEach(function(mod) {
            for (var i = 0; i < moduleData.length; i++) {
                if (moduleData[i].moduleId == mod) {
                    streamIds.push(moduleData[i].streamId);
                }
            }
        });
        
        var streamNames = [];
        streamIds.forEach(function(stream) {
            for (var i = 0; i < streamData.length; i++) {
                if (streamData[i].streamId == stream) {
                    streamNames.push(streamData[i].streamName);
                }
            }
        });
        
        var moduleNames = [];
        modIds.forEach(function(mod) {
            for (var i = 0; i < moduleData.length; i++) {
                if (moduleData[i].moduleId == mod) {
                    moduleNames.push(moduleData[i].moduleName);
                }
            }
        });
        
        var count = 1;

        const tablebody = courseData.map((course) =>
            <tr key={course.courseId} value={course.courseName}>
                    <th scope="row">{count++}</th>
                    <td><a href={"manage-course.htm?id="+course.courseName + 
                            "&name=" + streamNames[count-2] + 
                            "&name2="+moduleNames[count-2]}>
                        {course.courseName}</a></td>
                    <td>{streamNames[count-2]}</td>
                    <td>{moduleNames[count-2]}</td>
            </tr>
        );
        return(
            <tbody>
                {tablebody}
            </tbody>
        );
    } 
    
   
    
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
                                        <InsertOptionStreams />
                                  </div>
                                  <div className="form-group col-md-3">
                                    <InsertOptionModules />
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
                          <CoursesTable />
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
    <script src="https://code.jquery.com/jquery-3.3.1.min.js" crossorigin="anonymous"></script>
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