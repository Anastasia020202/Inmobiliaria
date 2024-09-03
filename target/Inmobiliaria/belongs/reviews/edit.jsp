<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.svalero.dao.Database" %>
<%@ page import="com.svalero.domain.Review" %>
<%@ page import="com.svalero.dao.ReviewDAO" %>

<%@include file="../../includes/header.jsp"%>

<div class="container py-5">
    <h2 class="mb-4 text-center text-primary">Editar Reseña</h2>

    <%
        int reviewId = Integer.parseInt(request.getParameter("id"));
        Database.connect();
        Review review = Database.jdbi.withExtension(ReviewDAO.class, dao -> dao.getReview(reviewId));
    %>

    <form action="${pageContext.request.contextPath}/belongs/reviews/edit-review" method="post">
        <input type="hidden" name="id" value="<%= review.getId() %>">
        <div class="form-group mb-3">
            <label for="customer_name">Nombre del Cliente:</label>
            <input type="text" class="form-control" id="customer_name" name="customer_name" value="<%= review.getCustomerName() %>" required>
        </div>
        <div class="form-group mb-3">
            <label for="text">Texto de la Reseña:</label>
            <textarea class="form-control" id="text" name="text" rows="5" required><%= review.getText() %></textarea>
        </div>
        <button type="submit" class="btn btn-primary w-100">Guardar Cambios</button>
    </form>
</div>

<%@include file="../../includes/footer.jsp"%>
