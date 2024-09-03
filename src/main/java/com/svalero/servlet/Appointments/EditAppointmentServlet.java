package com.svalero.servlet.Appointments;

import com.svalero.dao.AppointmentsDAO;
import com.svalero.dao.Database;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDateTime;

@WebServlet("/belongs/appointments/edit-appointment")
public class EditAppointmentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            int propertyId = Integer.parseInt(request.getParameter("property_id"));
            int agentId = Integer.parseInt(request.getParameter("agent_id"));
            String customerFirstName = request.getParameter("customer_first_name");
            String customerLastName = request.getParameter("customer_last_name");
            String customerEmail = request.getParameter("customer_email");
            String customerPhone = request.getParameter("customer_phone");
            String status = request.getParameter("status");
            String message = request.getParameter("message");
            LocalDateTime appointmentDatetime = LocalDateTime.parse(request.getParameter("appointment_datetime"));

            int customerId = 0; // No se puede editar el cliente de una cita

            // Conectar a la base de datos y actualizar la cita
            Database.connect();
            Database.jdbi.useExtension(AppointmentsDAO.class, dao -> {
                dao.editAppointmentWithCustomerInfo(propertyId, customerId, agentId, appointmentDatetime, status, message, customerFirstName, customerLastName, customerEmail, customerPhone, id);
            });

            response.sendRedirect(request.getContextPath() + "/belongs/appointments/view.jsp?editSuccess=true");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/belongs/appointments/view.jsp?editSuccess=false");
        }
    }
}
