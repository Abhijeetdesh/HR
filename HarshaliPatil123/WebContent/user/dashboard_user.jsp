<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
    <%@include file="db.jsp" %>
<!DOCTYPE html>
<html>
<head>
  	<title>User DashBoard</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700,800,900" rel="stylesheet">
		
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
		<link rel="stylesheet" href="../css/style2.css">
	   <link rel="stylesheet" href="../css/chart.css">
		
  </head>


<body >
		<div class="wrapper d-flex align-items-stretch">
			<nav id="sidebar" class="active">
					<a href="index.html" class="logo"><img src="images/logo.jpg" style="width: 25px;height: 25px;" ><br> AdeRate Solution</a>
     			<ul class="list-unstyled components mb-5">
<%
       /***** Post Parameters From The Request *****/
       String param1 = request.getParameter("uemail");
       if (param1 != null && !param1.equals("")) {

           int timeout =300;
           HttpSession sessionObj = request.getSession(true);

          
           /***** Setting The Updated Session Time Out *****/
           sessionObj.setMaxInactiveInterval(timeout);
           
           /***** Once The Time Out Is Reached. This Line Will Automatically Refresh The Page *****/
           response.setHeader("Refresh", timeout + "; URL=../homepage.jsp");
       } else {
           //out.println("<p id='errMsg' style='color: red; font-size: larger; margin-left: 564px'>Please Enter a Correct Name!</p>");
           RequestDispatcher rdObj = request.getRequestDispatcher("../homepage.jsp");
           rdObj.include(request, response);
       }

       %> 
       <%!String dpid=null; %>
   <%
   
    Connection con1=null;
	PreparedStatement ps1=null;
	ResultSet rs1=null;
	
	String emailid1=request.getParameter("uemail");
    String epassword1=request.getParameter("psw");
    System.out.println(emailid1);
    System.out.println(epassword1);
    
   %>
   <% 
   try
   {
     
     con1=DriverManager.getConnection(Url,Username,password);
     ps1=con1.prepareStatement("select * from user");
     final String secretKey = "ssshhhhhhhhhhh!!!!";
     String originalString = epassword1;
     String encryptedString = AES.encrypt(originalString, secretKey) ;
     String decryptedString = AES.decrypt(encryptedString, secretKey) ;
     if (emailid1!= null && encryptedString!=null) 
     {
      String sql = "Select * from user Where user_email='" + emailid1 + "' and user_password='" + encryptedString + "'";
      rs1 = ps1.executeQuery(sql);
      if(rs1.next())
      {
        dpid=rs1.getString("dpid");
        
   %>
       <li ><a  class="active" class="app-menu__item" href="userdplist_user.jsp?dpid=<%=rs1.getString("dpid")%>&admin_phone=<%=rs1.getString("admin_phone")%>" ><span class="fa fa-info-circle"></span> User Details</a>
           </li>
           
          <li ><a class="app-menu__item" href="timeset_user.jsp?dpid=<%=rs1.getString("dpid")%>&admin_phone=<%=rs1.getString("admin_phone")%>" ><span class="fa fa-clock-o"></span>Time Manager</a>
        </li>
        
        <li ><a class="app-menu__item" href="onoff_user.jsp?dpid=<%=rs1.getString("dpid")%>&admin_phone=<%=rs1.getString("admin_phone")%>" ><span class="fa fa-toggle-on"></span>ON/OFF</a>
        </li>
       
        <li ><a class="app-menu__item" href="show_user_notification.jsp?admin_phone=<%=rs1.getString("admin_phone")%>" ><span class="fa fa-bell"></span>Show Notifications</a>
        </li> 
        
       <li ><a class="app-menu__item" href="show_myuser_notification.jsp?admin_phone=<%=rs1.getString("admin_phone")%>" ><span class="fa fa-bell"></span>Show My Notifications</a>
        </li>  
         
         <li ><a class="app-menu__item" href="../homepage.jsp" ><span class="fa fa-power-off"></span>Logout</a>
        </li>
        </ul>
      </nav>
   <%
      }
    }
  }
  catch (Exception e) 
  {
    e.printStackTrace();
  }
  %>
        
         
  <div id="content" >

        <nav class="navbar navbar-expand-lg navbar-light bg-light">
          <div class="container-fluid">

            <button type="button" id="sidebarCollapse" class="btn btn-primary">
              <i class="fa fa-bars"></i>
              <span class="sr-only">Toggle Menu</span>
            </button>
            
           
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
<%!String c1=null,c2=null,c3=null,c4=null,c5=null,c7=null,
   c8=null,c12=null,c13=null,c14=null,c15=null,c16=null,c17=null,c18=null,c19=null,c20=null,c21=null; %>
