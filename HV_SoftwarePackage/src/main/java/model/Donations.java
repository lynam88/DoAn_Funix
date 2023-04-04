package model;

import java.util.Date;

public class Donations {
	private int id;
	private String status, title, content, category, src;	
	private Date startDate, endDate;
	private Float totalNeeded;
	
	public Donations() {
		super();
	}	

	public Donations(int id) {
		super();
		this.id = id;
	}
	
	public Donations(int id, String status, String title, String content, Date startDate, Date endDate,
			Float totalNeeded, String category, String src) {
		super();
		this.id = id;
		this.status = status;
		this.title = title;
		this.content = content;
		this.startDate = startDate;
		this.endDate = endDate;
		this.totalNeeded = totalNeeded;
		this.category = category;
		this.src = src;
	}

	public Donations(String status, String title, String content, Date startDate, Date endDate,
			Float totalNeeded, String category, String src) {
		super();
		this.status = status;
		this.title = title;
		this.content = content;
		this.startDate = startDate;
		this.endDate = endDate;
		this.totalNeeded = totalNeeded;
		this.category = category;
		this.src = src;
	}
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
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
	
	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getSrc() {
		return src;
	}

	public void setSrc(String src) {
		this.src = src;
	}
	
}
