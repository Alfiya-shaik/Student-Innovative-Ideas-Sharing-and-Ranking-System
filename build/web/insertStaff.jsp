<%-- 
    Document   : insertStaff
    Created on : 7 May, 2024, 11:57:52 AM
    Author     : SRIGANESH
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
       <%
           String user = session.getAttribute("username").toString();
           session.setAttribute("username", user);
           String stid = request.getParameter("sid");
           String stname = request.getParameter("sname");
           String dname = request.getParameter("dname");
           String desg = request.getParameter("desg");
           
           String pass = request.getParameter("password");
           String status = "Active";
           int auth = 1;
           try
           {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/studentinnvotive","root","root");
                PreparedStatement pst = con.prepareStatement("insert into staff(stid, stname, dname,designation,password,status) values(?,?,?,?,?,?)");
                pst.setString(1,stid);
                pst.setString(2,stname);
                pst.setString(3,dname);
                pst.setString(4,desg);
                
                pst.setString(5,pass);
                pst.setString(6,status);
                
                PreparedStatement pst1 = con.prepareStatement("insert into login(username, password,auth) values(?,?,?)");
                pst1.setString(1,stid);
                pst1.setString(2,pass);
                pst1.setInt(3,auth);
                
                int i = pst.executeUpdate();
                int j = pst1.executeUpdate();
                
                if(i>0 && j>0)
                {
                       response.sendRedirect("AddStaff.jsp?msg=success");
                       
                }
                else
                {
                    response.sendRedirect("Addstaff.jsp?msg1=Failed");
                }
                
                
           }catch(Exception e)
           {
               e.printStackTrace();
           }
           
       %>
    </body>
</html>
