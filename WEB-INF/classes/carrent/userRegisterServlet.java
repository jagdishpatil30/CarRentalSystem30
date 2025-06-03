package carrent;

import java.io.*;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/userRegisterServlet")
public class userRegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String DB_URL = "jdbc:mysql://localhost:3306/carrent";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "jaggu";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        PrintWriter out = response.getWriter();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            // try-with-resources automatically closes resources
            try (
                Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
                PreparedStatement stmt = conn.prepareStatement("INSERT INTO user (name, email, password) VALUES (?, ?, ?)")
            ) {
                stmt.setString(1, name);
                stmt.setString(2, email);
                stmt.setString(3, password);

                int rows = stmt.executeUpdate();

                if (rows > 0) {
                	out.println("<html>");
                    out.println("<head>");
                    out.println("<title>Registration Success</title>");
                    out.println("<script>");
                    out.println("setTimeout(function() { window.location.href = 'index.html'; }, 4000);");
                    out.println("</script>");
                    out.println("</head>");
                    out.println("<body>");
                    out.println("<h2>Registration Successful! Please Wait Redirecting to home Page...</h2>");
                    out.println("</body>");
                    out.println("</html>");
                } else {
                    out.println("<h2>Registration Failed. Please try again.</h2>");
                }
            }

        } catch (Exception e) {
            out.println("<h2>Error: " + e.getMessage() + "</h2>");
            e.printStackTrace();
        }
    }
}