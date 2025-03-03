package dao;

import java.util.List;

import model.Member;

public interface MemberDao {
	//create
	void addMember(String name,String username, String password,String address,String phone);
	void addMember(Member m);//inject 注入
	
	//read
	List<Member> allMember(); //select * from member
	Member selectMember(int id); //select * from member where id=?
	
	//update
	void updateMember(int id,String name,String password,String address,String phone);
	
	//delete
	void deleteMember(int id);
}
