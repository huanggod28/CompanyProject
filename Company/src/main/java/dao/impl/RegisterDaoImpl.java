package dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import dao.DbConnection;
import dao.RegisterDao;
import model.Register;

public class RegisterDaoImpl implements RegisterDao {

	public static void main(String[] args) {
		//new RegisterDaoImpl().addRegister("huanggg", "huangGod","1234","344342","1234567890","3433","4342");
		System.out.println("success");
	}
	private static Connection conn=DbConnection.getDB();
	@Override
	public void addRegister(String name, String username, String password, String phone, String email, String genger,
			String address) {
		String SQL="insert into register(name,username,password,phone,email,genger,address) "
				+ "values(?,?,?,?,?,?,?)";
		
		try {
			PreparedStatement ps=conn.prepareStatement(SQL);
			ps.setString(1, name);
			ps.setString(2, username);
			ps.setString(3, password);
			ps.setString(4, phone);
			ps.setString(5, email);
			ps.setString(6, genger);
			ps.setString(7, address);
			
			ps.execute();
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
	}

	@Override
	public void addRegister(Register r) {
		
		
	}

	@Override
	public Register findUsernameAndPassword(String username, String password) {
	    String SQL="select * from register where username=? and password=?";
	    Register register=null;
	    try {
	        PreparedStatement PreparedStatement=conn.prepareStatement(SQL);
	        PreparedStatement.setString(1, username);
	        PreparedStatement.setString(2, password);
	        ResultSet resultSet=PreparedStatement.executeQuery();
	        
	        if(resultSet.next())
	        {
	            register=new Register();
	            register.setId(resultSet.getInt("id"));
	            register.setName(resultSet.getString("name"));
	            register.setUsername(resultSet.getString("username"));
	            register.setPassword(resultSet.getString("password"));
	            register.setPhone(resultSet.getString("phone"));
	            register.setEmail(resultSet.getString("email"));                
	            register.setGenger(resultSet.getString("genger"));
	            register.setAddress(resultSet.getString("address"));
	            register.setWhitelist(resultSet.getBoolean("is_whitelist")); // ✅ 新增
	        }
	        
	    }catch (SQLException e) {
	        e.printStackTrace();
	    }
	    
	    return register;
	}

	@Override
	public boolean findByUsername(String username) {
		String SQL="select * from register where username=?";
		boolean isUsernameBeenUse=false;
		try {
			PreparedStatement preparedStatement=conn.prepareStatement(SQL);
			preparedStatement.setString(1,username);
			ResultSet resultSet=preparedStatement.executeQuery();
			
			if(resultSet.next()) isUsernameBeenUse=true;
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return isUsernameBeenUse;
	}

	@Override
	public Register selectMember(int id) {
		String SQL="select * from member where id=?";
		Register m=null;
		
		try {
			PreparedStatement ps=conn.prepareStatement(SQL);
			ps.setInt(1, id);
			ResultSet rs=ps.executeQuery();
			
			if(rs.next())
			{
				m=new Register();
				m.setId(rs.getInt("id"));
				m.setName(rs.getString("name"));
				m.setUsername(rs.getString("username"));
				m.setPassword(rs.getString("password"));
				m.setAddress(rs.getString("address"));
				m.setPhone(rs.getString("phone"));
			}
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return m;
	}

	@Override
	public void updateRegister(int id, String name, String password, String address, String phone) {
		// TODO Auto-generated method stub
		
	}

}
