<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%
 
response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires",300);
    int timeout = session.getMaxInactiveInterval();
    response.setHeader("Reload", timeout + "; URL = ../user.jsp");%>

<%String nme=(String) session.getAttribute("user_email");
    if (nme != null ) {
    	 
    }else{
    	response.sendRedirect("../user.jsp"); 
    }%>
  
</body>
</html>