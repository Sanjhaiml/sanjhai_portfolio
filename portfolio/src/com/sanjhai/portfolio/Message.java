package com.sanjhai.portfolio;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 * A single contact-form submission.
 */
public class Message {

    private static final DateTimeFormatter STAMP =
        DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    private final String name;
    private final String email;
    private final String subject;
    private final String body;
    private final String receivedAt;

    public Message(String name, String email, String subject, String body) {
        this.name = name;
        this.email = email;
        this.subject = subject;
        this.body = body;
        this.receivedAt = LocalDateTime.now().format(STAMP);
    }

    public String getName() { return name; }
    public String getEmail() { return email; }
    public String getSubject() { return subject; }
    public String getBody() { return body; }
    public String getReceivedAt() { return receivedAt; }

    /** One tab-separated line, safe to append to a flat text "store". */
    public String toStoreLine() {
        String safeBody = body == null ? "" : body.replace("\t", " ").replace("\n", " \\n ");
        String safeSubject = subject == null ? "" : subject.replace("\t", " ");
        return receivedAt + "\t" + name + "\t" + email + "\t" + safeSubject + "\t" + safeBody;
    }
}
