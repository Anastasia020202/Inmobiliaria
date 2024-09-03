package com.svalero.servlet.Appointments;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.svalero.dao.CustomersDAO;
import com.svalero.dao.Database;
import com.svalero.dao.AppointmentsDAO;
import com.svalero.domain.Customers;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@WebServlet("/belongs/appointments/schedule-appointment")
public class ScheduleAppointmentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String firstName = request.getParameter("first_name");
            String lastName = request.getParameter("last_name");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String message = request.getParameter("message");
            int propertyId = Integer.parseInt(request.getParameter("property_id"));
            int agentId = Integer.parseInt(request.getParameter("agent_id"));
            LocalDateTime appointmentDateTime = LocalDateTime.parse(request.getParameter("appointment_datetime"), DateTimeFormatter.ISO_DATE_TIME);

            Database.connect();
            Customers customer = Database.jdbi.withExtension(CustomersDAO.class, dao -> dao.getCustomerByEmail(email));

            if (customer == null) {
                // Si el cliente no existe, agregarlo
                Database.jdbi.useExtension(CustomersDAO.class, dao -> {
                    dao.addCustomer(firstName, lastName, email, phone);
                });
                customer = Database.jdbi.withExtension(CustomersDAO.class, dao -> dao.getCustomerByEmail(email));
            }

            // Ahora agendar la cita con el customer_id y copiar la información del cliente
            int customerId = customer.getId();
            final Customers finalCustomer = customer;
            Database.jdbi.useExtension(AppointmentsDAO.class, dao -> {
                dao.addAppointmentWithCustomerInfo(
                    propertyId,
                    customerId,
                    agentId,
                    appointmentDateTime,
                    "Pending",
                    message,
                    finalCustomer.getFirstName(),
                    finalCustomer.getLastName(),
                    finalCustomer.getEmail(),
                    finalCustomer.getPhone()
                );
            });

            response.sendRedirect(request.getContextPath() + "/belongs/property/view.jsp?id=" + propertyId + "&appointmentSuccess=true");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/belongs/property/view.jsp?id=" + request.getParameter("property_id") + "&appointmentSuccess=false");
        }
    }
}
