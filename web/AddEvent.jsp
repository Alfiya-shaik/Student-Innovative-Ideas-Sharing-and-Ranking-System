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
String eventId="";
Connection con=null;
Statement stmt=null;
ResultSet rs=null;

try{
    Class.forName("com.mysql.jdbc.Driver");
    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/studentinnvotive","root","root");
    stmt = con.createStatement();
    rs = stmt.executeQuery("select count(*) from event");

    int c=0;
    if(rs.next()){
        c = rs.getInt(1);
    }
    c++;
    eventId="EID"+c;

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
<title>Add Event</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" rel="stylesheet">

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

.btn-custom{
    background:#003366;
    color:white;
}

.btn-custom:hover{
    background:#001f3f;
}
</style>

<script>
function addCategory(){
    var container = document.getElementById("categoryContainer");

    var div = document.createElement("div");
    div.className = "input-group mb-2";

    div.innerHTML = `
        <input type="text" name="categories" class="form-control" placeholder="Enter Category" required>
        <div class="input-group-append">
            <button class="btn btn-danger" type="button" onclick="removeCategory(this)">Remove</button>
        </div>
    `;

    container.appendChild(div);
}

function removeCategory(btn){
    btn.parentElement.parentElement.remove();
}
</script>

</head>

<body>

<div class="container-fluid mt-4">

<div class="row justify-content-center">
<div class="col-lg-8 col-md-10">

<div class="card shadow">

<div class="card-header">
Add Event Details
</div>

<div class="card-body">

<form action="insertEvent.jsp" method="post">

<div class="form-row">

<div class="form-group col-md-6">
<label>Event ID</label>
<input type="text" name="event_id" value="<%=eventId%>" class="form-control" readonly>
</div>

<div class="form-group col-md-6">
<label>Event Name</label>
<input type="text" name="event_name" class="form-control" required>
</div>

</div>

<div class="form-row">

<div class="form-group col-md-6">
<label>Start Date</label>
<input type="date" name="start_date" class="form-control" required>
</div>

<div class="form-group col-md-6">
<label>End Date</label>
<input type="date" name="end_date" class="form-control" required>
</div>

</div>

<div class="form-group">
<label>Categories</label>
<div id="categoryContainer">

<div class="input-group mb-2">
<input type="text" name="categories" class="form-control" placeholder="Enter Category" required>
</div>

</div>

<button type="button" class="btn btn-success btn-sm" onclick="addCategory()">
+ Add Category
</button>

</div>

<button type="submit" class="btn btn-custom btn-block">
Create Event
</button>

</form>

</div>
</div>

</div>
</div>

</div>

</body>
</html>
