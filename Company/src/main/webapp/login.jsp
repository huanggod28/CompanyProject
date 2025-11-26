<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="zh-TW">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0"> <!-- RWD -->
<title>智能娃娃機營運系統</title>
<script src="https://cdn.jsdelivr.net/npm/particles.js@2.0.0/particles.min.js"></script>
<style>
* {
	box-sizing: border-box;
}

body, html {
	margin: 0;
	padding: 0;
	font-family: 'Segoe UI', sans-serif;
	height: 100%;
	overflow: auto;  /* 讓頁面可以滾動 */
	color: #fff;
}

/* 隱藏 Chrome / Edge / Safari scrollbar */
body::-webkit-scrollbar {
	display: none;
}

body {
	background-color: #0d0d0d;
}

#particles-js {
	position: fixed;
	width: 100%;
	height: 100%;
	z-index: 0;
}

.container {
	display: flex;
	flex-wrap: wrap;
	justify-content: center;
	gap: 40px;
	padding: 80px 20px;
	animation: fadeIn 2s ease;
}

/* RWD 卡片調整 */
.card {
	background: rgba(0, 255, 255, 0.05);
	border: 1px solid rgba(0, 255, 255, 0.2);
	border-radius: 20px;
	padding: 30px;
	flex: 1 1 300px; /* RWD：最小 300px，可自動縮放 */
	max-width: 400px;
	width: 100%;
	backdrop-filter: blur(10px);
	box-shadow: 0 0 20px rgba(0, 255, 255, 0.2);
	transition: all 0.4s ease;
}

.card:hover {
	transform: translateY(-5px);
	box-shadow: 0 0 25px rgba(0, 255, 255, 0.5);
}

h2 {
	color: #00ffff;
	border-bottom: 1px solid rgba(255, 255, 255, 0.1);
	padding-bottom: 20px;
	margin-top: 0;
	margin-bottom: 20px;
	text-align: center;
}

input[type="text"], input[type="password"] {
	width: 100%;
	padding: 10px;
	border: none;
	border-radius: 8px;
	margin-bottom: 15px;
	background: rgba(255, 255, 255, 0.1);
	color: #fff;
}

.captcha-container {
	display: flex;
	align-items: center;
	gap: 20px;
}

.captcha-container img {
	height: 40px;
	cursor: pointer;
	margin-left: 10px;
	border-radius: 6px;
}

input[type="submit"], input[type="reset"] {
	background: #00ffff;
	color: #000;
	border: none;
	border-radius: 8px;
	padding: 10px 20px;
	cursor: pointer;
	margin: 10px 5px 0;
	transition: background 0.3s ease, transform 0.3s ease;
}

input[type="submit"]:hover, input[type="reset"]:hover {
	transform: scale(1.05);
}

input[type="submit"]:hover {
	background: #00baba;
}

input[type="reset"]:hover {
	background: lightgray;
}

a {
	color: #00ffff;
	text-decoration: none;
}

a:hover {
	text-decoration: underline;
}

/* YouTube RWD */
.video-container {
	position: relative;
	width: 100%;
	padding-bottom: 56.25%; /* 16:9 */
	height: 0;
	overflow: hidden;
	border-radius: 8px;
	margin-bottom: 20px;
}

.video-container iframe {
	position: absolute;
	top: 0; left: 0;
	width: 100%;
	height: 100%;
	border: none;
	border-radius: 8px;
}

.footer {
	text-align: center;
	margin-top: 40px;
	font-size: 12px;
	color: #aaa;
}

@keyframes fadeIn {
	from { opacity: 0; transform: translateY(20px); }
	to { opacity: 1; transform: translateY(0); }
}

