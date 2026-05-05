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
<title>Student Feedback</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">

<style>
body{
    background:linear-gradient(135deg,#36b9cc,#4e73df);
    font-family:'Segoe UI',sans-serif;
}

.card{
    margin-top:40px;
    border-radius:20px;
}

.card-header{
    background:#343a40;
    color:white;
    text-align:center;
    font-weight:bold;
    font-size:18px;
    border-top-left-radius:20px;
    border-top-right-radius:20px;
}

.star{
    font-size:22px;
    color:#ccc;
    cursor:pointer;
}

.star.checked{
    color:gold;
}

.btn-custom{
    background:#4e73df;
    color:white;
    font-weight:600;
}

.btn-custom:hover{
    background:#2e59d9;
}

textarea{
    resize:none;
}
</style>

<script>
let selectedRating = 0;

function rateStar(rating){
    selectedRating = rating;
    document.getElementById("rating").value = rating;

    let stars = document.getElementsByClassName("star");
    for(let i=0;i<stars.length;i++){
        stars[i].classList.remove("checked");
    }

    for(let i=0;i<rating;i++){
        stars[i].classList.add("checked");
    }
}

function countChars(){
    let text = document.getElementById("message");
    document.getElementById("charCount").innerText = text.value.length;
}
</script>

</head>

<body>

<div class="container">
<div class="row justify-content-center">
<div class="col-md-7">

<div class="card shadow">

<div class="card-header">
    💬 Submit Your Feedback
</div>

<div class="card-body">

<%
String msg="";
String color="";

if("POST".equalsIgnoreCase(request.getMethod())){

    String studentId = session.getAttribute("studentname").toString();
    String category = request.getParameter("category");
    int rating = Integer.parseInt(request.getParameter("rating"));
    String message = request.getParameter("message");

    Connection con=null;
    PreparedStatement ps=null;

    try{
        Class.forName("com.mysql.jdbc.Driver");
        con=DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/studentinnvotive",
            "root",
            "root"
        );

        ps=con.prepareStatement(
        "INSERT INTO feedback(student_id,category,rating,message) VALUES(?,?,?,?)");

        ps.setString(1,studentId);
        ps.setString(2,category);
        ps.setInt(3,rating);
        ps.setString(4,message);

        ps.executeUpdate();

        msg="Thank you! Feedback Submitted Successfully.";
        color="success";

    }catch(Exception e){
        msg="Error Submitting Feedback!";
        color="danger";
        e.printStackTrace();
    }finally{
        if(ps!=null) ps.close();
        if(con!=null) con.close();
    }
}
%>

<% if(!msg.equals("")){ %>
<div class="alert alert-<%=color%> text-center">
    <%=msg%>
</div>
<% } %>

<form method="post">

<!-- Category -->
<div class="mb-3">
<label class="form-label">Feedback Category</label>
<select name="category" class="form-select" required>
    <option value="">-- Select Category --</option>
    <option>Website Experience</option>
    <option>Events</option>
    <option>Idea Submission</option>
    <option>Faculty Support</option>
    <option>Other</option>
</select>
</div>

<!-- Rating -->
<div class="mb-3">
<label class="form-label">Rating</label><br>

<i class="fa fa-star star" onclick="rateStar(1)"></i>
<i class="fa fa-star star" onclick="rateStar(2)"></i>
<i class="fa fa-star star" onclick="rateStar(3)"></i>
<i class="fa fa-star star" onclick="rateStar(4)"></i>
<i class="fa fa-star star" onclick="rateStar(5)"></i>

<input type="hidden" name="rating" id="rating" required>
</div>

<!-- Message -->
<div class="mb-3">
<label class="form-label">Your Feedback</label>
<textarea name="message" id="message" class="form-control"
rows="4" maxlength="500" onkeyup="countChars()" required></textarea>
<small class="text-muted">
Characters: <span id="charCount">0</span>/500
</small>
</div>

<div class="d-grid">
<button type="submit" class="btn btn-custom">
<i class="fas fa-paper-plane"></i> Submit Feedback
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
