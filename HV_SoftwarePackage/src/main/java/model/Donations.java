package model;

import java.sql.Date;

public class Donations {
	private int donationId;
	private String donationName;
	private String donationContent;
	private Date startDate;
	private Date endDate;
	private float totalNeeded;
	
	public Donations() {
		super();
	}

	public int getDonationId() {
		return donationId;
	}

	public void setDonationId(int donationId) {
		this.donationId = donationId;
	}

	public String getDonationName() {
		return donationName;
	}

	public void setDonationName(String donationName) {
		this.donationName = donationName;
	}

	public String getDonationContent() {
		return donationContent;
	}

	public void setDonationContent(String donationContent) {
		this.donationContent = donationContent;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public float getTotalNeeded() {
		return totalNeeded;
	}

	public void setTotalNeeded(float totalNeeded) {
		this.totalNeeded = totalNeeded;
	}	
}
