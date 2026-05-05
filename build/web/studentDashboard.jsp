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
<meta charset="UTF-8">
<title>Student Dashboard</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">

<style>
body{
    background:#f4f6f9;
    font-family:'Segoe UI', sans-serif;
}

.dashboard-header{
    font-size:22px;
    font-weight:600;
    margin-bottom:20px;
}

.card-box{
    border-radius:15px;
    color:white;
    padding:20px;
    transition:0.3s;
    box-shadow:0 4px 15px rgba(0,0,0,0.1);
}

.card-box:hover{
    transform:translateY(-5px);
}

.bg1{ background:linear-gradient(45deg,#4e73df,#224abe); }
.bg2{ background:linear-gradient(45deg,#1cc88a,#13855c); }
.bg3{ background:linear-gradient(45deg,#f6c23e,#dda20a); }
.bg4{ background:linear-gradient(45deg,#e74a3b,#be2617); }
.bg5{ background:linear-gradient(45deg,#36b9cc,#258391); }

.card-box i{
    font-size:28px;
}

.card-box h4{
    margin-top:10px;
    font-size:26px;
    font-weight:600;
}

</style>

</head>

<body>

<div class="container-fluid mt-4">

<div class="dashboard-header">
    Welcome, <%=session.getAttribute("studentname")%> 👋
</div>

<%
Connection con=null;
PreparedStatement ps=null;
ResultSet rs=null;

int totalIdeas=0;
int approved=0;
int pending=0;
int rejected=0;
int totalEvents=0;

try{
    Class.forName("com.mysql.jdbc.Driver");
    con=DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/studentinnvotive",
        "root",
        "root"
    );

    String studentId= session.getAttribute("studentname").toString();

    // Total Ideas
    ps=con.prepareStatement("SELECT COUNT(*) FROM submissions WHERE student_id=?");
    ps.setString(1,studentId);
    rs=ps.executeQuery();
    if(rs.next()) totalIdeas=rs.getInt(1);
    rs.close(); ps.close();

    // Approved
   /* ps=con.prepareStatement("SELECT COUNT(*) FROM submissions WHERE student_id=? AND status='Approved'");
    ps.setString(1,studentId);
    rs=ps.executeQuery();
    if(rs.next()) approved=rs.getInt(1);
    rs.close(); ps.close();

    // Pending
    ps=con.prepareStatement("SELECT COUNT(*) FROM submissions WHERE student_id=? AND status='Pending'");
    ps.setString(1,studentId);
    rs=ps.executeQuery();
    if(rs.next()) pending=rs.getInt(1);
    rs.close(); ps.close();

    // Rejected
    ps=con.prepareStatement("SELECT COUNT(*) FROM submissions WHERE student_id=? AND status='Rejected'");
    ps.setString(1,studentId); 
    rs=ps.executeQuery();
    if(rs.next()) rejected=rs.getInt(1);
    rs.close(); ps.close();*/

    // Events
    ps=con.prepareStatement("SELECT COUNT(*) FROM event");
    rs=ps.executeQuery();
    if(rs.next()) totalEvents=rs.getInt(1);

}catch(Exception e){
    e.printStackTrace();
}
finally{
    if(rs!=null) rs.close();
    if(ps!=null) ps.close();
    if(con!=null) con.close();
}
%>

<div class="row g-4">

<div class="col-md-4">
<div class="card-box bg1">
    <i class="fas fa-lightbulb"></i>
    <h4><%=totalIdeas%></h4>
    <div>Total Ideas Submitted</div>
</div>
</div>

<!--<div class="col-md-4">
<div class="card-box bg2">
    <i class="fas fa-check-circle"></i>
    <h4><%=approved%></h4>
    <div>Approved Ideas</div>
</div>
</div>

<div class="col-md-4">
<div class="card-box bg3">
    <i class="fas fa-hourglass-half"></i>
    <h4><%=pending%></h4>
    <div>Pending Ideas</div>
</div>
</div>

<div class="col-md-6">
<div class="card-box bg4">
    <i class="fas fa-times-circle"></i>
    <h4><%=rejected%></h4>
    <div>Rejected Ideas</div>
</div>
</div>-->

<div class="col-md-4">
<div class="card-box bg5">
    <i class="fas fa-calendar"></i>
    <h4><%=totalEvents%></h4>
    <div>Total Events</div>
</div>
</div>

</div>

</div>

</body>
</html>
