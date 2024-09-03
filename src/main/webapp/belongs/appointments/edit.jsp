<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.svalero.dao.Database" %>
<%@ page import="com.svalero.domain.Appointment" %>
<%@ page import="com.svalero.dao.AppointmentsDAO" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%@include file="../../includes/header.jsp"%>

<div class="container py-5">
    <h2 class="text-center mb-4">Editar Cita</h2>

    <%
        int appointmentId = Integer.parseInt(request.getParameter("id"));
        Database.connect();
        Appointment appointment = Database.jdbi.withExtension(AppointmentsDAO.class, dao -> dao.getAppointment(appointmentId));

        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
        String formattedDateTime = dateFormat.format(appointment.getAppointment_datetime());
    %>

    <form action="${pageContext.request.contextPath}/belongs/appointments/edit-appointment" method="post">
        <input type="hidden" name="id" value="<%= appointment.getId() %>">
        
        <div class="form-group mb-3">
            <label for="property_id">Propiedad ID:</label>
            <input type="number" class="form-control" id="property_id" name="property_id" value="<%= appointment.getProperty_id() %>" required>
        </div>
        <div class="form-group mb-3">
            <label for="agent_id">Agente ID:</label>
            <input type="number" class="form-control" id="agent_id" name="agent_id" value="<%= appointment.getAgent_id() %>" required>
        </div>
        
        <div class="form-group mb-3">
            <label for="customer_first_name">Nombre del Cliente:</label>
            <input type="text" class="form-control" id="customer_first_name" name="customer_first_name" value="<%= appointment.getName() %>" required>
        </div>

        <div class="form-group mb-3">
            <label for="customer_last_name">Apellido del Cliente:</label>
            <input type="text" class="form-control" id="customer_last_name" name="customer_last_name" value="<%= appointment.getLast_name() %>" required>
        </div>
        
        <div class="form-group mb-3">
            <label for="customer_email">Correo Electrónico del Cliente:</label>
            <input type="email" class="form-control" id="customer_email" name="customer_email" value="<%= appointment.getEmail() %>" required>
        </div>
        
        <div class="form-group mb-3">
            <label for="customer_phone">Teléfono del Cliente:</label>
            <input type="text" class="form-control" id="customer_phone" name="customer_phone" value="<%= appointment.getPhone() %>" required>
        </div>

        <div class="form-group mb-3">
            <label for="appointment_datetime">Fecha y Hora:</label>
            <input type="datetime-local" class="form-control" id="appointment_datetime" name="appointment_datetime" value="<%= formattedDateTime %>" required>
        </div>
        
        <div class="form-group mb-3">
            <label for="status">Estado:</label>
            <select class="form-select" id="status" name="status" required>
                <option value="Pendiente" <%= "Pendiente".equals(appointment.getStatus()) ? "selected" : "" %>>Pendiente</option>
                <option value="Confirmada" <%= "Confirmada".equals(appointment.getStatus()) ? "selected" : "" %>>Confirmada</option>
                <option value="Cancelada" <%= "Cancelada".equals(appointment.getStatus()) ? "selected" : "" %>>Cancelada</option>
            </select>
        </div>
        
        <div class="form-group mb-3">
            <label for="message">Mensaje:</label>
            <textarea class="form-control" id="message" name="message" rows="3"><%= appointment.getMessage() %></textarea>
        </div>
        
        <button type="submit" class="btn btn-primary w-100">Guardar Cambios</button>
    </form>
</div>

<%@include file="../../includes/footer.jsp"%>
