<%@page import="java.sql.*"%>

<%
String id = request.getParameter("id");

Connection con=null;
PreparedStatement ps=null;
ResultSet rs=null;

String name="",start="",end="",cat="";

try{
    Class.forName("com.mysql.jdbc.Driver");
    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/studentinnvotive","root","root");

    ps = con.prepareStatement("select * from event where event_id=?");
    ps.setString(1,id);
    rs = ps.executeQuery();

    if(rs.next()){
        name = rs.getString(2);
        start = rs.getString(3);
        end = rs.getString(4);
        cat = rs.getString(5);
    }

}catch(Exception e){
    e.printStackTrace();
}
%>

<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body style="background:#f4f6f9;">

<div class="container mt-4">
<div class="card shadow">
<div class="card-header bg-primary text-white text-center">
Edit Event
</div>
<div class="card-body">

<form action="updateEvent.jsp" method="post">

<input type="hidden" name="id" value="<%=id%>">

<div class="form-group">
<label>Event Name</label>
<input type="text" name="name" value="<%=name%>" class="form-control" required>
</div>

<div class="form-group">
<label>Start Date</label>
<input type="date" name="start" value="<%=start%>" class="form-control" required>
</div>

<div class="form-group">
<label>End Date</label>
<input type="date" name="end" value="<%=end%>" class="form-control" required>
</div>

<div class="form-group">
<label>Categories (Comma Separated)</label>
<input type="text" name="cat" value="<%=cat%>" class="form-control" required>
</div>

<button class="btn btn-success btn-block">Update Event</button>

</form>

</div>
</div>
</div>

</body>
</html>
