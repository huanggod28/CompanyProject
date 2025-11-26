<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-TW">
<head>
<meta charset="UTF-8">
<title>意見回復表單</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://cdn.jsdelivr.net/particles.js/2.0.0/particles.min.js"></script>
<style>
/* 防止內距造成元素超出邊界 */
*, *::before, *::after {
    box-sizing: border-box;
}

html, body {
    margin: 0;
    padding: 0;
    height: 100%;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background: radial-gradient(circle at top, #0a0f1a, #000);
    color: #fff;
    overflow: auto;  /* 讓頁面可以滾動 */
}

/* 隱藏 Chrome / Edge / Safari scrollbar */
body::-webkit-scrollbar {
	display: none;
}

/* 背景粒子層 */
#particles-js {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    z-index: 0;
}

/* 標題 */
h2, h3 {
    text-align: center;
    color: #00FFFF;
    text-shadow: 0 0 8px #00FFFF;
    margin-top: 25px;
}

/* 主要容器（放在770px main中） */
.container {
    width: 100%;
    max-width: 740px;
    margin: 20px auto;
    padding: 25px;
    background: rgba(0, 0, 0, 0.6);
    border-radius: 15px;
    box-shadow: 0 0 20px rgba(0, 255, 255, 0.25);
    backdrop-filter: blur(8px);
    position: relative;
    z-index: 1;
}

/* 表單 */
form {
    display: flex;
    flex-direction: column;
    gap: 15px;
}

label {
    font-weight: bold;
    color: #00ffff;
    font-size: 16px;
}

/* 調整輸入欄避免超出邊框 */
input[type="text"],
input[type="email"],
textarea {
    width: 100%;
    max-width: 100%; /* 防止 padding overflow */
    padding: 10px 12px;
    background-color: rgba(255, 255, 255, 0.08);
    border: 1px solid rgba(0, 255, 255, 0.3);
    border-radius: 8px;
    color: #fff;
    outline: none;
    font-size: 16px;
    transition: all 0.3s ease;
}

input:focus, textarea:focus {
    border-color: #00FFFF;
    box-shadow: 0 0 8px #00FFFF;
    background-color: rgba(255, 255, 255, 0.15);
}

textarea {
    resize: vertical;
    min-height: 110px;
}

/* 按鈕 */
button {
    width: 130px;
    align-self: flex-end;
    padding: 10px 15px;
    border: none;
    border-radius: 8px;
    background-color: #00FFFF;
    color: #000;
    font-weight: bold;
    font-size: 15px;
    cursor: pointer;
    transition: 0.3s;
}

button:hover {
    background-color: #00cccc;
    transform: scale(1.05);
    box-shadow: 0 0 10px #00ffff;
}

/* 表格區 */
table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
    color: #fff;
    font-size: 14px;
    table-layout: fixed;
    word-wrap: break-word;
}

th, td {
    padding: 8px;
    text-align: center;
    border: 1px solid rgba(0, 255, 255, 0.3);
}

th {
    background-color: rgba(0, 255, 255, 0.2);
    color: #00FFFF;
    text-shadow: 0 0 4px #00FFFF;
}

tr:nth-child(even) {
    background-color: rgba(255, 255, 255, 0.05);
}

tr:hover {
    background-color: rgba(0, 255, 255, 0.1);
}

/* RWD設定（手機平板） */
@media (max-width: 768px) {
    .container {
        padding: 18px;
        margin: 10px;
    }

    h2, h3 {
        font-size: 20px;
    }

    input[type="text"],
    input[type="email"],
    textarea {
        font-size: 15px;
    }

    button {
        width: 100%;
        font-size: 16px;
        padding: 12px;
    }

    table {
        font-size: 13px;
    }
}

@media (max-width: 480px) {
    h2, h3 {
        font-size: 18px;
    }
    input[type="text"],
    input[type="email"],
    textarea {
        font-size: 14px;
    }
    button {
        font-size: 15px;
    }
}
</style>
</head>
<body>
<div id="particles-js"></div>

<h2>意見回復表單</h2>

<div class="container">
    <form action="FeedbackSubmitServlet" method="post">
        <label>暱稱：</label>
        <input type="text" name="name" required>

        <label>主旨：</label>
        <input type="text" name="subject" required>

        <label>信箱：</label>
        <input type="email" name="email" required>

        <label>意見說明 (500字內)：</label>
        <textarea name="message" maxlength="500" required></textarea>

        <button type="submit">送出</button>
    </form>

    <h3>我送出的意見</h3>
    <table>
        <tr>
            <th>主旨</th>
            <th>內容</th>
            <th>回覆</th>
            <th>狀態</th>
        </tr>
        <c:forEach var="f" items="${feedbackList}">
            <tr>
                <td>${f.subject}</td>
                <td>${f.message}</td>
                <td>${f.reply}</td>
                <td>
                    <c:choose>
                        <c:when test="${f.replyStatus == 1}">
                            <span style="color:#00ffff;">已回覆</span>
                        </c:when>
                        <c:otherwise>
                            <span style="color:#ff7777;">未回覆</span>
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>

<script>
particlesJS("particles-js", {
  "particles": {
    "number": { "value": 60 },
    "color": { "value": "#00ffff" },
    "shape": { "type": "circle" },
    "opacity": { "value": 0.3 },
    "size": { "value": 3 },
    "line_linked": {
      "enable": true,
      "distance": 150,
      "color": "#00ffff",
      "opacity": 0.4,
      "width": 1
    },
    "move": {
      "enable": true,
      "speed": 2,
      "direction": "none",
      "out_mode": "bounce"
    }
  },
  "interactivity": {
    "events": {
      "onhover": { "enable": true, "mode": "repulse" },
      "onclick": { "enable": true, "mode": "push" }
    },
    "modes": {
      "repulse": { "distance": 100 },
      "push": { "particles_nb": 4 }
    }
  },
  "retina_detect": true
});
</script>

</body>
</html>