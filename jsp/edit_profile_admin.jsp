<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit User Profile | Admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
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

        input {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 16px;
            transition: var(--transition);
        }

        input:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.2);
            outline: none;
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

        .btn-primary {
            background-color: var(--primary);
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

        .user-id {
            font-family: monospace;
            color: #7f8c8d;
            font-size: 14px;
            margin-top: 5px;
        }

        .message {
            padding: 10px 15px;
            border-radius: 6px;
            margin-bottom: 20px;
            display: none;
        }

        .success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
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
            <h1 class="title"><i class="fas fa-user-edit"></i> Edit User Profile</h1>
            <a href="view_users.jsp" class="back-btn">
                <i class="fas fa-arrow-left"></i> Back
            </a>
        </div>

        <%-- Display messages if any --%>
        <%
            String success = request.getParameter("success");
            String error = request.getParameter("error");
            
            if (success != null) {
        %>
            <div class="message success">
                <i class="fas fa-check-circle"></i> <%= success %>
            </div>
            <script>
                document.querySelector('.message').style.display = 'block';
                setTimeout(() => {
                    document.querySelector('.message').style.opacity = '0';
                }, 3000);
            </script>
        <%
            }
            if (error != null) {
        %>
            <div class="message error">
                <i class="fas fa-exclamation-circle"></i> <%= error %>
            </div>
            <script>
                document.querySelector('.message').style.display = 'block';
            </script>
        <%
            }
        %>

        <%-- Fetch user data --%>
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
                    out.println("<div class='message error'><i class='fas fa-exclamation-circle'></i> Error: " + e.getMessage() + "</div>");
                }
            }
        %>

        <form action="/CarRent/UpdateUserServlet" method="post">
            <input type="hidden" name="id" value="<%= id %>">
            
            <div class="form-group">
                <label>User ID</label>
                <div class="user-id"><%= id %></div>
            </div>
            
            <div class="form-group">
                <label for="name">Full Name</label>
                <input type="text" id="name" name="name" value="<%= name %>" required>
            </div>
            
            <div class="form-group">
                <label for="email">Email Address</label>
                <input type="email" id="email" name="email" value="<%= email %>" required>
            </div>
            
            <div class="form-group">
                <label for="password">New Password (leave blank to keep current)</label>
                <input type="password" id="password" name="password" placeholder="Enter new password">
            </div>
            
            <div class="btn-group">
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-save"></i> Save Changes
                </button>
                <a href="view_users.jsp" class="btn btn-secondary">
                    <i class="fas fa-times"></i> Cancel
                </a>
            </div>
        </form>
    </div>

    <script>
        // Form validation
        document.querySelector('form').addEventListener('submit', function(e) {
            const name = document.getElementById('name').value.trim();
            const email = document.getElementById('email').value.trim();
            
            if (!name || !email) {
                e.preventDefault();
                alert('Please fill in all required fields');
                return false;
            }
            
            if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
                e.preventDefault();
                alert('Please enter a valid email address');
                return false;
            }
        });
    </script>
</body>
</html>