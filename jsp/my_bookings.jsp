<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%
// Check if user is logged in
if (session.getAttribute("email") == null) {
    response.sendRedirect("../index.html");
    return;
}

String userEmail = (String) session.getAttribute("email");
String userName = "User"; // Default name

// Fetch user name from database
Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/carrent", "root", "jaggu");
    
    ps = con.prepareStatement("SELECT name FROM user WHERE email = ?");
    ps.setString(1, userEmail);
    rs = ps.executeQuery();
    
    if (rs.next()) {
        userName = rs.getString("name");
    }
} catch (Exception e) {
    e.printStackTrace();
} finally {
    try { if (rs != null) rs.close(); } catch (SQLException e) {}
    try { if (ps != null) ps.close(); } catch (SQLException e) {}
    try { if (con != null) con.close(); } catch (SQLException e) {}
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Bookings - Car Rental</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        /* Animations */
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
        
        @keyframes slideUp {
            from { 
                opacity: 0;
                transform: translateY(20px);
            }
            to { 
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        @keyframes slideDown {
            from { 
                opacity: 0;
                transform: translateY(-30px);
            }
            to { 
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.02); }
            100% { transform: scale(1); }
        }
        
        @keyframes fadeInRight {
            from { 
                opacity: 0;
                transform: translateX(20px);
            }
            to { 
                opacity: 1;
                transform: translateX(0);
            }
        }

        body {
            margin: 0;
            font-family: 'Poppins', sans-serif;
            background: url('../imgs/11.jpg') no-repeat center center/cover;
            min-height: 100vh;
            color: #333;
            animation: fadeIn 0.8s ease-in-out;
        }

        .dashboard-container {
            padding: 30px;
            max-width: 1200px;
            margin: auto;
            animation: slideUp 0.8s ease-out;
        }

        .header {
            background: rgba(0,0,0,0.60);
            padding: 20px 30px;
            border-radius: 15px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 6px 20px rgba(0,0,0,0.1);
            margin-bottom: 30px;
            animation: slideDown 0.6s ease-out;
        }

        .header h1 {
            margin: 0;
            color: #FFA07A;
            font-size: 28px;
            animation: pulse 2s infinite;
        }

        .logout-btn {
            background: #ff4b2b;
            color: white;
            padding: 10px 20px;
            border-radius: 25px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s;
            animation: fadeInRight 0.8s ease-out;
        }

        .logout-btn i {
            margin-right: 8px;
        }

        .logout-btn:hover {
            background: #d63b1f;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
        }

        .bookings-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background: rgba(255, 255, 255, 0.9);
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            animation: fadeIn 0.8s ease-out;
        }

        .bookings-table th, .bookings-table td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        .bookings-table th {
            background-color: #6495ED;
            color: white;
            font-weight: 600;
        }

        .bookings-table tr:hover {
            background-color: #f5f5f5;
        }

        .status-booked {
            color: #2196F3;
            font-weight: bold;
        }

        .status-cancelled {
            color: #f44336;
            font-weight: bold;
        }

        .status-completed {
            color: #4CAF50;
            font-weight: bold;
        }

        .no-bookings {
            background: rgba(255, 255, 255, 0.9);
            padding: 30px;
            border-radius: 10px;
            text-align: center;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            animation: fadeIn 0.8s ease-out;
        }

        .no-bookings i {
            font-size: 50px;
            color: #6495ED;
            margin-bottom: 20px;
        }

        .back-btn {
            display: inline-block;
            background: #6495ED;
            color: white;
            padding: 10px 20px;
            border-radius: 25px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s;
            margin-top: 20px;
            position: relative;
            overflow: hidden;
        }

        .back-btn i {
            margin-right: 6px;
            transition: transform 0.3s;
        }

        .back-btn:hover {
            background: #005fcc;
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }

        .back-btn:hover i {
            transform: translateX(-5px);
        }

        .back-btn::after {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: 0.5s;
        }

        .back-btn:hover::after {
            left: 100%;
        }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <div class="header">
            <h1>Welcome, <%= userName %>!</h1>
            <a href="../index.html" class="logout-btn"><i class="fas fa-sign-out-alt"></i> Logout</a>
        </div>

        <%
        con = null;
        ps = null;
        rs = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/carrent", "root", "jaggu");

            // Now get all bookings for this user
            ps = con.prepareStatement("SELECT * FROM bookings WHERE user_name = ? ORDER BY booking_date DESC");
            ps.setString(1, userName);
            rs = ps.executeQuery();

            if (rs.isBeforeFirst()) {
        %>
                <table class="bookings-table">
                    <thead>
                        <tr>
                            <th>Car</th>
                            <th>Booking Date</th>
                            <th>Duration (Days)</th>
                            <th>Total Price</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        while (rs.next()) {
                            String carName = rs.getString("car_name");
                            String bookingDate = rs.getString("booking_date");
                            int days = rs.getInt("days");
                            double totalPrice = rs.getDouble("total_price");
                            String status = rs.getString("status");

                            String statusClass = "";
                            if ("Booked".equalsIgnoreCase(status)) {
                                statusClass = "status-booked";
                            } else if ("Cancelled".equalsIgnoreCase(status)) {
                                statusClass = "status-cancelled";
                            } else if ("Completed".equalsIgnoreCase(status)) {
                                statusClass = "status-completed";
                            }
                        %>
                            <tr>
                                <td><%= carName %></td>
                                <td><%= bookingDate %></td>
                                <td><%= days %></td>
                                <td>$<%= String.format("%.2f", totalPrice) %></td>
                                <td class="<%= statusClass %>"><%= status %></td>
                            </tr>
                        <%
                        }
                        %>
                    </tbody>
                </table>
                <a href="user_dashboard.jsp" class="back-btn"><i class="fas fa-arrow-left"></i> Back to Dashboard</a>
        <%
            } else {
        %>
                <div class="no-bookings">
                    <i class="fas fa-calendar-times"></i>
                    <h2>No Bookings Found</h2>
                    <p>You haven't made any bookings yet. Start by booking your first car!</p>
                    <a href="user_book_car.jsp" class="back-btn"><i class="fas fa-car"></i> Book a Car</a>
                    <br><br>
                    <a href="user_dashboard.jsp" class="back-btn"><i class="fas fa-arrow-left"></i> Back to Dashboard</a>
                </div>
        <%
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException e) {}
            try { if (ps != null) ps.close(); } catch (SQLException e) {}
            try { if (con != null) con.close(); } catch (SQLException e) {}
        }
        %>
    </div>
</body>
</html>