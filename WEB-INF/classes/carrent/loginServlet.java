package carrent;

import java.io.*;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/loginServlet")
public class loginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/carrent", "root", "jaggu");
            
            ps = con.prepareStatement("SELECT * FROM user WHERE email=? AND password=?");
            ps.setString(1, email);
            ps.setString(2, password);
            rs = ps.executeQuery();
            
            if (rs.next()) {
                // Create session and store user email
                HttpSession session = request.getSession();
                session.setAttribute("email", email);
                
                // Redirect to user dashboard
                response.sendRedirect("jsp/user_dashboard.jsp");
            } else {
                // Invalid credentials
                response.sendRedirect("index.html?error=1");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("index.html?error=2");
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException e) {}
            try { if (ps != null) ps.close(); } catch (SQLException e) {}
            try { if (con != null) con.close(); } catch (SQLException e) {}
        }
    }
}