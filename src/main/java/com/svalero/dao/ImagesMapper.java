package com.svalero.dao;

import com.svalero.domain.Images;
import org.jdbi.v3.core.mapper.RowMapper;
import org.jdbi.v3.core.statement.StatementContext;

import java.sql.ResultSet;
import java.sql.SQLException;

public class ImagesMapper implements RowMapper<Images> {
    @Override
    public Images map(ResultSet rs, StatementContext ctx) throws SQLException {
        return new Images(
            rs.getInt("id"),
            rs.getInt("property_id"),
            rs.getString("url")
        );
    }
}
