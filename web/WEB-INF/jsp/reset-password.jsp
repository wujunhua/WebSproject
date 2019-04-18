<%-- 
    Document   : reset-password
    Created on : Apr 17, 2019, 3:04:07 PM
    Author     : syntel
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="s"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Reset Password</title>
    </head>
    <body>
    <s:form commandName="forgotPass">
        Email:
        <input type="email" name="email" required>
        <button type="submit">Reset</button>
    </s:form>
    </body>
</html>
