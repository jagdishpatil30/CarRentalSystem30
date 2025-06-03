package carrent;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/UserBookCar")
public class UserBookCar extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get form data
        String userName = request.getParameter("user_name");
        String carName = request.getParameter("car_name");
        String daysStr = request.getParameter("days");
        String totalPriceStr = request.getParameter("total_price");

        // Convert to appropriate types
        int days = Integer.parseInt(daysStr);
        double totalPrice = Double.parseDouble(totalPriceStr);
        String bookingDate = java.time.LocalDate.now().toString();

        try {
            // Load JDBC driver and establish connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/carrent", "root", "jaggu");

            // Insert booking into bookings table
            String insertBooking = "INSERT INTO bookings (user_name, car_name, days, total_price, booking_date, status) VALUES (?, ?, ?, ?, ?, 'Booked')";
            PreparedStatement ps = con.prepareStatement(insertBooking);
            ps.setString(1, userName);
            ps.setString(2, carName);
            ps.setInt(3, days);
            ps.setDouble(4, totalPrice);
            ps.setDate(5, Date.valueOf(bookingDate));
            ps.executeUpdate();

            // Update car status to 'Unavailable'
            String updateCar = "UPDATE cars SET status='Unavailable' WHERE name = ?";
            PreparedStatement ps2 = con.prepareStatement(updateCar);
            ps2.setString(1, carName.split(" - ")[0]); // Use only the car name (exclude model)
            ps2.executeUpdate();

            // Close connections
            ps.close();
            ps2.close();
            con.close();

            // Store booking data in session
            HttpSession session = request.getSession();
            session.setAttribute("user_name", userName);
            session.setAttribute("car_name", carName);
            session.setAttribute("days", daysStr);
            session.setAttribute("total_price", totalPriceStr);
            session.setAttribute("booking_date", bookingDate);
            
            // Redirect to payment page
            response.sendRedirect("jsp/payment.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Booking Failed: " + e.getMessage());
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}