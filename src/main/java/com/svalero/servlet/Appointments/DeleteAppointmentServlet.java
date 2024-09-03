package com.svalero.servlet.Appointments;

import com.svalero.dao.AppointmentsDAO;
import com.svalero.dao.Database;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/belongs/appointments/delete")
public class DeleteAppointmentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int appointmentId = Integer.parseInt(request.getParameter("id"));

            Database.connect();
            Database.jdbi.useExtension(AppointmentsDAO.class, dao -> {
                dao.removeAppointment(appointmentId);
            });

            response.sendRedirect(request.getContextPath() + "/belongs/appointments/view");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al eliminar la cita.");
        }
    }
}
