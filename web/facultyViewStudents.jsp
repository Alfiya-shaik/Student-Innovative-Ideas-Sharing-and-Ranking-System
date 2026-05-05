<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<%
if(session.getAttribute("facultyname")==null){
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

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">

<style>
body{
    background:#f4f6f9;
}

.card{
    border-radius:15px;
}

.card-header{
    background:linear-gradient(90deg,#4e73df,#1cc88a);
    color:white;
    font-weight:600;
    text-align:center;
    font-size:18px;
}

.table th{
    background:#343a40;
    color:white;
    text-align:center;
}

.table td{
    text-align:center;
    vertical-align:middle;
}

.search-box{
    max-width:300px;
}
</style>

<script>
function searchStudent() {
    let input = document.getElementById("searchInput").value.toLowerCase();
    let rows = document.querySelectorAll("#studentTable tbody tr");

    rows.forEach(row => {
        let text = row.innerText.toLowerCase();
        row.style.display = text.includes(input) ? "" : "none";
    });
}
</script>

</head>

<body>

<div class="container-fluid mt-4">

<div class="card shadow">

<div class="card-header">
    👩‍🎓 Faculty – All Student Details
</div>

<div class="card-body">

<div class="d-flex justify-content-between align-items-center mb-3">

<%
Connection con=null;
PreparedStatement psCount=null;
ResultSet rsCount=null;
int totalStudents=0;

try{
    Class.forName("com.mysql.jdbc.Driver");
    con=DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/studentinnvotive",
        "root",
        "root"
    );

    psCount=con.prepareStatement("SELECT COUNT(*) FROM student");
    rsCount=psCount.executeQuery();

    if(rsCount.next()){
        totalStudents=rsCount.getInt(1);
    }
}catch(Exception e){
    e.printStackTrace();
}
%>

<h5>Total Students: <span class="badge bg-primary"><%=totalStudents%></span></h5>

<div class="search-box">
<input type="text" id="searchInput" onkeyup="searchStudent()" 
class="form-control" placeholder="Search student...">
</div>

</div>

<div class="table-responsive">

<table class="table table-bordered table-hover" id="studentTable">

<thead>
<tr>
    <th>ID</th>
    <th>Name</th>
    <th>Department</th>
    <th>Year</th>
    <th>Sem</th>
    <!--<th>Ideas</th>-->
</tr>
</thead>

<tbody>

<%
PreparedStatement ps=null;
ResultSet rs=null;

try{
    String query="SELECT * FROM student";
    ps=con.prepareStatement(query);
    rs=ps.executeQuery();

    while(rs.next()){
%>

<tr>
<td><%=rs.getString("srno")%></td>
<td><%=rs.getString("sname")%></td>
<td><%=rs.getString("dname")%></td>
<td><%=rs.getString("year")%></td>
<td><%=rs.getString("sem")%></td>


<!--<td>
<a href="facultyViewStudentIdeas.jsp?sid=<%=rs.getString("srno")%>" 
class="btn btn-sm btn-success">
<i class="fas fa-eye"></i> View Idea
</a>
</td>-->

</tr>

<%
    }

}catch(Exception e){
%>
<tr>
<td colspan="7" class="text-danger">Error Loading Students</td>
</tr>
<%
e.printStackTrace();
}
finally{
if(rs!=null) rs.close();
if(ps!=null) ps.close();
if(rsCount!=null) rsCount.close();
if(psCount!=null) psCount.close();
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
