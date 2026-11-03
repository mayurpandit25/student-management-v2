package com.school.util;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class DBUtil {

    private static final String URL;
    private static final String USER;
    private static final String PASSWORD;

    static {
        Properties properties = new Properties();

        try (InputStream input = DBUtil.class.getClassLoader()
                .getResourceAsStream("db.properties")) {

            if (input == null) {
                throw new RuntimeException("db.properties not found");
            }

            properties.load(input);

            URL = System.getenv().getOrDefault(
                    "DB_URL", properties.getProperty("db.url"));

            USER = System.getenv().getOrDefault(
                    "DB_USER", properties.getProperty("db.user"));

            PASSWORD = System.getenv().getOrDefault(
                    "DB_PASSWORD", properties.getProperty("db.password"));

            Class.forName("com.mysql.cj.jdbc.Driver");

        } catch (Exception e) {
            throw new ExceptionInInitializerError(e);
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
