<%-- 
    Document   : airportEdit
    Created on : Dec 5, 2019, 2:35:43 PM
    Author     : Brian
--%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Airport Information</title>
    </head>
    <body>
        <h1>Edit Airport Information</h1>
<%
    if(session.getAttribute("user") == null){
%>        
        You are not logged in<br/>
        <a href="login.jsp">Please Login</a>
<%
    }else if(!session.getAttribute("security_level").equals("rep")){
%>        
            You do not have permission to view this page.
            <br/>
            <a href="home.jsp">Return to Home</a>
                    
<%
    }else{
        //Get the airport id submitted in the form
        String airportid = request.getParameter("portid");
        //Was the user redirected here from a successful update?
        String strSuccess = request.getParameter("success");
        if(strSuccess != null && strSuccess.equals("true")){
        %>
        <p style="color:green;">Airport <b><%=airportid%></b> was updated successfully!</p>
        <%   
        }
%>
        <a href='logout.jsp'>Log out</a> -- <a href='home.jsp'>Return to Home</a>
        <p>Choose a different Airport:</p>
        <form action="airportEdit.jsp" method="POST">
            Airport ID: <input type="text" name="portid" maxlength="3"/>
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
        rs = st.executeQuery("select * from Airports where pid='" + airportid + "'");
        if (rs.next()) {
%>
        <p style="font-size: 18pt">Edit information for <b><%=rs.getString("pid")%></b></p><br/>
        <form action="modifyAirportInfo.jsp" method="POST">
            <input type="hidden" name="action" value="delete"/>
            <input type="hidden" name="portid" value="<%=rs.getString("pid")%>"/>
            <p style="color:red;">Delete all records for Aircraft Number <b><%=airportid%></b>:</p>
            <input type="submit" value="Delete"/>
        </form>

<%
    } else {
%>
        <form action="modifyAirportInfo.jsp" method="POST">
            <p style="font-size: 18pt">Create a new airport</p>
            <input type="hidden" name="action" value="create"/>
            Airport ID: <input type="text" name="portid" value="<%=airportid%>" maxlength="3"/><br/>
            <input type="submit" value="Submit"/>
        </form>
<%
        }
    }
%>
        </div>
    </body>
</html>
