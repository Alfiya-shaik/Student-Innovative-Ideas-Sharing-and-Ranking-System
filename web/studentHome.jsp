<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
if(session.getAttribute("studentname")==null){
%>
<script>
    window.location.href="login.jsp";
</script>
<%
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Student Home</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">

<style>
*{
    margin:0;
    padding:0;
    box-sizing:border-box;
}

body{
    font-family:'Segoe UI',sans-serif;
    overflow:hidden;
}

/* ====== Topbar ====== */
.topbar{
    height:60px;
    width:100%;
    background:linear-gradient(90deg,#4e73df,#1cc88a);
    color:white;
    display:flex;
    align-items:center;
    justify-content:space-between;
    padding:0 20px;
    position:fixed;
    top:0;
    left:0;
    z-index:1000;
}

.logo{
    font-size:20px;
    font-weight:600;
}

/* ====== User Dropdown ====== */
.user-section{
    position:relative;
    cursor:pointer;
    display:flex;
    align-items:center;
}

.user-section img{
    width:35px;
    height:35px;
    border-radius:50%;
    margin-right:8px;
}

.dropdown-menu-custom{
    position:absolute;
    top:55px;
    right:0;
    width:180px;
    background:white;
    border-radius:10px;
    box-shadow:0 5px 15px rgba(0,0,0,0.2);
    display:none;
    overflow:hidden;
}

.dropdown-menu-custom a{
    display:block;
    padding:10px;
    text-decoration:none;
    color:#333;
    transition:0.3s;
}

.dropdown-menu-custom a:hover{
    background:#f1f1f1;
}

/* ====== Layout Wrapper ====== */
.main-wrapper{
    display:flex;
    margin-top:60px;
    height:calc(100vh - 60px);
}

/* ====== Sidebar ====== */
.sidebar{
    width:230px;
    background:#343a40;
    overflow-y:auto;
}

.sidebar a{
    display:block;
    color:white;
    padding:12px 20px;
    text-decoration:none;
    transition:0.3s;
}

.sidebar a:hover,
.sidebar a.active{
    background:#1cc88a;
    padding-left:30px;
}

/* ====== Content ====== */
.content{
    flex:1;
    background:#f4f6f9;
    padding:15px;
}

iframe{
    width:100%;
    height:100%;
    border:none;
    background:white;
    border-radius:10px;
}

/* ====== Responsive ====== */
@media(max-width:768px){

.sidebar{
    position:fixed;
    left:-230px;
    top:60px;
    height:calc(100vh - 60px);
    transition:0.3s;
}

.sidebar.show{
    left:0;
}

.content{
    flex:1;
}

.menu-toggle{
    display:block;
    cursor:pointer;
}

}

.menu-toggle{
    display:none;
    font-size:22px;
}
</style>

<script>
function loadPage(page, element){
    document.getElementById("mainFrame").src = page;

    var links=document.querySelectorAll(".sidebar a");
    links.forEach(link=>link.classList.remove("active"));
    element.classList.add("active");
}

function toggleDropdown(){
    var menu=document.getElementById("dropdownMenu");
    menu.style.display = menu.style.display==="block" ? "none" : "block";
}

function toggleSidebar(){
    document.getElementById("sidebar").classList.toggle("show");
}
</script>

</head>

<body>

<!-- ===== Topbar ===== -->
<div class="topbar">

<div class="d-flex align-items-center">
    <i class="fas fa-bars me-3 menu-toggle" onclick="toggleSidebar()"></i>
    <div class="logo">🎓 Student Innovation Portal</div>
</div>

<div class="user-section" onclick="toggleDropdown()">
    <img src="https://cdn-icons-png.flaticon.com/512/149/149071.png">
    <span><%=session.getAttribute("studentname")%></span>
    <i class="fas fa-caret-down ms-2"></i>

    <div class="dropdown-menu-custom" id="dropdownMenu">
        <a href="#" onclick="loadPage('studentProfile.jsp',this)">
            <i class="fas fa-user"></i> Profile
        </a>
        <a href="#" onclick="loadPage('studentChangePassword.jsp',this)">
            <i class="fas fa-key"></i> Change Password
        </a>
        <a href="logout.jsp">
            <i class="fas fa-sign-out-alt"></i> Logout
        </a>
    </div>
</div>

</div>

<!-- ===== Main Layout ===== -->
<div class="main-wrapper">

<!-- Sidebar -->
<div class="sidebar" id="sidebar">

<a href="#" class="active" onclick="loadPage('studentDashboard.jsp',this)">
<i class="fas fa-home"></i> Dashboard
</a>

<a href="#" onclick="loadPage('studentProfile.jsp',this)">
<i class="fas fa-user"></i> Profile
</a>

<a href="#" onclick="loadPage('studentViewEvents.jsp',this)">
<i class="fas fa-calendar"></i> View Events
</a>

<a href="#" onclick="loadPage('submitIdea.jsp',this)">
<i class="fas fa-lightbulb"></i> Submit Idea
</a>

<a href="#" onclick="loadPage('viewAllIdeas.jsp',this)">
<i class="fas fa-list"></i> View All Ideas
</a>

<a href="#" onclick="loadPage('studentLeaderboard.jsp',this)">
<i class="fas fa-trophy"></i> Leader Board
</a>

<a href="#" onclick="loadPage('viewMyIdeasFeedback.jsp',this)">
<i class="fa fa-comment" aria-hidden="true"></i> View Remarks
</a>

<a href="#" onclick="loadPage('studentChangePassword.jsp',this)">
<i class="fas fa-key"></i> Change Password
</a>

<a href="#" onclick="loadPage('studentFeedback.jsp',this)">
<i class="fas fa-comment"></i> Feedback
</a>

<a href="logout.jsp">
<i class="fas fa-sign-out-alt"></i> Logout
</a>

</div>

<!-- Content -->
<div class="content">
    <iframe id="mainFrame" src="studentDashboard.jsp"></iframe>
</div>

</div>

</body>
</html>
