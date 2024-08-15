<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Flight List</title>
    <style>
        table {
            width: 50%;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid black;
        }
        th, td {
            padding: 15px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        body {
            background-image: url('./flightwall.jpg');
            background-size: cover;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            color: #333;
        }
        .navbar {
            background-color: rgba(0, 0, 0, 0.7);
            overflow: hidden;
            padding: 15px;
            text-align: center;
        }
        .navbar a {
            float: left;
            display: block;
            color: white;
            text-align: center;
            padding: 14px 20px;
            text-decoration: none;
            font-size: 17px;
        }
        .navbar a:hover {
            background-color: rgba(255, 255, 255, 0.2);
            color: black;
        }
        .footer {
            background-color: rgba(0, 0, 0, 0.7);
            color: white;
            text-align: center;
            padding: 10px;
            position: fixed;
            width: 100%;
            bottom: 0;
        }
    </style>
</head>
<body>
    <div class="navbar">
        <a href="./bookings.html">Bookings</a>
        <a href="./View.jsp">Flight View</a>
        <a href="./AddFlight.html">Add Flight</a>
        <a href="./cancellation.jsp">Cancellation</a>
        <a href="./viewTicket.jsp">View Tickets</a>
    </div>
    <h1>Flight List</h1>
    <%
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            // Load the database driver (optional if using connection pool)
            Class.forName("org.apache.derby.jdbc.EmbeddedDriver");

            // Establish a connection to the database
            conn = DriverManager.getConnection("jdbc:derby://localhost:1527/flight", "anshu", "anshu");
            stmt = conn.createStatement();

            // Execute a query to retrieve data from the flight table
            String query = "SELECT * FROM flight";
            rs = stmt.executeQuery(query);

            // Display the result in an HTML table
    %>
    <table>
        <tr>
            <th>Flight Number</th>
            <th>Airline</th>
        </tr>
    <%
            while (rs.next()) {
                int flno = rs.getInt("flno");
                String airline = rs.getString("airline");
    %>
        <tr>
            <td><%= flno %></td>
            <td><%= airline %></td>
        </tr>
    <%
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<p>Error: " + e.getMessage() + "</p>");
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    %>
    </table>
    <div class="footer">
        <p>&copy; 2024 My Website. All rights reserved.</p>
    </div>
</body>
</html>