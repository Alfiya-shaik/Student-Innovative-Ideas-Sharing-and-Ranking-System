<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<%
    String facultyname = session.getAttribute("facultyname").toString();
if(session.getAttribute("facultyname") == null){
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
<title>View Faculty</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">

<style>
body{
    background:#f4f6f9;
}

.card{
    border-radius:12px;
}

.card-header{
    background:#4e73df;
    color:white;
    font-weight:600;
    text-align:center;
}

.table th{
    background:#4e73df;
    color:white;
    text-align:center;
}

.table td{
    vertical-align:middle;
    text-align:center;
}

.btn-sm{
    border-radius:20px;
}
</style>
</head>

<body>

<div class="container-fluid mt-4">

<div class="card shadow">

<div class="card-header">
    Faculty Details
</div>

<div class="card-body">

<div class="table-responsive">

<table class="table table-bordered table-hover">

<thead>
<tr>
    <th>ID</th>
    <th>Name</th>
    <th>Department</th>
    <th>Designation</th>
    <th>Status</th>
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
    con=DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/studentinnvotive",
        "root",
        "root"
    );

    stmt=con.createStatement();
    rs=stmt.executeQuery("SELECT * FROM staff where stid='"+facultyname+"'");

    while(rs.next()){
%>

<tr>
<td><%=rs.getString("stid")%></td>
<td><%=rs.getString("stname")%></td>
<td><%=rs.getString("dname")%></td>
<td><%=rs.getString("designation")%></td>


<td>
<%
String status=rs.getString("status");
if("Active".equalsIgnoreCase(status)){
%>
<span class="badge bg-success">Active</span>
<%
}else{
%>
<span class="badge bg-danger">Inactive</span>
<%
}
%>
</td>

<td>
<a href="editFaculty.jsp?id=<%=rs.getString("stid")%>"
   class="btn btn-warning btn-sm">
   <i class="fas fa-edit"></i>
</a>

<!--<a href="deleteFaculty.jsp?id=<%=rs.getString("stid")%>"
   class="btn btn-danger btn-sm"
   onclick="return confirm('Are you sure to delete this faculty?');">
   <i class="fas fa-trash"></i>
</a>-->
</td>

</tr>

<%
}

}catch(Exception e){
%>
<tr>
<td colspan="7" class="text-danger">Error Loading Data</td>
</tr>
<%
e.printStackTrace();
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

</body>
</html>
