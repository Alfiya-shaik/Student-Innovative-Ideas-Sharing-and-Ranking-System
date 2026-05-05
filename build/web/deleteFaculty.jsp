<%@page import="java.sql.*"%>

<%
String id=request.getParameter("id");

try{
Class.forName("com.mysql.cj.jdbc.Driver");
Connection con=DriverManager.getConnection(
"jdbc:mysql://localhost:3306/studentinnvotive",
"root",
"root");

PreparedStatement ps=con.prepareStatement(
"DELETE FROM faculty WHERE faculty_id=?");

ps.setString(1,id);
ps.executeUpdate();

con.close();

response.sendRedirect("viewFaculty.jsp");

}catch(Exception e){
e.printStackTrace();
}
%>
