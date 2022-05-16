package com.team.culife.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.team.culife.dao.MovieDAO;
import com.team.culife.vo.MovieVO;
import com.team.culife.vo.PagingVO;

@Service
public class MovieServiceImpl implements MovieService {
	@Inject
	MovieDAO dao;
	
	@Override
	public List<MovieVO> movieReviewSelectByMemberNo(PagingVO vo) {
		return dao.movieReviewSelectByMemberNo(vo);
	}

	@Override
	public int movieReviewTotalRecord(PagingVO vo) {
		return dao.movieReviewTotalRecord(vo);
	}
	
	
}
