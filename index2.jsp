<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="com.svalero.domain.Property" %>
<%@ page import="com.svalero.dao.Property." %>

<%@ page import="com.svalero.domain.Images" %>
<%@ page import="com.svalero.dao.Images." %>

<%@ page import="com.svalero.domain.Customers" %>
<%@ page import="com.svalero.dao.Customers." %>

<%@ page import="com.svalero.domain.Appointments" %>
<%@ page import="com.svalero.dao.Appointments." %>

<%@ page import="com.svalero.domain.Agents" %>
<%@ page import="com.svalero.dao.Agents." %>

<%@ page import="java.util.List" %>
<%@ page import="com.svalero.dao.Database" %>
<%@ page import="com.svalero.util.CurrencyUtils" %>

<%@include file="includes/header.jsp"%>

<main>
    <div class="album py-2 bg-body-tertiary">
      <div class="container">
        <div class="alert alert-danger" role="alert">
        <div class="row">
          <div class="col-8">
            <h5 class="card-title">Limpiar registros</h5>
            <h6 class="card-subtitle mb-2 text-muted">Limpiar registros de la base de datos con el procedure</h6>
          </div>
          <div class="col-4 items-center text-center" style="align-content: center;">
            <div class="btn-group" role="group" aria-label="Basic example">
              <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#criteriaModal">Borrar</button>
              <button type="button" class="btn btn-outline-danger" data-bs-toggle="modal" data-bs-target="#customModal">Borrar por precio y estado</button>
            </div>
          </div>
        </div>
        </div>
      </div>
  
      <!-- Modal -->
      <div class="modal fade" id="criteriaModal" tabindex="-1" role="dialog" aria-labelledby="criteriaModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title" id="criteriaModalLabel">Seguro que desea eliminar registros?</h5>
            </div>
            <div class="modal-body">
              Se eliminaran algunos de los registros de la base de datos segun los datos de la tabla
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
              <div id="delete-btn">
                <button type="button" class="btn btn-danger">Eliminar</button>
              </div>
            </div>
          </div>
        </div>
      </div>
  
    <div class="container">
      <div class="row py-3">
          <div class="col">
            <h3>Portatiles</h3>
          </div>
          <div class="col text-end">
            <a href="device/laptop/search.jsp" class="btn btn-outline-primary">Buscar</a>
            <a href="device/laptop/add.jsp" class="btn btn-outline-primary">Agregar laptop</a>
          </div>
        </div>
      </div>
      <div class="container">
        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
          <%
            Database.connect();
            List<Laptop> laptops = Database.jdbi.withExtension(LaptopDao.class, dao -> dao.getAll());
            for (Laptop laptop : laptops) {
          %>
          <div class="col">
            <div class="card shadow-sm">
              <div class="card-body">
                <p class="card-text"><strong><%= laptop.getBrand() %></strong> <i><%= laptop.getModel() %></i></p>
                <p class="card-text"><%= laptop.getDescription() %></p>
                <p class="card-text">Reparado: <%= laptop.getFixed().toString() %></p>
                <div class="d-flex justify-content-between align-items-center">
                  <div class="btn-group">
                    <a href="device/laptop/view.jsp?id=<%= laptop.getId() %>" type="button" class="btn btn-sm btn-outline-primary">Ver</a>
                    <a href="device/laptop/edit.jsp?id=<%= laptop.getId() %>" type="button" class="btn btn-sm btn-outline-warning">Editar</a>
                    <a href="device/laptop/delete.jsp?id=<%= laptop.getId() %>" type="button" class="btn btn-sm btn-outline-danger">Eliminar</a>
                  </div>
                  <small class="text-body-secondary"><%= CurrencyUtils.format(laptop.getPrice()) %></small>
                </div>
              </div>
            </div>
          </div>
          <%
            }
          %>
        </div>
      </div>
    </div>
  
    <div class="container">
      <div class="row py-3">
          <div class="col">
            <h3>Mobiles</h3>
          </div>
          <div class="col text-end">
            <a href="device/phone/search.jsp" class="btn btn-outline-primary">Buscar</a>
            <a href="device/phone/add.jsp" class="btn btn-outline-primary">Agregar movil</a>
          </div>
        </div>
      </div>
      <div class="container">
        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
          <%
            Database.connect();
            List<Phone> phones = Database.jdbi.withExtension(PhoneDao.class, dao -> dao.getAll());
            for (Phone phone : phones) {
          %>
          <div class="col">
            <div class="card shadow-sm">
              <div class="card-body">
                <p class="card-text"><strong><%= phone.getBrand() %></strong> <i><%= phone.getModel() %></i></p>
                <p class="card-text"><%= phone.getDescription() %></p>
                <p class="card-text">Reparado: <%= phone.getFixed().toString() %></p>
                <p class="card-text">Intentos: <%= phone.getFix_attempts() %></p>
                <div class="d-flex justify-content-between align-items-center">
                  <div class="btn-group">
                    <a href="device/phone/view.jsp?id=<%= phone.getId() %>" type="button" class="btn btn-sm btn-outline-primary">Ver</a>
                    <a href="device/phone/edit.jsp?id=<%= phone.getId() %>" type="button" class="btn btn-sm btn-outline-warning">Editar</a>
                    <a href="device/phone/delete.jsp?id=<%= phone.getId() %>" type="button" class="btn btn-sm btn-outline-danger">Eliminar</a>
                  </div>
                  <small class="text-body-secondary"><%= CurrencyUtils.format(phone.getPrice()) %></small>
                </div>
              </div>
            </div>
          </div>
          <%
            }
          %>
        </div>
      </div>
    </div>
  
    <div class="container">
      <div class="row py-3">
          <div class="col">
            <h3>Tablets</h3>
          </div>
          <div class="col text-end">
            <a href="device/tablet/search.jsp" class="btn btn-outline-primary">Buscar</a>
            <a href="device/tablet/add.jsp" class="btn btn-outline-primary">Agregar tablet</a>
          </div>
        </div>
      </div>
      <div class="container">
        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
          <%
            Database.connect();
            List<Tablet> tablets = Database.jdbi.withExtension(TabletDao.class, dao -> dao.getAll());
            for (Tablet tablet : tablets) {
          %>
          <div class="col">
            <div class="card shadow-sm">
              <div class="card-body">
                <p class="card-text"><strong><%= tablet.getBrand() %></strong> <i><%= tablet.getModel() %></i></p>
                <p class="card-text"><%= tablet.getDescription() %></p>
                <p class="card-text">Reparado: <%= tablet.getFixed().toString() %></p>
                <p class="card-text">Garantia: <%= tablet.getWarranty() %></p>
                <div class="d-flex justify-content-between align-items-center">
                  <div class="btn-group">
                    <a href="device/tablet/view.jsp?id=<%= tablet.getId() %>" type="button" class="btn btn-sm btn-outline-primary">Ver</a>
                    <a href="device/tablet/edit.jsp?id=<%= tablet.getId() %>" type="button" class="btn btn-sm btn-outline-warning">Editar</a>
                    <a href="device/tablet/delete.jsp?id=<%= tablet.getId() %>" type="button" class="btn btn-sm btn-outline-danger">Eliminar</a>
                  </div>
                  <small class="text-body-secondary"><%= CurrencyUtils.format(tablet.getPrice()) %></small>
                </div>
              </div>
            </div>
          </div>
          <%
            }
          %>
        </div>
      </div>
    </div>
  
    <div class="container">
      <div class="row py-3">
          <div class="col">
            <h3>Relojes</h3>
          </div>
          <div class="col text-end">
            <a href="device/watch/add.jsp" class="btn btn-outline-primary">Agregar watch</a>
          </div>
        </div>
      </div>
      <div class="container">
        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
          <%
            Database.connect();
            List<Watch> watches = Database.jdbi.withExtension(WatchDao.class, dao -> dao.getAll());
            for (Watch watch : watches) {
          %>
          <div class="col">
            <div class="card shadow-sm">
              <div class="card-body">
                <p class="card-text"><strong><%= watch.getBrand() %></strong> <i><%= watch.getModel() %></i></p>
                <p class="card-text"><%= watch.getDescription() %></p>
                <p class="card-text">Reparado: <%= watch.getFixed().toString() %></p>
                <p class="card-text">OS: <%= watch.getOs() %></p>
                <div class="d-flex justify-content-between align-items-center">
                  <div class="btn-group">
                    <a href="device/watch/view.jsp?id=<%= watch.getId() %>" type="button" class="btn btn-sm btn-outline-primary">Ver</a>
                    <a href="device/watch/edit.jsp?id=<%= watch.getId() %>" type="button" class="btn btn-sm btn-outline-warning">Editar</a>
                    <a href="device/watch/delete.jsp?id=<%= watch.getId() %>" type="button" class="btn btn-sm btn-outline-danger">Eliminar</a>
                  </div>
                  <small class="text-body-secondary"><%= CurrencyUtils.format(watch.getPrice()) %></small>
                </div>
              </div>
            </div>
          </div>
          <%
            }
          %>
        </div>
      </div>
    </div>
  
    <div class="modal fade" id="customModal" tabindex="-1" role="dialog" aria-labelledby="customModallLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
          <div class="modal-content">
          <form id="custom-delete" method="post">
            <div class="modal-header">
              <h5 class="modal-title" id="customModallLabel">Selecciona el precio minimo y estado para eliminar</h5>
            </div>
            <div class="modal-body">
              Se eliminaran algunos de los registros de la base de datos segun los valores siguientes:
              <br>
              <div class="mb-3">
                <label for="price" class="form-label">Precio minimo</label>
                <input type="number" class="form-control" id="price" name="price" required>
  
                <label for="fixed" class="form-label">Estado</label>
                <select class="form-select" id="fixed" name="fixed" required>
                  <option value="true">Reparado</option>
                  <option value="false">No reparado</option>
                </select>
              </div>
  
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
              <div id="delete-btn">
                <button type="submit" class="btn btn-danger">Eliminar</button>
              </div>
            </div>
            </form>
          </div>
        </div>
      </div>
  </main>
  
  <!-- Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
  
    <script type="text/javascript">
    $("#delete-btn").on("click", function() {
      $(this).html('<button type="button" class="btn btn-danger" disabled><span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Eliminando...</button>');
  
      // Ajax call to delete records from database
      $.ajax({
        url: "/TechStoreApp/device/clean",
        type: "POST",
        success: function(data) {
          console.log("Records deleted successfully: ", data);
  
          alert("Registros eliminados correctamente: " + data);
  
          // Reload the page
          window.location.reload();
        },
      });
  
    });
  
    $("#custom-delete").on("submit", function(e) {
      e.preventDefault();
  
      $(this).find("button[type=submit]").html('<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Eliminando...');
  
      // Ajax call to delete records from database
      $.ajax({
       url: "/TechStoreApp/device/clean",
       type: "POST",
       data: {
           fixed: $("#fixed").val() === "true",
           price: $("#price").val()
       },
       contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        success: function(data) {
          console.log("Records deleted successfully: ", data);
  
          alert("Registros eliminados correctamente: " + data);
  
          // Reload the page
          window.location.reload();
        },
      });
  
    });
  
    </script>
  
    <%@include file="includes/footer.jsp"%>