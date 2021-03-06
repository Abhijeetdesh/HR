<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>  
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.*"%>

<!DOCTYPE html>
<html oncontextmenu="return false">
<head>
<meta charset="UTF-8">
	<title>ON/OFF Manager</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<script src=https://code.jquery.com/jquery-3.3.1.js></script> 
   

    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="../css/style2.css">
<style type="text/css">
	
	.bb{
	width: 30%;
	}
	
	.b1{
	
	font-weight: bold;
	}
	
	.b2{
	
	font-weight: bold;
	color: red;
	}
	 
	.a{
	width: 5rem;
	float: left;

	
	}
	.b{
	width: 5rem;
	margin-left: 30px;
	}
	.c{
	width: 5rem;
	margin-left: 30px;
	}
.f{
 margin-left: 45px; 

}
.d{
margin-left: 66px;
}
	.e{
	margin-left: 70px;
	}
	.im{
	display: flex;
 	margin-left: -3rem;
 
	}
</style>	
 </head>

<body>
 <%@include file="sessioncache.jsp" %>
<div class="wrapper d-flex align-items-stretch">
<nav id="sidebar" class="active" >
 <a href="aderatesolutions.com" class="logo"> Aderate Tech Solutions</a>
       <ul class="list-unstyled components mb-5">
          <li >
            <a  href="dashboard.jsp"><span class="fa fa-home"></span>DashBoard</a>
          </li>
          <li>
              <a  href="dptable.jsp"><span class="fa fa-sliders"></span>DP List</a>
          </li>
            <li>
            <a  class="active" href="onoff.jsp"><span class="fa fa-toggle-on"></span>ON/OFF</a>
          </li>
           <li>
              <a href="timeset.jsp"><span class="fa fa-clock-o"></span> Time Manager</a>
          </li>
          <li>
          <li>
            <a href="admin_info.jsp"><span class="fa fa-users"></span> Admin Manager</a>
          </li>
          <li>
            <a href="user_info.jsp"><span class="fa fa-users"></span> User Manager</a>
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
	
	 <div class=" pull-right" style="margin-top:5px;">
   			<label>Search</label>
		          <input type='text' id='txt_searchall' placeholder='Search here...' >&nbsp; 
		          <input class="btn btn-outline-primary" type=button onClick="location.href='dptable.jsp'" value='Back'>
	</div>	
	   <div class="table " style="overflow:scroll; height: 540px;width:80%; margin-left: 10%; ">
		 	<table id="example"  class="display" style="table-layout: auto;width:100%;">
	        <thead>
		            <tr>
		               <th>DPID</th>
		               <th>DP_NO</th>
		              <th class="bb">ON/OFF</th>
		              
		            </tr>
		    </thead>
       <%@include file="db.jsp" %>
	<tbody>
    <%
	String query="SELECT * FROM dp_info";
    Connection con=DriverManager.getConnection(Url,Username,password);
	PreparedStatement ps=con.prepareStatement(query);
	ResultSet rs=ps.executeQuery();
    while(rs.next())
    {
	   String dpid=rs.getString("dpid");  
    %>
    <tr>
		<td><a class="btn btn-outline-primary b1"><%=rs.getString("dpid")%></a></td>
	    <td><a class="btn btn-outline-primary b2" ><%=rs.getString("dp_number") %></a></td>
 	    <td>
 		<%if(dpid !=null){
 		  Statement statement1 = null;
 		  ResultSet resultSet1 =null;
 		  try
 		  {
 		    con =DriverManager.getConnection(Url,Username,password);
 		    statement1=con.createStatement();
 		    String sql1="SELECT * FROM onephase where dpid="+dpid;
 		    resultSet1=statement1.executeQuery(sql1);
 		    while(resultSet1.next())
 		    {
 		        String r_current=resultSet1.getString("r_current");
 		        int r_curr=Integer.parseInt(r_current);
 		        int r_min=resultSet1.getInt("r_min");
 		        int r_max=resultSet1.getInt("r_max");
 		        if(r_curr>=r_min && r_curr<=r_max)
 		        {			 
 		 %>  
 		         <div class="im">
 		         <img class="card-img-top a" src="../images/ONbulb.jpg" alt="Card image cap"><br>
 		         </div>
 		         <form action="onoffdata_onephase_r.jsp" method="post">
 		         <button type="submit"class="btn btn-primary f">OFF</button>
 		         <input type="hidden" name="dpid" value="<%=resultSet1.getString("dpid")%>">
                 <input type="hidden" name="data" value="@R0" >
                 </form>
 		 <%
 		         }
 		        else
 		         {
 		 %>
 		         <div class="im">
 		         <img class="card-img-top a" src="../images/OFFbulb.jpg" alt="Card image cap"><br>
 		         </div>
 		         <form action="onoffdata_onephase_r.jsp" method="post">
 		         <button type="submit"class="btn btn-primary f">ON</button>
 		         <input type="hidden" name="dpid" value="<%=resultSet1.getString("dpid")%>">
                 <input type="hidden" name="data" value="@R1" >
                 </form>
 		 <%
 		          }
 		  %>
 		  <% 
 		          String y_current=resultSet1.getString("y_current");
 		          int y_curr=Integer.parseInt(y_current);
 		          int y_min=resultSet1.getInt("y_min");
 		          int y_max=resultSet1.getInt("y_max");
 		          if(y_curr>=y_min && y_curr<=y_max)
  		          {             
 		   %>
 		          <div class="im">
 		          <img class="card-img-top a" src="../images/ONbulb.jpg" alt="Card image cap"><br>
 		          </div>
 		          <form action="onoffdata_onephase_y.jsp" method="post">
 		          <button type="submit"class="btn btn-primary f">OFF</button>
 		          <input type="hidden" name="dpid" value="<%=resultSet1.getString("dpid")%>">
                  <input type="hidden" name="data" value="Y0" >
                  </form>
 		    <%
 		           }
 		           else
 		           {
 		     %>
 		           <div class="im">
 		           <img class="card-img-top a" src="../images/OFFbulb.jpg" alt="Card image cap"><br>
 		           </div>
 		           <form action="onoffdata_onephase_y.jsp" method="post">
 		           <button type="submit"class="btn btn-primary f">ON</button>
 		           <input type="hidden" name="dpid" value="<%=resultSet1.getString("dpid")%>">
                   <input type="hidden" name="data" value="Y1" >
                   </form>
 		     <%
 		            }
 		     %>
 		     <%
 		           String b_current=resultSet1.getString("b_current");
		           int b_curr=Integer.parseInt(b_current);
		           int b_min=resultSet1.getInt("b_min");
		           int b_max=resultSet1.getInt("b_max");
		           if(b_curr>=b_min && b_curr<=b_max)
		           { 
 		     %>
 		           <div class="im">
 		           <img class="card-img-top a" src="../images/ONbulb.jpg" alt="Card image cap"><br>
 		           </div>
 		           <form action="onoffdata_onephase_b.jsp" method="post">
 		           <button type="submit"class="btn btn-primary f">OFF</button>
 		           <input type="hidden" name="dpid" value="<%=resultSet1.getString("dpid")%>">
                   <input type="hidden" name="data" value="B0" >
                   </form>
 		     <%
 		           }
 		           else
 		           {
 		     %>
 		           <div class="im">
 		           <img class="card-img-top a" src="../images/OFFbulb.jpg" alt="Card image cap"><br>
 		           </div>
 		           <form action="onoffdata_onephase_b.jsp" method="post">
 		           <button type="submit"class="btn btn-primary f">ON</button>
 		           <input type="hidden" name="dpid" value="<%=resultSet1.getString("dpid")%>">
                   <input type="hidden" name="data" value="B1" >
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
 		  else{
 			 RequestDispatcher rd=request.getRequestDispatcher("error.jsp");
 		   	rd.forward(request, response);
 		  }
		    }      
 	  %>     		     
		</table>
		
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
	
	 <script type="text/javascript">
            function setButton(value) {
            	localStorage.setItem("buttonID", value);
            }
            if (localStorage.buttonID) {
                document.getElementById(localStorage.buttonID).style.backgroundColor = "GREEN";
                B1.setAttribute("disabled", true);
                window.location.href="onofftoggledatasend.jsp";
            }
            
           /*  function my(){
            	window.location.href="newonofftoggle.jsp";
            } */
     </script>
            
     <script src="../js/jquery.min.js"></script>
    <script src="../js/popper.js"></script>
    <script src="../js/bootstrap.min.js"></script>
    <script src="../js/main.js"></script>
 	     <%@include file="footer.jsp" %>
  
  </body>
</html>
