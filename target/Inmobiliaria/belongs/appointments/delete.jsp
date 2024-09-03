<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.svalero.dao.Database" %>
<%@ page import="com.svalero.domain.Appointment" %>
<%@ page import="com.svalero.dao.AppointmentsDAO" %>

<%@include file="../../includes/header.jsp"%>

<%
    int appointmentId = Integer.parseInt(request.getParameter("id"));
    Database.connect();
    Appointment appointment = Database.jdbi.withExtension(AppointmentsDAO.class, dao -> dao.getAppointment(appointmentId));
%>

<div class="container py-5">
    <h2 class="mb-4">Eliminar Cita</h2>

    <div class="alert alert-warning">
        <i class="bi bi-exclamation-triangle me-2"></i>¿Estás seguro de que deseas eliminar la cita programada para <strong><%= appointment.getAppointment_datetime() %></strong> con el cliente <strong><%= appointment.getName() %> <%= appointment.getLast_name() %></strong>?
    </div>

    <form action="${pageContext.request.contextPath}/belongs/appointments/delete" method="post">
        <input type="hidden" name="id" value="<%= appointment.getId() %>">
        <div class="d-flex justify-content-between">
            <a href="${pageContext.request.contextPath}/belongs/appointments/view" class="btn btn-secondary">Cancelar</a>
            <button type="submit" class="btn btn-danger">Eliminar</button>
        </div>
    </form>
</div>

<%@include file="../../includes/footer.jsp"%>
