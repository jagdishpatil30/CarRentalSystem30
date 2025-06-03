package carrent;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 * Servlet implementation class updateProfile
 */
@WebServlet("/updateProfile")
public class updateProfile extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        Connection con = null;
        PreparedStatement ps = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/carrent", "root", "jaggu");

            ps = con.prepareStatement("UPDATE user SET name = ?, password = ? WHERE email = ?");
            ps.setString(1, name);
            ps.setString(2, password);
            ps.setString(3, email);

            int result = ps.executeUpdate();

            if (result > 0) {
                HttpSession session = request.getSession();
                session.setAttribute("updateStatus", "success");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (ps != null) ps.close(); } catch (SQLException e) {}
            try { if (con != null) con.close(); } catch (SQLException e) {}
        }

        response.sendRedirect("profile_update_success.html");
    }
}