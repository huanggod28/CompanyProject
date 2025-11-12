package dao.impl;

import dao.PollOptionDAO;
import model.PollOption;
import util.DbConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class PollOptionDAOImpl implements PollOptionDAO {

    @Override
    public boolean addOption(PollOption option) {
        String sql = "INSERT INTO poll_options(poll_id, option_text) VALUES(?,?)";
        try (Connection conn = DbConnection.getDB();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, option.getPollId());
            ps.setString(2, option.getOptionText());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public List<PollOption> getOptionsByPollId(int pollId) {
        List<PollOption> options = new ArrayList<>();
        String sql = "SELECT * FROM poll_options WHERE poll_id=?";
        try (Connection conn = DbConnection.getDB();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, pollId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                PollOption o = new PollOption();
                o.setId(rs.getInt("id"));
                o.setPollId(rs.getInt("poll_id"));
                o.setOptionText(rs.getString("option_text"));
                o.setVotes(rs.getInt("votes"));
                options.add(o);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return options;
    }

    @Override
    public boolean updateVoteCount(int optionId) {
        String sql = "UPDATE poll_options SET votes = votes + 1 WHERE id=?";
        try (Connection conn = DbConnection.getDB();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, optionId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}