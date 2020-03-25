package com.aderateTech;
 import java.time.LocalTime;
import java.sql.*;

   import java.util.TimerTask; 
  import java.time.format.DateTimeFormatter;
 
public class ScheduledTask extends TimerTask 
{
	
	
	   
	public void run() 
	{
		
		 try{
		 String Url="jdbc:mysql://localhost/myproject";
        String Username="root";
        String password="";
        Class.forName("com.mysql.jdbc.Driver");
        Connection con=DriverManager.getConnection(Url,Username,password);
        PreparedStatement ps=con.prepareStatement("select * from onephase ");
        ResultSet rs=ps.executeQuery();
       while(rs.next()){ 
		 DateTimeFormatter dtf = DateTimeFormatter.ofPattern(" HH:mm:ss");
		 LocalTime now = LocalTime.now();
		 
				
				System.out.println(dtf.format(now));
		
		String time0= rs.getString("on_time");
		String time1=rs.getString("off_time");
		String time2= rs.getString("on_time2");
		String time3=rs.getString("off_time2");
		if(time0==null && time1==null && time2==null &&time3==null)
		{
			System.out.println("it's null value");
		}
		else
		{
		 LocalTime timeA = LocalTime.parse(time0);
		 LocalTime timeB = LocalTime.parse(time1);
		 LocalTime timeC= LocalTime.parse(time2);
		 LocalTime timeD = LocalTime.parse(time3);
			
			

		 if (dtf.format(now).equals(dtf.format(timeA))) {
			
        String sql1="Update onephase set r_onoff=?,y_onoff=?,b_onoff=? where on_time='"+timeA+"'";
        
        PreparedStatement ps1 = con.prepareStatement(sql1);
       
        ps1.setString(1,"@R1");
        ps1.setString(2,"Y1");
        ps1.setString(3,"B1");
       
       
        int i = ps1.executeUpdate();
        if(i > 0)
        {
        	System.out.println("update on_time");
		 
		}
    }	

		 if (dtf.format(now).equals(dtf.format(timeB))) {
        
        String sql2="Update onephase set r_onoff=?,y_onoff=?,b_onoff=? where off_time='"+timeB+"'";
        
        PreparedStatement ps2 = con.prepareStatement(sql2);
       
            ps2.setString(1,"@R0");
            ps2.setString(2,"Y0");
            ps2.setString(3,"B0");
          
        int i = ps2.executeUpdate();
        if(i > 0)
        {
        	System.out.println("update off_time ");
		 
		}
    }	
		 if (dtf.format(now).equals(dtf.format(timeC))) {
	            
	            String sql3="Update onephase set r_onoff=?,y_onoff=?,b_onoff=? where on_time2='"+timeC+"'";
	            
	            PreparedStatement ps3 = con.prepareStatement(sql3);
	            
	                ps3.setString(1,"@R1");
	                ps3.setString(2,"Y1");
		       	    ps3.setString(3,"B1");
		         
	            int i = ps3.executeUpdate();
	            if(i > 0)
	            {
	            	System.out.println("update on_time2 ");
	 		 
	 		}
	        }	
		 if (dtf.format(now).equals(dtf.format(timeD))) {
	            
	            String sql4="Update onephase set r_onoff=?,y_onoff=?,b_onoff=? where off_time2='"+timeD+"'";
	            
	            PreparedStatement ps4 = con.prepareStatement(sql4);
	           
	               ps4.setString(1,"@R0");
		           ps4.setString(2,"Y0");
		           ps4.setString(3,"B0");
		           
	            int i = ps4.executeUpdate();
	            if(i > 0)
	            {
	            	System.out.println("update off_time2 ");
	 		 
	 		}
	        }	
		}
       }
		 }
		 catch (Exception e) 
		 {
			e.printStackTrace();
			}

		
	} 
}
