<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../../includes/header.jsp"%>

<main>
  <div class="container py-5">
    <h2 class="text-center mb-4">Agregar Nuevo Agente</h2>
    <form id="add-agent-form" novalidate>
      <div class="form-group mb-3">
        <label for="first_name" class="form-label">Nombre:</label>
        <input type="text" class="form-control" id="first_name" name="first_name" placeholder="Ingrese el nombre" required aria-required="true">
        <div class="invalid-feedback">Por favor, ingrese el nombre.</div>
      </div>
      <div class="form-group mb-3">
        <label for="last_name" class="form-label">Apellido:</label>
        <input type="text" class="form-control" id="last_name" name="last_name" placeholder="Ingrese el apellido" required aria-required="true">
        <div class="invalid-feedback">Por favor, ingrese el apellido.</div>
      </div>
      <div class="form-group mb-3">
        <label for="email" class="form-label">Correo Electrónico:</label>
        <input type="email" class="form-control" id="email" name="email" placeholder="Ingrese el correo electrónico" required aria-required="true">
        <div class="invalid-feedback">Por favor, ingrese un correo electrónico válido.</div>
      </div>
      <div class="form-group mb-3">
        <label for="phone" class="form-label">Teléfono:</label>
        <input type="text" class="form-control" id="phone" name="phone" placeholder="Ingrese el teléfono" required aria-required="true">
        <div class="invalid-feedback">Por favor, ingrese el teléfono.</div>
      </div>
      <div class="form-group mb-3">
        <label for="password" class="form-label">Contraseña:</label>
        <input type="password" class="form-control" id="password" name="password" placeholder="Ingrese la contraseña" required aria-required="true">
        <div class="invalid-feedback">Por favor, ingrese la contraseña.</div>
      </div>
      <button type="submit" class="btn btn-primary w-100" id="submit-btn">Guardar</button>
      <div id="loading-spinner" class="spinner-border text-primary mt-3" role="status" style="display:none;">
        <span class="visually-hidden">Cargando...</span>
      </div>
    </form>
    <div id="message" class="mt-3" style="display: none;"></div>
  </div>

  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

  <script type="text/javascript">
    $(document).ready(function() {
      // Validación en tiempo real
      $('#add-agent-form').on('submit', function(event) {
        event.preventDefault();
        var form = this;

        if (form.checkValidity() === false) {
          event.stopPropagation();
          $(form).addClass('was-validated');
        } else {
          $("#submit-btn").prop("disabled", true);
          $("#loading-spinner").show();

          $.ajax({
            url: "${pageContext.request.contextPath}/belongs/agents/add-agent",
            type: "POST",
            data: $(this).serialize(),
            success: function(data) {
              $("#loading-spinner").hide();
              $("#message").html('<div class="alert alert-success">Agente agregado exitosamente</div>').show();
              setTimeout(function() {
                window.location.href = "${pageContext.request.contextPath}/index.jsp";
              }, 2000);
            },
            error: function(xhr, status, error) {
              $("#loading-spinner").hide();
              $("#submit-btn").prop("disabled", false);
              $("#message").html('<div class="alert alert-danger">Error al agregar el agente: ' + error + '</div>').show();
            }
          });
        }
      });
    });
  </script>
</main>

<%@include file="../../includes/footer.jsp"%>
