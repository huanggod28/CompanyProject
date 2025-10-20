<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.Location"%>
<%@ page import="dao.impl.LocationDaoImpl"%>
<%
    String Name = (String) session.getAttribute("name");
    Integer userId = (Integer) session.getAttribute("id");
%>
<!DOCTYPE html>
<html lang="zh-TW">
<head>
<meta charset="UTF-8">
<title>機台管理</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script
	src="https://cdn.jsdelivr.net/particles.js/2.0.0/particles.min.js"></script>
<style>
	body {
		margin: 0;
		padding: 0;
		font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
		background: linear-gradient(to right, #0f0f0f, #1a1a1a);
		color: #ffffff;
		overflow-x: hidden;
	}
	
	#particles-js {
		position: fixed;
		width: 100%;
		height: 100%;
		z-index: 0;
	}
	
	h2 {
		text-align: center;
		color: #00ffff;
		margin-top: 7px;
	}
	
	.container {
		max-width: 800px;
		margin: 4px auto;
		padding: 13px;
		background-color: rgba(0, 0, 0, 0.6);
		border-radius: 12px;
		box-shadow: 0 0 20px rgba(0, 255, 255, 0.3);
		backdrop-filter: blur(8px);
		text-align: center;
	}
	
	select, button, a {
		font-size: 16px;
		padding: 10px;
		margin: 8px;
		border-radius: 6px;
		border: none;
		background-color: rgba(255, 255, 255, 0.1);
		color: #fff;
		outline: none;
	}
	
	select:focus, input:focus {
		border: 1px solid #00ffff;
	}
	
	button {
		background-color: #00ffff;
		color: #000;
		font-weight: bold;
		cursor: pointer;
		transition: background 0.3s, transform 0.2s;
	}
	
	button:hover {
		background-color: #00cccc;
		transform: scale(1.05);
	}
	
	a {
		color: #00ffff;
		text-decoration: none;
	}
	
	a:hover {
		text-decoration: underline;
	}
	
	.machine-display {
		margin-top: 5px;
		text-align: center;
	}
	
	img, iframe, video {
		width: 90%;
		max-width: 600px;
		height: 350px;
		border-radius: 10px;
		display: none;
		margin: 0px auto 0 auto; /* 這行讓元素水平置中 */
	}
	
	#machineName {
		font-size: 1.3em;
		color: #00ffff;
	}
	
	.nav-buttons {
		margin-top: 10px;
	}
	
	.container select {
		color: #00b0f0;
		background-color:;
	}
	.machine-header {
	    display: flex;
	    align-items: center;  /* 垂直置中 */
	    justify-content: center; /* 水平置中 */
	    gap: 5px; /* 名稱與按鈕間距 */
	    margin-bottom: 10px;
	}
	
	#editButtonContainer button {
	    background-color: #00ffff;
	    color: #000;
	    font-weight: bold;
	    cursor: pointer;
	    padding: 8px 16px;
	    border-radius: 6px;
	    border: none;
	    transition: background 0.3s, transform 0.2s;
	}
	
	#editButtonContainer button:hover {
	    background-color: #00cccc;
	    transform: scale(1.05);
	}
		
