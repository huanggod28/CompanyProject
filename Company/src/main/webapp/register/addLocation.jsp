<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Location" %>
<%@ page import="dao.impl.LocationDaoImpl" %>
<%
    Integer Id = (Integer) session.getAttribute("id");
    if (Id == null) {
        response.sendRedirect("VisitorCounterServlet?page=login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <title>新增場地 | 智能娃娃機監控</title>
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background: #0f111a;
            color: #00bcd4;
            overflow: hidden;
        }
        
        .container, .bottom {
		    position: relative;
		    z-index: 1; /* 蓋在粒子上方，但滑鼠事件還是會先到粒子 */
		}

        #particles-js {
            position: fixed;
            width: 100%;
            height: 100%;
            z-index: 0;
        }

        .container {
            max-width: 500px;
            margin: 100px auto;
            background-color: rgba(0, 0, 0, 0.8);
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 0 20px rgba(0, 188, 212, 0.6);
        }

        h2 {
            text-align: center;
            color: #00e5ff;
            margin-bottom: 30px;
        }

        label {
            display: block;
            margin-top: 15px;
            margin-bottom: 5px;
            color: #b2ebf2;
        }

        input[type="text"] {
            width: 100%;
            padding: 12px;
            border: none;
            border-radius: 8px;
            background-color: #1c1e2a;
            color: #00e5ff;
            font-size: 16px;
            outline: none;
        }

        input[type="text"]:focus {
            box-shadow: 0 0 10px #00e5ff;
        }

        button {
            margin-top: 20px;
            width: 100%;
            padding: 12px;
            background-color: #00bcd4;
            border: none;
            border-radius: 8px;
            color: #fff;
            font-size: 18px;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        button:hover {
            background-color: #0097a7;
        }

        a {
            display: block;
            text-align: center;
            margin-top: 20px;
            color: #4dd0e1;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div id="particles-js"></div>

    <div class="container">
        <h2>➕ 新增場地</h2>
        <form action="AddLocationServlet" method="post">
            <label for="name">場地名稱：</label>
            <input type="text" id="name" name="name" required>

            <label for="address">場地地址：</label>
            <input type="text" id="address" name="address" required>

            <button type="submit">✅ 新增場地</button>
        </form>
        <a href="VisitorCounterServlet?page=register/machineInformation.jsp">⬅ 返回機台資訊</a>
    </div>

    <!-- 粒子動畫 script -->
    <script src="https://cdn.jsdelivr.net/npm/particles.js@2.0.0/particles.min.js"></script>
    <script>
        particlesJS("particles-js", {
            particles: {
                number: { value: 60 },
                color: { value: "#00bcd4" },
                shape: { type: "circle" },
                opacity: { value: 0.6 },
                size: { value: 3 },
                line_linked: {
                    enable: true,
                    distance: 150,
                    color: "#00e5ff",
                    opacity: 0.4,
                    width: 1
                },
                move: {
                    enable: true,
                    speed: 2,
                    direction: "none",
                    out_mode: "out"
                }
            },
            interactivity: {
                events: {
                    onhover: { enable: true, mode: "repulse" },
                    onclick: { enable: true, mode: "push" }
                },
                modes: {
                    repulse: { distance: 100 },
                    push: { particles_nb: 4 }
                }
            },
            retina_detect: true
        });
    </script>
</body>
</html>