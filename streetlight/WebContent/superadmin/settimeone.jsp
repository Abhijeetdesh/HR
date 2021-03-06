<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" 
    import ="java.time.format.DateTimeFormatter"
    import="java.time.LocalDateTime"  %>
<!DOCTYPE html>
<html oncontextmenu="return false">
<head>
<meta charset="UTF-8">

	<meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Set Time</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="../css/style2.css">
    <style type="text/css">
    .a,.b{
    margin-left: 20%;
    }
    </style>
</head>
<body>
 <%@include file="sessioncache.jsp" %>
<div class="wrapper d-flex align-items-stretch">
<nav id="sidebar" class="active">
 <a href="aderatesolutions.com" class="logo"> Aderate Tech Solutions</a>
      <ul class="list-unstyled components mb-5">
          <li >
            <a href="dashboard.jsp"><span class="fa fa-home"></span>DashBoard</a>
          </li>
          <li>
              <a href="dptable.jsp"><span class="fa fa-sliders"></span>DP List</a>
          </li>
            <li>
            <a href="onoff.jsp"><span class="fa fa-toggle-on"></span>ON/OFF</a>
          </li>
           <li>
              <a  class="active" href="timeset.jsp"><span class="fa fa-clock-o"></span> Time Manager</a>
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
        	  <div class=" pull-right" style="margin-top:5px;">
   					<input class="btn btn-outline-primary" type=button onClick="location.href='timeset.jsp'" value='Back'>
		      </div>
		      <%
 DateTimeFormatter dtf = DateTimeFormatter.ofPattern("HH:mm:ss");
 LocalDateTime now = LocalDateTime.now();
%>
        <%@include file="db.jsp" %>       
 <%
String dpid = request.getParameter("dpid");
Connection connection = null;
Statement statement = null;ResultSet resultSet = null;
Statement statement1 = null;ResultSet resultSet1 = null;
Statement statement2 = null;ResultSet resultSet2 = null;
Statement statement3 = null;ResultSet resultSet3 = null;

%>
<%if(dpid !=null){

try{
connection = DriverManager.getConnection(Url,Username,password);
statement=connection.createStatement();
statement1=connection.createStatement();
statement2=connection.createStatement();
statement3=connection.createStatement();

String sql ="select * from dp_info where dpid="+dpid;
resultSet = statement.executeQuery(sql);
while(resultSet.next())
{
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
          <input type="text" class="form-control" value="<%=resultSet1.getString("on_time")%>" id="First" disabled>
        </div>
        <div class="form-group">
          <label for="text">Off Time</label>
          <input type="text" class="form-control"  value="<%=resultSet1.getString("off_time")%>" id="Last" disabled>
        </div>
        <input type="hidden" name="dpid" value="<%=dpid%>">
        </form>
    </div>
    <div class="col-sm-6">
         <form action="savephase1.jsp" method="post" >
         <h6 style=" margin-left: 25%;  font-weight: bold ;" >Slot 1</h6>
         <div class="form-group">
          <label for="text">On Time</label>
          <input type="text" class="form-control"  name="on_time" value="<%=dtf.format(now)%>" id="First">
        </div>
        <div class="form-group">
          <label for="text">Off Time</label>
          <input type="text" class="form-control" name="off_time" value="<%=dtf.format(now)%>" id="Last">
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
          <input type="text" class="form-control"  value="<%=resultSet1.getString("on_time2")%>" id="First" disabled>
        </div>
        <div class="form-group">
          <label for="text">Off Time</label>
          <input type="text" class="form-control" value="<%=resultSet1.getString("off_time2")%>" id="Last" disabled>
        </div>
         <input type="hidden" name="dpid" value="<%=dpid%>">
        </form>
    </div>
    <div class="col-sm-6">
       <form action=savephase1_slot2.jsp method="post" >
         <h6 style=" margin-left: 25%;  font-weight: bold ;">Slot 2</h6>
         <div class="form-group">
          <label for="text">On Time</label>
          <input type="text" class="form-control" name="on_time2" value="<%=dtf.format(now)%>" id="First">
        </div>
        <div class="form-group">
          <label for="text">Off Time</label>
          <input type="text" class="form-control" name="off_time2" value="<%=dtf.format(now)%>" id="Last">
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
} 
catch (Exception e) 
{
e.printStackTrace();
}
}
else{
	RequestDispatcher rd=request.getRequestDispatcher("error.jsp");
   	rd.forward(request, response);
}
%>

</div>
</div>
    <script src="../js/jquery.min.js"></script>
    <script src="../js/popper.js"></script>
    <script src="../js/bootstrap.min.js"></script>
    <script src="../js/main.js"></script>
        <%@include file="footer.jsp" %>

  </body>
</html>
