<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.svalero.domain.Property" %>
<%@ page import="com.svalero.dao.PropertyDAO" %>
<%@ page import="com.svalero.dao.Database" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Base64" %>

<%@include file="../../includes/header.jsp"%>

<main class="container py-5">
    <h2 class="mb-4">Buscar Propiedades</h2>
    
    <!-- Enviar el formulario sin AJAX -->
    <form action="${pageContext.request.contextPath}/belongs/property/search-properties" method="GET" class="mb-5">
        <div class="card p-4 shadow-sm">
            <h4 class="mb-3">Filtros de búsqueda</h4>
            <div class="row g-3">
                <div class="col-md-6">
                    <label for="type" class="form-label">Tipo de Propiedad</label>
                    <select class="form-select" id="type" name="type">
                        <option value="Casa">Casa</option>
                        <option value="Apartamento">Apartamento</option>
                        <option value="Local">Local</option>
                    </select>
                </div>
                <div class="col-md-6">
                    <label for="rooms" class="form-label">Número de Habitaciones</label>
                    <input type="number" class="form-control" id="rooms" name="rooms" placeholder="Número de habitaciones">
                </div>
            </div>
            <div class="mt-4 d-grid">
                <button type="submit" class="btn btn-primary btn-lg">Buscar</button>
            </div>
        </div>
    </form>

    <!-- Resultados -->
    <div class="row row-cols-1 row-cols-md-3 g-4">
        <%
            // Mostrar los resultados si hay alguna búsqueda realizada
            List<Property> properties = (List<Property>) request.getAttribute("properties");
            if (properties != null) {
                if (properties.isEmpty()) {
                    out.println("<div class='alert alert-warning'>No se encontraron propiedades con los criterios especificados.</div>");
                } else {
                    for (Property property : properties) {
                        String base64Image = property.getImage() != null ? Base64.getEncoder().encodeToString(property.getImage()) : "";
        %>
                        <div class="col">
                            <div class="card h-100">
                                <img src="data:image/jpeg;base64,<%= base64Image %>" class="card-img-top" alt="Imagen de <%= property.getType() %>" style="height: 200px; object-fit: cover;">
                                <div class="card-body">
                                    <h5 class="card-title"><%= property.getAddress() %></h5>
                                    <p class="card-text"><%= property.getDescription() %></p>
                                    <p class="card-text"><strong>Precio:</strong> <%= property.getPrice() %></p>
                                    <p class="card-text"><strong>Habitaciones:</strong> <%= property.getRooms() %></p>
                                    <p class="card-text"><strong>Metros Cuadrados:</strong> <%= property.getSquare_meters() %> m²</p>
                                    <div class="mt-3">
                                        <a href="view.jsp?id=<%= property.getId() %>" class="btn btn-outline-primary w-100">Ver Propiedad</a>
                                    </div>
                                </div>
                            </div>
                        </div>
        <%
                    }
                }
            }
        %>
    </div>
</main>

<%@include file="../../includes/footer.jsp"%>
