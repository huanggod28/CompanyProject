package dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dao.ChatReplyDao;
import dao.DbConnection;
import model.ChatReply;

public class ChatReplyDaoImpl implements ChatReplyDao {
    private static Connection conn = DbConnection.getDB(); // 取得資料庫連線

    @Override
    public List<ChatReply> getRepliesByMessageId(int messageId) throws SQLException {
        List<ChatReply> replies = new ArrayList<>();
        String sql = "SELECT * FROM chat_replies WHERE message_id = ? ORDER BY created_at ASC";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, messageId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                ChatReply reply = new ChatReply();
                reply.setId(rs.getInt("id"));
                reply.setMessageId(rs.getInt("message_id"));
                reply.setUserId(rs.getInt("user_id"));
                reply.setName(rs.getString("name"));
                reply.setContent(rs.getString("content"));
                reply.setCreatedAt(rs.getTimestamp("created_at"));
                replies.add(reply);
            }
        }
        return replies;
    }

    @Override
    public void addReply(ChatReply reply) throws SQLException {
        String sql = "INSERT INTO chat_replies (message_id, user_id, name, content) VALUES (?, ?, ?, ?)";
        
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, reply.getMessageId());
            stmt.setInt(2, reply.getUserId());
            stmt.setString(3, reply.getName());
            stmt.setString(4, reply.getContent());
            stmt.executeUpdate();
        }
    }
}