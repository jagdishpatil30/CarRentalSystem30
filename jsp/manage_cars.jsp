<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Cars | CarRent Admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        :root {
            --primary-color: #3498db;
            --secondary-color: #2ecc71;
            --danger-color: #e74c3c;
            --dark-color: #2c3e50;
            --light-color: #ecf0f1;
            --shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            --transition: all 0.3s ease;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
   background: linear-gradient(to right, rgba(230, 100, 101, 0.8), rgba(145, 152, 229, 0.8)), 
          url('/CarRent/imgs/admin_dashboard.jpg')fixed;
    	  background-size: cover;
        
}

 
        .container {
            max-width: 1200px;
            margin: 0 auto;
        }

        /* Header Styles */
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }

        .page-title {
            font-size: 28px;
            color: var(--dark-color);
            font-weight: 600;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 20px;
            border-radius: 6px;
            text-decoration: none;
            font-weight: 500;
            transition: var(--transition);
            border: none;
            cursor: pointer;
        }

        .btn-primary {
            background-color: var(--primary-color);
            color: white;
        }

        .btn-danger {
            background-color: var(--danger-color);
            color: white;
        }

        .btn-secondary {
            background-color: var(--dark-color);
            color: white;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow);
            opacity: 0.9;
        }

        /* Form Styles */
        .card {
            background: white;
            border-radius: 10px;
            padding: 25px;
            box-shadow: var(--shadow);
            margin-bottom: 30px;
        }

        .card-title {
            font-size: 22px;
            margin-bottom: 20px;
            color: var(--dark-color);
            border-bottom: 2px solid var(--light-color);
            padding-bottom: 10px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #555;
        }

        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 16px;
            transition: var(--transition);
        }

        .form-control:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.2);
        }

        /* Table Styles */
        .table-responsive {
            overflow-x: auto;
        }

        .table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            box-shadow: var(--shadow);
            border-radius: 10px;
            overflow: hidden;
        }

        .table th {
            background-color: var(--dark-color);
            color: white;
            padding: 15px;
            text-align: left;
            font-weight: 500;
        }

        .table td {
            padding: 15px;
            border-bottom: 1px solid #eee;
            vertical-align: middle;
        }

        .table tr:last-child td {
            border-bottom: none;
        }

        .table tr:hover {
            background-color: #f8f9fa;
        }

        .status-available {
            color: var(--secondary-color);
            font-weight: 500;
        }

        .status-unavailable {
            color: var(--danger-color);
            font-weight: 500;
        }

        .action-buttons {
            display: flex;
            gap: 10px;
        }

        /* Alert Message */
        .alert {
            padding: 15px;
            border-radius: 6px;
            margin-bottom: 20px;
            font-weight: 500;
        }

        .alert-success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .alert-error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .page-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }

            .action-buttons {
                flex-direction: column;
                gap: 8px;
            }

            .btn {
                width: 100%;
                justify-content: center;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Page Header -->
        <div class="page-header">
            <h1 class="page-title"><i class="fas fa-car"></i> Manage Cars</h1>
            <a href="../admin_dashboard.html" class="btn btn-secondary">
                <i class="fas fa-home"></i> Dashboard
            </a>
        </div>

        <!-- Message Display -->
        <%
            String msg = "";
            String alertClass = "";
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                String name = request.getParameter("car_name");
                String model = request.getParameter("car_model");
                String priceStr = request.getParameter("rent_price");

                try {
                    double price = Double.parseDouble(priceStr);
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/carrent", "root", "jaggu");

                    PreparedStatement ps = con.prepareStatement("INSERT INTO cars (name, model, price_per_day, status) VALUES (?, ?, ?, 'Available')");
                    ps.setString(1, name);
                    ps.setString(2, model);
                    ps.setDouble(3, price);
                    ps.executeUpdate();

                    msg = "Car added successfully!";
                    alertClass = "alert-success";
                    con.close();
                } catch (Exception e) {
                    msg = "Error: " + e.getMessage();
                    alertClass = "alert-error";
                }
            }
        %>
        <% if (!msg.isEmpty()) { %>
            <div class="alert <%= alertClass %>">
                <i class="fas <%= alertClass.equals("alert-success") ? "fa-check-circle" : "fa-exclamation-circle" %>"></i> 
                <%= msg %>
            </div>
        <% } %>

        <!-- Add Car Form -->
        <div class="card">
            <h2 class="card-title"><i class="fas fa-plus-circle"></i> Add New Car</h2>
            <form action="manage_cars.jsp" method="post">
                <div class="form-group">
                    <label for="car_name" class="form-label">Car Name</label>
                    <input type="text" id="car_name" name="car_name" class="form-control" placeholder="e.g., Toyota" required>
                </div>
                
                <div class="form-group">
                    <label for="car_model" class="form-label">Car Model</label>
                    <input type="text" id="car_model" name="car_model" class="form-control" placeholder="e.g., Corolla" required>
                </div>
                
                <div class="form-group">
                    <label for="rent_price" class="form-label">Daily Rental Price (₹)</label>
                    <input type="number" id="rent_price" name="rent_price" class="form-control" placeholder="e.g., 2500" step="0.01" min="0" required>
                </div>
                
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-save"></i> Add Car
                </button>
            </form>
        </div>

        <!-- Cars Listing -->
        <div class="card">
            <h2 class="card-title"><i class="fas fa-list"></i> Car Inventory</h2>
            <div class="table-responsive">
                <table class="table">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Name</th>
                            <th>Model</th>
                            <th>Price/Day</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/carrent", "root", "jaggu");
                            Statement stmt = con.createStatement();
                            ResultSet rs = stmt.executeQuery("SELECT * FROM cars");

                            int serialNo = 1;
                            while (rs.next()) {
                                String statusClass = "Available".equals(rs.getString("status")) ? "status-available" : "status-unavailable";
                    %>
                        <tr>
                            <td><%= serialNo++ %></td>
                            <td><%= rs.getString("name") %></td>
                            <td><%= rs.getString("model") %></td>
                            <td>₹<%= String.format("%.2f", rs.getDouble("price_per_day")) %></td>
                            <td class="<%= statusClass %>">
                                <i class="fas <%= "Available".equals(rs.getString("status")) ? "fa-check-circle" : "fa-times-circle" %>"></i> 
                                <%= rs.getString("status") %>
                            </td>
                            <td>
                                <div class="action-buttons">
                                    <a href="edit_car.jsp?id=<%= rs.getInt("id") %>" class="btn btn-primary">
                                        <i class="fas fa-edit"></i> Edit
                                    </a>
                                    <a href="delete_car.jsp?id=<%= rs.getInt("id") %>" class="btn btn-danger" 
                                       onclick="return confirm('Are you sure you want to delete this car?')">
                                        <i class="fas fa-trash-alt"></i> Remove
                                    </a>
                                </div>
                            </td>
                        </tr>
                    <%
                            }
                            con.close();
                        } catch (Exception e) {
                    %>
                        <tr>
                            <td colspan="6" style="text-align: center; color: var(--danger-color);">
                                <i class="fas fa-exclamation-triangle"></i> Error loading car inventory
                            </td>
                        </tr>
                    <%
                        }
                    %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <script>
        // Confirm before delete
        document.querySelectorAll('.btn-danger').forEach(btn => {
            btn.addEventListener('click', function(e) {
                if (!confirm('Are you sure you want to delete this car?')) {
                    e.preventDefault();
                }
            });
        });
    </script>
</body>
</html>