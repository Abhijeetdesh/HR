<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

	<meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Delete Dp Recored</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" href="../css/style2.css">
</head>
<body>

    <div class="wrapper d-flex align-items-stretch">
			<nav id="sidebar" class="active">
					<a href="index.html" class="logo"><img src="images/logo.jpg" style="width: 25px;height: 25px;" ><br> AdeRate Solution</a>
       <ul class="list-unstyled components mb-5">
          <li >
            <a class="active" href="dashboard.jsp"><span class="fa fa-home"></span>DashBoard</a>
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
	            
	           
	          </div>
        	</nav>
       <br><br><br><br>
 <div>
	 <%@include file="db.jsp" %>
		<%
			//int sr_no=Integer.parseInt(request.getParameter("sr_no"));
			String notification=request.getParameter("notification");
			String time=request.getParameter("time");
			System.out.println(notification);
			if(notification==null)
			{
				   request.setAttribute("alertMsg", "Add Notification");
				   	RequestDispatcher rd=request.getRequestDispatcher("notification_form.jsp");  
				   	rd.include(request, response);
			}
			else
			{
			try
			{
			
			Connection conn = DriverManager.getConnection(Url,Username,password);
			Statement st=conn.createStatement();
			
			int i=st.executeUpdate("insert into notification(notification,time)values('"+notification+"','"+time+"')");
             if(i>0){
			 RequestDispatcher rd=request.getRequestDispatcher("admin_notification_info.jsp");
			 rd.forward(request, response);	
             }
             else{
            	 RequestDispatcher rd=request.getRequestDispatcher("error.jsp");
 		    	rd.forward(request, response);
             }
			}
			catch(Exception e)
			{
			System.out.print(e);
			e.printStackTrace();
			}
			}
			%>
			
 </div>
     
   </div>
 </div>
  </body>
</html>
