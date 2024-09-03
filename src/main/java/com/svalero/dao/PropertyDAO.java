package com.svalero.dao;

import com.svalero.domain.Property;
import org.jdbi.v3.sqlobject.customizer.Bind;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import org.jdbi.v3.sqlobject.statement.SqlUpdate;
import org.jdbi.v3.sqlobject.statement.UseRowMapper;

import java.util.List;

public interface PropertyDAO {

    @SqlQuery("SELECT * FROM properties")
    @UseRowMapper(PropertyMapper.class)
    List<Property> getProperties();

    @SqlQuery("SELECT * FROM properties WHERE id = :id")
    @UseRowMapper(PropertyMapper.class)
    Property getProperty(@Bind("id") int id);

    @SqlQuery("SELECT * FROM properties WHERE type = :type")
    @UseRowMapper(PropertyMapper.class)
    List<Property> searchByType(@Bind("type") String type);

    @SqlQuery("SELECT * FROM properties WHERE price <= :maxPrice")
    @UseRowMapper(PropertyMapper.class)
    List<Property> searchByMaxPrice(@Bind("maxPrice") Double maxPrice);

    @SqlUpdate("DELETE FROM properties WHERE id = :id")
    void removeProperty(@Bind("id") int id);

    @SqlUpdate("UPDATE properties SET address = :address, type = :type, price = :price, square_meters = :squareMeters, rooms = :rooms, bathrooms = :bathrooms, description = :description WHERE id = :id")
    void editProperty(@Bind("address") String address,
                      @Bind("type") String type,
                      @Bind("price") double price,
                      @Bind("squareMeters") int squareMeters,
                      @Bind("rooms") int rooms,
                      @Bind("bathrooms") int bathrooms,
                      @Bind("description") String description,
                      @Bind("id") int id);

    @SqlUpdate("INSERT INTO properties (address, type, price, square_meters, rooms, bathrooms, description, agent_id, ImageColumn) VALUES (:address, :type, :price, :squareMeters, :rooms, :bathrooms, :description, :agentId, :image)")
    void addProperty(@Bind("address") String address,
                     @Bind("type") String type,
                     @Bind("price") double price,
                     @Bind("squareMeters") int squareMeters,
                     @Bind("rooms") int rooms,
                     @Bind("bathrooms") int bathrooms,
                     @Bind("description") String description,
                     @Bind("agentId") int agentId,
                     @Bind("image") byte[] image);
                    
    @SqlQuery("SELECT * FROM properties WHERE (:type IS NULL OR type = :type) AND (:rooms IS NULL OR rooms = :rooms)")
    @UseRowMapper(PropertyMapper.class)
    List<Property> searchPropertiesByTypeAndRooms(@Bind("type") String type, @Bind("rooms") Integer rooms);
}
