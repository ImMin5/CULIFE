package com.team.culife.dao;

import org.apache.ibatis.annotations.Mapper;

import com.team.culife.vo.AuthorVO;

@Mapper
public interface AuthorDAO {
	public AuthorVO authorSelectByName(String author);

}
