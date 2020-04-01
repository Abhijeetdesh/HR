<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>  
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page import="java.sql.*"%> 
<%@ page import ="java.time.format.DateTimeFormatter"
    import="java.time.LocalDateTime"  %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>DP LIST</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<script src=https://code.jquery.com/jquery-3.3.1.js></script> 
   

    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
		
			<link rel="stylesheet" href="../css/style2.css">
	  <style>
	#link
	{
	color: #009688 ;
	}
   </style>
    <style>
.notfound{
  display: none;
}


</style> 
 </head>

<body>
<%@include file="db.jsp" %>
 <div class="wrapper d-flex align-items-stretch">
<nav id="sidebar" class="active" >
 <a href="aderatesolutions.com" class="logo"> Aderate Tech Solutions</a>
	 <ul class="list-unstyled components mb-5">
<%!String user_phone,dpid1; %>
<%
    Connection con1=null;
	PreparedStatement ps1=null;
	ResultSet rs1=null;
    String aphone=request.getParameter("admin_phone");
    user_phone=request.getParameter("user_phone");
  %>
  <% 
   try
   {
	   
     con1=DriverManager.getConnection(Url,Username,password);
     ps1=con1.prepareStatement("select * from user");
     
    String sql = "Select * from user Where user_phone=" +user_phone;
      rs1 = ps1.executeQuery(sql);
      if(rs1.next())
      {
        dpid1=rs1.getString("dpid");
%>
     <li ><a  href="dashboard_user.jsp?user_phone=<%=rs1.getString("user_phone")%>"><span class="fa fa-home"></span>Dashboard</a>
       </li>
      
      <li ><a  href="userdplist_user.jsp?dpid=<%=rs1.getString("dpid")%>&admin_phone=<%=request.getParameter("admin_phone")%>&user_phone=<%=rs1.getString("user_phone") %>" ><span class="fa fa-info-circle"></span>User Details</a>
       </li>
           
       <li ><a  href="onoff_user.jsp?dpid=<%=rs1.getString("dpid")%>&admin_phone=<%=request.getParameter("admin_phone")%>&user_phone=<%=rs1.getString("user_phone") %>" ><span class="fa fa-toggle-on"></span>ON/OFF</a>
        </li>
         
          <li ><a class="active" href="timeset_user.jsp?dpid=<%=rs1.getString("dpid")%>&admin_phone=<%=request.getParameter("admin_phone")%>&user_phone=<%=rs1.getString("user_phone") %>" ><span class="fa fa-clock-o"></span>Time Manager</a>
        </li>
        
        <li ><a  href="show_user_notification.jsp?admin_phone=<%=request.getParameter("admin_phone")%>&user_phone=<%=rs1.getString("user_phone") %>" ><span class="fa fa-bell"></span>Show Notifications</a>
        </li> 
        
       <li ><a  href="show_myuser_notification.jsp?admin_phone=<%=request.getParameter("admin_phone") %>&user_phone=<%=rs1.getString("user_phone") %>" ><span class="fa fa-bell"></span>Show My Notifications</a>
        </li>      
            
        <li ><a  href="logout.jsp" ><span class="fa fa-power-off"></span>Logout</a>
        </li>
        
        
      </ul>
      </nav>
<%
      
}
}
catch (Exception e) 
{
e.printStackTrace();
}
%><div id="content" >
	        <nav class="navbar navbar-expand-lg navbar-light bg-light">
	          <div class="container-fluid">
	
	            <button type="button" id="sidebarCollapse" class="btn btn-primary">
	              <i class="fa fa-bars"></i>
	              <span class="sr-only">Toggle Menu</span>
	            </button>
               <h5>Street Light Controller </h5>
         		</div>
         		</nav>
   <div class="pad">    
    <div class=" pull-right" style="margin-top:5px;">
   	  <input class="btn btn-outline-primary" type=button onClick="location.href='timeset_user.jsp?user_phone=<%=user_phone %>&admin_phone=<%=request.getParameter("admin_phone")%>&dpid=<%=dpid1%>'" value='Back'>
   </div>
                    
 <%
 DateTimeFormatter dtf = DateTimeFormatter.ofPattern(" HH:mm:ss");
 LocalDateTime now = LocalDateTime.now();
%>
              
             <%
String dpid = request.getParameter("dpid");
String admin_phone=request.getParameter("admin_phone");             

Connection connection = null;
Statement statement = null;
ResultSet resultSet = null;
Statement statement1 = null;
ResultSet resultSet1 = null;

%>
<%
if(dpid != null){
try{
connection = DriverManager.getConnection(Url,Username,password);
statement=connection.createStatement();
statement1=connection.createStatement();
String sql ="select * from dp_info where dpid="+dpid;
resultSet = statement.executeQuery(sql);
while(resultSet.next()){
    	
    	String sql1 ="select * from onephase where dpid="+dpid;
    	 resultSet1 = statement1.executeQuery(sql1);
    	while(resultSet1.next())
    	{
    	%>
		      <div class="row">
    <div class="col-sm-6">
    <form> 
        <h6  style=" margin-left: 15%; font-weight: bold ;">Current Saved Time</h6>
        <div class="form-group">
          <label for="text">On Time</label>
          <input type="text" class="form-control"  value="<%=resultSet1.getString("on_time")%>" id="First" disabled>
        </div>
        <div class="form-group">
          <label for="text">Off Time</label>
          <input type="text" class="form-control" value="<%=resultSet1.getString("off_time")%>" id="Last" disabled>
        </div>
      
        </form>
    </div>
    <div class="col-sm-6">
         <form action="savephase1_user.jsp" method="post" >
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
         <input type="hidden" name="admin_phone" value="<%=admin_phone%>">
         
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
          <input type="text" class="form-control"  value="<%=resultSet1.getString("off_time2")%>" id="Last" disabled>
        </div>
         
        </form>
    </div>
    <div class="col-sm-6">
       <form action=savephase1_user_slot2.jsp method="post" >
         <h6 style=" margin-left: 25%;  font-weight: bold ;">Slot 2</h6>
         <div class="form-group">
          <label for="text">On Time</label>
          <input type="text" class="form-control" name="on_time2" value="<%=dtf.format(now)%>"  id="First">
        </div>
        <div class="form-group">
          <label for="text">Off Time</label>
          <input type="text" class="form-control"  name="off_time2" value="<%=dtf.format(now)%>" id="Last">
        </div>
         <input type="hidden" name="dpid" value="<%=dpid%>">
         <input type="hidden" name="admin_phone" value="<%=admin_phone%>">
         
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
}
else
{
	 RequestDispatcher rd=request.getRequestDispatcher("error.jsp");
		rd.include(request, response);
}		
%>
</div>
</div>
</div>



    
    
   
    <script src="../js/jquery.min.js"></script>
    <script src="../js/popper.js"></script>
    <script src="../js/bootstrap.min.js"></script>
    <script src="../js/main.js"></script>
         <%@include file="footer.jsp" %>
</body>
</html>
