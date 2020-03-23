<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.sql.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%@include file="db.jsp" %>
<% try{
	String dpid=request.getParameter("dpid");
    Connection con = DriverManager.getConnection(Url,Username,password);
PreparedStatement ps=con.prepareStatement("select * from onephase where dpid="+dpid);
ResultSet rs=ps.executeQuery();
while(rs.next()){
	%>r_onoff::<%=rs.getString("r_onoff")%>
	  y_onoff::<%=rs.getString("y_onoff")%>
	  b_onoff::<%=rs.getString("b_onoff")%>
	  <%
}
}
catch (Exception e) {
	System.out.println(e);
}

%>

</body>
</html>