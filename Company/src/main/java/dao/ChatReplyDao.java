package dao;

import java.sql.SQLException;
import java.util.List;

import model.ChatReply;

public interface ChatReplyDao {
	List<ChatReply> getRepliesByMessageId(int messageId) throws SQLException; // 取得特定留言的回覆
    void addReply(ChatReply reply) throws SQLException; // 新增回覆
}
