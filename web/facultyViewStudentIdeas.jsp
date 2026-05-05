<%@page import="java.sql.*"%>
<%@page contentType="text/html;charset=UTF-8"%>

<%
int totalIdeas = 0;
int totalStudents = 0;
int submittedStudents = 0;

Connection con = null;

try {

Class.forName("com.mysql.jdbc.Driver");

con = DriverManager.getConnection(
"jdbc:mysql://localhost:3306/studentinnvotive",
"root",
"root"
);

Statement st = con.createStatement();

/* Total Ideas */
ResultSet rs = st.executeQuery("SELECT COUNT(*) FROM submissions");
if(rs.next()) totalIdeas = rs.getInt(1);

/* Total Students */
rs = st.executeQuery("SELECT COUNT(*) FROM student");
if(rs.next()) totalStudents = rs.getInt(1);

/* Students Submitted Ideas */
rs = st.executeQuery("SELECT COUNT(DISTINCT student_id) FROM submissions");
if(rs.next()) submittedStudents = rs.getInt(1);

} catch(Exception e){
out.println("<p class='text-danger'>Error : "+e.getMessage()+"</p>");
}
%>

<!DOCTYPE html>
<html>
<head>

<title>Student Ideas</title>

<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

<style>

body{
font-family:'Segoe UI';
background:#f0f4f7;
}

.card:hover{
transform:scale(1.02);
transition:0.2s;
}

.ranking{
font-weight:bold;
color:#fff;
padding:5px 10px;
border-radius:50%;
display:inline-block;
}

.ranking-1{background:#ffd700;}
.ranking-2{background:#c0c0c0;}
.ranking-3{background:#cd7f32;}
.ranking-default{background:#6c757d;}

.search-box{
max-width:400px;
margin-bottom:20px;
}

</style>

</head>

<body class="p-4">

<div class="container">

<h2 class="text-center mb-4 text-primary">
Student Submitted Ideas
</h2>

<!-- Dashboard Cards -->

<div class="row g-4 mb-4">

<div class="col-md-4">
<div class="card text-white bg-primary p-3">
<h6>Total Ideas</h6>
<h3><%=totalIdeas%></h3>
</div>
</div>

<div class="col-md-4">
<div class="card text-white bg-success p-3">
<h6>Total Students</h6>
<h3><%=totalStudents%></h3>
</div>
</div>

<div class="col-md-4">
<div class="card text-white bg-warning p-3">
<h6>Students Submitted</h6>
<h3><%=submittedStudents%></h3>
</div>
</div>

</div>

<!-- Search -->

<div class="d-flex justify-content-between flex-wrap mb-3">

<input id="searchInput"
type="text"
class="form-control search-box"
placeholder="Search idea title">

<button class="btn btn-success ms-2"
onclick="sortIdeas('rank')">
<i class="fa fa-sort-numeric-up"></i>
Sort by Score
</button>

<button class="btn btn-info ms-2"
onclick="sortIdeas('title')">
<i class="fa fa-sort-alpha-up"></i>
Sort by Title
</button>

</div>

<!-- Idea Cards -->

<div class="row" id="ideasContainer">

<%

try{

Statement stIdeas = con.createStatement();

ResultSet rsIdeas = stIdeas.executeQuery(

"SELECT s.sname, "+
"i.idea_title, "+
"i.idea_description, "+
"i.score, "+
"i.submission_date "+
"FROM submissions i "+
"JOIN student s ON i.student_id = s.srno "+
"ORDER BY i.score DESC"

);

while(rsIdeas.next()){

int score = rsIdeas.getInt("score");

String rankClass="ranking-default";

if(score==1) rankClass="ranking-1";
else if(score==2) rankClass="ranking-2";
else if(score==3) rankClass="ranking-3";

%>

<div class="col-md-4 mb-4 idea-card"

data-title="<%=rsIdeas.getString("idea_title").toLowerCase()%>"

data-rank="<%=score%>">

<div class="card shadow-sm h-100">

<div class="card-body">

<span class="ranking <%=rankClass%>">
<%=score%>
</span>

<h5 class="card-title mt-2">
<%=rsIdeas.getString("idea_title")%>
</h5>

<p class="card-text">
<%=rsIdeas.getString("idea_description")%>
</p>

<p class="text-muted mb-1">
<strong>Submitted by:</strong>
<%=rsIdeas.getString("sname")%>
</p>

<p class="text-muted">
<strong>Date:</strong>
<%=rsIdeas.getDate("submission_date")%>
</p>

</div>
</div>
</div>

<%
}

}catch(Exception e){

out.println("<p class='text-danger'>Error fetching ideas : "+e.getMessage()+"</p>");

}

%>

</div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>

/* Search */

document.getElementById("searchInput")
.addEventListener("input",function(){

let filter=this.value.toLowerCase();

let cards=document.querySelectorAll(".idea-card");

cards.forEach(card=>{

let title=card.dataset.title;

card.style.display=title.includes(filter)?"":"none";

});

});

/* Sorting */

function sortIdeas(criteria){

let container=document.getElementById("ideasContainer");

let cards=Array.from(container.getElementsByClassName("idea-card"));

if(criteria==="rank"){
cards.sort((a,b)=>b.dataset.rank-a.dataset.rank);
}

else if(criteria==="title"){
cards.sort((a,b)=>a.dataset.title.localeCompare(b.dataset.title));
}

cards.forEach(card=>container.appendChild(card));

}

</script>

</body>
</html>