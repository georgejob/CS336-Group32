<%-- 
    Document   : modifyUserInfo
    Created on : Nov 30, 2019, 12:31:15 PM
    Author     : Brian
--%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%
    //Get the username, password, and name submitted in the form
    String actionType = request.getParameter("action");   
    String userid = request.getParameter("username");   
    String pwd = request.getParameter("password");
    String fullname = request.getParameter("fullname");
    String sec_level = request.getParameter("security_level");
    //Make sure the JDBC driver is properly loaded
    Class.forName("com.mysql.jdbc.Driver");
    //Connect to the database
    Connection con = DriverManager.getConnection("jdbc:mysql://cs336-group32.cbuttaegl5pc.us-east-1.rds.amazonaws.com:3306/FlightSystem","admin", "adminadmin");
    Statement st = con.createStatement();
    ResultSet rs;
    if(actionType.equals("update")){
        //Make sure that username is not already taken
        rs = st.executeQuery("select * from Person where username='" + userid + "'");
        if (rs.next()) {
            st.executeUpdate("UPDATE Person SET "
            + "password='" + pwd + "', "
            + "name='" + fullname + "'"
            + ((sec_level == null) ? "" : ", security_level='" + sec_level + "' ")        
            + "WHERE username='" + userid + "';");
            response.sendRedirect("userEdit.jsp?username="+userid+"&success=true");
        } else {
            out.println("Error: " + userid + " does not exist!");
            out.println("<a href='home.jsp'>Return to Home</a>");
        }
    } else if(actionType.equals("create")){
        if(sec_level == null || sec_level.equals("cust")){
            st.executeUpdate("INSERT INTO Person VALUES ('" + userid + "', '" + pwd + "','"+ fullname +"','cust');");
            st.executeUpdate("INSERT INTO Customer VALUES ('" + userid + "');");
        }else
            st.executeUpdate("INSERT INTO Person VALUES ('" + userid + "', '" + pwd + "','"+ fullname +"','rep');");
        response.sendRedirect("userEdit.jsp?username="+userid+"&success=true");
    } else if(actionType.equals("delete")){
        rs = st.executeQuery("select * from Customer where username='" + userid + "'");
        if(rs.next())
            st.executeUpdate("DELETE FROM Customer WHERE username='" + userid + "';");
        st.executeUpdate("DELETE FROM Person WHERE username='" + userid + "';");
        response.sendRedirect("userEdit.jsp?username="+userid+"&success=true");
    }
    
    
%>
