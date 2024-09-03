<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.svalero.domain.Property" %>
<%@ page import="com.svalero.dao.PropertyDAO" %>
<%@ page import="com.svalero.dao.Database" %>
<%@ page import="com.svalero.util.CurrencyUtils" %>

<%@include file="../../includes/header.jsp"%>
<main>
  <div class="container py-5">
    <h2 class="text-center mb-4">Agregar Propiedad</h2>
    <form id="add-property-form" enctype="multipart/form-data" novalidate>
      <div class="form-group mb-3">
        <label for="address" class="form-label">Dirección:</label>
        <input type="text" class="form-control" id="address" name="address" placeholder="Ingrese la dirección" required aria-required="true">
        <div class="invalid-feedback">Por favor, ingrese la dirección.</div>
      </div>

      <div class="form-group mb-3">
        <label for="type" class="form-label">Tipo:</label>
        <select class="form-control" id="type" name="type" required aria-required="true">
          <option value="">Seleccione un tipo</option>
          <option value="Casa">Casa</option>
          <option value="Apartamento">Apartamento</option>
          <option value="Local">Local</option>
        </select>
        <div class="invalid-feedback">Seleccione un tipo de propiedad.</div>
      </div>

      <div class="row">
        <div class="col-md-6">
          <div class="form-group mb-3">
            <label for="price" class="form-label">Precio:</label>
            <input type="number" class="form-control" id="price" name="price" step="0.01" min="0" placeholder="Ingrese el precio" required aria-required="true">
            <div class="invalid-feedback">Ingrese un precio válido.</div>
          </div>
        </div>
        <div class="col-md-6">
          <div class="form-group mb-3">
            <label for="squareMeters" class="form-label">Metros Cuadrados:</label>
            <input type="number" class="form-control" id="squareMeters" name="squareMeters" min="1" placeholder="Ingrese los m²" required aria-required="true">
            <div class="invalid-feedback">Ingrese los metros cuadrados.</div>
          </div>
        </div>
      </div>
      <div class="row">
        <div class="col-md-6">
          <div class="form-group mb-3">
            <label for="rooms" class="form-label">Habitaciones:</label>
            <input type="number" class="form-control" id="rooms" name="rooms" min="0" placeholder="Número de habitaciones" required aria-required="true">
            <div class="invalid-feedback">Ingrese el número de habitaciones.</div>
          </div>
        </div>
        <div class="col-md-6">
          <div class="form-group mb-3">
            <label for="bathrooms" class="form-label">Baños:</label>
            <input type="number" class="form-control" id="bathrooms" name="bathrooms" min="0" placeholder="Número de baños" required aria-required="true">
            <div class="invalid-feedback">Ingrese el número de baños.</div>
          </div>
        </div>
      </div>
      <div class="form-group mb-3">
        <label for="description" class="form-label">Descripción:</label>
        <textarea class="form-control" id="description" name="description" rows="3" placeholder="Descripción de la propiedad"></textarea>
      </div>
      <div class="form-group mb-3">
        <label for="image" class="form-label">Imagen:</label>
        <input type="file" class="form-control" id="image" name="image" accept="image/*">
        <div class="invalid-feedback">Seleccione una imagen válida.</div>
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
      $('#add-property-form').on('submit', function(event) {
        event.preventDefault();
        var form = this;

        if (form.checkValidity() === false) {
          event.stopPropagation();
          $(form).addClass('was-validated');
        } else {
          $("#submit-btn").prop("disabled", true);
          $("#loading-spinner").show();

          var formData = new FormData(form);

          $.ajax({
            url: "${pageContext.request.contextPath}/belongs/property/add-property",
            type: "POST",
            data: formData,
            contentType: false,
            processData: false,
            success: function(data) {
              $("#loading-spinner").hide();
              $("#message").html('<div class="alert alert-success">Propiedad agregada exitosamente</div>').show();
              setTimeout(function() {
                window.location.href = "${pageContext.request.contextPath}/index.jsp";
              }, 2000);
            },
            error: function(xhr, status, error) {
              $("#loading-spinner").hide();
              $("#submit-btn").prop("disabled", false);
              $("#message").html('<div class="alert alert-danger">Error al agregar la propiedad: ' + error + '</div>').show();
            }
          });
        }
      });
    });
  </script>
</main>

<%@include file="../../includes/footer.jsp"%>
