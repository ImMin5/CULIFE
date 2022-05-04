package com.team.culife.vo;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PageResponseBody<T> {
	private PagingVO vo;
	private List<T> items;
}
