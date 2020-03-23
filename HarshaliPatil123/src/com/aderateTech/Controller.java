package com.aderateTech;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.aderateTech.ConnectionManager;
import com.mysql.jdbc.Statement;
import com.mysql.jdbc.StringUtils;

public class Controller extends HttpServlet{
@Override
protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
	
	Connection con=null;
	String str=req.getParameter("EnterString");
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
		con=ConnectionManager.getConnection();
		
			
		
			
            String sql1="Update onephase set r_voltage=?,r_current=?,y_voltage=?,y_current=?,b_voltage=?,b_current=? where dpid='"+var+"'";
            
            PreparedStatement ps1 = con.prepareStatement(sql1);
            
          for(int i=0;i<itemList.size();i++)
		  {
			if(itemList.get(0).equals("#"))
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
				RequestDispatcher rd=req.getRequestDispatcher("error.jsp");
			    rd.forward(req, resp);
		    }
		  }
		int count=ps1.executeUpdate();
			
			  if(count>0) 
			  {System.out.println("update");
				 resp.sendRedirect( "index.jsp?dpid="+var ); 
				  
			}
	}
	catch (Exception e) {
		System.out.println(e);
	}
}
}
