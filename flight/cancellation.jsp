<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Ticket Cancellation</title>
    <style>
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
        .content {
            background-color: rgba(255, 255, 255, 0.9);
            padding: 20px;
            margin: 50px auto;
            width: 50%;
            border-radius: 10px;
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
        h1 {
            text-align: center;
        }
        form {
            text-align: center;
        }
        label, input {
            display: block;
            margin: 10px auto;
        }
        input[type="text"] {
            padding: 10px;
            width: 80%;
            border-radius: 5px;
            border: 1px solid #ccc;
        }
        input[type="submit"] {
            padding: 10px 20px;
            border-radius: 5px;
            border: none;
            background-color: #4CAF50;
            color: white;
            font-size: 16px;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #45a049;
        }
        .message {
            text-align: center;
            margin-top: 20px;
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
    <div class="content">
        <h1>Ticket Cancellation</h1>

        <form method="get" action="cancellation.jsp">
            <label for="ticketNo">Enter your Ticket Number:</label>
            <input type="text" name="ticketNo" id="ticketNo" required>
            <input type="submit" value="Cancel Ticket">
        </form>

        <div class="message">
        <%
            String ticketNo = request.getParameter("ticketNo");

            if (ticketNo != null && !ticketNo.isEmpty()) {
                Connection conn = null;
                PreparedStatement pstmt = null;

                try {
                    Class.forName("org.apache.derby.jdbc.EmbeddedDriver");
                    conn = DriverManager.getConnection("jdbc:derby://localhost:1527/flight", "anshu", "anshu");

                    String deleteQuery = "DELETE FROM ticket WHERE ticket_no = ?";
                    pstmt = conn.prepareStatement(deleteQuery);
                    pstmt.setString(1, ticketNo);

                    int rowsAffected = pstmt.executeUpdate();

                    if (rowsAffected > 0) {
                        out.println("<p style='color:green;'>Your ticket with number " + ticketNo + " has been successfully cancelled.</p>");
                    } else {
                        out.println("<p style='color:red;'>Ticket number " + ticketNo + " not found.</p>");
                    }

                } catch (ClassNotFoundException e) {
                    out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
                } catch (SQLException e) {
                    out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
                } finally {
                    try {
                        if (pstmt != null) pstmt.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        out.println("<p style='color:red;'>Error closing resources: " + e.getMessage() + "</p>");
                    }
                }
            }
        %>
        </div>

        <p style="text-align:center;"><a href="index.html">Return to Home</a></p>
    </div>
    <div class="footer">
        <p>&copy; 2024 My Website. All rights reserved.</p>
    </div>
</body>
</html>
