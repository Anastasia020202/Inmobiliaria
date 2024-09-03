package com.svalero.dao;

import com.svalero.domain.Appointments;
import org.jdbi.v3.core.mapper.RowMapper;
import org.jdbi.v3.core.statement.StatementContext;

import java.sql.ResultSet;
import java.sql.SQLException;

public class AppointmentsMapper implements RowMapper<AppointmentsDAO> {
    @Override
    public AppointmentsDAO map(ResultSet rs, StatementContext ctx) throws SQLException {
        return (AppointmentsDAO) new Appointments(
            rs.getInt("id"),
            rs.getInt("property_id"),
            rs.getInt("customer_id"),
            rs.getInt("agent_id"),
            rs.getTimestamp("appointment_datetime"),
            rs.getString("status")
        );
    }
}