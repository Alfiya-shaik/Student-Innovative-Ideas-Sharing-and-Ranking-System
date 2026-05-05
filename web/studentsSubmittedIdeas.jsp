<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<%
if(session.getAttribute("facultyname") == null){
%>
<script>
window.top.location.href="login.jsp";
</script>
<%
return;
}

String facultyId = session.getAttribute("facultyname").toString();
%>

<!DOCTYPE html>
<html>
<head>

<title>Students Submitted Ideas</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">

<style>
body{background:#f4f6f9;font-family:'Segoe UI';}
.card{border-radius:12px;}
.card-header{background:#1cc88a;color:white;text-align:center;}
.table th{background:#1cc88a;color:white;text-align:center;}
.table td{text-align:center;}
.like{color:green;font-size:20px;}
.dislike{color:red;font-size:20px;}
</style>

</head>

<body>

<div class="container-fluid mt-4">
<div class="card shadow">
<div class="card-header">Students Submitted Ideas</div>

<div class="card-body">

<!-- 🔍 LIVE FILTER BOX -->
<div class="mb-3 text-center">
<input type="text" id="filterInput" class="form-control w-50 d-inline"
       placeholder="Type to filter (Name, Roll No, Title...)">
</div>

<div class="table-responsive">

<table class="table table-bordered table-hover">

<thead>
<tr>
<th>ID</th>
<th>Name</th>
<th>Dept</th>
<th>Year</th>
<th>Sem</th>
<th>Title</th>
<th>Description</th>
<th>File</th>
<th>Score</th>
<th>Vote</th>
<th>Remarks</th>
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
"jdbc:mysql://localhost:3306/studentinnvotive","root","root");

// ================= LIKE =================
if(request.getParameter("like")!=null){

int id=Integer.parseInt(request.getParameter("like"));

PreparedStatement chk=con.prepareStatement(
"SELECT 1 FROM idea_votes WHERE idea_id=? AND faculty_id=?");
chk.setInt(1,id);
chk.setString(2,facultyId);

ResultSet r=chk.executeQuery();

if(!r.next()){

PreparedStatement ins=con.prepareStatement(
"INSERT INTO idea_votes(idea_id,faculty_id,vote_type) VALUES(?,?,?)");
ins.setInt(1,id);
ins.setString(2,facultyId);
ins.setString(3,"LIKE");
ins.executeUpdate();

PreparedStatement up=con.prepareStatement(
"UPDATE submissions SET score=IFNULL(score,0)+1 WHERE id=?");
up.setInt(1,id);
up.executeUpdate();

ins.close();
up.close();
}

r.close();
chk.close();

response.sendRedirect("studentsSubmittedIdeas.jsp");
}

// ================= DISLIKE =================
if(request.getParameter("dislike")!=null){

int id=Integer.parseInt(request.getParameter("dislike"));

PreparedStatement chk=con.prepareStatement(
"SELECT 1 FROM idea_votes WHERE idea_id=? AND faculty_id=?");
chk.setInt(1,id);
chk.setString(2,facultyId);

ResultSet r=chk.executeQuery();

if(!r.next()){

PreparedStatement ins=con.prepareStatement(
"INSERT INTO idea_votes(idea_id,faculty_id,vote_type) VALUES(?,?,?)");
ins.setInt(1,id);
ins.setString(2,facultyId);
ins.setString(3,"DISLIKE");
ins.executeUpdate();

ins.close();
}

r.close();
chk.close();

response.sendRedirect("studentsSubmittedIdeas.jsp");
}

// ================= SAVE REMARK =================
if(request.getParameter("saveRemark")!=null){

int ideaId=Integer.parseInt(request.getParameter("ideaId"));
String remark=request.getParameter("remark");

PreparedStatement checkRemark=con.prepareStatement(
"SELECT 1 FROM remarks WHERE idea_id=? AND faculty_id=?");

checkRemark.setInt(1,ideaId);
checkRemark.setString(2,facultyId);

ResultSet cr=checkRemark.executeQuery();

if(!cr.next()){

PreparedStatement psr=con.prepareStatement(
"INSERT INTO remarks(idea_id,faculty_id,remark) VALUES(?,?,?)");

psr.setInt(1,ideaId);
psr.setString(2,facultyId);
psr.setString(3,remark);
psr.executeUpdate();

psr.close();
}

cr.close();
checkRemark.close();

response.sendRedirect("studentsSubmittedIdeas.jsp");
}

// ================= FETCH =================
String query=
"SELECT s.srno,s.sname,s.dname,s.year,s.sem,"+
"i.id,i.idea_title,i.idea_description,i.score,i.filename,i.filepath,"+

"(SELECT 1 FROM idea_votes v WHERE v.idea_id=i.id AND v.faculty_id=?) AS voted,"+
"(SELECT 1 FROM remarks r WHERE r.idea_id=i.id AND r.faculty_id=?) AS remarked "+

"FROM student s INNER JOIN submissions i "+
"ON s.srno=i.student_id ORDER BY i.score DESC";

ps=con.prepareStatement(query);
ps.setString(1,facultyId);
ps.setString(2,facultyId);

rs=ps.executeQuery();

while(rs.next()){

boolean voted = rs.getObject("voted") != null;
boolean remarked = rs.getObject("remarked") != null;
%>

<tr>

<td><%=rs.getString("srno")%></td>
<td><%=rs.getString("sname")%></td>
<td><%=rs.getString("dname")%></td>
<td><%=rs.getString("year")%></td>
<td><%=rs.getString("sem")%></td>

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

<td><span class="badge bg-success"><%=rs.getInt("score")%></span></td>

<td>
<% if(!voted){ %>
<a href="?like=<%=rs.getInt("id")%>" class="like"><i class="fas fa-thumbs-up"></i></a>
&nbsp;&nbsp;
<a href="?dislike=<%=rs.getInt("id")%>" class="dislike"><i class="fas fa-thumbs-down"></i></a>
<% } else { %>
<span class="badge bg-secondary">Already Voted</span>
<% } %>
</td>

<td>
<% if(!remarked){ %>
<button class="btn btn-primary btn-sm" onclick="openRemark('<%=rs.getInt("id")%>')">💬</button>
<% } else { %>
<span class="badge bg-success">Remark Added</span>
<% } %>
</td>

</tr>

<%
}

}catch(Exception e){
out.println(e);
}
%>

</tbody>
</table>

</div>
</div>
</div>
</div>

<!-- REMARK MODAL -->
<div class="modal fade" id="remarkModal">
<div class="modal-dialog">
<div class="modal-content">

<form method="post">
<div class="modal-header">
<h5>Add Remark</h5>
<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
</div>

<div class="modal-body">
<input type="hidden" name="ideaId" id="ideaId">
<textarea name="remark" class="form-control" required></textarea>
</div>

<div class="modal-footer">
<button type="submit" name="saveRemark" class="btn btn-success">Save</button>
</div>

</form>

</div>
</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

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

<script>
function openRemark(id){
document.getElementById("ideaId").value=id;
new bootstrap.Modal(document.getElementById('remarkModal')).show();
}
</script>

</body>
</html>