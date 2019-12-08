<%-- 
    Document   : modifyAirportInfo
    Created on : Dec 5, 2019, 2:41:54 PM
    Author     : Brian
--%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%
    //Get the required information submitted in the form
    String actionType = request.getParameter("action");   
    String airportid = request.getParameter("portid");   
    //Make sure the JDBC driver is properly loaded
    Class.forName("com.mysql.jdbc.Driver");
    //Connect to the database
    Connection con = DriverManager.getConnection("jdbc:mysql://cs336-group32.cbuttaegl5pc.us-east-1.rds.amazonaws.com:3306/FlightSystem","admin", "adminadmin");
    Statement st = con.createStatement();
    ResultSet rs;
    if(actionType.equals("create")){
        rs = st.executeQuery("select * from Airports where pid='" + airportid + "'");
        if(rs.next()){
            out.println("Error: Airports " + airportid + " already exists!");
            out.println("<a href='home.jsp'>Return to Home</a>");
        }else{
            st.executeUpdate("INSERT INTO Airports VALUES ('" + airportid + "');");
            response.sendRedirect("airportEdit.jsp?portid="+airportid+"&success=true");
        }
    } else if(actionType.equals("delete")){
        st.executeUpdate("DELETE FROM Airports WHERE pid='" + airportid + "';");
        response.sendRedirect("airportEdit.jsp?portid="+airportid+"&success=true");
    }
    
    
%>