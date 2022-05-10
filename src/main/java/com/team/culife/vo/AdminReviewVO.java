package com.team.culife.vo;

import java.util.List;

public class AdminReviewVO {
	//추후 각 리뷰에 맞는 VO로 바꿔서 사용해야함.
	private String category;
	private int no;
	private String title;
	private int member_no;
	private String nickname;
	private String content;
	private int score_star;
	private String write_date;
	private int warning_count;
	//adminReviewList: 연극공연 다중삭제
	private List<Integer> noList;
	//adminReviewList: 영화 다중삭제
	private List<Integer> movie_noList;
	
	//감상평관리
	private String subject;
	
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getMember_no() {
		return member_no;
	}
	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getScore_star() {
		return score_star;
	}
	public void setScore_star(int score_star) {
		this.score_star = score_star;
	}
	public String getWrite_date() {
		return write_date;
	}
	public void setWrite_date(String write_date) {
		this.write_date = write_date;
	}
	public int getWarning_count() {
		return warning_count;
	}
	public void setWarning_count(int warning_count) {
		this.warning_count = warning_count;
	}
	public List<Integer> getNoList() {
		return noList;
	}
	public void setNoList(List<Integer> noList) {
		this.noList = noList;
	}
	public List<Integer> getMovie_noList() {
		return movie_noList;
	}
	public void setMovie_noList(List<Integer> movie_noList) {
		this.movie_noList = movie_noList;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	
	
	
}
