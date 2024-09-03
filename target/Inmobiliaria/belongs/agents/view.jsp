<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.svalero.dao.Database" %>
<%@ page import="com.svalero.dao.AgentsDAO" %>
<%@ page import="com.svalero.domain.Agents" %>
<%@ page import="java.util.List" %>

<%@include file="../../includes/header.jsp"%>

<div class="container py-5">
    <h2 class="text-center mb-4">Lista de Agentes</h2>
    <form class="mb-4">
        <input type="text" id="search" class="form-control" placeholder="Buscar por nombre, correo electrónico o teléfono">
    </form>
    <div class="table-responsive">
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>Nombre</th>
                    <th>Correo Electrónico</th>
                    <th>Teléfono</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody id="agent-table">
                <%
                    Database.connect();
                    List<Agents> agents = Database.jdbi.withExtension(AgentsDAO.class, AgentsDAO::getAgents);
                    for (Agents agent : agents) {
                %>
                <tr>
                    <td><%= agent.getFirstName() %> <%= agent.getLastName() %></td>
                    <td><%= agent.getEmail() %></td>
                    <td><%= agent.getPhone() %></td>
                    <td>
                        <a href="edit.jsp?id=<%= agent.getId() %>" class="btn btn-outline-secondary btn-sm">Editar</a>
                        <form action="${pageContext.request.contextPath}/belongs/agents/delete-agent" method="post" style="display:inline;" onsubmit="return confirm('¿Estás seguro de que quieres eliminar a este agente?');">
                            <input type="hidden" name="id" value="<%= agent.getId() %>">
                            <button type="submit" class="btn btn-outline-danger btn-sm">Despedir</button>
                        </form>
                    </td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
    $(document).ready(function(){
        $("#search").on("keyup", function() {
            var value = $(this).val().toLowerCase();
            $("#agent-table tr").filter(function() {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
            });
        });
    });
</script>

<%@include file="../../includes/footer.jsp"%>
