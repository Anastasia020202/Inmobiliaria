package com.svalero.dao;

import com.svalero.domain.Customers;
import org.jdbi.v3.core.mapper.RowMapper;
import org.jdbi.v3.core.statement.StatementContext;

import java.sql.ResultSet;
import java.sql.SQLException;

public class CustomerMapper implements RowMapper<Customers> {

    @Override
    public Customers map(ResultSet rs, StatementContext ctx) throws SQLException {
        return new Customers(
            rs.getInt("id"),
            rs.getString("first_name"),
            rs.getString("last_name"),
            rs.getString("email"),
            rs.getString("phone")
        );
    }
}
