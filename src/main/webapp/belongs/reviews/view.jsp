<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.svalero.dao.Database" %>
<%@ page import="com.svalero.domain.Review" %>
<%@ page import="com.svalero.dao.ReviewDAO" %>

<%@include file="../../includes/header.jsp"%>

<div class="container py-5">
    <h2 class="mb-4 text-center text-primary">Detalles de la Reseña</h2>

    <%
        int reviewId = Integer.parseInt(request.getParameter("id"));
        Database.connect();
        Review review = Database.jdbi.withExtension(ReviewDAO.class, dao -> dao.getReview(reviewId));
    %>

    <div class="card shadow-sm">
        <div class="card-body">
            <h5 class="card-title text-primary"><%= review.getCustomerName() %></h5>
            <p class="card-text"><%= review.getText() %></p>
        </div>
    </div>

    <div class="mt-4">
        <a href="<%= request.getContextPath() %>/belongs/reviews/edit.jsp?id=<%= review.getId() %>" class="btn btn-warning">Editar</a>
        <a href="<%= request.getContextPath() %>/belongs/reviews/delete.jsp?id=<%= review.getId() %>" class="btn btn-danger">Eliminar</a>
        <a href="<%= request.getContextPath() %>/" class="btn btn-secondary">Volver</a>
    </div>
</div>

<%@include file="../../includes/footer.jsp"%>
