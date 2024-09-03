<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.svalero.dao.Database" %>
<%@ page import="com.svalero.domain.Review" %>
<%@ page import="com.svalero.dao.ReviewDAO" %>

<%@include file="../../includes/header.jsp"%>

<div class="container py-5">
    <h2 class="mb-4 text-center text-primary">Eliminar Reseña</h2>

    <%
        int reviewId = Integer.parseInt(request.getParameter("id"));
        Database.connect();
        Review review = Database.jdbi.withExtension(ReviewDAO.class, dao -> dao.getReview(reviewId));
    %>

    <div class="alert alert-warning">
        <i class="bi bi-exclamation-triangle me-2"></i>¿Estás seguro de que deseas eliminar la reseña de <strong><%= review.getCustomerName() %></strong>?
    </div>

    <form action="${pageContext.request.contextPath}/belongs/reviews/delete-review" method="post">
        <input type="hidden" name="id" value="<%= review.getId() %>">
        <div class="d-flex justify-content-between">
            <a href="<%= request.getContextPath() %>/" class="btn btn-secondary">Cancelar</a>
            <button type="submit" class="btn btn-danger">Eliminar</button>
        </div>
    </form>
</div>

<%@include file="../../includes/footer.jsp"%>
