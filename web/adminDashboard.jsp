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

<%
int totalEvents = 0;
int closedEvents = 0;
int openEvents = 0;

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

    // Total Events
    rs = stmt.executeQuery("SELECT COUNT(*) FROM EVENT");
    if(rs.next()){
        totalEvents = rs.getInt(1);
    }
    rs.close();

    // Closed Events
    rs = stmt.executeQuery("SELECT COUNT(*) FROM EVENT WHERE status='Closed'");
    if(rs.next()){
        closedEvents = rs.getInt(1);
    }
    rs.close();

    // Open Events
    rs = stmt.executeQuery("SELECT COUNT(*) FROM EVENT WHERE status='Open'");
    if(rs.next()){
        openEvents = rs.getInt(1);
    }

}catch(Exception e){
    e.printStackTrace();
}
finally{
    if(rs!=null) rs.close();
    if(stmt!=null) stmt.close();
    if(con!=null) con.close();
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dashboard</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body{
    background:#f4f6f9;   /* Same as other iframe pages */
}

.card{
    border-radius:15px;
    transition:0.3s;
}

.card:hover{
    transform:translateY(-5px);
}

.card-total{
    background:linear-gradient(45deg,#ff416c,#ff4b2b);
    color:white;
}

.card-closed{
    background:linear-gradient(45deg,#00b09b,#96c93d);
    color:white;
}

.card-open{
    background:linear-gradient(45deg,#396afc,#2948ff);
    color:white;
}

#piechart{
    background:white;
    border-radius:15px;
    padding:20px;
    box-shadow:0 5px 15px rgba(0,0,0,0.1);
}
</style>



<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

<script>
google.charts.load('current', {'packages':['corechart']});
google.charts.setOnLoadCallback(initializeChart);

function initializeChart() {
    // Small delay ensures iframe is fully rendered
    setTimeout(drawChart, 300);
}

function drawChart() {

    var closed = <%= closedEvents %>;
    var open = <%= openEvents %>;

    var data = google.visualization.arrayToDataTable([
        ['Status', 'Count'],
        ['Closed Events', closed],
        ['Open Events', open]
    ]);

    var options = {
        title: 'Event Status Overview',
        is3D: true,
        chartArea: {
            width: '85%',
            height: '75%'
        },
        legend: {
            position: 'bottom'
        }
    };

    var chart = new google.visualization.PieChart(
        document.getElementById('piechart')
    );

    chart.draw(data, options);
}

// Redraw when resizing
window.addEventListener('resize', function() {
    drawChart();
});
</script>


</head>

<body>

<div class="container-fluid mt-4">

<h4 class="mb-4 fw-bold text-dark">Innovative Hub Dashboard</h4>

<div class="row g-4">

<div class="col-md-4">
<div class="card card-total shadow text-center p-4">
<h6>Total Events</h6>
<h2><%= totalEvents %></h2>
</div>
</div>

<div class="col-md-4">
<div class="card card-closed shadow text-center p-4">
<h6>Closed Events</h6>
<h2><%= closedEvents %></h2>
</div>
</div>

<div class="col-md-4">
<div class="card card-open shadow text-center p-4">
<h6>Open Events</h6>
<h2><%= openEvents %></h2>
</div>
</div>

</div>

<div class="row mt-5">
<div class="col-lg-6 col-md-8 mx-auto">
<div id="piechart" style="height:300px;"></div>
</div>
</div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
