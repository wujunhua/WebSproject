<jsp:include page="head-tag.jsp"/>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.ArrayList"%>
<%@ page import="java.sql.*" %>
 
<html>
    <head>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/babel-standalone/6.24.0/babel.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/react/15.4.2/react.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/react/15.4.2/react-dom.min.js"></script>
    </head>
    <body class="bg-light">

    <jsp:include page="nav.jsp"/>
    <div id="root"></div>
    <div id="root2"></div>
    <div id="root3"></div>
    
    <script type="text/babel">
        class HeadingLinks extends React.Component {
            render(){
                return(
                    <div className="container-fluid">
                        <div className="container mt-2 pt-4 pb-3">
                            <nav aria-label="breadcrumb">
                                <ol className="breadcrumb" style={{background:"transparent"}}>    
                                    <li className="breadcrumb-item"><a href="#">Admin</a></li>
                                    <li className="breadcrumb-item active" aria-current="page">Modules</li>
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
        $.ajaxSetup({
        async: false
        });
        function GetCategories() {
            var jsonData;
            $.getJSON("http://localhost:8084/WebAPI/getAllCategories", function(data) {
                jsonData = data;
            });
            const options = jsonData.map((cat) =>
                <option key={cat.categoryId} value={cat.categoryName}>{cat.categoryName}</option>
            );
            return(
                <select id="inputState" className="form-control" required="" name ="modCategory">
                    {options}
                </select>
            );
        }
        
        function GetStreams() {
            var jsonData;
            $.getJSON("http://localhost:8084/WebAPI/getAllStreams", function(data) {
                jsonData = data;
            });
            const options = jsonData.map((stream) =>
                <option key={stream.streamId} value={stream.streamId}>{stream.streamName}</option>
            );
            return(
                <select id="inputState2" onchange="myFunction()" className="form-control" required="" name ="streamName">
                    {options}
                </select>
            );
        }
        
        function GenerateTable() {
            var jsonStream;
            $.getJSON("http://localhost:8084/WebAPI/getAllStreams", function(data) {
                jsonStream = data;
            });
            var jsonCategory;
            $.getJSON("http://localhost:8084/WebAPI/getAllCategories", function(data) {
                jsonCategory = data;
            });
            var jsonModules;
            $.getJSON("http://localhost:8084/WebAPI/getAllModules", function(data) {
                jsonModules = data;
            });
            
            var catIds = [];
            var streamIds = [];
            jsonModules.forEach(function(mod){
                catIds.push(Object.values(mod)[3]);
                streamIds.push(Object.values(mod)[0]);
            });
            var catNames = [];
            var streamNames = [];
            catIds.forEach(function(cat){
                for (var i = 0; i < jsonCategory.length; i++){
                    if (jsonCategory[i].categoryId == cat){
                        catNames.push(jsonCategory[i].categoryName);
                    }
                } 
            });
            
            streamIds.forEach(function(stream){
                for (var i = 0; i < jsonStream.length; i++){
                    if (jsonStream[i].streamId == stream){
                        streamNames.push(jsonStream[i].streamName);
                    }
                } 
            });
            
            var count = 1;
            const tablebody = jsonModules.map((mod) =>
                <tr key={mod.userId} value={mod.userId}>
                        <th scope="row">{count++}</th>
                        <td><a href={"manage-module.htm?id="+ mod.moduleId 
                                + "&okay=" + mod.moduleName
                                + "&name=" + catNames[count-2]
                                + "&stream=" + streamNames[count-2]}>{mod.moduleName}</a></td>
                        <td>{catNames[count-2]}</td>
                        <td>{streamNames[count-2]}</td>
                </tr>
            );
    
            return(
                <tbody>
                    {tablebody}
                </tbody>
            );
        }
        class Content extends React.Component {
            constructor(props){
                super(props);
                this.handleSubmit = this.handleSubmit.bind(this);
            }

            handleSubmit(event) {
                event.preventDefault();
                var mName = $("#modName").val();
                var cName = $("#inputState :selected").text();
                var sName = $("#inputState2 :selected").text();
                
            }
            
            render(){
                return(
                    <div className="container-fluid bg-white" style={{minHeight:"100vh"}}>
                        <div className="container pb-5">
                            <div className="row py-3">
                                <div className="col-lg-12">
                                    <form action="createModule.htm">
                                        <div className="form">
                                            <div className="form-row">
                                                <div className="col-2">
                                                    <button className="btn btn-sm btn-primary mt-1 no-border" type="submit"><i className="fas fa-plus pr-2"></i>Insert Module</button>
                                                </div>
                                                <div class="col-4">
                                                    <input type="text" className="form-control" id="modName" name="modName" placeholder="Module Name" pattern="[a-zA-Z][a-zA-Z0-9-_.+#* ]{2,45}" title="Name must start with a letter and can only contain letters, numbers, hyphens, underscores, periods, hashtag, plus, star and be between 2 and 45 characters." required />
                                                    <div><small id="ajaxconf" className="text-danger"></small></div>
                                                </div>
                                                <div class="col-3">
                                                    <GetCategories />
                                                </div>
                                                <div class="col-3">
                                                    <GetStreams />
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
                                         <th scope="col">Name</th>
                                         <th scope="col">Category</th>
                                         <th scope="col">Stream Name</th>
                                    </tr>
                                    </thead>
                                        <GenerateTable />
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
  

  <!-- Optional JavaScript -->

  <!-- jQuery -->
  <script src="https://code.jquery.com/jquery-3.3.1.min.js" crossorigin="anonymous"></script>
  <!-- Popper.js -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
  <!-- Bootstrap.js -->
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

</body>
</html>