<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<%
if(session.getAttribute("facultyname")==null){
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
<title>Change Password</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body{
    background:#f4f6f9;
}

.card{
    max-width:500px;
    margin:auto;
    margin-top:60px;
    border-radius:15px;
}

.card-header{
    background:linear-gradient(90deg,#e74a3b,#f6c23e);
    color:white;
    text-align:center;
    font-weight:600;
    font-size:18px;
}
</style>

<script>
function togglePassword(id){
    var x=document.getElementById(id);
    if(x.type==="password"){
        x.type="text";
    }else{
        x.type="password";
    }
}
</script>

</head>

<body>

<div class="card shadow">

<div class="card-header">
    🔐 Faculty Change Password
</div>

<div class="card-body">

<%
String message="";
String messageType="";

if(request.getMethod().equalsIgnoreCase("POST")){

    String oldPass=request.getParameter("oldPassword");
    String newPass=request.getParameter("newPassword");
    String confirmPass=request.getParameter("confirmPassword");

    if(!newPass.equals(confirmPass)){
        message="New Password and Confirm Password do not match!";
        messageType="danger";
    }else{

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

            String facultyName=(String)session.getAttribute("facultyname");

            // Verify old password
            ps=con.prepareStatement(
                "SELECT * FROM staff WHERE stid=? AND password=?"
            );
            ps.setString(1, facultyName);
            ps.setString(2, oldPass);

            rs=ps.executeQuery();

            if(rs.next()){

                PreparedStatement psUpdate=con.prepareStatement(
                    "UPDATE login SET password=? WHERE username=?"
                );
                psUpdate.setString(1,newPass);
                psUpdate.setString(2,facultyName);
                
                PreparedStatement psUpdate1=con.prepareStatement(
                    "UPDATE staff SET password=? WHERE stid=?"
                );
                psUpdate1.setString(1,newPass);
                psUpdate1.setString(2,facultyName);

                int i=psUpdate.executeUpdate();
                int j=psUpdate1.executeUpdate();
                if(i>0 && j>0){
                    message="Password Changed Successfully!";
                    messageType="success";
                }else{
                    message="Password Update Failed!";
                    messageType="danger";
                }

                psUpdate.close();
            }else{
                message="Old Password Incorrect!";
                messageType="danger";
            }

        }catch(Exception e){
            message="Something went wrong!";
            messageType="danger";
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
<div class="alert alert-<%=messageType%>">
    <%=message%>
</div>
<% } %>

<form method="post">

<div class="mb-3">
<label>Old Password</label>
<input type="password" name="oldPassword" id="oldPassword" 
class="form-control" required>
<input type="checkbox" onclick="togglePassword('oldPassword')"> Show
</div>

<div class="mb-3">
<label>New Password</label>
<input type="password" name="newPassword" id="newPassword" 
class="form-control" required>
<input type="checkbox" onclick="togglePassword('newPassword')"> Show
</div>

<div class="mb-3">
<label>Confirm Password</label>
<input type="password" name="confirmPassword" id="confirmPassword" 
class="form-control" required>
<input type="checkbox" onclick="togglePassword('confirmPassword')"> Show
</div>

<div class="text-center">
<button type="submit" class="btn btn-danger px-4">
Update Password
</button>
</div>

</form>

</div>
</div>

</body>
</html>
