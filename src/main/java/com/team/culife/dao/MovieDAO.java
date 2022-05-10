package com.team.culife.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.team.culife.vo.MovieVO;
import com.team.culife.vo.PagingVO;

@Mapper
@Repository
public interface MovieDAO {
	public List<MovieVO> movieReviewSelectByMemberNo(PagingVO vo);

}
