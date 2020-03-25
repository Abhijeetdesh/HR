<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

	<meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Active/Block User</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="../css/style2.css">
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
            <a class="active" href="admin_user_info1.jsp?admin_phone=<%=request.getParameter("admin_phone")%>"><span class="fa fa-users"></span> User Manager</a>
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

 String aphone=request.getParameter("admin_phone");
String user_phone=request.getParameter("user_phone");
if(user_phone !=null){
String status=request.getParameter("status"); 
Connection con = null;
PreparedStatement ps = null;
/* int personID = Integer.parseInt(admin_phone);
 */System.out.println(user_phone);
 System.out.println(status);
   try
   {
     
     con = DriverManager.getConnection(Url,Username,password);
 String sql="Update user set status=? where user_phone="+user_phone; 

    ps = con.prepareStatement(sql);
/*  ps.setString(1,admin_name);
ps.setString(2, admin_email); 
ps.setString(3,admin_phone);
ps.setString(4, category);*/
ps.setString(1, status); 
    int i = ps.executeUpdate();
    if(i > 0)
     {
    	 RequestDispatcher rd=request.getRequestDispatcher("admin_user_info1.jsp");
		 rd.forward(request, response);
		
     }
    else
    {
      out.print("There is a problem in updating Record.");
    }
   }
   catch(SQLException sql)
   {
    request.setAttribute("error", sql);
     out.println(sql);
    }
}
else{
	RequestDispatcher rd=request.getRequestDispatcher("error2.jsp?admin_phone="+aphone);
 	rd.include(request, response);
}
%>    
            
   </div>
   </div>
  </body>
</html>
