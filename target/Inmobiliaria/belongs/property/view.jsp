<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.svalero.dao.Database" %>
<%@ page import="com.svalero.domain.Property" %>
<%@ page import="com.svalero.dao.PropertyDAO" %>
<%@ page import="com.svalero.util.CurrencyUtils" %>
<%@ page import="java.util.Base64" %>

<%@include file="../../includes/header.jsp"%>

<%
    int propertyId = Integer.parseInt(request.getParameter("id"));
    Database.connect();
    Property property = Database.jdbi.withExtension(PropertyDAO.class, dao -> dao.getProperty(propertyId));

    // Convertir la imagen a Base64 si existe
    String base64Image = property.getImage() != null ? Base64.getEncoder().encodeToString(property.getImage()) : "";
%>

<div class="container-fluid bg-light py-5">
    <div class="container">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="../../index.jsp" class="text-decoration-none">Inicio</a></li>
                <li class="breadcrumb-item active" aria-current="page"><%= property.getType() %></li>
            </ol>
        </nav>
        
        <!-- Alertas de éxito o error en la cita -->
        <%
            String appointmentSuccess = request.getParameter("appointmentSuccess");
            if ("true".equals(appointmentSuccess)) {
        %>
            <div class="alert alert-success text-center" role="alert">
                ¡Cita agendada con éxito!
            </div>
        <%
            } else if ("false".equals(appointmentSuccess)) {
        %>
            <div class="alert alert-danger text-center" role="alert">
                Error al agendar la cita. Por favor, inténtalo de nuevo.
            </div>
        <%
            }
        %>

        <div class="row g-5">
            <div class="col-lg-8">
                <div class="card border-0 shadow-sm">
                    <%
                        if (!base64Image.isEmpty()) {
                    %>
                        <img src="data:image/jpeg;base64,<%= base64Image %>" class="card-img-top" alt="Imagen de <%= property.getType() %>" style="height: 400px; object-fit: cover;">
                    <%
                        } else {
                    %>
                        <img src="../../path/to/default-image.jpg" class="card-img-top" alt="Imagen no disponible" style="height: 400px; object-fit: cover;">
                    <%
                        }
                    %>
                    <div class="card-body">
                        <h1 class="card-title mb-3"><%= property.getType() %></h1>
                        <p class="text-muted mb-4"><i class="bi bi-geo-alt-fill me-2"></i><%= property.getAddress() %></p>
                        <h2 class="text-primary mb-4"><%= CurrencyUtils.format(property.getPrice()) %></h2>
                        
                        <div class="row mb-4">
                            <div class="col-md-4">
                                <div class="d-flex align-items-center mb-3">
                                    <i class="bi bi-rulers fs-4 text-primary me-3"></i>
                                    <div>
                                        <small class="text-muted">Superficie</small>
                                        <p class="mb-0 fw-bold"><%= property.getSquare_meters() %> m²</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="d-flex align-items-center mb-3">
                                    <i class="bi bi-house-door fs-4 text-primary me-3"></i>
                                    <div>
                                        <small class="text-muted">Habitaciones</small>
                                        <p class="mb-0 fw-bold"><%= property.getRooms() %></p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="d-flex align-items-center mb-3">
                                    <i class="bi bi-droplet fs-4 text-primary me-3"></i>
                                    <div>
                                        <small class="text-muted">Baños</small>
                                        <p class="mb-0 fw-bold"><%= property.getBathrooms() %></p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <h3 class="mb-3">Descripción</h3>
                        <p class="mb-4"><%= property.getDescription() %></p>
                    </div>
                </div>
            </div>
            
            <div class="col-lg-4">
                <div class="card border-0 shadow-sm sticky-top" style="top: 2rem;">
                    <div class="card-body">
                        <h3 class="card-title mb-4">¿Interesado en esta propiedad?</h3>
                        <form action="${pageContext.request.contextPath}/belongs/appointments/schedule-appointment" method="post">
                            <input type="hidden" name="property_id" value="<%= property.getId() %>">
                            <input type="hidden" name="agent_id" value="<%= property.getAgent_id() %>">
                            <div class="mb-3">
                                <label for="first_name" class="form-label">Nombre</label>
                                <input type="text" class="form-control" id="first_name" name="first_name" required>
                            </div>
                            <div class="mb-3">
                                <label for="last_name" class="form-label">Apellido</label>
                                <input type="text" class="form-control" id="last_name" name="last_name" required>
                            </div>
                            <div class="mb-3">
                                <label for="email" class="form-label">Email</label>
                                <input type="email" class="form-control" id="email" name="email" required>
                            </div>
                            <div class="mb-3">
                                <label for="phone" class="form-label">Teléfono</label>
                                <input type="tel" class="form-control" id="phone" name="phone">
                            </div>
                            <div class="mb-3">
                                <label for="message" class="form-label">Mensaje</label>
                                <textarea class="form-control" id="message" name="message" rows="3" required></textarea>
                            </div>
                            <div class="mb-3">
                                <label for="appointment_datetime" class="form-label">Fecha y hora de la cita</label>
                                <input type="datetime-local" class="form-control" id="appointment_datetime" name="appointment_datetime" required>
                            </div>
                            <div class="d-grid gap-2">
                                <button type="submit" class="btn btn-primary btn-lg">Agendar visita</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            
        </div>
    </div>
</div>

<%@include file="../../includes/footer.jsp"%>
