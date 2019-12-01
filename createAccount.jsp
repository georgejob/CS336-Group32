<%-- 
    Document   : createAccount
    Created on : Nov 17, 2019, 11:14:45 PM
    Author     : Brian
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
   <head>
      <title>Create Account</title>
   </head>
   <body>
       <h1>Create an Account:</h1>
     <form action="addAccount.jsp" method="POST">
       Name: <input type="text" name="fullname"/> <br/>
       Username: <input type="text" name="username"/> <br/>
       Password:<input type="password" name="password"/> <br/>
       <input type="submit" value="Submit"/>
     </form>
       <p>Already have an account? <a href="home.jsp">Login</a></p>
   </body>
</html>
