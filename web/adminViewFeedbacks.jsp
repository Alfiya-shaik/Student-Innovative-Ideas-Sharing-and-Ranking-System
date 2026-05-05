<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<%
if(session.getAttribute("username")==null){
%>
<script>
    window.top.location.href="adminLogin.jsp";
</script>
<%
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>View Student Feedbacks</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">

<style>
body{
    background:#f4f6f9;
    font-family:'Segoe UI',sans-serif;
}

.card{
    margin-top:20px;
    border-radius:15px;
}

.card-header{
    background:linear-gradient(90deg,#4e73df,#36b9cc);
    color:white;
    font-weight:bold;
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

.star{
    color:gold;
}

.badge-category{
    font-size:12px;
}
</style>

</head>

<body>

<div class="container-fluid">

<div class="card shadow">

<div class="card-header">
    💬 Student Feedbacks
</div>

<div class="card-body">

<!-- FILTER SECTION -->
<form method="get" class="row g-3 mb-4">

<div class="col-md-3">
<label class="form-label">From Date</label>
<input type="date" name="fromDate" class="form-control" value="<%=request.getParameter("fromDate")!=null?request.getParameter("fromDate"):""%>">
</div>

<div class="col-md-3">
<label class="form-label">To Date</label>
<input type="date" name="toDate" class="form-control" value="<%=request.getParameter("toDate")!=null?request.getParameter("toDate"):""%>">
</div>

<div class="col-md-3 d-flex align-items-end">
<button type="submit" class="btn btn-primary w-100">
<i class="fas fa-filter"></i> Filter
</button>
</div>

<div class="col-md-3 d-flex align-items-end">
<a href="adminViewFeedbacks.jsp" class="btn btn-secondary w-100">
<i class="fas fa-rotate"></i> Reset
</a>
</div>

</form>

<div class="table-responsive">

<table class="table table-bordered table-hover">

<thead>
<tr>
    <th>ID</th>
    <th>Student</th>
    <th>Category</th>
    <th>Rating</th>
    <th>Message</th>
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

    String fromDate=request.getParameter("fromDate");
    String toDate=request.getParameter("toDate");

    String query=
    "SELECT f.*, s.sname " +
    "FROM feedback f " +
    "INNER JOIN student s ON f.student_id=s.srno ";

    if(fromDate!=null && toDate!=null &&
       !fromDate.equals("") && !toDate.equals("")){
        query += "WHERE DATE(f.feedback_date) BETWEEN ? AND ? ";
    }

    query += "ORDER BY f.feedback_date DESC";

    ps=con.prepareStatement(query);

    if(fromDate!=null && toDate!=null &&
       !fromDate.equals("") && !toDate.equals("")){
        ps.setString(1,fromDate);
        ps.setString(2,toDate);
    }

    rs=ps.executeQuery();

    while(rs.next()){
%>

<tr>
<td><%=rs.getInt("feedback_id")%></td>

<td><%=rs.getString("sname")%></td>

<td>
<span class="badge bg-info badge-category">
<%=rs.getString("category")%>
</span>
</td>

<td>
<%
int rating=rs.getInt("rating");
for(int i=1;i<=5;i++){
    if(i<=rating){
%>
<i class="fa fa-star star"></i>
<%
    }else{
%>
<i class="fa fa-star text-muted"></i>
<%
    }
}
%>
</td>

<td style="text-align:left;">
<%=rs.getString("message")%>
</td>

<td><%=rs.getTimestamp("feedback_date")%></td>

</tr>

<%
    }

}catch(Exception e){
%>
<tr>
<td colspan="6" class="text-danger">Error Loading Feedbacks</td>
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
