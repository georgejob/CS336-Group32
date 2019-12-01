<%-- 
    Document   : addAccount
    Created on : Nov 17, 2019, 11:16:11 PM
    Author     : Brian
--%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%
    //Get the username, password, and name submitted in the form
    String userid = request.getParameter("username");   
    String pwd = request.getParameter("password");
    String fullname = request.getParameter("fullname");
    //Make sure the JDBC driver is properly loaded
    Class.forName("com.mysql.jdbc.Driver");
    //Connect to the database
    Connection con = DriverManager.getConnection("jdbc:mysql://cs336-group32.cbuttaegl5pc.us-east-1.rds.amazonaws.com:3306/FlightSystem","admin", "adminadmin");
    Statement st = con.createStatement();
    ResultSet rs;
    //Make sure that username is not already taken
    rs = st.executeQuery("select * from Person where username='" + userid + "'");
    if (rs.next()) {
        out.println("That username is already taken: <a href='createAccount.jsp'>try again</a>");
    } else {
        //Add this user to the database
        st.executeUpdate("INSERT INTO Person VALUES ('" + userid + "', '" + pwd + "','"+ fullname +"','cust');");
        st.executeUpdate("INSERT INTO Customer VALUES ('" + userid + "');");
        
        //Store the user's username and security level in the session
        session.setAttribute("user", userid);
        session.setAttribute("security_level", "cust");
        out.println("Welcome " + userid + "!");
        out.println("Your account has been created successfully.");
        out.println("<a href='home.jsp'>Return to Home</a> -- <a href='logout.jsp'>Log out</a>");
    }
%>
