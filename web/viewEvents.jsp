<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<%
if(session.getAttribute("username") == null){
%>
<script>
    window.top.location.href="login.jsp";
</script>
<%
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Manage Events</title>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

<style>
body{
    background:#f4f6f9;
}
.card{
    border-radius:10px;
}
.card-header{
    background:#003366;
    color:white;
    font-weight:600;
    text-align:center;
}
.table th{
    background:#003366;
    color:white;
}
.table td{
    vertical-align:middle;
}
.btn-sm{
    margin:2px;
}
</style>
</head>

<body>

<div class="container-fluid mt-4">
<div class="row justify-content-center">
<div class="col-lg-11">

<div class="card shadow">

<div class="card-header">
Event Details
</div>

<div class="card-body">

<div class="table-responsive">

<table class="table table-bordered table-hover text-center">

<thead>
<tr>
    <th>Event ID</th>
    <th>Event Name</th>
    <th>Start Date</th>
    <th>End Date</th>
    <th>Categories</th>
    <th>Action</th>
</tr>
</thead>

<tbody>

<%
Connection con=null;
Statement stmt=null;
ResultSet rs=null;

try{
    Class.forName("com.mysql.jdbc.Driver");
    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/studentinnvotive","root","root");
    stmt = con.createStatement();
    rs = stmt.executeQuery("SELECT * FROM event");

    while(rs.next()){
%>

<tr>
    <td><%=rs.getString(1)%></td>
    <td><%=rs.getString(2)%></td>
    <td><%=rs.getString(3)%></td>
    <td><%=rs.getString(4)%></td>
    <td><%=rs.getString(5)%></td>
    <td>
        <a href="editEvent.jsp?id=<%=rs.getString(1)%>" class="btn btn-warning btn-sm">Edit</a>
        <a href="deleteEvent.jsp?id=<%=rs.getString(1)%>" 
           class="btn btn-danger btn-sm"
           onclick="return confirm('Are you sure you want to delete this event?')">
           Delete
        </a>
    </td>
</tr>

<%
    }

}catch(Exception e){
%>
<tr>
<td colspan="6" class="text-danger">Error Loading Data</td>
</tr>
<%
}
finally{
    if(rs!=null) rs.close();
    if(stmt!=null) stmt.close();
    if(con!=null) con.close();
}
%>

</tbody>
</table>

</div>
</div>
</div>

</div>
</div>
</div>

</body>
</html>
