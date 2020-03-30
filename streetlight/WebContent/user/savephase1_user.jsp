<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
  	<title>User DashBoard</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700,800,900" rel="stylesheet">
		
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
		<link rel="stylesheet" href="../css/style2.css">
		
  </head>
<body>
	<div class="wrapper d-flex align-items-stretch">
			<nav id="sidebar" class="active" >
		    <a href="index.html" class="logo"><img src="images/logo.jpg" style="width: 25px;height: 25px;" >Aderate Solution</a>
<%!String dpid=null;%>
<%
    Connection con1=null;
	PreparedStatement ps1=null;
	ResultSet rs1=null;
	String admin_phone=request.getParameter("admin_phone");

  %>
  <%@include file="db.jsp" %>
  <% 
   try
   {
  
     con1=DriverManager.getConnection(Url,Username,password);
     ps1=con1.prepareStatement("select * from user");
     
    String sql = "Select * from user Where admin_phone="+admin_phone;
      rs1 = ps1.executeQuery(sql);
      if(rs1.next())
      {
        dpid=rs1.getString("dpid");
   %>   
   
      	
     <ul class="list-unstyled components mb-5">
        
          
     <li ><a  href="dashboard_user.jsp?admin_phone=<%=request.getParameter("admin_phone")%>" ><span class="fa fa-info-circle"></span>Dashboard</a>
       </li>
      
      <li ><a  href="userdplist_user.jsp?dpid=<%=rs1.getString("dpid")%>&admin_phone=<%=request.getParameter("admin_phone")%>" ><span class="fa fa-info-circle"></span>User Details</a>
       </li>
           
       <li ><a  href="onoff_user.jsp?dpid=<%=rs1.getString("dpid")%>&admin_phone=<%=request.getParameter("admin_phone")%>" ><span class="fa fa-toggle-on"></span>ON/OFF</a>
        </li>
         
          <li ><a class="active" href="timeset_user.jsp?dpid=<%=rs1.getString("dpid")%>&admin_phone=<%=request.getParameter("admin_phone")%>" ><span class="fa fa-clock-o"></span>Time Manager</a>
        </li>
        
        <li ><a  href="show_user_notification.jsp?admin_phone=<%=request.getParameter("admin_phone")%>" ><span class="fa fa-bell"></span>Show Notifications</a>
        </li> 
        
       <li ><a  href="show_myuser_notification.jsp?admin_phone=<%=request.getParameter("admin_phone") %>" ><span class="fa fa-bell"></span>Show My Notifications</a>
        </li>      
            
        <li ><a  href="../homepage.jsp" ><span class="fa fa-power-off"></span>Logout</a>
        </li>
        
        
   </ul>
      </nav>
       <!-- Page Content  -->
      <div id="content" >

        <nav class="navbar navbar-expand-lg navbar-light bg-light">
          <div class="container-fluid">

            <button type="button" id="sidebarCollapse" class="btn btn-primary">
              <i class="fa fa-bars"></i>
              <span class="sr-only">Toggle Menu</span>
            </button>
            
           
          </div>
        </nav>
  <%
    }
  }
  catch (Exception e) 
  {
    e.printStackTrace();
  }
  %>
   	
   	

<%
String ontime = request.getParameter("on_time");
String offtime=request.getParameter("off_time");
System.out.println("dpid::"+dpid);
String admin_phone1=request.getParameter("admin_phone");
System.out.println(admin_phone1);
System.out.println(ontime);
System.out.println(offtime);
if(ontime!= null && offtime!=null)
{
Connection con = null;
PreparedStatement ps = null;

try
{

con = DriverManager.getConnection(Url,Username,password);
String sql="Update onephase set on_time=?,off_time=? where dpid='"+dpid+"'";
ps = con.prepareStatement(sql);
ps.setString(1,ontime);
ps.setString(2,offtime);

int i = ps.executeUpdate();
if(i > 0)
{
	request.setAttribute("admin_phone",admin_phone1);
	RequestDispatcher rd=request.getRequestDispatcher("timeset_user.jsp?dpid="+dpid);
	rd.forward(request,response);
}
else
{
	 RequestDispatcher rd=request.getRequestDispatcher("error.jsp");
		rd.include(request, response);
}
}
catch(SQLException sql)
{
request.setAttribute("error", sql);
out.println(sql);
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

     <%@include file="footer.jsp" %>
  </body>
</html>
