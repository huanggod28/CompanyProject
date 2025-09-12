<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>認識我們</title>
<!-- 引入 particles.js -->
<script src="https://cdn.jsdelivr.net/particles.js/2.0.0/particles.min.js"></script>

<style>
    /* 粒子背景容器 */
    #particles-js {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        z-index: -1;
    }

    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        margin: 0;
        padding: 0;
        color: #fff;
        background: linear-gradient(45deg, #1A1A1A, #0A0A0A);
        position: relative;
    }

    .container {
        width: 80%;
        margin: 50px auto;
        padding: 30px;
        background: rgba(0, 0, 0, 0.6);
        border-radius: 12px;
        box-shadow: 0 0 20px rgba(0, 255, 255, 0.3);
        backdrop-filter: blur(8px);
        text-align: center;
    }

    h2 {
        font-size: 24px;
        line-height: 1.8;
        color: #00FFFF;
    }

    .highlight {
        color: #00FFFF;
        font-weight: bold;
    }

    footer {
        text-align: center;
        margin-top: 50px;
        font-size: 14px;
        color: #00FFFF;
    }
</style>
</head>
<body>

<!-- 粒子背景 -->
<div id="particles-js"></div>

<div class="container">
    <h2>
        大家好，我們是 <span class="highlight">致理科大夜資四A第二組</span>，一個充滿個性與活力的團隊！我們組共有8位成員，每個人都有獨特的想法和風格，讓團隊充滿創意與多元性。我們來自不同背景，但擁有相同的目標——透過團隊合作，不斷學習與成長。在課堂上，我們互相扶持，分工合作，讓每次的專案都能發揮最佳水準。我們不只是同學，更是能夠彼此信任的夥伴！希望未來能夠在學習與實作中發揮各自的優勢，共同迎接挑戰，創造更多精彩的成果！
    </h2>
</div>

<footer>
    <p>© 2025 致理科大夜資四A第二組 - 所有權利保留</p>
</footer>

<!-- 初始化粒子背景 -->
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