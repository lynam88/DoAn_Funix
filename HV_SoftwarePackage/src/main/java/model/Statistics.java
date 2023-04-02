package model;

public class Statistics {	
	private int totalUsers, totalDonations;
	private Float totalDonationAmount, todayDonationAmount;

	public Statistics() {
	}

	public Statistics(int totalUsers, int totalDonations, Float totalDonationAmount, Float todayDonationAmount) {
		super();
		this.totalUsers = totalUsers;
		this.totalDonations = totalDonations;
		this.totalDonationAmount = totalDonationAmount;
		this.todayDonationAmount = todayDonationAmount;
	}

	public int getTotalUsers() {
		return totalUsers;
	}

	public void setTotalUsers(int totalUsers) {
		this.totalUsers = totalUsers;
	}

	public int getTotalDonations() {
		return totalDonations;
	}

	public void setTotalDonations(int totalDonations) {
		this.totalDonations = totalDonations;
	}

	public Float getTotalDonationAmount() {
		return totalDonationAmount;
	}

	public void setTotalDonationAmount(Float totalDonationAmount) {
		this.totalDonationAmount = totalDonationAmount;
	}

	public Float getTodayDonationAmount() {
		return todayDonationAmount;
	}

	public void setTodayDonationAmount(Float todayDonationAmount) {
		this.todayDonationAmount = todayDonationAmount;
	}	
	
	
}