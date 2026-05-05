<%@page import="java.sql.*"%>

<%
String id = request.getParameter("id");
String name = request.getParameter("name");
String start = request.getParameter("start");
String end = request.getParameter("end");
String cat = request.getParameter("cat");

Connection con=null;
PreparedStatement ps=null;

try{
    Class.forName("com.mysql.jdbc.Driver");
    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/studentinnvotive","root","root");

    ps = con.prepareStatement("update event set event_name=?,start_date=?,end_date=?,categories=? where event_id=?");

    ps.setString(1,name);
    ps.setString(2,start);
    ps.setString(3,end);
    ps.setString(4,cat);
    ps.setString(5,id);

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
