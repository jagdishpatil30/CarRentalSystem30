<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%
    if (session.getAttribute("email") == null) {
        response.sendRedirect("index.html");
        return;
    }

    String userEmail = (String) session.getAttribute("email");

    String name = "";
    String email = "";
    String password = "";

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/carrent", "root", "jaggu");
        ps = con.prepareStatement("SELECT * FROM user WHERE email = ?");
        ps.setString(1, userEmail);
        rs = ps.executeQuery();
        if (rs.next()) {
            name = rs.getString("name");
            email = rs.getString("email");
            password = rs.getString("password");
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
    <title>Edit Profile - Car Rental</title>
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
            font-family: 'Poppins', sans-serif;
            background: url('../imgs/11.jpg') no-repeat center center/cover;
            margin: 0;
            padding: 0;
            color: #333;
            animation: fadeIn 0.8s ease-in-out;
            min-height: 100vh;
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

        .form-container {
            background: rgba(255,255,255,0.9);
            max-width: 500px;
            margin: 0 auto;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 6px 25px rgba(0, 0, 0, 0.2);
            animation: fadeIn 0.8s ease-out;
        }

        .form-container h2 {
            text-align: center;
            color: #6495ED;
            margin-bottom: 25px;
        }

        input[type="text"], input[type="email"], input[type="password"] {
            width: 100%;
            padding: 12px;
            margin-top: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-family: 'Poppins', sans-serif;
            transition: all 0.3s;
        }

        input[type="text"]:focus, 
        input[type="email"]:focus, 
        input[type="password"]:focus {
            border-color: #6495ED;
            box-shadow: 0 0 0 2px rgba(100, 149, 237, 0.2);
            outline: none;
        }

        input[type="submit"] {
            background-color: #6495ED;
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 25px;
            cursor: pointer;
            font-weight: bold;
            width: 100%;
            font-family: 'Poppins', sans-serif;
            transition: all 0.3s;
            position: relative;
            overflow: hidden;
        }

        input[type="submit"]:hover {
            background-color: #005fcc;
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }

        input[type="submit"]::after {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: 0.5s;
        }

        input[type="submit"]:hover::after {
            left: 100%;
        }

        .back-link {
            display: block;
            text-align: center;
            margin-top: 20px;
            color: #6495ED;
            text-decoration: none;
            font-weight: bold;
            transition: all 0.3s;
        }

        .back-link:hover {
            color: #005fcc;
            transform: translateX(-5px);
        }

        .back-link i {
            margin-right: 6px;
            transition: transform 0.3s;
        }

        .back-link:hover i {
            transform: translateX(-5px);
        }
    </style>
</head>
<body>
<div class="dashboard-container">
    <div class="header">
        <h1>Welcome, <%= name %>!</h1>
        <a href="../index.html" class="logout-btn"><i class="fas fa-sign-out-alt"></i> Logout</a>
    </div>

    <div class="form-container">
        <h2><i class="fas fa-user-edit"></i> Edit Profile</h2>
        <form action="/CarRent/updateProfile" method="post" onsubmit="return confirm('Are you sure you want to update your profile?');">
            <label>Name:</label>
            <input type="text" name="name" value="<%= name %>" required>

            <label>Email:</label>
            <input type="email" name="email" value="<%= email %>" readonly>

           <label>Password:</label>
			<input type="password" name="password" id="password" value="<%= password %>" required>
			<br>
			<input type="checkbox" id="showPassword" onclick="togglePassword()"> Show Password
			<script>
    function togglePassword() {
        const passwordInput = document.getElementById("password");
        if (passwordInput.type === "password") {
            passwordInput.type = "text";
        } else {
            passwordInput.type = "password";
        }
    }
</script>

            <input type="submit" value="Update Profile">
        </form>
        <a class="back-link" href="user_dashboard.jsp"><i class="fas fa-arrow-left"></i> Back to Dashboard</a>
    </div>
</div>
</body>
</html>