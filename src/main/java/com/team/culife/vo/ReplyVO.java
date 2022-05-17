package com.team.culife.vo;

import java.util.List;

public class ReplyVO {

	private int reply_no;
	private int no;
	private int member_no;
	private String content;
	private String write_date;
	private List<Integer> replynoList;
	private String nickname;
	
	public int getReply_no() {
		return reply_no;
	}
	public void setReply_no(int reply_no) {
		this.reply_no = reply_no;
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
	public List<Integer> getReplynoList() {
		return replynoList;
	}
	public void setReplynoList(List<Integer> replynoList) {
		this.replynoList = replynoList;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	
}