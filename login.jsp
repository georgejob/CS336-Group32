<%-- 
    Document   : index
    Created on : Nov 17, 2019, 4:15:04 PM
    Author     : Brian
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
   <head>
      <title>Login</title>
   </head>
   <body>
       <h1>Login:</h1>
     <form action="checkLoginDetails.jsp" method="POST">
       Username: <input type="text" name="username"/> <br/>
       Password:<input type="password" name="password"/> <br/>
       <input type="submit" value="Submit"/>
     </form>
       <p>Don't have an account? <a href="createAccount.jsp">Create An Account</a></p>
   </body>
</html>