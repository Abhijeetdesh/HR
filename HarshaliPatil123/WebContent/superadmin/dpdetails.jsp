<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

	<meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Delete Dp Recored</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" href="../css/style2.css">
	<style type="text/css">
	.a{
	
	margin-left: 5rem;
	}
	</style>
</head>
<body>

    <div class="wrapper d-flex align-items-stretch">
			<nav id="sidebar" class="active">
					<a href="index.html" class="logo"><img src="images/logo.jpg" style="width: 25px;height: 25px;" ><br> AdeRate Solution</a>
        <ul class="list-unstyled components mb-5">
          <li >
            <a  href="dashboard.jsp"><span class="fa fa-home"></span>DashBoard</a>
          </li>
          <li>
              <a class="active" href="dptable.jsp"><span class="fa fa-sliders"></span>DP List</a>
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
      <%@include file="db.jsp" %>
    <%
	String dpid = request.getParameter("dpid");
    Connection connection = null;
    Statement statement = null;
    ResultSet resultSet = null;
    if (dpid!= null) 
    {
	try
	{ 
	 connection = DriverManager.getConnection(Url,Username,password);
	 statement=connection.createStatement();
	 String sql ="SELECT * FROM dp_info where dpid="+dpid;
	 resultSet = statement.executeQuery(sql);
	 while(resultSet.next())
	 {  
      %>
        	<button type="button" class="btn btn-outline-primary" style="position: absolute; top:80px; margin-left: 20px;">DP ID ::<%=resultSet.getString("dpid") %></button>
     <%
				
				
	
	   
	     Statement statement1 = null;
         ResultSet resultSet1 =null;
         
             connection =DriverManager.getConnection(Url,Username,password);
			 statement1=connection.createStatement();
		     String sql1="SELECT * FROM onephase where dpid="+dpid;
		     resultSet1=statement1.executeQuery(sql1);
		     
			 while(resultSet1.next())
			{			
	           
	 %>   	
     <div class="card" style="width: 17rem;">
       <div class="card-body">
         <h5 class="card-title">R</h5>
         <% String onoff=resultSet1.getString("onoff"); 
             if(onoff.equals("#R1"))
             {
         %>
            <img class="card-img-top" src="../images/ONbulb.jpg" alt="Card image cap"><br><br>
         <%
             }
             else
             {
        %>   
            <img class="card-img-top" src="../images/OFFbulb.jpg" alt="Card image cap"><br><br>
        <%
             }
        %>     
          <span class="a">Voltage::<%=resultSet1.getString("r_voltage") %></span><br>
          <span class="a">Current::<%=resultSet1.getString("r_current") %></span>
    
     </div>
  </div>
  
   
   <%
			}		
 }}
catch (Exception e) 
 {
   e.printStackTrace();
   }  
	 }
	else
	{
		RequestDispatcher rd=request.getRequestDispatcher("error.jsp");
    	rd.forward(request, response);
	}
   
   %>     	
        	
   </div>
  </div>
        
        
     <script src="../js/jquery.min.js"></script>
    <script src="../js/popper.js"></script>
    <script src="../js/bootstrap.min.js"></script>
    <script src="../js/main.js"></script>
 	<footer style="margin-top: 15px;">
	   		<div class="footer-copyright" style="margin-top:-5%;width: 100%;">
	        <p class="footer-company">All Rights Reserved. &copy; 2020 <a href="https://wss.mahadiscom.in/wss/wss" target="blank">MAHARASHTRA STATE ELECTRICITY BOARD</a> Design By :
	            <a  href="https://aderatesolutions.com/" target="blank"> AdeRate Tech Solutions</a></p>
	    	</div>
	</footer>    
  
  </body>
</html>
        	