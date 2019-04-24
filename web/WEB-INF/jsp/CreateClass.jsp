<%@page import="POJO.Stream"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="s"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!--database access-->
<%
    session.setAttribute("username", request.getAttribute("username"));
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

    String sql = "SELECT * FROM stream";
    Statement stmt = conn.createStatement();
    ResultSet rs = stmt.executeQuery(sql);

    ArrayList<String> streamIDs = new ArrayList();
    request.setAttribute("streamIDs", streamIDs);

    ArrayList<String> streamNames = new ArrayList();
    request.setAttribute("streamNames", streamNames);

    ArrayList<Stream> allStreams = new ArrayList<Stream>();
    while (rs.next()) {
        allStreams.add(new Stream(rs));
    }
    request.setAttribute("allStreams", allStreams);

    // fill in names and IDs, two separate arrays
//    while(rs.next()) {
//        streamIDs.add(rs.getString("stream_id"));
//        streamNames.add(rs.getString("stream_name"));
//    }
    rs.close(); // close resources
    stmt.close();
    conn.commit();
    conn.close();
%>


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

        <div class="container-fluid">
            <div class="container mt-2 pt-4 pb-3">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb" style="background: transparent;">
                        <li class="breadcrumb-item"><a href="#">Instructor</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Create Class</li>
                    </ol>
                </nav>
            </div>
        </div>

        <!-- Tabs -->
        <div class="container-fluid">
            <div class="container">
                <ul class="nav nav-tabs">
                    <li class="nav-item">
                        <a class="nav-link active" href="createclass.htm">Create Class</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="email.htm">Email Hub</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="showEmployees.htm">Employees</a>
                    </li>
                </ul>
            </div>
        </div>
        <!-- End Tabs -->

        <div class="container-fluid bg-white" style="height: 100vh;">
            <div class="container pb-5 pt-4">
                <div class="row mx-1">
                    <div class="col-sm-8 px-3 py-3"> 
                        <s:form commandName="excel" id="createClassForm" enctype="multipart/form-data" method="POST">
                            <div class="form-group row">
                                <div class="col-sm-2">
                            <label class="my-1 mr-2" for="selectedStream">Stream</label>
                                </div>
                                <div class="col-sm-10">
                            <select id="selectedStream" name="streamName" class="custom-select">
                                <c:forEach items="${allStreams}" var="stream">
                                    <option value="${stream.ID}"> 
                                        ${stream.name}
                                    </option>
                                </c:forEach>
                            </select>    
                                </div>
                            </div>
                       
                            <div class="form-group row">
                                <div class="col-sm-2 my-1">
                               <label class="my-1 mr-2" for="location">City/Country</label>
                                </div>
                                <div class="col-sm-6 my-1">
                               <input type="text" id="location" name="location" class="form-control" pattern="[a-zA-Z][a-zA-Z]{2,50}" title="Location must contain only letters and be atleast 3 characters." required/>
                                </div>
                                <div class="col-sm-4 mt-2 mb-1">
                                    <div class="custom-control custom-radio custom-control-inline">
                                        <input type="radio" class="custom-control-input" id="onSite" name="site" value="Onsite" checked>
                                        <label class="custom-control-label" for="onSite"><small>Onsite</small></label>
                                    </div>
                                    <div class="custom-control custom-radio custom-control-inline">
                                        <input type="radio" class="custom-control-input" id="offSite" name="site" value="Offshore">
                                        <label class="custom-control-label" for="offSite"><small>Offshore</small></label>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group row">
                                <div class="col-sm-2 my-1">
                                    <label class="my-1 mr-2" for="location">Instructor Email</label>
                                </div>
                                <div class="col-sm-10 my-1">
                                    <input type="email" name="insEmail" id="insEmail" class="form-control" pattern="[a-zA-Z][a-zA-Z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$" title="Must be a valid atos or syntel email" required/>
                                </div>
                                <font color="red"><span id="emailValidation"></span></font>
                            </div>
                            
                            <div class="form-group row">
                                <div class="col-sm-2 my-1">
                                    <label class="my-1 mr-2" for="location">Start Date</label>
                                </div>
                                <div class="col-sm-4 my-1">
                                    <input type="date" name="startDate" id="startDate" class="form-control" required/>
                                </div>
                                
                                <div class="col-sm-2 my-1">
                                    <label class="my-1 mr-2" for="location">End Date</label>
                                </div>
                                <div class="col-sm-4 my-1">
                                    <input type="date" name="endDate" id="endDate" class="form-control" required/>
                                </div>
                                <font color="red"><span id="endDateValidation"></span></font>
                            </div>

                            <div class="form-group row">
                                <div class="col-sm-2 my-1 pt-2">
                                    <label for="exampleFormControlFile1">File Select</label>
                                </div>
                                <div class="col-sm-10 my-1 btn-light py-2 pl-3">
                                    <input type="file" accept=".csv, application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, application/vnd.ms-excel" ID="file" name="file" runat="server" title="Uploaded file must be an excel" required/>
                                </div>
                            </div>
                            <div class="row justify-content-center">
                                <button type="button" class="btn btn-primary rounded-0 px-3" onclick="validate()" ><i class="far fa-file-alt pr-2"></i>Submit</button>
                            </div>
                             <div class="row justify-content-center">
                                <button type="submit" id="actualButton" class="btn btn-primary rounded-0 px-3" style="display: none;" ><i class="far fa-file-alt pr-2"></i>Submit</button>
                            </div>
                        </s:form>                       
                    </div><!-- End col 8 -->
                    <div class="col-sm-4 mt-2">
                        <div class='card'>
                        <div class='card-header bg-light'>
                            Template
                        </div>
                       
                            <ul class='list-group'>
                                <c:forEach items="${allStreams}" var="stream"> 
                                    <li class='list-group-item'><a href="download.htm?streamID=${stream.ID}">${stream.name}</a></li>
                                </c:forEach>
                            </ul>
                       
                        </div>
                    </div>
                </div><!-- End row --> 
            </div><!-- End container --> 
        </div><!-- End fluid container -->



        <!-- Optional JavaScript -->

        <!-- jQuery -->
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <!-- Popper.js -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <!-- Bootstrap.js -->
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

        
        <script src="<c:url value="/resources/js/classValidate.js" />"></script>
        
        
    </body>


