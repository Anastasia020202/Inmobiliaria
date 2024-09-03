<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.svalero.dao.Database" %>
<%@ page import="com.svalero.dao.AgentsDAO" %>
<%@ page import="com.svalero.domain.Agents" %>

<%@include file="../../includes/header.jsp"%>

<div class="container py-5">
    <h2 class="text-center mb-4">Editar Agente</h2>

    <%
        int agentId = Integer.parseInt(request.getParameter("id"));
        Database.connect();
        Agents agent = Database.jdbi.withExtension(AgentsDAO.class, dao -> dao.getAgentId(agentId));
    %>

    <form action="${pageContext.request.contextPath}/belongs/agents/edit-agent" method="post">
        <input type="hidden" name="id" value="<%= agent.getId() %>">
        <div class="form-group mb-3">
            <label for="first_name">Nombre:</label>
            <input type="text" class="form-control" id="first_name" name="first_name" value="<%= agent.getFirstName() %>" required>
        </div>
        <div class="form-group mb-3">
            <label for="last_name">Apellido:</label>
            <input type="text" class="form-control" id="last_name" name="last_name" value="<%= agent.getLastName() %>" required>
        </div>
        <div class="form-group mb-3">
            <label for="email">Correo Electrónico:</label>
            <input type="email" class="form-control" id="email" name="email" value="<%= agent.getEmail() %>" required>
        </div>
        <div class="form-group mb-3">
            <label for="phone">Teléfono:</label>
            <input type="text" class="form-control" id="phone" name="phone" value="<%= agent.getPhone() %>" required>
        </div>
        <div class="form-group mb-3">
            <label for="password">Contraseña:</label>
            <input type="password" class="form-control" id="password" name="password" value="<%= agent.getPassword() %>" required>
        </div>
        <button type="submit" class="btn btn-primary w-100">Guardar Cambios</button>
    </form>
</div>

<%@include file="../../includes/footer.jsp"%>
