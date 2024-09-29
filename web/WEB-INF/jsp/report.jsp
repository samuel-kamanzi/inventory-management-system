<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Inventory Reports Menu</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f8;
            margin: 0;
            padding: 20px;
        }
        .container {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            margin: 0 auto;
        }
        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }
        ul {
            list-style-type: none;
            padding: 0;
            margin: 0;
            display: flex;
            justify-content: center; /* Center the menu horizontally */
            gap: 20px; /* Space between menu items */
        }
        li {
            margin: 0; /* Remove margin from list items */
        }
        a {
            text-decoration: none;
            color: #007bff;
            font-size: 16px;
            padding: 10px 20px; /* Add padding for clickable area */
            display: block; /* Make the entire area clickable */
            border-radius: 4px; /* Rounded corners */
            transition: background-color 0.3s, color 0.3s; /* Smooth hover effect */
        }
        a:hover {
            text-decoration: none;
            background-color: #e7f0ff; /* Light background on hover */
            color: #0056b3; /* Darker color on hover */
        }
        .back-button {
            display: block;
            width: fit-content;
            margin: 20px auto;
            padding: 10px 20px;
            text-align: center;
            font-size: 16px;
            color: #fff;
            background-color: #007bff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .back-button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Choose a Report to Generate</h2>
    <ul>
        <li><a href="<c:url value='/Rp1.htm'/>">Stock In Report</a></li>
        <li><a href="<c:url value='/Rp2.htm'/>">Stock Out Report</a></li>
        <li><a href="<c:url value='/Rp3.htm'/>">Product Report</a></li>
    </ul>
    <button class="back-button" onclick="window.history.back();">Back</button>
</div>
</body>
</html>
