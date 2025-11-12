package model;

import java.util.Date;

public class PollVote {
	private int id;
	private int pollId;
	private Integer userId; // 可為 null
	private int optionId;
	private Date votedAt;

	// getters & setters
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getPollId() {
		return pollId;
	}

	public void setPollId(int pollId) {
		this.pollId = pollId;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public int getOptionId() {
		return optionId;
	}

	public void setOptionId(int optionId) {
		this.optionId = optionId;
	}

	public Date getVotedAt() {
		return votedAt;
	}

	public void setVotedAt(Date votedAt) {
		this.votedAt = votedAt;
	}
}