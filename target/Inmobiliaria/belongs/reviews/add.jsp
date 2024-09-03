<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../../includes/header.jsp"%>

<div class="container py-5">
    <h2 class="text-center mb-4">Agregar Reseña</h2>

    <form action="${pageContext.request.contextPath}/belongs/reviews/add-review" method="post">
        <div class="form-group mb-3">
            <label for="customer_name">Nombre del Cliente:</label>
            <input type="text" class="form-control" id="customer_name" name="customer_name" required>
        </div>
        
        <div class="form-group mb-3">
            <label for="text">Texto de la Reseña:</label>
            <textarea class="form-control" id="text" name="text" rows="3" required></textarea>
        </div>
        
        <button type="submit" class="btn btn-primary w-100">Guardar Reseña</button>
    </form>
</div>

<%@include file="../../includes/footer.jsp"%>
