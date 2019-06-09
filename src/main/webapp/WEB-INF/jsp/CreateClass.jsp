
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="s"%> 

<!DOCTYPE html>

<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
    <!-- Navbar -->
    <jsp:include page="nav.jsp"/>
    <!-- End Navbar -->

    <div id="root"></div>
    <div id="root2"></div>
    <div id="root3"></div>
    <script type ="text/babel">
        class HeadingLinks extends React.Component  {
            render(){
                return (
                    <div>
                    <div className="container-fluid">
                    <div className="container mt-2 pt-4 pb-3">
                        <nav aria-label="breadcrumb">
                          <ol className="breadcrumb" style={{background:"transparent"}}>
                            <li className="breadcrumb-item"><a href="#">Instructor</a></li>
                            <li className="breadcrumb-item active" aria-current="page">Create Class</li>
                          </ol>
                        </nav>
                    </div>
                    </div>
                    </div>
                );
            }
  };
        ReactDOM.render(<HeadingLinks />, document.getElementById("root"));
    
        class Tabs extends React.Component{
            render(){
                return (
                        
                    <div className="container-fluid">
                      <div className="container">
                        <ul className="nav nav-tabs">
                          <li className="nav-item">
                            <a className="nav-link active" href="createclass.htm">Create Class</a>
                          </li>
                          <li className="nav-item">
                            <a className="nav-link" href="email.htm">Email Hub</a>
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
        
        function InsertOptionStreams() {
            var jsonData;
            $.getJSON("http://localhost:8084/WebAPI/getAllStreams", function(data) {
                jsonData = data;
            });
            const options = jsonData.map((stream) =>
                <option key={stream.streamId} value={stream.streamId}>{stream.streamName}</option>
            );
            return(
                <select id="selectedStream" name="streamName" className="custom-select">
                    {options}
                </select>
            );
        }
        
        function InsertULStreams() {
            var jsonData;
            $.getJSON("http://localhost:8084/WebAPI/getAllStreams", function(data) {
                jsonData = data;
            });
            const options = jsonData.map((stream) =>
                <li key={stream.streamId} value={stream.streamId} className="list-group-item"><a href="download.htm?streamID={stream.streamId}">{stream.streamName}</a></li>
            );
            return(
                <ul className="list-group">
                    {options}
                </ul>
            );
        }
        
        class Contents extends React.Component{        
            render(){
                return (
                <div className="container-fluid bg-white" style={{height: "100vh"}}>
                    <div className="container pb-5 pt-4">
                        <div className="row mx-1">
                            <div className="col-sm-8 px-3 py-3"> 
                            <s:form commandname="excel" id="createClassForm" encType="multipart/form-data" method="POST">
                                <div className="form-group row">
                                    <div className="col-sm-2">
                                        <label className="my-1 mr-2" htmlFor="selectedStream">Stream</label>
                                    </div>
                                    <div className="col-sm-10">
                                        <InsertOptionStreams />
                                    </div>
                                </div>
                                    <div className="form-group row">
                                        <div className="col-sm-2 my-1">
                                            <label className="my-1 mr-2" htmlFor="location">City/Country</label>
                                        </div>
                                        <div className="col-sm-6 my-1">
                                            <input type="text" id="location" name="location" className="form-control" pattern="[a-zA-Z][a-zA-Z]{2,50}" title="Location must contain only letters and be atleast 3 characters." required />
                                        </div>
                                        <div className="col-sm-4 mt-2 mb-1">
                                        <div className="custom-control custom-radio custom-control-inline">
                                          <input type="radio" className="custom-control-input" id="onSite" name="site" defaultValue="Onsite" defaultChecked />
                                          <label className="custom-control-label" htmlFor="onSite"><small>Onsite</small></label>
                                        </div>
                                        <div className="custom-control custom-radio custom-control-inline">
                                          <input type="radio" className="custom-control-input" id="offSite" name="site" defaultValue="Offshore" />
                                          <label className="custom-control-label" htmlFor="offSite"><small>Offshore</small></label>
                                        </div>
                                    </div>
                                </div>
                                <div className="form-group row">
                                  <div className="col-sm-2 my-1">
                                    <label className="my-1 mr-2" htmlFor="location">Instructor Email</label>
                                  </div>
                                  <div className="col-sm-10 my-1">
                                    <input type="email" name="insEmail" id="insEmail" className="form-control" pattern="[a-zA-Z][a-zA-Z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$" title="Must be a valid atos or syntel email" required />
                                  </div>
                                  <font color="red"><span id="emailValidation" /></font>
                                </div>
                                <div className="form-group row">
                                  <div className="col-sm-2 my-1">
                                    <label className="my-1 mr-2" htmlFor="location">Start Date</label>
                                  </div>
                                  <div className="col-sm-4 my-1">
                                    <input type="date" name="startDate" id="startDate" className="form-control" required />
                                  </div>
                                  <div className="col-sm-2 my-1">
                                    <label className="my-1 mr-2" htmlFor="location">End Date</label>
                                  </div>
                                  <div className="col-sm-4 my-1">
                                    <input type="date" name="endDate" id="endDate" className="form-control" required />
                                  </div>
                                  <font color="red"><span id="endDateValidation" /></font>
                                </div>
                                <div className="form-group row">
                                  <div className="col-sm-2 my-1 pt-2">
                                    <label htmlFor="exampleFormControlFile1">File Select</label>
                                  </div>
                                  <div className="col-sm-10 my-1 btn-light py-2 pl-3">
                                    <input type="file" accept=".csv, application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, application/vnd.ms-excel" id="file" name="file" runat="server" title="Uploaded file must be an excel" required />
                                  </div>
                                </div>
                                <div className="row justify-content-center">
                                  <button type="button" className="btn btn-primary rounded-0 px-3" onclick="validate()"><i className="far fa-file-alt pr-2" />Submit</button>
                                </div>
                                <div className="row justify-content-center">
                                  <button type="submit" id="actualButton" className="btn btn-primary rounded-0 px-3" style={{display:"none"}}><i className="far fa-file-alt pr-2" />Submit</button>
                                </div>
                            </s:form>
                            </div>
                            <div className="col-sm-4 mt-2">
                              <div className="card">
                                <div className="card-header bg-light">
                                  Template
                                </div>
                                    <InsertULStreams />
                              </div>
                            </div>
                        </div>
                    </div>
                </div>
                );
            }
        };
        ReactDOM.render(<Contents />, document.getElementById("root3"));
    </script>    
    
    <!-- Optional JavaScript -->

    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.3.1.min.js" crossorigin="anonymous"></script>
    <!-- Popper.js -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <!-- Bootstrap.js -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>


    <script src="<c:url value="/resources/js/classValidate.js" />"></script>


</body>
