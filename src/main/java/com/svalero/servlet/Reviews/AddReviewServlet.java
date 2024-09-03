package com.svalero.servlet.Reviews;

import com.svalero.dao.Database;
import com.svalero.dao.ReviewDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/belongs/reviews/add-review")
public class AddReviewServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String customerName = request.getParameter("customer_name");
        String text = request.getParameter("text");

        try {
            Database.connect();
            Database.jdbi.useExtension(ReviewDAO.class, dao -> dao.addReview(customerName, text));
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/belongs/reviews/add.jsp?error=true");
        }
    }
}
