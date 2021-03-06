<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
 <%@include file="sessioncache.jsp" %>
   <div class="wrapper d-flex align-items-stretch">
			<nav id="sidebar" class="active" >
					<a href="index.html" class="logo"><img src="images/logo.jpg" style="width: 25px;height: 25px;" ><br> AdeRate Solution</a>
        <ul class="list-unstyled components mb-5">
  
          <li>
              <a href="dashboard_admin.jsp?admin_phone=<%=request.getParameter("admin_phone")%>"><span class="fa fa-sliders"></span>Dashboard</a>
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
            
           
          </div>
        </nav>
        
      <div class=" pull-right" style="margin-top:5px;">
   			<label>Search</label>
		          <input type='text' id='txt_searchall' placeholder='Search here...' >&nbsp;
		           <input class="btn btn-outline-primary p-1 mr-5" type="submit" onClick="location.href='user_registration_admin.jsp?admin_phone=<%=request.getParameter("admin_phone") %>'" value='Add user'> 
		         
		      </div>
       		
     	 	<div class="table" style="overflow:scroll; height: 350px;width:98%; margin-left: 10px; margin-top: 100px; ">
		 	<table id="example"  class="display" style="table-layout: auto;width:100%;">
        <thead>
            <tr>
             <th>Name</th>
             <th>Email</th>
             <th>Mobile</th>
             <th>Password</th>
             <th>DpId</th>
             <th>Status</th>  
             <th>Update</th>
             <th>Delete</th>
             <th>Active/Block</th>    
             <th>Details</th>                
           </tr>
        </thead>
       <tbody>
             <%@include file="db.jsp" %>
       
       <%
       
          Connection con=DriverManager.getConnection(Url,Username,password);
          String aphone=request.getParameter("admin_phone");
          if(aphone != null)
          {
          PreparedStatement ps=con.prepareStatement("select * from user where admin_phone='" + aphone + "'");
          ResultSet rs=ps.executeQuery();
          while(rs.next())
          {
       %>
          <tr>
            <td><%=rs.getString("user_name")%></td>
            <td><%=rs.getString("user_email")%></td>
            <td><%= rs.getString("user_phone") %></td>
            <td><%= rs.getString("user_password")%></td>
            <td><%= rs.getString("dpid")%></td>
            <td><%= rs.getString("status")%></td>
            <td><a href="user_edit_admin.jsp?user_phone=<%=rs.getString("user_phone")%>&admin_phone=<%=rs.getString("admin_phone")%>">Edit</a></td>
            <td><a href="user_admin_record_delete1.jsp?user_phone=<%=rs.getString("user_phone")%>&admin_phone=<%=rs.getString("admin_phone")%>">Delete</a></td>
            <td><a href="active_block_user_admin.jsp?user_phone=<%=rs.getString("user_phone")%>&admin_phone=<%=rs.getString("admin_phone")%>">Active/Block</a></td>
            <td><a href="userdplist_admin.jsp?dpid=<%=rs.getString("dpid")%>&admin_phone=<%=rs.getString("admin_phone")%>">DP data</a></td>
         </tr>
     <%
         }
       }
       else{
    	   RequestDispatcher rd=request.getRequestDispatcher("error.jsp");
		    	rd.forward(request, response);
       }
      %>
        </tbody>

       
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
