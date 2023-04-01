package model;

import java.util.Date;

public class UsersDonation {
	private String name, phone, email, bank, transactionId, userDonationStatus, donationTitle;
	private Date donationDate;
	private int donationId, userDonationId;
	private Float donationAmount;

	public UsersDonation() {
	}	
	
	public UsersDonation(String email) {
		super();
		this.email = email;
	}
	
	public UsersDonation(String name, String email, String phone, String bank, String transactionId, Float donationAmount, int donationId) {
		super();
		this.name = name;
		this.phone = phone;
		this.email = email;
		this.bank = bank;
		this.transactionId = transactionId;
		this.donationId = donationId;
		this.donationAmount = donationAmount;
	}	

	public UsersDonation(String userDonationStatus, int userDonationId) {
		super();
		this.userDonationStatus = userDonationStatus;
		this.userDonationId = userDonationId;
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

	public String getBank() {
		return bank;
	}

	public void setBank(String bank) {
		this.bank = bank;
	}

	public String getTransactionId() {
		return transactionId;
	}

	public void setTransactionId(String transactionId) {
		this.transactionId = transactionId;
	}

	public Float getDonationAmount() {
		return donationAmount;
	}

	public void setDonationAmount(Float donationAmount) {
		this.donationAmount = donationAmount;
	}

	public Date getDonationDate() {
		return donationDate;
	}

	public void setDonationDate(Date donationDate) {
		this.donationDate = donationDate;
	}

	public String getUserDonationStatus() {
		return userDonationStatus;
	}

	public void setUserDonationStatus(String userDonationStatus) {
		this.userDonationStatus = userDonationStatus;
	}

	public int getDonationId() {
		return donationId;
	}

	public void setDonationId(int donationId) {
		this.donationId = donationId;
	}

	public String getDonationTitle() {
		return donationTitle;
	}

	public void setDonationTitle(String donationTitle) {
		this.donationTitle = donationTitle;
	}

	public int getUserDonationId() {
		return userDonationId;
	}

	public void setUserDonationId(int userDonationId) {
		this.userDonationId = userDonationId;
	}		
}