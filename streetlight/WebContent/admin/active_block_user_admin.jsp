<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html oncontextmenu="return false">
<head>
<meta charset="UTF-8">

	<meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Active/Block User</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="../css/style2.css">
</head>
<body>
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
	<div class="wrapper d-flex align-items-stretch">
			<nav id="sidebar" class="active" >
				<a href="index.html" class="logo"><img src="images/logo.jpg" style="width: 25px;height: 25px;" ><br> AdeRate Solution</a>
        
        <ul class="list-unstyled components mb-5">
         <li>
              <a href="dashboard_admin.jsp?admin_phone=<%=request.getParameter("admin_phone")%>"><span class="fa fa-sliders"></span>Dashboard</a>
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
            
           
          </div>
        </nav>
        <div class=" pull-right" style="margin-top:5px;">
   			     <input class="btn btn-outline-primary" type=button onClick="location.href='admin_user_info1.jsp?admin_phone=<%=request.getParameter("admin_phone")%>'" value='Back'>
		      </div> 
          <%@include file="db.jsp" %>
 <%
String user_phone = request.getParameter("user_phone");

Connection connection = null;
Statement statement = null;
ResultSet resultSet = null;
%>
<%
try{
connection = DriverManager.getConnection(Url,Username,password);
statement=connection.createStatement();
String sql ="select * from user where user_phone="+user_phone;
resultSet = statement.executeQuery(sql);
while(resultSet.next()){
%>

		<div class="my" >
           			
				<form name="form1" method="post" action="active_block_user2_admin.jsp">
	             <fieldset disabled="disabled"> 
 			   <div class="form-group">
				   <label for="exampleInputEmail1">User_Name::</label>
                    <input class="form-control=" name="user_name" type="text"  value="<%=resultSet.getString("user_name") %>" required/>
                   </div>
             
                 <div class="form-group">
                 <label for="exampleInputEmail1">User_Email::</label>
                    <input class="form-control" name="user_email" type="text" value="<%=resultSet.getString("user_email") %>">
                  </div>
                  
                     </fieldset> 
                  
                  
                   <div class="form-group">
                   <label for="exampleInputEmail1">User_Phone::</label>
                    <input class="form-control" name="user_phone" type="text" value="<%=resultSet.getString("user_phone") %>">
                  </div>
                 
                 <input class="form-control" name="admin_phone" type="hidden" value="<%=request.getParameter("admin_phone") %>">
              
                  <div class="form-group">
                  <label for="exampleInputEmail1">Status::</label>
                  <select class="form-control" name="status" type="text" >
                  <option value="active">active</option>
                  <option value="block">block</option>
                  </select>      
              </div>
            
            <button class="btn btn-primary" type="button" onclick = "functionAlert();" style="margin-left: 30%"><i class="fa fa-save"></i>Save</button>
		   <div id = "confirm">
	         <div class = "message">Do you Want Save?</div>
	         <button type="submit"  class = "yes">OK</button>
	         <button type="button" class="yes"  style="background: red">Cancel</button>
	       </div>    
		
            </form>
            </div>
	</div>                         
</div>

   <%
}
connection.close();
} catch (Exception e) {
e.printStackTrace();
}
			
%>

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
