<%@ page import="java.sql.*, java.text.NumberFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>All Bookings</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body {
           background: linear-gradient(to right, rgba(230, 100, 101, 0.8), rgba(145, 152, 229, 0.8)), 
          url('/CarRent/imgs/admin_dashboard.jpg') no-repeat center center fixed;
    	  background-size: cover;
        }
        .container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 20px;
            background-color: rgba(255, 255, 255, 0.9);
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.2);
        }

        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 15px;
            border-bottom: 1px solid rgba(0, 0, 0, 0.1);
        }

        .page-title {
            font-size: 2rem;
            font-weight: 600;
            color: #3a0ca3;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .page-title i {
            color: #4361ee;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 20px;
            background: #4361ee;
            color: white;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .btn:hover {
            background: #3a0ca3;
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(67, 97, 238, 0.2);
        }

        .bookings-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            background: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            color: #333;
        }

        .bookings-table thead {
            background: linear-gradient(135deg, #4361ee, #3a0ca3);
            color: white;
        }

        .bookings-table th {
            padding: 15px;
            text-align: left;
            font-weight: 500;
        }

        .bookings-table th i {
            margin-right: 8px;
        }

        .bookings-table td {
            padding: 15px;
            border-bottom: 1px solid #eee;
            vertical-align: middle;
        }

        .bookings-table td i {
            margin-right: 8px;
            color: #4361ee;
        }

        .bookings-table tr:last-child td {
            border-bottom: none;
        }

       

        .action-cell {
            display: flex;
            gap: 8px;
        }

        .action-btn {
            padding: 8px 15px;
            border-radius: 8px;
            text-decoration: none;
            font-size: 0.85rem;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }

        .delete-btn {
            background: rgba(239, 35, 60, 0.1);
            color: #ef233c;
        }

        .delete-btn:hover {
            background: rgba(239, 35, 60, 0.2);
        }

        .no-bookings {
            text-align: center;
            padding: 30px;
            color: #6c757d;
            background: white;
            border-radius: 8px;
        }

        .price-cell {
            font-weight: 600;
            color: #3a0ca3;
        }

        /* Responsive adjustments */
        @media (max-width: 768px) {
            .bookings-table {
                display: block;
                overflow-x: auto;
            }
            
            body {
                padding: 15px;
            }
            
            .page-title {
                font-size: 1.5rem;
            }
        }

        @media (max-width: 480px) {
            .top-bar {
                flex-direction: column;
                gap: 10px;
                align-items: flex-start;
            }
            
            .action-cell {
                flex-direction: column;
                gap: 8px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="top-bar">
            <h1 class="page-title"><i class="fas fa-calendar-check"></i> All Bookings</h1>
            <a href="../admin_dashboard.html" class="btn">
                <i class="fas fa-arrow-left"></i> Back to Dashboard
            </a>
        </div>

        <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/carrent", "root", "jaggu");

                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT * FROM bookings");

                if (!rs.isBeforeFirst()) {
        %>
                    <div class="no-bookings">
                        <i class="fas fa-calendar-times" style="font-size: 3rem; margin-bottom: 1rem; color: #adb5bd;"></i>
                        <h3>No Bookings Found</h3>
                        <p>There are currently no bookings in the system.</p>
                    </div>
        <%
                } else {
        %>
                    <table class="bookings-table">
                        <thead>
                            <tr>
                                <th><i class="fas fa-id-card"></i> Booking ID</th>
                                <th><i class="fas fa-user"></i> User</th>
                                <th><i class="fas fa-car"></i> Car</th>
                                <th><i class="fas fa-clock"></i> Duration</th>
                                <th><i class="fas fa-money-bill-wave"></i> Total Price</th>
                                <th><i class="fas fa-calendar-day"></i> Booking Date</th>
                                <th><i class="fas fa-cog"></i> Action</th>
                            </tr>
                        </thead>
                        <tbody>
        <%
                            while (rs.next()) {
        %>
                                <tr>
                                    <td> #<%= rs.getInt("id") %></td>
                                    <td> <%= rs.getString("user_name") %></td>
                                    <td><%= rs.getString("car_name") %></td>
                                    <td> <%= rs.getInt("days") %> days</td>
                                    <td class="price-cell"> <%= NumberFormat.getCurrencyInstance(new java.util.Locale("en", "IN")).format(rs.getDouble("total_price")) %></td>
                                    <td> <%= rs.getDate("booking_date") %></td>
                                    <td class="action-cell">
                                        <a href="../ReturnCarServlet?id=<%= rs.getInt("id") %>" 
                                           class="action-btn delete-btn"
                                           onclick="return confirm('Are you sure you want to return this car?');">
                                            <i class="fas fa-car"></i> Return Car
                                        </a>
                                    </td>
                                </tr>
        <%
                            }
        %>
                        </tbody>
                    </table>
        <%
                }
                conn.close();
            } catch (Exception e) {
        %>
                <div class="no-bookings" style="color: #ef233c;">
                    <i class="fas fa-exclamation-triangle" style="font-size: 3rem; margin-bottom: 1rem;"></i>
                    <h3>Error Loading Bookings</h3>
                    <p><%= e.getMessage() %></p>
                </div>
        <%
            }
        %>
    </div>
</body>
</html>