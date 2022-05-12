package com.team.culife.service;

import java.util.List;

import com.team.culife.vo.ReviewVO;

public interface ReviewService {
	public int reviewWrite(ReviewVO vo);
	public List<ReviewVO> reviewList(String title);
	public int reviewEdit(ReviewVO vo);
	public int reviewDel(int no, int member_no);
}
