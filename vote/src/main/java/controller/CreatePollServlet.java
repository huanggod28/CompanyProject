package controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.PollDAO;
import dao.PollOptionDAO;
import dao.impl.PollDAOImpl;
import dao.impl.PollOptionDAOImpl;
import model.Poll;
import model.PollOption;
import model.User;

@WebServlet("/CreatePollServlet")
public class CreatePollServlet extends HttpServlet {
    private PollDAO pollDAO = new PollDAOImpl();
    private PollOptionDAO optionDAO = new PollOptionDAOImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        User user = (User) request.getSession().getAttribute("user");

        // 只要有登入的使用者都可以建立投票
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String title = request.getParameter("title");
        String endDate = request.getParameter("end_time");

        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
            Date endTime = sdf.parse(endDate);

            //建立投票主題
            Poll poll = new Poll();
            poll.setTitle(title);
            poll.setCreatedBy(user.getId());
            poll.setEndTime(new java.sql.Timestamp(endTime.getTime()));

            //自動生成匿名連結
            String token = UUID.randomUUID().toString().replace("-", "");
            poll.setAnonymousUrl("VoteServlet?token=" + token);

            int pollId = pollDAO.createPoll(poll);

            if (pollId > 0) {
                //寫入投票選項
                String[] options = request.getParameterValues("options");
                if (options != null) {
                    for (String opt : options) {
                        if (opt != null && !opt.trim().isEmpty()) {
                            PollOption option = new PollOption();
                            option.setPollId(pollId);
                            option.setOptionText(opt.trim());
                            optionDAO.addOption(option);
                        }
                    }
                }

                //成功後導回投票列表
                if (user.getRole() == 1) {
                    // 管理者看到所有投票
                    response.sendRedirect("AdminPollsServlet");
                } else {
                    // 一般使用者看到自己建立的投票
                    response.sendRedirect("MyPollsServlet");
                }
            } else {
                request.setAttribute("error", "建立投票失敗");
                request.getRequestDispatcher("create_poll.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "時間格式錯誤或其他例外");
            request.getRequestDispatcher("create_poll.jsp").forward(request, response);
        }
    }
}