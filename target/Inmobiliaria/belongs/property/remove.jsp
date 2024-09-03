<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.svalero.domain.Property" %>
<%@ page import="com.svalero.dao.PropertyDAO" %>
<%@ page import="com.svalero.dao.Database" %>

<%
    int propertyId = 0;
    Property property = null;
    try {
        propertyId = Integer.parseInt(request.getParameter("id"));
        Database.connect();
        property = Database.jdbi.withExtension(PropertyDAO.class, dao -> dao.getById(propertyId));
    } catch (Exception e) {
        // Manejar el error, tal vez redirigir a una página de error
        response.sendRedirect("error.jsp");
        return;
    }
%>

<%@include file="includes/header.jsp"%>

<main class="container py-5">
    <h2>Eliminar Propiedad</h2>
    <div class="alert alert-warning" role="alert">
        ¿Está seguro de que desea eliminar esta propiedad? Esta acción no se puede deshacer.
    </div>
    <div class="card mb-3">
        <div class="card-body">
            <h5 class="card-title"><%= property.getType() %> - <%= property.getAddress() %></h5>
            <p class="card-text">Precio: <%= property.getPrice() %></p>
            <p class="card-text">Metros Cuadrados: <%= property.getSquareMeters() %></p>
            <p class="card-text">Habitaciones: <%= property.getRooms() %>, Baños: <%= property.getBathrooms() %></p>
            <p class="card-text"><small class="text-muted">ID de la propiedad: <%= property.getId() %></small></p>
        </div>
    </div>
    <button id="delete-btn" class="btn btn-danger">Confirmar Eliminación</button>
    <a href="/Inmobiliaria" class="btn btn-secondary">Cancelar</a>
    <div id="message" class="mt-3" style="display: none;"></div>
</main>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

<script type="text/javascript">
$(document).ready(function() {
    $("#delete-btn").on("click", function() {
        $.ajax({
            url: "${pageContext.request.contextPath}/delete-property",
            type: "POST",
            data: { id: <%= property.getId() %> },
            success: function(data) {
                $("#message").html('<div class="alert alert-success">Propiedad eliminada exitosamente</div>').show();
                setTimeout(function() {
                    window.location.href = "${pageContext.request.contextPath}/Inmobiliaria";
                }, 2000);
            },
            error: function(xhr, status, error) {
                $("#message").html('<div class="alert alert-danger">Error al eliminar la propiedad: ' + error + '</div>').show();
            }
        });
    });
});
</script>

<%@include file="includes/footer.jsp"%>