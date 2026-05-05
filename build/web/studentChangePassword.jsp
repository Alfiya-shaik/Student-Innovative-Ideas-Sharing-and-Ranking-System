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

<title>Change Password</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">

<style>

body{
background:linear-gradient(135deg,#4e73df,#1cc88a);
font-family:'Segoe UI';
}

.card{
margin-top:60px;
border-radius:20px;
}

.card-header{
background:#343a40;
color:white;
text-align:center;
font-size:18px;
font-weight:bold;
border-top-left-radius:20px;
border-top-right-radius:20px;
}

.form-control:focus{
box-shadow:none;
border-color:#4e73df;
}

.btn-custom{
background:#4e73df;
color:white;
font-weight:600;
}

.btn-custom:hover{
background:#2e59d9;
}

.input-group-text{
cursor:pointer;
}

</style>

<script>
function togglePassword(id){
var field=document.getElementById(id);
field.type = field.type === "password" ? "text" : "password";
}
</script>

</head>

<body>

<div class="container">
<div class="row justify-content-center">
<div class="col-md-6">

<div class="card shadow">

<div class="card-header">
🔐 Change Password
</div>

<div class="card-body">

<%

String message="";
String color="";


if("POST".equalsIgnoreCase(request.getMethod())){

String email=(String)session.getAttribute("studentname");

String current=request.getParameter("currentPassword");
String newpass=request.getParameter("newPassword");
String confirm=request.getParameter("confirmPassword");

if(!newpass.equals(confirm)){

message="New Password and Confirm Password do not match!";
color="danger";

}else{

Connection con=null;
PreparedStatement ps=null, ps1=null;
ResultSet rs=null;

try{

Class.forName("com.mysql.jdbc.Driver");

con=DriverManager.getConnection(
"jdbc:mysql://localhost:3306/studentinnvotive",
"root",
"root"
);

ps=con.prepareStatement(
"SELECT * FROM student WHERE srno=? AND password=?"
);

ps.setString(1,email);
ps.setString(2,current);

rs=ps.executeQuery();

if(rs.next()){

ps.close();

ps=con.prepareStatement(
"UPDATE student SET password=? WHERE srno=?"
);

ps.setString(1,newpass);
ps.setString(2,email);

ps1=con.prepareStatement(
"UPDATE login SET password=? WHERE username=?"
);

ps1.setString(1,newpass);
ps1.setString(2,email);

ps.executeUpdate();
ps1.executeUpdate();

message="Password Changed Successfully!";
color="success";

}else{

message="Current Password is Incorrect!";
color="danger";

}

}catch(Exception e){

message="Error Occurred!";
color="danger";
e.printStackTrace();

}finally{

if(rs!=null) rs.close();
if(ps!=null) ps.close();
if(con!=null) con.close();

}

}

}

%>

<% if(!message.equals("")){ %>

<div class="alert alert-<%=color%> text-center">
<%=message%>
</div>

<% } %>

<form method="post">

<div class="mb-3">

<label class="form-label">Current Password</label>

<div class="input-group">

<input type="password" name="currentPassword"
id="currentPassword" class="form-control" required>

<span class="input-group-text"
onclick="togglePassword('currentPassword')">

<i class="fa fa-eye"></i>

</span>

</div>

</div>

<div class="mb-3">

<label class="form-label">New Password</label>

<div class="input-group">

<input type="password" name="newPassword"
id="newPassword" class="form-control" required>

<span class="input-group-text"
onclick="togglePassword('newPassword')">

<i class="fa fa-eye"></i>

</span>

</div>

</div>

<div class="mb-3">

<label class="form-label">Confirm Password</label>

<div class="input-group">

<input type="password" name="confirmPassword"
id="confirmPassword" class="form-control" required>

<span class="input-group-text"
onclick="togglePassword('confirmPassword')">

<i class="fa fa-eye"></i>

</span>

</div>

</div>

<div class="d-grid">

<button type="submit" class="btn btn-custom">
<i class="fas fa-key"></i> Update Password
</button>

</div>

</form>

</div>
</div>

</div>
</div>
</div>

</body>
</html>