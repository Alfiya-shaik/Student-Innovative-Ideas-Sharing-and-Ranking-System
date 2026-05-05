<%@ page language="java" contentType="text/html; charset=UTF-8"%>

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
<script>alert("Student Added Successfully.");</script>
<%
}

if(request.getParameter("msg1") != null){
%>
<script>alert("Student Adding Failed.");</script>
<%
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Student</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body{
    background:#f4f6f9;   /* Admin clean background */
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
Add Student
</div>

<div class="card-body">

<form action="insertStudent.jsp" method="post">

<div class="form-row">

<div class="form-group col-md-6">
<label>Student Roll No</label>
<input type="text" name="sid" class="form-control" required>
</div>

<div class="form-group col-md-6">
<label>Student Name</label>
<input type="text" name="sname" class="form-control" required>
</div>
    
<div class="form-group col-md-6">
<label>Student Email</label>
<input type="email" name="email" class="form-control" required>
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
<label>Year</label>
<select name="year" class="form-control" required>
<option value="">--Select Year--</option>
<option>I</option>
<option>II</option>
<option>III</option>
<option>IV</option>
</select>
</div>

</div>

<div class="form-row">

<div class="form-group col-md-6">
<label>Semester</label>
<select name="sem" class="form-control" required>
<option value="">--Select Semester--</option>
<option>I</option>
<option>II</option>
</select>
</div>

<div class="form-group col-md-6">
<label>Password</label>
<input type="text" name="password" value="12345" class="form-control" required>
</div>

</div>

<button type="submit" class="btn btn-custom btn-block">
Create Student
</button>

</form>

</div>
</div>

</div>
</div>

</div>

</body>
</html>
