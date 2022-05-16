package com.team.culife.service;

import java.util.List;

import com.team.culife.vo.MovieVO;
import com.team.culife.vo.PagingVO;

public interface MovieService {
	public List<MovieVO> movieReviewSelectByMemberNo(PagingVO vo);
	public int movieReviewTotalRecord(PagingVO vo);
}
