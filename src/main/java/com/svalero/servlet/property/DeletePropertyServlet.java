package com.svalero.servlet.property;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.svalero.dao.PropertyDAO;
import com.svalero.dao.Database;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/belongs/property/delete-property")
public class DeletePropertyServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int propertyId = Integer.parseInt(request.getParameter("id"));

        try {
            Database.connect();
            
            Database.jdbi.useExtension(PropertyDAO.class, dao -> {
                dao.removeProperty(propertyId);
            });

            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write("Propiedad eliminada con éxito");
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Error al eliminar la propiedad: " + e.getMessage());
        }
    }
}