package com.svalero.servlet.property;

import com.svalero.dao.PropertyDAO;
import com.svalero.dao.Database;
import com.svalero.domain.Property;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/belongs/property/search-properties")
public class SearchPropertiesServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Recoger los parámetros del formulario
        String type = request.getParameter("type");
        String roomsParam = request.getParameter("rooms");

        System.out.println("Received search parameters:");
        System.out.println("Type: " + type);
        System.out.println("Rooms: " + roomsParam);

        // Convertir parámetros a tipos de datos adecuados
        Integer rooms = null;
        if (roomsParam != null && !roomsParam.isEmpty()) {
            try {
                rooms = Integer.parseInt(roomsParam);
                System.out.println("Parsed rooms: " + rooms);
            } catch (NumberFormatException e) {
                System.out.println("Failed to parse rooms parameter: " + e.getMessage());
            }
        }

        try {
            Database.connect();
            System.out.println("Database connected.");

            final Integer finalRooms = rooms;
            List<Property> properties = Database.jdbi.withExtension(PropertyDAO.class, dao -> 
                dao.searchPropertiesByTypeAndRooms(type, finalRooms)
            );

            System.out.println("Properties found: " + properties.size());

            request.setAttribute("properties", properties);
            request.getRequestDispatcher("/belongs/property/search.jsp").forward(request, response);

        } catch (Exception e) {
            System.out.println("Exception caught: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error al buscar propiedades: " + e.getMessage());
            request.getRequestDispatcher("/belongs/property/search.jsp").forward(request, response);
        }
    }
}
