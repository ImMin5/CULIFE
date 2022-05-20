package com.team.culife.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.team.culife.dao.MovieReviewDAO;
import com.team.culife.vo.MovieReviewVO;

@Service
public class MovieReviewServiceImpl implements MovieReviewService{
	@Autowired
	MovieReviewDAO dao;
	
	@Override
	public int MreviewWrite(MovieReviewVO vo) {
		return dao.MreviewWrite(vo);
	}

	@Override
	public List<MovieReviewVO> MreviewList(int movie_id) {
		return dao.MreviewList(movie_id);
	}

	@Override
	public int MreviewEdit(MovieReviewVO vo) {
		return dao.MreviewEdit(vo);
	}

	@Override
	public int MreviewDel(int no, int member_no) {
		return dao.MreviewDel(no, member_no);
	}

	@Override
	public double MstarAvg(int movie_id) {
		return dao.MstarAvg(movie_id);
	}

	@Override
	public int MreviewCnt(int movie_id) {
		return dao.MreviewCnt(movie_id);
	}

	@Override
	public int oxMReview(int member_no, int movie_id) {
		return dao.oxMReview(member_no, movie_id);
	}

}
