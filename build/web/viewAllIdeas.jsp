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

String studentId = session.getAttribute("studentname").toString();
%>

<!DOCTYPE html>
<html>
<head>

<title>View Ideas</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">

<style>
body{ background:#f4f6f9; font-family:Segoe UI; }
.card{ margin-top:30px; border-radius:12px; }
.card-header{
    background:linear-gradient(90deg,#1cc88a,#4e73df);
    color:white;
    font-size:20px;
    font-weight:bold;
    text-align:center;
}
.table th{ background:#343a40; color:white; }
.like-btn{ color:#28a745; font-size:20px; }
.dislike-btn{ color:#dc3545; font-size:20px; }
</style>

</head>

<body>

<div class="container-fluid">
<div class="card shadow">
<div class="card-header">
💡 Student Innovation Ideas
</div>

<div class="card-body">

<!-- 🔍 LIVE FILTER BOX -->
<div class="mb-3 text-center">
<input type="text" id="filterInput" class="form-control w-50 d-inline"
       placeholder="Type to filter (Event, Title, Description...)">
</div>

<div class="table-responsive">

<table class="table table-bordered table-hover text-center">

<thead>
<tr>
<th>ID</th>
<th>Event</th>
<th>Idea Title</th>
<th>Description</th>
<th>File</th>
<th>Score</th>
<th>Vote</th>
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

// LIKE
if(request.getParameter("like")!=null){
    int ideaId=Integer.parseInt(request.getParameter("like"));

    PreparedStatement check=con.prepareStatement(
    "SELECT 1 FROM idea_votes WHERE idea_id=? AND student_id=?"
    );

    check.setInt(1,ideaId);
    check.setString(2,studentId);

    ResultSet voteRs=check.executeQuery();

    if(!voteRs.next()){
        PreparedStatement insertVote=con.prepareStatement(
        "INSERT INTO idea_votes(idea_id,student_id,vote_type) VALUES(?,?,?)"
        );

        insertVote.setInt(1,ideaId);
        insertVote.setString(2,studentId);
        insertVote.setString(3,"LIKE");
        insertVote.executeUpdate();

        PreparedStatement updateScore=con.prepareStatement(
        "UPDATE submissions SET score=IFNULL(score,0)+1 WHERE id=?"
        );

        updateScore.setInt(1,ideaId);
        updateScore.executeUpdate();

        insertVote.close();
        updateScore.close();
    }

    voteRs.close();
    check.close();

    response.sendRedirect("viewAllIdeas.jsp");
}

// DISLIKE
if(request.getParameter("dislike")!=null){
    int ideaId=Integer.parseInt(request.getParameter("dislike"));

    PreparedStatement check=con.prepareStatement(
    "SELECT 1 FROM idea_votes WHERE idea_id=? AND student_id=?"
    );

    check.setInt(1,ideaId);
    check.setString(2,studentId);

    ResultSet voteRs=check.executeQuery();

    if(!voteRs.next()){
        PreparedStatement insertVote=con.prepareStatement(
        "INSERT INTO idea_votes(idea_id,student_id,vote_type) VALUES(?,?,?)"
        );

        insertVote.setInt(1,ideaId);
        insertVote.setString(2,studentId);
        insertVote.setString(3,"DISLIKE");
        insertVote.executeUpdate();

        insertVote.close();
    }

    voteRs.close();
    check.close();

    response.sendRedirect("viewAllIdeas.jsp");
}

// FETCH IDEAS
String query =
"SELECT s.*, e.event_name, " +
"(SELECT 1 FROM idea_votes v WHERE v.idea_id=s.id AND v.student_id=?) AS voted " +
"FROM submissions s " +
"INNER JOIN event e ON s.event_id=e.event_id " +
"ORDER BY s.score DESC";

ps=con.prepareStatement(query);
ps.setString(1,studentId);

rs=ps.executeQuery();

while(rs.next()){
boolean voted = rs.getObject("voted") != null;
%>

<tr>
<td><%=rs.getInt("id")%></td>
<td><%=rs.getString("event_name")%></td>
<td><%=rs.getString("idea_title")%></td>
<td><%=rs.getString("idea_description")%></td>

<td>
<%
String fileName = rs.getString("filename");

if(fileName != null && !fileName.equals("")){
%>
<a href="downloadFile.jsp?id=<%=rs.getInt("id")%>" class="btn btn-sm btn-primary">
<i class="fas fa-download"></i> Download
</a>
<% } else { %>
<span class="text-muted">No File</span>
<% } %>
</td>

<td>
<span class="badge bg-primary">
<%=rs.getInt("score")%>
</span>
</td>

<td>
<% if(!voted){ %>
<a href="viewAllIdeas.jsp?like=<%=rs.getInt("id")%>" class="like-btn">
<i class="fas fa-thumbs-up"></i>
</a>

&nbsp;&nbsp;

<a href="viewAllIdeas.jsp?dislike=<%=rs.getInt("id")%>" class="dislike-btn">
<i class="fas fa-thumbs-down"></i>
</a>
<% } else { %>
<span class="badge bg-secondary">Already Voted</span>
<% } %>
</td>

</tr>

<%
}

}catch(Exception e){
%>

<tr>
<td colspan="7" class="text-danger">
Error Loading Ideas
</td>
</tr>

<%
e.printStackTrace();
}
finally{
try{ if(rs!=null) rs.close(); }catch(Exception e){}
try{ if(ps!=null) ps.close(); }catch(Exception e){}
try{ if(con!=null) con.close(); }catch(Exception e){}
}
%>

</tbody>
</table>

</div>
</div>
</div>
</div>

<!-- 🔥 LIVE FILTER SCRIPT -->
<script>
document.getElementById("filterInput").addEventListener("keyup", function() {

    let filter = this.value.toLowerCase();
    let rows = document.querySelectorAll("table tbody tr");

    rows.forEach(function(row) {

        let text = row.textContent.toLowerCase();

        if(text.includes(filter)){
            row.style.display = "";
        } else {
            row.style.display = "none";
        }

    });

});
</script>

</body>
</html>