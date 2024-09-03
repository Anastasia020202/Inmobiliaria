package com.svalero.dao;

import com.svalero.domain.Review;
import org.jdbi.v3.sqlobject.config.RegisterRowMapper;
import org.jdbi.v3.sqlobject.customizer.Bind;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import org.jdbi.v3.sqlobject.statement.SqlUpdate;

import java.util.List;

@RegisterRowMapper(ReviewMapper.class)
public interface ReviewDAO {

    @SqlQuery("SELECT * FROM reviews")
    List<Review> getAllReviews();

    @SqlQuery("SELECT * FROM reviews WHERE id = :id")
    Review getReview(@Bind("id") int id);

    @SqlUpdate("UPDATE reviews SET customer_name = :customerName, text = :text WHERE id = :id")
    void editReview(@Bind("id") int id, @Bind("customerName") String customerName, @Bind("text") String text);

    @SqlUpdate("DELETE FROM reviews WHERE id = :id")
    void deleteReview(@Bind("id") int id);

    @SqlUpdate("INSERT INTO reviews (customer_name, text) VALUES (:customerName, :text)")
    void addReview(@Bind("customerName") String customerName, @Bind("text") String text);


}
