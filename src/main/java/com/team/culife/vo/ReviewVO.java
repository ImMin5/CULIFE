package com.team.culife.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter

public class ReviewVO {
	private int no;
	private String title;
	private int member_no;
	private String content;
	private int score_star;
	private String write_date;
	private int spo_check;
	private int warning_count;
}
