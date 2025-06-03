<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String id = request.getParameter("id");
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    if (id != null && name != null && email != null) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/carrent", "root", "jaggu");
            
            if (password != null && !password.isEmpty()) {
                // Update with new password
                PreparedStatement ps = con.prepareStatement(
                    "UPDATE user SET name = ?, email = ?, password = ? WHERE id = ?");
                ps.setString(1, name);
                ps.setString(2, email);
                ps.setString(3, password);
                ps.setString(4, id);
                ps.executeUpdate();
            } else {
                // Update without changing password
                PreparedStatement ps = con.prepareStatement(
                    "UPDATE user SET name = ?, email = ? WHERE id = ?");
                ps.setString(1, name);
                ps.setString(2, email);
                ps.setString(3, id);
                ps.executeUpdate();
            }
            
            con.close();
            response.sendRedirect("edit_profile_admin.jsp?id=" + id + "&success=User+profile+updated+successfully");
        } catch (Exception e) {
            response.sendRedirect("edit_profile_admin.jsp?id=" + id + "&error=" + e.getMessage().replace(" ", "+"));
        }
    } else {
        response.sendRedirect("view_users.jsp?error=Invalid+parameters");
    }
%>