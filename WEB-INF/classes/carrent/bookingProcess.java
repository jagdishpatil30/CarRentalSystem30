package carrent;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Servlet implementation class bookingProcess
 */
@WebServlet("/bookingProcess")
public class bookingProcess extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        // Store all form data in session
        session.setAttribute("user_name", request.getParameter("user_name"));
        session.setAttribute("car_name", request.getParameter("car_name"));
        session.setAttribute("days", request.getParameter("days"));
        session.setAttribute("total_price", request.getParameter("total_price"));
        session.setAttribute("booking_date", java.time.LocalDate.now().toString());
        
        // Forward to payment.jsp
        request.getRequestDispatcher("jsp/payment.jsp").forward(request, response);
    }
}