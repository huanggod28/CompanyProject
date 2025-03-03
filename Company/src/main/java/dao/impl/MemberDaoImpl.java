package dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dao.DbConnection;
import dao.MemberDao;
import model.Member;

public class MemberDaoImpl implements MemberDao{

	public static void main(String[] args) {
		//new MemberDaoImpl().addMember("huanggg", "huangGod","1234","台北市","1234567890");//create
		//new MemberDaoImpl().addMember(new Member("huag", "hugGod","1230","台北市","1234567890"));;//create 注入
		/*List<Member> l=new MemberDaoImpl().allMember(); //read all
		for(Member m:l)
		{
			System.out.println(m.getId()+
					"\t"+m.getName()+
					"\t"+m.getUsername()+
					"\t"+m.getPassword()+
					"\t"+m.getAddress()+
					"\t"+m.getPhone());
		}*/
		/*Member m=new MemberDaoImpl().selectMember(1); //read 1 ()內填入id可找那筆資料
		System.out.println(m.getId()+
				"\t"+m.getName()+
				"\t"+m.getUsername()+
				"\t"+m.getPassword()+
				"\t"+m.getAddress()+
				"\t"+m.getPhone());*/
		//new MemberDaoImpl().updateMember(1, "hhh", "1234", "台北市", "23265413");//update
		new MemberDaoImpl().deleteMember(1); //delete
		
		System.out.println("success");
	
	}
	private static Connection conn=DbConnection.getDB();//使用之前建立的連線method

	@Override
	public void addMember(String name, String username, String password, String address, String phone) {
		String SQL="insert into member(name,username,password,address,phone) "
				+ "values(?,?,?,?,?)";
		try {
			PreparedStatement ps=conn.prepareStatement(SQL);
			ps.setString(1, name);
			ps.setString(2, username);
			ps.setString(3, password);
			ps.setString(4, address);
			ps.setString(5, phone);
			
			ps.execute();
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
	}

	@Override
	public List<Member> allMember() {   //read all
		String SQL="select * from member";
		List<Member> l=new ArrayList();
		
		try {
			PreparedStatement ps=conn.prepareStatement(SQL);
			ResultSet rs=ps.executeQuery();
			while(rs.next())
			{
				Member m=new Member();		
				m.setId(rs.getInt("id")); //放入資料
				m.setName(rs.getString("name"));
				m.setUsername(rs.getString("username"));
				m.setPassword(rs.getString("password"));
				m.setAddress(rs.getString("address"));
				m.setPhone(rs.getString("phone"));
				l.add(m);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return l;
	}

	@Override
	public Member selectMember(int id) {  //read 1
		String SQL="select * from member where id=?";
		Member m=null;
		
		try {
			PreparedStatement ps=conn.prepareStatement(SQL);
			ps.setInt(1, id);
			ResultSet rs=ps.executeQuery();
			
			if(rs.next())
			{
				m=new Member();
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
	public void addMember(Member m) {  //create 注入
		String SQL="insert into member(name,username,password,address,phone) "
				+ "values(?,?,?,?,?)";
		try {
			PreparedStatement ps=conn.prepareStatement(SQL);
			ps.setString(1, m.getName());
			ps.setString(2, m.getUsername());
			ps.setString(3, m.getPassword());
			ps.setString(4, m.getAddress());
			ps.setString(5, m.getPhone());
			
			ps.execute();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}

	@Override
	public void updateMember(int id, String name, String password, String address, String phone) { //update
		String SQL="update member set name=?,password=?,address=?,phone=? where id=?";
		try {
			PreparedStatement ps=conn.prepareStatement(SQL);
			ps.setString(1, name);
			ps.setString(2, password);
			ps.setString(3, address);
			ps.setString(4, phone);
			ps.setInt(5, id);
			ps.execute();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		
	}

	@Override
	public void deleteMember(int id) { //delete
		String SQL="delete from member where id=?";
		
		try {
			PreparedStatement ps=conn.prepareStatement(SQL);
			ps.setInt(1, id);
			ps.executeUpdate();
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
		
	}

}
