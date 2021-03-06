<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page import="java.sql.*" 
    import="java.util.ArrayList"
import="java.util.List"  %>
<%@include file="sessioncacheuser.jsp" %>
<!DOCTYPE html>
<html oncontextmenu="return false">
<head>
<meta charset="UTF-8">
	<title>DP LIST</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<script src=https://code.jquery.com/jquery-3.3.1.js></script> 
   

    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
		
			<link rel="stylesheet" href="../css/style2.css">
	
 </head>

<body>
 
<%@include file="db.jsp" %>
    <div class="wrapper d-flex align-items-stretch">
			<nav id="sidebar" class="active" >
	<a href="index.html" class="logo"><img src="images/logo.jpg" style="width: 25px;height: 25px;" ><br> AdeRate Solution</a>     
	   <ul class="list-unstyled components mb-5">
        
        <li><a  href="dashboard_user.jsp?admin_phone=<%=request.getParameter("admin_phone")%>" ><span class="fa fa-info-circle"></span>Dashboard</a>
        </li>
        
        <li ><a class="active" href="userdplist_user.jsp?dpid=<%=request.getParameter("dpid")%>&admin_phone=<%=request.getParameter("admin_phone")%>" ><span class="fa fa-info-circle"></span>User Details</a>
        </li>
        
        <li ><a  href="onoff_user.jsp?dpid=<%=request.getParameter("dpid")%>&admin_phone=<%=request.getParameter("admin_phone")%>" ><span class="fa fa-toggle-on"></span>ON/OFF</a>
        </li>
           
        <li><a  href="timeset_user.jsp?dpid=<%=request.getParameter("dpid")%>&admin_phone=<%=request.getParameter("admin_phone")%>" ><span class="fa fa-clock-o"></span>Time Manager</a>
        </li>
        
        <li ><a  href="show_user_notification.jsp?admin_phone=<%=request.getParameter("admin_phone")%>" ><span class="fa fa-bell"></span>Show Notifications</a>
        </li> 
        
       <li ><a  href="show_myuser_notification.jsp?admin_phone=<%=request.getParameter("admin_phone") %>" ><span class="fa fa-bell"></span>Show My Notifications</a>
        </li>      
            
        <li ><a  href="logout.jsp" ><span class="fa fa-power-off"></span>Logout</a>
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
        
     
   
  	 <div class=" pull-right" style="margin-top:5px;">
   			<label>Search</label>
		          <input type='text' id='txt_searchall' placeholder='Search here...' >&nbsp;       
	</div> 
       		
      	
<%-- <%
       /***** Post Parameters From The Request *****/
       String param1 = request.getParameter("dpid");
       if (param1 != null && !param1.equals("")) {

           int timeout =300;
           HttpSession sessionObj = request.getSession(true);

          
           /***** Setting The Updated Session Time Out *****/
           sessionObj.setMaxInactiveInterval(timeout);
           
           /***** Once The Time Out Is Reached. This Line Will Automatically Refresh The Page *****/
           response.setHeader("Refresh", timeout + "; URL=../homepage.jsp");
       } else {
           //out.println("<p id='errMsg' style='color: red; font-size: larger; margin-left: 564px'>Please Enter a Correct Name!</p>");
           RequestDispatcher rdObj = request.getRequestDispatcher("../homepage.jsp");
           rdObj.include(request, response);
       }
 --%>
       %>
      
<%  

Connection connection = null;
Statement statement = null;
Statement statement1 = null;
ResultSet resultSet = null;
ResultSet resultSet1 = null;
String dpid1=request.getParameter("dpid");
System.out.println(dpid1);

%>
<%
if(dpid1 != null){
try{
connection = DriverManager.getConnection(Url,Username,password);
statement=connection.createStatement();
statement1=connection.createStatement();
String sql ="select dpid from dp_info";
resultSet = statement.executeQuery(sql);
ArrayList<String> idlist = new ArrayList<>();
String sql1="select dpid from user where dpid='"+dpid1+"'";
resultSet1 = statement1.executeQuery(sql1);
if(resultSet1.next()){
	 String str=resultSet1.getString("dpid");
 
	 String[] words=str.split(",");//splits the string based on whitespace  
	 List<String> itemList = new ArrayList<String>();
	 for (String w : words) {
	    itemList.add(w);
	 }
	  
while(resultSet.next()){
	 String id=resultSet.getString("dpid");
	 idlist.add(id);
	 //System.out.println("dpid list from dp_info"+idlist);
	
}
//Find the common elements 
idlist.retainAll(itemList); 
%>
<div class="table" style="overflow:scroll; height: 350px;width:98%; margin-left: 10px; margin-top: 100px; ">
	<table id="example"  class="display" style="table-layout: auto;width:100%;"> 
		    <thead >
            <tr >
              <th>Name</th>
              <th>DPID</th>
              <th>DP_No</th>
              <th>Address</th>
              <th>Phone</th>
              <th>Details</th>     
            </tr>
        </thead>
        <%for (String n : idlist)
        {
            Connection con=DriverManager.getConnection(Url,Username,password);
            PreparedStatement ps=con.prepareStatement("select * from dp_info where dpid="+(n));
            ResultSet rs=ps.executeQuery();
           while(rs.next())
           {
	     %>
         <tbody>
             
               <tr>
                  <td><%=rs.getString("name")%></td>
                  <td><%=rs.getString("dpid")%></td>
                  <td><%= rs.getString("dp_number") %></td>
                  <td><%= rs.getString("address") %></td>
                  <td><%= rs.getString("phone") %></td>
                  <td><a href="user_dpdetails_user.jsp?dpid=<%=rs.getString("dpid")%>&admin_phone=<%=request.getParameter("admin_phone")%>">Details</a></td>
             </tr>
          
        </tbody>
        
<%
             }
        }
     }
   connection.close();
} 
catch (Exception e) {
e.printStackTrace();
}
}
else
{
	 RequestDispatcher rd=request.getRequestDispatcher("error.jsp");
		rd.include(request, response);
}
%>
        
      
      		</table>
		</div>
	</div>
</div>
      

     <script type="text/javascript">
    
    $(document).ready(function(){

  	  // Search all columns
  	  $('#txt_searchall').keyup(function(){
  	    // Search Text
  	    var search = $(this).val();

  	    // Hide all table tbody rows
  	    $('table tbody tr').hide();

  	    // Count total search result
  	    var len = $('table tbody tr:not(.notfound) td:contains("'+search+'")').length;

  	    if(len > 0){
  	      // Searching text in columns and show match row
  	      $('table tbody tr:not(.notfound) td:contains("'+search+'")').each(function(){
  	        $(this).closest('tr').show();
  	      });
  	    }else{
  	      $('.notfound').show();
  	    }

  	  });

  	 

  	});

  	// Case-insensitive searching (Note - remove the below script for Case sensitive search )
  	
</script>
     <script src="../js/jquery.min.js"></script>
    <script src="../js/popper.js"></script>
    <script src="../js/bootstrap.min.js"></script>
    <script src="../js/main.js"></script>
 	     <%@include file="footer.jsp" %>

  </body>
</html>
