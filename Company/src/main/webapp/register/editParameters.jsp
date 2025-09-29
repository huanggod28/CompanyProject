<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="zh-TW">
<head>
<meta charset="UTF-8">
<title>編輯機台參數</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://cdn.jsdelivr.net/particles.js/2.0.0/particles.min.js"></script>
<style>
    html, body {
        margin: 0;
        padding: 0;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background: linear-gradient(to right, #0a0a0a, #1a1a1a);
        color: #fff;
        height: 100%;
    }

    #particles-js {
        position: fixed;
        width: 100%;
        height: 100%;
        z-index: 0;
        top: 0;
        left: 0;
    }

    body h2 {
        text-align: center;
        color: #00FFFF;
        margin-top: 30px;
        text-shadow: 0 0 8px #00FFFF;
    }

    .container {
        width: 90%;
        max-width: 700px;
        margin: 40px auto;
        padding: 20px 30px;
        background-color: rgba(0,0,0,0.6);
        border-radius: 12px;
        box-shadow: 0 0 20px rgba(0,255,255,0.3);
        backdrop-filter: blur(8px);
    }

    form {
        display: flex;
        flex-direction: column;
    }

    h3 {
        color: #00FFFF;
        margin-top: 25px;
        text-shadow: 0 0 5px #00FFFF;
    }

    label, input, select {
        margin-top: 10px;
    }

    input[type="number"], select {
        width: 100%;
        padding: 8px;
        border-radius: 6px;
        border: none;
        background-color: rgba(255,255,255,0.1);
        color: #fff;
        outline: none;
    }

    input[type="number"]:focus, select:focus {
        border: 1px solid #00FFFF;
        background-color: rgba(255,255,255,0.2);
    }

    input[type="submit"] {
        margin-top: 20px;
        padding: 12px;
        border: none;
        border-radius: 6px;
        background-color: #00FFFF;
        color: #000;
        font-weight: bold;
        cursor: pointer;
        transition: all 0.3s ease;
    }

    input[type="submit"]:hover {
        background-color: #00cccc;
        transform: scale(1.05);
    }

    p {
        text-align: center;
        color: #ff5555;
        font-weight: bold;
    }
    
    .container select {
		color: #00b0f0;
		background-color:;
	}
</style>
</head>
<body>
<div id="particles-js"></div>

<h2>編輯機台參數</h2>

<div class="container">
<c:if test="${empty params}">
    <p>❌ 找不到該機台參數，請確認 machineId 是否正確</p>
</c:if>

<c:if test="${not empty params}">
<form action="EditParametersServlet" method="post">
    <input type="hidden" name="machineId" value="${params.machineId}" />

    <h3>爪力設定</h3>
    起爪力: <input type="number" name="initialGrip" value="${params.initialGrip}" min="0" max="100"/><br/>
    移動爪力: <input type="number" name="moveGrip" value="${params.moveGrip}" min="0" max="100"/><br/>
    放爪前力道: <input type="number" name="preDropGrip" value="${params.preDropGrip}" min="0" max="100"/><br/>
    強爪力: <input type="number" name="strongGrip" value="${params.strongGrip}" min="80" max="100"/><br/>
    爪子開口角度: <input type="number" name="openAngle" value="${params.openAngle}" min="20" max="90"/><br/>
    爪子閉合角度: <input type="number" name="closeAngle" value="${params.closeAngle}" min="10" max="45"/><br/>
    爪力出力延遲: <input type="number" name="gripDelay" value="${params.gripDelay}" step="0.1" min="0.1" max="3.0"/><br/>

    <h3>機率/保夾設定</h3>
    保夾次數: <input type="number" name="guaranteeCount" value="${params.guaranteeCount}" min="1" max="99"/><br/>
    保夾強爪力: <input type="number" name="guaranteeGrip" value="${params.guaranteeGrip}" min="80" max="100"/><br/>

    <h3>操作設定</h3>
    操作時間: <input type="number" name="playTime" value="${params.playTime}" min="15" max="60"/><br/>
    Z軸速度: <input type="number" name="zSpeed" value="${params.zSpeed}" min="1" max="10"/><br/>
    XY軸速度: <input type="number" name="xySpeed" value="${params.xySpeed}" min="1" max="10"/><br/>
    快速下爪: 
    <select name="quickDrop">
        <option value="ON" <c:if test="${params.quickDrop=='ON'}">selected</c:if>>ON</option>
        <option value="OFF" <c:if test="${params.quickDrop=='OFF'}">selected</c:if>>OFF</option>
    </select><br/>
    移動限制: 
    <select name="moveLimit">
        <option value="自由" <c:if test="${params.moveLimit=='自由'}">selected</c:if>>自由</option>
        <option value="單向" <c:if test="${params.moveLimit=='單向'}">selected</c:if>>單向</option>
        <option value="雙向" <c:if test="${params.moveLimit=='雙向'}">selected</c:if>>雙向</option>
    </select><br/>

    <h3>金額與投幣設定</h3>
    單次金額: <input type="number" name="price" value="${params.price}" min="10" max="100"/><br/>
    保夾金額: <input type="number" name="max_price" value="${params.max_price}" min="10" max="3000"/><br/>
    投幣記憶:
    <select name="coinMemory">
        <option value="ON" <c:if test="${params.coinMemory=='ON'}">selected</c:if>>ON</option>
        <option value="OFF" <c:if test="${params.coinMemory=='OFF'}">selected</c:if>>OFF</option>
    </select><br/>
    出貨重置模式:
    <select name="resetMode">
        <option value="自動" <c:if test="${params.resetMode=='自動'}">selected</c:if>>自動</option>
        <option value="手動" <c:if test="${params.resetMode=='手動'}">selected</c:if>>手動</option>
        <option value="不重置" <c:if test="${params.resetMode=='不重置'}">selected</c:if>>不重置</option>
    </select><br/>

    <h3>音效與燈光設定</h3>
    音效總開關:
    <select name="soundSwitch">
        <option value="ON" <c:if test="${params.soundSwitch=='ON'}">selected</c:if>>ON</option>
        <option value="OFF" <c:if test="${params.soundSwitch=='OFF'}">selected</c:if>>OFF</option>
    </select><br/>
    音量: <input type="number" name="volume" value="${params.volume}" min="0" max="100"/><br/>
    燈效模式:
    <select name="lightMode">
        <option value="常亮" <c:if test="${params.lightMode=='常亮'}">selected</c:if>>常亮</option>
        <option value="呼吸" <c:if test="${params.lightMode=='呼吸'}">selected</c:if>>呼吸</option>
        <option value="閃爍" <c:if test="${params.lightMode=='閃爍'}">selected</c:if>>閃爍</option>
    </select><br/>
    中獎特效燈光:
    <select name="jackpotLight">
        <option value="ON" <c:if test="${params.jackpotLight=='ON'}">selected</c:if>>ON</option>
        <option value="OFF" <c:if test="${params.jackpotLight=='OFF'}">selected</c:if>>OFF</option>
    </select><br/><br/>

    <input type="submit" value="儲存">
</form>
</c:if>
</div>

<script>
particlesJS("particles-js", {
    particles: {
        number: { value: 60 },
        color: { value: "#00ffff" },
        shape: { type: "circle" },
        opacity: { value: 0.3 },
        size: { value: 3 },
        line_linked: {
            enable: true,
            distance: 150,
            color: "#00ffff",
            opacity: 0.4,
            width: 1
        },
        move: {
            enable: true,
            speed: 2,
            direction: "none",
            out_mode: "bounce"
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