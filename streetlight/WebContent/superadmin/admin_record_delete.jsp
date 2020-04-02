<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html oncontextmenu="return false">
<head>
<meta charset="UTF-8">
	<title>Admin Notification</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<script src=https://code.jquery.com/jquery-3.3.1.js></script> 
   <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" href="../css/style2.css">
	  
 </head>

<body>
 <%@include file="sessioncache.jsp" %>
<div class="wrapper d-flex align-items-stretch">
<nav id="sidebar" class="active" >
 <a href="aderatesolutions.com" class="logo"> Aderate Tech Solutions</a>
        <ul class="list-unstyled components mb-5">
          <li >
            <a  href="dashboard.jsp"><span class="fa fa-home"></span>DashBoard</a>
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
            <a href="admin_info.jsp"><span class="fa fa-users"></span> Admin Manager</a>
          </li>
          <li>
            <a href="user_info.jsp"><span class="fa fa-users"></span> User Manager</a>
          </li>
          <li>
            <a class="active"  href="admin_notification_info.jsp"><span class="fa fa-bell"></span> Admin Notifications</a>
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
   String admin_phone = request.getParameter("admin_phone");
   if(admin_phone!= null)
   {
    Connection con = null;
	PreparedStatement ps = null;
/* 	int personID = Integer.parseInt(admin_phone);
 */	try
    {
     
	 con = DriverManager.getConnection(Url,Username,password);
	 String sql="delete from admin where admin_phone="+admin_phone;
	 ps = con.prepareStatement(sql);
	 int i = ps.executeUpdate();
	 if(i > 0)
	 {
	  RequestDispatcher rd=request.getRequestDispatcher("admin_info.jsp");
	  rd.forward(request, response);	
	 }
	else
	{

		RequestDispatcher rd=request.getRequestDispatcher("error.jsp");
		rd.forward(request, response);
    }
	 
	 String sql1="delete from dp_info where admin_phone="+admin_phone;
	 PreparedStatement ps1=con.prepareStatement(sql1);
	 int j=ps1.executeUpdate();
	 if(j>0)
	 {
		 System.out.println("record updated");
	 }
	 else
	 {

	     RequestDispatcher rd=request.getRequestDispatcher("error.jsp");
	     rd.forward(request, response);
	 }
	 
     
	 String sql4="delete from onephase where admin_phone='"+admin_phone+"'";
	 PreparedStatement ps4=con.prepareStatement(sql4);
	 int m=ps4.executeUpdate();
	 if(m>0)
	 {
		 System.out.println("record updated");
	 }
	 else
	 {

	     RequestDispatcher rd=request.getRequestDispatcher("error.jsp");
	     rd.forward(request, response);
	 }
	 
	 String sql3="delete from user where admin_phone='"+admin_phone+"'";
	 PreparedStatement ps3=con.prepareStatement(sql3);
	 int l=ps3.executeUpdate();
	 if(l>0)
	 {
		 System.out.println("record updated");
	 }
	 else
	 {

	     RequestDispatcher rd=request.getRequestDispatcher("error.jsp");
	     rd.forward(request, response);
	 }

	 
	 String sql2="delete from admin_notification where admin_phone="+admin_phone;
	 PreparedStatement ps2=con.prepareStatement(sql2);
	 int k=ps2.executeUpdate();
	 if(k>0)
	 {
		 System.out.println("record updated");
	 }
	 else
	 {

	     RequestDispatcher rd=request.getRequestDispatcher("error.jsp");
	     rd.forward(request, response);
	 }
   }
  catch(SQLException sql)
  {
    request.setAttribute("error", sql);
	out.println(sql);
  }
 }

else
{
	RequestDispatcher rd=request.getRequestDispatcher("error.jsp");
	rd.forward(request, response);
}	
%>

 </div>
</div> <script src="../js/main.js"></script>
     <%@include file="footer.jsp" %>
    
  </body>
</html>
