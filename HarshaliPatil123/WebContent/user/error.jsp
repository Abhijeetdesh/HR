<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
	th,td{
	width: 20%;
	text-align: center;
	
	}
	
	.b1{
	width: 9rem;
	font-weight: bold;
	}
	
	.b2{
	width: 9rem;
	font-weight: bold;
	color: red;
	}
	</style>		 
 </head>

<body>
<div class="wrapper d-flex align-items-stretch">
			<nav id="sidebar" class="active" >
					<a href="index.html" class="logo"><img src="images/logo.jpg" style="width: 25px;height: 25px;" ><br> AdeRate Solution</a>
        <ul class="list-unstyled components mb-5">
        
          
        <li ><a  href="userdplist_user.jsp?dpid=<%=request.getParameter("dpid")%>&admin_phone=<%=request.getParameter("admin_phone")%>" ><span class="fa fa-info-circle"></span>User Details</a>
           </li>
           
          <li ><a  href="timeset_user.jsp?dpid=<%=request.getParameter("dpid")%>&admin_phone=<%=request.getParameter("admin_phone")%>" ><span class="fa fa-clock-o"></span>Time Manager</a>
        </li>
        
        <li ><a  class="active"  href="onoff_user.jsp?dpid=<%=request.getParameter("dpid")%>&admin_phone=<%=request.getParameter("admin_phone")%>" ><span class="fa fa-toggle-on"></span>ON/OFF</a>
        </li>
        
        <li ><a  href="show_user_notification.jsp?admin_phone=<%=request.getParameter("admin_phone")%>" ><span class="fa fa-bell"></span>Show Notifications</a>
        </li> 
        
       <li ><a  href="show_myuser_notification.jsp?admin_phone=<%=request.getParameter("admin_phone") %>" ><span class="fa fa-bell"></span>Show My Notifications</a>
        </li>      
            
        <li ><a  href="../homepage.jsp" ><span class="fa fa-power-off"></span>Logout</a>
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
	th,td{
	width: 20%;
	text-align: center;
	
	}
	
	.b1{
	width: 9rem;
	font-weight: bold;
	}
	
	.b2{
	width: 9rem;
	font-weight: bold;
	color: red;
	}
	</style>		 
 </head>

<body>
<div class="wrapper d-flex align-items-stretch">
			<nav id="sidebar" class="active" >
					<a href="index.html" class="logo"><img src="images/logo.jpg" style="width: 25px;height: 25px;" ><br> AdeRate Solution</a>
        <ul class="list-unstyled components mb-5">
        
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
           <div class=" pull-right" style="margin-top:5px;">
   			<input class="btn btn-outline-primary" type=button onClick="location.href='../homepage.jsp'" value='Back'>
		      </div>
		      
		      <center><h3><br>Oop's something wrong...Please try again</h3></center>
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
 	<footer class="footer" >
	   		<div class="footer-copyright" style="width: 100%;">
	        <p class="footer-company">All Rights Reserved. &copy; 2020 <a href="https://wss.mahadiscom.in/wss/wss" target="blank">MAHARASHTRA STATE ELECTRICITY BOARD</a> Design By :
	            <a  href="https://aderatesolutions.com/" target="blank"> AdeRate Tech Solutions</a></p>
	    	</div>
	</footer>   
    
    
  </body>
</html>


</body>
</html>