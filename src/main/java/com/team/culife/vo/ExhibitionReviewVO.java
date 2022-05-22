package com.team.culife.vo;

import java.util.List;

public class ExhibitionReviewVO {

	private int exhibition_no;
	private int no;
	private int member_no;
	private String content;
	private String write_date;
	private List<Integer> exhibition_noList;
	private String nickname;
	private String subject;
	
	public int getExhibition_no() {
		return exhibition_no;
	}
	public void setExhibition_no(int exhibition_no) {
		this.exhibition_no = exhibition_no;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public int getMember_no() {
		return member_no;
	}
	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWrite_date() {
		return write_date;
	}
	public void setWrite_date(String write_date) {
		this.write_date = write_date;
	}
	public List<Integer> getExhibition_noList() {
		return exhibition_noList;
	}
	public void setExhibition_noList(List<Integer> exhibition_noList) {
		this.exhibition_noList = exhibition_noList;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	
}