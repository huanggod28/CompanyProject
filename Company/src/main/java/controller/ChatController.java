package controller;

import dao.ChatMessageDao;
import dao.ChatReplyDao;
import dao.impl.ChatMessageDaoImpl;
import dao.impl.ChatReplyDaoImpl;
import model.ChatMessage;
import model.ChatReply;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/ChatController")
public class ChatController extends HttpServlet {
    private ChatMessageDao messageDao = new ChatMessageDaoImpl();
    private ChatReplyDao replyDao = new ChatReplyDaoImpl();

    // 處理 GET 請求，顯示留言板內容
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 取得所有留言
        List<ChatMessage> messages = null;
        try {
            messages = messageDao.getAllMessages(); // 從資料庫獲取留言
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // 取得每則留言的回覆
        for (ChatMessage message : messages) {
            List<ChatReply> replies = null;
            try {
                replies = replyDao.getRepliesByMessageId(message.getId()); // 根據留言ID查詢回覆
            } catch (SQLException e) {
                e.printStackTrace();
            }
            message.setReplies(replies); // 設定留言的回覆
        }

        // 把留言列表傳遞到 JSP
        request.setAttribute("messages", messages);
        request.getRequestDispatcher("VisitorCounterServlet?page=register/chat.jsp").forward(request, response);
    }

    // 處理 POST 請求，新增留言和回覆
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("addMessage".equals(action)) { // 新增留言
            String name = request.getParameter("name");
            String subject = request.getParameter("subject");
            String content = request.getParameter("content");
            
            Integer userId = (Integer) request.getSession().getAttribute("userId");
            if (userId == null) {
                userId = 0; // 預設為 0，若沒有登入的情況
            }

            ChatMessage message = new ChatMessage();
            message.setName(name);
            message.setSubject(subject);
            message.setContent(content);
            message.setUserId(userId); // 設置 userId
            System.out.println("Message to insert: " + message);
            try {
                messageDao.addMessage(message); // 存入資料庫
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } 
        else if ("addReply".equals(action)) { // 回覆留言
            int messageId = Integer.parseInt(request.getParameter("messageId"));
            String name = request.getParameter("name");
            String content = request.getParameter("content");

            Integer userId = (Integer) request.getSession().getAttribute("userId");
            if (userId == null) {
                userId = 0; // 預設為 0，若沒有登入的情況
            }

            ChatReply reply = new ChatReply();
            reply.setMessageId(messageId);
            reply.setName(name);
            reply.setContent(content);
            reply.setUserId(userId); // 設置 userId

            try {
                replyDao.addReply(reply); // 存入資料庫
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        // 新增留言或回覆後，重定向到留言板頁面
        response.sendRedirect("ChatController");
    }
}