/* 手機版調整 */
@media (max-width: 600px) {
	.container {
		padding: 40px 10px;
		gap: 20px;
	}
	h2 {
		font-size: 18px;
	}
	input[type="text"], input[type="password"], input[type="submit"], input[type="reset"] {
		font-size: 14px;
		padding: 8px;
	}
}
</style>
</head>
<body>
	<div id="particles-js"></div>

	<div class="container">

		<!-- 文章區塊 -->
		<div class="card">
			<h2>最新文章</h2>
			<ul style="padding-left: 0; list-style: none;">
				<li><a href="javascript:void(0);" onclick="toggleArticle('a1')">◎如何選擇熱門娃娃：吸引玩家的商品策略
				</a>
					<div id="a1" class="article-content"
						style="display: none; padding: 10px 15px; margin-top: 8px; border-left: 2px solid #00ffff; color: #ccc;">
						這篇文章探討了夾娃娃機業者如何透過與上游廠商或他國平台的批貨，以更為低廉的成本進貨，
						並設定合理的、高於成本的夾取門檻，即使人流不多，獲取的利潤也夠支付租金，且機台的資金回收期短，獲利基礎非常穩健。 <a
							href="https://www.saas.cybersoft.tw/post/%E5%A8%83%E5%A8%83%E6%A9%9F%E5%89%B5%E6%A5%AD?utm_source=chatgpt.com"
							alt="文章1" target=_blank>完整文章</a>
					</div></li>

				<li><a href="javascript:void(0);" onclick="toggleArticle('a2')">◎地點選擇與利潤分析：找到高效益的黃金位置
				</a>
					<div id="a2" class="article-content"
						style="display: none; padding: 10px 15px; margin-top: 8px; border-left: 2px solid #00ffff; color: #ccc;">
						本文探討了夾娃娃機店的地點選擇對業績的影響，指出即使在相對偏僻的地點，如台中西屯區的夾子園旗艦店，仍能吸引大量顧客，顯示地點選擇與經營策略的關聯性。
						<a href="https://www.peopo.org/news/634682?utm_source=chatgpt.com"
							alt="文章" target=_blank>完整文章</a>
					</div></li>

				<li><a href="javascript:void(0);" onclick="toggleArticle('a3')">◎補貨時間管理策略：保持吸引力的關鍵</a>
					<div id="a3" class="article-content"
						style="display: none; padding: 10px 15px; margin-top: 8px; border-left: 2px solid #00ffff; color: #ccc;">
						這篇文章講解如何安排補貨時程與頻率，避免機台空空如也或商品過時，並提供不同客群與地點的補貨需求範例。 <a
							href="https://aiwahu.tw/clip-doll/?utm_source=chatgpt.com"
							alt="文章" target=_blank>完整文章</a>
					</div></li>

				<li><a href="javascript:void(0);" onclick="toggleArticle('a4')">◎娃娃機經營趨勢報告：從投資玩具到打造品牌體驗
				</a>
					<div id="a4" class="article-content"
						style="display: none; padding: 10px 15px; margin-top: 8px; border-left: 2px solid #00ffff; color: #ccc;">
						這篇報告分析了2024年娃娃機市場的發展趨勢，指出全球市場規模持續擴大，預計到2028年將超過50億美元，並強調亞太地區特別是中國市場的主導地位。
						<a
							href="https://big5.chinabgao.com/freereport/96693.html?utm_source=chatgpt.com"
							alt="文章" target=_blank>完整文章</a>
					</div></li>

				<li><a href="javascript:void(0);" onclick="toggleArticle('a5')">◎營運成本控管：從機台、租金到電費的預算分配
				</a>
					<div id="a5" class="article-content"
						style="display: none; padding: 10px 15px; margin-top: 8px; border-left: 2px solid #00ffff; color: #ccc;">
						本文介紹了零食娃娃機的經營模式，指出其成本較低、回本速度快，並探討了在競爭激烈的市場中，業者如何透過商品選擇和行銷活動來吸引消費者。
						​ <a
							href="https://www.peopo.org/news/657644?utm_source=chatgpt.com"
							alt="文章" target=_blank>完整文章</a>
					</div></li>

				<li><a href="javascript:void(0);" onclick="toggleArticle('a6')">◎玩家心理學：了解消費者行為提升營收</a>
					<div id="a6" class="article-content"
						style="display: none; padding: 10px 15px; margin-top: 8px; border-left: 2px solid #00ffff; color: #ccc;">
						本文從心理學角度剖析玩家為何願意投幣（如成就感、好奇心、賭博心理），並提供設計機台與選品策略以對應這些心理。 <a
							href="https://gogolvyouqu.wordpress.com/2024/06/03/parent-child-playground-claw-machine/?utm_source=chatgpt.com"
							alt="文章" target=_blank>完整文章</a>
					</div></li>

				<li><a href="javascript:void(0);" onclick="toggleArticle('a7')">◎娃娃機行銷術：用活動與社群打造人氣機台
				</a>
					<div id="a7" class="article-content"
						style="display: none; padding: 10px 15px; margin-top: 8px; border-left: 2px solid #00ffff; color: #ccc;">
						這篇文章介紹了五種創意的夾娃娃機活動方案，包括社交媒體互動挑戰、會員集點活動等，幫助中小企業提升品牌曝光率和顧客參與度。 <a
							href="https://hkclawmachine.com/%E5%A4%BE%E5%A8%83%E5%A8%83%E6%A9%9F%E6%B4%BB%E5%8B%95%E6%96%B9%E6%A1%88/?utm_source=chatgpt.com"
							alt="文章" target=_blank>完整文章</a>
					</div></li>

				<li><a href="javascript:void(0);" onclick="toggleArticle('a8')">◎多機台經營技巧：如何擴張你的娃娃機王國
				</a>
					<div id="a8" class="article-content"
						style="display: none; padding: 10px 15px; margin-top: 8px; border-left: 2px solid #00ffff; color: #ccc;">
						本文探討了夾娃娃機店的經營策略，強調持續創新和提供獨特體驗的重要性，並建議業者跳脫傳統無人娃娃機店的經營模式，以消費者為中心，提升顧客黏著度。​
						<a
							href="https://www.wisho2o.com/article/new-interactive-entertainment-experience?utm_source=chatgpt.com"
							alt="文章" target=_blank>完整文章</a>
					</div></li>

				<li><a href="javascript:void(0);" onclick="toggleArticle('a9')">◎娃娃機法律與營運合規知識</a>
					<div id="a9" class="article-content"
						style="display: none; padding: 10px 15px; margin-top: 8px; border-left: 2px solid #00ffff; color: #ccc;">
						本文詳細探討了夾娃娃機經營中可能涉及的法律問題，包括機台分類、商品合法性、機台改裝限制等。​文章指出，夾娃娃機若被經濟部評鑑為「電子遊戲機」，需取得相關營業證照；若為「選物販賣機」，
						則需確保商品價值與保夾金額相當，且不得擺放盜版商品或未經審核的電子產品。​此外，改裝機台以影響遊戲結果，可能觸犯詐欺等刑事責任。​
						<a href="https://www.legis-pedia.com/QA/question/707" alt="文章"
							target=_blank>完整文章</a>
					</div></li>

				<li><a href="javascript:void(0);"
					onclick="toggleArticle('a10')">◎創業案例分享：從副業到月入十萬的娃娃機經營者故事
				</a>
					<div id="a10" class="article-content"
						style="display: none; padding: 10px 15px; margin-top: 8px; border-left: 2px solid #00ffff; color: #ccc;">
						本文分享了夾娃娃機經營者的創業經驗，探討了他們如何透過選擇合適的商品和地點，以及創新的行銷策略，成功地將副業轉變為穩定的收入來源。
						<a
							href="https://www.wishmobile.com/blogs/marketing/claw_machine_LINE_marketing?utm_source=chatgpt.com"
							alt="文章" target=_blank>完整文章</a>
					</div></li>
			</ul>
		</div>

		<!-- 登入區塊 -->
		<div class="card">
			<h2>登入系統</h2>
		    <form action="LoginController" method="post">
		        <input type="text" name="username" placeholder="請輸入帳號" required>
		        <input type="password" name="password" placeholder="請輸入密碼" required>
		        <div class="captcha-container">
		            <input type="text" name="captcha" placeholder="驗證碼">
		            <img src="CaptchaServlet" onclick="this.src='CaptchaServlet?'+Math.random()" alt="驗證碼">
		        </div>
		        <div style="text-align: center;">
		            <input style="font-weight: bolder;" type="submit" value="登入">
		            <input style="background-color: gray; font-weight: bolder;" type="reset" value="重置">
		        </div>
		        <div style="text-align: center; margin-top: 10px; font-size: 12px">
		            <a href="VisitorCounterServlet?page=register.jsp">註冊帳號</a>
		        </div>
		    </form>
		</div>

		<!-- YouTube 區塊 -->
		<div class="card">
			<h2>實戰影片</h2>
			<div class="video-container">
				<iframe src="https://www.youtube.com/embed/1ieKSJGOqiQ" allowfullscreen></iframe>
			</div>
			<div class="video-container">
				<iframe src="https://www.youtube.com/embed/g-tWbpHZd14" allowfullscreen></iframe>
			</div>
		</div>
	</div>

	<div class="footer">© 2025 致理科大夜資三A第二組 - 所有權利保留</div>

	<script>
		particlesJS("particles-js", {
			particles : {
				number : { value : 80 },
				color : { value : "#00ffff" },
				shape : { type : "circle" },
				opacity : { value : 0.3 },
				size : { value : 3 },
				line_linked : { enable : true, distance : 150, color : "#00ffff", opacity : 0.3, width : 1 },
				move : { enable : true, speed : 2 }
			},
			interactivity : {
				events : { onhover : { enable : true, mode : "grab" } },
				modes : { grab : { distance : 200, line_linked : { opacity : 0.5 } } }
			},
			retina_detect : true
		});
		/*下拉展開*/
		function toggleArticle(id) {
			const content = document.getElementById(id);
			if (content.style.display === "none" || content.style.display === "") {
				content.style.display = "block";
			} else {
				content.style.display = "none";
			}
		}
	</script>
</body>
</html>