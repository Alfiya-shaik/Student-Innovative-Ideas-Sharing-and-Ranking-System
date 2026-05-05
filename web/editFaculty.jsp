<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<%
 String facultyname = session.getAttribute("facultyname").toString();
if(session.getAttribute("facultyname") == null){
%>
<script>
    window.top.location.href="login.jsp";
</script>
<%
    return;
}
%>

<%
String id = request.getParameter("id");

String facultyId="";
String name="";
String password="";
String dept="";
String designation="";
String status="";

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

    // UPDATE LOGIC
    if(request.getParameter("update") != null){

        facultyId=facultyname;
        name=request.getParameter("name");
        password=request.getParameter("password");
        dept=request.getParameter("department");
        designation=request.getParameter("designation");
        status=request.getParameter("status");

        ps=con.prepareStatement(
        "UPDATE staff SET stname=?, dname=?, designation=?, password=? WHERE stid=?");

        ps.setString(1,name);
        ps.setString(2,dept);
        ps.setString(3,designation);
        ps.setString(4, password);
        
        ps.setString(5,facultyId);
        System.out.println(ps);
        ps1 = con.prepareStatement("update login set password=? where username=?");
        ps1.setString(1, password);
        ps1.setString(2,facultyId);

        ps.executeUpdate();
        ps1.executeUpdate();
%>
<script>
alert("Faculty Updated Successfully!");
window.location="viewFacultyProfile.jsp";
</script>
<%
    }
    
    // LOAD DATA
    if(facultyname != null){
        ps=con.prepareStatement("SELECT * FROM staff WHERE stid=?");
        ps.setString(1,facultyname);
        rs=ps.executeQuery();

        if(rs.next()){
            facultyId=rs.getString("stid");
            name=rs.getString("stname");
            
            dept=rs.getString("dname");
            designation=rs.getString("designation");
            password=rs.getString("password");
            status=rs.getString("status");
        }
    }

}catch(Exception e){
    e.printStackTrace();
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Faculty</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body{
    background:#f4f6f9;
}

.card{
    border-radius:15px;
}

.card-header{
    background:#4e73df;
    color:white;
    text-align:center;
    font-weight:600;
}

.form-control{
    border-radius:10px;
}

.btn-primary{
    border-radius:20px;
    padding:8px 25px;
}
</style>
</head>

<body>

<div class="container mt-4">

<div class="card shadow">

<div class="card-header">
    Edit Faculty Details
</div>

<div class="card-body">

<form method="post">

<input type="hidden" name="facultyId" value="<%=facultyId%>">

<div class="row mb-3">
    <label class="col-md-3 col-form-label">Faculty Name</label>
    <div class="col-md-9">
        <input type="text" name="name" class="form-control"
               value="<%=name%>" required>
    </div>
</div>

<div class="row mb-3">
    <label class="col-md-3 col-form-label">Password</label>
    <div class="col-md-9">
        <input type="text" name="password" class="form-control"
               value="<%=password%>" required>
    </div>
</div>

<div class="row mb-3">
    <label class="col-md-3 col-form-label">Department</label>
    <div class="col-md-9">
        <input type="text" name="department" class="form-control"
               value="<%=dept%>" required>
    </div>
</div>

<div class="row mb-3">
    <label class="col-md-3 col-form-label">Designation</label>
    <div class="col-md-9">
        <input type="text" name="designation" class="form-control"
               value="<%=designation%>" required>
    </div>
</div>

<div class="row mb-4">
    <label class="col-md-3 col-form-label">Status</label>
    <div class="col-md-9">
        <select name="status" class="form-control" required>
            <option value="Active" <%=status.equals("Active")?"selected":""%>>
                Active
            </option>
            <option value="Inactive" <%=status.equals("Inactive")?"selected":""%>>
                Inactive
            </option>
        </select>
    </div>
</div>

<div class="text-center">
    <button type="submit" name="update" class="btn btn-primary">
        Update Faculty
    </button>

    <a href="viewFacultyProfile.jsp" class="btn btn-secondary ms-2">
        Cancel
    </a>
</div>

</form>

</div>
</div>

</div>

</body>
</html>
