package com.team.culife.service;

import java.util.List;

import com.team.culife.vo.ExhibitionReviewVO;

public interface ExhibitionReviewService {

	// 댓글 등록하기
	public int insert_ExhibitionReview(ExhibitionReviewVO vo);
		
	// 댓글 목록보이기
	public List<ExhibitionReviewVO> select_ExhibitionReviewList(int exhibition_no);

	// 댓글 수정하기 
	public int update_ExhibitionReview(ExhibitionReviewVO vo);
		
	// 댓글 삭제하기
	public int delete_ExhibitionReview(int exhibition_no, int member_no);

}

