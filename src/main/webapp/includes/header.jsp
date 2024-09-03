<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!doctype html>
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Agencia Inmobiliaria</title>
    <link rel="shortcut icon" href="" type="image/x-icon">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
</head>

<div class="container">
    <header class="d-flex flex-wrap justify-content-between align-items-center py-3 mb-4 border-bottom">
        <a href="/Inmobiliaria" class="d-flex align-items-center mb-3 mb-md-0 text-decoration-none">
            <span class="fs-4 text-primary">Inmobiliaria Zaragoza</span>
        </a>

        <ul class="nav nav-pills">
            <li class="nav-item"><a href="#" class="nav-link active" aria-current="page">Inicio</a></li>
            <li class="nav-item"><a href="#" class="nav-link">Propiedades</a></li>
            <li class="nav-item"><a href="#" class="nav-link">Servicios</a></li>
            <li class="nav-item"><a href="#" class="nav-link">Contacto</a></li>
            <li class="nav-item"><a href="#" class="nav-link">Nosotros</a></li>
            <li class="nav-item"><a href="${pageContext.request.contextPath}/belongs/appointments/view.jsp" class="nav-link">Citas</a></li>
        </ul>
    </header>
</div>
