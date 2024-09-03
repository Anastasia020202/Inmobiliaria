package com.svalero.dao;

import com.svalero.domain.Agents;
import org.jdbi.v3.sqlobject.config.RegisterRowMapper;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import org.jdbi.v3.sqlobject.statement.SqlUpdate;

import java.util.List;

@RegisterRowMapper(AgentsMapper.class)
public interface AgentsDAO {
    
    @SqlQuery("SELECT * FROM agents")
    List<Agents> getAgents();

    @SqlQuery("SELECT TOP 3 * FROM agents")
    List<Agents> getTopAgents();

    @SqlQuery("SELECT * FROM agents WHERE id = ?")
    Agents getAgentId(int id);

    @SqlQuery("SELECT * FROM agents WHERE first_name = ?, last_name = ? , email = ?, phone = ?")
    Agents getAgent(String firstName, String lastName, String email, String phone);

    @SqlQuery("SELECT * FROM agents WHERE email = ?")
    Agents getAgentByEmail(String email);

    @SqlUpdate("DELETE FROM agents WHERE id = ?")
    void removeAgent(int id);    

    @SqlUpdate("UPDATE agents SET first_name = ?, last_name = ?, email = ?, phone = ?, password = ? WHERE id = ?")
    void editAgent(String firstName, String lastName, String email, String phone, String password, int id);

    @SqlUpdate("INSERT INTO agents (first_name, last_name, email, phone, password) VALUES (?, ?, ?, ?, ?)")
    void addAgent(String firstName, String lastName, String email, String phone, String password);
}

