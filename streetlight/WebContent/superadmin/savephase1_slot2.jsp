<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html oncontextmenu="return false">
<head>
<meta charset="UTF-8">

	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>ADD Admin Record</title>
  	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="../css/style2.css">
</head>
<body >
 <%@include file="sessioncache.jsp" %>
<div class="wrapper d-flex align-items-stretch">
<nav id="sidebar" class="active">
 <a href="aderatesolutions.com" class="logo"> Aderate Tech Solutions</a>
          <ul class="list-unstyled components mb-5">
          <li >
            <a href="dashboard.jsp"><span class="fa fa-home"></span>DashBoard</a>
          </li>
          <li>
              <a href="dptable.jsp"><span class="fa fa-sliders"></span>DP List</a>
          </li>
            <li>
            <a href="onoff.jsp"><span class="fa fa-toggle-on"></span>ON/OFF</a>
          </li>
           <li>
              <a href="timeset.jsp"><span class="fa fa-clock-o"></span> Time Manager</a>
          </li>
          <li>
          <li>
            <a  class="active" href="admin_info.jsp"><span class="fa fa-users"></span> Admin Manager</a>
          </li>
          <li>
            <a href="user_info.jsp"><span class="fa fa-users"></span> User Manager</a>
          </li>
          <li>
            <a href="admin_notification_info.jsp"><span class="fa fa-bell"></span> Admin Notifications</a>
          </li>
           <li>
            <a href="user_notification_info.jsp"><span class="fa fa-bell"></span> User Notifications</a>
          </li>
           <li>
            <a href="logout.jsp"><span class="fa fa-power-off"></span>Logout</a>
          </li>
        </ul>

    	</nav>
    	
    	<div id="content" >

        <nav class="navbar navbar-expand-lg navbar-light bg-light">
          <div class="container-fluid">

            <button type="button" id="sidebarCollapse" class="btn btn-primary">
              <i class="fa fa-bars"></i>
              <span class="sr-only">Toggle Menu</span>
            </button>
              <h5>Street Light Controller </h5>
          </div>
        </nav>
        
      
 <%@include file="db.jsp" %>
<%
String ontime2 = request.getParameter("on_time2");
String offtime2=request.getParameter("off_time2");

String dpid=request.getParameter("dpid");
System.out.println(dpid);
System.out.println(ontime2);
System.out.println(offtime2);
if(ontime2!= null && offtime2!=null)
{
Connection con = null;
PreparedStatement ps = null;

try
{

con = DriverManager.getConnection(Url,Username,password);
String sql="Update onephase set on_time2 =?,off_time2=? where dpid='"+dpid+"'";
ps = con.prepareStatement(sql);
ps.setString(1,ontime2);
ps.setString(2,offtime2);

int i = ps.executeUpdate();
if(i > 0)
{
RequestDispatcher rd=request.getRequestDispatcher("timeset.jsp");
rd.forward(request,response);
}
else
{
	RequestDispatcher rd=request.getRequestDispatcher("error.jsp");
   	rd.forward(request, response);}
}
catch(SQLException sql)
{
request.setAttribute("error", sql);
out.println(sql);
}
}

else{
	RequestDispatcher rd=request.getRequestDispatcher("error.jsp");
   	rd.forward(request, response);
}
%>    
            
   </div>
   </div>
    <%@include file="footer.jsp" %>
   
  </body>
</html>
