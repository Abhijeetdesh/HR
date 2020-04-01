<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page import="java.sql.*" 
    import="java.util.ArrayList"
import="java.util.List"  %>
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
<style type="text/css">
		
	.f{
 margin-left: 75px; 

}
 </style>	
 </head>

<body>
<div class="wrapper d-flex align-items-stretch">
<nav id="sidebar" class="active" >
 <a href="aderatesolutions.com" class="logo"> Aderate Tech Solutions</a>
        <ul class="list-unstyled components mb-5">
           
           <li ><a class="app-menu__item" href="dashboard_user.jsp?user_phone=<%=request.getParameter("user_phone")%>" ><span class="fa fa-home"></span>Dashboard</a>
           </li>
          
           <li ><a class="app-menu__item" href="userdplist_user.jsp?dpid=<%=request.getParameter("dpid")%>&admin_phone=<%=request.getParameter("admin_phone")%>&user_phone=<%=request.getParameter("user_phone")%>" ><span class="fa fa-info-circle"></span> User Details</a>
           </li>
            
          <li ><a class="active" class="app-menu__item" href="onoff_user.jsp?dpid=<%=request.getParameter("dpid")%>&admin_phone=<%=request.getParameter("admin_phone")%>&user_phone=<%=request.getParameter("user_phone")%>" ><span class="fa fa-toggle-on"></span>ON/OFF</a>
          </li>
       
         <li ><a class="app-menu__item" href="timeset_user.jsp?dpid=<%=request.getParameter("dpid")%>&admin_phone=<%=request.getParameter("admin_phone")%>&user_phone=<%=request.getParameter("user_phone")%>" ><span class="fa fa-clock-o"></span>Time Manager</a>
         </li>
        
        <li ><a class="app-menu__item" href="show_user_notification.jsp?admin_phone=<%=request.getParameter("admin_phone")%>&user_phone=<%=request.getParameter("user_phone")%>" ><span class="fa fa-bell"></span>Show Notifications</a>
        </li> 
        
       <li ><a class="app-menu__item" href="show_myuser_notification.jsp?admin_phone=<%=request.getParameter("admin_phone")%>&user_phone=<%=request.getParameter("user_phone")%>" ><span class="fa fa-bell"></span>Show My Notifications</a>
        </li>  
         
         <li ><a class="app-menu__item" href="logout.jsp" ><span class="fa fa-power-off"></span>Logout</a>
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
    <div class=" pull-right" style="margin-top:5px;">
      <label>Search</label>
		      <input type='text' id='txt_searchall' placeholder='Search here...' >&nbsp; 
		      <input class="btn btn-outline-primary" type=button onClick="location.href='userdplist_user.jsp?user_phone=<%=request.getParameter("user_phone")%>&admin_phone=<%=request.getParameter("admin_phone")%>&dpid=<%=request.getParameter("dpid")%>'" value='Back'>
		         
	</div>
       		
     <div class="table " style="overflow:scroll; height: 540px;width:98%; margin-left: 1%; ">
	  <table id="example"  class="display" style="table-layout: auto;width:100%;">
        <thead>
            <tr>
              
              <th>DPID</th>
              <th>DP_NO</th>
              <th>ON/OFF</th>   
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
           <td><a class="btn btn-outline-primary b1"><%=rs.getString("dpid")%></a></td>
           <td><a class="btn btn-outline-primary b1"><%=rs.getString("dp_number")%></a></td>
 		   <td id="line" style="display:flex;">
    <%
 	Statement statement3 = null;
    ResultSet resultSet3 =null;
    String aphone=request.getParameter("admin_phone");
    try
    {
 		con =DriverManager.getConnection(Url,Username,password);
        statement3=con.createStatement();
 		String sql3="SELECT * FROM onephase where dpid="+n;
 		resultSet3=statement3.executeQuery(sql3);
 		while(resultSet3.next())
 		{
 		   String r_current=resultSet3.getString("r_current");
 		   int r_curr=Integer.parseInt(r_current);
 		   int r_min=resultSet3.getInt("r_min");
 		   int r_max=resultSet3.getInt("r_max");
 		   if(r_curr>=r_min && r_curr<=r_max)
 		    {			 
    %>  
 		 <div class="im">
 		 <img class="card-img-top a" src="../images/ONbulb.jpg" alt="Card image cap"><br>
 		 </div>
 		   <form action="onoffdata_user_onephase_r.jsp" method="post">
 		   <button type="submit"class="btn btn-primary f">OFF</button>
 		   <input type="hidden" name="dpid" value="<%=resultSet3.getString("dpid")%>">
           <input type="hidden" name="data" value="@R0" >
           <input type="hidden" name="admin_phone" value="<%=aphone%>">
           <input type="hidden" name="dpid1" value="<%=dpid1%>">
           <input type="hidden" name="user_phone" value=<%=request.getParameter("user_phone") %>>
           
         </form>
    <%
 		    }
 		    else
 		     {
 	%>
 		 <div class="im">
 		 <img class="card-img-top a" src="../images/OFFbulb.jpg" alt="Card image cap"><br>
 		 </div>
           <form action="onoffdata_user_onephase_r.jsp" method="post">
 		   <button type="submit"class="btn btn-primary f">ON</button>
 		   <input type="hidden" name="dpid" value="<%=resultSet3.getString("dpid")%>">
           <input type="hidden" name="data" value="@R1" >
           <input type="hidden" name="admin_phone" value="<%=aphone%>">
            <input type="hidden" name="dpid1" value="<%=dpid1%>">
           <input type="hidden" name="user_phone" value=<%=request.getParameter("user_phone") %>>
            
          </form>
   <%
 		     }
   %>
   <% 
 		    String y_current=resultSet3.getString("y_current");
 		    int y_curr=Integer.parseInt(y_current);
 		    int y_min=resultSet3.getInt("y_min");
 		    int y_max=resultSet3.getInt("y_max");
 		    if(y_curr>=y_min && y_curr<=y_max)
  		    {             
    %>
 		    <div class="im">
 		    <img class="card-img-top a" src="../images/ONbulb.jpg" alt="Card image cap"><br>
 		    </div>
 		    <form action="onoffdata_user_onephase_y.jsp" method="post">
 		    <button type="submit"class="btn btn-primary f">OFF</button>
 		    <input type="hidden" name="dpid" value="<%=resultSet3.getString("dpid")%>">
            <input type="hidden" name="data" value="Y0" >
            <input type="hidden" name="admin_phone" value="<%=aphone%>">
            <input type="hidden" name="dpid1" value="<%=dpid1%>">
            <input type="hidden" name="user_phone" value=<%=request.getParameter("user_phone") %>>
            </form>
     <%
 		      }
 		     else
 		     {
      %>
 		     <div class="im">
 		     <img class="card-img-top a" src="../images/OFFbulb.jpg" alt="Card image cap"><br>
 		     </div>
 		     <form action="onoffdata_user_onephase_y.jsp" method="post">
 		     <button type="submit"class="btn btn-primary f">ON</button>
 		      <input type="hidden" name="dpid" value="<%=resultSet3.getString("dpid")%>">
             <input type="hidden" name="data" value="Y1" >
              <input type="hidden" name="admin_phone" value="<%=aphone%>">
            <input type="hidden" name="dpid1" value="<%=dpid1%>">
            <input type="hidden" name="user_phone" value=<%=request.getParameter("user_phone") %>>
             </form>
 	 <%
 		      }
 	 %>
 	 <%
 		     String b_current=resultSet3.getString("b_current");
		     int b_curr=Integer.parseInt(b_current);
		     int b_min=resultSet3.getInt("b_min");
		     int b_max=resultSet3.getInt("b_max");
		     if(b_curr>=b_min && b_curr<=b_max)
		     { 
      %>
 		      <div class="im">
 		      <img class="card-img-top a" src="../images/ONbulb.jpg" alt="Card image cap"><br>
 		      </div>
 		      <form action="onoffdata_user_onephase_b.jsp" method="post">
 		      <button type="submit"class="btn btn-primary f"> OFF</button>
 		      <input type="hidden" name="dpid" value="<%=resultSet3.getString("dpid")%>">
             <input type="hidden" name="data" value="B0" >
              <input type="hidden" name="admin_phone" value="<%=aphone%>">
             <input type="hidden" name="dpid1" value="<%=dpid1%>">
            <input type="hidden" name="user_phone" value=<%=request.getParameter("user_phone") %>>
             </form>
      <%
 		      }
 		      else
 		      {
 	   %>
 		      <div class="im">
 		      <img class="card-img-top a" src="../images/OFFbulb.jpg" alt="Card image cap"><br>
 		      </div>
 		      <form action="onoffdata_user_onephase_b.jsp" method="post">
 		      <button type="submit"class="btn btn-primary f"> ON</button>
 		      <input type="hidden" name="dpid" value="<%=resultSet3.getString("dpid")%>">
               <input type="hidden" name="data" value="B1" >
             <input type="hidden" name="admin_phone" value="<%=aphone%>">
             <input type="hidden" name="dpid1" value="<%=dpid1%>">
              <input type="hidden" name="user_phone" value=<%=request.getParameter("user_phone") %>>
             </form>
 		<%
 		       }
 		%>
 		      </td>
 		 
 		 </tr>
          
        </tbody>
      <%
		    }
 		   }
 		  catch (Exception e) 
 		   {
 		      e.printStackTrace();
 		   }
 		    
 	   }
  }
}
connection.close();
} 
catch (Exception e) {
e.printStackTrace();
}
}
else{
	   RequestDispatcher rd=request.getRequestDispatcher("error.jsp");
		rd.include(request, response);
	}  			


 
%>
          </table>
      	</div>
      </div>	
	</div>
</div>    
   
    
     <script>
          
            function selectRow(){
            	var index,
            	     table=document.getElementById("myTable");
            	for(var i=1;i<table.rows.length;i++)
            		{
            		   table.rows[i].onclick=function()
            		   {
            			   if(typeof index !== "undefined")
            				   {
            				    table.rows[index].classList.toggle("selected");
            				    }
            			   console.log(typeof index);
            			   index=this.rowIndex;
            			   this.classList.toggle("selected");
            			   console.log(typeof index);
            		   }
            		}
            }selectRow();
        </script>
          
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
