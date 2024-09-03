package com.svalero.servlet.Reviews;

import com.svalero.dao.Database;
import com.svalero.dao.ReviewDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/belongs/reviews/delete-review")
public class DeleteReviewServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        try {
            Database.connect();
            Database.jdbi.useExtension(ReviewDAO.class, dao -> dao.deleteReview(id));
            response.sendRedirect(request.getContextPath() + "/?deleteSuccess=true");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/?deleteSuccess=false");
        }
    }
}
