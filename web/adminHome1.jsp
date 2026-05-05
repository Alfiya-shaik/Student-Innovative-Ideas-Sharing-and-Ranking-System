<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Innovative Ideas Sharing System</title>
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
     <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        .navbar {
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .dropdown-menu {
            border-radius: 10px;
        }
    
        /* Reset and base styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Roboto', sans-serif;
        }

        body {
            line-height: 1.6;
            color: #333;
            /* Full-page background image */
            background: url('https://images.unsplash.com/photo-1504384308090-c894fdcc538d?auto=format&fit=crop&w=1950&q=80') no-repeat center center fixed;
            background-size: cover;
        }

        a {
            text-decoration: none;
            color: inherit;
        }

        /* Header / Navbar */
        header {
            background-color: rgba(0, 51, 102, 0.9); /* professional navy blue */
            color: #fff;
            padding: 15px 50px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: sticky;
            top: 0;
            z-index: 100;
        }

        header .logo {
            font-size: 1.8rem;
            font-weight: 700;
        }

        header nav a {
            margin-left: 25px;
            font-weight: 500;
            transition: color 0.3s ease;
        }

        header nav a:hover {
            color: #ffcc00; /* subtle accent color */
        }

        /* Hero Section */
        .hero {
            background: url('https://images.unsplash.com/photo-1581092580491-8e5613c2f4a7?auto=format&fit=crop&w=1950&q=80') no-repeat center center/cover;
            height: 90vh;
            display: flex;
            justify-content: center;
            align-items: center;
            color: #fff;
            text-align: center;
            position: relative;
        }

        .hero::after {
            content: '';
            position: absolute;
            top: 0; left: 0;
            width: 100%; height: 100%;
            background-color: rgba(0,0,0,0.5); /* overlay for readability */
        }

        .hero-content {
            position: relative;
            max-width: 700px;
            z-index: 1;
        }

        .hero-content h1 {
            font-size: 3rem;
            margin-bottom: 20px;
        }

        .hero-content p {
            font-size: 1.2rem;
            margin-bottom: 30px;
        }

        .hero-content a {
            padding: 12px 30px;
            background-color: #ffcc00;
            color: #003366;
            font-weight: 500;
            border-radius: 5px;
            transition: background 0.3s ease;
        }

        .hero-content a:hover {
            background-color: #e6b800;
        }

        /* Features Section */
        .features {
            padding: 80px 50px;
            display: flex;
            justify-content: space-around;
            flex-wrap: wrap;
            background-color: rgba(244, 246, 248, 0.9); /* semi-transparent to show background image */
        }

        .feature-box {
            flex: 1 1 250px;
            margin: 20px;
            background-color: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            text-align: center;
        }

        .feature-box:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.15);
        }

        .feature-box h3 {
            margin-bottom: 15px;
            color: #003366;
        }

        .feature-box p {
            color: #555;
        }

        /* Footer */
        footer {
            background-color: rgba(0, 51, 102, 0.9);
            color: #fff;
            text-align: center;
            padding: 20px 50px;
        }

        /* Responsive */
        @media(max-width: 768px) {
            .hero-content h1 {
                font-size: 2.2rem;
            }

            .features {
                flex-direction: column;
                padding: 50px 20px;
            }

            .feature-box {
                margin: 15px 0;
            }
        }
    </style>
    <!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<%
            String user = session.getAttribute("user").toString();
            session.setAttribute("user", user);
            
        %>
    <!-- Header -->
    <header>
        <div class="logo">InnovateHub</div>
<!--      <nav>
            <div class="btn-container">
                <a href="adminHome.jsp" class="btn">Home</a>
                <a href="AddStaff.jsp" class="btn">Add Faculty</a>
                <a href="AddStudent.jsp" class="btn">Add Student</a>
                <a href="viewStaff.jsp" class="btn">View Faculty</a>
                <a href="viewStudents.jsp" class="btn">View Students</a>
                <a href="viewFeedback.jsp" class="btn">View Feedbacks</a>
                <a href="index.jsp">logout</a>
			
        </div>
        </nav>-->
        <nav class="navbar navbar-expand-lg navbar-dark ">
    <div class="container-fluid">

        <!-- Brand -->
        <a class="navbar-brand fw-bold" href="adminDashboard.jsp" target="contentFrame">Dashboard</a>

<!--         Toggle Button -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarContent">
            <span class="navbar-toggler-icon"></span>
        </button>

<!--         Navbar Links -->
        <div class="collapse navbar-collapse" id="navbarContent">

            <ul class="navbar-nav me-auto mb-2 mb-lg-0">

                <li class="nav-item">
                    <a class="nav-link active" href="#">Home</a>
                </li>

                 <!--Dropdown Menu -->
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="servicesDropdown"
                       role="button" data-bs-toggle="dropdown">
                        Services
                    </a>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="#">Web Development</a></li>
                        <li><a class="dropdown-item" href="#">Mobile Apps</a></li>
                        <li><a class="dropdown-item" href="#">AI Solutions</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item" href="#">Consulting</a></li>
                    </ul>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="#">Contact</a>
                </li>

            </ul>

           <!--User Dropdown -->
            <ul class="navbar-nav">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" role="button"
                       data-bs-toggle="dropdown">
                        <i class="bi bi-person-circle"></i> Username
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end">
                        <li><a class="dropdown-item" href="#">Profile</a></li>
                        <li><a class="dropdown-item" href="#">Settings</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item text-danger" href="#">Logout</a></li>
                    </ul>
                </li>
            </ul>

        </div>
    </div>
</nav>
    </header>

    <!-- Hero Section -->
<!--    <section class="hero" id="home">-->
        <div class="col-md-10 p-0">
            <iframe id="contentFrame" src="adminDashboard.jsp"></iframe>
            
        </div>
<!--    </section>-->

    <!-- Features Section -->
    <section class="features" id="features">
        <div class="feature-box">
            <h3>Idea Sharing</h3>
            <p>Submit your innovative ideas and get them reviewed by peers and mentors.</p>
        </div>
        <div class="feature-box">
            <h3>Ranking & Feedback</h3>
            <p>Receive constructive feedback and vote on the most promising ideas.</p>
        </div>
        <div class="feature-box">
            <h3>Collaboration</h3>
            <p>Connect with other students to collaborate and refine your ideas for real-world impact.</p>
        </div>
    </section>

    <!-- Footer -->
    <footer>
        &copy; 2026 InnovateHub. All Rights Reserved.
    </footer>
    <script>
    function loadPage(page) {
        document.getElementById("contentFrame").src = page;
    }
</script>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
