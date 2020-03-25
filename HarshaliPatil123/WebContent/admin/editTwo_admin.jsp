<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

	<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
	    
    <title>Delete Dp Recored</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="stylesheet" type="text/css" href="../css/main.css">

    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	
     <style>
	 
	#link
	{
	color: #009688;
	}
	
   </style>
</head>
<body class="app sidebar-mini">
	html {
 				 overflow-y: scroll;
				}
    <!-- Navbar-->
    <header class="app-header"><a class="app-header__logo" href="index.html">Aderate Solution</a>
     
    </header>
    <!-- Sidebar menu-->
    <div class="app-sidebar__overlay" data-toggle="sidebar"></div>
    <aside class="app-sidebar">
      <div class="app-sidebar__user"><img class="app-sidebar__user-avatar" src="images\profoundlogo.png" alt="User Image">
        <div>
          <p class="app-sidebar__user-name">Admin</p>
        </div>
      </div>
      
        <div class="vertical-menu">
       <ul class="app-menu">
      <%String admin_phone=request.getParameter("admin_phone");
        if(admin_phone !=null)
        {
      %>
        <li><a class="app-menu__item" href="dptable_admin.jsp?admin_phone=<%=request.getParameter("admin_phone")%>"><i class="app-menu__icon fa fa-laptop"></i><span class="app-menu__label">DP List</span></a>
       </li>
       
        <li><a class="app-menu__item" href="timeset_admin.jsp?admin_phone=<%=request.getParameter("admin_phone")%>"><i class="app-menu__icon fa fa-laptop"></i><span class="app-menu__label">Time Manager</span></a>
        </li>
      
         <li><a class="app-menu__item" href="admin_user_info1.jsp?admin_phone=<%=request.getParameter("admin_phone")%>"><i class="app-menu__icon fa fa-laptop"></i><span class="app-menu__label">User Manager</span></a>
       </li>
       
       <li ><a class="app-menu__item" href="onoff_admin.jsp?admin_phone=<%=request.getParameter("admin_phone") %>" ><i class="app-menu__icon fa fa-history" ></i><span class="app-menu__label">ON/OFF</span></a>
        </li>
        
        <li ><a class="app-menu__item" href="show_admin_notification.jsp?admin_phone=<%=request.getParameter("admin_phone")%>" ><i class="app-menu__icon fa fa-history" ></i><span class="app-menu__label">Show Notifications</span></a>
         </li>
        
         <li ><a class="app-menu__item" href="newadmin_notification_info.jsp?admin_phone=<%=request.getParameter("admin_phone") %>" ><i class="app-menu__icon fa fa-history" ></i><span class="app-menu__label">Notifications</span></a>
       </li>
       
       <li ><a class="app-menu__item" href="../homepage.jsp" ><i class="app-menu__icon fa fa-history" ></i><span class="app-menu__label">Logout</span></a>
        </li>
           <% }
        else{
        	RequestDispatcher rd=request.getRequestDispatcher("error2.jsp?admin_phone="+admin_phone);
        	 	rd.include(request, response);
        } %>      		            	
      </ul>
      </div>
      
         </aside>
    <main class="app-content">
      <div class="app-title">
      </div>
      <%@include file="db.jsp" %>
      
<% 


String name = request.getParameter("name");
//String dpid=request.getParameter("dpid");
String dpid1=request.getParameter("dpid1");
String dp_number=request.getParameter("dp_number");
String address=request.getParameter("address");
String phone=request.getParameter("phone");

int r_min=Integer.parseInt(request.getParameter("r_min"));
int y_min=Integer.parseInt(request.getParameter("y_min"));
int b_min=Integer.parseInt(request.getParameter("b_min"));
int r_max=Integer.parseInt(request.getParameter("r_max"));
int y_max=Integer.parseInt(request.getParameter("y_max"));
int b_max=Integer.parseInt(request.getParameter("b_max"));

