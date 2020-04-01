<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>  
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page import="java.sql.*" 
    import ="java.time.format.DateTimeFormatter"
    import="java.time.LocalDateTime"  %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Add Notification</title>
  	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="../css/style2.css">
</head>

<body >
<div class="wrapper d-flex align-items-stretch">
			<nav id="sidebar" class="active">
 <a href="aderatesolutions.com" class="logo"> Aderate Tech Solutions</a>
         <ul class="list-unstyled components mb-5">
         <li>
              <a href="dashboard_admin.jsp?admin_phone=<%=request.getParameter("admin_phone")%>"><span class="fa fa-home"></span>Dashboard</a>
          </li>
          
          <li>
              <a href="dptable_admin.jsp?admin_phone=<%=request.getParameter("admin_phone")%>"><span class="fa fa-sliders"></span> DP List</a>
          </li>
          <li>
            <a href="onoff_admin.jsp?admin_phone=<%=request.getParameter("admin_phone") %>" ><span class="fa fa-toggle-on"></span> ON/OFF</a>
          </li>
          
           <li>
              <a  href="timeset_admin.jsp?admin_phone=<%=request.getParameter("admin_phone")%>"><span class="fa fa-clock-o"></span> Time Manager</a>
          </li>
          <li>
          <li>
            <a href="admin_user_info1.jsp?admin_phone=<%=request.getParameter("admin_phone")%>"><span class="fa fa-users"></span> User Manager</a>
          </li>
          <li>
            <a href="show_admin_notification.jsp?admin_phone=<%=request.getParameter("admin_phone")%>" ><span class="fa fa-bell"></span> Show Notifications</a>
          </li>
           <li>
            <a class="active" href="newadmin_notification_info.jsp?admin_phone=<%=request.getParameter("admin_phone") %>" ><span class="fa fa-bell"></span>Notifications</a>
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
 <div>
 <%@include file="db.jsp" %>
	
		<%
			String notification=request.getParameter("notification");
			String time=request.getParameter("time");
			String aphone=request.getParameter("admin_phone");
            
			if(notification !=null){
			try
			{
			
			Connection conn = DriverManager.getConnection(Url,Username,password);
			Statement st=conn.createStatement();
			
			int i=st.executeUpdate("insert into admin_notification(notification,time,admin_phone)values('"+notification+"','"+time+"','"+aphone+"')");
             if(i>0){
			 RequestDispatcher rd=request.getRequestDispatcher("newadmin_notification_info.jsp");
			 rd.forward(request, response);	
             }
             else{
            	 RequestDispatcher rd=request.getRequestDispatcher("error2.jsp?admin_phone="+aphone);
 		     	rd.include(request, response);
             }
			}
			catch(Exception e)
			{
			System.out.print(e);
			e.printStackTrace();
			}
			}
			else{
				RequestDispatcher rd=request.getRequestDispatcher("error2.jsp?admin_phone="+aphone);
		     	rd.include(request, response);
			}
			%>
			
 </div>
 </div>    
       </div>   
   <script src="../js/jquery.min.js"></script>
    <script src="../js/popper.js"></script>
    <script src="../js/bootstrap.min.js"></script>
    <script src="../js/main.js"></script>
       <%@include file="footer.jsp" %>
</body>
</html>
