<%@ page import="java.sql.*" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/carrent", "root", "jaggu");
        PreparedStatement ps = con.prepareStatement("DELETE FROM cars WHERE id=?");
        ps.setInt(1, id);
        ps.executeUpdate();
        con.close();
    } catch (Exception e) {
        out.println("Error deleting car: " + e.getMessage());
    }

    response.sendRedirect("manage_cars.jsp");
%>
