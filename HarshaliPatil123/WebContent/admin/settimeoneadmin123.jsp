<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" 
    import ="java.time.format.DateTimeFormatter"
    import="java.time.LocalDateTime"  %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

	<meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Set Time</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="../css/style2.css">
</head>
<body >
	
	<div class="wrapper d-flex align-items-stretch">
			<nav id="sidebar" class="active">
					<a href="index.html" class="logo"><img src="images/logo.jpg" style="width: 25px;height: 25px;" ><br> AdeRate Solution</a>
        <ul class="list-unstyled components mb-5">
      
       
          <li>
              <a href="dptable_admin.jsp?admin_phone=<%=request.getParameter("admin_phone")%>"><span class="fa fa-sliders"></span> DP List</a>
          </li>
           <li>
              <a class="active" href="timeset_admin.jsp?admin_phone=<%=request.getParameter("admin_phone")%>"><span class="fa fa-clock-o"></span> Time Manager</a>
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
                       
 <%
 DateTimeFormatter dtf = DateTimeFormatter.ofPattern(" HH:mm:ss");
 LocalDateTime now = LocalDateTime.now();
%>
              
  <%
String dpid = request.getParameter("dpid");


Connection connection = null;
Statement statement = null;ResultSet resultSet = null;
Statement statement1 = null;ResultSet resultSet1 = null;
Statement statement2 = null;ResultSet resultSet2 = null;
Statement statement3 = null;ResultSet resultSet3 = null;

%>
<%
try{
connection = DriverManager.getConnection(Url,Username,password);
statement=connection.createStatement();
String sql ="select * from dp_info where dpid="+dpid;
resultSet = statement.executeQuery(sql);
while(resultSet.next()){
/* 	String phase=resultSet.getString("phase");
    int count = Integer.parseInt(phase); */
 /*    if(count==1) */
/*     { */
    	statement1=connection.createStatement();
    	String sql1 ="select * from onephase where dpid="+dpid;
    	resultSet1 = statement1.executeQuery(sql1);
    	while(resultSet1.next())
    	{

%>
		
		      <h2 style="color: red; text-align: center;">Set Time</h2>
		      <div class="row">
    <div class="col-sm-6">
    <form> 
        <h6  style=" margin-left: 15%; font-weight: bold ;">Current Saved Time</h6>
        <div class="form-group">
          <label for="text">On Time</label>
          <input type="text" class="form-control" value="<%=resultSet1.getString("on_time")%>"  id="First" disabled>
        </div>
        <div class="form-group">
          <label for="text">Off Time</label>
          <input type="text" class="form-control"  value="<%=resultSet1.getString("off_time")%>" id="Last" disabled>
        </div>
         <input type="hidden" name="dpid" value="<%=dpid%>">
        </form>
    </div>
    <div class="col-sm-6">
         <form action="savephase1_admin.jsp" method="post" >
         <h6 style=" margin-left: 25%;  font-weight: bold ;" >Slot 1</h6>
         <div class="form-group">
          <label for="text">On Time</label>
          <input type="hidden" name="admin_phone" value="<%=resultSet.getString("admin_phone")%>">
             <input class="form-control"  name="on_time" value="<%=dtf.format(now)%>" type="text" required/>
        </div>
        <div class="form-group">
          <label for="text">Off Time</label>
          <input type="text" class="form-control"name="off_time" value="<%=dtf.format(now)%>"  id="Last">
        </div>
         <input type="hidden" name="dpid" value="<%=dpid%>">
            <button class="btn btn-primary a" type="submit" ><i class="fa fa-fw fa-lg fa-check-circle"></i>Register</button>
        </form>
    </div>
</div><br>
 <div class="row">
    <div class="col-sm-6">
        <form>
        <h6 style=" margin-left: 15%;  font-weight: bold ;">Current Saved Time</h6>
        <div class="form-group">
          <label for="text">On Time</label>
          <input type="text" class="form-control"   value="<%=resultSet1.getString("on_time2")%>" id="First" disabled>
        </div>
        <div class="form-group">
          <label for="text">Off Time</label>
          <input type="text" class="form-control"  value="<%=resultSet1.getString("off_time2")%>" id="Last" disabled>
        </div>
          <input type="hidden" name="dpid" value="<%=dpid%>">
        </form>
    </div>
    <div class="col-sm-6">
       <form action=savephase1_admin_slot2.jsp method="post" >
         <h6 style=" margin-left: 25%;  font-weight: bold ;">Slot 2</h6>
         <div class="form-group">
          <label for="text">On Time</label>
         <input type="hidden" name="admin_phone" value="<%=resultSet.getString("admin_phone")%>">
            <input class="form-control"  name="on_time2" value="<%=dtf.format(now)%>" type="text" required/>
        </div>
        <div class="form-group">
          <label for="text">Off Time</label>
          <input type="text" class="form-control"  name="off_time2" value="<%=dtf.format(now)%>" id="Last">
        </div>
        <input type="hidden" name="dpid" value="<%=dpid%>">
            <button class="btn btn-primary b" type="submit" "><i class="fa fa-fw fa-lg fa-check-circle"></i>Register</button>
        </form>
    </div>
</div>
   
   <% 
    	}
 }
    

connection.close();
} catch (Exception e) {
e.printStackTrace();
}
			
%>
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
    <footer >
	   		<div class="footer-copyright" >
	        <p class="footer-company">All Rights Reserved. &copy; 2020 <a href="https://wss.mahadiscom.in/wss/wss" target="blank">MAHARASHTRA STATE ELECTRICITY BOARD</a> Design By :
	            <a  href="https://aderatesolutions.com/" target="blank"> AdeRate Tech Solutions</a></p>
	    	</div>
	</footer>     
    

  </body>
</html>
