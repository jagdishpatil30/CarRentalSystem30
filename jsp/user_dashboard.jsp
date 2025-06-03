<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%
// Check if user is logged in
if (session.getAttribute("email") == null) {
    response.sendRedirect("index.html");
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
  <title>User Dashboard - Car Rental</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
  <style>
    /* Original styles remain the same */
    body {
      margin: 0;
      font-family: 'Poppins', sans-serif;
      background: url('../imgs/11.jpg') no-repeat center center/cover;
      min-height: 100vh;
      color: #333;
      animation: fadeIn 0.8s ease-in-out;
    }

    @keyframes fadeIn {
      from { opacity: 0; }
      to { opacity: 1; }
    }

    .dashboard-container {
      padding: 30px;
      max-width: 1200px;
      margin: auto;
      animation: slideUp 0.8s ease-out;
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

    .card-container {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
      gap: 20px;
    }

    .card {
      background: rgba(0,0,0,0.60);
      padding: 15px 10px;
      border-radius: 15px;
      text-align: center;
      box-shadow: 0 8px 25px rgba(0,0,0,0.1);
      transition: all 0.3s ease;
      opacity: 0;
      animation: cardFadeIn 0.6s forwards;
    }

    .card:nth-child(1) { animation-delay: 0.2s; }
    .card:nth-child(2) { animation-delay: 0.4s; }
    .card:nth-child(3) { animation-delay: 0.6s; }

    @keyframes cardFadeIn {
      from { 
        opacity: 0;
        transform: translateY(20px);
      }
      to { 
        opacity: 1;
        transform: translateY(0);
      }
    }

    .card:hover {
      transform: translateY(-8px) scale(1.02);
      box-shadow: 0 12px 30px rgba(0,0,0,0.2);
    }

    .card h3 {
      color: #DE3163;
      margin-top: 0;
      font-size: 22px;
      transition: color 0.3s;
    }

    .card:hover h3 {
      color: #FF6B8B;
    }

    .card h3 i {
      margin-right: 8px;
      transition: transform 0.3s;
    }

    .card:hover h3 i {
      transform: rotate(15deg);
    }

    .card p {
      color: #FFBF00;
      margin: 20px 0;
      font-size: 16px;
      transition: color 0.3s;
    }

    .card:hover p {
      color: #FFD700;
    }

    .btn {
      display: inline-block;
      background: #6495ED;
      color: white;
      padding: 10px 20px;
      border-radius: 25px;
      text-decoration: none;
      font-weight: 600;
      transition: all 0.3s;
      position: relative;
      overflow: hidden;
    }

    .btn:hover {
      background: #005fcc;
      transform: translateY(-3px);
      box-shadow: 0 5px 15px rgba(0,0,0,0.2);
    }

    .btn i {
      margin-right: 6px;
      transition: transform 0.3s;
    }

    .btn:hover i {
      transform: translateX(5px);
    }

    .btn::after {
      content: '';
      position: absolute;
      top: 0;
      left: -100%;
      width: 100%;
      height: 100%;
      background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
      transition: 0.5s;
    }

    .btn:hover::after {
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

  <div class="card-container">
    <div class="card">
      <h3><i class="fas fa-car"></i> Book Car</h3>
      <p>See what's available and choose your drive.</p>
      <a href="user_book_car.jsp" class="btn"><i class="fas fa-arrow-right"></i> Book Now</a>
    </div>

    <div class="card">
      <h3><i class="fas fa-calendar-check"></i> My Bookings</h3>
      <p>Check your bookings.</p>
      <a href="my_bookings.jsp" class="btn"><i class="fas fa-eye"></i> View Bookings</a>
    </div>

    <div class="card">
      <h3><i class="fas fa-user-edit"></i> Edit Profile</h3>
      <p>Update your name, password.</p>
      <a href="edit_profile.jsp" class="btn"><i class="fas fa-edit"></i> Edit</a>
    </div>
  </div>
</div>

</body>
</html>