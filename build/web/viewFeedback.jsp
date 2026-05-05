<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Innovative Ideas Sharing System</title>
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" crossorigin="anonymous"></script>
    <style>
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
        .column {
                float: left;
                width: 33.33%;
                padding: 5px;
            }

                /* Clearfix (clear floats) */
            .row::after {
                content: "";
                clear: both;
                display: table;
            }
            .login-container {
                
                width: 80%;
                padding: 20px;
                background-color: #fff;
                border-radius: 8px;
                //box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                text-align: center;
                margin-left: 10%;
            }

            .login-form {
                display: flex;
                flex-direction: column;
                color:black;
            }

            .login-form h2 {
                text-align: center;
                margin-bottom: 20px;
            }

            .input-group {
                margin-bottom: 15px;
            }

            .input-group label {
                display: block;
                margin-bottom: 5px;
                font-weight: bold;
            }

            .input-group input {
            width: 100%;
            padding: 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
            }
            .input-group select {
            width: 100%;
            padding: 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
            }

            button {
                width: 100%;
                padding: 10px;
                background-color: #007bff;
                color: #fff;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                transition: background-color 0.3s;
            }

            button:hover {
                background-color: #0056b3;
            }
            .tview
            {
                width:100%;
                height: auto;
                padding:10px;
                color:black;
                border:1px solid #ccc;
            }
    </style>
</head>
<body>

    <!-- Header -->
   <!-- Header -->
    <header>
        <div class="logo">InnovateHub</div>
        <nav>
       <a href="adminHome.jsp" >Home</a>
                <a href="AddStaff.jsp" >Add Faculty</a>
                <a href="AddStudent.jsp" >Add Student</a>
                <a href="viewStaff.jsp" >View Faculty</a>
                <a href="viewStudents.jsp" >View Students</a>
                <a href="viewFeedback.jsp" >View Feedbacks</a>
                <a href="index.jsp">logout</a>
    </nav>
    </header>

    <!-- Hero Section 
    <section class="hero" id="home">-->
        <div class="login-container" align="center" style="margin-top:50px;opacity:0.9;">
           <h5><span style="color:#ffb703;"><u>Feedback Details</u></span></h5>
            <table class="tview">
                <th>Feedback ID</th>
                <th>Feedback Name</th>
                <th>Description</th>
               
               
                
                <%
             try{
                 
                 
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/studentinnvotive", "root", "root");
                    Statement stmt = con.createStatement();
                    String Query = "select * from feedback";
                    ResultSet rs = stmt.executeQuery(Query);
                    while(rs.next())
                    {
                %>
                <tr>           
                <td><%=rs.getInt(1)%></td>
                <td><%=rs.getString(2)%></td>
                <td><%=rs.getString(3)%></td>
                
                </tr>
                <%
                    }
                }catch(Exception e)
                {
                    e.printStackTrace();
                }
                %>
                
                
            </table>
        </div>
    <!--</section>

     Features Section 
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
-->
    <!-- Footer 
    <footer>
        &copy; 2026 InnovateHub. All Rights Reserved.
    </footer>
-->
</body>
</html>
