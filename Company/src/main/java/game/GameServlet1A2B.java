package game;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpSession;
import java.util.*;

@WebServlet("/GameServlet1A2B")
public class GameServlet1A2B extends HttpServlet {
    private static final String GAME_KEY = "gameNumber";  // 存放正確答案
    private static final String GUESSES_KEY = "guesses";  // 存放猜測紀錄
    private static final String ATTEMPT_KEY = "attemptCount"; // 記錄猜測次數
    private static final String SHOW_ANSWER_KEY = "showAnswer"; // 是否顯示答案

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String action = request.getParameter("action");

        if ("start".equals(action)) {
            startGame(session);
        } else if ("guess".equals(action)) {
            processGuess(request, session);
        } else if ("showAnswer".equals(action)) {
            session.setAttribute(SHOW_ANSWER_KEY, true);
        }

        // 轉發到 JSP 頁面
        RequestDispatcher dispatcher = request.getRequestDispatcher("/game/1A2Bgame/game1A2B.jsp");
        dispatcher.forward(request, response);
    }

    // 初始化遊戲（產生新隨機數，重置紀錄）
    private void startGame(HttpSession session) {
        String randomNumber = generateRandomNumber();
        session.setAttribute(GAME_KEY, randomNumber);
        session.setAttribute(GUESSES_KEY, new ArrayList<String>());
        session.setAttribute(ATTEMPT_KEY, 0); // 重置猜測次數
        session.setAttribute(SHOW_ANSWER_KEY, false); // 隱藏答案
    }

    // 處理玩家猜測
    private void processGuess(HttpServletRequest request, HttpSession session) {
        String guess = request.getParameter("guess");

        if (guess == null || guess.length() != 4 || !guess.matches("\\d{4}")) {
            return;  // 避免非數字或長度錯誤
        }

        String gameNumber = (String) session.getAttribute(GAME_KEY);
        if (gameNumber == null) {
            return;  // 確保遊戲已經開始
        }

        // 計算幾 A 幾 B
        String result = getResult(guess, gameNumber);
        List<String> guesses = (List<String>) session.getAttribute(GUESSES_KEY);
        int attemptCount = (int) session.getAttribute(ATTEMPT_KEY) + 1; // 計算第幾次猜測

        if (guesses == null) {
            guesses = new ArrayList<>();
        }

        // 加入當前猜測與結果（附上猜測次數）
        guesses.add(attemptCount + ". " + guess + " -> " + result);
        session.setAttribute(GUESSES_KEY, guesses);
        session.setAttribute(ATTEMPT_KEY, attemptCount);

        // 若猜中 4A0B，自動重新開始遊戲
        if ("4A0B".equals(result)) {
            startGame(session);
        }
    }

    // 產生 4 位不重複的隨機數
    private String generateRandomNumber() {
        List<Integer> digits = new ArrayList<>();
        for (int i = 0; i < 10; i++) {
            digits.add(i);
        }
        Collections.shuffle(digits);
        return "" + digits.get(0) + digits.get(1) + digits.get(2) + digits.get(3);
    }

    // 計算幾 A 幾 B
    private String getResult(String guess, String gameNumber) {
        int correctPosition = 0;
        int correctNumber = 0;

        for (int i = 0; i < 4; i++) {
            if (guess.charAt(i) == gameNumber.charAt(i)) {
                correctPosition++;  // 數字與位置正確
            } else if (gameNumber.contains(Character.toString(guess.charAt(i)))) {
                correctNumber++;  // 數字正確但位置錯誤
            }
        }

        return correctPosition + "A" + correctNumber + "B";
    }
}