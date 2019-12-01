<%-- 
    Document   : admin
    Created on : Nov 26, 2019, 1:42:14 PM
    Author     : Brian
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Control Panel</title>
    </head>
    <body>
        <%
            if ((session.getAttribute("user") == null)) {
        %>
            You are not logged in<br/>
            <a href="login.jsp">Please Login</a>
        <%
          } else if (!(session.getAttribute("security_level").equals("admin"))) {
        %>
            You do not have permission to view this page.
            <br/>
            <a href="home.jsp">Return to Home</a>
        <%} else {
        %>
            <h1>Admin Control Panel</h1>
            Welcome <%=session.getAttribute("user")%>! 
            <a href='logout.jsp'>Log out</a>
            <div>
                <p>Edit Customer Information</p>
                <form action="userEdit.jsp" method="POST">
                    Username: <input type="text" name="username"/> <br/>
                    <input type="submit" value="Submit"/>
                </form>
            </div>
        <%
            }
        %>
    </body>
</html>
