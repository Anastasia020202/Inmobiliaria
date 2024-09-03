<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.svalero.dao.Database" %>
<%@ page import="com.svalero.domain.Property" %>
<%@ page import="com.svalero.dao.PropertyDAO" %>

<%@include file="../../includes/header.jsp"%>

<%
    // Obtener el parámetro `editSuccess` y mostrar mensajes de éxito o error.
    String editSuccess = request.getParameter("editSuccess");
    if ("true".equals(editSuccess)) {
%>
        <div class="alert alert-success text-center" role="alert">
            ¡Propiedad editada con éxito!
        </div>
<%
    } else if ("false".equals(editSuccess)) {
%>
        <div class="alert alert-danger text-center" role="alert">
            Error al editar la propiedad. Por favor, inténtelo de nuevo.
        </div>
<%
    }

    // Cargar la propiedad
    int propertyId = Integer.parseInt(request.getParameter("id"));
    Database.connect();
    Property property = Database.jdbi.withExtension(PropertyDAO.class, dao -> dao.getProperty(propertyId));
%>

<div class="container py-5">
    <h2 class="mb-4">Editar Propiedad</h2>
    <form action="${pageContext.request.contextPath}/belongs/property/edit-property" method="POST">
        <input type="hidden" name="id" value="<%= property.getId() %>">
        <div class="form-group mb-3">
            <label for="address" class="form-label">Dirección:</label>
            <input type="text" class="form-control" id="address" name="address" value="<%= property.getAddress() %>" required>
        </div>
        <div class="form-group mb-3">
            <label for="type" class="form-label">Tipo:</label>
            <select class="form-control" id="type" name="type" required>
                <option value="Casa" <%= "Casa".equals(property.getType()) ? "selected" : "" %>>Casa</option>
                <option value="Apartamento" <%= "Apartamento".equals(property.getType()) ? "selected" : "" %>>Apartamento</option>
                <option value="Local" <%= "Local".equals(property.getType()) ? "selected" : "" %>>Local</option>
            </select>
        </div>
        <div class="form-group mb-3">
            <label for="price" class="form-label">Precio:</label>
            <input type="number" class="form-control" id="price" name="price" value="<%= property.getPrice() %>" step="0.01" required>
        </div>
        <div class="form-group mb-3">
            <label for="squareMeters" class="form-label">Metros Cuadrados:</label>
            <input type="number" class="form-control" id="squareMeters" name="squareMeters" value="<%= property.getSquare_meters() %>" required>
        </div>
        <div class="form-group mb-3">
            <label for="rooms" class="form-label">Habitaciones:</label>
            <input type="number" class="form-control" id="rooms" name="rooms" value="<%= property.getRooms() %>" required>
        </div>
        <div class="form-group mb-3">
            <label for="bathrooms" class="form-label">Baños:</label>
            <input type="number" class="form-control" id="bathrooms" name="bathrooms" value="<%= property.getBathrooms() %>" required>
        </div>
        <div class="form-group mb-3">
            <label for="description" class="form-label">Descripción:</label>
            <textarea class="form-control" id="description" name="description" rows="3"><%= property.getDescription() %></textarea>
        </div>
        <button type="submit" class="btn btn-primary w-100">Guardar Cambios</button>
    </form>
</div>

<%@include file="../../includes/footer.jsp"%>
