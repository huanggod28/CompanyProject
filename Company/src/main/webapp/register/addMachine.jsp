<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Location" %>
<%@ page import="dao.impl.LocationDaoImpl" %>

<%
    Integer Id = (Integer) session.getAttribute("id");
    if (Id == null) {
        response.sendRedirect("VisitorCounterServlet?page=login.jsp");
        return;
    }

    List<Location> locations = new LocationDaoImpl().getLocationsByUserId(Id);
%>

<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <title>新增機台</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
            background: linear-gradient(to right, #0f0f0f, #1a1a1a);
            color: #e0f7fa;
            margin: 0;
            padding: 0;
        }

        h2 {
            text-align: center;
            color: #00e5ff;
            margin-top: 10px;
            font-size: 28px;
        }

        .container {
            width: 90%;
            max-width: 600px;
            margin: 15px auto;
            padding: 25px 30px;
            background-color: rgba(0, 0, 0, 0.65);
            border-radius: 12px;
            box-shadow: 0 0 25px rgba(0, 255, 255, 0.2);
            backdrop-filter: blur(10px);
        }

        label {
            display: block;
            margin-top: 10px;
            color: #b2ebf2;
            font-weight: 500;
        }

        select, input[type="text"] {
            width: 100%;
            padding: 12px;
            margin-top: 8px;
            border-radius: 8px;
            border: 1px solid transparent;
            background-color: rgba(255, 255, 255, 0.1);
            color: #e0f7fa;
            font-size: 16px;
            transition: all 0.2s ease;
        }

        select:focus, input[type="text"]:focus {
            border-color: #00e5ff;
            background-color: rgba(255, 255, 255, 0.15);
            box-shadow: 0 0 8px #00e5ff;
        }

        button {
            margin-top: 30px;
            width: 100%;
            padding: 14px;
            background-color: #00e5ff;
            color: #000;
            border: none;
            border-radius: 8px;
            font-weight: bold;
            font-size: 16px;
            cursor: pointer;
            transition: background 0.3s ease, transform 0.2s;
        }

        button:hover {
            background-color: #00bcd4;
            transform: scale(1.03);
        }

        a {
            display: block;
            text-align: center;
            margin-top: 25px;
            color: #4dd0e1;
            text-decoration: none;
            font-size: 15px;
        }

        a:hover {
            text-decoration: underline;
        }
        
        .container select {
			color: #00b0f0;
			background-color:;
		}
    </style>

    <script>
        function validateInput(inputType) {
            if (inputType === 'camera') {
                document.getElementById('imageUrl').value = '';
            } else if (inputType === 'image') {
                document.getElementById('cameraUrl').value = '';
            }
        }

        function validateForm() {
            let cameraUrl = document.getElementById("cameraUrl").value.trim();
            let imageUrl = document.getElementById("imageUrl").value.trim();

            if (cameraUrl === "" && imageUrl === "") {
                alert("請輸入「監視器連結」或「圖片 URL」其中之一。");
                return false;
            }

            if (cameraUrl !== "" && imageUrl !== "") {
                alert("請只填一項：「監視器連結」或「圖片 URL」。");
                return false;
            }

            return true;
        }
    </script>
</head>
<body>
<div id="particles-js"></div>

<h2>➕ 新增機台</h2>

<div class="container">
    <form action="AddMachineServlet" method="post" onsubmit="return validateForm();">
        <label for="locationId">📍 選擇場地：</label>
        <select id="locationId" name="locationId" required>
            <option value="">請選擇場地</option>
            <% for (Location loc : locations) { %>
                <option value="<%= loc.getId() %>"><%= loc.getName() %></option>
            <% } %>
        </select>

        <label for="machineName">機台名稱：</label>
        <input type="text" id="machineName" name="machineName" required>

        <label for="cameraUrl">監視器連結：</label>
        <input type="text" id="cameraUrl" name="cameraUrl" oninput="validateInput('camera')">

        <label for="imageUrl">圖片 URL：</label>
        <input type="text" id="imageUrl" name="imageUrl" oninput="validateInput('image')">

        <button type="submit">✅ 新增機台</button>
    </form>

    <a href="VisitorCounterServlet?page=register/machineInformation.jsp">⬅ 返回機台資訊</a>
</div>

<script>
particlesJS("particles-js", {
    particles: {
        number: { value: 80 },
        color: { value: "#00ffff" },
        shape: { type: "circle" },
        opacity: { value: 0.35 },
        size: { value: 3 },
        line_linked: {
            enable: true,
            distance: 140,
            color: "#00ffff",
            opacity: 0.3,
            width: 1
        },
        move: { enable: true, speed: 2 }
    },
    interactivity: {
        events: { onhover: { enable: true, mode: "grab" } },
        modes: {
            grab: { distance: 180, line_linked: { opacity: 0.5 } }
        }
    },
    retina_detect: true
});
</script>
</body>
</html>