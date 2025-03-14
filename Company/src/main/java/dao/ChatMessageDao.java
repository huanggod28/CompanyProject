package dao;

import java.sql.SQLException;
import java.util.List;

import model.ChatMessage;

public interface ChatMessageDao {
	List<ChatMessage> getAllMessages() throws SQLException; // 取得所有留言
    void addMessage(ChatMessage message) throws SQLException; // 新增留言
}
