<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

	<meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Delete DP Recored</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="../css/style2.css">
</head>
<body>
		<div class="wrapper d-flex align-items-stretch">
			<nav id="sidebar" class="active">
					<a href="index.html" class="logo"><img src="images/logo.jpg" style="width: 25px;height: 25px;" ><br> AdeRate Solution</a>
        <ul class="list-unstyled components mb-5">
          <li class="active">
            <a href="#"><span class="fa fa-home"></span> DashBoard</a>
          </li>
          <li>
              <a href="dptable.jsp"><span class="fa fa-sliders"></span> DP List</a>
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
            <a href="onoff.jsp"><span class="fa fa-toggle-on"></span>ON/OFF</a>
          </li>
           <li>
          <a href="../homepage.jsp"><span class="fa fa-power-off"></span>Logout</a>
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
			String admin_phone=request.getParameter("admin_phone");
			if(dpid!= null)
			{
			Connection con = null;
			PreparedStatement ps = null;
			int personID = Integer.parseInt(dpid);
			try
			{
			
			con = DriverManager.getConnection(Url,Username,password);
			String sql="delete from dp_info where dpid="+personID;
			ps = con.prepareStatement(sql);
			
			 
			int i = ps.executeUpdate();
			if(i > 0)
			{
			 RequestDispatcher rd=request.getRequestDispatcher("dptable_admin.jsp");
   			 rd.forward(request, response);
			}
			else
			{

				 RequestDispatcher rd=request.getRequestDispatcher("error2.jsp?admin_phone="+admin_phone);
				 	rd.include(request, response);
			}

			String sql1="delete from onephase where dpid='"+dpid+"'";
			PreparedStatement ps1 = con.prepareStatement(sql1);
			
				
				 
				int j = ps1.executeUpdate();
				if(j > 0)
				{
					System.out.println("Record deleted from onephase");
				}
				else
				{
					 RequestDispatcher rd=request.getRequestDispatcher("error2.jsp?admin_phone="+admin_phone);
					 	rd.include(request, response);
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
			 RequestDispatcher rd=request.getRequestDispatcher("error2.jsp?admin_phone="+admin_phone);
			 	rd.include(request, response);
		}
			%>
    </div>
    </div>
    
      <%@include file="footer.jsp" %>
  
  </body>
</html>
