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
<title>View Students</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

<style>
body{
    background:#f4f6f9;   /* Clean admin background */
}

.card{
    border-radius:10px;
}

.card-header{
    background:#003366;
    color:white;
    font-weight:600;
    text-align:center;
    font-size:18px;
}

.table th{
    background:#003366;
    color:white;
}

.table td{
    vertical-align:middle;
}
</style>
</head>

<body>

<div class="container-fluid mt-4">

<div class="row justify-content-center">
<div class="col-lg-11 col-md-12">

<div class="card shadow">

<div class="card-header">
    Student Details
</div>

<div class="card-body">

<div class="table-responsive">

<table class="table table-bordered table-hover text-center">

<thead>
<tr>
    <th>Student ID</th>
    <th>Name</th>
    <th>Department</th>
    <th>Year</th>
    <th>Semester</th>
    <th>Status</th>
</tr>
</thead>

<tbody>

<%
Connection con=null;
Statement stmt=null;
ResultSet rs=null;

try{
    Class.forName("com.mysql.jdbc.Driver");
    con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/studentinnvotive",
        "root",
        "root"
    );

    stmt = con.createStatement();
    rs = stmt.executeQuery("SELECT * FROM student");

    while(rs.next()){
%>
<tr>
    <td><%=rs.getString(1)%></td>
    <td><%=rs.getString(2)%></td>
    <td><%=rs.getString(3)%></td>
    <td><%=rs.getString(4)%></td>
    <td><%=rs.getString(5)%></td>
    <td>
        <%
            String status = rs.getString(7);
            if("Active".equalsIgnoreCase(status)){
        %>
            <span class="badge badge-success">Active</span>
        <%
            } else {
        %>
            <span class="badge badge-danger">Inactive</span>
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
    <td colspan="6" class="text-danger">
        Error Loading Data
    </td>
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
</div>

</div>

</body>
</html>
