package dao;

import model.PollVote;

public interface PollVoteDAO {
    boolean addVote(PollVote vote);
    boolean hasUserVoted(int pollId, Integer userId); // userId 可為 null
    public boolean hasTokenVoted(int pollId, String token);
}