<%-- 
    Document   : AddStudentAction
    Created on : 26 Feb, 2019, 3:43:19 PM
    Author     : SRIGANESH
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>

<%
    String user = session.getAttribute("username").toString();
    session.setAttribute("username",user);
    String rno = request.getParameter("sid");
    String sname = request.getParameter("sname");
    String dname = request.getParameter("dname");
    String year = request.getParameter("year");
    String sem = request.getParameter("sem");
    String pass = request.getParameter("password");
    String status = "Active";
    String email = request.getParameter("email");
    //String atstatus ="Deactive";
    int auth = 2;
    
    try
    {
        Class.forName("com.mysql.jdbc.Driver");
         Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/studentinnvotive","root","root");
         PreparedStatement pst = con.prepareStatement("insert into student (srno,sname,dname,year,sem,password,status,email) values(?,?,?,?,?,?,?,?)");
         pst.setString(1,rno);
         pst.setString(2,sname);
         pst.setString(3, dname);
         pst.setString(4, year);
          pst.setString(5, sem);
          pst.setString(6, pass);
          pst.setString(7, status);
          pst.setString(8,email);
         
          PreparedStatement pst1 = con.prepareStatement("insert into login (username,password,auth) values(?,?,?)");
          pst1.setString(1,rno);
          pst1.setString(2, pass);
          pst1.setInt(3, auth);
          
         int i = pst.executeUpdate();
         int j = pst1.executeUpdate();
         if(i>0 && j>0)
         {
             System.out.println("Helloooooooooooooooooooooooooooooooo");
             response.sendRedirect("AddStudent.jsp?msg=success");
             
         }
         else
         {
             response.sendRedirect("AddStudent.jsp?msg1=failed");
         }
    }catch(Exception e){e.printStackTrace();}
%>