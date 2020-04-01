<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" 
    import="java.util.ArrayList"
    import="java.util.List" 
 %>
<%@page import="java.util.Base64"%>
<%@page import="javax.crypto.Cipher"%>
<%@page import="java.io.UnsupportedEncodingException"%>
<%@page import="java.security.NoSuchAlgorithmException"%>
<%@page import="javax.crypto.spec.SecretKeySpec"%>
<%@page import="javax.crypto.SecretKey"%>
<%@page import="java.security.MessageDigest"%>
<%@page import="java.util.Arrays" %>
<%@ page import="java.sql.*" 
         import="com.grocery.AES"
         import="com.grocery.Admin_RegisterController"
         %>
    <%@include file="db.jsp" %>
<!DOCTYPE html>
<html>
<head>
  	<title></title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700,800,900" rel="stylesheet">
		
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
		<link rel="stylesheet" href="../css/style2.css">
	    <link rel="stylesheet" href="../css/chart.css">
		
  </head>

<body>
<div class="wrapper d-flex align-items-stretch">
   <nav id="sidebar" class="active">
 <a href="aderatesolutions.com" class="logo"> Aderate Tech Solutions</a>
         <ul class="list-unstyled components mb-5">
         <%!String admin_phone=null; %>
        <% admin_phone=request.getParameter("admin_phone");%>
      
           <li>
              <a class="active" href="dashboard_admin.jsp?admin_phone=<%=request.getParameter("admin_phone")%>"><span class="fa fa-home"></span>Dashboard</a>
          </li>
          
          <li>
              <a href="dptable_admin.jsp?admin_phone=<%=request.getParameter("admin_phone")%>"><span class="fa fa-sliders"></span> DP List</a>
          </li>
          <li>
            <a href="onoff_admin.jsp?admin_phone=<%=request.getParameter("admin_phone") %>" ><span class="fa fa-toggle-on"></span> ON/OFF</a>
          </li>
          <li>
              <a href="timeset_admin.jsp?admin_phone=<%=request.getParameter("admin_phone")%>"><span class="fa fa-clock-o"></span> Time Manager</a>
          </li>
          <li>
          <li>
            <a href="admin_user_info1.jsp?admin_phone=<%=request.getParameter("admin_phone")%>"><span class="fa fa-users"></span> User Manager</a>
          </li>
          <li>
            <a href="show_admin_notification.jsp?admin_phone=<%=request.getParameter("admin_phone") %>" ><span class="fa fa-bell"></span> Show Notifications</a>
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
             <h5>Street Light Controller </h5>
         </div>
        </nav>
 <div class="pad">
        <%!String c1=null,c3=null,c4=null;%>
 <%!int v1=0,v3=0,v4=0; %>
<%
int sum3=0,offdp=0;
String dpid=null;

Connection con1=null;
Statement statement1=null;ResultSet resultSet1=null;
Statement statement2=null;ResultSet resultSet2=null;
Statement statement3=null;ResultSet resultSet3=null;
Statement statement4=null;ResultSet resultSet4=null;
try
{ 
	con1 = DriverManager.getConnection(Url, Username, password);
    statement1=con1.createStatement();
    statement2=con1.createStatement();
    statement3=con1.createStatement();
    statement4=con1.createStatement();

    String sql1 ="SELECT COUNT(dpid)FROM dp_info WHERE admin_phone="+admin_phone;
    resultSet1 = statement1.executeQuery(sql1);
    ResultSetMetaData rsmd1 = resultSet1.getMetaData();
    int columnsNumber1 = rsmd1.getColumnCount();
    
    while(resultSet1.next())
    {
       for (int i = 1; i <= columnsNumber1; i++) 
 	   {
         c1=resultSet1.getString(i);
         v1=Integer.parseInt(c1);
         
       }
    }
    System.out.println("Total DP..."+v1);
     
    String sql2="SELECT * FROM dp_info WHERE admin_phone="+admin_phone;
    resultSet2=statement2.executeQuery(sql2);
    ArrayList idlist=new ArrayList();
    while(resultSet2.next())
    {
    	dpid=resultSet2.getString("dpid");
        Object[] value=dpid.split(",");
        for(int i=0; i<value.length;i++)
        {
        	idlist.add(value[i]);
        }

    }
    System.out.println("List:::"+idlist);
    for(Object n : idlist)
    {
   	 String sql3="SELECT COUNT(dpid) FROM onephase WHERE (r_current>=r_min AND r_current<=r_max) OR (y_current>=y_min AND y_current<=y_max) OR (b_current>=b_min AND b_current<=b_max) AND dpid="+n;
     resultSet3=statement3.executeQuery(sql3);
   	 ResultSetMetaData rsmd3 = resultSet3.getMetaData();
   	 int columnsNumber3 = rsmd3.getColumnCount();
   	 while(resultSet3.next())
   	 {
   	   for (int i = 1; i <= columnsNumber3; i++) 
   	    {
   	     c3=resultSet3.getString(i);
   	     v3=Integer.parseInt(c3);
        }
        
   	  }
    }
	     sum3=sum3+v3;
	     System.out.println("Total ON DP::"+sum3);
	     offdp=v1-sum3;
	     System.out.println("Total OFF DP::"+offdp);
	
	 String sql4 ="SELECT COUNT(user_phone)FROM user WHERE admin_phone="+admin_phone;
	 resultSet4 = statement4.executeQuery(sql4);
	 ResultSetMetaData rsmd4 = resultSet4.getMetaData();
	 int columnsNumber4 = rsmd4.getColumnCount();
	 while(resultSet4.next())
	 {
	    for (int i = 1; i <= columnsNumber4; i++) 
	  	{
	       c4=resultSet4.getString(i);
	       v4=Integer.parseInt(c4);
	    }
	 }
	  System.out.println("Total user::"+v4);
	          
	     
 %> 

 <div class="bg-style">
<!--   <h1 class="p-3">Canvas circular progressbar </h1>
 -->  <div class="wrapper">
    <div class="row pt-5 pb-5">
  
  <div class="col-6 col-sm-3">
        <div class="counter" data-cp-percentage="<%=v1%>" data-cp-color="#00bfeb">
        </div>
        <h4>Total DP</h4>
     </div>
  
  <div class="col-6 col-sm-3">
        <div class="counter" data-cp-percentage="<%=sum3%>" data-cp-color="#EA4C89"></div>
        <h4>Total On DP</h4>
  </div>
 
  <div class="col-6 col-sm-3">
      <div class="counter" data-cp-percentage="<%=offdp%>" data-cp-color="#FF675B"></div>
      <h4>Total Off DP</h4>
    </div>
  
   <div class="col-6 col-sm-3">
        <div class="counter" data-cp-percentage="<%=v4%>" data-cp-color="#0008ff"></div>
        <h4>Total Users</h4>
    </div>
    
  </div>
  </div>
 </div>
<p class="p-3">
</p>
<%
  }
  catch (Exception e)
  {
    e.printStackTrace();
  }

%>
</div>
</div>
 </div>
          
          
     <script src="../js/chart.js"></script>
    <script src="../js/jquery.min.js"></script>
    <script src="../js/popper.js"></script>
    <script src="../js/bootstrap.min.js"></script>
    <script src="../js/main.js"></script>
        <%@include file="footer.jsp" %>
  
  </body>
</html>
