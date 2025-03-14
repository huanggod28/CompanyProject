<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <title>聯絡我們</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f9;
        }

        /* 設置頁面容器寬度100%，並設置最大寬度以避免過寬 */
        .container {
            width: 100%;
            max-width: 800px; /* 最大寬度控制 */
            margin: 0 auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            box-sizing: border-box; /* 確保容器內的元素不會超過容器邊界 */
        }

        h1 {
            text-align: center;
            color: #3498db;
            font-size: 24px;
            margin-bottom: 20px;
        }

        .contact-info {
            margin-bottom: 30px;
        }

        .contact-info h2 {
            font-size: 18px;
            color: #333;
            margin-bottom: 10px;
        }

        .contact-info p {
            font-size: 14px;
            color: #555;
            line-height: 1.6;
        }

        .footer {
            text-align: center;
            margin-top: 30px;
            font-size: 12px;
            color: #888;
        }

        /* 在小於768px的螢幕上，設置容器寬度為100% */
        @media (max-width: 768px) {
            .container {
                max-width: 100%;
                padding: 10px;
            }
        }
    </style>
</head>
<body>

<div class="container">
    <h1>聯絡我們</h1>
    
    <!-- 聯絡資訊 -->
    <div class="contact-info">
        <h2>我們的聯絡方式</h2>
        <p><strong>單位：</strong>致理科大夜資三A第二組</p>
        <p><strong>地址：</strong>新北市板橋區文化路313號</p>
        <p><strong>電話：</strong>(02) 1234-5678</p>
        <p><strong>電子郵件：</strong>61110125@example.com</p>
    </div>
</div>

<div class="footer">
    <p>© 2025 致理科大夜資三A第二組 - 所有權利保留</p>
</div>

</body>
</html>