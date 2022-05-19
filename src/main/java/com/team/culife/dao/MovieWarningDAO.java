package com.team.culife.dao;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.team.culife.vo.MovieWarningVO;

@Mapper
@Repository
public interface MovieWarningDAO {
	public int mwarning(MovieWarningVO warning);
}
