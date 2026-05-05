<%@page import="java.sql.*"%>

<%@page import="Mail.MailSender"%>
<%
String event_id = request.getParameter("event_id");
String event_name = request.getParameter("event_name");
String start_date = request.getParameter("start_date");
String end_date = request.getParameter("end_date");
String status = "Open";

String[] categories = request.getParameterValues("categories");

String categoryList = "";
if(categories != null){
    for(int i=0; i<categories.length; i++){
        categoryList += categories[i];
        if(i != categories.length-1){
            categoryList += ",";
        }
    }
}

Connection con=null;
PreparedStatement ps=null;
String mail =null;
String msg ="New Event Created Titled: "+event_name;
ResultSet rs = null;

try{
    Class.forName("com.mysql.jdbc.Driver");
    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/studentinnvotive","root","root");

    ps = con.prepareStatement("insert into event values(?,?,?,?,?,?)");
    ps.setString(1,event_id);
    ps.setString(2,event_name);
    ps.setString(3,start_date);
    ps.setString(4,end_date);
    ps.setString(5,categoryList);
    ps.setString(6,status);

    int i = ps.executeUpdate();
    
    ps.close();
    
    ps = con.prepareStatement("select * from student");
    rs = ps.executeQuery();
    
    while(rs.next())
    {
        mail = rs.getString("email");
        //msg = "Your Successfully Registered to the "+hname;
        MailSender email = new MailSender();
        Boolean flag = email.sendMail(mail,"Event Notification",msg);
        if(flag)
        {
            System.out.println("Email Sent");
        }   

    }
    
    
    if(i>0){
        response.sendRedirect("AddEvent.jsp?msg=success");
    }else{
        response.sendRedirect("AddEvent.jsp?msg1=fail");
    }

}catch(Exception e){
    e.printStackTrace();
}
finally{
    if(ps!=null) ps.close();
    if(con!=null) con.close();
}
%>
