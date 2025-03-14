<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.Location, model.Machine" %>
<%@ page import="dao.impl.LocationDaoImpl, dao.impl.MachineDaoImpl" %>
<%
    String Name = (String) session.getAttribute("name");
%>
<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>機台管理</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background: linear-gradient(to bottom, #E3F2FD, #FFFFFF);
            margin: 0;
            padding: 20px;
            text-align: center;
        }

        h2 {
            color: #003366;
        }

        select, button, a {
            font-size: 16px;
            padding: 8px;
            margin: 5px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }

        select {
            background-color: #f8f9fa;
        }

        button {
            background-color: #0277BD;
            color: white;
            cursor: pointer;
        }

        button:hover {
            background-color: #01579B;
        }

        .container {
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            display: inline-block;
        }

        .machine-display {
            margin-top: 20px;
        }

        img, iframe {
            width: 500px;
            height: 300px;
            border-radius: 10px;
            display: none;
        }
    </style>
    <script>
        let currentIndex = 0;
        let machines = [];

        window.onload = async function () {
            try {
                let response = await fetch("GetSessionServlet");
                let sessionData = await response.json();

                if (sessionData.locationId) {
                    document.getElementById("location").value = sessionData.locationId;
                    loadMachines(sessionData.locationId);
                }
            } catch (error) {
                console.error("❌ 無法獲取 session 資料:", error);
            }
        };

        function updateDisplay() {
            if (machines.length === 0) {
                document.getElementById("machineName").innerText = "此場地沒有機台";
                toggleDisplayElements(false);
                return;
            }

            let machine = machines[currentIndex];
            let { name, cameraUrl, imageUrl } = machine;

            document.getElementById("machineName").innerText = "目前機台: " + name;

            let imageElement = document.getElementById("machineImage");
            let cameraElement = document.getElementById("camera");
            let cameraFrameElement = document.getElementById("cameraFrame");

            if (imageUrl) {
                imageElement.src = imageUrl;
                toggleDisplayElements(true, "image");
            } else if (cameraUrl && cameraUrl.startsWith("http")) {
                if (cameraUrl.match(/\.(jpeg|jpg|gif|png)$/)) {
                    cameraElement.src = cameraUrl;
                    toggleDisplayElements(true, "camera");
                } else {
                    cameraFrameElement.src = cameraUrl;
                    toggleDisplayElements(true, "cameraFrame");
                }
            } else {
                document.getElementById("machineName").innerText = "此機台無可顯示內容";
                toggleDisplayElements(false);
            }
        }

        function toggleDisplayElements(show, type = "") {
            document.getElementById("machineImage").style.display = (show && type === "image") ? "block" : "none";
            document.getElementById("camera").style.display = (show && type === "camera") ? "block" : "none";
            document.getElementById("cameraFrame").style.display = (show && type === "cameraFrame") ? "block" : "none";
        }

        function changeMachine(direction) {
            if (machines.length > 0) {
                currentIndex = (currentIndex + direction + machines.length) % machines.length;
                updateDisplay();
            }
        }

        async function saveLocationIdToSession(locationId) {
            if (!locationId.trim()) return;

            try {
                let response = await fetch("SaveLocationServlet", {
                    method: "POST",
                    headers: { "Content-Type": "application/x-www-form-urlencoded" },
                    body: new URLSearchParams({ locationId })
                });

                if (!response.ok) throw new Error(`❌ 伺服器錯誤: ${response.status}`);
                loadMachines(locationId);
            } catch (error) {
                console.error("❌ session 更新失敗:", error);
            }
        }

        function handleLocationChange(locationId) {
            if (!locationId.trim()) return;
            saveLocationIdToSession(locationId);
        }

        async function loadMachines(locationId) {
            if (!locationId) return;

            try {
                let response = await fetch(`MachineServlet?locationId=${locationId}`);
                if (!response.ok) throw new Error(`❌ 伺服器錯誤: ${response.status}`);

                machines = await response.json();
                currentIndex = 0;
                updateDisplay();
            } catch (error) {
                console.error("❌ 獲取機台資料失敗:", error);
            }
        }
    </script>
</head>
<body>
    <h2>機台管理</h2>

    <div class="container">
        <form>
            <label for="location">選擇場地：</label>
            <select id="location" name="location" onchange="handleLocationChange(this.value)">
                <option value="">請選擇場地</option>
                <% 
                    Integer userId = (Integer) session.getAttribute("id");
                    if (userId != null) {
                        List<Location> locations = new LocationDaoImpl().getLocationsByUserId(userId);
                        for (Location loc : locations) {
                %>
                            <option value="<%= loc.getId() %>"><%= loc.getName() %></option>
                <% 
                        }
                    } else {
                %>
                    <option value="" disabled>請先登入</option>
                <% } %>
            </select>
            <a href="VisitorCounterServlet?page=register/machineInformation.jsp">如未出現機台請點此</a>
        </form>

        <div class="machine-display">
            <h3 id="machineName">請選擇場地</h3>
            <img id="camera" alt="監視器畫面"/>
            <iframe id="cameraFrame"></iframe>
            <img id="machineImage" alt="機台圖片"/>
        </div>

        <br>
        <button onclick="changeMachine(-1)">⬆ 上一台 ⬆</button>
        <button onclick="changeMachine(1)">⬇ 下一台 ⬇</button>

        <br><br>
        <a href="VisitorCounterServlet?page=register/addLocation.jsp">➕ 新增場地</a> |
        <a href="VisitorCounterServlet?page=register/addMachine.jsp">➕ 新增機台</a>
    </div>
</body>
</html>