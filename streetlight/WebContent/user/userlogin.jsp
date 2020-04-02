<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" 
    import="java.util.ArrayList"
    import="java.util.List" 
 %>
 <%! String nme=null; %>
 <%
 
response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires",300);
    int timeout = session.getMaxInactiveInterval();
    response.setHeader("Reload", timeout + "; URL = ../user.jsp");%>

<%String nme=(String) session.getAttribute("user_email");
    if (nme != null ) {
    	 
    }else{
    	response.sendRedirect("../user.jsp"); 
    }%>
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
  	<title>User login</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700,800,900" rel="stylesheet">
		
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
		<link rel="stylesheet" href="../css/style2.css">
		
  </head>

<body class="app sidebar-mini">

    <div class="wrapper d-flex align-items-stretch">
			<nav id="sidebar" class="active">
				<a href="index.html" class="logo" ><img src="images/logo.jpg" style="width: 25px;height: 25px;" >Aderate Solution</a>
    
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
<%@include file="db.jsp" %>
<%
  Connection con=null;
  PreparedStatement ps=null;
  ResultSet rs=null;
  
  String emailid=request.getParameter("uemail");
  String epassword=request.getParameter("psw");
  
%>
<% 
  try
  {
   
    con=DriverManager.getConnection(Url,Username,password);
    ps=con.prepareStatement("select * from user");
    final String secretKey = "ssshhhhhhhhhhh!!!!";
    String originalString = epassword;
    String encryptedString = AES.encrypt(originalString, secretKey) ;
    String decryptedString = AES.decrypt(encryptedString, secretKey) ;
    if (emailid!= null && encryptedString!=null) 
    {
     String sql = "Select * from user Where user_email='" + emailid + "' and user_password='" + encryptedString + "'";
     rs = ps.executeQuery(sql);
     if(rs.next())
     {      
    	 String admin_phone=rs.getString("admin_phone");
    	 String user_email=rs.getString("user_email");
    	 String user_password=rs.getString("user_password");
    	 String dpid=rs.getString("dpid");
    	 String status=rs.getString("status");
    	 System.out.println(status);
    	 String check="active";
    	 if(check.equals(status))
    	 {		  System.out.println("email"+user_email);
		 HttpSession sess = request.getSession();
    	   session.setAttribute("user_email", user_email);
    	  nme=(String) session.getAttribute("user_email");
    	 if(nme !=null){
    		 RequestDispatcher rd=request.getRequestDispatcher("dashboard_user.jsp?admin_phone="+admin_phone);
    		 rd.forward(request, response);
    	 }
    	 }
    	 else
    	 {
    	     HttpSession sess = request.getSession();
    	     session.setAttribute("This_user_is_blocked", "1");
    	     response.sendRedirect("../homepage.jsp");
    	 }
     }
     else{
    	   HttpSession sess = request.getSession();
    	   session.setAttribute("wrong_uname_pass", "1");
    	   response.sendRedirect("../homepage.jsp");
    	 }
     }
   
  }
  catch (Exception e) 
  {
   e.printStackTrace();
  }
%>

 </div>
    
    <script src="../js/jquery.min.js"></script>
    <script src="../js/popper.js"></script>
    <script src="../js/bootstrap.min.js"></script>
    <script src="../js/main.js"></script>
        <%@include file="footer.jsp" %>
</body>
</html>
