package model;

import java.util.Date;

public class Donations {
	private int id;
	private int status;
	private String title;
	private String content;
	private Date startDate;
	private Date endDate;
	private Float totalNeeded;
	
	public Donations() {
		super();
	}	

	public Donations(int id) {
		super();
		this.id = id;
	}

	public Donations(int status, String title, String content, Date startDate, Date endDate, Float totalNeeded) {
		super();
		this.status = status;
		this.title = title;
		this.content = content;
		this.startDate = startDate;
		this.endDate = endDate;
		this.totalNeeded = totalNeeded;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
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

	public Float getTotalNeeded() {
		return totalNeeded;
	}

	public void setTotalNeeded(Float totalNeeded) {
		this.totalNeeded = totalNeeded;
	}

		
}
