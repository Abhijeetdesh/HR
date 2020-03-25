<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<html>
<head>
<meta charset="UTF-8">

	<meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Delete DP Recored</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="../css/style2.css">
</head>
<body >
	<div class="wrapper d-flex align-items-stretch">
			<nav id="sidebar" class="active">
				<a href="index.html" class="logo"><img src="images/logo.jpg" style="width: 25px;height: 25px;" ><br> AdeRate Solution</a>
       <ul class="list-unstyled components mb-5">
          <li >
            <a  href="dashboard.jsp"><span class="fa fa-home"></span>DashBoard</a>
          </li>
          <li>
              <a href="dptable.jsp"><span class="fa fa-sliders"></span>DP List</a>
          </li>
            <li>
            <a href="onoff.jsp"><span class="fa fa-toggle-on"></span>ON/OFF</a>
          </li>
           <li>
              <a href="timeset.jsp"><span class="fa fa-clock-o"></span> Time Manager</a>
          </li>
          <li>
          <li>
            <a href="admin_info.jsp"><span class="fa fa-users"></span> Admin Manager</a>
          </li>
          <li>
            <a class="active" href="user_info.jsp"><span class="fa fa-users"></span> User Manager</a>
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
   					<input class="btn btn-outline-primary" type=button onClick="location.href='user_info.jsp'" value='Back'>
		      </div>
		      
<%!
private static SecretKeySpec secretKey;
 private static byte[] key;

 public static void setKey(String myKey) 
{
    MessageDigest sha = null;
    try {
        key = myKey.getBytes("UTF-8");
        sha = MessageDigest.getInstance("SHA-1");
        key = sha.digest(key);
        key = Arrays.copyOf(key, 16); 
        secretKey = new SecretKeySpec(key, "AES");
    } 
    catch (NoSuchAlgorithmException e) {
        e.printStackTrace();
    } 
    catch (UnsupportedEncodingException e) {
        e.printStackTrace();
    }
}
%>
<%! 
 public static String encrypt(String strToEncrypt, String secret) 
{
    try
    {
        setKey(secret);
        Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5Padding");
        cipher.init(Cipher.ENCRYPT_MODE, secretKey);
        return Base64.getEncoder().encodeToString(cipher.doFinal(strToEncrypt.getBytes("UTF-8")));
    } 
    catch (Exception e) 
    {
        System.out.println("Error while encrypting: " + e.toString());
    }
    return null;
}
%>
<%! 
 public static String decrypt(String strToDecrypt, String secret) 
{
    try
    {
        setKey(secret);
        Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5PADDING");
        cipher.init(Cipher.DECRYPT_MODE, secretKey);
        return new String(cipher.doFinal(Base64.getDecoder().decode(strToDecrypt)));
    } 
    catch (Exception e) 
    {
        System.out.println("Error while decrypting: " + e.toString());
    }
    return null;
}

%>
         <%@include file="db.jsp" %>      
<%
String user_phone = request.getParameter("user_phone");

Connection connection = null;
Statement statement = null;
ResultSet resultSet = null;
%>
<%
if (user_phone!= null) {
try{
connection = DriverManager.getConnection(Url,Username,password);
statement=connection.createStatement();
String sql ="select * from user where user_phone="+user_phone;
resultSet = statement.executeQuery(sql);
while(resultSet.next()){
	String one=resultSet.getString("user_password");
	final String secretKey = "ssshhhhhhhhhhh!!!!";

	//String originalString = adminepassword;
	String encryptedString = one;
	String decryptedString = AES.decrypt(encryptedString, secretKey) ;
%>
		<div class="my" >
             
             <form name="form1" method="post" action="user_record_delete.jsp">
						
		       <div class="form-group">
               <label for="exampleInputEmail1">Name::</label>
               <input class="form-control" id="u_name" name="user_name" type="text" value="<%=resultSet.getString("user_name")%>" disabled="disabled"/>
              </div>
	
	           <div class="form-group">
               <label for="exampleInputEmail1">Email::</label>
               <input class="form-control" id="e_mail" name="user_email" type="text" value="<%=resultSet.getString("user_email")%>" disabled="disabled"/>
              </div>
	
	           <div class="form-group">
               <label for="exampleInputEmail1">Mobile::</label>
               <input class="form-control" id="p_hone" name="user_phone1" type="text" value="<%=resultSet.getString("user_phone")%>" disabled="disabled"/>
               <input type="hidden" name="user_phone" placeholder="Phone"  id="adminphone" autocomplete="off" value="<%=resultSet.getString("user_phone")%>">
              </div>
			 	
			 	 
    	    <div class="form-group">
             <label for="exampleInputEmail1">Password::</label>
             <input class="form-control" id="p_assword" name="user_password" type="text" value="<%=decryptedString%>" disabled="disabled"/>
            </div>
  
            <div class="form-group">
            <label for="exampleInputEmail1">DP ID::</label>
            <input class="form-control" id="p_assword" name="dpid" type="text" value="<%=resultSet.getString("dpid")%>" disabled="disabled"/>
           </div>
  

            <button class="btn btn-primary" type="button" onclick = "functionAlert();" style="margin-left: 30%"><i class="fa fa-fw fa-lg fa-check-circle"></i>Delete</button>
		   <div id = "confirm">
	         <div class = "message">Do you Want Delete?</div>
	         <button type="submit"  class = "yes">OK</button>
	         <button type="button" class="yes"  style="background: red">Cancel</button>
	       </div>
<%
}
connection.close();
} catch (Exception e) {
e.printStackTrace();
}
}
else
{
	RequestDispatcher rd=request.getRequestDispatcher("error.jsp");
	rd.forward(request, response);
}
			
%>
		   
          </form>
      </div>
   </div>
</div>
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
    <footer >
	   		<div class="footer-copyright" >
	        <p class="footer-company">All Rights Reserved. &copy; 2020 <a href="https://wss.mahadiscom.in/wss/wss" target="blank">MAHARASHTRA STATE ELECTRICITY BOARD</a> Design By :
	            <a  href="https://aderatesolutions.com/" target="blank"> AdeRate Tech Solutions</a></p>
	    	</div>
	</footer>  
  </body>
</html>
