<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.svalero.dao.Database" %>
<%@ page import="com.svalero.domain.Property" %>
<%@ page import="com.svalero.dao.PropertyDAO" %>
<%@ page import="com.svalero.domain.Agents" %>
<%@ page import="com.svalero.dao.AgentsDAO" %>
<%@ page import="com.svalero.domain.Review" %>
<%@ page import="com.svalero.dao.ReviewDAO" %>

<%@ page import="java.util.List" %>
<%@ page import="com.svalero.util.CurrencyUtils" %>

<%@include file="includes/header.jsp"%>

<div class="container-fluid bg-light">
    <div class="row py-5">
        <div class="col-lg-8 mx-auto text-center">
            <h1 class="display-4 text-primary mb-4">Propiedades Disponibles</h1>
            <p class="lead text-muted mb-5">Explora nuestra selección de propiedades y encuentra tu hogar ideal.</p>
            <a href="belongs/property/search.jsp" class="btn btn-primary btn-lg">Buscar Propiedades</a>
        </div>
    </div>
</div>

<div class="container mb-5">
    <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
        <%
            Database.connect();
            List<Property> properties = Database.jdbi.withExtension(PropertyDAO.class, PropertyDAO::getProperties);
            for (Property property : properties) {
                byte[] imageBytes = property.getImage(); // Assuming the image is stored as a byte array
                String base64Image = imageBytes != null ? "data:image/jpeg;base64," + java.util.Base64.getEncoder().encodeToString(imageBytes) : "path/to/default/image.jpg";
        %>
        <div class="col">
            <div class="card h-100 border-0 shadow-sm hover-shadow transition-300">
                <img src="<%= base64Image %>" class="card-img-top" alt="Imagen de <%= property.getType() %>" style="height: 200px; object-fit: cover;">
                <div class="card-body">
                    <h5 class="card-title text-primary"><%= property.getType() %></h5>
                    <p class="card-text"><i class="bi bi-geo-alt-fill text-secondary me-2"></i><%= property.getAddress() %></p>
                    <p class="card-text"><i class="bi bi-rulers text-secondary me-2"></i><%= property.getSquare_meters() %> m² | <i class="bi bi-house-door text-secondary me-2"></i><%= property.getRooms() %> hab | <i class="bi bi-droplet text-secondary me-2"></i><%= property.getBathrooms() %> baños</p>
                    <p class="card-text text-muted small"><%= property.getDescription() %></p>
                </div>
                <div class="card-footer bg-white border-top-0 d-flex justify-content-between align-items-center">
                    <span class="h5 text-primary mb-0"><%= CurrencyUtils.format(property.getPrice()) %></span>
                    <div class="btn-group">
                        <a href="belongs/property/view.jsp?id=<%= property.getId() %>" class="btn btn-outline-primary btn-sm">Ver</a>
                        <a href="belongs/property/edit.jsp?id=<%= property.getId() %>" class="btn btn-outline-secondary btn-sm">Editar</a>
                        <a href="belongs/property/delete.jsp?id=<%= property.getId() %>" class="btn btn-outline-danger btn-sm">Eliminar</a>
                    </div>
                </div>
            </div>
        </div>
        <%
            }
        %>
    </div>
</div>

