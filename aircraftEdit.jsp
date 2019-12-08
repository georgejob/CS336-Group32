<%-- 
    Document   : aircraftEdit
    Created on : Dec 4, 2019, 3:44:53 PM
    Author     : Brian
--%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Aircraft Information</title>
    </head>
    <body>
        <h1>Edit Aircraft Information</h1>
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
        //Get the aircraft id submitted in the form
        String aircraftid = request.getParameter("craftid");
        //Was the user redirected here from a successful update?
        String strSuccess = request.getParameter("success");
        if(strSuccess != null && strSuccess.equals("true")){
        %>
        <p style="color:green;">Aircraft Number <b><%=aircraftid%></b> was updated successfully!</p>
        <%   
        }
%>
        <p>Choose a different Aircraft:</p>
        <form action="aircraftEdit.jsp" method="POST">
            Aircraft Number: <input type="number" name="craftid"/>
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
        rs = st.executeQuery("select * from Aircraft where cid='" + aircraftid + "'");
        if (rs.next()) {
%>
        <form action="modifyAircraftInfo.jsp" method="POST">
            <p style="font-size: 18pt">Edit information for <b><%=rs.getString("cid")%></b></p><br/>
            <input type="hidden" name="action" value="update"/>
            <input type="hidden" name="craftid" value="<%=rs.getString("cid")%>"/>
            Owned By Airline: <input type="text" name="lineid" value="<%=rs.getString("lid")%>" maxlength="2"/> <br/>
            <input type="submit" value="Submit"/>
        </form>
        <form action="modifyAircraftInfo.jsp" method="POST">
            <input type="hidden" name="action" value="delete"/>
            <input type="hidden" name="craftid" value="<%=rs.getString("cid")%>"/>
            <p style="color:red;">Delete all records for Aircraft Number <b><%=aircraftid%></b>:</p>
            <input type="submit" value="Delete"/>
        </form>

<%
    } else {
%>
        <form action="modifyAircraftInfo.jsp" method="POST">
            <p style="font-size: 18pt">Create a new aircraft</p>
            <input type="hidden" name="action" value="create"/>
            Aircraft Number: <input type="number" name="craftid" value="<%=aircraftid%>"/><br/>
            Owned By Airline: <input type="text" name="lineid" maxlength="2"/> <br/>
            <input type="submit" value="Submit"/>
        </form>
<%
        }
    }
%>
        </div>
    </body>
</html>
