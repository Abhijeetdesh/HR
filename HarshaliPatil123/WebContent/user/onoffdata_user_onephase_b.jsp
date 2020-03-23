<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
   <%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
  <head>
  	<title> B onoff data send</title>
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
          <li ><a  class="active" class="app-menu__item" href="userdplist_user.jsp?dpid=<%=request.getParameter("dpid1")%>&admin_phone=<%=request.getParameter("admin_phone")%>" ><span class="fa fa-info-circle"></span> User Details</a>
           </li>
           
          <li ><a class="app-menu__item" href="timeset_user.jsp?dpid=<%=request.getParameter("dpid1")%>&admin_phone=<%=request.getParameter("admin_phone")%>" ><span class="fa fa-clock-o"></span>Time Manager</a>
        </li>
        
        <li ><a class="app-menu__item" href="onoff_user.jsp?dpid=<%=request.getParameter("dpid1")%>&admin_phone=<%=request.getParameter("admin_phone")%>" ><span class="fa fa-toggle-on"></span>ON/OFF</a>
        </li>
       
        <li ><a class="app-menu__item" href="show_user_notification.jsp?admin_phone=<%=request.getParameter("admin_phone")%>" ><span class="fa fa-bell"></span>Show Notifications</a>
        </li> 
        
       <li ><a class="app-menu__item" href="show_myuser_notification.jsp?admin_phone=<%=request.getParameter("admin_phone")%>" ><span class="fa fa-bell"></span>Show My Notifications</a>
        </li>  
         
         <li ><a class="app-menu__item" href="../homepage.jsp" ><span class="fa fa-power-off"></span>Logout</a>
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
<div> <%@include file="db.jsp" %>
<%
String id = request.getParameter("dpid");
String dpid1=request.getParameter("dpid1");
String data=request.getParameter("data"); 
String aphone=request.getParameter("admin_phone");
Connection connection = null;
PreparedStatement ps=null;

try
{ 
connection = DriverManager.getConnection(Url,Username,password);
String sql="Update onephase set b_onoff=? where dpid="+id;
ps = connection.prepareStatement(sql);
ps.setString(1,data);


int i = ps.executeUpdate();

if(i > 0)
{
/* 	request.setAttribute("dpid",dpid1);
 */	RequestDispatcher rd = request.getRequestDispatcher("onoff_user.jsp?dpid="+dpid1);
	rd.forward(request, response);
}	  
else
{
	out.print("record not updated");
}  


}
catch (Exception e) {
				
e.printStackTrace();
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
    <footer style="margin-top: 13px;">
	   		<div class="footer-copyright" style="margin-top:-5%;width: 100%;">
	        <p class="footer-company">All Rights Reserved. &copy; 2020 <a href="https://wss.mahadiscom.in/wss/wss" target="blank">MAHARASHTRA STATE ELECTRICITY BOARD</a> Design By :
	            <a  href="https://aderatesolutions.com/" target="blank"> AdeRate Tech Solutions</a></p>
	    	</div>
	</footer>    
  </body>
</html>