</style>
	<script>
	let currentIndex = 0;
	let machines = [];

	window.onload = async function () {
	    const urlParams = new URLSearchParams(window.location.search);
	    const machineIdFromUrl = urlParams.get("machineId");

	    try {
	        // 先抓 session 資料
	        let response = await fetch("GetSessionServlet");
	        let sessionData = await response.json();

	        if (sessionData.locationId) {
	            document.getElementById("location").value = sessionData.locationId;
	            await loadMachines(sessionData.locationId, machineIdFromUrl);
	        }
	    } catch (error) {
	        console.error("❌ 無法獲取 session 資料:", error);
	    }
	};

	async function loadMachines(locationId, machineIdFromUrl = null) {
	    if (!locationId) return;

	    try {
	        let response = await fetch(`MachineServlet?locationId=${locationId}`);
	        if (!response.ok) throw new Error(`❌ 伺服器錯誤: ${response.status}`);

	        machines = await response.json();

	        // 確定 currentIndex
	        if (machineIdFromUrl) {
	            let index = machines.findIndex(m => m.id == machineIdFromUrl);
	            currentIndex = index >= 0 ? index : 0;
	        } else {
	            currentIndex = 0;
	        }

	        updateDisplay();
	    } catch (error) {
	        console.error("❌ 獲取機台資料失敗:", error);
	    }
	}

	function updateDisplay() {
	    if (machines.length === 0) return;

	    let machine = machines[currentIndex];
	    window.currentMachine = machine;
	    let { id, name, cameraUrl, imageUrl } = machine;

	    document.getElementById("machineName").innerText = "目前機台: " + name;

	    // 清空 container
	    const container = document.getElementById("editButtonContainer");
	    container.innerHTML = "";

	    // 建立按鈕元素
	    const btn = document.createElement("button");
	    btn.textContent = "編輯參數";
	    btn.onclick = () => {
	        location.href = "EditParametersServlet?machineId=" + id;
	    };
	    container.appendChild(btn);

	    console.log("🔍 當前機台 ID:", id);
	    console.log("🔗 生成的編輯連結 (按鈕實際 href):", btn.onclick.toString());
	    console.log("🔗 按鈕將跳轉至:", "EditParametersServlet?machineId=" + id);
	    // 其他顯示邏輯 (圖片/影片/YouTube)
	    let imageElement = document.getElementById("machineImage");
	    let cameraElement = document.getElementById("camera");
	    let cameraFrameElement = document.getElementById("cameraFrame");
	    let videoElement = document.getElementById("machineVideo");

	    if (imageUrl) {
	        imageElement.src = imageUrl;
	        toggleDisplayElements(true, "image");
	    } else if (cameraUrl) {
	        if (cameraUrl.match(/\.(jpeg|jpg|gif|png)$/)) {
	            cameraElement.src = cameraUrl;
	            toggleDisplayElements(true, "camera");
	        } else if (cameraUrl.endsWith(".mp4")) {
	            videoElement.src = cameraUrl;
	            videoElement.load();
	            videoElement.play();
	            toggleDisplayElements(true, "video");
	        } else if (cameraUrl.includes("youtube.com") || cameraUrl.includes("youtu.be")) {
	            cameraFrameElement.src = convertToYouTubeEmbed(cameraUrl);
	            toggleDisplayElements(true, "cameraFrame");
	        } else {
	            cameraFrameElement.src = cameraUrl;
	            toggleDisplayElements(true, "cameraFrame");
	        }
	    } else {
	        document.getElementById("machineName").innerText = "此機台無可顯示內容";
	        toggleDisplayElements(false);
	    }
	}

	function convertToYouTubeEmbed(url) {
	    let videoId;
	    let match = url.match(/[?&]v=([^&]+)/) || url.match(/youtu\.be\/([^?]+)/);
	    if (match) {
	        videoId = match[1];
	        return `https://www.youtube.com/embed/${videoId}?autoplay=1&rel=0&enablejsapi=1`;
	    }
	    return url;
	}

	function toggleDisplayElements(show, type = "") {
	    document.getElementById("machineImage").style.display = (show && type === "image") ? "block" : "none";
	    document.getElementById("camera").style.display = (show && type === "camera") ? "block" : "none";
	    document.getElementById("cameraFrame").style.display = (show && type === "cameraFrame") ? "block" : "none";
	    document.getElementById("machineVideo").style.display = (show && type === "video") ? "block" : "none";
	}

	async function changeMachine(direction) {
	    if (machines.length > 0) {
	        // 計算下一台的 index
	        currentIndex = (currentIndex + direction + machines.length) % machines.length;
	        let currentMachine = machines[currentIndex];

	        try {
	            // ✅ 先更新後端 session
	            await fetch("SaveMachineServlet", {
	                method: "POST",
	                headers: { "Content-Type": "application/x-www-form-urlencoded" },
	                body: new URLSearchParams({ machineId: currentMachine.id })
	            });

	            console.log("✅ 已更新 session 中的機台 ID:", currentMachine.id);
	            console.log("🟢 切換後 currentMachine:", currentMachine);
	            // ✅ 確定 session 更新成功後再更新畫面
	            updateDisplay();

	        } catch (err) {
	            console.error("❌ 更新機台 ID 失敗:", err);
	        }
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
	        await loadMachines(locationId); // ✅ 等 session 更新完成再載入機台
	    } catch (error) {
	        console.error("❌ session 更新失敗:", error);
	    }
	}

	function handleLocationChange(locationId) {
	    if (!locationId.trim()) return;
	    saveLocationIdToSession(locationId);
	}
	
	//此為投幣按鈕用
	function insertCoin() {
	    fetch("InsertCoinServlet", {
	        method: "POST",
	        headers: { "Content-Type": "application/x-www-form-urlencoded" },
	        body: "machineId=" + currentMachine.id
	    }).then(res => res.text()).then(alert);
	    console.log("投入10元",insertCoin);
	}
	
	// 此為出貨按鈕
	function shipment() {
	    let productCost = prompt("請輸入該獎品成本：", "10");
	    if (!productCost) return;

	    let note = prompt("請輸入出貨說明：", "玩家成功夾取");
	    if (note === null) note = ""; // 避免使用者按取消

	    fetch("ShipmentServlet", {
	        method: "POST",
	        headers: { "Content-Type": "application/x-www-form-urlencoded" },
	        body: "machineId=" + currentMachine.id + 
	              "&productCost=" + productCost + 
	              "&note=" + encodeURIComponent(note)
	    })
	    .then(res => res.text())
	    .then(alert);

	    console.log("出貨執行，機台ID:", currentMachine.id, "成本:", productCost, "說明:", note);
	}
    </script>
</head>
<body>
	<div id="particles-js"></div>

	<h2>機台管理</h2>

	<div class="container">
		<label for="location">選擇場地：</label> <select id="location"
			name="location" onchange="handleLocationChange(this.value)">
			<option value="">請選擇場地</option>
			<%
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
			<%
            }
        %>
		</select> <a href="VisitorCounterServlet?page=register/machineInformation.jsp">如未出現機台請點此</a>

		<div class="machine-display">
		    <div class="machine-header">
		        <h3 id="machineName">請選擇場地</h3>
		        <div id="editButtonContainer"></div>
		    </div>
		    <img id="camera" alt="監視器畫面" />
		    <iframe id="cameraFrame" frameborder="0"
		        allow="autoplay; encrypted-media; picture-in-picture"
		        allowfullscreen></iframe>
		    <img id="machineImage" alt="機台圖片" />
		    <video id="machineVideo" controls autoplay loop muted></video>
		</div>

		<div class="nav-buttons">
			<button onclick="changeMachine(-1)">⬆ 上一台</button>
			<button onclick="changeMachine(1)">⬇ 下一台</button>
			<button onclick="insertCoin()">投入10元</button>
    		<button onclick="shipment()">出貨</button>
    		<a href="ExportRevenueServlet"><button>匯出營收CSV</button></a>
		</div>
		
		<div style="margin-top: 20px;">
			<a href="VisitorCounterServlet?page=register/addLocation.jsp">➕
				新增場地</a> | <a href="VisitorCounterServlet?page=register/addMachine.jsp">➕
				新增機台</a>
		</div>
	</div>

	<!-- 粒子背景 -->
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