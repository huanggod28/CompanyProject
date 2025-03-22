package game;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.JSONObject;

@WebServlet("/SlotServlet")
public class SlotServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String[] SYMBOLS = {"🍒", "🍋", "🍊", "🔔", "⭐", "7️⃣"};
    private static final int[] SYMBOL_WEIGHTS = {5, 5, 5, 5, 5, 2};

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer balance = (Integer) session.getAttribute("balance");

        if (balance == null) {
            balance = 100; // 預設初始金額
        }

        // 讀取 JSON 請求內容
        StringBuilder sb = new StringBuilder();
        String line;
        try (BufferedReader reader = request.getReader()) {
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }
        }

        // 解析 JSON
        JSONObject json = new JSONObject(sb.toString());
        String betStr = json.optString("bet", "");
        String multiplierStr = json.optString("multiplier", "");

        // 印出前端發送的 bet 和 multiplier
        System.out.println("Received bet: " + betStr);
        System.out.println("Received multiplier: " + multiplierStr);

        if (betStr.isEmpty() || multiplierStr.isEmpty()) {
            response.setContentType("application/json");
            response.getWriter().write("{\"error\": \"錯誤: 下注金額或倍率為空！\"}");
            return;
        }

        try {
            int bet = Integer.parseInt(betStr);
            int multiplier = Integer.parseInt(multiplierStr);

            if (bet <= 0 || multiplier <= 0) {
                response.setContentType("application/json");
                response.getWriter().write("{\"error\": \"錯誤: 下注金額或倍率無效！\"}");
                return;
            }

            int totalBet = bet * multiplier;

            if (totalBet > balance) {
                response.setContentType("application/json");
                response.getWriter().write("{\"error\": \"餘額不足，請更換投入倍率！\"}");
                return;
            }

            balance -= totalBet;

            Random rand = new Random();
            String[] result = new String[3];

            // 20% 機率強制三張相同
            if (rand.nextInt(100) < 20) {
                String luckySymbol = getRandomSymbol(rand);
                result[0] = result[1] = result[2] = luckySymbol;
            } else {
                for (int i = 0; i < 3; i++) {
                    result[i] = getRandomSymbol(rand);
                }
            }

            int payout = 0;
            String message = "";

            if (result[0].equals(result[1]) && result[1].equals(result[2])) {
                if (result[0].equals("7️⃣")) {
                    payout = totalBet * 5;
                } else {
                    payout = totalBet * 3;
                }
                message = "🎉 恭喜你中獎！" + result[0] + " " + result[1] + " " + result[2] + " 返還：" + payout;
            } else {
                message = "😢 好可惜，下次一定中獎！";
            }

            balance += payout;
            session.setAttribute("balance", balance);

            // 回傳 JSON
            response.setContentType("application/json");
            response.getWriter().write(String.format(
                "{\"symbol1\": \"%s\", \"symbol2\": \"%s\", \"symbol3\": \"%s\", \"balance\": %d, \"message\": \"%s\"}",
                result[0], result[1], result[2], balance, message
            ));

        } catch (NumberFormatException e) {
            response.setContentType("application/json");
            response.getWriter().write("{\"error\": \"錯誤: 下注金額或倍率格式不正確！\"}");
            e.printStackTrace();
        }
    }

    private String getRandomSymbol(Random rand) {
        int totalWeight = 0;
        for (int weight : SYMBOL_WEIGHTS) {
            totalWeight += weight;
        }

        int randomIndex = rand.nextInt(totalWeight);
        int cumulativeWeight = 0;
        for (int i = 0; i < SYMBOLS.length; i++) {
            cumulativeWeight += SYMBOL_WEIGHTS[i];
            if (randomIndex < cumulativeWeight) {
                return SYMBOLS[i];
            }
        }
        return SYMBOLS[SYMBOLS.length - 1];
    }
}