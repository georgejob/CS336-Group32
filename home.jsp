<%-- 
    Document   : home
    Created on : Nov 25, 2019, 4:38:01 PM
    Author     : Brian
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Group32 Home</title>
    </head>
    <body>
        <h1>Welcome to Group32's Final Project</h1>
        <%
            if ((session.getAttribute("user") == null)) {
        %>
            You are not logged in<br/>
            <a href="login.jsp">Please Login</a>
        <%} else {
        %>
            Welcome <%=session.getAttribute("user")%>! 
            <a href='logout.jsp'>Log out</a><br/>
            <p>What would you like to do?</p>
            <ul>
        <%
            if (session.getAttribute("security_level").equals("admin")){
        %>
                <li><a href="admin.jsp">Admin Control Panel</a></li>
        <%
            }else if(session.getAttribute("security_level").equals("rep")){
        %>
                <li><a href="rep.jsp">Customer Representative Control Panel</a></li>
        <%
            }
        %>
                <li>View Profile Information</li>
                <li>View Reservations</li>
                <li>Search Flights</li>
            </ul>
        <%
            }
        %>
    </body>
</html>
