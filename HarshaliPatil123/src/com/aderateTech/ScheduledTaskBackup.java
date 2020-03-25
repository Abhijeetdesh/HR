package com.aderateTech;
 import java.time.LocalTime;
import java.sql.*;

   import java.util.TimerTask; 
  import java.time.format.DateTimeFormatter;
 
public class ScheduledTaskBackup extends TimerTask 
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
		 
				 int r_current= rs.getInt("r_current"); 
				 int y_current=rs.getInt("y_current");
				  int b_current= rs.getInt("b_current");
				 
		
				
				 int r_min= rs.getInt("r_min"); 
				 int r_max=rs.getInt("r_max");
				 int y_min=rs.getInt("y_min"); 
				 int y_max= rs.getInt("y_max"); 
				 int b_min=rs.getInt("b_min"); 
				 int b_max= rs.getInt("b_max");
				
				 String r_onoff= rs.getString("r_onoff");
					String y_onoff=rs.getString("y_onoff");
					String b_onoff= rs.getString("b_onoff");
		
		String time0= rs.getString("on_time");
		String time1=rs.getString("off_time");
		String time2= rs.getString("on_time2");
		String time3=rs.getString("off_time2");
		
		 LocalTime timeA = LocalTime.parse(time0);
		 LocalTime timeB = LocalTime.parse(time1);
		 LocalTime timeC= LocalTime.parse(time2);
		 LocalTime timeD = LocalTime.parse(time3);
			
			

		 if (dtf.format(now).equals(dtf.format(timeA))) {
			
        String sql1="Update onephase set r_onoff=?,y_onoff=?,b_onoff=? where on_time='"+timeA+"'and r_current='"+r_current+"'and y_current='"+y_current+"'and b_current='"+b_current+"'and r_min='"+r_min+"'and r_max='"+r_max+"'and y_min='"+y_min+"'and y_max='"+y_max+"'and b_min='"+b_min+"'and b_max='"+b_max+"'and r_onoff='"+r_onoff+"'and y_onoff='"+y_onoff+"'and b_onoff='"+b_onoff+"'";
        
        PreparedStatement ps1 = con.prepareStatement(sql1);
       
       if(r_current<=r_max && r_current>=r_min)
       {
        ps1.setString(1,"@R1");
       }
       else
       {
        ps1.setString(1,r_onoff);
       }
       if(y_current<=y_max && y_current>=y_min)
       {
        ps1.setString(2,"Y1");
       }
       else {
    	   ps1.setString(2,y_onoff);
       }
       if(b_current<=b_max && b_current>=b_min)
       {
        ps1.setString(3,"B1");
       }
       else {
    	   ps1.setString(3,b_onoff);
       }
        int i = ps1.executeUpdate();
        if(i > 0)
        {
        	System.out.println("update on_time");
		 
		}
    }	

		 if (dtf.format(now).equals(dtf.format(timeB))) {
        
        String sql2="Update onephase set r_onoff=?,y_onoff=?,b_onoff=? where off_time='"+timeB+"'and r_current='"+r_current+"'and y_current='"+y_current+"'and b_current='"+b_current+"'and r_min='"+r_min+"'and r_max='"+r_max+"'and y_min='"+y_min+"'and y_max='"+y_max+"'and b_min='"+b_min+"'and b_max='"+b_max+"'and r_onoff='"+r_onoff+"'and y_onoff='"+y_onoff+"'and b_onoff='"+b_onoff+"'";
        
        PreparedStatement ps2 = con.prepareStatement(sql2);
        if(r_current<=r_max && r_current>=r_min)
           {
            ps2.setString(1,"@R0");
           }
        else {
        	  ps2.setString(1,r_onoff);
        }
        if(y_current<=y_max && y_current>=y_min)
           {
             ps2.setString(2,"Y0");
           }
        else {
        	 ps2.setString(2,y_onoff);
        }
        if(b_current<=b_max && b_current>=b_min)
           {
             ps2.setString(3,"B0");
           }
        else {
        	ps2.setString(3,y_onoff);
        }
        int i = ps2.executeUpdate();
        if(i > 0)
        {
        	System.out.println("update off_time ");
		 
		}
    }	
		 if (dtf.format(now).equals(dtf.format(timeC))) {
	            
	            String sql3="Update onephase set r_onoff=?,y_onoff=?,b_onoff=? where on_time2='"+timeC+"'and r_current='"+r_current+"'and y_current='"+y_current+"'and b_current='"+b_current+"'and r_min='"+r_min+"'and r_max='"+r_max+"'and y_min='"+y_min+"'and y_max='"+y_max+"'and b_min='"+b_min+"'and b_max='"+b_max+"'and r_onoff='"+r_onoff+"'and y_onoff='"+y_onoff+"'and b_onoff='"+b_onoff+"'";
	            
	            PreparedStatement ps3 = con.prepareStatement(sql3);
	            if(r_current<=r_max && r_current>=r_min)
		           {
	                ps3.setString(1,"@R1");
		           }
	            else {
	            	ps3.setString(1,r_onoff);
	            }
	            if(y_current<=y_max && y_current>=y_min)
		           {
	                ps3.setString(2,"Y1");
		           }
	            else {
	            	ps3.setString(2,y_onoff);
	            }
	            if(b_current<=b_max && b_current>=b_min)
		           {
	                ps3.setString(3,"B1");
		           }
	            else
	            {
	            	ps3.setString(3,b_onoff);
	            }
	            int i = ps3.executeUpdate();
	            if(i > 0)
	            {
	            	System.out.println("update on_time2 ");
	 		 
	 		}
	        }	
		 if (dtf.format(now).equals(dtf.format(timeD))) {
	            
	            String sql4="Update onephase set r_onoff=?,y_onoff=?,b_onoff=? where off_time2='"+timeD+"'and r_current='"+r_current+"'and y_current='"+y_current+"'and b_current='"+b_current+"'and r_min='"+r_min+"'and r_max='"+r_max+"'and y_min='"+y_min+"'and y_max='"+y_max+"'and b_min='"+b_min+"'and b_max='"+b_max+"'and r_onoff='"+r_onoff+"'and y_onoff='"+y_onoff+"'and b_onoff='"+b_onoff+"'";
	            
	            PreparedStatement ps4 = con.prepareStatement(sql4);
	            
	            if(r_current<=r_max && r_current>=r_min)
		           {
	               ps4.setString(1,"@R0");
		           }
	            else {
	            	ps4.setString(1,r_onoff);
	            }
	            if(y_current<=y_max && y_current>=y_min)
		           {
	            ps4.setString(2,"Y0");
		           }
	            else {
	            	 ps4.setString(2,y_onoff);
	            }
	            if(b_current<=b_max && b_current>=b_min)
		           {
	                 ps4.setString(3,"B0");
		           }
	            else {
	            	ps4.setString(3,b_onoff);
	            }
	            int i = ps4.executeUpdate();
	            if(i > 0)
	            {
	            	System.out.println("update off_time2 ");
	 		 
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

