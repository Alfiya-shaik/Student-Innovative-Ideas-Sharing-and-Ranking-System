<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Login - Ideas Sharing System</title>
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    <style>
        /* Reset default styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Roboto', sans-serif;
        }

        body {
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            background: url('https://images.unsplash.com/photo-1508780709619-79562169bc64?auto=format&fit=crop&w=1470&q=80') no-repeat center center/cover;
        }

        .login-container {
            background: rgba(255, 255, 255, 0.9);
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
            width: 350px;
            text-align: center;
        }

        .login-container h1 {
            color: #333;
            margin-bottom: 25px;
            font-size: 24px;
        }

        .login-container input[type="text"],
        .login-container input[type="password"] {
            width: 100%;
            padding: 12px 15px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 8px;
            outline: none;
            font-size: 16px;
            transition: 0.3s;
        }

        .login-container input[type="text"]:focus,
        .login-container input[type="password"]:focus {
            border-color: #6c63ff;
            box-shadow: 0 0 8px rgba(108, 99, 255, 0.3);
        }

        .login-container button {
            width: 100%;
            padding: 12px;
            margin-top: 15px;
            border: none;
            border-radius: 8px;
            background: linear-gradient(45deg, #6c63ff, #5e54e2);
            color: white;
            font-size: 16px;
            cursor: pointer;
            transition: 0.3s;
        }

        .login-container button:hover {
            background: linear-gradient(45deg, #5e54e2, #6c63ff);
            transform: translateY(-2px);
        }

        .login-container .forgot-password {
            display: block;
            margin-top: 15px;
            font-size: 14px;
            color: #6c63ff;
            text-decoration: none;
        }

        .login-container .forgot-password:hover {
            text-decoration: underline;
        }

        @media(max-width: 400px) {
            .login-container {
                width: 90%;
                padding: 30px;
            }
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h1>Student Login</h1>
        <form action="loginAction.jsp" method="POST">
            <input type="text" name="username" placeholder="Username" required>
            <input type="password" name="password" placeholder="Password" required>
            <button type="submit">Login</button>
            <a href="#" class="forgot-password">Forgot Password?</a>
        </form>
    </div>
</body>
</html>
