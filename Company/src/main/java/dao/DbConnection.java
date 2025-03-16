package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DbConnection {
    private static final String URL = "jdbc:mysql://huanggod.myddns.me:3306/company";
    private static final String USER = "root";
    private static final String PASSWORD = "qq930828";

    private static Connection connection = null;

    // 取得資料庫連線 (單例模式)
    public static Connection getDB() {
        if (connection == null) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                connection = DriverManager.getConnection(URL, USER, PASSWORD);
                System.out.println("連線成功.");
            } catch (ClassNotFoundException e) {
                System.out.println("未找到連線.");
                e.printStackTrace();
            } catch (SQLException e) {
                System.out.println("連線失敗.");
                e.printStackTrace();
            }
        }
        return connection;
    }

    // 檢查連線是否有效
    public static boolean isConnectionValid() {
        try {
            if (connection != null && !connection.isClosed()) {
                return true; // 連線有效
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false; // 連線無效
    }

    // 關閉資料庫連線
    public static void closeDB() {
        if (connection != null) {
            try {
                connection.close();
                System.out.println("Database connection closed.");
                connection = null; // 確保變數重置
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // 測試方法
    public static void main(String[] args) {
        Connection conn = DbConnection.getDB();
        System.out.println("Is connection valid? " + DbConnection.isConnectionValid());
        DbConnection.closeDB(); // 測試完後關閉連線
    }
}