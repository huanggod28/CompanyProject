package util;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/game")
public class GameServlet extends HttpServlet {
    // 取得遊戲的初始棋盤
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        int[][] grid = (int[][]) session.getAttribute("grid");

        // 如果沒有存儲棋盤，就初始化一個新的棋盤
        if (grid == null) {
            grid = new int[4][4];
            session.setAttribute("grid", grid);
        }

        request.setAttribute("grid", grid);
        request.getRequestDispatcher("game/2048game/game.jsp").forward(request, response);
    }

    // 處理用戶的操作，更新棋盤
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        int[][] grid = (int[][]) session.getAttribute("grid");

        // 根據方向參數更新棋盤
        String direction = request.getParameter("direction");
        if (direction != null) {
            // 根據方向處理移動邏輯
            switch (direction) {
                case "up":
                    moveUp(grid);
                    break;
                case "down":
                    moveDown(grid);
                    break;
                case "left":
                    moveLeft(grid);
                    break;
                case "right":
                    moveRight(grid);
                    break;
            }
        }

        session.setAttribute("grid", grid);
        response.sendRedirect("game.jsp");
    }

    // 向左移動邏輯
    private void moveLeft(int[][] grid) {
        for (int row = 0; row < 4; row++) {
            int[] newRow = new int[4];
            int pos = 0;

            // 合併數字
            for (int col = 0; col < 4; col++) {
                if (grid[row][col] != 0) {
                    if (pos > 0 && newRow[pos - 1] == grid[row][col]) {
                        newRow[pos - 1] *= 2;
                    } else {
                        newRow[pos] = grid[row][col];
                        pos++;
                    }
                }
            }

            // 將合併後的結果放回原始棋盤
            grid[row] = newRow;
        }
    }

    // 向右移動邏輯
    private void moveRight(int[][] grid) {
        for (int row = 0; row < 4; row++) {
            int[] newRow = new int[4];
            int pos = 3;

            // 合併數字
            for (int col = 3; col >= 0; col--) {
                if (grid[row][col] != 0) {
                    if (pos < 3 && newRow[pos + 1] == grid[row][col]) {
                        newRow[pos + 1] *= 2;
                    } else {
                        newRow[pos] = grid[row][col];
                        pos--;
                    }
                }
            }

            // 將合併後的結果放回原始棋盤
            grid[row] = newRow;
        }
    }

    // 向上移動邏輯
    private void moveUp(int[][] grid) {
        for (int col = 0; col < 4; col++) {
            int[] newCol = new int[4];
            int pos = 0;

            // 合併數字
            for (int row = 0; row < 4; row++) {
                if (grid[row][col] != 0) {
                    if (pos > 0 && newCol[pos - 1] == grid[row][col]) {
                        newCol[pos - 1] *= 2;
                    } else {
                        newCol[pos] = grid[row][col];
                        pos++;
                    }
                }
            }

            // 將合併後的結果放回原始棋盤
            for (int row = 0; row < 4; row++) {
                grid[row][col] = newCol[row];
            }
        }
    }

    // 向下移動邏輯
    private void moveDown(int[][] grid) {
        for (int col = 0; col < 4; col++) {
            int[] newCol = new int[4];
            int pos = 3;

            // 合併數字
            for (int row = 3; row >= 0; row--) {
                if (grid[row][col] != 0) {
                    if (pos < 3 && newCol[pos + 1] == grid[row][col]) {
                        newCol[pos + 1] *= 2;
                    } else {
                        newCol[pos] = grid[row][col];
                        pos--;
                    }
                }
            }

            // 將合併後的結果放回原始棋盤
            for (int row = 0; row < 4; row++) {
                grid[row][col] = newCol[row];
            }
        }
    }
}