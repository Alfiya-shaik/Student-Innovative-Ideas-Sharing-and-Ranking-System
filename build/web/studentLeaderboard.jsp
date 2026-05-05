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

<title>Student Leaderboard</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">

<style>

body{
background:#f8f9fc;
font-family:'Segoe UI';
}

.card{
margin-top:25px;
border-radius:15px;
}

.card-header{
background:linear-gradient(90deg,#4e73df,#1cc88a);
color:white;
text-align:center;
font-size:20px;
font-weight:bold;
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

.rank-1{
background:#fff3cd;
font-weight:bold;
}

.rank-2{
background:#e2e3e5;
font-weight:bold;
}

.rank-3{
background:#f8d7da;
font-weight:bold;
}

.badge-score{
font-size:14px;
}

</style>

</head>

<body>

<div class="container-fluid">

<div class="card shadow">

<div class="card-header">
🏆 Student Leaderboard
</div>

<div class="card-body">

<div class="table-responsive">

<table class="table table-bordered table-hover">

<thead>
<tr>
<th>Rank</th>
<th>Student Name</th>
<th>Total Ideas</th>
<th>Total Score</th>
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

String query=

"SELECT student_name, "+
"COUNT(id) AS total_ideas, "+
"IFNULL(SUM(score),0) AS total_score "+
"FROM submissions "+
"GROUP BY student_id "+
"ORDER BY total_score DESC";

ps=con.prepareStatement(query);

rs=ps.executeQuery();

int rank=1;

while(rs.next()){

String rowClass="";

if(rank==1) rowClass="rank-1";
else if(rank==2) rowClass="rank-2";
else if(rank==3) rowClass="rank-3";

%>

<tr class="<%=rowClass%>">

<td>

<%

if(rank==1){

%>

<i class="fas fa-trophy text-warning"></i>

<%

}else if(rank==2){

%>

<i class="fas fa-medal text-secondary"></i>

<%

}else if(rank==3){

%>

<i class="fas fa-medal text-danger"></i>

<%

}else{

out.print(rank);

}

%>

</td>

<td><%=rs.getString("student_name")%></td>

<td>
<span class="badge bg-primary">
<%=rs.getInt("total_ideas")%>
</span>
</td>

<td>
<span class="badge bg-dark badge-score">
<%=rs.getInt("total_score")%>
</span>
</td>

</tr>

<%

rank++;

}

}catch(Exception e){

%>

<tr>
<td colspan="4" class="text-danger">
Error Loading Leaderboard
</td>
</tr>

<%

e.printStackTrace();

}finally{

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