if(dpid1!= null)
{
Connection con = null;
PreparedStatement ps = null;
//int personID = Integer.parseInt(dpid1);
try
{

con = DriverManager.getConnection(Url,Username,password);
String sql = "Update dp_info set name=?,dpid=?,dp_number=?,address=?,phone=?,r_min=?,r_max=?,y_min=?,y_max=?,b_min=?,b_max=? where dpid="+dpid1 ;
ps = con.prepareStatement(sql);
ps.setString(1, name);
ps.setString(2,dpid1);
ps.setString(3, dp_number);
ps.setString(4, address);
ps.setString(5, phone);
ps.setInt(6,r_min);
ps.setInt(7,r_max);
ps.setInt(8,y_min);
ps.setInt(9,y_max);
ps.setInt(10,b_min);
ps.setInt(11,b_max);
int i = ps.executeUpdate();
if(i > 0)
{
	RequestDispatcher rd=request.getRequestDispatcher("dptable_admin.jsp");
	 rd.forward(request, response);
}
else
{
	RequestDispatcher rd=request.getRequestDispatcher("error2.jsp?admin_phone="+admin_phone);
	 	rd.include(request, response);
}
String sql1 = "Update onephase set r_min=?,r_max=?,y_min=?,y_max=?,b_min=?,b_max=? where dpid="+dpid1;
PreparedStatement	ps1 = con.prepareStatement(sql1);
	ps1.setInt(1,r_min);
	ps1.setInt(2,r_max);
	ps1.setInt(3,y_min);
	ps1.setInt(4,y_max);
	ps1.setInt(5,b_min);
	ps1.setInt(6,b_max);
	int j = ps1.executeUpdate();
	
	if (j > 0) {
		
		System.out.println("Record Updated successfully");
	} else {
		RequestDispatcher rd=request.getRequestDispatcher("error2.jsp?admin_phone="+admin_phone);
	 	rd.include(request, response);
	}
}
catch(SQLException sql)
{
request.setAttribute("error", sql);
out.println(sql);
}
} else{
	RequestDispatcher rd=request.getRequestDispatcher("error2.jsp?admin_phone="+admin_phone);
	 	rd.include(request, response);
}
       
%>    
            
    </main>
    
    
    <!-- Essential javascripts for application to work-->
    <script src="/resources/js/jquery-3.3.1.min.js"></script>
    <script src="/resources/js/popper.min.js"></script>
    <script src="/resources/js/bootstrap.min.js"></script>
    <script src="/resources/js/main.js"></script>
    <!-- The javascript plugin to display page loading on top-->
    <script src="/resources/js/plugins/pace.min.js"></script>
    <!-- Page specific javascripts-->
    <script type="text/javascript" src="/resources/js/plugins/chart.js"></script>
    <script type="text/javascript">
      var data = {
      	labels: ["January", "February", "March", "April", "May"],
      	datasets: [
      		{
      			label: "My First dataset",
      			fillColor: "rgba(220,220,220,0.2)",
      			strokeColor: "rgba(220,220,220,1)",
      			pointColor: "rgba(220,220,220,1)",
      			pointStrokeColor: "#fff",
      			pointHighlightFill: "#fff",
      			pointHighlightStroke: "rgba(220,220,220,1)",
      			data: [65, 59, 80, 81, 56]
      		},
      		{
      			label: "My Second dataset",
      			fillColor: "rgba(151,187,205,0.2)",
      			strokeColor: "rgba(151,187,205,1)",
      			pointColor: "rgba(151,187,205,1)",
      			pointStrokeColor: "#fff",
      			pointHighlightFill: "#fff",
      			pointHighlightStroke: "rgba(151,187,205,1)",
      			data: [28, 48, 40, 19, 86]
      		}
      	]
      };
      var pdata = [
      	{
      		value: 300,
      		color: "#46BFBD",
      		highlight: "#5AD3D1",
      		label: "Complete"
      	},
      	{
      		value: 50,
      		color:"#F7464A",
      		highlight: "#FF5A5E",
      		label: "In-Progress"
      	}
      ]
      
      var ctxl = $("#lineChartDemo").get(0).getContext("2d");
      var lineChart = new Chart(ctxl).Line(data);
      
      var ctxp = $("#pieChartDemo").get(0).getContext("2d");
      var pieChart = new Chart(ctxp).Pie(pdata);
    </script>
    <!-- Google analytics script-->
    <script type="text/javascript">
      if(document.location.hostname == 'pratikborsadiya.in') {
      	(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
      	(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
      	m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
      	})(window,document,'script','//www.google-analytics.com/analytics.js','ga');
      	ga('create', 'UA-72504830-1', 'auto');
      	ga('send', 'pageview');
      }
    </script>
  </body>
</html>
