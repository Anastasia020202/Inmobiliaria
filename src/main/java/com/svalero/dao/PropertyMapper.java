package com.svalero.dao;

import com.svalero.domain.Property;
import org.jdbi.v3.core.mapper.RowMapper;
import org.jdbi.v3.core.statement.StatementContext;

import java.sql.ResultSet;
import java.sql.SQLException;

public class PropertyMapper implements RowMapper<Property> {

    @Override
    public Property map(ResultSet rs, StatementContext ctx) throws SQLException {
        return new Property(
            rs.getInt("id"),
            rs.getString("address"),
            rs.getString("type"),
            rs.getDouble("price"),
            rs.getInt("square_meters"),
            rs.getInt("rooms"),
            rs.getInt("bathrooms"),
            rs.getString("description"),
            rs.getInt("agent_id"),
            rs.getBytes("ImageColumn") // Mapear la columna de imagen
        );
    }
}
