package com.svalero.dao;

import com.svalero.domain.Customers;
import org.jdbi.v3.sqlobject.config.RegisterRowMapper;
import org.jdbi.v3.sqlobject.customizer.Bind;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import org.jdbi.v3.sqlobject.statement.SqlUpdate;

import java.util.List;

@RegisterRowMapper(CustomerMapper.class)
public interface CustomersDAO {

    @SqlQuery("SELECT * FROM customers")
    List<Customers> getCustomers();

    @SqlQuery("SELECT * FROM customers WHERE id = :id")
    Customers getCustomerById(@Bind("id") int id);

    @SqlQuery("SELECT * FROM customers WHERE email = :email")
    Customers getCustomerByEmail(@Bind("email") String email);

    @SqlUpdate("DELETE FROM customers WHERE id = :id")
    void removeCustomer(@Bind("id") int id);

    @SqlUpdate("UPDATE customers SET first_name = :firstName, last_name = :lastName, email = :email, phone = :phone WHERE id = :id")
    void editCustomer(@Bind("firstName") String firstName, 
                      @Bind("lastName") String lastName, 
                      @Bind("email") String email, 
                      @Bind("phone") String phone, 
                      @Bind("id") int id);

    @SqlUpdate("INSERT INTO customers (first_name, last_name, email, phone) VALUES (:firstName, :lastName, :email, :phone)")
    void addCustomer(@Bind("firstName") String firstName, 
                     @Bind("lastName") String lastName, 
                     @Bind("email") String email, 
                     @Bind("phone") String phone);
}
