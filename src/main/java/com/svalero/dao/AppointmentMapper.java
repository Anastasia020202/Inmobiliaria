package com.svalero.dao;

import com.svalero.domain.Appointment;
import org.jdbi.v3.core.mapper.RowMapper;
import org.jdbi.v3.core.statement.StatementContext;

import java.sql.ResultSet;
import java.sql.SQLException;

public class AppointmentMapper implements RowMapper<Appointment> {

    @Override
    public Appointment map(ResultSet rs, StatementContext ctx) throws SQLException {
        return new Appointment(
            rs.getInt("id"),
            rs.getInt("property_id"),
            rs.getInt("customer_id"),
            rs.getInt("agent_id"),
            rs.getString("customer_first_name"),
            rs.getString("customer_last_name"),
            rs.getString("customer_email"),
            rs.getString("customer_phone"),
            rs.getString("message"),
            rs.getTimestamp("appointment_datetime"),
            rs.getString("status")
        );
    }
}

