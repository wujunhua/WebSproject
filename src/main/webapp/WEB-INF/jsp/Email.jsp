<%@ taglib uri="http://www.springframework.org/tags/form" prefix="s"%> 
<%@ taglib uri = "http://www.springframework.org/tags/form" prefix = "form"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<HTML>
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <!-- Custom CSS -->
        <link rel="stylesheet" href="css/styles.css">
        <!-- Animate CSS -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.7.0/animate.min.css">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous">
        <!-- Google Fonts (Noto Sans) --> 
        <link href="https://fonts.googleapis.com/css?family=Noto+Sans" rel="stylesheet">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/babel-standalone/6.24.0/babel.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/react/15.4.2/react.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/react/15.4.2/react-dom.min.js"></script>
        <title>Atos Syntel &middot; Land</title>
        <style>
            p, h1, h2, h3, h4, h5, h6, li, ul, ol{
                font-family: Verdana,Geneva,sans-serif;
            }
        </style>
    </head>
<body class="bg-light">
    
    <jsp:include page="nav.jsp"/>
    
    <%  String pdfSaved = request.getParameter("pdfSaved");
        
        if(pdfSaved != null) { %>
            <div class="alert alert-success alert-dismissible fade show text-center" role="alert">
                The pdf is available for preview at C:/Users/syntel/Music/
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
    <% } %> <!-- end of if -->

    <!--confirmation that a class was successfully created on the previous page, createclass.htm-->
    <div id="classSuccessAlert" class="alert alert-success alert-dismissible fade text-center d-none" role="alert">
        Data was read successfully, your class has been created.
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
    </div>
  
    <div id="root"></div>
    <div id="root2"></div>
    <div id="root3"></div>
    <script type ="text/babel">    
    class HeadingLinks extends React.Component{
        render(){
            return(
                <div className="container-fluid">
                    <div className="container mt-2 pt-4 pb-3">
                        <nav aria-label="breadcrumb">
                            <ol className="breadcrumb" style={{background: "transparent"}}>
                                <li className="breadcrumb-item"><a href="#">Instructor</a></li>
                                <li className="breadcrumb-item active" aria-current="page">Email Hub</li>
                            </ol>
                        </nav>
                    </div>
                </div>
            );
        }
    };
    
    ReactDOM.render(<HeadingLinks />, document.getElementById("root"));
    
    class Tabs extends React.Component {
        render(){
            return (
                <div className="container-fluid">
                    <div className="container">
                        <ul className="nav nav-tabs">
                            <li className="nav-item">
                                <a className="nav-link" href="createclass.htm">Create Class</a>
                            </li>
                            <li className="nav-item">
                                <a className="nav-link active" href="email.htm">Email Hub</a>
                            </li>
                            <li className="nav-item">
                                <a className="nav-link" href="showEmployees.htm">Employees</a>
                            </li>
                        </ul>
                    </div>
                </div>
            );
        }
    };
    
    ReactDOM.render(<Tabs />, document.getElementById("root2"));
 
 
 
    $.ajaxSetup({
        async: false
    });

    function GetEmployees() {
        var jsonData;
        $.getJSON("http://localhost:8084/WebAPI/getAllEmployees", function(data) {
            jsonData = data;
        });
        var searchBy = 0;
        var searchByString = '${param.searchName}';
        if('${param.searchEmail}' !== ""){
            searchBy = 2;
            searchByString = '${param.searchEmail}';
        }
        
        
        var empName = [];
        jsonData.forEach(function(emp){
            empName.push(Object.values(emp)[searchBy]);
        }); 
        
        var searchedJsonData = [];
        var counter = 0;
        jsonData.forEach(function(emp){
            if(Object.values(emp)[searchBy].includes(searchByString)){
                searchedJsonData[counter] = emp;
                counter++;
            }
        });
        searchedJsonData = JSON.parse(JSON.stringify(searchedJsonData));
        const searchedName = empName.filter(e => e.includes(searchByString));
        
        var count = 1;
        const tablebody = searchedJsonData.map((emp) =>
            <tr key={emp.employeeId} value={count++}>
                    <td className="noto">{emp.name}</td>
                    <td className="noto">{emp.email}</td>
                    <td className="noto"><a href={"pdf-preview.htm?empID=" + emp.employeeId}>
                                            <i className="fas fa-file-pdf px-2"></i>
                                         </a></td>
                    <td className="text-center noto"><input className="cb" type="checkbox" name="emailChecked" value={emp.email} /></td>
            </tr>
        );
        return(
            <tbody>
                {tablebody}
            </tbody>
        );
    }
 
    class Contents extends React.Component {
        constructor(){
            super();
            this.selectAll = this.selectAll.bind(this);
            this.search = this.search.bind(this);
        }
        
        selectAll(event){
            var form = document.forms[1];
           var checkboxTotal = 0;
           for(var i = 0; i<form.length; ++i){
               if(form[i].type == 'checkbox')
                   ++checkboxTotal;
           }
           
           var countChecked = 0;
           for (var i = 0; i < checkboxTotal; ++i) {
                if (form[i].type == 'checkbox') {
                    if(form[i].checked == true)
                        countChecked++;
                }
           }
           checkboxTotal -= 1;
           
           if(countChecked == checkboxTotal){
                for (var i = 1; i <= checkboxTotal; ++i) {
                    if (form[i].type == 'checkbox') {
                        form[i].checked = false;
                    }
                }
           }else{
                for (var i = 1; i <= checkboxTotal; ++i) {
                    if (form[i].type == 'checkbox') {
                        form[i].checked = true;
                    }
                }
                
           }
        }
        
        search(event){
            var searcher = $("#sear").val();
            var searchBy = $("#searchby :selected").text();
            window.location.href = "email.htm?search"+searchBy+"="+searcher;
        }
        
        render(){
            return(
                   <div className="container-fluid bg-whiteds" style={{height: "100vh"}}>
                    <div className="container pb-5 pt-3">
                        <form:form className="form-inline pt-1 pb-2 w-100">                 
                            <button className="btn btn-primary rounded-0 px-3 mr-2 my-1" onClick={this.search} type="button"><i className="fas fa-search pr-1"></i>Search</button>
                            <select id="searchby" name="col" className="custom-select my-1 mr-sm-2">
                                <option value="name">Name</option>
                                <option value="email">Email</option>
                            </select>
                            <input type="text" placeholder="Search.." id="sear" name="search" className="form-control my-1 mr-sm-2" />
                        </form:form>

                        <form:form id="emailForm" method="post" action="sendEmail.htm" className="mt-2"> 
                        <table className="table table-bordered table-striped table-sm">
                            <thead>
                                <tr>
                                    <th scope="col" style={{width: "35%"}}>Name</th>
                                    <th scope="col" style={{width: "35%"}}>Email</th>
                                    <th scope="col" style={{width: "10%"}} className="text-center">PDF</th>
                                    <th scope="col" style={{width: "20%"}} className="text-center">Send    <input type="checkbox" onClick={this.selectAll}/></th> 
                                </tr>
                            </thead>
                                <GetEmployees />
                        </table>
                        <div className="row justify-content-center my-5">
                          <button type="submit" value="Login" className="btn btn-primary px-3 mx-1 rounded-0"><i className="fas fa-paper-plane pr-2"></i>Send</button>
                        </div>
                        </form:form>
                    </div>
                </div> 
                    );
        }
    };
        ReactDOM.render(<Contents />, document.getElementById("root3"));
    </script>
    <!-- Custom JavaScript -->
    <script src="<c:url value="/resources/js/confirmation.js" />"></script>
    
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.4.0.min.js" crossorigin="anonymous"></script>
    <!-- Popper.js -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <!-- Bootstrap.js -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
</BODY>
</HTML>
