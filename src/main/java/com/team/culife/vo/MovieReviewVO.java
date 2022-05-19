package com.team.culife.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MovieReviewVO {
	private int no;
	private int movie_id;
	private int member_no;
	private String nickname;
	private String movie_title;
	private String content;
	private int score_star;
	private String poster_path;
	private String write_date;
	private int spo_check;
	private int vote_count;
}
