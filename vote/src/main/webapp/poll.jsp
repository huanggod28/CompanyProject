<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8"%>
<%@ page import="dao.impl.PollDAOImpl, dao.impl.PollOptionDAOImpl, model.Poll, model.PollOption, java.util.*" %>
<%
    String token = request.getParameter("token");

    if (token == null) {
        out.println("<h3>Token missing!</h3>");
        return;
    }

    PollDAOImpl pollDAO = new PollDAOImpl();
    PollOptionDAOImpl optionDAO = new PollOptionDAOImpl();
    Poll poll = pollDAO.getPollByAnonymousUrl("VoteServlet?token=" + token);

    if (poll == null) {
        out.println("<h3>無此投票或連結錯誤</h3>");
        return;
    }

    List<PollOption> options = optionDAO.getOptionsByPollId(poll.getId());
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>投票 - <%= poll.getTitle() %></title>
<style>
    body {
        font-family: 'Arial', sans-serif;
        margin: 0;
        padding: 0;
        background: linear-gradient(-45deg, #fbc2eb, #a6c1ee, #fad0c4, #c2e9fb);
        background-size: 400% 400%;
        animation: gradientBG 15s ease infinite;
        color: #333;
        display: flex;
        flex-direction: column;
        align-items: center;
        min-height: 100vh;
    }

    @keyframes gradientBG {
        0% {background-position: 0% 50%;}
        50% {background-position: 100% 50%;}
        100% {background-position: 0% 50%;}
    }

    h2 {
        margin: 20px 0;
        color: #444;
        opacity: 0;
        transform: translateY(-20px);
        animation: fadeIn 1s forwards;
    }

    @keyframes fadeIn {
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    form {
        background: rgba(255,255,255,0.85);
        width: 90%;
        max-width: 500px;
        padding: 25px 30px;
        border-radius: 12px;
        box-shadow: 0 8px 20px rgba(0,0,0,0.1);
        display: flex;
        flex-direction: column;
        align-items: flex-start;
        opacity: 0;
        transform: translateY(20px);
        animation: fadeIn 0.8s forwards;
        animation-delay: 0.3s;
    }

    /* ----------------- 長條選項樣式 ----------------- */
    .poll-option {
        border: 1px solid #ccc;
        border-radius: 8px;
        padding: 12px 15px;
        margin: 6px 0;
        cursor: pointer;
        display: block;
        width: 95%;
        transition: 0.2s;
        user-select: none;
        position: relative;
    }

    .poll-option:hover {
        background-color: #f0f0f0;
    }

    .poll-option input[type="radio"] {
        display: none; /* 隱藏原本 radio */
    }

    .poll-option span {
        display: block;
    }

    .poll-option input[type="radio"]:checked + span {
        background-color: #4caf50;
        color: white;
        padding: 5px 10px;
        border-radius: 5px;
    }

    button {
        padding: 10px 20px;
        border: none;
        border-radius: 8px;
        cursor: pointer;
        background: linear-gradient(135deg, #89f7fe 0%, #66a6ff 100%);
        color: #fff;
        font-size: 16px;
        transition: all 0.3s ease;
        margin-top: 15px;
        width: 100%;
    }

    button:hover {
        transform: translateY(-3px) scale(1.05);
        box-shadow: 0 8px 15px rgba(0,0,0,0.2);
    }

    @media screen and (max-width: 480px) {
        form {
            width: 95%;
            padding: 20px;
        }
    }
</style>
</head>
<body>
<h2><%= poll.getTitle() %></h2>
<form method="post" action="VoteServlet">
    <input type="hidden" name="pollId" value="<%= poll.getId() %>">
    <% for(PollOption o : options) { %>
        <label class="poll-option">
            <input type="radio" name="optionId" value="<%= o.getId() %>" required>
            <span><%= o.getOptionText() %></span>
        </label>
    <% } %>
    <button type="submit">送出投票</button>
</form>
</body>
</html>