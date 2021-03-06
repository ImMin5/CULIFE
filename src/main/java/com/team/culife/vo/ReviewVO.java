package com.team.culife.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter

public class ReviewVO {
	private int no;
	private String title;
	private int member_no;
	private String nickname;
	private String content;
	private int score_star;
	private String write_date;
	private int spo_check;
	private String poster;
	private int seq;
	private int review_cnt;
	private double star_avg;
}
