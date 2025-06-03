<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Get all booking details from session
    String userName = (String) session.getAttribute("user_name");
    String carName = (String) session.getAttribute("car_name");
    String days = (String) session.getAttribute("days");
    String totalPrice = (String) session.getAttribute("total_price");
    String bookingDate = (String) session.getAttribute("booking_date");

    // Set default values if null
    if (userName == null) userName = "Guest";
    if (carName == null) carName = "Car Model";
    if (days == null) days = "1";
    if (totalPrice == null) totalPrice = "0.00";
    if (bookingDate == null) bookingDate = new java.text.SimpleDateFormat("dd-MM-yyyy").format(new java.util.Date());
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Booking Receipt</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
    <style>
        body {
            background: url('../imgs/11.jpg') no-repeat center center/cover;
            font-family: 'Poppins', sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
        }

        .receipt-container {
            background: #fff;
            padding: 30px;
            max-width: 500px;
            width: 100%;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        .receipt-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .receipt-header h2 {
            color: #4361ee;
            margin-bottom: 5px;
        }

        .receipt-header .success-icon {
            font-size: 40px;
            color: #4cc9f0;
        }

        .receipt-details {
            border-top: 1px solid #ddd;
            padding-top: 20px;
        }

        .receipt-details .row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
            font-size: 1rem;
        }

        .receipt-details .label {
            color: #555;
        }

        .receipt-details .value {
            font-weight: 600;
            color: #222;
        }

        .back-home {
            margin-top: 30px;
            text-align: center;
        }

        .back-home a {
            text-decoration: none;
            background: #4361ee;
            color: white;
            padding: 10px 20px;
            border-radius: 8px;
            transition: 0.3s;
        }

        .back-home a:hover {
            background: #3a0ca3;
        }
    </style>
</head>
<body>
    <div class="receipt-container">
        <div class="receipt-header">
            <div class="success-icon">✅</div>
            <h2>Booking Confirmation</h2>
            <p>Thank you for your booking!</p>
        </div>

        <div class="receipt-details">
            <div class="row">
                <span class="label">Customer Name:</span>
                <span class="value"><%= userName %></span>
            </div>
            <div class="row">
                <span class="label">Car Booked:</span>
                <span class="value"><%= carName %></span>
            </div>
            <div class="row">
                <span class="label">Booking Duration:</span>
                <span class="value"><%= days %> day(s)</span>
            </div>
            <div class="row">
                <span class="label">Total Amount:</span>
                <span class="value">₹<%= totalPrice %></span>
            </div>
            <div class="row">
                <span class="label">Booking Date:</span>
                <span class="value"><%= bookingDate %></span>
            </div>
        </div>

        <div class="back-home">
            <a href="user_dashboard.jsp">Back to Dashboard</a>
        </div>
    </div>
</body>
</html>
