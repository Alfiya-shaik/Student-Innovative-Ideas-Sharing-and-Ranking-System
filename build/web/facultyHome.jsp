<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
if(session.getAttribute("facultyname") == null){
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
<title>Faculty Dashboard</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">

<style>
body{
    margin:0;
    font-family:'Segoe UI',sans-serif;
    background:#f4f6f9;
    overflow-x:hidden;
}

/* ===== SIDEBAR ===== */
.sidebar{
    position:fixed;
    top:0;
    left:0;
    width:250px;
    height:100%;
    background:#1f2d3d;
    padding-top:20px;
    transition:0.3s;
    z-index:1000;
}

.sidebar h4{
    color:white;
    text-align:center;
    margin-bottom:30px;
}

.sidebar a{
    display:block;
    color:#c2c7d0;
    padding:12px 20px;
    text-decoration:none;
    transition:0.3s;
    font-size:15px;
}

.sidebar a:hover,
.sidebar a.active{
    background:#4e73df;
    color:white;
}

.sidebar i{
    margin-right:10px;
}

/* ===== CONTENT ===== */
.content{
    margin-left:250px;
    padding:15px;
    transition:0.3s;
}

/* ===== TOPBAR ===== */
.topbar{
    background:linear-gradient(90deg,#4e73df,#1cc88a);
    padding:10px 20px;
    border-radius:12px;
    margin-bottom:15px;
}

.topbar img{
    object-fit:cover;
}

/* ===== IFRAME ===== */
iframe{
    width:100%;
    height:85vh;
    border:none;
    background:white;
    border-radius:12px;
    box-shadow:0 4px 12px rgba(0,0,0,0.1);
}

/* ===== RESPONSIVE ===== */
@media(max-width:768px){

    .sidebar{
        left:-250px;
    }

    .sidebar.active{
        left:0;
    }

    .content{
        margin-left:0;
    }
}
</style>
</head>

<body>

<!-- ===== SIDEBAR ===== -->
<div class="sidebar" id="sidebar">

    <h4><i class="fa-solid fa-layer-group"></i> <span>Faculty Panel</span></h4>

    <a href="#" onclick="loadPage('facultyDashboard.jsp',this)" class="active">
        <i class="fas fa-chart-line"></i> Dashboard
    </a>

    <a href="#" onclick="loadPage('viewFacultyProfile.jsp',this)">
        <i class="fas fa-user"></i> Profile
    </a>

    <a href="#" onclick="loadPage('facultyViewStudents.jsp',this)">
        <i class="fas fa-users"></i> Students Info
    </a>
    <a href="#" onclick="loadPage('studentsSubmittedIdeas.jsp',this)">
        <i class="fas fa-lightbulb"></i> Submitted Ideas
    </a>


    <a href="#" onclick="loadPage('facultyLeaderboard.jsp',this)">
        <i class="fas fa-trophy"></i> Leader Board
    </a>

    <a href="#" onclick="loadPage('facultyChangePassword.jsp',this)">
        <i class="fas fa-key"></i> Change Password
    </a>

    <a href="logout.jsp">
        <i class="fas fa-sign-out-alt"></i> Logout
    </a>

</div>

<!-- ===== CONTENT AREA ===== -->
<div class="content">

    <!-- ===== TOPBAR ===== -->
    <nav class="navbar navbar-expand-lg topbar shadow">

        <!-- Mobile Toggle -->
        <button class="btn text-white d-lg-none" onclick="toggleSidebar()">
            <i class="fas fa-bars"></i>
        </button>

        <div class="ms-auto dropdown">

            <a class="d-flex align-items-center text-white text-decoration-none dropdown-toggle"
               href="#"
               role="button"
               data-bs-toggle="dropdown">

                <img src="https://cdn-icons-png.flaticon.com/512/3135/3135715.png"
                     width="35"
                     height="35"
                     class="rounded-circle me-2">

                <span class="fw-semibold">
                    <%=session.getAttribute("facultyname")%>
                </span>
            </a>

            <ul class="dropdown-menu dropdown-menu-end shadow">

                <li>
                    <a class="dropdown-item" href="#" onclick="loadPage('viewFacultyProfile.jsp')">
                        <i class="fas fa-user me-2"></i> Profile
                    </a>
                </li>

                <li>
                    <a class="dropdown-item" href="#" onclick="loadPage('facultyChangePassword.jsp')">
                        <i class="fas fa-key me-2"></i> Change Password
                    </a>
                </li>

                <li><hr class="dropdown-divider"></li>

                <li>
                    <a class="dropdown-item text-danger" href="logout.jsp">
                        <i class="fas fa-sign-out-alt me-2"></i> Logout
                    </a>
                </li>

            </ul>

        </div>

    </nav>

    <!-- ===== IFRAME CONTENT ===== -->
    <iframe id="contentFrame" src="facultyDashboard.jsp"></iframe>

</div>

<!-- ===== SCRIPTS ===== -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>

// Load iframe page
function loadPage(page, element){
    document.getElementById("contentFrame").src = page;

    // Remove active class
    document.querySelectorAll('.sidebar a').forEach(link=>{
        link.classList.remove("active");
    });

    if(element){
        element.classList.add("active");
    }

    // Close sidebar on mobile
    if(window.innerWidth < 768){
        document.getElementById("sidebar").classList.remove("active");
    }
}

// Toggle sidebar (mobile)
function toggleSidebar(){
    document.getElementById("sidebar").classList.toggle("active");
}

</script>

</body>
</html>
