<!DOCTYPE html>
<html>
<head>
<title>Admin Login</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-dark d-flex justify-content-center align-items-center vh-100">

<form action="validateLogin.jsp" method="post" class="bg-white p-4 rounded shadow" style="width:350px;">
    <h4 class="text-center mb-3">Admin Login</h4>
    <input type="text" name="username" class="form-control mb-3" placeholder="Username" required>
    <input type="password" name="password" class="form-control mb-3" placeholder="Password" required>
    <button class="btn btn-dark w-100">Login</button>
</form>

</body>
</html>
