<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.Poll, dao.impl.PollOptionDAOImpl, model.PollOption, java.util.*" %>
<%
    Poll poll = (Poll) request.getAttribute("poll");
    if (poll == null && request.getParameter("pollId") != null) {
        int pollId = Integer.parseInt(request.getParameter("pollId"));
        poll = new dao.impl.PollDAOImpl().getPollById(pollId);
    }
    dao.impl.PollOptionDAOImpl optionDAO = new dao.impl.PollOptionDAOImpl();
    List<PollOption> options = optionDAO.getOptionsByPollId(poll.getId());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>投票結果</title>
<style>
    /* ----------------- 背景動畫 ----------------- */
    body {
        font-family: 'Arial', sans-serif;
        margin: 0;
        padding: 0;
        background: linear-gradient(-45deg, #fbc2eb, #a6c1ee, #fad0c4, #c2e9fb);
        background-size: 400% 400%;
        animation: gradientBG 15s ease infinite;
        color: #333;
        min-height: 100vh;
        display: flex;
        flex-direction: column;
        align-items: center;
    }

    @keyframes gradientBG {
        0% {background-position: 0% 50%;}
        50% {background-position: 100% 50%;}
        100% {background-position: 0% 50%;}
    }

    /* ----------------- 標題 ----------------- */
    h3 {
        margin: 20px 0;
        color: #444;
        opacity: 0;
        transform: translateY(-20px);
        animation: fadeIn 1s forwards;
    }

    /* ----------------- 投票結果卡片 ----------------- */
    .option-card {
        background: rgba(255,255,255,0.85);
        width: 90%;
        max-width: 600px;
        padding: 15px 20px;
        margin: 10px 0;
        border-radius: 12px;
        box-shadow: 0 8px 20px rgba(0,0,0,0.1);
        transition: transform 0.3s ease, background 0.3s ease;
        opacity: 0;
        transform: translateY(20px);
        animation: fadeIn 0.8s forwards;
    }

    .option-card:hover {
        transform: translateY(-3px) scale(1.02);
        background: rgba(255,255,255,0.95);
    }

    /* ----------------- 滑入動畫 ----------------- */
    @keyframes fadeIn {
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    /* ----------------- RWD ----------------- */
    @media screen and (max-width: 480px) {
        .option-card {
            padding: 12px 15px;
        }
    }
</style>
</head>
<body>
<h3>投票結果</h3>
<%
int delay = 0;
for(PollOption o : options) {
    delay += 0.2;
%>
<div class="option-card" style="animation-delay: <%=delay%>s;">
    <strong><%=o.getOptionText()%></strong>: <%=o.getVotes()%> 票
</div>
<% } %>
</body>
</html>