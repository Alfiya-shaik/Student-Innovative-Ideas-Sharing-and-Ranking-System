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

<title>Faculty Leaderboard</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">

<style>

body{
background:#f4f6f9;
font-family:'Segoe UI';
}

.card{
border-radius:15px;
}

.card-header{
background:linear-gradient(90deg,#f6c23e,#e74a3b);
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
vertical-align:middle;
text-align:center;
}

.rank-1{
background:#ffd700 !important;
font-weight:bold;
}

.rank-2{
background:#c0c0c0 !important;
font-weight:bold;
}

.rank-3{
background:#cd7f32 !important;
font-weight:bold;
}

.badge{
font-size:13px;
}

</style>

</head>

<body>

<div class="container-fluid mt-4">

<div class="card shadow">

<div class="card-header">
🏆 Faculty Leaderboard – Student Idea Rankings
</div>

<div class="card-body">

<div class="table-responsive">

<table class="table table-bordered table-hover">

<thead>

<tr>

<th>Rank</th>
<th>Student Name</th>
<th>Branch</th>
<th>Idea Title</th>
<th>Score</th>
<th>Submission Date</th>

</tr>

</thead>

<tbody>

<%

Connection con=null;
PreparedStatement ps=null;
ResultSet rs=null;

int rank=0;

try{

Class.forName("com.mysql.jdbc.Driver");

con=DriverManager.getConnection(
"jdbc:mysql://localhost:3306/studentinnvotive",
"root",
"root"
);

String query=

"SELECT s.sname, s.dname, "+
"i.idea_title, i.score, i.submission_date "+
"FROM submissions i "+
"INNER JOIN student s ON s.srno=i.student_id "+
"ORDER BY i.score DESC";

ps=con.prepareStatement(query);

rs=ps.executeQuery();

while(rs.next()){

rank++;

String rowClass="";
String trophy="";

if(rank==1){
rowClass="rank-1";
trophy="🥇";
}
else if(rank==2){
rowClass="rank-2";
trophy="🥈";
}
else if(rank==3){
rowClass="rank-3";
trophy="🥉";
}

%>

<tr class="<%=rowClass%>">

<td><%=rank%> <%=trophy%></td>

<td><%=rs.getString("sname")%></td>

<td><%=rs.getString("dname")%></td>

<td><%=rs.getString("idea_title")%></td>

<td>

<span class="badge bg-primary">
<%=rs.getInt("score")%>
</span>

</td>

<td>
<%=rs.getDate("submission_date")%>
</td>

</tr>

<%

}

}catch(Exception e){

%>

<tr>

<td colspan="6" class="text-danger text-center">
Error Loading Leaderboard
</td>

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