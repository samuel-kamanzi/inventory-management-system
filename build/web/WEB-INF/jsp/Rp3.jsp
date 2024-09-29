<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.sql.*, java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Product Report</title>
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
            max-width: 800px;
            margin: 0 auto;
        }
        h1 {
            text-align: center;
            color: #333;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            font-size: 14px;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
            color: #666;
        }
        .no-data {
            text-align: center;
            color: #777;
            font-size: 14px;
        }
        .back-button, .print-button {
            display: block;
            width: fit-content;
            margin: 20px auto;
            padding: 10px 20px;
            text-align: center;
            font-size: 16px;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .back-button {
            background-color: #007bff;
        }
        .back-button:hover {
            background-color: #0056b3;
        }
        .print-button {
            background-color: #28a745;
        }
        .print-button:hover {
            background-color: #218838;
        }
        /* Print Media Query */
        @media print {
            .back-button, .print-button {
                display: none;
            }
        }
    </style>
    <script>
        function applyFilter() {
            var filterValue = document.getElementById('filter').value;
            window.location.href = window.location.pathname + '?filter=' + filterValue;
        }

        function printPage() {
            window.print();
        }
    </script>
</head>
<body>
<div class="container">
    <h1>Product Report</h1>

    <!-- Filter Form -->
    <form method="get" action="">
        <label for="filter">Select Filter:</label>
        <select id="filter" name="filter" onchange="applyFilter()">
            <option value="">--All--</option>
            <option value="daily" <%= "daily".equals(request.getParameter("filter")) ? "selected" : "" %>>Daily</option>
            <option value="weekly" <%= "weekly".equals(request.getParameter("filter")) ? "selected" : "" %>>Weekly</option>
            <option value="monthly" <%= "monthly".equals(request.getParameter("filter")) ? "selected" : "" %>>Monthly</option>
        </select>
    </form>

    <!-- Results Table -->
    <div id="reportResults">
        <% 
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            String filter = request.getParameter("filter");
            String query = "SELECT * FROM product";
            String dateCondition = "";

            // Modify the query based on the filter
            if ("daily".equals(filter)) {
                dateCondition = " DATE(date_added) = CURDATE()";
            } else if ("weekly".equals(filter)) {
                dateCondition = " WEEK(date_added) = WEEK(CURDATE()) AND YEAR(date_added) = YEAR(CURDATE())";
            } else if ("monthly".equals(filter)) {
                dateCondition = " MONTH(date_added) = MONTH(CURDATE()) AND YEAR(date_added) = YEAR(CURDATE())";
            }

            if (!dateCondition.isEmpty()) {
                query += " WHERE" + dateCondition;
            }

            try {
                // Database connection
                conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/inventory", "root", "");
                pstmt = conn.prepareStatement(query);
                rs = pstmt.executeQuery();

                if (rs.next()) {
        %>
        <table>
            <thead>
                <tr>
                    <th>Product ID</th>
                    <th>Product Name</th>
                    <th>Category</th>
                    <th>Created Date</th>
                </tr>
            </thead>
            <tbody>
                <%
                    // Displaying data
                    do {
                        int productId = rs.getInt("product_id");
                        String productName = rs.getString("product_name");
                        String category = rs.getString("category");
                        Date createdDate = rs.getDate("date_added"); // Ensure this column name is correct
                %>
                <tr>
                    <td><%= productId %></td>
                    <td><%= productName %></td>
                    <td><%= category %></td>
                    <td><%= sdf.format(createdDate) %></td>
                </tr>
                <%
                    } while (rs.next());
                %>
            </tbody>
        </table>
        <%
                } else {
        %>
        <p class="no-data">No data available.</p>
        <%
                }
            } catch (SQLException e) {
                e.printStackTrace();
        %>
        <p class="no-data">Error retrieving data: <%= e.getMessage() %></p>
        <%
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        %>
    </div>

    <button class="print-button" onclick="printPage();">Print</button>
    <button class="back-button" onclick="window.history.back();">Back</button>
</div>
</body>
</html>
