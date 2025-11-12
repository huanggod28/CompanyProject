package dao.impl;

import dao.PollVoteDAO;
import model.PollVote;
import util.DbConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class PollVoteDAOImpl implements PollVoteDAO {

    @Override
    public boolean addVote(PollVote vote) {
        String sql = "INSERT INTO poll_votes(poll_id, user_id, option_id) VALUES(?,?,?)";
        try (Connection conn = DbConnection.getDB();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, vote.getPollId());
            if (vote.getUserId() != null) ps.setInt(2, vote.getUserId());
            else ps.setNull(2, java.sql.Types.INTEGER);
            ps.setInt(3, vote.getOptionId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean hasUserVoted(int pollId, Integer userId) {
        String sql;
        if (userId != null) {
            sql = "SELECT COUNT(*) FROM poll_votes WHERE poll_id=? AND user_id=?";
        } else {
            sql = "SELECT COUNT(*) FROM poll_votes WHERE poll_id=? AND user_id IS NULL";
        }
        try (Connection conn = DbConnection.getDB();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, pollId);
            if (userId != null) ps.setInt(2, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1) > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}