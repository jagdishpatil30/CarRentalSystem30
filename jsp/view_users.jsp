<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>User Management | CarRent Admin</title>
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
          url('/CarRent/imgs/admin_dashboard.jpg') no-repeat center center fixed;
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

        .back-btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 20px;
            border-radius: 6px;
            text-decoration: none;
            font-weight: 500;
            transition: var(--transition);
            background-color: var(--dark-color);
            color: white;
            margin-bottom: 20px;
        }

        .back-btn:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow);
            opacity: 0.9;
        }

        /* Table Styles */
        .card {
            background: white;
            border-radius: 10px;
            padding: 25px;
            box-shadow: var(--shadow);
            margin-bottom: 30px;
        }

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

        .user-id {
            color: #666;
            font-family: monospace;
        }

        .user-email {
            color: var(--primary-color);
        }

        /* Action Buttons */
        .action-btn {
            padding: 6px 12px;
            border-radius: 4px;
            text-decoration: none;
            font-size: 14px;
            margin-right: 5px;
            transition: var(--transition);
        }

        .edit-btn {
            background-color: var(--primary-color);
            color: white;
        }

        .delete-btn {
            background-color: var(--danger-color);
            color: white;
        }

        .action-btn:hover {
            opacity: 0.8;
            transform: translateY(-1px);
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .page-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }
            
            .table {
                display: block;
            }
            
            .table th, .table td {
                padding: 10px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Page Header -->
        <div class="page-header">
            <h1 class="page-title"><i class="fas fa-users-cog"></i>View Users</h1>
            <a href="../admin_dashboard.html" class="back-btn">
                <i class="fas fa-arrow-left"></i> Back to Dashboard
            </a>
        </div>

        <!-- Users Table -->
        <div class="card">
            <div class="table-responsive">
                <table class="table">
                    <thead>
                        <tr>
                            <th><i class="fas fa-id-card"></i> ID</th>
                            <th><i class="fas fa-user"></i> Name</th>
                            <th><i class="fas fa-envelope"></i> Email</th>
                            <th><i class="fas fa-cog"></i> Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/carrent", "root", "jaggu");
                            Statement stmt = con.createStatement();
                            ResultSet rs = stmt.executeQuery("SELECT * FROM user");

                            while (rs.next()) {
                    %>
                        <tr>
                            <td class="user-id"><%= rs.getInt("id") %></td>
                            <td><strong><%= rs.getString("name") %></strong></td>
                            <td class="user-email"><%= rs.getString("email") %></td>
                            <td>
                                <a href="edit_profile_admin.jsp?id=<%= rs.getInt("id") %>" class="action-btn edit-btn">
                                    <i class="fas fa-edit"></i> Edit
                                </a>
                                <a href="/CarRent/DeleteUserServlet?id=<%= rs.getInt("id") %>" class="action-btn delete-btn" 
                                   onclick="return confirmDelete()">
                                    <i class="fas fa-trash-alt"></i> Delete
                                </a>
                            </td>
                        </tr>
                    <%
                            }
                            con.close();
                        } catch (Exception e) {
                    %>
                        <tr>
                            <td colspan="4" style="text-align: center; color: var(--danger-color);">
                                <i class="fas fa-exclamation-triangle"></i> Error loading users: <%= e.getMessage() %>
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
        function confirmDelete() {
            return confirm('Are you sure you want to delete this user?');
        }
    </script>
</body>
</html>
