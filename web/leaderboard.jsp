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
<title>Student Leaderboard</title>

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

.rank-1{ background:#fff8dc; font-weight:bold; }
.rank-2{ background:#f0f0f0; font-weight:bold; }
.rank-3{ background:#ffe4b5; font-weight:bold; }

.desc-box{
    max-width:300px;
    white-space:nowrap;
    overflow:hidden;
    text-overflow:ellipsis;
}

.score-badge{
    font-size:14px;
    padding:6px 12px;
}
</style>
</head>

<body>

<div class="container-fluid mt-4">
<div class="row justify-content-center">
<div class="col-lg-12">

<div class="card shadow">

<div class="card-header">
🏆 Student Idea Leaderboard
</div>

<div class="card-body">

<div class="table-responsive">

<table class="table table-bordered table-hover text-center">

<thead>
<tr>
    <th>Rank</th>
    <th>Student ID</th>
    <th>Student Name</th>
    <th>Event ID</th>
    <th>Idea Title</th>
    <th>Idea Description</th>
    <th>Score</th>
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
    rs = stmt.executeQuery("SELECT * FROM submissions ORDER BY score DESC");

    int rank = 1;

    while(rs.next()){

        String rowClass="";
        if(rank==1) rowClass="rank-1";
        else if(rank==2) rowClass="rank-2";
        else if(rank==3) rowClass="rank-3";

        String desc = rs.getString("idea_description");
%>

<tr class="<%=rowClass%>">

<td>
<% if(rank==1){ %> 🥇
<% } else if(rank==2){ %> 🥈
<% } else if(rank==3){ %> 🥉
<% } else { %> <%=rank%>
<% } %>
</td>

<td><%=rs.getString("student_id")%></td>
<td><%=rs.getString("student_name")%></td>
<td><%=rs.getString("event_id")%></td>
<td><%=rs.getString("idea_title")%></td>

<td>
    <div class="desc-box" title="<%=desc%>">
        <%=desc%>
    </div>
</td>

<td>
    <span class="badge badge-success score-badge">
        <%=rs.getInt("score")%>
    </span>
</td>

</tr>

<%
        rank++;
    }

}catch(Exception e){
%>
<tr>
<td colspan="7" class="text-danger">Error Loading Leaderboard</td>
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
