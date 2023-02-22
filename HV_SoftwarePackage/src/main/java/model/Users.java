package model;

import java.util.Date;

public class Users {
	private String name, phone, email, avatarPath, address, password;
	private Date registrationDate;
	private int role, status;

	public Users() {
	}	

	public Users(int role) {
		super();
		this.role = role;
	}
	
	public Users(String email) {
		super();
		this.email = email;
	}	

	public Users(String name, String phone, String email, String avatarPath, String address, String password) {
		super();
		this.name = name;
		this.phone = phone;
		this.email = email;
		this.avatarPath = avatarPath;
		this.address = address;
		this.password = password;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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
	
	public String getAvatarPath() {
		return avatarPath;
	}

	public void setAvatarPath(String avatarPath) {
		this.avatarPath = avatarPath;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}
	
	public void setRegistrationDate(Date registrationDate) {
		this.registrationDate = registrationDate;
	}
	
	public String getPassword() {
		return password;
	}	

	public void setPassword(String password) {
		this.password = password;
	}

	public Date getRegistrationDate() {
		return registrationDate;
	}

	public int getRole() {
		return role;
	}

	public void setRole(int role) {
		this.role = role;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}	
	
}