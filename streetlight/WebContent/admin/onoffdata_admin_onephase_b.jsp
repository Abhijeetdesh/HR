<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
   <%@ page import="java.sql.*" %>
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
<!DOCTYPE html>
<html oncontextmenu="return false">
  <head>
  	<title>Threephase B onoff data send</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700,800,900" rel="stylesheet">
		
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
		<link rel="stylesheet" href="../css/style2.css">
		<link rel="stylesheet" href="../css/chart.css">
		
  </head>
  <body>
		
		<div class="wrapper d-flex align-items-stretch">
			<nav id="sidebar" class="active">
					<a href="index.html" class="logo"><img src="images/logo.jpg" style="width: 25px;height: 25px;" ><br> AdeRate Solution</a>
         <ul class="list-unstyled components mb-5">
       <li>
              <a href="dptable_admin.jsp?admin_phone=<%=request.getParameter("admin_phone")%>"><span class="fa fa-sliders"></span> DP List</a>
          </li>
           <li>
              <a  href="timeset_admin.jsp?admin_phone=<%=request.getParameter("admin_phone")%>"><span class="fa fa-clock-o"></span> Time Manager</a>
          </li>
          <li>
          <li>
            <a href="admin_user_info1.jsp?admin_phone=<%=request.getParameter("admin_phone")%>"><span class="fa fa-users"></span> User Manager</a>
          </li>
          <li>
            <a class="active" href="onoff_admin.jsp?admin_phone=<%=request.getParameter("admin_phone") %>" ><span class="fa fa-toggle-on"></span> ON/OFF</a>
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
<div> 

<%@include file="db.jsp" %>
<%
String id = request.getParameter("dpid");
String data=request.getParameter("data"); 
String aphone=request.getParameter("admin_phone");
Connection connection = null;
PreparedStatement ps=null;
if(id !=null && data !=null)
{
try

{ 
connection = DriverManager.getConnection(Url,Username,password);
String sql="Update onephase set b_onoff=? where dpid="+id;
ps = connection.prepareStatement(sql);
ps.setString(1,data);


int i = ps.executeUpdate();

if(i > 0)
{
	RequestDispatcher rd = request.getRequestDispatcher("onoff_admin.jsp?admin_phone="+aphone);
	rd.forward(request, response);
}	  
else
{
	 RequestDispatcher rd=request.getRequestDispatcher("error2.jsp?admin_phone="+aphone);
		rd.include(request, response);


}}
catch (Exception e) {
				
e.printStackTrace();
}
} else
	  {
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
     <script src="../js/chart.js"></script>
        <%@include file="footer.jsp" %>
    
  </body>
</html>