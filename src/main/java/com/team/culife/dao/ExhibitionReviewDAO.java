package com.team.culife.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.team.culife.vo.ExhibitionReviewVO;
import com.team.culife.vo.PagingVO;

@Mapper
@Repository
public interface ExhibitionReviewDAO {

	// 댓글 등록하기
	public int insert_ExhibitionReview(ExhibitionReviewVO vo);
			
	// 댓글 목록보이기
	public List<ExhibitionReviewVO> select_ExhibitionReviewList(int no);

	// 댓글 수정하기 
	public int update_ExhibitionReview(ExhibitionReviewVO vo);
			
	// 댓글 삭제하기
	public int delete_ExhibitionReview(int exhibition_no, int member_no);
	
	public int exhibitionReviewTotalRecord(PagingVO vo);
	public List<ExhibitionReviewVO> exhibitionReviewSelectByMemberNo(PagingVO vo);

}
