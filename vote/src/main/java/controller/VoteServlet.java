package controller;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
    private PollDAO pollDAO = new PollDAOImpl();
    private PollOptionDAO optionDAO = new PollOptionDAOImpl();
    private PollVoteDAO voteDAO = new PollVoteDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String token = request.getParameter("token");
        if (token == null || token.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "缺少投票 token");
            return;
        }

        // 取得投票主題
        Poll poll = pollDAO.getPollByAnonymousUrl("VoteServlet?token=" + token);
        if (poll == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "投票不存在");
            return;
        }

        //檢查是否截止
        Timestamp now = new Timestamp(System.currentTimeMillis());
        boolean isClosed = poll.getEndTime() != null && now.after(poll.getEndTime());

        //取得使用者／cookie token
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        Integer userId = (user != null) ? user.getId() : null;
        String voterToken = getOrCreateVoterToken(request, response);

        //檢查是否已投
        boolean hasVoted = (userId != null)
                ? voteDAO.hasUserVoted(poll.getId(), userId)
                : voteDAO.hasTokenVoted(poll.getId(), voterToken);

        //根據狀況決定要去哪個頁面
        if (isClosed || hasVoted) {
            // 顯示結果頁
            request.setAttribute("poll", poll);
            request.getRequestDispatcher("poll_result.jsp").forward(request, response);
        } else {
            // 顯示投票表單
            request.setAttribute("poll", poll);
            request.getRequestDispatcher("poll.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int optionId = Integer.parseInt(request.getParameter("optionId"));
        int pollId = Integer.parseInt(request.getParameter("pollId"));

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        Integer userId = (user != null) ? user.getId() : null;
        String voterToken = getOrCreateVoterToken(request, response);

        // 檢查是否已投票
        boolean hasVoted = (userId != null)
                ? voteDAO.hasUserVoted(pollId, userId)
                : voteDAO.hasTokenVoted(pollId, voterToken);

        if (!hasVoted) {
            PollVote vote = new PollVote();
            vote.setPollId(pollId);
            vote.setOptionId(optionId);
            vote.setUserId(userId);
            vote.setVoterToken(voterToken);

            voteDAO.addVote(vote);
            optionDAO.updateVoteCount(optionId);
            pollDAO.incrementTotalVotes(pollId); //更新總投票數
        }

        response.sendRedirect("poll_result.jsp?pollId=" + pollId);
    }

    /** 若不存在 voterToken 則建立 Cookie */
    private String getOrCreateVoterToken(HttpServletRequest request, HttpServletResponse response) {
        String token = null;
        if (request.getCookies() != null) {
            for (Cookie c : request.getCookies()) {
                if ("voterToken".equals(c.getName())) {
                    token = c.getValue();
                    break;
                }
            }
        }
        if (token == null) {
            token = UUID.randomUUID().toString();
            Cookie newCookie = new Cookie("voterToken", token);
            newCookie.setMaxAge(60 * 60 * 24 * 365); // 保存一年
            response.addCookie(newCookie);
        }
        return token;
    }
}