<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>  
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>DP Details</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<script src=https://code.jquery.com/jquery-3.3.1.js></script> 
   

    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
		
			<link rel="stylesheet" href="../css/style2.css">
	  
    <style>
.notfound{
  display: none;
}

tr:nth-child(even) {background-color: #F9E79F;}
th, td {
  padding: 8px;
  text-align: left;
  border-bottom: 1px solid #ddd;
}
th{
background-color: #282C34;
color: white;
}
tr:hover {background-color:#f5f5f5;}
</style> 
 </head>
<body>
	<div class="wrapper d-flex align-items-stretch">
			<nav id="sidebar" class="active" >
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
      
          
          
          <!-- Page Content  -->
      <div id="content" >

        <nav class="navbar navbar-expand-lg navbar-light bg-light">
          <div class="container">

            <button type="button" id="sidebarCollapse" class="btn btn-primary">
              <i class="fa fa-bars"></i>
              <span class="sr-only">Toggle Menu</span>
            </button>
            
           
          </div>
        </nav>
      
   <%@include file="db.jsp" %>
 <%
	String dpid = request.getParameter("dpid");
    Connection connection = null;
    Statement statement = null;
    ResultSet resultSet = null;
	try
	{ 
	 connection = DriverManager.getConnection(Url,Username,password);
	 statement=connection.createStatement();
	 String sql ="SELECT * FROM dp_info where dpid="+dpid;
	 resultSet = statement.executeQuery(sql);
	 while(resultSet.next())
	 {  
      %>
        	<button type="button" class="btn btn-outline-primary" style="position: absolute; top:80px; margin-left: 20px;">DP ID ::<%=resultSet.getString("dpid") %></button>
     <%
    Statement statement1 = null;
    ResultSet resultSet1 =null;
    try
	{
       connection =DriverManager.getConnection(Url,Username,password);
       statement1=connection.createStatement();
	   String sql1="SELECT * FROM onephase where dpid="+dpid;
	   resultSet1=statement1.executeQuery(sql1);
	   while(resultSet1.next())
	  {			
	           
	 %>   	
     <div class="card" style="width: 17rem;">
       <div class="card-body">
         <h5 class="card-title">R</h5>
         <% String r_current=resultSet1.getString("r_current");
            int r_curr=Integer.parseInt(r_current);
             if(r_curr>=8 && r_curr<=12)
             {
         %>
            <img class="card-img-top" src="../images/ONbulb.jpg" alt="Card image cap"><br><br>
         <%
             }
             else
             {
        %>   
            <img class="card-img-top" src="../images/OFFbulb.jpg" alt="Card image cap"><br><br>
        <%
             }
        %>     
          <span class="a">Voltage::<%=resultSet1.getString("r_voltage") %></span><br>
          <span class="a">Current::<%=resultSet1.getString("r_current") %></span>
     </div>
  </div>
  
   <div class="card" style="width: 17rem;">
       <div class="card-body">
         <h5 class="card-title">Y</h5>
         <% String y_current=resultSet1.getString("y_current");
            int y_curr=Integer.parseInt(y_current);
             if(y_curr>=8 && y_curr<=12)
             {
         %>
            <img class="card-img-top" src="../images/ONbulb.jpg" alt="Card image cap"><br><br>
         <%
             }
             else
             {
        %>   
            <img class="card-img-top" src="../images/OFFbulb.jpg" alt="Card image cap"><br><br>
        <%
             }
        %>     
          <span class="a">Voltage::<%=resultSet1.getString("y_voltage") %></span><br>
          <span class="a">Current::<%=resultSet1.getString("y_current") %></span>
     </div>
  </div>
  
  <div class="card" style="width: 17rem;">
       <div class="card-body">
         <h5 class="card-title">B</h5>
         <% String b_current=resultSet1.getString("b_current");
            int b_curr=Integer.parseInt(b_current);
             if(b_curr>=8 && b_curr<=12)
             {
         %>
            <img class="card-img-top" src="../images/ONbulb.jpg" alt="Card image cap"><br><br>
         <%
             }
             else
             {
        %>   
            <img class="card-img-top" src="../images/OFFbulb.jpg" alt="Card image cap"><br><br>
        <%
             }
        %>     
          <span class="a">Voltage::<%=resultSet1.getString("b_voltage") %></span><br>
          <span class="a">Current::<%=resultSet1.getString("b_current") %></span>
     </div>
  </div>
  <%  
     }
   }
   catch (Exception e) 
   {
	e.printStackTrace();
    }		
}
%> 
   
   <%
   
 }
catch (Exception e) 
 {
   e.printStackTrace();
   }  
   
   %>     	
        	
   </div>
  </div>
    
             
   
    <script>
            
            function selectRow(){
        
                var radios = document.getElementsByName("select");
                for( var i = 0; i < radios.length; i++ )
                {
                    radios[i].onclick = function()
                    {
                        // remove class from the other rows
                        
                        var el = document.getElementById("first-tr");
                        
                        // go to the nex sibing
                        while(el = el.nextSibling)
                        {
                            if(el.tagName === "TR")
                            {
                                // remove the selected class
                                el.classList.remove("selected");
                            }
                        }
                        
                     // radio  -      td      -          tr 
                        this.parentElement.parentElement.classList.toggle("selected");
                    };
                }
        
            }
            selectRow();
        </script>
         <script src="../js/jquery.min.js"></script>
    <script src="../js/popper.js"></script>
    <script src="../js/bootstrap.min.js"></script>
    <script src="../js/main.js"></script>
    <footer style="margin-top: -5%;" >
	   		<div class="footer-copyright" >
	        <p class="footer-company">All Rights Reserved. &copy; 2020 <a href="https://wss.mahadiscom.in/wss/wss" target="blank">MAHARASHTRA STATE ELECTRICITY BOARD</a> Design By :
	            <a  href="https://aderatesolutions.com/" target="blank"> AdeRate Tech Solutions</a></p>
	    	</div>
	</footer>     
    
  </body>
</html>