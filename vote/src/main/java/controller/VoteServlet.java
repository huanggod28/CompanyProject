package controller;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.PollDAO;
import dao.PollOptionDAO;
import dao.PollVoteDAO;
import dao.impl.PollDAOImpl;
import dao.impl.PollOptionDAOImpl;
import dao.impl.PollVoteDAOImpl;
import model.Poll;
import model.PollVote;
import model.User;

@WebServlet("/VoteServlet")
public class VoteServlet extends HttpServlet {
    private PollOptionDAO optionDAO = new PollOptionDAOImpl();
    private PollVoteDAO voteDAO = new PollVoteDAOImpl();
    private PollDAO pollDAO = new PollDAOImpl();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int optionId = Integer.parseInt(request.getParameter("optionId"));
        int pollId = Integer.parseInt(request.getParameter("pollId"));

        User user = (User) request.getSession().getAttribute("user");
        Integer userId = (user != null) ? user.getId() : null;

        if (!voteDAO.hasUserVoted(pollId, userId)) {
            PollVote vote = new PollVote();
            vote.setPollId(pollId);
            vote.setUserId(userId);
            vote.setOptionId(optionId);
            voteDAO.addVote(vote);

            // 更新該選項的票數
            optionDAO.updateVoteCount(optionId);

            // 更新 Poll 的 total_votes
            Poll poll = pollDAO.getPollById(pollId);
            if (poll != null) {
                poll.setTotalVotes(poll.getTotalVotes() + 1);
                pollDAO.updateTotalVotes(poll);
            }
        }

        response.sendRedirect("poll_result.jsp?pollId=" + pollId);
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String token = request.getParameter("token");
        if (token == null || token.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "缺少投票 token");
            return;
        }

        // 根據 token 取得對應投票
        Poll poll = pollDAO.getPollByAnonymousUrl("VoteServlet?token=" + token);
        if (poll == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "投票不存在");
            return;
        }

        request.setAttribute("poll", poll);
        request.getRequestDispatcher("poll.jsp").forward(request, response);
    }
}