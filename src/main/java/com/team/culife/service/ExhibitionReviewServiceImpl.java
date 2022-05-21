package com.team.culife.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.team.culife.dao.ExhibitionReviewDAO;
import com.team.culife.dao.ReplyDAO;
import com.team.culife.vo.ExhibitionReviewVO;
import com.team.culife.vo.PagingVO;
import com.team.culife.vo.ReplyVO;

@Service
public class ExhibitionReviewServiceImpl implements ExhibitionReviewService {

	@Inject
	ExhibitionReviewDAO dao;

	@Override
	public int insert_ExhibitionReview(ExhibitionReviewVO vo) {
		return dao.insert_ExhibitionReview(vo);
	}

	@Override
	public List<ExhibitionReviewVO> select_ExhibitionReviewList(int exhibition_no) {
		return dao.select_ExhibitionReviewList(exhibition_no);
	}

	@Override
	public int update_ExhibitionReview(ExhibitionReviewVO vo) {
		return dao.update_ExhibitionReview(vo);
	}

	@Override
	public int delete_ExhibitionReview(int exhibition_no, int member_no) {
		return dao.delete_ExhibitionReview(exhibition_no, member_no);
	}

	@Override
	public int exhibitionReviewTotalRecord(PagingVO vo) {
		return dao.exhibitionReviewTotalRecord(vo);
	}

	@Override
	public List<ExhibitionReviewVO> exhibitionReviewSelectByMemberNo(PagingVO vo) {
		return dao.exhibitionReviewSelectByMemberNo(vo);
	}

	
	
}