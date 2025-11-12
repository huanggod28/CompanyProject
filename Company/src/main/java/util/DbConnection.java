package util;

import java.sql.Connection;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class DbConnection {

    public static Connection getDB() {
        try {
            Context initCtx = new InitialContext();
            DataSource ds = (DataSource) initCtx.lookup("java:comp/env/jdbc/MyDB");
            return ds.getConnection(); // 每次取一條新連線（連線池中取出）
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}