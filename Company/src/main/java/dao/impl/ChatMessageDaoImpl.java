package dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dao.ChatMessageDao;
import dao.DbConnection;
import model.ChatMessage;

public class ChatMessageDaoImpl implements ChatMessageDao {
    private static Connection conn = DbConnection.getDB(); // 取得資料庫連線

    @Override
    public List<ChatMessage> getAllMessages() throws SQLException {
        List<ChatMessage> messages = new ArrayList<>();
        String sql = "SELECT * FROM chat_messages ORDER BY created_at DESC";
        
        try (PreparedStatement stmt = conn.prepareStatement(sql);
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
        
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            System.out.println("Preparing to insert message: " + message);
            stmt.setInt(1, message.getUserId());
            stmt.setString(2, message.getName());
            stmt.setString(3, message.getSubject());
            stmt.setString(4, message.getContent());
            int rowsAffected = stmt.executeUpdate();
            System.out.println("Rows affected: " + rowsAffected);
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;  // 可以在這裡拋出或處理錯誤
        }
    }
}