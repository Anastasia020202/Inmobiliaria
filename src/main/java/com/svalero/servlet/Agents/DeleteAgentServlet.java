package com.svalero.servlet.Agents;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.svalero.dao.AgentsDAO;
import com.svalero.dao.Database;

import java.io.IOException;

@WebServlet("/belongs/agents/delete-agent")
public class DeleteAgentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int agentId = Integer.parseInt(request.getParameter("id"));
            
            Database.connect();
            Database.jdbi.useExtension(AgentsDAO.class, dao -> {
                dao.removeAgent(agentId);
            });
            
            response.sendRedirect(request.getContextPath() + "/belongs/agents/view.jsp?deleteSuccess=true");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/belongs/agents/view.jsp?deleteSuccess=false");
        }
    }
}
