package carrent;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

/**
 * Servlet implementation class UpdateUserServlet
 */

@WebServlet("/UpdateUserServlet")
public class UpdateUserServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/carrent";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "jaggu";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("id");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            int id = Integer.parseInt(idStr);
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);

            PreparedStatement ps;
            if (password != null && !password.trim().isEmpty()) {
                String sql = "UPDATE user SET name = ?, email = ?, password = ? WHERE id = ?";
                ps = con.prepareStatement(sql);
                ps.setString(1, name);
                ps.setString(2, email);
                ps.setString(3, password);
                ps.setInt(4, id);
            } else {
                String sql = "UPDATE user SET name = ?, email = ? WHERE id = ?";
                ps = con.prepareStatement(sql);
                ps.setString(1, name);
                ps.setString(2, email);
                ps.setInt(3, id);
            }

            int rows = ps.executeUpdate();
            con.close();

            if (rows > 0) {
                response.sendRedirect("jsp/edit_profile_admin.jsp?id=" + id + "&success=User updated successfully");
            } else {
                response.sendRedirect("jsp/edit_profile_admin.jsp?id=" + id + "&error=Failed to update user");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("edit_profile_admin.jsp?id=" + idStr + "&error=" + e.getMessage());
        }
    }
}