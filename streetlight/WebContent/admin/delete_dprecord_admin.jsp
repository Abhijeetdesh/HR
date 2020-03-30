<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

	<meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Delete DP Recored</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="../css/style2.css">
</head>
<body>
	<div class="wrapper d-flex align-items-stretch">
      <nav id="sidebar" class="active">
	    <a href="index.html" class="logo"><img src="images/logo.jpg" style="width: 25px;height: 25px;" ><br> AdeRate Solution</a>
          <ul class="list-unstyled components mb-5">
            <% String admin_phone=request.getParameter("admin_phone"); 
     if(admin_phone != null){%>
           <li>
              <a href="dashboard_admin.jsp?admin_phone=<%=request.getParameter("admin_phone")%>"><span class="fa fa-sliders"></span>Dashboard</a>
          </li>
          <li>
              <a class="active" href="dptable_admin.jsp?admin_phone=<%=request.getParameter("admin_phone")%>"><span class="fa fa-sliders"></span> DP List</a>
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
            <a href="newadmin_notification_info.jsp?admin_phone=<%=request.getParameter("admin_phone") %>" ><span class="fa fa-bell"></span>Notifications</a>
          </li>
         
           <li>
            <a href="../homepage.jsp"><span class="fa fa-power-off"></span>Logout</a>
          </li>
          <%}
     else{
     RequestDispatcher rd1=request.getRequestDispatcher("error.jsp");
     	 	rd1.include(request, response);
     	 	}%>
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
String dpid = request.getParameter("dpid");
if(dpid!=null){

Connection connection = null;
Statement statement = null;
ResultSet resultSet = null;
%>
<%
try
{
   connection = DriverManager.getConnection(Url,Username,password);
   statement=connection.createStatement();
   String sql ="select * from dp_info where dpid="+dpid;
   resultSet = statement.executeQuery(sql);
   while(resultSet.next())
   {
%>
		<div class="my" >
           			
				<form name="form1" method="post" action="DeleteRecord_admin.jsp">
						
				   <div class="form-group">
                    <label for="exampleInputEmail1">Name::</label>
                    <input class="form-control" name="name" type="text" value="<%=resultSet.getString("name") %>" disabled/>
                   </div>
             
                 <div class="form-group">
                    <label for="exampleInputEmail1">DP id::</label>
                    <input class="form-control" name="dpid1" type="text" value="<%=resultSet.getString("dpid") %>" disabled>
                    <input class="form-control" name="dpid" type="hidden" value="<%=resultSet.getString("dpid") %>">
                  </div>
                  
                   <div class="form-group">
                    <label for="exampleInputEmail1">DP_Number::</label>
                    <input class="form-control" name="dp_number" type="text" value="<%=resultSet.getString("dp_number") %>" disabled>
                  </div>
                  
                    <div class="form-group">
                    <label for="exampleInputEmail1">Address::</label>
                    <input class="form-control" name="address" type="text" value="<%=resultSet.getString("address") %>" disabled>
                  </div>
                  
                    <div class="form-group">
                    <label for="exampleInputEmail1">Phone::</label>
                    <input class="form-control" name="phone" type="text" value="<%=resultSet.getString("phone") %>" disabled>
                  </div>
                
                   <input class="form-control" name="admin_phone" type="hidden" value="<%=request.getParameter("admin_phone") %>" >
                   
                  
            
          <button class="btn btn-primary" type="button" onclick = "functionAlert();" style="margin-left: 30%"><i class="fa fa-trash"></i>Delete</button>
		   <div id = "confirm">
	         <div class = "message">Do you Want Delete?</div>
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
} 
catch (Exception e)
{
e.printStackTrace();
}
}
else{
	 RequestDispatcher rd=request.getRequestDispatcher("error2.jsp?admin_phone="+admin_phone);
	 	rd.include(request, response);
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