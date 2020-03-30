<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.net.URL"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>
    <%@include file="db.jsp" %>
    
<!DOCTYPE html>
<html>
<head>
</head>
<body>
		 
           
<%
Connection con=null;
String str = request.getParameter("string");
System.out.println(str);
if(str != null)
{
System.out.println(str);
String var=null;

String[] words=str.split(":");//splits the string based on whitespace  
 List<String> itemList = new ArrayList<String>();
 for (String w : words) 
 {
    itemList.add(w);
 }
 System.out.println(itemList);

	

 for(int j=0;j<itemList.size();j++) 
 {
	 var=itemList.get(1);
	 
 }
try
{
	 con = DriverManager.getConnection(Url,Username,password);
        String sql1="Update onephase set r_voltage=?,r_current=?,y_voltage=?,y_current=?,b_voltage=?,b_current=? where dpid='"+var+"'";
        
        PreparedStatement ps1 = con.prepareStatement(sql1);
        
      for(int i=0;i<itemList.size();i++)
	  {
		if(itemList.get(0).equals("@"))
		{
	     switch(i)
	      {
	           
	          case 2:ps1.setString(1,itemList.get(i));
	          case 3:ps1.setString(2,itemList.get(i));
	          case 4:ps1.setString(3,itemList.get(i));
	          case 5:ps1.setString(4,itemList.get(i));
	          case 6:ps1.setString(5,itemList.get(i));
	          case 7:ps1.setString(6,itemList.get(i));
					
	       }
	    }
		else
		{
			RequestDispatcher rd=request.getRequestDispatcher("error.jsp");
		    rd.forward(request, response);
	    }
	  }
	int count=ps1.executeUpdate();
		
		  if(count>0) 
		  {
			  System.out.println("updated");
			response.sendRedirect( "index.jsp?dpid="+var ); 
		 }
}
catch (Exception e) {
	System.out.println(e);
}
}
%>

<%
String dpid = request.getParameter( "dpid" );

System.out.println("here dpid"+dpid);
if(dpid != null)
{
try{
	
     con = DriverManager.getConnection(Url,Username,password);
PreparedStatement ps=con.prepareStatement("select * from onephase where dpid="+dpid);
ResultSet rs=ps.executeQuery();
while(rs.next()){
	String str1=rs.getString("r_onoff");
	String str2=rs.getString("y_onoff");
	String str3=rs.getString("b_onoff");
	out.println(str1+":"+str2+":"+str3);
}
}
catch (Exception e) {
	System.out.println(e);
}
}
%>
  </body>
</html>
