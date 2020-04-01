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
            <a class="active" href="admin_user_info1.jsp?admin_phone=<%=request.getParameter("admin_phone")%>"><span class="fa fa-users"></span> User Manager</a>
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

String admin_phone=request.getParameter("admin_phone");
System.out.println("admin no*"+admin_phone);
 
String user_phone=request.getParameter("user_phone");
String status=request.getParameter("status"); 
Connection con = null;
PreparedStatement ps = null;
/* int personID = Integer.parseInt(admin_phone);
 */System.out.println(user_phone);
 System.out.println(status);
 if(user_phone !=null){
try
{
   con = DriverManager.getConnection(Url,Username,password);
   String sql="Update user set status=? where user_phone="+user_phone; 

    ps = con.prepareStatement(sql);
    ps.setString(1, status); 
    int i = ps.executeUpdate();
    if(i > 0)
     {
    	 RequestDispatcher rd=request.getRequestDispatcher("admin_user_info1.jsp?admin_phone="+admin_phone);
		 rd.forward(request, response);
		
     }
   
    	else{
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
else{
	RequestDispatcher rd=request.getRequestDispatcher("error2.jsp?admin_phone="+admin_phone);
 	rd.include(request, response);
}

%>    
            
   </div>
   </div>
  <%@include file="footer.jsp" %>
   
  </body>
</html>
