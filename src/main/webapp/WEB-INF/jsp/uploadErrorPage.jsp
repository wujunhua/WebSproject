<%-- 
    Document   : emailRedirect
    Created on : Apr 21, 2019, 9:47:29 PM
    Author     : syntel
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<script type="text/javascript">
    function alert_this(){
        alert("Error in File upload");
        window.location.href="createclass.htm";
    }
</script>
<script type="text/javascript"> window.onload = alert_this; </script>
