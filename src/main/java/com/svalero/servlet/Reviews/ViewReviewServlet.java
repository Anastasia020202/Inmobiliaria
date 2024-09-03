package com.svalero.servlet.Reviews;

import com.svalero.dao.Database;
import com.svalero.dao.ReviewDAO;
import com.svalero.domain.Review;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/belongs/reviews/view-review")
public class ViewReviewServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int reviewId = Integer.parseInt(request.getParameter("id"));

        try {
            Database.connect();
            Review review = Database.jdbi.withExtension(ReviewDAO.class, dao -> dao.getReview(reviewId));
            request.setAttribute("review", review);
            request.getRequestDispatcher("/belongs/reviews/view.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al cargar la reseña.");
        }
    }
}
