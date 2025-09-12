<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>   
<%@ page import="java.util.List, model.ChatMessage, model.ChatReply" %>
<%
    List<ChatMessage> messages = (List<ChatMessage>) request.getAttribute("messages");
%>
<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <title>留言板</title>
    <script src="https://cdn.jsdelivr.net/particles.js/2.0.0/particles.min.js"></script>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(to right, #0a0a0a, #1a1a1a);
            color: #fff;
        }

        #particles-js {
            position: fixed;
            width: 100%;
            height: 100%;
            z-index: -1;
            top: 0;
            left: 0;
        }

        .container {
            width: 90%;
            max-width: 1000px;
            margin: 40px auto;
            padding: 20px;
            background-color: rgba(0, 0, 0, 0.6);
            border-radius: 12px;
            backdrop-filter: blur(10px);
            box-shadow: 0 0 20px rgba(0, 255, 255, 0.3);
        }

        h2, h3 {
            color: #00ffff;
        }

        form {
            background-color: rgba(255, 255, 255, 0.05);
            padding: 10px;
            margin-bottom: 20px;
            border-radius: 8px;
            box-shadow: 0 0 8px rgba(0, 255, 255, 0.1);
        }

        label {
            font-size: 14px;
            display: block;
            margin-top: 5px;
            color: #ddd;
        }

        input[type="text"], textarea {
            width: 100%;
            padding: 5px;
            margin-top: 3px;
            font-size: 14px;
            border: 1px solid #00ffff;
            border-radius: 4px;
            background-color: rgba(255, 255, 255, 0.1);
            color: #fff;
        }

        textarea {
            resize: none;
            height: 50px;
        }

        input[type="submit"] {
            background-color: #00ffff;
            color: #000;
            border: none;
            padding: 6px 12px;
            margin-top: 10px;
            font-size: 13px;
            border-radius: 4px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #00cccc;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            font-size: 13px;
            margin-top: 10px;
        }

        th, td {
            border: 1px solid #555;
            padding: 8px;
            text-align: left;
            background-color: rgba(255, 255, 255, 0.05);
        }

        th {
            background-color: #00cccc;
            color: #000;
        }

        .reply {
            margin-top: 5px;
            padding: 5px;
            background-color: rgba(0, 255, 255, 0.05);
            border-left: 3px solid #00ffff;
            font-size: 12px;
        }

        .reply b {
            color: #00ffff;
        }

        .reply small {
            color: #999;
        }
    </style>
</head>
<body>

<div id="particles-js"></div>

<div class="container">
    <h2>留言板</h2>

    <h3>新增留言</h3>
    <form action="ChatController" method="post">
        <input type="hidden" name="action" value="addMessage">
        <label>留言者：</label>
        <input type="text" name="name" required>

        <label>主旨：</label>
        <input type="text" name="subject" required>

        <label>內容：</label>
        <textarea name="content" required></textarea>

        <input type="submit" value="送出留言">
    </form>

    <h3>所有留言</h3>
    <table>
        <tr>
            <th>留言者</th>
            <th>主旨</th>
            <th>內容</th>
            <th>時間</th>
            <th>回覆</th>
        </tr>
        <% if (messages != null && !messages.isEmpty()) { %>
            <% for (ChatMessage message : messages) { %>
                <tr>
                    <td><%= message.getName() %></td>
                    <td><%= message.getSubject() %></td>
                    <td><%= message.getContent() %></td>
                    <td><%= message.getCreatedAt() %></td>
                    <td>
                        <% if (message.getReplies() != null) { %>
                            <% for (ChatReply reply : message.getReplies()) { %>
                                <div class="reply">
                                    <b><%= reply.getName() %>:</b> <%= reply.getContent() %><br>
                                    <small><%= reply.getCreatedAt() %></small>
                                </div>
                            <% } %>
                        <% } %>
                        <form action="ChatController" method="post">
                            <input type="hidden" name="action" value="addReply">
                            <input type="hidden" name="messageId" value="<%= message.getId() %>">

                            <label>回覆者：</label>
                            <input type="text" name="name" required>

                            <label>回覆內容：</label>
                            <textarea name="content" required></textarea>

                            <input type="submit" value="回覆">
                        </form>
                    </td>
                </tr>
            <% } %>
        <% } else { %>
            <tr><td colspan="5">目前沒有留言</td></tr>
        <% } %>
    </table>
</div>

<!-- 粒子特效設定 -->
<script>
particlesJS("particles-js", {
    particles: {
        number: { value: 60 },
        color: { value: "#00ffff" },
        shape: { type: "circle" },
        opacity: { value: 0.3 },
        size: { value: 3 },
        line_linked: {
            enable: true,
            distance: 150,
            color: "#00ffff",
            opacity: 0.3,
            width: 1
        },
        move: { enable: true, speed: 2 }
    },
    interactivity: {
        events: { onhover: { enable: true, mode: "grab" } },
        modes: {
            grab: { distance: 200, line_linked: { opacity: 0.5 } }
        }
    },
    retina_detect: true
});
</script>

</body>
</html>