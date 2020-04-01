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
<html>
<head>
<meta charset="UTF-8">

	<meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Edit User Record</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="../css/style2.css">
</head>
	<div class="wrapper d-flex align-items-stretch">
<nav id="sidebar" class="active">
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
      <%@include file="db.jsp" %>
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
	StringBuilder buffer = new StringBuilder();
	boolean processedFirst = false;
	String firstParam = null;
			
	Connection con=null;
	PreparedStatement ps=null;
%>
<%
	String uname=request.getParameter("user_name");
	String uemail=request.getParameter("user_email");
	String uphone=request.getParameter("user_phone");
	String upassword=request.getParameter("user_password");
	String dpid[]= request.getParameterValues("id[]");
	String aphone=request.getParameter("admin_phone");

%>
<%if (dpid==null) {
	 
	   request.setAttribute("alertmsg", "Select atleast one dpid");
	RequestDispatcher rd=request.getRequestDispatcher("user_registration_admin.jsp");  
	rd.include(request, response);
	
} 
else{
	try 
   {
     
	 con=DriverManager.getConnection(Url,Username,password);
	 final String secretKey = "ssshhhhhhhhhhh!!!!";
				   
	 String originalString = upassword;
	 String encryptedString = AES.encrypt(originalString, secretKey) ;
	 String decryptedString = AES.decrypt(encryptedString, secretKey) ;

	PreparedStatement ps1=con.prepareStatement("select * from user where  user_phone='"+uphone+"'");
     ResultSet rs = ps1.executeQuery();
     if (rs.next()) {
   	  System.out.println("User already Regitstered");
   	   request.setAttribute("alertMsg", "User already exist");
     	RequestDispatcher rd=request.getRequestDispatcher("user_registration_admin.jsp");  
     	rd.include(request, response);
     	
     } 
     else 
     {
     ps=con.prepareStatement("insert into user values(?,?,?,?,?,?,?,?,?)");
	 ps.setString(1, null);
     ps.setString(2, uname);
     ps.setString(3, uemail);
	 ps.setString(4, uphone);
	 ps.setString(5, encryptedString);
     ps.setString(6, "user");
			    			
     List<String> list=new ArrayList<String>();
     for(int loopIndex = 0; loopIndex < dpid.length; loopIndex++)
     {
	 System.out.println(dpid[loopIndex] + "<BR>");
     list.add(dpid[loopIndex]);
     }
     //System.out.println(list);
     try
     {
	   for(String record: list)
	   {
	     if(processedFirst)
	     buffer.append(",");
		 buffer.append(record);
	     processedFirst = true;
	   }
	   firstParam = buffer.toString();
	 }
     finally
     {
	   buffer = null;
	 }
	 ps.setString(7, firstParam);
	 ps.setString(8, "active");
	 ps.setString(9, aphone);
	 int i=ps.executeUpdate();
	 if(i>0) 
	 {  
	  System.out.println("user added successfully");
      RequestDispatcher rd=request.getRequestDispatcher("admin_user_info1.jsp");
	  rd.forward(request, response);
	  }
     }
    }
	catch (Exception e) 
    {
	  e.printStackTrace();
	}
}
%>
      </div>
</div>
    
     <%@include file="footer.jsp" %>
    
   
  </body>
</html>
