package com.team.culife.service;

import java.util.List;

import com.team.culife.vo.PagingVO;
import com.team.culife.vo.ReviewVO;

public interface ReviewService {
	public int reviewWrite(ReviewVO vo);
	public List<ReviewVO> reviewList(String title);
	public int reviewEdit(ReviewVO vo);
	public int reviewDel(int no, int member_no);
	public double starAvg(String title);
	public int reviewCnt(String title);
	int oxReview(int member_no,String title);
	
	public int theaterReviewTotalRecord(PagingVO vo);
	public List<ReviewVO>theaterReviewSelectByMemberNo(PagingVO vo);
}