<%!int v1=0,v2=0,v3=0,v4=0,v5=0,v7=0,v8=0,v12=0,v13=0,v14=0,v15=0,v16=0,v17=0,v18=0,v19=0,v20=0,v21=0; %>
<% 
int sum1=0,sum2=0,sum3=0,sum4=0,sum5=0,sum6=0,sum7=0,sum8=0,sum9=0,
   sum10=0,sum11=0,sum12=0,sum13=0,sum14=0,sum15=0,sum16=0,sum17=0,sum18=0,sum19=0,sum20=0,sum21=0;
dpid=rs1.getString("dpid");
System.out.println(dpid);
Object[] value=dpid.split(",");
/* System.out.println(Arrays.toString(value));
 */
 int count=0;
ArrayList idlist=new ArrayList();
for(int i=0; i<value.length;i++)
{
	System.out.println("Total dp::"+value[i]);
	idlist.add(value[i]);
    count++;
}
System.out.println(count);

con1 = DriverManager.getConnection(Url, Username, password);

Statement statement1=null;ResultSet resultSet1=null;
Statement statement2=null;ResultSet resultSet2=null;
Statement statement3=null;ResultSet resultSet3=null;
Statement statement4=null;ResultSet resultSet4=null;
Statement statement5=null;ResultSet resultSet5=null;
Statement statement7=null;ResultSet resultSet7=null;
Statement statement8=null;ResultSet resultSet8=null;
Statement statement12=null;ResultSet resultSet12=null;
Statement statement13=null;ResultSet resultSet13=null;
Statement statement14=null;ResultSet resultSet14=null;
Statement statement15=null;ResultSet resultSet15=null;
Statement statement16=null;ResultSet resultSet16=null;
Statement statement17=null;ResultSet resultSet17=null;
Statement statement18=null;ResultSet resultSet18=null;
Statement statement19=null;ResultSet resultSet19=null;
Statement statement20=null;ResultSet resultSet20=null;
Statement statement21=null;ResultSet resultSet21=null;

statement1=con1.createStatement();
statement2=con1.createStatement();
statement3=con1.createStatement();
statement4=con1.createStatement();
statement5=con1.createStatement();
statement7=con1.createStatement();
statement8=con1.createStatement();
statement12=con1.createStatement();
statement13=con1.createStatement();
statement14=con1.createStatement();
statement15=con1.createStatement();
statement16=con1.createStatement();
statement17=con1.createStatement();
statement18=con1.createStatement();
statement19=con1.createStatement();
statement20=con1.createStatement();
statement21=con1.createStatement();

System.out.println("idlist::"+idlist);
 for(Object n : idlist)
 {
	 String sql1="SELECT COUNT(dpid) FROM onephase WHERE dpid="+n;
     resultSet1=statement1.executeQuery(sql1);
	 ResultSetMetaData rsmd1 = resultSet1.getMetaData();
	 int columnsNumber1 = rsmd1.getColumnCount();
	 while(resultSet1.next())
	 {
	   for (int i = 1; i <= columnsNumber1; i++) 
	   {
	     c1=resultSet1.getString(i);
	     v1=Integer.parseInt(c1);
		 sum1=sum1+v1;
       }
	}
	
	 String sql2="SELECT COUNT(dpid) FROM onephase WHERE r_voltage>100 AND dpid="+n;
     resultSet2=statement2.executeQuery(sql2);
	 ResultSetMetaData rsmd2 = resultSet2.getMetaData();
	 int columnsNumber2 = rsmd2.getColumnCount();
	 while(resultSet2.next())
	 {
	   for (int i = 1; i <= columnsNumber2; i++) 
	   {
	     c2=resultSet2.getString(i);
	     v2=Integer.parseInt(c2);
		 sum2=sum2+v2;
       }
	}
	 String sql3="SELECT COUNT(dpid) FROM onephase WHERE r_voltage<100 AND dpid="+n;
     resultSet3=statement3.executeQuery(sql3);
	 ResultSetMetaData rsmd3 = resultSet3.getMetaData();
	 int columnsNumber3 = rsmd3.getColumnCount();
	 while(resultSet3.next())
	 {
	   for (int i = 1; i <= columnsNumber3; i++) 
	   {
	     c3=resultSet3.getString(i);
	     v3=Integer.parseInt(c3);
		 sum3=sum3+v3;
       }
	}
 }	 
