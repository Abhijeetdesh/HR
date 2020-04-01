<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    
<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="css/user.css">
</head>

<body>
   
   <div class="container">
        <div class="img"> 
       
        <div id="group_158"  >
            <img src="skins/path_145.png" id="path_145" />
            <img src="skins/path_146.png" id="path_146" />
            <img src="skins/path_8.png" id="path_8" />

        </div>
        <div id="Aderate">
            <span>Aderate</span>
        </div>
        <div id="Tech_Solution">
            <span>Tech Solution</span>
        </div>
    </div>
       <div class="login-container">
        <div id="first">
<form action="admin/admin_login.jsp" method="post">
    <h2>Admin Login</h2>
    <div class="input-div one ">
          <div class="i">
          </div>
    
          <div>
          <input type="text" class="input" name="admin_email" placeholder="Username">
          </div>
    </div>
   
    <div class="input-div two " >
          <div class="i">
          </div>
       
          <div>
            <input type="password" class="input"  name="admin_password" placeholder="Password">
         </div>
   </div>
            
     <input type="submit" class="btn" value="Login">
         <div class="form-group">
                <p class="text-center"><a href="user.jsp" id="signin">User</a></p>
         </div>
</form>
      
      </div>
    </div>
</div>
   <script type="text/javascript" src="js/superadmin.js"></script>
</body>
</html>