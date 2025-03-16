package model;

import java.sql.Timestamp;

public class Leaderboard {
    private int id;
    private String playerName;
    private int score;
    private Timestamp createdAt;

    // ✅ 無參數建構子（必須有，JSP/Servlet 需要）
    public Leaderboard() {}

    // ✅ 帶參數建構子
    public Leaderboard(int id, String playerName, int score, Timestamp createdAt) {
        this.id = id;
        this.playerName = playerName;
        this.score = score;
        this.createdAt = createdAt;
    }

    // ✅ Getter & Setter
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getPlayerName() { return playerName; }
    public void setPlayerName(String playerName) { this.playerName = playerName; }

    public int getScore() { return score; }
    public void setScore(int score) { this.score = score; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    // ✅ toString 方法，方便除錯
    @Override
    public String toString() {
        return "Leaderboard{" +
                "id=" + id +
                ", playerName='" + playerName + '\'' +
                ", score=" + score +
                ", createdAt=" + createdAt +
                '}';
    }
}