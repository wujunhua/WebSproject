<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib uri = "http://www.springframework.org/tags/form" prefix = "form"%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Employees</title>
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" 
            integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" 
            crossorigin="anonymous"></script>
    </head>
    
    <body>        
        <form:form method="post" action="/WebSproject/searchEmployees.htm">       
            <div class="search-container">
               <select name="col">
                  <option value="name">Name</option>
                  <option value="email">Email</option>
                  <option value="classID">Class ID</option>
               </select>
               <input type="text" placeholder="Search.." name="search">
               <button type="submit">Search</button>
            </div>
        </form:form>
        <table class="table table-striped table-bordered">
            <thead>
            <tr>
                <th>#</th>
                <th>Name</th>
                <th>Email</th>
                <th>Manager</th>
                <th>Action</th>
            </tr>
            </thead>
            <tbody>
                <c:set var="count" value="1"/>
                <c:forEach items = "${emplist}" var = "emp">
                    <tr>
                        <td>${count}</td>
                        <td>
                            ${emp.employeeName}
                        </td>
                        <td>${emp.employeeEmail}</td>
                        <td>${emp.managerID}</td>
                        <td>
                            <button id="editButton" type="button" class="btn btn-primary" data-toggle="modal"
                                    data-target="#editModal" data-id="${emp.employeeID}" data-name="${emp.employeeName}" 
                                    data-email="${emp.employeeEmail}" data-managerid="${emp.managerID}">Edit</button>
                            <button id="deleteButton" type="button" class="btn btn-danger" data-toggle="modal"
                                    data-target="#deleteModal" data-id="${emp.employeeID}">Delete</button>
                        </td>                        
                    </tr>
                    <c:set var="count" value="${count + 1}"/>
                </c:forEach>          
            </tbody>
        </table>
                
        <!-- Edit Employee Modal -->
        <div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="editModalLabel" aria-hidden="true">
           <div class="modal-dialog" role="document">
              <div class="modal-content">
                 <div class="modal-header">
                    <h5 class="modal-title" id="editModalLabel">Edit Employee</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                    </button>
                 </div>
                 <form:form method="post" action="/WebSproject/editEmployees.htm">
                    <div class="modal-body">
                        <div class="form-group">
                                <label for="editName">Employee Name: 
                                </label> <input type="text" id="editName" name="editName" class="form-control" pattern="[A-Za-z]+ [A-Za-z]+">
                        </div>
                        <div class="form-group">
                                <label for="editEmail">Employee Email: </label> 
                                <input type="text" id="editEmail" name="editEmail" class="form-control" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$">
                        </div>   
                        <div class="form-group">
                                <label for="editManagerID">Employee Manager ID: 
                                </label> <input type="text" id="editManagerID" name="editManagerID" class="form-control" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$">
                        </div>
                    </div>
                    <div class="modal-footer">
                       <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                       <button name="editModalButton" type="submit" id="editModalButton" class="btn btn-primary btn-primary">
                       Confirm Update
                       </button>
                    </div>
                 </form:form>
              </div>
           </div>
        </div>                
 
        <!-- Delete Employee Modal -->
        <div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="deleteModalLabel" aria-hidden="true">
           <div class="modal-dialog" role="document">
              <div class="modal-content">
                 <div class="modal-header">
                    <h5 class="modal-title" id="deleteModalLabel">Confirm Delete</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                    </button>
                 </div>
                 <div class="modal-body">
                    Are you sure you want to delete this employee?
                 </div>
                 <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <form:form method="post" action="/WebSproject/deleteEmployees.htm">
                       <button name="deleteModalButton" type="submit" id="deleteModalButton" class="btn btn-primary btn-danger">
                       Confirm Delete
                       </button>
                    </form:form>
                 </div>
              </div>
           </div>
        </div>
               
        <!-- Modal button listener -->
        <!-- Add data thru modal buttons -->
        <script type="text/javascript">
            $(document).ready(function(){
                $(document).on("click", "#deleteButton", function(){
                    $("#deleteModalButton").val($(this).data("id"));
                });
                $(document).on("click", "#editButton", function(){
                    $("#editModalButton").val($(this).data("id"));
                    $("#editName").val($(this).data("name"));
                    $("#editEmail").val($(this).data("email"));
                    $("#editManagerID").val($(this).data("managerid"));
                });
             });
        </script>
                
        <!-- jQuery -->
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <!-- Popper.js -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <!-- Bootstrap.js -->
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
        <!-- Bootstrap.css -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    </body>
</html>
