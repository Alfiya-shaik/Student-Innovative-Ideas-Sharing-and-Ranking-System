<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<%
if(session.getAttribute("studentname")==null){
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
<title>View Events</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">

<style>
body{
    background:#f4f6f9;
    font-family:'Segoe UI',sans-serif;
}

.card{
    margin-top:30px;
    border-radius:15px;
}

.card-header{
    background:linear-gradient(90deg,#36b9cc,#4e73df);
    color:white;
    font-weight:600;
    font-size:18px;
    text-align:center;
}

.table th{
    background:#343a40;
    color:white;
    text-align:center;
}

.table td{
    vertical-align:middle;
}

.badge{
    font-size:13px;
}

.table-hover tbody tr:hover{
    background:#f1f1f1;
    transition:0.3s;
}
</style>

</head>

<body>

<div class="container-fluid">

<div class="card shadow">

<div class="card-header">
    📅 Available Events
</div>

<div class="card-body">

<div class="table-responsive">

<table class="table table-bordered table-hover align-middle text-center">

<thead>
<tr>
    <th>ID</th>
    <th>Event Name</th>
    <th>Start Date</th>
    <th>End Date</th>
    <th>Categories</th>
    <th>Status</th>
</tr>
</thead>

<tbody>

<%
Connection con=null;
PreparedStatement ps=null;
ResultSet rs=null;

try{
    Class.forName("com.mysql.jdbc.Driver");
    con=DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/studentinnvotive",
        "root",
        "root"
    );

    ps=con.prepareStatement("SELECT * FROM event ORDER BY start_date DESC");
    rs=ps.executeQuery();

    while(rs.next()){
        String status=rs.getString("status");
%>

<tr>
<td><%=rs.getString("event_id")%></td>
<td><%=rs.getString("event_name")%></td>
<td><%=rs.getDate("start_date")%></td>
<td><%=rs.getDate("end_date")%></td>
<td><%=rs.getString("categories")%></td>

<td>
<%
if("Open".equalsIgnoreCase(status)){
%>
<span class="badge bg-success">Active</span>
<%
}else if("Closed".equalsIgnoreCase(status)){
%>
<span class="badge bg-danger">Closed</span>
<%
}else{
%>
<span class="badge bg-warning text-dark">Upcoming</span>
<%
}
%>
</td>

</tr>

<%
    }

}catch(Exception e){
%>
<tr>
<td colspan="5" class="text-danger">Error Loading Events</td>
</tr>
<%
e.printStackTrace();
}
finally{
    if(rs!=null) rs.close();
    if(ps!=null) ps.close();
    if(con!=null) con.close();
}
%>

</tbody>
</table>

</div>

</div>
</div>

</div>

</body>
</html>
