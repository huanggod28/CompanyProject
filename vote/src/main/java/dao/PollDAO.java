package dao;

import model.Poll;
import java.util.List;

public interface PollDAO {
	int createPoll(Poll poll);
    Poll getPollById(int id);
    Poll getPollByAnonymousUrl(String url);
    List<Poll> getAllPolls();
    List<Poll> getPollsByUserId(int userId);
    List<Poll> getAllPollsByUser(int userId);
	void updateTotalVotes(Poll poll);
}