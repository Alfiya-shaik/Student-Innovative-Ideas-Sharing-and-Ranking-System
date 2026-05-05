<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Faculty Login | Student Innovative Ideas System</title>

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body {
            height: 100vh;
            background: linear-gradient(
                    rgba(0, 0, 0, 0.45),
                    rgba(0, 0, 0, 0.45)
                ),
                url("https://images.unsplash.com/photo-1523240795612-9a054b0db644") no-repeat center center/cover;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .login-container {
            width: 380px;
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(12px);
            border-radius: 18px;
            padding: 35px;
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.4);
            color: #fff;
        }

        .login-container h2 {
            text-align: center;
            margin-bottom: 10px;
            font-weight: 600;
            color: #ffffff;
        }

        .login-container p {
            text-align: center;
            font-size: 14px;
            margin-bottom: 25px;
            color: #e0e0e0;
        }

        .form-group {
            margin-bottom: 18px;
        }

        .form-group label {
            font-size: 14px;
            color: #f1f1f1;
        }

        .form-group input {
            width: 100%;
            padding: 12px;
            margin-top: 6px;
            border-radius: 10px;
            border: none;
            outline: none;
            background: rgba(255, 255, 255, 0.9);
            font-size: 14px;
        }

        .login-btn {
            width: 100%;
            padding: 12px;
            margin-top: 10px;
            border: none;
            border-radius: 12px;
            background: linear-gradient(to right, #4facfe, #00f2fe);
            color: #000;
            font-weight: 600;
            font-size: 15px;
            cursor: pointer;
            transition: 0.3s;
        }

        .login-btn:hover {
            transform: scale(1.03);
            background: linear-gradient(to right, #00f2fe, #4facfe);
        }

        .footer-text {
            margin-top: 18px;
            text-align: center;
            font-size: 13px;
            color: #ddd;
        }

        .footer-text span {
            color: #00f2fe;
            font-weight: 500;
        }
    </style>
</head>
<body>

<div class="login-container">
    <h2>Faculty Login</h2>
    <p>Student Innovative Ideas Sharing & Ranking System</p>

    <form method="post" action="loginAction.jsp">
        <div class="form-group">
            <label>Faculty ID</label>
            <input type="text" name="username" placeholder="Enter your email" required>
        </div>

        <div class="form-group">
            <label>Password</label>
            <input type="password" name="password" placeholder="Enter your password" required>
        </div>

        <button type="submit" class="login-btn">Login</button>
    </form>

    <div class="footer-text">
        Empowering <span>Innovation</span> & <span>Creativity</span>
    </div>
</div>

</body>
</html>
