<%-- 
    Document   : userEdit
    Created on : Nov 30, 2019, 11:42:04 AM
    Author     : Brian
--%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit User Information</title>
    </head>
    <body>
        <h1>Edit User Information</h1>
<%
    if(session.getAttribute("user") == null){
%>        
        You are not logged in<br/>
        <a href="login.jsp">Please Login</a>
<%
    }else if(!session.getAttribute("security_level").equals("admin")){
%>        
            You do not have permission to view this page.
            <br/>
            <a href="home.jsp">Return to Home</a>
                    
<%
    }else{
        //Get the username submitted in the form
        String userid = request.getParameter("username");
        //Was the user redirected here from a successful update?
        String strSuccess = request.getParameter("success");
        if(strSuccess != null && strSuccess.equals("true")){
        %>
        <p style="color:green;">User <b><%=userid%></b> was updated successfully!</p>
        <%   
        }
%>
        <p>Choose a different user:</p>
        <form action="userEdit.jsp" method="POST">
            Username: <input type="text" name="username"/> <br/>
            <input type="submit" value="Submit"/>
        </form>
        <div>
<%
        //Make sure the JDBC driver is properly loaded
        Class.forName("com.mysql.jdbc.Driver");
        //Connect to the database
        Connection con = DriverManager.getConnection("jdbc:mysql://cs336-group32.cbuttaegl5pc.us-east-1.rds.amazonaws.com:3306/FlightSystem","admin", "adminadmin");
        Statement st = con.createStatement();
        ResultSet rs;
        //Get the user if the supplied username and password exist in the database
        rs = st.executeQuery("select * from Person where username='" + userid + "'");
        if (rs.next()) {
            if(rs.getString("security_level").equals("admin")){
%>
                You do not have permission to edit information on other admins!
<%
            }else{
%>

        <form action="modifyUserInfo.jsp" method="POST">
            <p style="font-size: 18pt">Edit information for <b><%=rs.getString("username")%></b></p><br/>
            <input type="hidden" name="action" value="update"/>
            <input type="hidden" name="username" value="<%=rs.getString("username")%>"/>
            Name: <input type="text" name="fullname" value="<%=rs.getString("name")%>"/> <br/>
            Password: <input type="text" name="password" value="<%=rs.getString("password")%>"/> <br/>
            <%
                if(session.getAttribute("security_level").equals("admin")){
            %>
            Security Level: 
            <select name="security_level">
                <option value='cust' <%=(rs.getString("security_level").equals("cust")) ? "selected='true'":""%>>Customer</option>
                <option value='rep' <%=(rs.getString("security_level").equals("rep")) ? "selected='true'":""%>>Customer Representative</option>
            </select>
            <%
                }
            %>
            <input type="submit" value="Submit"/>
        </form>
        <form action="modifyUserInfo.jsp" method="POST">
            <input type="hidden" name="action" value="delete"/>
            <input type="hidden" name="username" value="<%=rs.getString("username")%>"/>
            <p style="color:red;">Delete all records for <b><%=userid%></b>:</p>
            <input type="submit" value="Delete"/>
        </form>

<%
        }
    } else {
%>
        <form action="modifyUserInfo.jsp" method="POST">
            <p style="font-size: 18pt">Create a new user</p>
            <input type="hidden" name="action" value="create"/>
            Username: <input type="text" name="username"/> <br/>
            Name: <input type="text" name="fullname"> <br/>
            Password: <input type="text" name="password"/> <br/>
            <%
                if(session.getAttribute("security_level").equals("admin")){
            %>
            Security Level: 
            <select name="security_level">
                <option value='cust' selected="true">Customer</option>
                <option value='rep'>Customer Representative</option>
            </select>
            <%
                }
            %>
            <input type="submit" value="Submit"/>
        </form>
<%
        }
    }
%>
        </div>
    </body>
</html>