<%-- 
    Document   : checkLoginDetails
    Created on : Nov 17, 2019, 5:25:10 PM
    Author     : Brian
--%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%
    //Get the username and password submitted in the form
    String userid = request.getParameter("username");   
    String pwd = request.getParameter("password");
    //Make sure the JDBC driver is properly loaded
    Class.forName("com.mysql.jdbc.Driver");
    //Connect to the database
    Connection con = DriverManager.getConnection("jdbc:mysql://cs336-group32.cbuttaegl5pc.us-east-1.rds.amazonaws.com:3306/FlightSystem","admin", "adminadmin");
    Statement st = con.createStatement();
    ResultSet rs;
    //Get the user if the supplied username and password exist in the database
    rs = st.executeQuery("select * from Person where username='" + userid + "' and password='" + pwd + "'");
    if (rs.next()) {
        //Store the user's username and security level in the session
        session.setAttribute("user", userid); 
        String sec_level = rs.getString("security_level");
        session.setAttribute("security_level", sec_level);
        response.sendRedirect("home.jsp");
    } else {
        out.println("Invalid password <a href='login.jsp'>try again</a>");
    }
%>