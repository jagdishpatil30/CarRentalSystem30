<%@ page import="java.sql.*" %> 
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Book a Car</title>

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">

    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

    <style>
        /* Animations */
        @keyframes fadeInBody {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: url('../imgs/11.jpg') no-repeat center center/cover;
            margin: 0;
            padding: 0;
            min-height: 100vh;
            color: #333;
            animation: fadeInBody 1s ease-in;
        }

        .dashboard-container {
            padding: 30px;
            max-width: 1200px;
            margin: auto;
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

        .header h1 {
            margin: 0;
            color: #FFA07A;
            font-size: 28px;
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.02); }
            100% { transform: scale(1); }
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

        .logout-btn i {
            margin-right: 8px;
        }

        .logout-btn:hover {
            background: #d63b1f;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
        }

        .container {
            background-color: rgba(255, 255, 255, 0.95);
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            padding: 30px;
            width: 100%;
            max-width: 450px;
            margin: auto;
            animation: slideIn 1.2s ease-out;
        }

        h2 {
            color: #2c3e50;
            margin: 0 0 20px 0;
            font-size: 24px;
            text-align: center;
        }

        .form-group {
            margin-bottom: 15px;
        }

        label {
            display: block;
            margin-bottom: 6px;
            font-weight: 600;
            color: #2c3e50;
            font-size: 14px;
        }

        input, select {
            width: 100%;
            padding: 10px 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
            box-sizing: border-box;
            transition: all 0.2s;
        }

        input:focus, select:focus {
            border-color: #3498db;
            box-shadow: 0 0 0 2px rgba(52, 152, 219, 0.2);
            outline: none;
        }

        input[readonly] {
            background-color: #f5f5f5;
            color: #666;
        }

        .btn-submit {
            background-color: #3498db;
            color: white;
            border: none;
            padding: 10px;
            font-size: 15px;
            font-weight: 600;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.2s, transform 0.3s, box-shadow 0.3s;
            width: 100%;
            margin-top: 5px;
        }

        .btn-submit:hover {
            background-color: #2980b9;
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(0,0,0,0.15);
        }

        .btn-dashboard {
            display: block;
            background-color: #2ecc71;
            color: white;
            text-align: center;
            padding: 10px;
            font-size: 15px;
            font-weight: 600;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.2s, transform 0.3s, box-shadow 0.3s;
            text-decoration: none;
            margin-top: 15px;
        }

        .btn-dashboard:hover {
            background-color: #27ae60;
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(0,0,0,0.15);
        }

        .price-display {
            font-size: 16px;
            font-weight: bold;
            color: #2c3e50;
            margin-top: 5px;
        }
    </style>

    <script>
        let carPrices = {};

        function updatePrice() {
            const car = document.getElementById("car_name").value;
            const days = document.getElementById("days").value;
            const price = carPrices[car] || 0;
            const total = price * (days || 0);
            document.getElementById("total_price").value = total.toFixed(2);
            document.getElementById("price_display").textContent = total.toFixed(2);
        }
    </script>
</head>

<body>
<%
    String userEmail = (String) session.getAttribute("email");
    String userName = "";

    if (userEmail != null) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/carrent", "root", "jaggu");
            PreparedStatement ps = con.prepareStatement("SELECT name FROM user WHERE email = ?");
            ps.setString(1, userEmail);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                userName = rs.getString("name");
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>

<div class="dashboard-container">
    <!-- Header -->
    <div class="header">
        <h1>Welcome, <%= userName %>!</h1>
        <a href="../index.html" class="logout-btn"><i class="fas fa-sign-out-alt"></i> Logout</a>
    </div>

    <div class="container">
        <h2>Book a Car</h2>

        <form action="/CarRent/UserBookCar" method="post">
            <div class="form-group">
                <label>Your Name</label>
                <input type="text" name="user_name" value="<%= userName %>" readonly required>
            </div>

            <div class="form-group">
                <label>Select Car</label>
                <select name="car_name" id="car_name" onchange="updatePrice()" required>
                    <option value="">-- Select a Car --</option>
                    <%
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/carrent", "root", "jaggu");
                            Statement stmt = con.createStatement();
                            ResultSet rs = stmt.executeQuery("SELECT name, model, price_per_day FROM cars WHERE status='Available'");

                            while (rs.next()) {
                                String name = rs.getString("name");
                                String model = rs.getString("model");
                                double price = rs.getDouble("price_per_day");
                                String carKey = name + " - " + model;
                    %>
                        <option value="<%= carKey %>"><%= carKey %> (₹<%= price %>/day)</option>
                        <script>carPrices["<%= carKey %>"] = <%= price %>;</script>
                    <%
                            }
                            con.close();
                        } catch (Exception e) {
                            out.println("<option>Error loading cars</option>");
                        }
                    %>
                </select>
            </div>

            <div class="form-group">
                <label>Rental Days</label>
                <input type="number" name="days" id="days" min="1" oninput="updatePrice()" required>
            </div>

            <div class="form-group">
                <label>Total Price</label>
                <div class="price-display">₹<span id="price_display">0.00</span></div>
                <input type="hidden" name="total_price" id="total_price" required>
            </div>

            <button type="submit" class="btn-submit">Book Now</button>
            <a href="user_dashboard.jsp" class="btn-dashboard">Back to Dashboard</a>
        </form>
    </div>
</div>
</body>
</html>