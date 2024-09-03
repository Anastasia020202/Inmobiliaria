<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ page import="com.svalero.dao.Database" %>
<%@ page import="com.svalero.dao.PropertyDAO" %>

<%@ include file="../../includes/header.jsp" %>

<div class="container my-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <h1 class="text-center mb-4">Eliminar Propiedad</h1>

            <%
                // Obtener el ID de la propiedad desde los parámetros de la URL
                int propertyId = Integer.parseInt(request.getParameter("id"));
                
                // Confirmación de la eliminación
                String confirm = request.getParameter("confirm");
                
                if ("yes".equals(confirm)) {
                    // Si la confirmación es "yes", eliminar la propiedad
                    try {
                        Database.connect();
                        Database.jdbi.useExtension(PropertyDAO.class, dao -> {
                            dao.removeProperty(propertyId);
                        });

                        out.println("<div class='alert alert-success' role='alert'>Propiedad eliminada con éxito.</div>");
                    } catch (Exception e) {
                        out.println("<div class='alert alert-danger' role='alert'>Error al eliminar la propiedad: " + e.getMessage() + "</div>");
                        e.printStackTrace();
                    }
                } else {
            %>

            <!-- Formulario de confirmación para eliminar la propiedad -->
            <div class="alert alert-warning" role="alert">
                ¿Estás seguro de que deseas eliminar esta propiedad?
            </div>

            <form action="delete.jsp" method="GET">
                <input type="hidden" name="id" value="<%= propertyId %>">
                <div class="d-flex justify-content-between">
                    <a href="../../index.jsp" class="btn btn-secondary">Cancelar</a>
                    <button type="submit" name="confirm" value="yes" class="btn btn-danger">Eliminar</button>
                </div>
            </form>

            <%
                }
            %>
        </div>
    </div>
</div>

<%@ include file="../../includes/footer.jsp" %>
