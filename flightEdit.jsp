<%-- 
    Document   : flightEdit
    Created on : Dec 5, 2019, 2:52:48 PM
    Author     : Brian
--%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Flight Information</title>
    </head>
    <body>
        <h1>Edit Flight Information</h1>
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
        //Get the airline id and flight number submitted in the form
        String flightnum = request.getParameter("flightnum");
        String lineid = request.getParameter("lineid");
        //Was the user redirected here from a successful update?
        String strSuccess = request.getParameter("success");
        if(strSuccess != null && strSuccess.equals("true")){
        %>
        <p style="color:green;">Flight <b>#<%=flightnum%></b> for airline <b><%=lineid%></b> was updated successfully!</p>
        <%   
        }
%>
        <p>Choose a different Flight:</p>
        <form action="flightEdit.jsp" method="POST">
            Flight Airline: <input type="text" name="lineid" maxlength="2"/>
            Flight Number: <input type="number" name="flightnum"/>
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
        rs = st.executeQuery("select * from Flights where lid='" + lineid + "' AND number='" + flightnum + "';");
        if (rs.next()) {
%>
        <form action="modifyFlightInfo.jsp" method="POST">
            <p style="font-size: 18pt">Edit information for Flight <b>#<%=flightnum%></b> for <b><%=lineid%></b> Airline</p><br/>
            <input type="hidden" name="action" value="update"/>
            <input type="hidden" name="lineid" value="<%=lineid%>"/>
            <input type="hidden" name="flightnum" value="<%=flightnum%>"/>
            Type: 
            <select name='ftype'>
                <option value='domestic' <%=(rs.getString("type").equals("domestic")) ? "selected='true'":""%>>Domestic</option>
                <option value='international' <%=(rs.getString("type").equals("international")) ? "selected='true'":""%>>International</option>
            </select><br/>
            Departure Time: <input type="time" name="depart_time" value="<%=rs.getString("depart_time")%>"/><br/>
            Arrival Time: <input type="time" name="arrive_time" value="<%=rs.getString("arrive_time")%>"/><br/>
            Economy Price: $<input type="number" name="fare_economy" value="<%=rs.getString("fare_economy")%>"/><br/>
            First-Class Price: $<input type="number" name="fare_first" value="<%=rs.getString("fare_first")%>"/><br/>
            Operated By Aircraft Number: <input type="number" name="craftid" value="<%=rs.getString("cid")%>"/><br/>
            Departure Airport: <input type="text" name="depart_port" value="<%=rs.getString("departure_pid")%>" maxlength="3"/><br/>
            Destination Airport: <input type="text" name="dest_port" value="<%=rs.getString("destination_pid")%>" maxlength="3"/><br/>
<%
            //Get all the days on which this flight operates
            rs = st.executeQuery("SELECT * FROM flies_on WHERE lid='" + lineid + "' AND number='" + flightnum + "';");
            //Load these days into an array
            boolean[] onDays = new boolean[7];
            for(int i = 0; i < onDays.length; i++){
                onDays[i] = false;
            }
            while(rs.next()){
                onDays[rs.getInt("day_number")] = true;
            }
%>
            Days of Operation:<br/>
            <div style="border:1px solid black;">
                <input type="checkbox" name="day_num" value="0" <%=(onDays[0]) ? "checked":""%>/>Sunday<br/>
                <input type="checkbox" name="day_num" value="1" <%=(onDays[1]) ? "checked":""%>/>Monday<br/>
                <input type="checkbox" name="day_num" value="2" <%=(onDays[2]) ? "checked":""%>/>Tuesday<br/>
                <input type="checkbox" name="day_num" value="3" <%=(onDays[3]) ? "checked":""%>/>Wednesday<br/>
                <input type="checkbox" name="day_num" value="4" <%=(onDays[4]) ? "checked":""%>/>Thursday<br/>
                <input type="checkbox" name="day_num" value="5" <%=(onDays[5]) ? "checked":""%>/>Friday<br/>
                <input type="checkbox" name="day_num" value="6" <%=(onDays[6]) ? "checked":""%>/>Saturday<br/>
            </div>
            <input type="submit" value="Submit"/>
        </form>
        <form action="modifyFlightInfo.jsp" method="POST">
            <input type="hidden" name="action" value="delete"/>
            <input type="hidden" name="lineid" value="<%=lineid%>"/>
            <input type="hidden" name="flightnum" value="<%=flightnum%>"/>
            <p style="color:red;">Delete all records for Flight <b>#<%=flightnum%></b> for <b><%=lineid%></b> Airline:</p>
            <input type="submit" value="Delete"/>
        </form>

<%
    } else {
%>
        <form action="modifyFlightInfo.jsp" method="POST">
            <p style="font-size: 18pt">Create a new flight</p>
            <input type="hidden" name="action" value="create"/>
            Flight Airline: <input type="text" name="lineid" maxlength="2"/><br/>
            Flight Number: <input type="number" name="flightnum"/><br/>
            Type: 
            <select name='ftype'>
                <option value='domestic'>Domestic</option>
                <option value='international'>International</option>
            </select><br/>
            Departure Time: <input type="time" name="depart_time"/><br/>
            Arrival Time: <input type="time" name="arrive_time"/><br/>
            Economy Price: $<input type="number" name="fare_economy"/><br/>
            First-Class Price: $<input type="number" name="fare_first"/><br/>
            Operated By Aircraft Number: <input type="number" name="craftid"/><br/>
            Departure Airport: <input type="text" name="depart_port" maxlength="3"/><br/>
            Destination Airport: <input type="text" name="dest_port" maxlength="3"/><br/>
            Days of Operation:<br/>
            <div style="border:1px solid black;">
                <input type="checkbox" name="day_num" value="0"/>Sunday<br/>
                <input type="checkbox" name="day_num" value="1"/>Monday<br/>
                <input type="checkbox" name="day_num" value="2"/>Tuesday<br/>
                <input type="checkbox" name="day_num" value="3"/>Wednesday<br/>
                <input type="checkbox" name="day_num" value="4"/>Thursday<br/>
                <input type="checkbox" name="day_num" value="5"/>Friday<br/>
                <input type="checkbox" name="day_num" value="6"/>Saturday<br/>
            </div>
            <input type="submit" value="Submit"/>
        </form>
<%
        }
    }
%>
        </div>
    </body>
</html>
