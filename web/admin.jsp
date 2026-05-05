<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Login | Student Ideas Ranking System</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

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
                    rgba(0, 0, 0, 0.55),
                    rgba(0, 0, 0, 0.55)
                ),
                url('https://images.unsplash.com/photo-1522202176988-66273c2fd55f');
            background-size: cover;
            background-position: center;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .login-container {
            width: 380px;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 12px;
            padding: 35px 30px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.3);
            animation: fadeIn 1s ease;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .login-container h2 {
            text-align: center;
            margin-bottom: 8px;
            color: #2c3e50;
        }

        .login-container p {
            text-align: center;
            font-size: 14px;
            color: #666;
            margin-bottom: 25px;
        }

        .input-group {
            margin-bottom: 18px;
        }

        .input-group label {
            font-size: 14px;
            color: #333;
            margin-bottom: 5px;
            display: block;
        }

        .input-group input {
            width: 100%;
            padding: 10px 12px;
            border-radius: 6px;
            border: 1px solid #ccc;
            font-size: 14px;
            transition: 0.3s;
        }

        .input-group input:focus {
            outline: none;
            border-color: #6a89cc;
            box-shadow: 0 0 5px rgba(106, 137, 204, 0.5);
        }

        .login-btn {
            width: 100%;
            padding: 11px;
            background: linear-gradient(135deg, #6a89cc, #4a69bd);
            color: white;
            font-size: 15px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: 0.3s;
            margin-top: 10px;
        }

        .login-btn:hover {
            background: linear-gradient(135deg, #4a69bd, #1e3799);
        }

        .footer-text {
            text-align: center;
            font-size: 13px;
            margin-top: 18px;
            color: #555;
        }

        .footer-text span {
            color: #4a69bd;
            font-weight: 500;
        }
    </style>
</head>
<body>

<div class="login-container">
    <h2>Admin Login</h2>
    <p>Student Innovative Ideas Sharing & Ranking System</p>

    <form method="post" action="loginAction.jsp">
        <div class="input-group">
            <label>Username</label>
            <input type="text" name="username" placeholder="Enter admin username" required>
        </div>

        <div class="input-group">
            <label>Password</label>
            <input type="password" name="password" placeholder="Enter password" required>
        </div>

        <button type="submit" class="login-btn">Login</button>
    </form>

    <div class="footer-text">
        © 2026 <span>Innovation Portal</span>
    </div>
</div>

</body>
</html>
