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
<html>
<head>
    <title>新增機台</title>
    <script>
        function validateInput(inputType) {
            if (inputType === 'camera') {
                document.getElementById('imageUrl').value = '';  // 清空圖片 URL
            } else if (inputType === 'image') {
                document.getElementById('cameraUrl').value = ''; // 清空監視器連結
            }
        }

        function validateForm() {
            let cameraUrl = document.getElementById("cameraUrl").value.trim();
            let imageUrl = document.getElementById("imageUrl").value.trim();

            if (cameraUrl === "" && imageUrl === "") {
                alert("請輸入監視器連結或上傳圖片 URL 其中之一！");
                return false;
            }

            if (cameraUrl !== "" && imageUrl !== "") {
                alert("請選擇 **監視器連結** 或 **圖片 URL**，不能兩者都填！");
                return false;
            }

            return true;
        }
    </script>
</head>
<body>
    <h2>新增機台</h2>
    <form action="AddMachineServlet" method="post" onsubmit="return validateForm();">
        <label for="locationId">選擇場地：</label>
        <select id="locationId" name="locationId" required>
            <option value="">請選擇場地</option>
            <% for (Location loc : locations) { %>
                <option value="<%= loc.getId() %>"><%= loc.getName() %></option>
            <% } %>
        </select>
        <br><br>

        <label for="machineName">機台名稱：</label>
        <input type="text" id="machineName" name="machineName" required>
        <br><br>

        <label for="cameraUrl">監視器連結：</label>
        <input type="text" id="cameraUrl" name="cameraUrl" oninput="validateInput('camera')">
        <br><br>

        <label for="imageUrl">圖片 URL：</label>
        <input type="text" id="imageUrl" name="imageUrl" oninput="validateInput('image')">
        <br><br>

        <button type="submit">新增機台</button>
    </form>

    <br>
    <a href="VisitorCounterServlet?page=register/machineInformation.jsp">返回機台資訊</a>
</body>
</html>