package com.team.culife.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.team.culife.vo.PagingVO;
import com.team.culife.vo.ReviewVO;

@Mapper
@Repository
public interface ReviewDAO {
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
