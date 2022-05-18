package com.team.culife.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AuthorVO {
	private int no;
	private int member_no;
	private String author;
	private String sns_link;
	private String author_thumbnail;
	private int debut_year;
	private String create_date;
	private String nickname;
	private Integer author_status;
	private String msg;
	private String author_msg;
}
