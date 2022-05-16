package com.team.culife.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AuthorVO {
	int no;
	int member_no;
	String author;
	String sns_link;
	String author_thumbnail;
	int debut_year;
	String create_date;
	int author_status;
	String msg;
	String author_msg;
}
