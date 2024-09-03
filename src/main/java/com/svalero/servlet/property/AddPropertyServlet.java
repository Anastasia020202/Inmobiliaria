package com.svalero.servlet.property;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.svalero.dao.PropertyDAO;
import com.svalero.dao.Database;

import java.io.IOException;

@WebServlet("/belongs/property/add-property")
@MultipartConfig // Necesario para manejar la subida de archivos
public class AddPropertyServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Recogiendo los parámetros
            String address = request.getParameter("address");
            String type = request.getParameter("type");
            double price = Double.parseDouble(request.getParameter("price"));
            int square_meters = Integer.parseInt(request.getParameter("squareMeters"));
            int rooms = Integer.parseInt(request.getParameter("rooms"));
            int bathrooms = Integer.parseInt(request.getParameter("bathrooms"));
            String description = request.getParameter("description");

            // Recogiendo la imagen
            Part filePart = request.getPart("image"); // El input de la imagen debe tener name="image"
            byte[] image = null;

            if (filePart != null && filePart.getSize() > 0) {
                image = filePart.getInputStream().readAllBytes(); // Convertir la imagen a un array de bytes
            }

            // Añadiendo log para la depuración
            System.out.println("Received property data:");
            System.out.println("Address: " + address);
            System.out.println("Type: " + type);
            System.out.println("Price: " + price);
            System.out.println("Square Meters: " + square_meters);
            System.out.println("Rooms: " + rooms);
            System.out.println("Bathrooms: " + bathrooms);
            System.out.println("Description: " + description);
            System.out.println("Image size: " + (image != null ? image.length : "No image"));

            int agentId = 1; // Aquí puedes asignar un ID de agente válido

            // Conexión a la base de datos
            Database.connect();

            // Insertando la nueva propiedad
            final byte[] finalImage = image;
            Database.jdbi.useExtension(PropertyDAO.class, dao -> {
                dao.addProperty(address, type, price, square_meters, rooms, bathrooms, description, agentId, finalImage);
            });

            // Confirmación de éxito
            System.out.println("Property added successfully");
            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write("Propiedad añadida con éxito");

        } catch (Exception e) {
            // Manejo de errores
            System.err.println("Error while adding property: " + e.getMessage());
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Error al añadir la propiedad: " + e.getMessage());
        }
    }
}
