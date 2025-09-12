<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <title>註冊帳號</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- 粒子特效 -->
    <script src="https://cdn.jsdelivr.net/particles.js/2.0.0/particles.min.js"></script>
    <style>
        #particles-js {
            position: fixed;
            width: 100%;
            height: 100%;
            z-index: -1;
            top: 0;
            left: 0;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(to right, #0a0a0a, #1a1a1a);
            color: #fff;
            margin: 0;
            padding: 0;
        }

        h2 {
            text-align: center;
            color: #00FFFF;
            margin-top: 50px;
        }

        .container {
            width: 90%;
            max-width: 600px;
            margin: 40px auto;
            padding: 30px;
            background-color: rgba(0, 0, 0, 0.6);
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 255, 255, 0.3);
            backdrop-filter: blur(8px);
        }

        form table {
            width: 100%;
        }

        td {
            padding: 10px;
            font-size: 1em;
            color: #ccc;
        }

        td input[type="text"],
        td input[type="password"],
        td input[type="email"] {
            width: 100%;
            padding: 10px;
            border-radius: 6px;
            border: none;
            background-color: rgba(255, 255, 255, 0.1);
            color: #fff;
            outline: none;
        }

        td input[type="text"]:focus,
        td input[type="password"]:focus,
        td input[type="email"]:focus {
            border: 1px solid #00ffff;
            background-color: rgba(255, 255, 255, 0.2);
        }

        .gender-section {
            display: flex;
            gap: 15px;
            align-items: center;
        }

        td input[type="radio"] {
            margin-right: 5px;
        }

        td input[type="submit"]{
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            font-weight: bold;
            cursor: pointer;
            background-color: #00FFFF;
            color: #000;
            transition: background 0.3s ease, transform 0.2s;
        }
        
        td input[type="reset"] {
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            font-weight: bold;
            cursor: pointer;
            background-color: gray;
            color: #000;
            transition: background 0.3s ease, transform 0.2s;
        }

        td input[type="submit"]:hover {
            background-color: #00cccc;
            transform: scale(1.05); /*字體放大特效*/
        }
        
        td input[type="reset"]:hover {
            background-color: lightgray;
            transform: scale(1.05); /*字體放大特效*/
        }

        td a {
            color: #00FFFF;
            text-decoration: none;
            font-size: 0.95em;
        }

        td a:hover {
            text-decoration: underline;
        }

        .logo {
            width: 150px;
            display: block;
            margin: 0 auto 20px auto;
        }
    </style>
</head>
<body>
<div id="particles-js"></div>

<h2>註冊帳號</h2>

<div class="container">
    <form action="AddRegisterControler" method="post">
        <table>
            <tr>
                <td>姓名：</td>
                <td><input type="text" name="name" required></td>
            </tr>
            <tr>
                <td>帳號：</td>
                <td><input type="text" name="username" required></td>
            </tr>
            <tr>
                <td>密碼：</td>
                <td><input type="password" name="password" required></td>
            </tr>
            <tr>
                <td>電話：</td>
                <td><input type="text" name="phone" required></td>
            </tr>
            <tr>
                <td>信箱：</td>
                <td><input type="email" name="email" required placeholder="example@gmail.com"></td>
            </tr>
            <tr>
                <td>性別：</td>
                <td class="gender-section">
                    <input type="radio" name="gender" value="男">男
                    <input type="radio" name="gender" value="女">女
                </td>
            </tr>
            <tr>
                <td>地址：</td>
                <td><input type="text" name="address" required placeholder="請填寫完整地址"></td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <input type="submit" value="送出" onclick="alert('註冊成功')">
                    <input type="reset" value="重填">
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <a href="VisitorCounterServlet?page=index.jsp">返回登入</a>
                </td>
            </tr>
        </table>
    </form>
</div>

<!-- 粒子特效設定 -->
<script>
particlesJS("particles-js", {
    particles: {
        number: { value: 80 },
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