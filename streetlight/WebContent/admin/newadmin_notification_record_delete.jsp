<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

	<meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Delete Notification Record</title>
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
      <div>
      
<%
String sr_no = request.getParameter("sr_no");
String admin_phone=request.getParameter("admin_phone");
System.out.println("admin-phone::"+admin_phone);
Connection con = null;
PreparedStatement ps = null;

if(sr_no!= null)
	{
	int personID = Integer.parseInt(sr_no);
try
{
	  con = DriverManager.getConnection(Url,Username,password);
	  String sql="delete from admin_notification where sr_no="+personID;
	  ps = con.prepareStatement(sql);
	  int i = ps.executeUpdate();
	  if(i > 0)
	  {
	    RequestDispatcher rd=request.getRequestDispatcher("newadmin_notification_info.jsp?admin_phone="+admin_phone);
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
}
else{
RequestDispatcher rd=request.getRequestDispatcher("error2.jsp?admin_phone="+admin_phone);
	rd.include(request, response);
}
%>
      </div>
 </div>
</div>
    
    
    <script>
         function functionAlert(msg, myYes) 
         {
            var confirmBox = $("#confirm");
            confirmBox.find(".message").text(msg);
            confirmBox.find(".yes").unbind().click(function() {
               confirmBox.hide();
            });
            confirmBox.find(".yes").click(myYes);
            confirmBox.show();
         }
     </script>  	
    <script src="../js/jquery.min.js"></script>
    <script src="../js/popper.js"></script>
    <script src="../js/bootstrap.min.js"></script>
    <script src="../js/main.js"></script>
        <%@include file="footer.jsp" %>
</body>
</html>
