<%@page import="java.sql.*"%>
<%
int totalIdeas=0;
int totalStudents=0;
int submittedStudents=0;

try{
Class.forName("com.mysql.jdbc.Driver");
Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/studentinnvotive","root","root");

Statement st=con.createStatement();

ResultSet rs=st.executeQuery("select count(*) from submissions");
if(rs.next()) totalIdeas=rs.getInt(1);

rs=st.executeQuery("select count(*) from student");
if(rs.next()) totalStudents=rs.getInt(1);

rs=st.executeQuery("select count(distinct student_id) from submissions");
if(rs.next()) submittedStudents=rs.getInt(1);

con.close();
}catch(Exception e){}
%>

<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://www.gstatic.com/charts/loader.js"></script>

<script>
google.charts.load('current', {'packages':['corechart']});
google.charts.setOnLoadCallback(drawChart);

function drawChart(){
var data=google.visualization.arrayToDataTable([
['Type','Count'],
['Submitted',<%=submittedStudents%>],
['Not Submitted',<%=totalStudents-submittedStudents%>]
]);

var options={
title:'Student Idea Submission',
is3D:true
};

var chart=new google.visualization.PieChart(document.getElementById('piechart'));
chart.draw(data,options);
}
</script>

</head>
<body class="p-4 bg-light">

<div class="row g-4">

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
<h6>Submitted Students</h6>
<h3><%=submittedStudents%></h3>
</div>
</div>

</div>

<div class="row mt-4">
<div class="col-md-6 mx-auto">
<div id="piechart" style="height:350px;"></div>
</div>
</div>

</body>
</html>
