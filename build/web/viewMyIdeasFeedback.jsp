<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<%
if(session.getAttribute("studentname")==null){
%>
<script>
window.top.location.href="index.jsp";
</script>
<%
return;
}

String studentId = session.getAttribute("studentname").toString();
String search = request.getParameter("search");
if(search == null) search = "";
%>

<!DOCTYPE html>
<html>
<head>

<title>My Ideas & Faculty Feedback</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body{
    background:#f4f6f9;
    font-family:Segoe UI;
}
.card{
    margin-top:30px;
    border-radius:12px;
}
.card-header{
    background:linear-gradient(90deg,#4e73df,#1cc88a);
    color:white;
    text-align:center;
    font-size:18px;
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
.remark-box{
    text-align:left;
    background:#eef2ff;
    padding:8px;
    border-radius:6px;
    margin-bottom:5px;
}
</style>

</head>

<body>

<div class="container">

<div class="card shadow">

<div class="card-header">
📌 My Ideas & Faculty Feedback
</div>

<div class="card-body">

<!-- 🔍 SEARCH -->
<form method="get" class="mb-3">
<div class="row">
<div class="col-md-10">
<input type="text" name="search" class="form-control"
placeholder="Search by idea title / description / remark..."
value="<%=search%>">
</div>
<div class="col-md-2">
<button class="btn btn-primary w-100">Search</button>
</div>
</div>
</form>

<div class="table-responsive">

<table class="table table-bordered table-hover">

<thead>
<tr>
<th>ID</th>
<th>Idea Title</th>
<th>Description</th>
<th>Score</th>
<th>Faculty Remarks (Feedback)</th>
<th>Date</th>
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

// ✅ QUERY WITH SEARCH + REMARKS
String query=
"SELECT i.id, i.idea_title, i.idea_description, i.score, i.submission_date "+
"FROM submissions i "+
"WHERE i.student_id=? AND ("+
"i.idea_title LIKE ? OR "+
"i.idea_description LIKE ? OR "+
"EXISTS (SELECT 1 FROM remarks r WHERE r.idea_id=i.id AND r.remark LIKE ?)"+
") ORDER BY i.id DESC";

ps=con.prepareStatement(query);

ps.setString(1,studentId);
ps.setString(2,"%"+search+"%");
ps.setString(3,"%"+search+"%");
ps.setString(4,"%"+search+"%");

rs=ps.executeQuery();

while(rs.next()){

int ideaId = rs.getInt("id");
%>

<tr>

<td><%=ideaId%></td>

<td><%=rs.getString("idea_title")%></td>

<td><%=rs.getString("idea_description")%></td>

<td>
<span class="badge bg-success">
<%=rs.getInt("score")%>
</span>
</td>

<td>

<%
PreparedStatement psr=con.prepareStatement(
"SELECT faculty_id, remark FROM remarks WHERE idea_id=?");

psr.setInt(1,ideaId);

ResultSet rr=psr.executeQuery();

boolean hasRemark=false;

while(rr.next()){
hasRemark=true;
%>

<div class="remark-box">
<b><%=rr.getString("faculty_id")%>:</b>
<br>
<%=rr.getString("remark")%>
</div>

<%
}

if(!hasRemark){
%>
<span class="text-muted">No feedback yet</span>
<%
}

rr.close();
psr.close();
%>

</td>

<td><%=rs.getDate("submission_date")%></td>

</tr>

<%
}

}catch(Exception e){
%>

<tr>
<td colspan="6" class="text-danger text-center">
Error loading data
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