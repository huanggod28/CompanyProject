<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>智能娃娃機營運監控系統</title>
<style>
body {
	margin: 0;
	font-family: Arial, sans-serif;
}

.navbar {
	display: flex;
	justify-content: space-between;
	align-items: center;
	background-color: black;
	color: white;
	padding: 20px 40px;
	height: 90px;
}

.navbar .logo {
	font-size: 24px;
	font-weight: bold;
}

.navbar .menu {
	display: flex;
	gap: 20px;
	align-items: center;
}

.navbar .menu .btn {
  position: relative;
  display: inline-block;
  padding: 8px 16px;
  color: white;
  background-color: black;
  border: 0px solid #444; /* 淡邊線 */
  border-radius: 8px;
  text-decoration: none;
  font-weight: bold;
  z-index: 0;
  overflow: hidden;
}

/* 動態金光跑邊框 */
.navbar .menu .btn::after {
  content: "";
  position: absolute;
  width: 100%;
  height: 100%;
  top: 0;
  left: 0;
  border-radius: 20px;
  background: linear-gradient(
    90deg,
    transparent 0%,
    #ffd700 50%,
    transparent 100%
  );
  animation: moveLight 2.5s linear infinite;
  background-size: 300% 300%;
  background-repeat: no-repeat;
  pointer-events: none;
  mask: 
    linear-gradient(#000 0 0) content-box, 
    linear-gradient(#000 0 0);
  -webkit-mask: 
    linear-gradient(#000 0 0) content-box, 
    linear-gradient(#000 0 0);
  mask-composite: exclude;
  -webkit-mask-composite: destination-out;
  padding: 3px;
  z-index: 1;
}
@keyframes moveLight {
  0% {
    background-position: 200% 0%;
  }
  100% {
    background-position: -200% 0%;
  }
}

.navbar .menu .btn:hover {
  border: 1px solid gold; /* 淡邊線 */
  color: gold;
  border-color: gold;
  
}
/*這是按鈕*/
.navbar .menu .btn .bn{
	background-color: black;
	color:white;
	font-size:18px;
}
/*這是按鈕*/
.navbar .menu .bn{
	background-color: black;
	color:white;
	font-size:18px;
}

.navbar .bell-icon {
	font-size: 20px;
	cursor: pointer;
}

.logo {
	font-size: 24px;
	font-weight: bold;
	display: flex;
	align-items: center;
	gap: 10px; /* 圖片與文字之間的間距 */
}

.logo img {
	height: 60px; /* 可依照你圖示調整大小 */
}
</style>
<!-- Font Awesome CDN for bell icon -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>

	<div class="navbar">

		<div class="logo">
			<img src="pic/IDO.png" alt="Logo">智能娃娃機營運監控系統
		</div>
		<div class="menu">
			<a href="" target=_blank alt="" class="btn">
				<button class="bn">Learn</button>
			</a>
			<a href="" target=_blank alt="" class="btn">
				<button class="bn">Community</button>
			</a>
			<a href="#" target=_blank alt="" class="btn">
				<button class="bn">Add Sonic</button>
			</a>			
			<a href="https://www.chihlee.edu.tw/" target=_blank alt=致理 class="btn">
				<button class="bn">Chihlee</button>
			</a>
			<a href="https://discord.gg/r3YC8Ckk" target=_blank alt=doscord群組 class="btn">
				<button class="bn">Discord</button>
			</a>
			<i class="fas fa-bell bell-icon"></i>
		</div>
	</div>

</body>
</html>