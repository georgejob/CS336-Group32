<%-- 
    Document   : success
    Created on : Nov 17, 2019, 5:27:26 PM
    Author     : Brian
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home</title>
    </head>
    <body>
        <%
            if ((session.getAttribute("user") == null)) {
        %>
            You are not logged in<br/>
            <a href="login.jsp">Please Login</a>
        <%} else {
        %>
            Welcome <%=session.getAttribute("user")%>! 
            <a href='logout.jsp'>Log out</a>
        <%
            }
        %>
    </body>
</html>
