<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
 <%@include file="sessioncache.jsp" %>
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
String adminname=request.getParameter("admin_name");
String adminemailid=request.getParameter("admin_email");
String adminephonenumber=request.getParameter("admin_phone");
String adminepassword=request.getParameter("admin_password");
String admin_phone1=request.getParameter("admin_phone1");
Connection connection = null;
PreparedStatement ps = null;

%>
<%
if(admin_phone1!=null){
try{
connection = DriverManager.getConnection(Url,Username,password);

String sql="Update admin set admin_name=?,admin_email=?,admin_phone=?,admin_password=? where admin_phone="+admin_phone1;

ps = connection.prepareStatement(sql);

final String secretKey = "ssshhhhhhhhhhh!!!!";

String originalString = adminepassword;
String encryptedString = AES.encrypt(originalString, secretKey) ;
String decryptedString = AES.decrypt(encryptedString, secretKey) ;

ps.setString(1,adminname);
ps.setString(2, adminemailid);
ps.setString(3, adminephonenumber);
ps.setString(4, encryptedString);
int i = ps.executeUpdate();
if(i > 0)
{
	   RequestDispatcher rd=request.getRequestDispatcher("admin_info.jsp");
	   rd.forward(request, response);		          
	   
}
else
{
	   RequestDispatcher rd=request.getRequestDispatcher("error.jsp");
	   rd.forward(request, response);		
}   
String sql1="Update user set admin_phone=? where admin_phone="+admin_phone1;
PreparedStatement ps1=connection.prepareStatement(sql1);
ps1.setString(1,adminephonenumber);
int j=ps1.executeUpdate();
if(j>0)
{
	System.out.println("Record updated");
}
else
{
	   RequestDispatcher rd=request.getRequestDispatcher("error.jsp");
	   rd.forward(request, response);		
}   

String sql2="Update dp_info set admin_phone=? where admin_phone="+admin_phone1;
PreparedStatement ps2=connection.prepareStatement(sql2);
ps2.setString(1,adminephonenumber);
int k=ps2.executeUpdate();
if(k>0)
{
	System.out.println("Record updated");
}
else
{
	   RequestDispatcher rd=request.getRequestDispatcher("error.jsp");
	   rd.forward(request, response);		
}   

String sql3="Update admin_notification set admin_phone=? where admin_phone="+admin_phone1;
PreparedStatement ps3=connection.prepareStatement(sql3);
ps3.setString(1,adminephonenumber);
int l=ps3.executeUpdate();
if(l>0)
{
	System.out.println("Record updated");
}
else
{
	   RequestDispatcher rd=request.getRequestDispatcher("error.jsp");
	   rd.forward(request, response);		
}   
String sql4="Update onephase set admin_phone=? where admin_phone="+admin_phone1;
PreparedStatement ps4=connection.prepareStatement(sql4);
ps4.setString(1,adminephonenumber);
int m=ps4.executeUpdate();
if(m>0)
{
	System.out.println("Record updated");
}
else
{
	   RequestDispatcher rd=request.getRequestDispatcher("error.jsp");
	   rd.forward(request, response);		
}   



}

catch (Exception e) 
{
e.printStackTrace();
}
}
else
{
	 RequestDispatcher rd=request.getRequestDispatcher("error.jsp");
	   rd.forward(request, response);		

}

	

	final String secretKey = "ssshhhhhhhhhhh!!!!";
   
    String originalString = adminepassword;
    String encryptedString = AES.encrypt(originalString, secretKey) ;
String decryptedString = AES.decrypt(encryptedString, secretKey) ;
	
%>
 <script src="../js/main.js"></script>
     <%@include file="footer.jsp" %>

</body>
</html>