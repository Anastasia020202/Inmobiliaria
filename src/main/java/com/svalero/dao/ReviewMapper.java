package com.svalero.dao;

import com.svalero.domain.Review;
import org.jdbi.v3.core.mapper.RowMapper;
import org.jdbi.v3.core.statement.StatementContext;

import java.sql.ResultSet;
import java.sql.SQLException;

public class ReviewMapper implements RowMapper<Review> {

    @Override
    public Review map(ResultSet rs, StatementContext ctx) throws SQLException {
        return new Review(
            rs.getInt("id"),
            rs.getString("customer_name"),
            rs.getString("text")
        );
    }
}
