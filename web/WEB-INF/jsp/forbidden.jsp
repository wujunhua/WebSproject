<%-- 
    Document   : forbidden
    Created on : Apr 21, 2019, 6:06:50 PM
    Author     : syntel
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <jsp:include page="head-tag.jsp"/>
    <body class="bg-light">
        <div class="container mt-5">
            <div class="row mt-5 mx-5">
                <i class="fas fa-lock mt-5 mx-5" style="font-size: 5.0em;"></i>
            </div>
            <div class="row mx-5 mt-3">
                <h3 class="mx-5 mt-2"><b>Error:</b> You are attempting to access an admin page without admin privileges.</h3>
            </div>
        </div>
    </body>
</html>
