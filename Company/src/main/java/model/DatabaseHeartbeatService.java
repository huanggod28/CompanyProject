package model;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import dao.DbConnection;

public class DatabaseHeartbeatService {

    private static final ScheduledExecutorService scheduler = Executors.newScheduledThreadPool(1);
    private static Connection conn = DbConnection.getDB(); // 初始資料庫連接

    // 啟動定時心跳檢查任務
    public static void startHeartbeatTask() {
        // 每 60 秒執行一次 sendHeartbeat 方法
        scheduler.scheduleAtFixedRate(() -> {
            sendHeartbeat();
        }, 0, 60, TimeUnit.SECONDS);  // 初始延遲0秒，每60秒執行一次
    }

    // 執行心跳檢查
    private static void sendHeartbeat() {
        try {
            if (!DbConnection.isConnectionValid(conn)) {
                // 如果連接無效，則重新建立連接
                System.out.println("Connection is invalid. Reconnecting...");
                conn = DbConnection.getDB(); // 重新建立連接
            }
            // 發送簡單查詢來保持連接
            conn.createStatement().executeQuery("SELECT 1");
            System.out.println("Database heartbeat sent successfully.");
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Error while sending heartbeat: " + e.getMessage());
        }
    }

    // 停止定時任務
    public static void stopHeartbeatTask() {
        scheduler.shutdown();
    }

    // 主方法示範啟動心跳任務
    public static void main(String[] args) {
        startHeartbeatTask(); // 啟動心跳任務
    }
}