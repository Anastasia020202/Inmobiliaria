package com.svalero.dao;

import com.svalero.domain.Appointment;
import org.jdbi.v3.sqlobject.config.RegisterRowMapper;
import org.jdbi.v3.sqlobject.customizer.Bind;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import org.jdbi.v3.sqlobject.statement.SqlUpdate;

import java.util.List;
import java.time.LocalDateTime;

@RegisterRowMapper(AppointmentMapper.class)
public interface AppointmentsDAO {

    @SqlQuery("SELECT * FROM appointments")
    List<Appointment> getAppointments();

    @SqlQuery("SELECT * FROM appointments WHERE id = :id")
    Appointment getAppointment(@Bind("id") int id);

    @SqlQuery("SELECT * FROM appointments WHERE property_id = :propertyId")
    List<Appointment> getAppointmentsForProperty(@Bind("propertyId") int propertyId);

    @SqlQuery("SELECT * FROM appointments WHERE customer_id = :customerId")
    List<Appointment> getAppointmentsForCustomer(@Bind("customerId") int customerId);

    @SqlQuery("SELECT * FROM appointments WHERE agent_id = :agentId")
    List<Appointment> getAppointmentsForAgent(@Bind("agentId") int agentId);

    @SqlUpdate("DELETE FROM appointments WHERE id = :id")
    void removeAppointment(@Bind("id") int id);

    @SqlUpdate("UPDATE appointments SET property_id = :propertyId, customer_id = :customerId, agent_id = :agentId, appointment_datetime = :appointmentDatetime, status = :status, message = :message WHERE id = :id")
    void editAppointment(@Bind("propertyId") int propertyId, 
                         @Bind("customerId") int customerId, 
                         @Bind("agentId") int agentId, 
                         @Bind("appointmentDatetime") LocalDateTime appointmentDatetime, 
                         @Bind("status") String status, 
                         @Bind("message") String message, 
                         @Bind("id") int id);

    @SqlUpdate("INSERT INTO appointments (property_id, agent_id, customer_id, appointment_datetime, status, message) " +
               "VALUES (:propertyId, :agentId, :customerId, :appointmentDatetime, :status, :message)")
    void addAppointment(@Bind("propertyId") int propertyId,
                        @Bind("agentId") int agentId,
                        @Bind("customerId") int customerId,
                        @Bind("appointmentDatetime") LocalDateTime appointmentDatetime,
                        @Bind("status") String status,
                        @Bind("message") String message);

    @SqlUpdate("INSERT INTO appointments (property_id, customer_id, agent_id, appointment_datetime, status, message, customer_first_name, customer_last_name, customer_email, customer_phone) " +
               "VALUES (:propertyId, :customerId, :agentId, :appointmentDatetime, :status, :message, :customerFirstName, :customerLastName, :customerEmail, :customerPhone)")
    void addAppointmentWithCustomerInfo(@Bind("propertyId") int propertyId,
                                        @Bind("customerId") int customerId,
                                        @Bind("agentId") int agentId,
                                        @Bind("appointmentDatetime") LocalDateTime appointmentDatetime,
                                        @Bind("status") String status,
                                        @Bind("message") String message,
                                        @Bind("customerFirstName") String customerFirstName,
                                        @Bind("customerLastName") String customerLastName,
                                        @Bind("customerEmail") String customerEmail,
                                        @Bind("customerPhone") String customerPhone);
    
    @SqlUpdate("UPDATE appointments SET property_id = :propertyId, customer_id = :customerId, agent_id = :agentId, appointment_datetime = :appointmentDatetime, status = :status, message = :message, customer_first_name = :customerFirstName, customer_last_name = :customerLastName, customer_email = :customerEmail, customer_phone = :customerPhone WHERE id = :id")
    void editAppointmentWithCustomerInfo(@Bind("propertyId") int propertyId, 
                                         @Bind("customerId") int customerId, 
                                         @Bind("agentId") int agentId, 
                                         @Bind("appointmentDatetime") LocalDateTime appointmentDatetime, 
                                         @Bind("status") String status, 
                                         @Bind("message") String message, 
                                         @Bind("customerFirstName") String customerFirstName,
                                         @Bind("customerLastName") String customerLastName,
                                         @Bind("customerEmail") String customerEmail,
                                         @Bind("customerPhone") String customerPhone,
                                         @Bind("id") int id);
}
