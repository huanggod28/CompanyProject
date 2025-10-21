package model;

import java.sql.Timestamp;

public class Feedback {
    private int id;
    private int userId;
    private String name;
    private String subject;
    private String email;
    private String message;
    private String reply;
    private int replyStatus; // 0 = 未回覆, 1 = 已回覆
    private Timestamp createdAt;

    // Getters & Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getSubject() { return subject; }
    public void setSubject(String subject) { this.subject = subject; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }

    public String getReply() { return reply; }
    public void setReply(String reply) { this.reply = reply; }

    public int getReplyStatus() { return replyStatus; }
    public void setReplyStatus(int replyStatus) { this.replyStatus = replyStatus; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}
