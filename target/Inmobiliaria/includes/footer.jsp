<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!doctype html>
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title></title>
    <link rel="shortcut icon" href="" type="image/x-icon">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
</head>

<div class="container">
    <footer class="d-flex flex-column flex-md-row justify-content-between align-items-center py-4 my-4 border-top">
        <div class="col-md-4 mb-3 mb-md-0">
            <h5 class="text-primary">Inmobiliaria Zaragoza</h5>
            <p class="text-body-secondary">&copy; 2024 Inmobiliaria Zaragoza. Todos los derechos reservados.</p>
        </div>

        <div class="col-md-4 mb-3 mb-md-0 text-center">
            <a href="/" class="d-flex align-items-center justify-content-center link-body-emphasis text-decoration-none">

            </a>
            <div class="mt-2">
                <a href="#" class="text-body-secondary me-3"><i class="bi bi-facebook"></i></a>
                <a href="#" class="text-body-secondary me-3"><i class="bi bi-twitter"></i></a>
                <a href="#" class="text-body-secondary"><i class="bi bi-instagram"></i></a>
            </div>
        </div>

        <ul class="nav col-md-4 justify-content-end">
            <li class="nav-item"><a href="#" class="nav-link px-2 text-body-secondary">Inicio</a></li>
            <li class="nav-item"><a href="#" class="nav-link px-2 text-body-secondary">Propiedades</a></li>
            <li class="nav-item"><a href="#" class="nav-link px-2 text-body-secondary">Servicios</a></li>
            <li class="nav-item"><a href="#" class="nav-link px-2 text-body-secondary">Contacto</a></li>
            <li class="nav-item"><a href="#" class="nav-link px-2 text-body-secondary">Nosotros</a></li>
            <li class="nav-item"><a href="${pageContext.request.contextPath}/belongs/appointments/view.jsp" class="nav-link px-2 text-body-secondary">Citas</a></li>
        </ul>
        
    </footer>
</div>
