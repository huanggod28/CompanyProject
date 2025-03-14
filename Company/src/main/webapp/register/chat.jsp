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
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 5px;
            background: #D7EAFB;
            color: #333;
            width: 735px;
            height: 548px;
            overflow: hidden;
        }

        h2 {
            font-size: 16px;
            margin-bottom: 5px;
        }

        h3 {
            font-size: 14px;
            margin: 5px 0;
        }

        .container {
            width: 100%;
            height: 548px;
            overflow-y: auto;
            padding: 5px;
            box-sizing: border-box;
        }

        /* 表單樣式 */
        form {
            background: #fff;
            padding: 5px;
            border-radius: 3px;
            box-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
            margin-bottom: 5px;
        }

        label {
            font-size: 12px;
            font-weight: bold;
        }

        /* 減少輸入框大小 */
        input[type="text"], textarea {
            width: 100%;
            padding: 1px; /* 減少 padding */
            font-size: 14px; /* 減少字型大小 */
            border: 1px solid #ccc;
            border-radius: 2px;
        }

        textarea {
            height: 35px; /* 減少高度 */
            resize: none;
        }

        input[type="submit"] {
            background: #3498db;
            color: white;
            border: none;
            padding: 3px 8px;
            font-size: 12px;
            cursor: pointer;
            border-radius: 2px;
        }

        input[type="submit"]:hover {
            background: #2980b9;
        }

        /* 表格樣式 */
        table {
            width: 100%;
            border-collapse: collapse;
            font-size: 12px;
        }

        table th, table td {
            padding: 3px;
            text-align: left;
            border: 1px solid #ddd;
        }

        table th {
            background: #2980b9;
            color: white;
        }

        table tr:nth-child(even) {
            background: #f2f2f2;
        }

        /* 回覆樣式 */
        .reply {
            margin-left: 5px;
            padding: 3px;
            font-size: 11px;
            background: #ecf0f1;
            border-left: 2px solid #3498db;
        }

        .reply b {
            color: #2980b9;
        }

        .reply small {
            color: #7f8c8d;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>留言板</h2>

        <!-- 新增留言 -->
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

        <hr>

        <!-- 顯示所有留言 -->
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
                            <!-- 顯示回覆 -->
                            <% if (message.getReplies() != null) { %>
                                <% for (ChatReply reply : message.getReplies()) { %>
                                    <div class="reply">
                                        <b><%= reply.getName() %>:</b> <%= reply.getContent() %><br>
                                        <small><%= reply.getCreatedAt() %></small>
                                    </div>
                                <% } %>
                            <% } %>

                            <!-- 回覆留言表單 -->
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
</body>
</html>