package model;

public class OwnerInformation {
	private Integer id;
	private String name;
	private String username;
	private String password;
	private String phone;
	private String email;
	private String genger;
	private String address;
	private String machine_information;
	
	public OwnerInformation() {
		super();
	}

	public OwnerInformation(Integer id, String name, String username, String password, String phone, String email,
			String genger, String address, String machine_information) {
		super();
		this.id = id;
		this.name = name;
		this.username = username;
		this.password = password;
		this.phone = phone;
		this.email = email;
		this.genger = genger;
		this.address = address;
		this.machine_information = machine_information;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getGenger() {
		return genger;
	}

	public void setGenger(String genger) {
		this.genger = genger;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getMachine_information() {
		return machine_information;
	}

	public void setMachine_information(String machine_information) {
		this.machine_information = machine_information;
	}
	
}
