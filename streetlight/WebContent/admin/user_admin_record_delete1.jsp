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
    <title>Delete User Recored</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="../css/style2.css">
</head>
<body >
<div class="wrapper d-flex align-items-stretch">
<nav id="sidebar" class="active" >
 <a href="aderatesolutions.com" class="logo"> Aderate Tech Solutions</a>
        
        <ul class="list-unstyled components mb-5">
         <li>
              <a href="dashboard_admin.jsp?admin_phone=<%=request.getParameter("admin_phone")%>"><span class="fa fa-home"></span>Dashboard</a>
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
              
             <%
String user_phone = request.getParameter("user_phone");
String admin_phone =request.getParameter("admin_phone");
Connection connection = null;
Statement statement = null;
ResultSet resultSet = null;
%>
<%@include file="db.jsp" %>
<%
try{
connection = DriverManager.getConnection(Url,Username,password);
statement=connection.createStatement();
String sql ="select * from user where user_phone="+user_phone;
if(user_phone != null){
resultSet = statement.executeQuery(sql);
while(resultSet.next()){
	String one=resultSet.getString("user_password");
	final String secretKey = "ssshhhhhhhhhhh!!!!";

	//String originalString = adminepassword;
	String encryptedString = one;
	String decryptedString = AES.decrypt(encryptedString, secretKey) ;
%>
				<div class="pad">
           			
				<form name="form1" method="post" action="user_admin_record_delete.jsp">
						
				   <div class="form-group">
                  <label for="exampleInputEmail1">Name::</label>
                  <input class="form-control" id="u_name" name="user_name" type="text" value="<%=resultSet.getString("user_name")%>"  disabled/>
                  </div>
	
	              <div class="form-group">
                  <label for="exampleInputEmail1">Email::</label>
                  <input class="form-control" id="e_mail" name="user_email" type="text" value="<%=resultSet.getString("user_email")%>" disabled>
                 </div>
	
	             <div class="form-group">
                 <label for="exampleInputEmail1">Mobile::</label>
                 <input class="form-control" id="p_hone" name="user_phone1" type="text" value="<%=resultSet.getString("user_phone")%>" disabled>
   	             <input type="hidden" name="user_phone" placeholder="Phone"  id="adminphone" autocomplete="off" value="<%=resultSet.getString("user_phone")%>">
  	             <input type="hidden" name="admin_phone" placeholder="Phone"  id="adminphone" autocomplete="off" value="<%=resultSet.getString("admin_phone")%>">
          </div>
 	
 	
	           <div class="form-group">
               <label for="exampleInputEmail1">Password::</label>
               <input class="form-control" id="p_assword" name="user_password" type="text" value="<%=decryptedString%>" disabled>
              </div>
  
              <div class="form-group">
              <label for="exampleInputEmail1">DP ID::</label>
               <input class="form-control"  name="dpid" type="text" value="<%=resultSet.getString("dpid")%>" disabled>
               </div>
  
              <button class="btn btn-primary" type="button" onclick = "functionAlert();" style="margin-left: 30%"><i class="fa fa-trash"></i>Delete</button>
		   <div id = "confirm">
	         <div class = "message">Do you Want Delete?</div>
	         <button type="submit"  class = "yes">OK</button>
	         <button type="button" class="yes"  style="background: red">Cancel</button>
	       </div>        
		   
            </form>
        </div>
     </div>
</div>

  
            <%
}
}
else{
	RequestDispatcher rd=request.getRequestDispatcher("error2.jsp?admin_phone="+admin_phone);
 	rd.include(request, response);
}
connection.close();
} catch (Exception e) {
e.printStackTrace();
}
				
%>

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
        <%@include file="footer.jsp" %>
</body>
</html>
