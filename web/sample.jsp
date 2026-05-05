<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
    String username = "Admin"; // Replace with session.getAttribute("username")
%>
<!DOCTYPE html>
<html>
<head>
    <title>Premium Admin Dashboard</title>

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">

    <style>
        body {
            margin: 0;
            overflow-x: hidden;
            transition: 0.3s;
            background: #f1f5f9;
        }

        body.dark-mode {
            background: #0f172a;
            color: white;
        }

        /* Sidebar */
        .sidebar {
            position: fixed;
            height: 100vh;
            width: 250px;
            background: linear-gradient(180deg, #1e293b, #0f172a);
            transition: 0.3s;
            color: white;
            z-index: 1000;
        }

        .sidebar.collapsed {
            width: 80px;
        }

        .sidebar h4 {
            text-align: center;
            padding: 20px 0;
        }

        .sidebar .nav-link {
            color: #cbd5e1;
            padding: 15px;
            transition: 0.3s;
        }

        .sidebar .nav-link:hover,
        .sidebar .nav-link.active {
            background: rgba(255,255,255,0.1);
            color: white;
            border-left: 4px solid #38bdf8;
        }

        .sidebar .nav-link i {
            margin-right: 10px;
        }

        .sidebar.collapsed span {
            display: none;
        }

        /* Content */
        .content {
            margin-left: 250px;
            transition: 0.3s;
        }

        .content.expanded {
            margin-left: 80px;
        }

        /* Top Navbar */
        .topbar {
            backdrop-filter: blur(10px);
            background: rgba(255,255,255,0.6);
            padding: 10px 20px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        body.dark-mode .topbar {
            background: rgba(15,23,42,0.8);
        }

        iframe {
            width: 100%;
            height: 85vh;
            border: none;
            border-radius: 15px;
            opacity: 1;
            transition: opacity 0.4s ease-in-out;
        }

        iframe.fade {
            opacity: 0;
        }

        /* Mobile */
        @media(max-width: 768px){
            .sidebar {
                left: -250px;
            }
            .sidebar.show {
                left: 0;
            }
            .content {
                margin-left: 0;
            }
        }
    </style>
</head>

<body>

<!-- Sidebar -->
<div class="sidebar p-2" id="sidebar">

    <h4>
        <i class="fa-solid fa-layer-group"></i>
        <span>Admin Panel</span>
    </h4>

    <ul class="nav flex-column">

        <li class="nav-item">
            <a class="nav-link active" href="#" onclick="loadPage(this,'dashboard.jsp')">
                <i class="fa-solid fa-chart-pie"></i>
                <span>Dashboard</span>
            </a>
        </li>

        <li class="nav-item">
            <a class="nav-link" data-bs-toggle="collapse" href="#eventMenu">
                <i class="fa-solid fa-calendar-check"></i>
                <span>Events</span>
            </a>
            <div class="collapse ps-4" id="eventMenu">
                <a class="nav-link" href="#" onclick="loadPage(this,'addEvent.jsp')">
                    <i class="fa-solid fa-plus"></i> Add Event
                </a>
                <a class="nav-link" href="#" onclick="loadPage(this,'manageEvents.jsp')">
                    <i class="fa-solid fa-list"></i> Manage
                </a>
            </div>
        </li>

        <li class="nav-item">
            <a class="nav-link" href="#" onclick="loadPage(this,'reports.jsp')">
                <i class="fa-solid fa-file-lines"></i>
                <span>Reports</span>
            </a>
        </li>

        <li class="nav-item">
            <a class="nav-link text-danger" href="logout.jsp">
                <i class="fa-solid fa-right-from-bracket"></i>
                <span>Logout</span>
            </a>
        </li>

    </ul>
</div>

<!-- Content -->
<div class="content" id="content">

    <!-- Topbar -->
    <div class="topbar d-flex justify-content-between align-items-center">

        <button class="btn btn-outline-dark" onclick="toggleSidebar()">
            <i class="fa-solid fa-bars"></i>
        </button>

        <div class="d-flex align-items-center gap-3">

            <!-- Dark Mode Toggle -->
            <button class="btn btn-sm btn-outline-secondary" onclick="toggleDarkMode()">
                <i class="fa-solid fa-moon"></i>
            </button>

            <!-- Notification -->
            <div class="position-relative">
                <i class="fa-solid fa-bell fs-5"></i>
                <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                    3
                </span>
            </div>

            <!-- Profile Dropdown -->
            <div class="dropdown">
                <a class="dropdown-toggle text-decoration-none text-dark"
                   href="#" data-bs-toggle="dropdown">
                   <i class="fa-solid fa-user"></i> <%= username %>
                </a>
                <ul class="dropdown-menu dropdown-menu-end">
                    <li><a class="dropdown-item" href="#">Profile</a></li>
                    <li><a class="dropdown-item" href="#">Settings</a></li>
                    <li><hr class="dropdown-divider"></li>
                    <li><a class="dropdown-item text-danger" href="logout.jsp">Logout</a></li>
                </ul>
            </div>

        </div>
    </div>

    <!-- Iframe -->
    <div class="p-3">
        <iframe id="contentFrame" src="dashboard.jsp"></iframe>
    </div>

</div>

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
    function toggleSidebar(){
        let sidebar = document.getElementById("sidebar");
        let content = document.getElementById("content");
        sidebar.classList.toggle("collapsed");
        content.classList.toggle("expanded");
    }

    function loadPage(element,page){
        let frame = document.getElementById("contentFrame");

        // Fade effect
        frame.classList.add("fade");
        setTimeout(() => {
            frame.src = page;
            frame.classList.remove("fade");
        }, 300);

        // Active menu
        document.querySelectorAll(".nav-link").forEach(link=>{
            link.classList.remove("active");
        });
        element.classList.add("active");
    }

    function toggleDarkMode(){
        document.body.classList.toggle("dark-mode");
    }

    // Prevent Back After Logout
    window.history.forward();
    function noBack(){ window.history.forward(); }
</script>

</body>
</html>
