<%@page import="java.sql.*"%>

<%
String id = request.getParameter("id");

Connection con=null;
PreparedStatement ps=null;

try{
    Class.forName("com.mysql.jdbc.Driver");
    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/studentinnvotive","root","root");

    ps = con.prepareStatement("delete from event where event_id=?");
    ps.setString(1,id);

    ps.executeUpdate();
    response.sendRedirect("viewEvents.jsp");

}catch(Exception e){
    e.printStackTrace();
}
finally{
    if(ps!=null) ps.close();
    if(con!=null) con.close();
}
%>
