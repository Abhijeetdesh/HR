<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
.a{
	
	margin-left: 5rem;
	}
.card-img-top{
	margin-top: 66px;
	margin-left: 54px;
	}
	
	
</style> 
 </head>
<body>
<div class="wrapper d-flex align-items-stretch">
<nav id="sidebar" class="active" >
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
              <!-- Page Content  -->
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
   <div class="pad">          
      		  <%@include file="db.jsp" %>
 <%
	String dpid = request.getParameter("dpid");
 String admin_phone=request.getParameter("admin_phone");
    Connection connection = null;
    Statement statement = null;
    ResultSet resultSet = null;
    if(dpid !=null){
	try
	{ 
	 connection = DriverManager.getConnection(Url,Username,password);
	 statement=connection.createStatement();
	 String sql ="SELECT * FROM dp_info where dpid="+dpid;
	 resultSet = statement.executeQuery(sql);
	 while(resultSet.next())
	 {  
      %>
        	<button type="button" class="btn btn-outline-primary" style="position: absolute;  margin-left: 3px;">DP ID ::<%=resultSet.getString("dpid") %></button>
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
            int r_min=resultSet1.getInt("r_min");
            int r_max=resultSet1.getInt("r_max");
             if(r_curr>=r_min && r_curr<=r_max)
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
            int y_min=resultSet1.getInt("y_min");
            int y_max=resultSet1.getInt("y_max");
             if(y_curr>=y_min && y_curr<=y_max)
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
            int b_min=resultSet1.getInt("b_min");
            int b_max=resultSet1.getInt("b_max");
             if(b_curr>=b_min && b_curr<=b_max)
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
         <%@include file="footer.jsp" %>

  </body>
</html>