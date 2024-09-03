package com.svalero.servlet.Agents;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.svalero.dao.AgentsDAO;
import com.svalero.dao.Database;

import java.io.IOException;

@WebServlet("/belongs/agents/add-agent")
public class AddAgentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Recoger parámetros del formulario
            String firstName = request.getParameter("first_name");
            String lastName = request.getParameter("last_name");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String password = request.getParameter("password");
            
            // Logging each value to confirm correct retrieval
            System.out.println("First Name: " + firstName);
            System.out.println("Last Name: " + lastName);
            System.out.println("Email: " + email);
            System.out.println("Phone: " + phone);
            System.out.println("Password: " + password);
            
            // Conectar a la base de datos y agregar el agente
            Database.connect();
            
            System.out.println("Connected to database");
            
            Database.jdbi.useExtension(AgentsDAO.class, dao -> {
                dao.addAgent(firstName, lastName, email, phone, password);
            });
            
            System.out.println("Agent added successfully");
            
            // Enviar respuesta de éxito
            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write("Agente añadido con éxito");
        } catch (Exception e) {
            // Manejo de errores
            System.err.println("Error while adding agent: " + e.getMessage());
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Error al añadir el agente: " + e.getMessage());
        }
    }
}
