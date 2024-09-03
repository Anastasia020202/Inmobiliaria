package com.svalero.dao;

import com.svalero.domain.Images;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import org.jdbi.v3.sqlobject.statement.SqlUpdate;
import org.jdbi.v3.sqlobject.statement.UseRowMapper;

import java.util.List;

public interface ImagesDAO {
    
    @SqlQuery("SELECT * FROM images")
    @UseRowMapper(ImagesMapper.class)
    List<Images> getImages();

    @SqlQuery("SELECT * FROM images WHERE id = ?")
    @UseRowMapper(ImagesMapper.class)
    Images getImage(int id);

    @SqlQuery("SELECT * FROM images WHERE property_id = ?")
    @UseRowMapper(ImagesMapper.class)
    List<Images> getImagesForProperty(int propertyId);

    @SqlUpdate("DELETE FROM images WHERE id = ?")
    void removeImage(int id);

    @SqlUpdate("UPDATE images SET property_id = ?, url = ? WHERE id = ?")
    void editImage(int propertyId, String url, int id);

    @SqlUpdate("INSERT INTO images (property_id, url) VALUES (?, ?)")
    void addImage(int propertyId, String url);
}