package com.svalero.servlet.Agents;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.svalero.dao.AgentsDAO;
import com.svalero.dao.Database;

import java.io.IOException;

@WebServlet("/belongs/agents/edit-agent")
public class EditAgentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String firstName = request.getParameter("first_name");
            String lastName = request.getParameter("last_name");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String password = request.getParameter("password");

            Database.connect();
            Database.jdbi.useExtension(AgentsDAO.class, dao -> {
                dao.editAgent(firstName, lastName, email, phone, password, id);
            });

            response.sendRedirect(request.getContextPath() + "/belongs/agents/view.jsp?editSuccess=true");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/belongs/agents/view.jsp?editSuccess=false");
        }
    }
}
