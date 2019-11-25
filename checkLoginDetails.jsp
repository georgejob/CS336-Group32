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
    String userid = request.getParameter("username");   
    String pwd = request.getParameter("password");
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://cs336-group32.cbuttaegl5pc.us-east-1.rds.amazonaws.com:3306/FlightSystem","admin", "adminadmin");
    Statement st = con.createStatement();
    ResultSet rs;
    rs = st.executeQuery("select * from Person where username='" + userid + "' and password='" + pwd + "'");
    if (rs.next()) {
        session.setAttribute("user", userid); // the username will be stored in the session
        out.println("welcome " + userid);
        out.println("<a href='logout.jsp'>Log out</a>");
        response.sendRedirect("success.jsp");
    } else {
        out.println("Invalid password <a href='index.jsp'>try again</a>");
    }
%>