package util;

import java.io.BufferedReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import dao.DbConnection;
import model.Leaderboard;

@WebServlet("/ScoreServlet")
public class ScoreServlet extends HttpServlet {
    private static final Connection conn = DbConnection.getDB();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        BufferedReader reader = request.getReader();
        StringBuilder jsonReceived = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) {
            jsonReceived.append(line);
        }
        System.out.println("Received JSON: " + jsonReceived.toString());  // 檢查前端傳來的 JSON

        Gson gson = new Gson();
        ScoreData data = gson.fromJson(jsonReceived.toString(), ScoreData.class);

        if (data == null || data.getPlayerName() == null || data.getScore() < 0) {
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("{\"message\":\"Invalid data.\"}");
            return;
        }

        String playerName = data.getPlayerName();
        int score = data.getScore();

        try {
            // 插入資料
            String insertSQL = "INSERT INTO leaderboard (player_name, score) VALUES (?, ?)";
            PreparedStatement insertStmt = conn.prepareStatement(insertSQL, PreparedStatement.RETURN_GENERATED_KEYS);
            insertStmt.setString(1, playerName);
            insertStmt.setInt(2, score);
            insertStmt.executeUpdate();

            // 取得 ID
            ResultSet generatedKeys = insertStmt.getGeneratedKeys();
            int id = -1;
            if (generatedKeys.next()) {
                id = generatedKeys.getInt(1);
            }
            generatedKeys.close();
            insertStmt.close();

            if (id == -1) {
                response.getWriter().write("{\"message\":\"Error saving score.\"}");
                return;
            }

            // 查詢 created_at
            String selectSQL = "SELECT created_at FROM leaderboard WHERE id = ?";
            PreparedStatement selectStmt = conn.prepareStatement(selectSQL);
            selectStmt.setInt(1, id);
            ResultSet resultSet = selectStmt.executeQuery();

            Timestamp createdAt = null;
            if (resultSet.next()) {
                createdAt = resultSet.getTimestamp("created_at");
            }
            resultSet.close();
            selectStmt.close();

            if (createdAt == null) {
                createdAt = new Timestamp(System.currentTimeMillis());
            }

            // 確保 Leaderboard 有正確的 getter 方法
            Leaderboard leaderboard = new Leaderboard(id, playerName, score, createdAt);

            // 使用 GsonBuilder 轉換為標準 JSON
            Gson gsonResponse = new GsonBuilder().setDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").create();
            String jsonResponse = gsonResponse.toJson(leaderboard);

            System.out.println("Response JSON: " + jsonResponse); // 確保 JSON 正確
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(jsonResponse);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("{\"message\":\"Error saving score.\"}");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Leaderboard> leaderboard = new ArrayList<>();
        try {
            String sql = "SELECT id, player_name, score, created_at FROM leaderboard ORDER BY score DESC LIMIT 10";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                leaderboard.add(new Leaderboard(
                        rs.getInt("id"),
                        rs.getString("player_name"),
                        rs.getInt("score"),
                        rs.getTimestamp("created_at")
                ));
            }
            stmt.close();
            rs.close();

            // 使用 GsonBuilder 設定標準日期格式，確保前端能正確解析
            Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").create();
            String jsonResponse = gson.toJson(leaderboard);

            System.out.println("Leaderboard JSON Response: " + jsonResponse);  // Debug 輸出

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(jsonResponse);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("[]"); // 返回空 JSON 陣列
        }
    }
}

// 輔助類：用於解析 JSON
class ScoreData {
    private String playerName;
    private int score;
    
    public String getPlayerName() { return playerName; }
    public int getScore() { return score; }
}