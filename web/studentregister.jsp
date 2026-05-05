<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Student Registration | Innovative Ideas System</title>
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
            min-height: 100vh;
            background: linear-gradient(
                rgba(0, 0, 0, 0.45),
                rgba(0, 0, 0, 0.45)
            ),
            url("https://images.unsplash.com/photo-1522071820081-009f0129c71c") no-repeat center center/cover;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .register-container {
            width: 420px;
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(12px);
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 8px 32px rgba(0,0,0,0.25);
            color: #fff;
        }

        .register-container h2 {
            text-align: center;
            margin-bottom: 10px;
            font-weight: 600;
        }

        .register-container p {
            text-align: center;
            font-size: 14px;
            margin-bottom: 25px;
            color: #eaeaea;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            font-size: 13px;
            display: block;
            margin-bottom: 5px;
        }

        .form-group input,
        .form-group select {
            width: 100%;
            padding: 10px;
            border-radius: 8px;
            border: none;
            outline: none;
            font-size: 14px;
        }

        .form-group input::placeholder {
            color: #777;
        }

        .register-btn {
            width: 100%;
            margin-top: 10px;
            padding: 12px;
            background: linear-gradient(135deg, #00c6ff, #0072ff);
            border: none;
            border-radius: 25px;
            color: white;
            font-size: 15px;
            font-weight: 500;
            cursor: pointer;
            transition: transform 0.2s, box-shadow 0.2s;
        }

        .register-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(0, 114, 255, 0.6);
        }

        .login-link {
            text-align: center;
            margin-top: 15px;
            font-size: 13px;
        }

        .login-link a {
            color: #00c6ff;
            text-decoration: none;
            font-weight: 500;
        }

        .login-link a:hover {
            text-decoration: underline;
        }

        @media (max-width: 480px) {
            .register-container {
                width: 90%;
            }
        }
    </style>
</head>
<body>

<div class="register-container">
    <h2>Student Registration</h2>
    <p>Share your innovative ideas and get ranked</p>

    <form method="post" action="studentlogin.html">
        <div class="form-group">
            <label>Student Name</label>
            <input type="text" placeholder="Enter full name" required>
        </div>

        <div class="form-group">
            <label>Email Address</label>
            <input type="email" placeholder="Enter email" required>
        </div>

        <div class="form-group">
            <label>Mobile Number</label>
            <input type="text" placeholder="Enter mobile number" required>
        </div>

        <div class="form-group">
            <label>Department</label>
            <select required>
                <option value="">-- Select Department --</option>
                <option>Computer Science</option>
                <option>Information Technology</option>
                <option>Electronics</option>
                <option>Mechanical</option>
                <option>Civil</option>
            </select>
        </div>

        <div class="form-group">
            <label>Year of Study</label>
            <select required>
                <option value="">-- Select Year --</option>
                <option>1st Year</option>
                <option>2nd Year</option>
                <option>3rd Year</option>
                <option>4th Year</option>
            </select>
        </div>

        <div class="form-group">
            <label>Password</label>
            <input type="password" placeholder="Create password" required>
        </div>

        <div class="form-group">
            <label>Confirm Password</label>
            <input type="password" placeholder="Confirm password" required>
        </div>

        <button type="submit" class="register-btn">Register</button>
    </form>

    <div class="login-link">
        Already registered? <a href="studentlogin.jsp">Login here</a>
    </div>
</div>

</body>
</html>
