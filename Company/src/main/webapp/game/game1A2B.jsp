<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>猜數字遊戲 (1A2B)</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            background: linear-gradient(to bottom, #D7EAFB, #FFFFFF); /* 背景漸層 */
            margin: 0;
            padding: 0;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .container {
            max-width: 400px;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 10px;
            background: white;
            box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
        }
        .result, .guesses { 
            margin-top: 20px; 
            text-align: left;
        }
        ul {
            list-style-type: none;
            padding: 0;
        }
        input {
            padding: 5px;
            font-size: 16px;
            width: 80px;
            text-align: center;
        }
        button {
            padding: 5px 10px;
            font-size: 16px;
            cursor: pointer;
            border: none;
            border-radius: 5px;
            background: #4A90E2;
            color: white;
        }
        button:hover {
            background: #357ABD;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>猜數字遊戲 (1A2B)</h1>

        <!-- 開始遊戲按鈕 -->
        <form action="GameServlet1A2B" method="POST">
            <button type="submit" name="action" value="start">開始新遊戲</button>
        </form>

        <!-- 顯示猜測紀錄 -->
        <div class="guesses">
            <h3>猜測紀錄</h3>
            <ul>
                <% 
                    List<String> guesses = (List<String>) session.getAttribute("guesses");
                    if (guesses != null && !guesses.isEmpty()) {
                        for (String guess : guesses) {
                            out.println("<li>" + guess + "</li>");
                        }
                    } else {
                        out.println("<li>尚無猜測紀錄</li>");
                    }
                %>
            </ul>
        </div>

        <!-- 輸入猜測 -->
        <div class="result">
            <h3>輸入你的猜測</h3>
            <form action="GameServlet1A2B" method="POST">
                <input type="text" name="guess" maxlength="4" size="4" placeholder="請輸入4位數字" required pattern="[0-9]{4}">
                <button type="submit" name="action" value="guess">提交猜測</button>
            </form>
        </div>

        <!-- 顯示答案按鈕 -->
        <form action="GameServlet1A2B" method="POST">
            <button type="submit" name="action" value="showAnswer">顯示答案</button>
        </form>
        <% 
            Boolean showAnswer = (Boolean) session.getAttribute("showAnswer");
            if (Boolean.TRUE.equals(showAnswer)) {
                String answer = (String) session.getAttribute("gameNumber");
                out.println("<p>答案: " + answer + "</p>");
            }
        %>
    </div>
</body>
</html>