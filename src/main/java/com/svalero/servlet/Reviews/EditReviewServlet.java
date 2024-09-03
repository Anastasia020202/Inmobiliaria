package com.svalero.servlet.Reviews;

import com.svalero.dao.Database;
import com.svalero.dao.ReviewDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/belongs/reviews/edit-review")
public class EditReviewServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String customerName = request.getParameter("customer_name");
        String text = request.getParameter("text");

        try {
            Database.connect();
            Database.jdbi.useExtension(ReviewDAO.class, dao -> dao.editReview(id, customerName, text));
            response.sendRedirect(request.getContextPath() + "/belongs/reviews/view.jsp?id=" + id + "&editSuccess=true");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/belongs/reviews/view.jsp?id=" + id + "&editSuccess=false");
        }
    }
}
