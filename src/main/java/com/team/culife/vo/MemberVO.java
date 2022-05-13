package com.team.culife.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MemberVO {
	private int no;
	private long kakao_id;
	private String email;
	private String nickname;
	private int grade;
	private int warning_count;
	private String thumbnail;
	private boolean status;
	private String create_date;	
	//admin(memberList)-end_date
	private String end_date;
}