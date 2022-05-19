package com.team.culife.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.team.culife.vo.MovieReviewVO;

@Mapper
@Repository
public interface MovieReviewDAO {
	public int MreviewWrite(MovieReviewVO vo);
	public List<MovieReviewVO> MreviewList(int movie_id);
	public int MreviewEdit(MovieReviewVO vo);
	public int MreviewDel(int no, int member_no);
	public double MstarAvg(int movie_id);
	public int MreviewCnt(int movie_id);
	int oxMReview(int member_no, int movie_id);
}
