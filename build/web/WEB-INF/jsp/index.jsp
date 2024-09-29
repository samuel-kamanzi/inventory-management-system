<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Login Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .login-container {
            background-color: #ffffff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px 0px rgba(0, 0, 0, 0.1);
            width: 350px;
            text-align: center;
        }

        .login-container h2 {
            margin-bottom: 20px;
            font-size: 24px;
            color: #333333;
            font-weight: 600;
        }

        .login-container .input-group {
            margin-bottom: 20px;
            position: relative;
            text-align: left;
        }

        .login-container .input-group input {
            width: calc(100% - 40px);
            padding: 10px 15px;
            padding-left: 40px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
            box-sizing: border-box;
        }

        .login-container .input-group .icon {
            position: absolute;
            left: 10px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 18px;
            color: #888888;
        }

        .login-container .login-button {
            background-color: #5cb85c;
            color: #ffffff;
            padding: 10px;
            border: none;
            border-radius: 5px;
            width: 100%;
            font-size: 18px;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.3s ease;
            margin-top: 10px;
        }

        .login-container .login-button:hover {
            background-color: #4cae4c;
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <div class="login-container">
        <h2>Login</h2>
        <form action="login.htm" method="post">
            <div class="input-group">
                <i class="fas fa-user icon"></i>
                <input type="text" name="username" placeholder="Username" required>
            </div>
            <div class="input-group">
                <i class="fas fa-lock icon"></i>
                <input type="password" name="password" placeholder="Password" required>
            </div>
            <button type="submit" class="login-button">Login</button>
        </form>

        <c:if test="${not empty message}">
            <p>${message}</p>
        </c:if>
    </div>
</body>
</html>
