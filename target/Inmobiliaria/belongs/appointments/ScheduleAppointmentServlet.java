package com.svalero.servlet.appointments;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.svalero.dao.Database;
import com.svalero.dao.AppointmentsDAO;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@WebServlet("/belongs/appointments/schedule-appointment")
public class ScheduleAppointmentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String message = request.getParameter("message");
            int propertyId = Integer.parseInt(request.getParameter("property_id"));
            int agentId = Integer.parseInt(request.getParameter("agent_id"));
            LocalDateTime appointmentDateTime = LocalDateTime.parse(request.getParameter("appointment_datetime"), DateTimeFormatter.ISO_DATE_TIME);

            // Lógica para crear un nuevo cliente o encontrar uno existente por email (opcional)

            Database.connect();
            Database.jdbi.useExtension(AppointmentsDAO.class, dao -> {
                dao.addAppointment(propertyId, agentId, name, email, phone, appointmentDateTime, "Pending", message);
            });

            response.sendRedirect(request.getContextPath() + "/belongs/property/view.jsp?id=" + propertyId + "&appointmentSuccess=true");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/belongs/property/view.jsp?id=" + request.getParameter("property_id") + "&appointmentSuccess=false");
        }
    }
}
