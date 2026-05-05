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
<title>Student Profile</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body{
    background:#f4f6f9;
    font-family:'Segoe UI',sans-serif;
}

.card{
    max-width:700px;
    margin:auto;
    margin-top:30px;
    border-radius:15px;
}

.card-header{
    background:linear-gradient(90deg,#4e73df,#1cc88a);
    color:white;
    font-weight:600;
    text-align:center;
    font-size:18px;
}

.profile-label{
    font-weight:600;
}
</style>

</head>

<body>

<div class="container">

<div class="card shadow">

<div class="card-header">
    👤 Student Profile
</div>

<div class="card-body">

<%
Connection con=null;
PreparedStatement ps=null;
ResultSet rs=null;

//int studentId=(Integer)session.getAttribute("studentid");
String studentId = session.getAttribute("studentname").toString();
String message="";

try{
    Class.forName("com.mysql.jdbc.Driver");
    con=DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/studentinnvotive",
        "root",
        "root"
    );

    // Update Profile
    if(request.getMethod().equalsIgnoreCase("POST")){

        String name=request.getParameter("name");
        String email=request.getParameter("email");
        String dept=request.getParameter("department");
        String year=request.getParameter("year");
        String sem=request.getParameter("sem");
        

        ps=con.prepareStatement(
        "UPDATE student SET stname=?, dnam=?, year=?, sem=? WHERE srno=?");

        ps.setString(1,name);
        ps.setString(3,dept);
        ps.setString(4,year);
        ps.setString(5,sem);
        ps.setString(6,studentId);

        int i=ps.executeUpdate();

        if(i>0){
            message="Profile Updated Successfully!";
            session.setAttribute("studentname",name);
        }

        ps.close();
    }

    // Fetch Profile
    ps=con.prepareStatement("SELECT * FROM student WHERE srno=?");
    ps.setString(1,studentId);
    rs=ps.executeQuery();

    if(rs.next()){
%>

<% if(!message.equals("")){ %>
<div class="alert alert-success">
    <%=message%>
</div>
<% } %>

<form method="post">

<div class="row mb-3">
<div class="col-md-6">
<label class="profile-label">Full Name</label>
<input type="text" name="name" class="form-control"
value="<%=rs.getString("sname")%>" required>
</div>

<div class="row mb-3">
<div class="col-md-6">
<label class="profile-label">Department</label>
<input type="text" name="department" class="form-control"
value="<%=rs.getString("dname")%>" required>
</div>

<div class="row mb-3">
<div class="col-md-6">
<label class="profile-label">Year</label>
<input type="text" name="year" class="form-control"
value="<%=rs.getString("year")%>" required>
</div>



<div class="row mb-3">
<div class="col-md-6">
<label class="profile-label">Semister</label>
<input type="text" name="sem" class="form-control"
value="<%=rs.getString("sem")%>" required>
</div>
</div>

<div class="text-center">
<button type="submit" class="btn btn-success px-4">
Update Profile
</button>
</div>

</form>

<%
    }

}catch(Exception e){
    out.println("<div class='alert alert-danger'>Error Loading Profile</div>");
    e.printStackTrace();
}
finally{
    if(rs!=null) rs.close();
    if(ps!=null) ps.close();
    if(con!=null) con.close();
}
%>

</div>
</div>

</div>

</body>
</html>
