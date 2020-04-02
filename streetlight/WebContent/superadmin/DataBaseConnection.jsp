<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="java.sql.*,java.util.*"%>
<!DOCTYPE html>
<html oncontextmenu="return false">
<head>
<meta charset="UTF-8">

	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Active/Block Admin </title>
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
            <a class="active" href="user_info.jsp"><span class="fa fa-users"></span> User Manager</a>
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
   String name=request.getParameter("name");
   String dpid=request.getParameter("dpid");
   String dp_number=request.getParameter("dp_number");
   String address=request.getParameter("address");
   String phone=request.getParameter("phone");
   String aphone=request.getParameter("admin_phone");
   int r_min=Integer.parseInt(request.getParameter("r_min"));
   int y_min=Integer.parseInt(request.getParameter("y_min"));
   int b_min=Integer.parseInt(request.getParameter("b_min"));
   int r_max=Integer.parseInt(request.getParameter("r_max"));
   int y_max=Integer.parseInt(request.getParameter("y_max"));
   int b_max=Integer.parseInt(request.getParameter("b_max"));
   
   if (aphone!= null && dpid!=null) {
   try
   {
	
	Connection conn = DriverManager.getConnection(Url,Username,password);
PreparedStatement ps=null;
   
    

    ps=conn.prepareStatement("select * from dp_info where dpid='" +dpid+ "' and phone='"+phone+"'");
          ResultSet rs = ps.executeQuery();
          if (rs.next()) {
        	  System.out.println("DP already Regitstered");
        	  request.setAttribute("alertMsg", "DP already exist");
            	RequestDispatcher rd=request.getRequestDispatcher("regdpsuperadmin.jsp");  
            	rd.include(request, response);
        
          } 
          else {
	Statement st=conn.createStatement();
    int i=st.executeUpdate("insert into dp_info(name,dpid, dp_number,address,phone,r_min,r_max,y_min,y_max,b_min,b_max,admin_phone)values('"+name+"','"+dpid+"','"+dp_number+"','"+address+"','"+ phone+"','"+ r_min+"','"+ r_max+"','"+ y_min+"','"+ y_max+"','"+ b_min+"','"+ b_max+"','"+aphone+"')");
	if(i>0)
	{
	   RequestDispatcher rd=request.getRequestDispatcher("dptable.jsp");
	  rd.forward(request, response); 
	}
	else
	{
		RequestDispatcher rd=request.getRequestDispatcher("error.jsp");
	   	rd.forward(request, response);
	}
	
	Statement st1=conn.createStatement();
    int j=st1.executeUpdate("insert into onephase(dpid,r_voltage,r_current,y_voltage,y_current,b_voltage,b_current,r_onoff,y_onoff,b_onoff,on_time,off_time,on_time2,off_time2,r_min,r_max,y_min,y_max,b_min,b_max,admin_phone)values('"+dpid+"',0,0,0,0,0,0,'@R0','Y0','B0',null,null,null,null,'"+ r_min+"','"+ r_max+"','"+ y_min+"','"+ y_max+"','"+ b_min+"','"+ b_max+"','"+ aphone+"')");
	if(j>0)
	{
	  System.out.println("Record save into onephase");
	  
	}
	else
	{
		RequestDispatcher rd=request.getRequestDispatcher("error.jsp");
	   	rd.forward(request, response);
	}
	
   
          }
          
	   }
   catch(Exception e)
   {
	System.out.print(e);
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
 <script src="../js/main.js"></script>
     <%@include file="footer.jsp" %>

  </body>
</html>
