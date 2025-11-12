package dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import dao.PollDAO;
import model.Poll;
import util.DbConnection;

public class PollDAOImpl implements PollDAO {

	@Override
	public int createPoll(Poll poll) {
	    String sql = "INSERT INTO polls(title, created_by, anonymous_url, end_time, total_votes) VALUES(?,?,?,?,0)";
	    int pollId = -1;
	    try (Connection conn = DbConnection.getDB();
	         PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

	        // 生成匿名投票連結
	        String uuid = java.util.UUID.randomUUID().toString().replace("-", "");
	        String anonymousUrl = "VoteServlet?token=" + uuid;
	        poll.setAnonymousUrl(anonymousUrl);

	        System.out.println("DEBUG createPoll: title=" + poll.getTitle() + ", created_by=" + poll.getCreatedBy() + ", endTime=" + poll.getEndTime());

	        ps.setString(1, poll.getTitle());
	        ps.setInt(2, poll.getCreatedBy());
	        ps.setString(3, poll.getAnonymousUrl());
	        ps.setTimestamp(4, poll.getEndTime() != null ? new java.sql.Timestamp(poll.getEndTime().getTime()) : null);

	        int affectedRows = ps.executeUpdate();
	        if (affectedRows == 0) {
	            System.out.println("DEBUG createPoll: insert failed, affectedRows=0");
	            return -1;
	        }

	        ResultSet rs = ps.getGeneratedKeys();
	        if (rs.next()) {
	            pollId = rs.getInt(1);
	        } else {
	            System.out.println("DEBUG createPoll: no generated key returned");
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return pollId;
	}

	@Override
	public Poll getPollById(int id) {
	    String sql = "SELECT * FROM polls WHERE id = ?";
	    try (Connection conn = DbConnection.getDB();
	         PreparedStatement ps = conn.prepareStatement(sql)) {

	        ps.setInt(1, id);
	        ResultSet rs = ps.executeQuery();

	        if (rs.next()) {
	            Poll poll = new Poll();
	            poll.setId(rs.getInt("id"));
	            poll.setTitle(rs.getString("title"));
	            poll.setCreatedBy(rs.getInt("created_by"));
	            poll.setAnonymousUrl(rs.getString("anonymous_url"));
	            poll.setEndTime(rs.getTimestamp("end_time"));
	            poll.setCreatedAt(rs.getTimestamp("created_at"));
	            poll.setTotalVotes(rs.getInt("total_votes"));
	            return poll;
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return null;
	}

	@Override
	public Poll getPollByAnonymousUrl(String url) {
	    String sql = "SELECT * FROM polls WHERE anonymous_url = ?";
	    try (Connection conn = DbConnection.getDB();
	         PreparedStatement ps = conn.prepareStatement(sql)) {

	        ps.setString(1, url);
	        ResultSet rs = ps.executeQuery();

	        if (rs.next()) {
	            Poll poll = new Poll();
	            poll.setId(rs.getInt("id"));
	            poll.setTitle(rs.getString("title"));
	            poll.setCreatedBy(rs.getInt("created_by"));
	            poll.setAnonymousUrl(rs.getString("anonymous_url"));
	            poll.setEndTime(rs.getTimestamp("end_time"));
	            poll.setCreatedAt(rs.getTimestamp("created_at"));
	            poll.setTotalVotes(rs.getInt("total_votes"));
	            return poll;
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return null;
	}

	@Override
	public List<Poll> getAllPollsByUser(int userId) {
	    String sql = "SELECT * FROM polls WHERE created_by = ? ORDER BY created_at DESC";
	    List<Poll> polls = new ArrayList<>();
	    try (Connection conn = DbConnection.getDB();
	         PreparedStatement ps = conn.prepareStatement(sql)) {

	        ps.setInt(1, userId);
	        ResultSet rs = ps.executeQuery();

	        while (rs.next()) {
	            Poll poll = new Poll();
	            poll.setId(rs.getInt("id"));
	            poll.setTitle(rs.getString("title"));
	            poll.setCreatedBy(rs.getInt("created_by"));
	            poll.setAnonymousUrl(rs.getString("anonymous_url"));
	            poll.setEndTime(rs.getTimestamp("end_time"));
	            poll.setCreatedAt(rs.getTimestamp("created_at"));
	            poll.setTotalVotes(rs.getInt("total_votes"));
	            polls.add(poll);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return polls;
	}

	@Override
	public List<Poll> getAllPolls() {
	    String sql = "SELECT * FROM polls ORDER BY created_at DESC";
	    List<Poll> polls = new ArrayList<>();
	    try (Connection conn = DbConnection.getDB();
	         PreparedStatement ps = conn.prepareStatement(sql)) {

	        ResultSet rs = ps.executeQuery();
	        while (rs.next()) {
	            Poll poll = new Poll();
	            poll.setId(rs.getInt("id"));
	            poll.setTitle(rs.getString("title"));
	            poll.setCreatedBy(rs.getInt("created_by"));
	            poll.setAnonymousUrl(rs.getString("anonymous_url"));
	            poll.setEndTime(rs.getTimestamp("end_time"));
	            poll.setCreatedAt(rs.getTimestamp("created_at"));
	            poll.setTotalVotes(rs.getInt("total_votes"));
	            polls.add(poll);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return polls;
	}
	
	@Override
    public List<Poll> getPollsByUserId(int userId) {
        List<Poll> list = new ArrayList<>();
        String sql = "SELECT * FROM polls WHERE created_by = ? ORDER BY created_at DESC";
        try (Connection conn = DbConnection.getDB();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Poll poll = new Poll();
                poll.setId(rs.getInt("id"));
                poll.setTitle(rs.getString("title"));
                poll.setEndTime(rs.getTimestamp("end_time"));
                poll.setTotalVotes(rs.getInt("total_votes"));
                poll.setAnonymousUrl(rs.getString("anonymous_url"));
                poll.setCreatedAt(rs.getTimestamp("created_at"));
                list.add(poll);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
	
	public void updateTotalVotes(Poll poll) {
	    String sql = "UPDATE polls SET total_votes = ? WHERE id = ?";
	    try (Connection conn = DbConnection.getDB();
	         PreparedStatement ps = conn.prepareStatement(sql)) {
	        ps.setInt(1, poll.getTotalVotes());
	        ps.setInt(2, poll.getId());
	        ps.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}
}