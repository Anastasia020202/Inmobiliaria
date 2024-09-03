package com.svalero.servlet.property;

import com.svalero.dao.Database;
import com.svalero.dao.PropertyDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/belongs/property/edit-property")
public class EditPropertyServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Obtén los parámetros de la solicitud
            String propertyIdParam = request.getParameter("id");
            String address = request.getParameter("address");
            String type = request.getParameter("type");
            String priceParam = request.getParameter("price");
            String squareMetersParam = request.getParameter("squareMeters");
            String roomsParam = request.getParameter("rooms");
            String bathroomsParam = request.getParameter("bathrooms");
            String description = request.getParameter("description");

            // Verifica si los parámetros necesarios no son nulos o vacíos antes de convertirlos
            if (propertyIdParam == null || propertyIdParam.isEmpty() ||
                priceParam == null || priceParam.isEmpty() ||
                squareMetersParam == null || squareMetersParam.isEmpty() ||
                roomsParam == null || roomsParam.isEmpty() ||
                bathroomsParam == null || bathroomsParam.isEmpty()) {

                throw new IllegalArgumentException("Se recibieron parámetros nulos o vacíos en la solicitud.");
            }

            int propertyId = Integer.parseInt(propertyIdParam);
            double price = Double.parseDouble(priceParam);
            int squareMeters = Integer.parseInt(squareMetersParam);
            int rooms = Integer.parseInt(roomsParam);
            int bathrooms = Integer.parseInt(bathroomsParam);

            Database.connect();

            // Actualiza la propiedad en la base de datos sin modificar la imagen
            Database.jdbi.useExtension(PropertyDAO.class, dao -> {
                dao.editProperty(address, type, price, squareMeters, rooms, bathrooms, description, propertyId);
            });

            response.sendRedirect(request.getContextPath() + "/");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al actualizar la propiedad: " + e.getMessage());
        }
    }
}
