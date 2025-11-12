package dao;

import model.PollOption;
import java.util.List;

public interface PollOptionDAO {
    boolean addOption(PollOption option);
    List<PollOption> getOptionsByPollId(int pollId);
    boolean updateVoteCount(int optionId);
}