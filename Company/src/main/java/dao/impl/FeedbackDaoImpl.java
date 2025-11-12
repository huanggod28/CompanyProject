package dao.impl;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import dao.FeedbackDao;
import model.Feedback;
import util.DbConnection;

public class FeedbackDaoImpl implements FeedbackDao {

    @Override
    public void insert(Feedback f) {
        String sql = "INSERT INTO feedback (user_id, name, subject, email, message) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DbConnection.getDB();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, f.getUserId());
            ps.setString(2, f.getName());
            ps.setString(3, f.getSubject());
            ps.setString(4, f.getEmail());
            ps.setString(5, f.getMessage());
            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<Feedback> findByUserId(int userId) {
        List<Feedback> list = new ArrayList<>();
        String sql = "SELECT * FROM feedback WHERE user_id = ? ORDER BY created_at DESC";

        try (Connection conn = DbConnection.getDB();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(extractFeedback(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    @Override
    public List<Feedback> findAll() {
        List<Feedback> list = new ArrayList<>();
        String sql = "SELECT * FROM feedback ORDER BY created_at DESC";

        try (Connection conn = DbConnection.getDB();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            while (rs.next()) {
                list.add(extractFeedback(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    @Override
    public void updateReply(int id, String reply, int replyStatus) {
        String sql = "UPDATE feedback SET reply = ?, reply_status = ? WHERE id = ?";

        try (Connection conn = DbConnection.getDB();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, reply);
            ps.setInt(2, replyStatus);
            ps.setInt(3, id);
            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void toggleReplyStatus(int id, int newStatus) {
        String sql = "UPDATE feedback SET reply_status = ? WHERE id = ?";

        try (Connection conn = DbConnection.getDB();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, newStatus);
            ps.setInt(2, id);
            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private Feedback extractFeedback(ResultSet rs) throws SQLException {
        Feedback f = new Feedback();
        f.setId(rs.getInt("id"));
        f.setUserId(rs.getInt("user_id"));
        f.setName(rs.getString("name"));
        f.setSubject(rs.getString("subject"));
        f.setEmail(rs.getString("email"));
        f.setMessage(rs.getString("message"));
        f.setReply(rs.getString("reply"));
        f.setReplyStatus(rs.getInt("reply_status"));
        f.setCreatedAt(rs.getTimestamp("created_at"));
        return f;
    }
}