%>
<div class="bg-style">
<!--   <h1 class="p-3">Canvas circular progressbar </h1>
 -->  <div class="wrapper">
    <div class="row pt-5 pb-5">
  
  <div class="col-6 col-sm-3">
        <div class="counter" data-cp-percentage="<%=50%>" data-cp-color="#00bfeb">
        </div>
        <h4>Total DP</h4>
     </div>
  
  <div class="col-6 col-sm-3">
        <div class="counter" data-cp-percentage="<%=50%>" data-cp-color="#EA4C89"></div>
        <h4>Total On DP</h4>
  </div>
 
  <div class="col-6 col-sm-3">
      <div class="counter" data-cp-percentage="<%=25%>" data-cp-color="#FF675B"></div>
      <h4>Total Off DP</h4>
    </div>
  
  <br>    
   
    <div class="col-sm my" >
     <b>
     <br>
     <label id="font">ONE PHASE(<%=5%>)</label><br>
     <label>ON(R)::<%=5%></label>
     <progress id="on" value="<%=5%>" max="<%=10%>" ></progress>

     <label>OFF(R)::<%=5%></label>
     <progress id="off" value="<%=5%>" max="<%=10%>"></progress> 
     </b>
   </div> 
   
   <br>
    <div class="my1 mt-5" >
     <b>
     <br>
     <label id="font">TWO PHASE(<%=20%>)</label><br>
     <label>ON(R)::<%=3%></label>
     <progress id="on" value="<%=5%>" max="<%=50%>" ></progress>

     <label>OFF(R)::<%=4%></label>
     <progress id="off" value="<%=4%>" max="<%=50%>"></progress> 
    <br>   
     <label>ON(Y)::<%=6%></label>
     <progress id="on" value="<%=6%>" max="<%=50%>" ></progress>

     <label>OFF(Y)::<%=6%></label>
     <progress id="off" value="<%=6%>" max="<%=50%>"></progress> 
     </b>
   </div> 
    
   <br>
    <div class="my2 mt-5" >
     <b>
     <br>
     <label id="font">THREE PHASE(<%=15%>)</label><br>
     <label>ON(R)::<%=16%></label>
     <progress id="on" value="<%=16%>" max="<%=50%>" ></progress>

     <label>OFF(R)::<%=17%></label>
     <progress id="off" value="<%=17%>" max="<%=50%>"></progress> 
    <br>   
     <label>ON(Y)::<%=30%></label>
     <progress id="on" value="<%=18%>" max="<%=50%>" ></progress>

     <label>OFF(Y)::<%=30%></label>
     <progress id="off" value="<%=30%>" max="<%=50%>"></progress> 
      <br>   
     <label>ON(B)::<%=20%></label>
     <progress id="on" value="<%=20%>" max="<%=50%>" ></progress>

     <label>OFF(B)::<%=21%></label>
     <progress id="off" value="<%=21%>" max="<%=50%>"></progress> 
     </b>
   </div>   
  
  
    </div>
  </div>
 
</div>
<p class="p-3">
</p>


</div>
 </div>
         
    <script src="../js/chart.js"></script>
    <script src="../js/jquery.min.js"></script>
    <script src="../js/popper.js"></script>
    <script src="../js/bootstrap.min.js"></script>
    <script src="../js/main.js"></script>
    <footer style="margin-top: 13px;">
	   		<div class="footer-copyright" style="margin-top:-5%;width: 100%;">
	        <p class="footer-company">All Rights Reserved. &copy; 2020 <a href="https://wss.mahadiscom.in/wss/wss" target="blank">MAHARASHTRA STATE ELECTRICITY BOARD</a> Design By :
	            <a  href="https://aderatesolutions.com/" target="blank"> AdeRate Tech Solutions</a></p>
	    	</div>
	</footer>    
  </body>
</html>
