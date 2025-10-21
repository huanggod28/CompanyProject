package dao;

import java.util.List;
import model.Feedback;

public interface FeedbackDao {
    void insert(Feedback feedback);
    List<Feedback> findByUserId(int userId);
    List<Feedback> findAll();
    void updateReply(int id, String reply, int replyStatus);
    void toggleReplyStatus(int id, int newStatus);
}