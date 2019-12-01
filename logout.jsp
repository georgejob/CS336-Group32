<%-- 
    Document   : logout
    Created on : Nov 17, 2019, 5:30:21 PM
    Author     : Brian
--%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%
session.invalidate();
response.sendRedirect("home.jsp");
 
%>
