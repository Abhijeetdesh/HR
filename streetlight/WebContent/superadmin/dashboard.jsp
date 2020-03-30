<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page import="java.sql.*" 
    import="java.util.ArrayList"
    import="java.util.List" %>
<!DOCTYPE html>
<html>
  <head>
  	<title>SuperAdmin DashBoard</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700,800,900" rel="stylesheet">
		
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
		<link rel="stylesheet" href="../css/style2.css">
		<link rel="stylesheet" href="../css/chart.css">
	<style>
	progress:before{
	content: 'valu' attr(value);
	position: relative;
	top: 5px;
	
	
	}
</style>	
</head>
<body>
		
<div class="wrapper d-flex align-items-stretch">
<nav id="sidebar" class="active" >
 <a href="aderatesolutions.com" class="logo"> Aderate Tech Solutions</a>
       <ul class="list-unstyled components mb-5">
          <li >
            <a class="active"  href="dashboard.jsp"><span class="fa fa-home "></span>Dashboard</a>
          </li>
          <li>
              <a  href="dptable.jsp"><span class="fa  fa-sliders "></span>DP List</a>
          </li>
            <li>
            <a href="onoff.jsp"><span class="fa fa-toggle-on"></span>ON/OFF</a>
          </li>
           <li>
              <a href="timeset.jsp"><span class="fa fa-clock-o"></span> Time Manager</a>
          </li>
          <li>
          <li>
            <a href="admin_info.jsp"><span class="fa fa-users"></span> Admin Manager </a>
          </li>
          <li>
            <a href="user_info.jsp"><span class="fa fa-users"></span> User Manager </a>
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
      <%@include file="sessioncache.jsp" %>
     <%@include file="db.jsp" %>
<%!String check1=null,check2=null,check3=null,check4=null; %>
<%!int var1=0,var2=0,offdp=0,var3=0,var4=0; %>   

<%
Connection connection = null;
Statement statement1 = null;ResultSet resultSet1 = null;
Statement statement2 =null;ResultSet resultSet2=null;
Statement statement3 =null;ResultSet resultSet3=null;
Statement statement4 =null;ResultSet resultSet4=null;
Statement statement5 =null;ResultSet resultSet5=null;

%>
<%
try
{
    connection = DriverManager.getConnection(Url,Username,password);
    statement1=connection.createStatement();
    statement2=connection.createStatement();
    statement3=connection.createStatement();
    statement4=connection.createStatement();
    statement5=connection.createStatement();
  
    String sql1 ="SELECT COUNT(dpid)FROM dp_info" ;
    resultSet1 = statement1.executeQuery(sql1);
    ResultSetMetaData rsmd1 = resultSet1.getMetaData();
    int columnsNumber1 = rsmd1.getColumnCount();
    while(resultSet1.next())
    {
      for (int i = 1; i <= columnsNumber1; i++) 
	  {
       check1=resultSet1.getString(i);
       var1=Integer.parseInt(check1);
	   }
    }
     System.out.println("Total dp::"+var1);
     
     String sql2 ="SELECT COUNT(dpid) FROM onephase where (r_current>=r_min AND r_current<=r_max) OR (y_current>=y_min AND y_current<=y_max) OR (b_current>=b_min AND b_current<=b_max)";
     resultSet2 = statement2.executeQuery(sql2);
     ResultSetMetaData rsmd2 = resultSet2.getMetaData();
     int columnsNumber2 = rsmd2.getColumnCount();
    
     while(resultSet2.next())
     {
    	 for (int i = 1; i <= columnsNumber1; i++) 
   	    {
         check2=resultSet2.getString(i);
         var2=Integer.parseInt(check2);
   	    }
     }
         	 
      System.out.println("On dp List::"+var2);
      offdp=var1-var2;
     System.out.println("Total Off::"+offdp);
      
     String sql3="SELECT COUNT(admin_phone) FROM admin";
     resultSet3=statement3.executeQuery(sql3);
     ResultSetMetaData rsmd3 = resultSet3.getMetaData();
     
     int columnsNumber3 = rsmd3.getColumnCount();
     while(resultSet3.next())
     {
       for (int i = 1; i <= columnsNumber3; i++) 
 	  {
        check3=resultSet3.getString(i);
        var3=Integer.parseInt(check3);
 	   }
     }
      System.out.println("Total admin::"+var3);
      
      String sql4="SELECT COUNT(user_phone) FROM user";
      resultSet4=statement4.executeQuery(sql4);
      ResultSetMetaData rsmd4 = resultSet4.getMetaData();
      
      int columnsNumber4 = rsmd4.getColumnCount();
      while(resultSet4.next())
      {
        for (int i = 1; i <= columnsNumber4; i++) 
  	  {
         check4=resultSet4.getString(i);
         var4=Integer.parseInt(check4);
  	   }
      }
       System.out.println("Total User::"+var4);
       
%>  
    <div class="bg-style">
<!--   <h1 class="p-3">Canvas circular progressbar </h1>
 -->  <div class="wrapper">
    <div class="row pt-5 pb-5">
  
      <div class="col-6 col-sm-3">
        <div class="counter" data-cp-percentage="<%=var1%>" data-cp-color="#00bfeb">
        </div>
        <h4>Total DP</h4>
     </div>
  
     <div class="col-6 col-sm-3">
        <div class="counter" data-cp-percentage="<%=var2%>" data-cp-color="#EA4C89"></div>
        <h4>Total On DP</h4>
     </div>
 
    <div class="col-6 col-sm-3">
      <div class="counter" data-cp-percentage="<%=offdp%>" data-cp-color="#FF675B"></div>
      <h4>Total Off DP</h4>
    </div>
  
       <div class="col-6 col-sm-3">
        <div class="counter" data-cp-percentage="<%=var3%>" data-cp-color="#FF9900"></div>
        <h4>Total Admins</h4>
    </div>
    
      <div class="col-6 col-sm-3">
        <div class="counter" data-cp-percentage="<%=var4%>" data-cp-color="#0008ff"></div>
        <h4>Total Users</h4>
    </div>
   
    </div>
  </div>
 
</div>
<p class="p-3">
</p>
</div>
 <%
 connection.close();
 } 
 catch (Exception e)
 {
 e.printStackTrace();
 }
 %>     
</div>

    <script src="../js/jquery.min.js"></script>
    <script src="../js/popper.js"></script>
    <script src="../js/bootstrap.min.js"></script>
    <script src="../js/main.js"></script>
     <script src="../js/chart.js"></script>
     <%@include file="footer.jsp" %>
   </body>
</html>