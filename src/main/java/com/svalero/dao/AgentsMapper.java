package com.svalero.dao;

import com.svalero.domain.Agents;
import org.jdbi.v3.core.mapper.RowMapper;
import org.jdbi.v3.core.statement.StatementContext;

import java.sql.ResultSet;
import java.sql.SQLException;

public class AgentsMapper implements RowMapper<Agents> {
    @Override
    public Agents map(ResultSet rs, StatementContext ctx) throws SQLException {
        return new Agents(
            rs.getInt("id"),
            rs.getString("first_name"),
            rs.getString("last_name"),
            rs.getString("email"),
            rs.getString("phone"),
            rs.getString("password")
        );
    }
}