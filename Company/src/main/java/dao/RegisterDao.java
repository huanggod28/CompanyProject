package dao;


import model.Register;

public interface RegisterDao {
	//create
	void addRegister(String name,String username,String password,String phone,String email,String genger,String address);
	void addRegister(Register r);
	//read
	Register findUsernameAndPassword(String username,String password);
	boolean findByUsername(String username);
	Register selectMember(int id); //select * from member where id=?
	//update
	void updateRegister(int id,String name,String password,String address,String phone);
	
	//delete
}
