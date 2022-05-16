package com.team.culife.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.team.culife.dao.ReviewDAO;
import com.team.culife.vo.ReviewVO;

@Service
public class ReviewServiceImpl implements ReviewService{
	@Autowired
	ReviewDAO dao;

	@Override
	public int reviewWrite(ReviewVO vo) {
		return dao.reviewWrite(vo);
	}

	@Override
	public List<ReviewVO> reviewList(String title) {
		return dao.reviewList(title);
	}

	@Override
	public int reviewEdit(ReviewVO vo) {
		return dao.reviewEdit(vo);
	}

	
	@Override
	public int reviewDel(int no, int member_no) {
		return dao.reviewDel(no, member_no);
	}

	@Override
	public double starAvg(String title) {
		return dao.starAvg(title);
	}

	@Override
	public int oxReview(int member_no,String title) {
		return dao.oxReview(member_no,title);
	}

	@Override
	public int reviewCnt(String title) {
		return dao.reviewCnt(title);
	}
	
}
