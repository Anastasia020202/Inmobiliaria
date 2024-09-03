<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.svalero.dao.Database" %>
<%@ page import="com.svalero.domain.Appointment" %>
<%@ page import="com.svalero.dao.AppointmentsDAO" %>
<%@ page import="java.util.List" %>

<%@include file="../../includes/header.jsp"%>

<div class="container py-5">
    <h2 class="mb-4">Citas Programadas</h2>
    
    <div class="card shadow-sm mb-4">
        <div class="card-body">
            <form>
                <div class="input-group">
                    <span class="input-group-text bg-light">
                        <i class="bi bi-search"></i>
                    </span>
                    <input type="text" id="search" class="form-control" placeholder="Buscar por propiedad, agente, cliente, fecha o estado">
                </div>
            </form>
        </div>
    </div>

    <%
        // Conectar a la base de datos y recuperar las citas
        Database.connect();
        List<Appointment> appointments = Database.jdbi.withExtension(AppointmentsDAO.class, AppointmentsDAO::getAppointments);
        
        // Verificar si la lista de citas está vacía o no
        if (appointments == null || appointments.isEmpty()) {
    %>
        <div class="alert alert-info">
            <i class="bi bi-info-circle me-2"></i>No hay citas programadas.
        </div>
    <% } else { %>
        <div class="table-responsive">
            <table class="table table-hover">
                <thead class="table-light">
                    <tr>
                        <th>ID</th>
                        <th>Propiedad</th>
                        <th>Agente</th>
                        <th>Cliente</th>
                        <th>Teléfono</th>
                        <th>Fecha y Hora</th>
                        <th>Mensaje</th>
                        <th>Estado</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody id="appointment-table">
                    <% for (Appointment appointment : appointments) { %>
                    <tr>
                        <td><%= appointment.getId() %></td>
                        <td><a href="<%= request.getContextPath() %>/belongs/property/view.jsp?id=<%= appointment.getProperty_id() %>" class="text-decoration-none">Ver Propiedad</a></td>
                        <td><%= appointment.getAgent_id() %></td>
                        <td><%= appointment.getName() %> <%= appointment.getLast_name() %></td>
                        <td><%= appointment.getPhone() %></td>
                        <td><%= appointment.getAppointment_datetime() %></td>
                        <td><%= appointment.getMessage() %></td>
                        <td>
                            <% 
                            String statusClass = "bg-secondary";
                            String status = appointment.getStatus().toLowerCase();
                            if (status.equals("pendiente")) {
                                statusClass = "bg-warning text-dark";
                            } else if (status.equals("confirmada")) {
                                statusClass = "bg-success";
                            } else if (status.equals("cancelada")) {
                                statusClass = "bg-danger";
                            }
                            %>
                            <span class="badge <%= statusClass %>"><%= appointment.getStatus() %></span>
                        </td>
                        <td>
                            <div class="btn-group" role="group">
                                <a href="<%= request.getContextPath() %>/belongs/appointments/edit.jsp?id=<%= appointment.getId() %>" class="btn btn-outline-warning btn-sm">
                                    <i class="bi bi-pencil"></i>
                                </a>
                                <a href="<%= request.getContextPath() %>/belongs/appointments/delete?id=<%= appointment.getId() %>" class="btn btn-outline-danger btn-sm" onclick="return confirm('¿Estás seguro de que quieres eliminar esta cita?')">
                                    <i class="bi bi-trash"></i>
                                </a>
                            </div>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    <% } %>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
    $(document).ready(function(){
        $("#search").on("keyup", function() {
            var value = $(this).val().toLowerCase();
            $("#appointment-table tr").filter(function() {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
            });
        });
    });
</script>

<%@include file="../../includes/footer.jsp"%>
