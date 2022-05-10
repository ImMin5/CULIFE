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
	public int reviewDel(int no, String attribute) {
		return dao.reviewDel(no, no);
	}
	
}
