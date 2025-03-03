package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DbConnection {

	public static void main(String[] args) {
		System.out.println(DbConnection.getDB());
	}
	
	public static Connection getDB()  //將連線建成method
	{
		String url="jdbc:mysql://huanggod.myddns.me:3306/company";
		String user="root";
		String password="qq930828";
		Connection conn=null;  //連線成功傳回記憶體位置;失敗回傳null
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn=DriverManager.getConnection(url, user, password);			
			System.out.println("Connection success");
		}
		catch (ClassNotFoundException e) {
				System.out.println("no driver");
				e.printStackTrace();
			}
		catch (SQLException e) {
			System.out.println("no connection");	
			e.printStackTrace();
			}
		return conn;
	}

}
