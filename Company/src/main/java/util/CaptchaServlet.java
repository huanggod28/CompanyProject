package util;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Random;

@SuppressWarnings("serial")
@WebServlet("/CaptchaServlet")
public class CaptchaServlet extends HttpServlet {

    private static final int WIDTH = 100;
    private static final int HEIGHT = 25;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. 產生隨機驗證碼
        String captcha = generateCaptchaString(4);

        // 2. 將驗證碼存入 Session
        HttpSession session = request.getSession();
        session.setAttribute("captcha", captcha);

        // 3. 創建圖像
        BufferedImage image = new BufferedImage(WIDTH, HEIGHT, BufferedImage.TYPE_INT_RGB);
        Graphics2D g = image.createGraphics();

        // 4. 繪製背景
        g.setColor(Color.WHITE);
        g.fillRect(0, 0, WIDTH, HEIGHT);

        // 5. 繪製邊框
        g.setColor(Color.BLACK);
        g.drawRect(0, 0, WIDTH - 1, HEIGHT - 1);

        // 6. 繪製邊框
        Random random = new Random();
        g.setColor(Color.LIGHT_GRAY);
        for (int i = 0; i < 10; i++) {
            int x1 = random.nextInt(WIDTH);
            int y1 = random.nextInt(HEIGHT);
            int x2 = random.nextInt(WIDTH);
            int y2 = random.nextInt(HEIGHT);
            g.drawLine(x1, y1, x2, y2);
        }

        // 7. 繪製驗證碼字串
        g.setFont(new Font("Arial", Font.BOLD, 20));
        g.setColor(Color.BLUE);
        int x = 10;
        int y = 20;
        for (char ch : captcha.toCharArray()) {
            g.drawString(String.valueOf(ch), x, y);
            x += 20;
        }

        // 8. 釋放資源
        g.dispose();

        // 9. 設定回應頭，通知瀏覽器回傳的是圖片
        response.setContentType("image/png");

        // 10. 輸出映像到瀏覽器
        ImageIO.write(image, "png", response.getOutputStream());
    }

    private String generateCaptchaString(int length) {
        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        StringBuilder captcha = new StringBuilder();
        Random random = new Random();
        for (int i = 0; i < length; i++) {
            captcha.append(chars.charAt(random.nextInt(chars.length())));
        }
        return captcha.toString();
    }
}