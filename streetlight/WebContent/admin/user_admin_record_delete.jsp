<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html oncontextmenu="return false">
<head>
<%response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires",300);
    int timeout = session.getMaxInactiveInterval();
    response.setHeader("Refresh", timeout + "; URL = ../admin.jsp");%>

<%String u = (String) request.getSession().getAttribute("admin_email");
    if (u != null ) {
        
    }else{
        response.sendRedirect("../admin.jsp");
    }%>
<meta charset="UTF-8">
	<title>Time Manager</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<script src=https://code.jquery.com/jquery-3.3.1.js></script> 
   

    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
		
			<link rel="stylesheet" href="../css/style2.css">

 </head>


<body>
<div class="wrapper d-flex align-items-stretch">
			<nav id="sidebar" class="active" >
					<a href="index.html" class="logo"><img src="images/logo.jpg" style="width: 25px;height: 25px;" ><br> AdeRate Solution</a>
        <ul class="list-unstyled components mb-5">
      
     
          <li>
              <a href="dptable_admin.jsp?admin_phone=<%=request.getParameter("admin_phone")%>"><span class="fa fa-sliders"></span> DP List</a>
          </li>
           <li>
              <a class="active" href="timeset_admin.jsp?admin_phone=<%=request.getParameter("admin_phone")%>"><span class="fa fa-clock-o"></span> Time Manager</a>
          </li>
          <li>
          <li>
            <a href="admin_user_info1.jsp?admin_phone=<%=request.getParameter("admin_phone")%>"><span class="fa fa-users"></span> User Manager</a>
          </li>
          <li>
            <a href="onoff_admin.jsp?admin_phone=<%=request.getParameter("admin_phone") %>" ><span class="fa fa-toggle-on"></span> ON/OFF</a>
          </li>
          <li>
            <a href="show_admin_notification.jsp?admin_phone=<%=request.getParameter("admin_phone")%>" ><span class="fa fa-bell"></span> Show Notifications</a>
          </li>
           <li>
            <a href="newadmin_notification_info.jsp?admin_phone=<%=request.getParameter("admin_phone") %>" ><span class="fa fa-bell"></span>Notifications</a>
          </li>
         
           <li>
            <a href="logout.jsp"><span class="fa fa-power-off"></span>Logout</a>
          </li>
      </ul>  
      </nav>
    
    <!-- Page Content  -->
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
			String user_phone = request.getParameter("user_phone");
			String admin_phone=request.getParameter("admin_phone");
			%>
			<input type="hidden" name="admin_phone" value="<%=admin_phone%>">
			<% 
			 
			if(user_phone!= null)
			{
			Connection con = null;
			PreparedStatement ps = null;
/* 			int personID = Integer.parseInt(admin_phone);
 */			try
			{
			
			con = DriverManager.getConnection(Url,Username,password);
			String sql="delete from user where user_phone="+user_phone;
			ps = con.prepareStatement(sql);
			
			 
			int i = ps.executeUpdate();
			if(i > 0)
			{ 
				out.print("Record Deleted Successfully");
				RequestDispatcher rd=request.getRequestDispatcher("admin_user_info1.jsp");
   			 rd.forward(request, response);
   			
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
			}else{
				 RequestDispatcher rd=request.getRequestDispatcher("error2.jsp?admin_phone="+admin_phone);
					rd.include(request, response);
			}
			%>
      </div>
</div>
 <%@include file="footer.jsp" %>
  
  </body>
</html>
