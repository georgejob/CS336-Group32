<%-- 
    Document   : modifyAircraftInfo
    Created on : Dec 4, 2019, 3:59:31 PM
    Author     : Brian
--%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%
    //Get the required information submitted in the form
    String actionType = request.getParameter("action");   
    String craftid = request.getParameter("craftid");   
    String lineid = request.getParameter("lineid");
    int firstSeats = Integer.parseInt(request.getParameter("firstseats"));
    int econSeats = Integer.parseInt(request.getParameter("econseats"));
    //Make sure the JDBC driver is properly loaded
    Class.forName("com.mysql.jdbc.Driver");
    //Connect to the database
    Connection con = DriverManager.getConnection("jdbc:mysql://cs336-group32.cbuttaegl5pc.us-east-1.rds.amazonaws.com:3306/FlightSystem","admin", "adminadmin");
    Statement st = con.createStatement();
    ResultSet rs;
    if(actionType.equals("update")){
        //Make sure that the aircraft exists
        rs = st.executeQuery("select * from Aircraft where cid='" + craftid + "'");
        if (rs.next()) {
            rs = st.executeQuery("select * from Airlines where lid='" + lineid + "'");
            if(rs.next()){
                st.executeUpdate("UPDATE Aircraft SET "
                + "lid='" + lineid + "'"   
                + "WHERE cid='" + craftid + "';");
                response.sendRedirect("aircraftEdit.jsp?craftid="+craftid+"&success=true");
            }else{
                out.println("Error: Airline " + lineid + " does not exist!");
                out.println("<a href='home.jsp'>Return to Home</a>");
            }
        } else {
            out.println("Error: Aircraft Number" + craftid + " does not exist!");
            out.println("<a href='home.jsp'>Return to Home</a>");
        }
    } else if(actionType.equals("create")){
        //Make sure that this flight hasn't already been created
        rs = st.executeQuery("select * from Airlines where lid='" + lineid + "'");
        if(rs.next()){
            st.executeUpdate("INSERT INTO Aircraft VALUES ('" + craftid + "', '" + lineid + "');");
            //Add seats to the aircraft
            for(int i = 0; i < firstSeats + econSeats; i++){
                st.executeUpdate("INSERT INTO Seats VALUES ('" + i + "', '" + craftid + "', '" + ((i < firstSeats) ? "first" : "economy") + "');");
            }
            response.sendRedirect("aircraftEdit.jsp?craftid="+craftid+"&success=true");
        }else{
            out.println("Error: Airline " + lineid + " does not exist!");
            out.println("<a href='home.jsp'>Return to Home</a>");
        }
    } else if(actionType.equals("delete")){
        st.executeUpdate("DELETE FROM Aircraft WHERE cid='" + craftid + "';");
        response.sendRedirect("aircraftEdit.jsp?craftid="+craftid+"&success=true");
    }
    
    
%>