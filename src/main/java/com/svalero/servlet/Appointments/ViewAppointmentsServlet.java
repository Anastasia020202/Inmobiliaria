package com.svalero.servlet.Appointments;

import com.svalero.dao.AppointmentsDAO;
import com.svalero.dao.Database;
import com.svalero.domain.Appointment;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/belongs/appointments/view")
public class ViewAppointmentsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Database.connect();
            List<Appointment> appointments = Database.jdbi.withExtension(AppointmentsDAO.class, AppointmentsDAO::getAppointments);

            request.setAttribute("appointments", appointments);
            request.getRequestDispatcher("/belongs/appointments/view.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al cargar las citas.");
        }
    }
}
