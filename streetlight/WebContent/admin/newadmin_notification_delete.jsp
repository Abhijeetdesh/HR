<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>
    <%@ page import="java.sql.*" 
    import ="java.time.format.DateTimeFormatter"
    import="java.time.LocalDateTime"  %>
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
        </nav><%@include file="db.jsp" %>
        
 <%
 String admin_phone=request.getParameter("admin_phone");
String sr_no = request.getParameter("sr_no");
 if(sr_no != null){
int personID=Integer.parseInt(sr_no);

Connection connection = null;
Statement statement = null;
ResultSet resultSet = null;
%>
<%
try
{
   connection = DriverManager.getConnection(Url,Username,password);
   statement=connection.createStatement();
   String sql ="select * from admin_notification where sr_no="+personID;
   resultSet = statement.executeQuery(sql);
   while(resultSet.next())
   {
%>
    <div class="pad" >
      <form name="form1" method="post" action="newadmin_notification_record_delete.jsp">
		<div class="form-group">
        <label for="exampleInputEmail1">Sr No::</label>
        <input class="form-control" name="sr_no" type="text" value="<%=resultSet.getString("sr_no") %>" disabled="disabled">
        <input class="form-control" name="sr_no" type="hidden" value="<%=resultSet.getString("sr_no")%>">
        </div>
             
        <div class="form-group">
        <label for="exampleInputEmail1">Notification::</label>
        <input class="form-control" name="notification" type="text" value="<%=resultSet.getString("notification")%>"disabled="disabled">
        </div>
      
       <input type="hidden" name="admin_phone" value="<%=request.getParameter("admin_phone") %>" >  
                      
        <div class="form-group">
        <label for="exampleInputEmail1">Time::</label>
        <input class="form-control" name="time" height="20%" type="text" value="<%=resultSet.getString("time")%>" disabled="disabled">
        </div>
                  
        <button class="btn btn-primary" type="button" onclick = "functionAlert();" style="margin-left: 30%"><i class="fa fa-trash"></i>Delete</button>
		<div id = "confirm">
	    <div class = "message">Do you Want To Delete?</div>
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
catch (Exception e) {
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
