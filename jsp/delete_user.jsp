<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Delete User | Admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        /* SAME CSS AS edit_user.jsp */
        :root {
            --primary: #3498db;
            --secondary: #2ecc71;
            --danger: #e74c3c;
            --dark: #2c3e50;
            --light: #ecf0f1;
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
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }

        .edit-container {
            max-width: 600px;
            width: 100%;
            background: white;
            border-radius: 10px;
            box-shadow: var(--shadow);
            padding: 30px;
            animation: fadeIn 0.5s ease;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 1px solid #eee;
        }

        .title {
            font-size: 24px;
            color: var(--dark);
            font-weight: 600;
        }

        .back-btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 8px 16px;
            border-radius: 6px;
            text-decoration: none;
            font-weight: 500;
            background-color: var(--dark);
            color: white;
            transition: var(--transition);
        }

        .back-btn:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow);
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: var(--dark);
        }

        input, .user-id {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 16px;
            background-color: #f4f4f4;
        }

        .btn-group {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }

        .btn {
            padding: 12px 20px;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            font-weight: 500;
            cursor: pointer;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            flex: 1;
        }

        .btn-danger {
            background-color: var(--danger);
            color: white;
        }

        .btn-secondary {
            background-color: #95a5a6;
            color: white;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow);
            opacity: 0.9;
        }

        @media (max-width: 768px) {
            .edit-container {
                padding: 20px;
            }
            .btn-group {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <div class="edit-container">
        <div class="header">
            <h1 class="title"><i class="fas fa-user-times"></i> Delete User</h1>
            <a href="view_users.jsp" class="back-btn">
                <i class="fas fa-arrow-left"></i> Back
            </a>
        </div>

        <%-- Fetch user data from database --%>
        <%
            String id = request.getParameter("id");
            String name = "";
            String email = "";

            if (id != null) {
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/carrent", "root", "jaggu");
                    PreparedStatement ps = con.prepareStatement("SELECT * FROM user WHERE id = ?");
                    ps.setString(1, id);
                    ResultSet rs = ps.executeQuery();

                    if (rs.next()) {
                        name = rs.getString("name");
                        email = rs.getString("email");
                    }
                    con.close();
                } catch (Exception e) {
                    out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
                }
            }
        %>

        <form action="/CarRent/DeleteUserServlet" method="post">
            <input type="hidden" name="id" value="<%= id %>">

            <div class="form-group">
                <label>User ID</label>
                <div class="user-id"><%= id %></div>
            </div>

            <div class="form-group">
                <label>Full Name</label>
                <div class="user-id"><%= name %></div>
            </div>

            <div class="form-group">
                <label>Email Address</label>
                <div class="user-id"><%= email %></div>
            </div>

            <p style="color: #e74c3c; font-weight: 600; margin-top: 10px;">Are you sure you want to permanently delete this user?</p>

            <div class="btn-group">
                <button type="submit" class="btn btn-danger">
                    <i class="fas fa-trash-alt"></i> Delete
                </button>
                <a href="view_users.jsp" class="btn btn-secondary">
                    <i class="fas fa-times"></i> Cancel
                </a>
            </div>
        </form>
    </div>
</body>
</html>
