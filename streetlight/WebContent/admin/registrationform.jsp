<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html oncontextmenu="return false">
<head>
<%response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires",300);
    int timeout = session.getMaxInactiveInterval();
    response.setHeader("Refresh", timeout + "; URL = ../admin.jsp");%>

<%String u = (String) request.getSession().getAttribute("admin_email");
    if (u != null ) {
        
    }else{
        response.sendRedirect("../admin.jsp");
    }%>
<meta charset="UTF-8">
<%@include file="db.jsp" %>

	<meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Add DP Recored</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="../css/style2.css">
</head>
<body>

<div class="wrapper d-flex align-items-stretch">
      <nav id="sidebar" class="active">
	    <a href="index.html" class="logo"><img src="images/logo.jpg" style="width: 25px;height: 25px;" ><br> AdeRate Solution</a>
          <ul class="list-unstyled components mb-5">
           <li>
              <a href="dashboard_admin.jsp?admin_phone=<%=request.getParameter("admin_phone")%>"><span class="fa fa-sliders"></span>Dashboard</a>
          </li>
          <li>
              <a class="active" href="dptable_admin.jsp?admin_phone=<%=request.getParameter("admin_phone")%>"><span class="fa fa-sliders"></span> DP List</a>
          </li>
          <li>
            <a href="onoff_admin.jsp?admin_phone=<%=request.getParameter("admin_phone") %>" ><span class="fa fa-toggle-on"></span> ON/OFF</a>
          </li>
          
           <li>
              <a  href="timeset_admin.jsp?admin_phone=<%=request.getParameter("admin_phone")%>"><span class="fa fa-clock-o"></span> Time Manager</a>
          </li>
          <li>
          <li>
            <a href="admin_user_info1.jsp?admin_phone=<%=request.getParameter("admin_phone")%>"><span class="fa fa-users"></span> User Manager</a>
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
   			     <input class="btn btn-outline-primary" type=button onClick="location.href='dptable_admin.jsp?admin_phone=<%=request.getParameter("admin_phone")%>'" value='Back'>
		      </div>  
         <div class="my" >		
      
				<form name="form1" method="post" action="DataBaseConnection_admin.jsp">
				  <div class="form-group">
                    <label class="col-form-label col-form-label-sm" for="inputSmall">Name::</label>
                    <input class="form-control" name="name" type="text" required placeholder="Name"/>
                   </div>
             
                 <div class="form-group">
                    <label class="col-form-label col-form-label-sm" for="inputSmall">DP Id::</label>
                    <input class="form-control" name="dpid" type="text" onkeyup="checkExist()" placeholder="Dp-Id">
                     <span id="isE"></span>
                  </div>
                  
                   <div class="form-group">
                    <label class="col-form-label col-form-label-sm" for="inputSmall">DP-Number::</label>
                    <input class="form-control" name="dp_number" type="text" placeholder="Dp-Number">
                  </div>
                  
                   <div class="form-group">
                    <label class="col-form-label col-form-label-sm" for="inputSmall">Address::</label>
                    <input class="form-control" name="address" type="text" placeholder="Address">
                  </div>
                  <div class="form-group">
                    <label class="col-form-label col-form-label-sm" for="inputSmall">Phone Number::</label>
                    <input class="form-control" name="phone" type="text" onkeyup="checkExist1()" placeholder="Phone Number">
                    <span id="isEF"></span>
                  </div>
                  
                   <!-- <div class="form-group">
                    <label class="col-form-label col-form-label-sm" for="inputSmall"> Admin Phone Number::</label> --> 
                    <input class="form-control" name="admin_phone" type="hidden" value="<%=request.getParameter("admin_phone")%>">
                   <!-- </div>  -->
                  
                 <div class="form-group">
                    <label for="exampleInputPassword1">R_Current Tolerance::</label><br>
                    <label for="exampleInputPassword1">R_Max</label>
                   <input type="text" class="form-control" name="r_max" required>
                   <label for="exampleInputPassword1">R_Min</label>
                    <input type="text" class="form-control" name="r_min" required>
                  </div>
                  <div class="form-group">
                    <label for="exampleInputPassword1">Y_Current Tolerance::</label><br>
                    <label for="exampleInputPassword1">Y_Max</label>
                    <input type="text" class="form-control" name="y_max"required >
                    <label for="exampleInputPassword1">Y_Min</label>
                    <input type="text" class="form-control" name="y_min" required>
                  </div>
                  <div class="form-group">
                    <label for="exampleInputPassword1">B_Current Tolerance::</label><br>
                    <label for="exampleInputPassword1">B_Max</label>
                    <input type="text" class="form-control" name="b_max" required >
                    <label for="exampleInputPassword1">B_Min</label>
                   <input type="text" class="form-control" name="b_min" required>
                  </div>
                  
                  
                  
              
            
       <button class="btn btn-primary" type="button" onclick = "functionAlert();" style="margin-left: 30%"><i class="fa fa-fw fa-lg fa-check-circle"></i>Add</button>
		   <div id = "confirm">
	         <div class = "message">Do you Want To Add?</div>
	         <button type="submit"  class = "yes">OK</button>
	         <button type="button" class="yes"  style="background: red">Cancel</button>
	       </div>     
			</form>
		 </div>
     </div>
 </div>


    <% String message = (String)request.getAttribute("alertMsg");
       if(message !=null){
    %>
     
     <script type="text/javascript">
    var msg = "<%=message%>";
    alert(msg);
</script>
   <%} %>
    	 <script>
         function functionAlert(msg, myYes) 
         {
            var confirmBox = $("#confirm");
            confirmBox.find(".message").text(msg);
            confirmBox.find(".yes").unbind().click(function() {
               confirmBox.hide();
            });
            confirmBox.find(".yes").click(myYes);
            confirmBox.show();
         }
     </script>  
	   
    <script src="../js/jquery.min.js"></script>
    <script src="../js/popper.js"></script>
    <script src="../js/bootstrap.min.js"></script>
    <script src="../js/main.js"></script>
    <script src="../js/file.js"></script>
         <%@include file="footer.jsp" %>

 </body>
</html>
