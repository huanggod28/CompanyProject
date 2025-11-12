package dao.impl;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import dao.ChatMessageDao;
import model.ChatMessage;
import util.DbConnection;

public class ChatMessageDaoImpl implements ChatMessageDao {

    @Override
    public List<ChatMessage> getAllMessages() throws SQLException {
        List<ChatMessage> messages = new ArrayList<>();
        String sql = "SELECT * FROM chat_messages ORDER BY created_at DESC";

        try (Connection conn = DbConnection.getDB();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                ChatMessage msg = new ChatMessage();
                msg.setId(rs.getInt("id"));
                msg.setUserId(rs.getInt("user_id"));
                msg.setName(rs.getString("name"));
                msg.setSubject(rs.getString("subject"));
                msg.setContent(rs.getString("content"));
                msg.setCreatedAt(rs.getTimestamp("created_at"));
                messages.add(msg);
            }
        }

        return messages;
    }

    @Override
    public void addMessage(ChatMessage message) throws SQLException {
        String sql = "INSERT INTO chat_messages (user_id, name, subject, content) VALUES (?, ?, ?, ?)";

        try (Connection conn = DbConnection.getDB();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, message.getUserId());
            stmt.setString(2, message.getName());
            stmt.setString(3, message.getSubject());
            stmt.setString(4, message.getContent());

            int rowsAffected = stmt.executeUpdate();
            System.out.println("Rows affected: " + rowsAffected);
        }
    }
}