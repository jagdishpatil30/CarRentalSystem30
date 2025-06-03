package carrent;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Servlet implementation class UserBookCarFinal
 */
@WebServlet("/UserBookCarFinal")
public class UserBookCarFinal extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        // Get data from session
        String user = (String) session.getAttribute("user");
        String car = (String) session.getAttribute("car");
        String days = (String) session.getAttribute("days");
        String amount = (String) session.getAttribute("amount");

        // Do any logic like saving to DB if needed

        // Redirect to success page
        response.sendRedirect("jsp/payment_success.jsp");
    }
}
