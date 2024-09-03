package com.svalero.dao;

import org.jdbi.v3.core.Handle;
import org.jdbi.v3.core.Jdbi;
import org.jdbi.v3.sqlobject.SqlObjectPlugin;

import static com.svalero.util.Constants.*;

import java.sql.SQLException;

public class Database {
    public static Jdbi jdbi;
    public static Handle db;

    public static void connect() throws ClassNotFoundException, SQLException {
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        

        jdbi = Jdbi.create(CONNECTION_STRING, USERNAME, PASSWORD);
        jdbi.installPlugin(new SqlObjectPlugin());
        db = jdbi.open();

        db.execute("USE " + DATABASE);
    }

    public void close() throws SQLException {
        db.close();
    }
}