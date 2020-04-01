<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html oncontextmenu="return false">
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%request.getSession().setAttribute("admin_email", null);%>
<%  response.sendRedirect("../admin.jsp"); %>
</body>
</html>