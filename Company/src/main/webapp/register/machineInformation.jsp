<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.Location, model.Machine" %>
<%@ page import="dao.impl.LocationDaoImpl, dao.impl.MachineDaoImpl" %>
<%
    String Name = (String) session.getAttribute("name");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>機台管理</title>
    <script>
        let currentIndex = 0;
        let machines = [];

        function updateDisplay() {
            if (machines.length > 0) {
                let machine = machines[currentIndex];
                document.getElementById("machineName").innerText = "目前機台: " + machine.name;

                let cameraElement = document.getElementById("camera");
                let cameraFrameElement = document.getElementById("cameraFrame");
                let imageElement = document.getElementById("machineImage");

                let cameraUrl = machine.cameraUrl;
                let imageUrl = machine.imageUrl;

                // **如果有機台圖片，顯示圖片**
                if (imageUrl) {
                    imageElement.src = imageUrl;
                    imageElement.style.display = "block";
                    cameraElement.style.display = "none";
                    cameraFrameElement.style.display = "none";
                }
                // **如果 cameraUrl 是監視器串流，顯示 iframe**
                else if (cameraUrl && cameraUrl.startsWith("http")) {
                    if (cameraUrl.match(/\.(jpeg|jpg|gif|png)$/)) {
                        cameraElement.src = cameraUrl;
                        cameraElement.style.display = "block";
                        cameraFrameElement.style.display = "none";
                        imageElement.style.display = "none";
                    } else {
                        cameraFrameElement.src = cameraUrl;
                        cameraFrameElement.style.display = "block";
                        cameraElement.style.display = "none";
                        imageElement.style.display = "none";
                    }
                } else {
                    cameraElement.style.display = "none";
                    cameraFrameElement.style.display = "none";
                    imageElement.style.display = "none";
                    document.getElementById("machineName").innerText = "此機台無可顯示內容";
                }
            }
        }

        function prevMachine() {
            if (machines.length > 0) {
                currentIndex = (currentIndex - 1 + machines.length) % machines.length;
                updateDisplay();
            }
        }

        function nextMachine() {
            if (machines.length > 0) {
                currentIndex = (currentIndex + 1) % machines.length;
                updateDisplay();
            }
        }

        function loadMachines(locationId) {
            if (!locationId) {
                console.error("locationId 不存在");
                return;
            }

            fetch(`MachineServlet?locationId=${locationId}`)
                .then(response => response.json())
                .then(data => {
                    if (data.length === 0) {
                        document.getElementById("machineName").innerText = "此場地沒有機台";
                        document.getElementById("camera").style.display = "none";
                        document.getElementById("cameraFrame").style.display = "none";
                        document.getElementById("machineImage").style.display = "none";
                        return;
                    }

                    machines = data;
                    currentIndex = 0;
                    updateDisplay();
                })
                .catch(error => console.error("獲取機台資料失敗:", error));
        }
    </script>
</head>
<body>
    <h2>機台管理</h2>
    
    <!-- 場地選擇 -->
    <form>
        <label for="location">選擇場地：</label>
        <select id="location" name="location" onchange="loadMachines(this.value)">
            <option value="">請選擇場地</option>
            <% 
                Integer userId = (Integer) session.getAttribute("id"); // 確保 session 中有 userId
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
    </form>

    <!-- 監視器畫面 & 圖片 -->
    <h3 id="machineName">請選擇場地</h3>
    <img id="camera" src="" width="500" height="300" alt="監視器畫面" style="display:none"/>
    <iframe id="cameraFrame" width="500" height="300" style="display:none;"></iframe>
    <img id="machineImage" src="" width="500" height="300" alt="機台圖片" style="display:none;"/>

    <!-- 切換機台 -->
    <br>
    <button onclick="prevMachine()">⬆ 上一台 ⬆</button>
    <button onclick="nextMachine()">⬇ 下一台 ⬇</button>

    <!-- 新增場地 / 機台 -->
    <br><br>
    <a href="VisitorCounterServlet?page=register/addLocation.jsp">➕ 新增場地</a> |
    <a href="VisitorCounterServlet?page=register/addMachine.jsp">➕ 新增機台</a>

</body>
</html>