<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.Poll, java.util.List" %>
<%
    List<Poll> polls = (List<Poll>) request.getAttribute("polls");
%>
<html>
<head>
    <title>管理員投票清單</title>
    <link rel="icon" href="https://web.huanggod.myddns.me/vote/pic/voteicon.png" type="image/x-icon">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        /* ----------------- 背景動畫 ----------------- */
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(-45deg, #a1c4fd, #c2e9fb, #fbc2eb, #fad0c4);
            background-size: 400% 400%;
            animation: gradientBG 15s ease infinite;
            color: #333;
        }

        @keyframes gradientBG {
            0% {background-position: 0% 50%;}
            50% {background-position: 100% 50%;}
            100% {background-position: 0% 50%;}
        }

        /* ----------------- 通用樣式 ----------------- */
        h2 {
            text-align: center;
            margin: 20px 0;
            color: #444;
        }

        a {
            text-decoration: none;
            color: #4a90e2;
            transition: all 0.3s ease;
        }

        a:hover {
            color: #d36cae;
            transform: scale(1.05);
        }

        /* ----------------- 按鈕樣式 ----------------- */
        .btn {
            display: inline-block;
            padding: 10px 20px;
            background-color: #89f7fe;
            background-image: linear-gradient(135deg, #89f7fe 0%, #66a6ff 100%);
            color: white;
            border-radius: 8px;
            margin: 10px;
            transition: all 0.3s ease;
        }

        .btn:hover {
            transform: translateY(-3px) scale(1.05);
            box-shadow: 0 8px 15px rgba(0,0,0,0.2);
        }

        /* ----------------- 表格樣式 ----------------- */
        table {
            width: 90%;
            max-width: 1000px;
            margin: 20px auto;
            border-collapse: collapse;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 8px 20px rgba(0,0,0,0.1);
        }

        th, td {
            padding: 12px 15px;
            text-align: center;
            transition: background-color 0.3s ease;
        }

        th {
            background: rgba(255,255,255,0.7);
        }

        tr:nth-child(even) {
            background: rgba(255,255,255,0.5);
        }

        tr:hover {
            background-color: rgba(255, 255, 255, 0.8);
            transform: scale(1.02);
        }

        /* ----------------- 滾動動畫 ----------------- */
        .fade-in {
            opacity: 0;
            transform: translateY(20px);
            transition: all 0.8s ease;
        }

        .fade-in.visible {
            opacity: 1;
            transform: translateY(0);
        }

        /* ----------------- RWD ----------------- */
        @media screen and (max-width: 768px) {
            table, th, td {
                display: block;
                width: 90%;
                margin: 10px auto;
            }

            th {
                display: none;
            }

            td {
                text-align: right;
                padding-left: 50%;
                position: relative;
            }

            td::before {
                content: attr(data-label);
                position: absolute;
                left: 15px;
                font-weight: bold;
                text-align: left;
            }

            .btn {
                width: 80%;
                text-align: center;
                margin: 10px auto;
                display: block;
            }
        }
    </style>
</head>
<body>
    <h2 class="fade-in">所有投票主題</h2>
    <a href="create_poll.jsp" class="btn fade-in">+ 建立新投票</a>
    <table class="fade-in">
        <tr>
            <th>ID</th>
            <th>主題</th>
            <th>截止時間</th>
            <th>匿名連結</th>
        </tr>
        <% if (polls != null) {
            for (Poll p : polls) { %>
                <tr>
                    <td data-label="ID"><%=p.getId()%></td>
                    <td data-label="主題"><%=p.getTitle()%></td>
                    <td data-label="截止時間"><%=p.getEndTime()%></td>
                    <td data-label="匿名連結">
                        <a href="poll.jsp?link=<%=p.getAnonymousUrl()%>" target="_blank">
                            http://localhost:8080/YourApp/poll.jsp?link=<%=p.getAnonymousUrl()%>
                        </a>
                    </td>
                </tr>
        <%  }
        } else { %>
            <tr><td colspan="4">目前沒有投票</td></tr>
        <% } %>
    </table>

    <script>
        // 監聽滾動事件，淡入元素
        const faders = document.querySelectorAll('.fade-in');
        const appearOptions = {
            threshold: 0.2,
            rootMargin: "0px 0px -50px 0px"
        };

        const appearOnScroll = new IntersectionObserver(function(entries, observer){
            entries.forEach(entry => {
                if(entry.isIntersecting){
                    entry.target.classList.add('visible');
                    observer.unobserve(entry.target);
                }
            });
        }, appearOptions);

        faders.forEach(fader => {
            appearOnScroll.observe(fader);
        });
    </script>
</body>
</html>