<div class="container-fluid bg-light py-5">
    <div class="row">
        <div class="col-lg-8 mx-auto text-center">
            <h2 class="display-5 text-primary mb-4">Nuestros Mejores Agentes</h2>
            <div class="row row-cols-1 row-cols-md-3 g-4">
                <%
                    Database.connect();
                    List<Agents> agents = Database.jdbi.withExtension(AgentsDAO.class, dao -> dao.getAgents());
                    int displayedAgents = 0;
                    for (Agents agent : agents) {
                        if (displayedAgents >= 3) {
                            break; // Mostrar solo 3 agentes
                        }
                        displayedAgents++;
                %>
                <div class="col">
                    <div class="card h-100 border-0 shadow-sm hover-shadow transition-300">
                        <div class="card-body text-center">
                            <h5 class="card-title text-primary"><%= agent.getFirst_name() %> <%= agent.getLast_name() %></h5>
                            <p class="card-text text-muted"><%= agent.getEmail() %></p>
                            <p class="card-text"><i class="bi bi-telephone-fill text-secondary me-2"></i><%= agent.getPhone() %></p>
                        </div>
                    </div>
                </div>
                <%
                    }
                %>
            </div>
            <div class="mt-4">
                <a href="belongs/agents/add.jsp" class="btn btn-outline-primary btn-lg">Contratar Agente</a>
                <a href="belongs/agents/view.jsp" class="btn btn-outline-secondary btn-lg">Ver Todos los Agentes</a>
            </div>
        </div>
    </div>
</div>


<div class="container-fluid bg-primary text-white py-5">
    <div class="container">
        <div class="row">
            <div class="col-md-8 mx-auto text-center">
                <h2 class="mb-4">¿Listo para vender tu propiedad?</h2>
                <p class="lead mb-4">Agregar tu propiedad a nuestra lista es fácil y rápido.</p>
                <a href="belongs/property/add.jsp" class="btn btn-light btn-lg px-4 py-2">Agregar Propiedad</a>
            </div>
        </div>
    </div>
</div>


<!-- Carrusel de Reseñas -->
<div class="container-fluid bg-light py-5">
    <div class="container">
        <h2 class="text-center mb-5 text-primary">Lo que dicen nuestros clientes</h2>

        <div id="reviewCarousel" class="carousel slide" data-bs-ride="carousel">
            <div class="carousel-inner">
                <%
                    Database.connect();
                    List<Review> reviews = Database.jdbi.withExtension(ReviewDAO.class, ReviewDAO::getAllReviews);
                    boolean isActive = true;
                    for (Review review : reviews) {
                %>
                <div class="carousel-item <%= isActive ? "active" : "" %>">
                    <div class="card border-0 shadow-sm">
                        <div class="card-body text-center p-5">
                            <i class="bi bi-quote display-1 text-primary mb-3"></i>
                            <p class="lead mb-4"><%= review.getText() %></p>
                            <div class="d-flex justify-content-center align-items-center">
                                <div>
                                    <h5 class="mb-1"><%= review.getCustomerName() %></h5>
                                    <p class="text-muted mb-0">Cliente satisfecho</p>
                                </div>
                            </div>
                            <div class="mt-4">
                                <a href="<%= request.getContextPath() %>/belongs/reviews/view.jsp?id=<%= review.getId() %>" class="btn btn-outline-secondary btn-sm me-2">Ver</a>
                                <a href="<%= request.getContextPath() %>/belongs/reviews/edit.jsp?id=<%= review.getId() %>" class="btn btn-outline-primary btn-sm me-2">Editar</a>
                                <a href="<%= request.getContextPath() %>/belongs/reviews/delete.jsp?id=<%= review.getId() %>" class="btn btn-outline-danger btn-sm">Eliminar</a>
                            </div>
                        </div>
                    </div>
                </div>
                <%
                    isActive = false;
                    }
                %>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#reviewCarousel" data-bs-slide="prev">
                <span class="carousel-control-prev-icon bg-primary rounded-circle" aria-hidden="true"></span>
                <span class="visually-hidden">Anterior</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#reviewCarousel" data-bs-slide="next">
                <span class="carousel-control-next-icon bg-primary rounded-circle" aria-hidden="true"></span>
                <span class="visually-hidden">Siguiente</span>
            </button>
        </div>

        <div class="text-center mt-5">
            <a href="<%= request.getContextPath() %>/belongs/reviews/add.jsp" class="btn btn-primary btn-lg">Agregar Reseña</a>
        </div>
    </div>
</div>


<%@include file="includes/footer.jsp"%>

