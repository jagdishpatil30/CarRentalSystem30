<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Car</title>
    <style>
        body { 
            font-family: Arial; 
            padding: 30px; 
            background: linear-gradient(to right, rgba(230, 100, 101, 0.8), rgba(145, 152, 229, 0.8)), 
            url('/CarRent/imgs/admin_dashboard.jpg') no-repeat center center fixed;
            background-size: cover;
        }

        form { 
            width: 400px; 
            background: #fff; 
            padding: 20px; 
            border-radius: 8px; 
            box-shadow: 0 0 10px #ccc; 
            margin: 0 auto;
        }

        input { 
            width: 100%; 
            padding: 10px; 
            margin-bottom: 15px; 
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        input[type=submit] { 
            background: #007BFF; 
            color: white; 
            border: none; 
            cursor: pointer; 
            border-radius: 4px;
        }

        input[type=submit]:hover {
            background: #0056b3;
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
            font-size: 24px;
            color: #333;
        }

        .back-btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 20px;
            border-radius: 6px;
            text-decoration: none;
            font-weight: 500;
            background-color: #333;
            color: white;
            margin-top: 20px;
            display: block;
            text-align: center;
            width: 100%;
        }

        .back-btn:hover {
            background-color: #555;
            transform: translateY(-2px);
            opacity: 0.9;
        }

        select {
            width: 100%;
            padding: 10px;
            border-radius: 4px;
            border: 1px solid #ddd;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
        }
    </style>
</head>
<body>

<%
    int id = Integer.parseInt(request.getParameter("id"));
    String name = "", model = "", status = "";
    double price = 0;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/carrent", "root", "jaggu");
        PreparedStatement ps = con.prepareStatement("SELECT * FROM cars WHERE id=?");
        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            name = rs.getString("name");
            model = rs.getString("model");
            price = rs.getDouble("price_per_day");
            status = rs.getString("status");
        }
        con.close();
    } catch (Exception e) {
        out.println("Error loading car: " + e.getMessage());
    }

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String newName = request.getParameter("car_name");
        String newModel = request.getParameter("car_model");
        double newPrice = Double.parseDouble(request.getParameter("rent_price"));
        String newStatus = request.getParameter("status");

        try {
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/carrent", "root", "jaggu");
            PreparedStatement ps = con.prepareStatement("UPDATE cars SET name=?, model=?, price_per_day=?, status=? WHERE id=?");
            ps.setString(1, newName);
            ps.setString(2, newModel);
            ps.setDouble(3, newPrice);
            ps.setString(4, newStatus);
            ps.setInt(5, id);
            ps.executeUpdate();
            con.close();
            response.sendRedirect("manage_cars.jsp");
        } catch (Exception e) {
            out.println("Update failed: " + e.getMessage());
        }
    }
%>

<div class="container">
    <h2>Edit Car</h2>
    <form method="post">
        <input type="text" name="car_name" value="<%= name %>" required>
        <input type="text" name="car_model" value="<%= model %>" required>
        <input type="number" name="rent_price" value="<%= price %>" step="0.01" required>
        <select name="status">
            <option value="Available" <%= status.equals("Available") ? "selected" : "" %>>Available</option>
            <option value="Unavailable" <%= status.equals("Unavailable") ? "selected" : "" %>>Unavailable</option>
        </select>
        <input type="submit" value="Update Car">
    </form>
    <a href="manage_cars.jsp" class="back-btn">
        <i class="fas fa-arrow-left"></i> Back to Car Management
    </a>
</div>

</body>
</html>
