package game;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.LinkedList;
import java.util.Queue;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

@WebServlet("/TicTacToeServlet")
public class TicTacToeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private GameState gameState;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");

        if ("init".equals(action)) {
            // 初始化遊戲
            gameState = new GameState();
            String jsonResponse = new Gson().toJson(gameState);
            response.getWriter().write(jsonResponse);

        } else if ("move".equals(action)) {
            // 處理玩家移動
            int row = Integer.parseInt(request.getParameter("row"));
            int col = Integer.parseInt(request.getParameter("col"));

            // 處理移動邏輯
            if (gameState != null && !gameState.isGameOver()) {
                gameState.makeMove(row, col);
                String jsonResponse = new Gson().toJson(gameState);
                response.getWriter().write(jsonResponse);
            }

        } else if ("reset".equals(action)) {
            // 重置遊戲
            gameState = new GameState();
            String jsonResponse = new Gson().toJson(gameState);
            response.getWriter().write(jsonResponse);
        }
    }

    // GameState 類別
    public static class GameState {
        private String[][] board;
        private String currentPlayer;
        private boolean gameOver;

        public GameState() {
            this.board = new String[3][3];
            this.currentPlayer = "X";
            this.gameOver = false;
            // 初始化棋盤
            for (int i = 0; i < 3; i++) {
                for (int j = 0; j < 3; j++) {
                    board[i][j] = "";  // 空格初始化
                }
            }
        }

        public String[][] getBoard() {
            return board;
        }

        public String getCurrentPlayer() {
            return currentPlayer;
        }

        public boolean isGameOver() {
            return gameOver;
        }

        public void makeMove(int row, int col) {
            if (board[row][col].isEmpty()) {
                board[row][col] = currentPlayer;
                // 檢查是否贏得遊戲
                if (checkWin()) {
                    gameOver = true;
                } else {
                    // 換下一個玩家
                    currentPlayer = currentPlayer.equals("X") ? "O" : "X";
                }
            }
        }

        private boolean checkWin() {
            // 檢查行、列和對角線
            for (int i = 0; i < 3; i++) {
                if (board[i][0].equals(currentPlayer) && board[i][1].equals(currentPlayer) && board[i][2].equals(currentPlayer)) {
                    return true;
                }
                if (board[0][i].equals(currentPlayer) && board[1][i].equals(currentPlayer) && board[2][i].equals(currentPlayer)) {
                    return true;
                }
            }
            if (board[0][0].equals(currentPlayer) && board[1][1].equals(currentPlayer) && board[2][2].equals(currentPlayer)) {
                return true;
            }
            if (board[0][2].equals(currentPlayer) && board[1][1].equals(currentPlayer) && board[2][0].equals(currentPlayer)) {
                return true;
            }
            return false;
        }
    }
}