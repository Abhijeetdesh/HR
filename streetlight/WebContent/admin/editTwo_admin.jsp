<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

	<meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Edit DP Recored</title>
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
           <%String admin_phone=request.getParameter("admin_phone");
        if(admin_phone !=null)
        {
      %>
            <a href="dashboard.jsp"><span class="fa fa-home"></span> DashBoard</a>
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
           <% }
        else{
        	RequestDispatcher rd=request.getRequestDispatcher("error2.jsp?admin_phone="+admin_phone);
        	 	rd.include(request, response);
        } %>  
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


String name = request.getParameter("name");
//String dpid=request.getParameter("dpid");
String dpid1=request.getParameter("dpid1");
String dp_number=request.getParameter("dp_number");
String address=request.getParameter("address");
String phone=request.getParameter("phone");

int r_min=Integer.parseInt(request.getParameter("r_min"));
int y_min=Integer.parseInt(request.getParameter("y_min"));
int b_min=Integer.parseInt(request.getParameter("b_min"));
int r_max=Integer.parseInt(request.getParameter("r_max"));
int y_max=Integer.parseInt(request.getParameter("y_max"));
int b_max=Integer.parseInt(request.getParameter("b_max"));

if(dpid1!= null)
{
Connection con = null;
PreparedStatement ps = null;
//int personID = Integer.parseInt(dpid1);
try
{

con = DriverManager.getConnection(Url,Username,password);
String sql = "Update dp_info set name=?,dpid=?,dp_number=?,address=?,phone=?,r_min=?,r_max=?,y_min=?,y_max=?,b_min=?,b_max=? where dpid="+dpid1 ;
ps = con.prepareStatement(sql);
ps.setString(1, name);
ps.setString(2,dpid1);
ps.setString(3, dp_number);
ps.setString(4, address);
ps.setString(5, phone);
ps.setInt(6,r_min);
ps.setInt(7,r_max);
ps.setInt(8,y_min);
ps.setInt(9,y_max);
ps.setInt(10,b_min);
ps.setInt(11,b_max);
int i = ps.executeUpdate();
if(i > 0)
{
	RequestDispatcher rd=request.getRequestDispatcher("dptable_admin.jsp?admin_phone="+admin_phone);
	 rd.forward(request, response);
}
else
{
	RequestDispatcher rd=request.getRequestDispatcher("error2.jsp?admin_phone="+admin_phone);
	 	rd.include(request, response);
}
String sql1 = "Update onephase set r_min=?,r_max=?,y_min=?,y_max=?,b_min=?,b_max=? where dpid="+dpid1;
PreparedStatement	ps1 = con.prepareStatement(sql1);
	ps1.setInt(1,r_min);
	ps1.setInt(2,r_max);
	ps1.setInt(3,y_min);
	ps1.setInt(4,y_max);
	ps1.setInt(5,b_min);
	ps1.setInt(6,b_max);
	int j = ps1.executeUpdate();
	
	if (j > 0) {
		
		System.out.println("Record Updated successfully");
	} else {
		RequestDispatcher rd=request.getRequestDispatcher("error2.jsp?admin_phone="+admin_phone);
	 	rd.include(request, response);
	}
}
catch(SQLException sql)
{
request.setAttribute("error", sql);
out.println(sql);
}
} else{
	RequestDispatcher rd=request.getRequestDispatcher("error2.jsp?admin_phone="+admin_phone);
	 	rd.include(request, response);
}
       
%>    
    
  </div>
 	</div>
     <%@include file="footer.jsp" %>
 	
  </body>
</html>
