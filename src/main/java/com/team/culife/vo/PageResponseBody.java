package com.team.culife.vo;

import java.util.HashMap;
import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PageResponseBody<T> {
	private PagingVO vo;
	private List<T> items;
	private HashMap<String,String> msg;
}
