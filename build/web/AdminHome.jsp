<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
if(session.getAttribute("username")==null){
    response.sendRedirect("login.jsp");
}
String username = (String)session.getAttribute("username");
int notificationCount = 5; // Example dynamic value
%>
<!DOCTYPE html>
<html>
<head>
<title>Admin Panel</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">

<style>
body{margin:0;transition:.3s;background:#f1f5f9;}
body.dark{background:#0f172a;color:white;}

.sidebar{
position:fixed;height:100vh;width:250px;
background:linear-gradient(180deg,#1e293b,#0f172a);
color:white;transition:.3s;z-index:1000;
}
.sidebar.collapsed{width:80px;}
.sidebar h4{padding:20px;text-align:center;}
.sidebar .nav-link{
color:#cbd5e1;padding:15px;transition:.3s;
}
.sidebar .nav-link:hover,
.sidebar .nav-link.active{
background:rgba(250, 60, 22,0.7);
border-left:4px solid #38bdf8;
color:white;
}
.sidebar.collapsed span{display:none;}

.content{margin-left:250px;transition:.3s;}
.content.expanded{margin-left:80px;}

.topbar{
background:linear-gradient(180deg,#1e293b,#0f172a);//rgba(250, 60, 22,0.1);
backdrop-filter:blur(10px);
padding:10px 20px;
box-shadow:0 5px 15px rgba(0,0,0,.1);
color:white;
}
iframe{
width:100%;height:85vh;border:none;
border-radius:15px;transition:.4s;
}
iframe.fade{opacity:0;}

@media(max-width:768px){
.sidebar{left:-250px;}
.sidebar.show{left:0;}
.content{margin-left:0;}
}
</style>
</head>

<body>

<!-- Sidebar -->
<div class="sidebar" id="sidebar">
<h4><i class="fa-solid fa-layer-group"></i> <span>Admin Panel</span></h4>

<ul class="nav flex-column" id="sidebarMenu">

<!-- Dashboard -->
<li class="nav-item">
    <a class="nav-link active" href="#" onclick="loadPage(this,'adminDashboard.jsp')">
<i class="fa-solid fa-chart-pie"></i> <span>Dashboard</span>
</a>
</li>
<!-- Staff Dropdown -->
<li class="nav-item">
<a class="nav-link" data-bs-toggle="collapse" href="#staffMenu" onclick="closeOtherMenus('staffMenu')">
<i class="fa-solid fa-calendar-check"></i> <span>Faculty Info</span>
</a>
<div class="collapse ps-4 sidebar-collapse" id="staffMenu">
    <a class="nav-link" href="#" onclick="loadPage(this,'AddStaff.jsp')">
<i class="fa-solid fa-plus"></i> Add Faculty
</a>
    <a class="nav-link" href="#" onclick="loadPage(this,'viewStaff.jsp')">
<i class="fa-solid fa-list"></i> Manage Faculty
</a>
</div>
</li>

<!-- Student Dropdown -->
<li class="nav-item">
<a class="nav-link" data-bs-toggle="collapse" href="#studentMenu" onclick="closeOtherMenus('studentMenu')">
<i class="fa-solid fa-calendar-check"></i> <span>Students Info</span>
</a>
<div class="collapse ps-4 sidebar-collapse" id="studentMenu">
    <a class="nav-link" href="#" onclick="loadPage(this,'AddStudent.jsp')">
<i class="fa-solid fa-plus"></i> Add Students
</a>
    <a class="nav-link" href="#" onclick="loadPage(this,'viewStudents.jsp')">
<i class="fa-solid fa-list"></i> Manage Students
</a>
</div>
</li>

<!-- Events Dropdown -->
<li class="nav-item">
<a class="nav-link" data-bs-toggle="collapse" href="#eventMenu" onclick="closeOtherMenus('eventMenu')">
<i class="fa-solid fa-calendar-check"></i> <span>Events</span>
</a>
<div class="collapse ps-4 sidebar-collapse" id="eventMenu">
<a class="nav-link" href="#" onclick="loadPage(this,'AddEvent.jsp')">
<i class="fa-solid fa-plus"></i> Add Event
</a>
<a class="nav-link" href="#" onclick="loadPage(this,'viewEvents.jsp')">
<i class="fa-solid fa-list"></i> Manage Events
</a>
</div>
</li>
<li class="nav-item">
    <a href="#" class="nav-link" onclick="loadPage(this,'leaderboard.jsp')">
        <i class="fas fa-trophy mr-2"></i> Leader Board
    </a>
</li>
<li class="nav-item">
    <a href="#" class="nav-link" onclick="loadPage(this,'adminViewFeedbacks.jsp')">
        <i class="fas fa-comment"></i> Feedbacks
    </a>
</li>
<!-- Reports Dropdown 
<li class="nav-item">
<a class="nav-link" data-bs-toggle="collapse" href="#reportMenu" onclick="closeOtherMenus('reportMenu')">
<i class="fa-solid fa-file-lines"></i> <span>Reports</span>
</a>
<div class="collapse ps-4 sidebar-collapse" id="reportMenu">
<a class="nav-link" href="#" onclick="loadPage(this,'dailyReport.jsp')">
<i class="fa-solid fa-calendar-day"></i> Daily Report
</a>
<a class="nav-link" href="#" onclick="loadPage(this,'monthlyReport.jsp')">
<i class="fa-solid fa-calendar"></i> Monthly Report
</a>
</div>
</li>-->

<!-- Logout -->
<li class="nav-item">
<a class="nav-link" href="logout.jsp">
<i class="fa-solid fa-right-from-bracket"></i> <span>Logout</span>
</a>
</li>

</ul>
</div>

<!-- Content -->
<div class="content" id="content">

<div class="topbar d-flex justify-content-between align-items-center">

<button class="btn btn-outline-light" onclick="toggleSidebar()">
<i class="fa-solid fa-bars"></i>
</button>

<div class="d-flex align-items-center gap-3">

<button class="btn btn-sm btn-outline-secondary" onclick="toggleDark()">
<i class="fa-solid fa-moon"></i>
</button>

<!--<div class="position-relative">
<i class="fa-solid fa-bell fs-5"></i>
<span class="position-absolute top-0 start-100 translate-middle badge bg-danger rounded-pill">
<%=notificationCount%>
</span>
</div>-->

<div class="dropdown">
<a class="dropdown-toggle text-white text-decoration-none"
href="#" data-bs-toggle="dropdown">
<i class="fa-solid fa-user"></i> <%=username%>
</a>
<ul class="dropdown-menu dropdown-menu-end">
<!--<li><a class="dropdown-item" href="#">Profile</a></li>
<li><a class="dropdown-item" href="#">Settings</a></li>
<li><hr class="dropdown-divider"></li>-->
<li><a class="dropdown-item text-danger" href="logout.jsp">Logout</a></li>
</ul>
</div>

</div>
</div>

<div class="p-3">
    <iframe id="frame" src="adminDashboard.jsp"></iframe>
</div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
    function closeOtherMenus(currentId){

    document.querySelectorAll('.sidebar-collapse').forEach(menu=>{
        if(menu.id !== currentId){
            let collapseInstance = bootstrap.Collapse.getInstance(menu);
            if(collapseInstance){
                collapseInstance.hide();
            }
        }
    });

}

function toggleSidebar(){
let s=document.getElementById("sidebar");
let c=document.getElementById("content");
s.classList.toggle("collapsed");
c.classList.toggle("expanded");
if(window.innerWidth<768){s.classList.toggle("show");}
}

function loadPage(el,page){
let frame=document.getElementById("frame");
frame.classList.add("fade");
setTimeout(()=>{
frame.src=page;
frame.classList.remove("fade");
},300);

document.querySelectorAll(".nav-link").forEach(l=>l.classList.remove("active"));
el.classList.add("active");
}

function toggleDark(){
document.body.classList.toggle("dark");
}

window.history.forward();
</script>

</body>
</html>
