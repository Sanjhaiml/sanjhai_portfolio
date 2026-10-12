package com.sanjhai.portfolio;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * OPTIONAL data-access class for storing contact messages in MySQL
 * instead of the flat file used by FileMessageStore.
 *
 * Not wired up by default \u2014 ContactServlet uses FileMessageStore so the
 * project runs with zero extra setup. To switch to a real database:
 *
 *   1. Create the schema in sql/schema.sql (run it in MySQL).
 *   2. Drop the MySQL Connector/J jar into WEB-INF/lib.
 *   3. Fill in DB_URL / DB_USER / DB_PASSWORD below.
 *   4. In ContactServlet, replace the FileMessageStore.append(message)
 *      call with ContactDAO.save(message), and FileMessageStore.count()
 *      with ContactDAO.count().
 */
public class ContactDAO {

    private static final String DB_URL  = "jdbc:mysql://localhost:3306/portfolio_db";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    public static void save(Message message) throws SQLException {
        String sql = "INSERT INTO contact_messages (name, email, subject, body, received_at) " +
                     "VALUES (?, ?, ?, ?, NOW())";
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, message.getName());
            stmt.setString(2, message.getEmail());
            stmt.setString(3, message.getSubject());
            stmt.setString(4, message.getBody());
            stmt.executeUpdate();
        } finally {
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        }
    }

    public static long count() throws SQLException {
        String sql = "SELECT COUNT(*) FROM contact_messages";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            return rs.next() ? rs.getLong(1) : 0L;
        } finally {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        }
    }
}
