package com.sanjhai.portfolio;

import java.io.File;
import java.io.FileWriter;
import java.io.BufferedWriter;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

/**
 * Persists contact-form messages to a flat file under WEB-INF/data.
 *
 * This is the default data-management strategy for this project because
 * it works immediately after deployment, with no database setup. For a
 * real database instead, see ContactDAO.java and sql/schema.sql, then
 * point ContactServlet at ContactDAO instead of this class \u2014 the rest
 * of the app (contact.jsp, the message count shown there) stays the same.
 */
public class FileMessageStore {

    // Populated once from the web app's real path by ContactServlet / a listener.
    private static volatile String dataFilePath = null;

    public static void init(String webInfPath) {
        File dir = new File(webInfPath, "data");
        if (!dir.exists()) {
            dir.mkdirs();
        }
        dataFilePath = new File(dir, "messages.txt").getAbsolutePath();
    }

    public static synchronized void append(Message message) throws IOException {
        if (dataFilePath == null) {
            throw new IllegalStateException("FileMessageStore.init(webInfPath) was not called yet.");
        }
        BufferedWriter writer = null;
        try {
            writer = new BufferedWriter(new FileWriter(dataFilePath, true));
            writer.write(message.toStoreLine());
            writer.newLine();
        } finally {
            if (writer != null) {
                writer.close();
            }
        }
    }

    /** Number of messages received so far \u2014 shown on the contact page. */
    public static synchronized long count() {
        if (dataFilePath == null) {
            return 0L;
        }
        File file = new File(dataFilePath);
        if (!file.exists()) {
            return 0L;
        }
        long lines = 0L;
        BufferedReader reader = null;
        try {
            reader = new BufferedReader(new FileReader(file));
            while (reader.readLine() != null) {
                lines++;
            }
        } catch (IOException e) {
            return 0L;
        } finally {
            if (reader != null) {
                try { reader.close(); } catch (IOException ignored) { }
            }
        }
        return lines;
    }
}
