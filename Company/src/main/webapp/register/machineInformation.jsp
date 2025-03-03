<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.Location, model.Machine" %>
<%@ page import="dao.impl.LocationDaoImpl, dao.impl.MachineDaoImpl" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>機台管理</title>
    <script>
        let currentIndex = 0;
        let machines = [];

        function updateCamera() {
            if (machines.length > 0) {
                document.getElementById("machineName").innerText = machines[currentIndex].name;
                document.getElementById("camera").src = machines[currentIndex].camera_url;
            } else {
                document.getElementById("camera").src = "";
            }
        }

        function prevMachine() {
            if (machines.length > 0) {
                currentIndex = (currentIndex - 1 + machines.length) % machines.length;
                updateCamera();
            }
        }

        function nextMachine() {
            if (machines.length > 0) {
                currentIndex = (currentIndex + 1) % machines.length;
                updateCamera();
            }
        }

        function loadMachines(locationId) {
            fetch(`MachineServlet?locationId=${locationId}`)
                .then(response => response.json())
                .then(data => {
                    machines = data;
                    currentIndex = 0;
                    updateCamera();
                });
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
                List<Location> locations = new LocationDaoImpl().getLocationsByUserId((Integer) session.getAttribute("id"));
                for (Location loc : locations) {
            %>
                <option value="<%= loc.getId() %>"><%= loc.getName() %></option>
            <% } %>
        </select>
    </form>

    <!-- 監視器畫面 -->
    <h3 id="machineName">請選擇場地</h3>
    <img id="camera" src="" width="500" height="300" alt="監視器畫面"/>

    <!-- 切換機台 -->
    <button onclick="prevMachine()">⬆ 上一台　⬆</button>
    <button onclick="nextMachine()">⬇ 下一台　⬇</button>

    <!-- 新增場地 / 機台 -->
    <br><br>
    <a href="VisitorCounterServlet?page=register/addLocation.jsp">➕ 新增場地</a> |
    <a href="VisitorCounterServlet?page=register/addMachine.jsp">➕ 新增機台</a>

</body>
</html>
