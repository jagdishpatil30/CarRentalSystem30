package carrent;

import java.io.IOException;
import java.sql.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/ReturnCarServlet")
public class ReturnCarServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String DB_URL = "jdbc:mysql://localhost:3306/carrent";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "jaggu";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String bookingIdParam = request.getParameter("id");

        if (bookingIdParam == null || bookingIdParam.isEmpty()) {
            response.getWriter().println("Booking ID is missing.");
            return;
        }

        int bookingId = Integer.parseInt(bookingIdParam);

        Connection conn = null;
        PreparedStatement getCarName = null;
        PreparedStatement updateCar = null;
        PreparedStatement deleteBooking = null;
        Statement checkStmt = null;
        ResultSet rs = null;
        ResultSet bookingCountRs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            // 1. Get car name from booking
            String getCarQuery = "SELECT car_name FROM bookings WHERE id = ?";
            getCarName = conn.prepareStatement(getCarQuery);
            getCarName.setInt(1, bookingId);
            rs = getCarName.executeQuery();

            String carName = null;
            String carBrand = null;
            String carModel = null;

            if (rs.next()) {
                carName = rs.getString("car_name");
                if (carName.contains(" - ")) {
                    String[] parts = carName.split(" - ");
                    carBrand = parts[0].trim();
                    carModel = parts[1].trim();
                }
            }

            if (carName == null || carBrand == null || carModel == null) {
                response.getWriter().println("Car details not found.");
                return;
            }

            // 2. Update car status to 'Available'
            String updateCarQuery = "UPDATE cars SET status = 'Available' WHERE name = ? AND model = ?";
            updateCar = conn.prepareStatement(updateCarQuery);
            updateCar.setString(1, carBrand);
            updateCar.setString(2, carModel);
            updateCar.executeUpdate();

            // 3. Delete the booking record
            String deleteBookingQuery = "DELETE FROM bookings WHERE id = ?";
            deleteBooking = conn.prepareStatement(deleteBookingQuery);
            deleteBooking.setInt(1, bookingId);
            deleteBooking.executeUpdate();

            // 4. Reset AUTO_INCREMENT if bookings table is empty
            checkStmt = conn.createStatement();
            bookingCountRs = checkStmt.executeQuery("SELECT COUNT(*) AS total FROM bookings");
            if (bookingCountRs.next() && bookingCountRs.getInt("total") == 0) {
                checkStmt.executeUpdate("ALTER TABLE bookings AUTO_INCREMENT = 1");
            }

            // 5. Redirect back to bookings page
            response.sendRedirect("jsp/view_bookings.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        } finally {
            try { if (bookingCountRs != null) bookingCountRs.close(); } catch (Exception ignored) {}
            try { if (rs != null) rs.close(); } catch (Exception ignored) {}
            try { if (getCarName != null) getCarName.close(); } catch (Exception ignored) {}
            try { if (updateCar != null) updateCar.close(); } catch (Exception ignored) {}
            try { if (deleteBooking != null) deleteBooking.close(); } catch (Exception ignored) {}
            try { if (checkStmt != null) checkStmt.close(); } catch (Exception ignored) {}
            try { if (conn != null) conn.close(); } catch (Exception ignored) {}
        }
    }
}
