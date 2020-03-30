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
  	<title>User DashBoard</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700,800,900" rel="stylesheet">
		
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
		<link rel="stylesheet" href="../css/style2.css">
	   <link rel="stylesheet" href="../css/chart.css">
		
  </head>


<body >
		<div class="wrapper d-flex align-items-stretch">
			<nav id="sidebar" class="active">
					<a href="index.html" class="logo"><img src="images/logo.jpg" style="width: 25px;height: 25px;" ><br> AdeRate Solution</a>
     			<ul class="list-unstyled components mb-5">
   <%
   String dpid=null;
    String admin_phone=request.getParameter("admin_phone");
    System.out.println("***"+admin_phone);
    Connection con1= DriverManager.getConnection(Url, Username, password);
    Statement statement=null;ResultSet resultSet=null;
    PreparedStatement ps=null;
    ps=con1.prepareStatement("SELECT * FROM user");
    String sql="Select * FROM user WHERE admin_phone="+admin_phone;
    resultSet=ps.executeQuery(sql);
    while(resultSet.next())
    {
    	dpid=resultSet.getString("dpid");
    } 
	System.out.println("###"+dpid);

    %>
        <li ><a  class="active" class="app-menu__item" href="dashboard_user.jsp?admin_phone=<%=admin_phone%>"><span class="fa fa-info-circle"></span>Dashboard</a>
        </li>
       
        <li ><a class="app-menu__item" href="userdplist_user.jsp?admin_phone=<%=admin_phone%>&dpid=<%=dpid%>"><span class="fa fa-info-circle"></span> User Details</a>
        </li>
         
        <li><a class="app-menu__item" href="onoff_user.jsp?admin_phone=<%=admin_phone%>&dpid=<%=dpid%>"><span class="fa fa-toggle-on"></span>ON/OFF</a>
        </li>
         
        <li ><a class="app-menu__item" href="timeset_user.jsp?admin_phone=<%=admin_phone%>&dpid=<%=dpid%>"><span class="fa fa-clock-o"></span>Time Manager</a>
        </li>
        
        <li ><a class="app-menu__item" href="show_user_notification.jsp?admin_phone=<%=admin_phone%>" ><span class="fa fa-bell"></span>Show Notifications</a>
        </li> 
        
       <li ><a class="app-menu__item" href="show_myuser_notification.jsp?admin_phone=<%=admin_phone%>" ><span class="fa fa-bell"></span>Show My Notifications</a>
        </li>  
         
         <li ><a class="app-menu__item" href="../homepage.jsp" ><span class="fa fa-power-off"></span>Logout</a>
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
        
 <%! String c1=null;%>
<%! int v1=0; %>
<% 
int sum1=0,offdp=0;
System.out.println(dpid);
String[] value=dpid.split(",");
 int count=0;
 con1 = DriverManager.getConnection(Url, Username, password);
 Statement statement1=null;ResultSet resultSet1=null;
 statement1=con1.createStatement();
 ArrayList<String> idlist=new ArrayList();
for(int i=0; i<value.length;i++)
{
	System.out.println("Total dp::"+value[i]);
	idlist.add(value[i]);
	count++;
	
}
System.out.println("Total DPPP:"+count);
System.out.println("idlist::"+idlist);
for(String n : idlist)
{
	System.out.println("dpid="+n);
	 String sql1="SELECT COUNT(dpid) FROM onephase WHERE (r_current>=r_min AND r_current<=r_max) OR (y_current>=y_min AND y_current<=y_max) OR (b_current>=b_min AND b_current<=b_max) AND dpid="+n;
     resultSet1=statement1.executeQuery(sql1);
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
	 System.out.println("Total ON DP:"+v1);

}
 
 offdp=count-v1;
 System.out.println("Total OFF dp:"+offdp);
%>
<div class="bg-style">
<!--   <h1 class="p-3">Canvas circular progressbar </h1>
 -->  <div class="wrapper">
    <div class="row pt-5 pb-5">
  
  <div class="col-6 col-sm-3">
        <div class="counter" data-cp-percentage="<%=count%>" data-cp-color="#00bfeb">
        </div>
        <h4>Total DP</h4>
     </div>
  
  <div class="col-6 col-sm-3">
        <div class="counter" data-cp-percentage="<%=v1%>" data-cp-color="#EA4C89"></div>
        <h4>Total On DP</h4>
  </div>
 
  <div class="col-6 col-sm-3">
      <div class="counter" data-cp-percentage="<%=offdp%>" data-cp-color="#FF675B"></div>
      <h4>Total Off DP</h4>
    </div>
    </div>
  </div>
 
</div>
<p class="p-3">
</p>

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
