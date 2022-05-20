package com.team.culife.vo;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ExhibitionWorkVO {
	private int no;
	private int author_no;
	private String subject;
	private String content;
	private String start_date;
	private String end_date;
	private String create_date;
	private int type;
	private List<WorkVO> workList;
	private int member_no;
	private String author;
}
