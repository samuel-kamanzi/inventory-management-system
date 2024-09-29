<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    // Check if a session exists and if a user is logged in
    if (session.getAttribute("username") == null) {
        // Redirect to login page if not logged in
        response.sendRedirect("index.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inventory Management System</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #e6f7ff; /* Solid background color */
            margin: 0;
            padding: 0;
            color: #333;
        }
        .container {
            max-width: 1200px;
            margin: 40px auto;
            padding: 20px;
            background: #ffffff;
            border-radius: 12px;
            /*box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);*/
            transition: box-shadow 0.3s ease-in-out;
        }
        .container:hover {
            box-shadow: 0 1px 1px rgba(0, 0, 0, 0.3);
        }
        .header {
            background: #007bff; /* Solid background color */
            color: #fff;
            padding: 20px;
            border-radius: 12px 12px 0 0;
            text-align: center;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        .header h1 {
            margin: 0;
            font-size: 32px;
        }
        .nav {
            background: #00bcd4; /* Solid background color */
            padding: 15px;
            border-radius: 0 0 12px 12px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
        }
        .nav ul {
            list-style: none;
            margin: 0;
            padding: 0;
            text-align: center;
        }
        .nav ul li {
            display: inline-block;
            margin-right: 20px;
        }
        .nav ul li a {
            color: #ffffff;
            text-decoration: none;
            font-size: 18px;
            transition: color 0.3s ease;
        }
        .nav ul li a:hover {
            color: #ffeb3b;
        }
        .main {
            padding: 20px;
        }
        .main h2 {
            margin-top: 0;
            color: #333;
        }
        .dashboard {
            margin-top: 20px;
        }
        .dashboard .card {
            background: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            transition: box-shadow 0.3s ease;
        }
        .dashboard .card:hover {
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.3);
        }
        .dashboard .card h3 {
            margin-top: 0;
            color: #333;
        }
        .dashboard .card ul {
            list-style: none;
            margin: 0;
            padding: 0;
        }
        .dashboard .card ul li {
            margin-bottom: 10px;
        }
        .dashboard .card ul li span {
            font-weight: bold;
        }
        
        
        #footer{
            position: absolute;
            
            
            left: 0;
            right: 0;
            text-align: center;
            bottom: 0;
                
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Inventory Management System</h1>
        </div>
        <div class="nav"> 
           <ul>
<!--    <li><a href="<c:url value='/index.htm'/>">Home</a></li>-->
    <li><a href="<c:url value='/stockTracking.htm'/>">Record product</a></li>
    <li><a href="<c:url value='/stockmanagementController.htm'/>">Stock Management</a></li>
    <li><a href="<c:url value='/report.htm'/>">Reporting</a></li>
 <li><a href="<c:url value='/logout1.htm'/>" class="logout-button">Logout</a></li>
</ul>

        </div>
        <div class="main">
            <h2>Overview</h2>
            <p>Welcome to our inventory management system! This platform is designed to help you track, manage, and optimize your inventory levels, ensuring that you have the right products in stock at the right time.</p>
            <div class="dashboard">
                <!-- dashboard content here -->
            </div>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
    
    
    <label id="footer">
        &copy;inventory management system 2024
    </label>
</body>
</html>
