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

if(request.getParameter("msg") != null){
%>
<script>alert("Staff Added Successfully.");</script>
<%
}
if(request.getParameter("msg1") != null){
%>
<script>alert("Staff Adding Failed.");</script>
<%
}
%>

<%
String eid="";
Connection con1=null;
Statement stmt1=null;
ResultSet rs=null;

try{
    Class.forName("com.mysql.jdbc.Driver");
    con1 = DriverManager.getConnection("jdbc:mysql://localhost:3306/studentinnvotive","root","root");
    stmt1 = con1.createStatement();
    rs = stmt1.executeQuery("select count(*) from staff");

    int c=0;
    if(rs.next()){
        c = rs.getInt(1);
    }
    c++;
    eid="FID"+c;

}catch(Exception e){
    e.printStackTrace();
}
finally{
    if(rs!=null) rs.close();
    if(stmt1!=null) stmt1.close();
    if(con1!=null) con1.close();
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Staff</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

<style>
body{
    background:#f4f6f9;  /* Admin clean background */
}

.card{
    border-radius:10px;
}

.card-header{
    background:#003366;
    color:white;
    font-weight:600;
    text-align:center;
    font-size:18px;
}

.form-control{
    border-radius:6px;
}

.btn-custom{
    background:#003366;
    color:white;
    border-radius:6px;
}

.btn-custom:hover{
    background:#FA3C16;
}
</style>
</head>

<body>

<div class="container-fluid mt-4">

<div class="row justify-content-center">
<div class="col-lg-8 col-md-10">

<div class="card shadow">

<div class="card-header">
Add Staff
</div>

<div class="card-body">

<form action="insertStaff.jsp" method="post">

<div class="form-row">

<div class="form-group col-md-6">
<label>Staff ID</label>
<input type="text" name="sid" value="<%=eid%>" class="form-control" readonly>
</div>

<div class="form-group col-md-6">
<label>Staff Name</label>
<input type="text" name="sname" class="form-control" required>
</div>

</div>

<div class="form-row">

<div class="form-group col-md-6">
<label>Department</label>
<select name="dname" class="form-control" required>
<option value="">--Select Department--</option>
<option>CSE</option>
<option>ECE</option>
<option>EEE</option>
<option>CIVIL</option>
<option>MCA</option>
</select>
</div>

<div class="form-group col-md-6">
<label>Designation</label>
<select name="desg" class="form-control" required>
<option value="">--Select Designation--</option>
<option>Professor</option>
<option>Associate Professor</option>
<option>Assistant Professor</option>
</select>
</div>

</div>

<div class="form-row">

<div class="form-group col-md-6">
<label>Password</label>
<input type="text" name="password" value="12345" class="form-control" required>
</div>

<div class="form-group col-md-6 d-flex align-items-end">
<button type="submit" class="btn btn-custom btn-block">
Create Staff
</button>
</div>

</div>

</form>

</div>
</div>

</div>
</div>

</div>

</body>
</html>
