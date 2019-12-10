<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Search Flights</title>
    </head>
    <body>
        <%
            if ((session.getAttribute("user") == null)) {
        %>
            You are not logged in<br/>
            <a href="login.jsp">Please Login</a>
        <%} else {
        %>
            <h1>Search Flights</h1>
            Welcome <%=session.getAttribute("user")%>!
            <a href='logout.jsp'>Log out</a> -- <a href='home.jsp'>Return to Home</a>
            <div style="border: 2px solid black; padding-left:15px; margin-top:4px;">
                <select>
                <option value="oneway">One-Way</option>
                <option value="roundtrip">Round Trip</option>
                <option value="flexible">Flexible Date/Time</option>
                </select>
            </div>
        <%
            }
        %>
        
    </body>
</html>
