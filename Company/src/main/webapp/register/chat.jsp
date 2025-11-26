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
    	/* 全頁無 Scrollbar 並維持畫面正常 */
		html, body {
		    height: 100%;
		    overflow: auto;  /* 讓頁面可以滾動 */
		}
		
		/* 隱藏 Chrome / Edge / Safari scrollbar */
		body::-webkit-scrollbar {
		    display: none;
		}
    
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
            z-index: 0;
            top: 0;
            left: 0;
        }

        .container {
            width: 95%;
            max-width: 770px; /* 限制在 iframe 寬度 */
            margin: 20px auto;
            padding: 15px;
            background-color: rgba(0, 0, 0, 0.6);
            border-radius: 12px;
            backdrop-filter: blur(10px);
            box-shadow: 0 0 20px rgba(0, 255, 255, 0.3);
        }

        h2, h3 {
            color: #00ffff;
            margin-top: 10px;
        }

        form {
            background-color: rgba(255, 255, 255, 0.05);
            padding: 8px;
            margin-bottom: 15px;
            border-radius: 8px;
            box-shadow: 0 0 8px rgba(0, 255, 255, 0.1);
        }

        label {
            font-size: 13px;
            display: block;
            margin-top: 5px;
            color: #ddd;
        }

        input[type="text"], textarea {
            width: 100%;
            padding: 4px;
            margin-top: 3px;
            font-size: 13px;
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
            padding: 5px 10px;
            margin-top: 8px;
            font-size: 12px;
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
            table-layout: fixed;
            word-wrap: break-word;
            word-break: break-all;
        }

        th, td {
            border: 1px solid #555;
            padding: 6px;
            text-align: left;
            background-color: rgba(255, 255, 255, 0.05);
            vertical-align: top;
        }

        th {
            background-color: #00cccc;
            color: #000;
        }

        /* 欄位寬度分配 */
        th:nth-child(1), td:nth-child(1) { width: 12%; }
        th:nth-child(2), td:nth-child(2) { width: 18%; }
        th:nth-child(3), td:nth-child(3) { width: 30%; }
        th:nth-child(4), td:nth-child(4) { width: 15%; }
        th:nth-child(5), td:nth-child(5) { width: 25%; }

        /* 回覆樣式 */
        .reply {
            margin-top: 5px;
            padding: 4px;
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

        /* 回覆表單縮小一點 */
        td form input[type="text"] {
            font-size: 12px;
            padding: 3px;
        }
        td form textarea {
            height: 40px;
            font-size: 12px;
        }

        /* ========== 手機 RWD ========= */
        @media (max-width: 600px) {
            table, thead, tbody, th, td, tr {
                display: block;
            }

            thead {
                display: none; /* 隱藏標題列 */
            }

            tr {
                margin-bottom: 12px;
                border: 1px solid #444;
                border-radius: 6px;
                padding: 8px;
                background-color: rgba(255, 255, 255, 0.05);
            }

            td {
                border: none;
                padding: 5px 0;
                font-size: 13px;
            }

            td:before {
                content: attr(data-label);
                font-weight: bold;
                color: #00ffff;
                display: block;
                margin-bottom: 2px;
            }
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
                    <td data-label="留言者"><%= message.getName() %></td>
                    <td data-label="主旨"><%= message.getSubject() %></td>
                    <td data-label="內容"><%= message.getContent() %></td>
                    <td data-label="時間"><%= message.getCreatedAt() %></td>
                    <td data-label="回覆">
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