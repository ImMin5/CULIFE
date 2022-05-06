package com.team.culife.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.team.culife.vo.AuthorVO;
import com.team.culife.vo.ExhibitionVO;

@Mapper
public interface AuthorDAO {
	public AuthorVO authorSelectByName(String author);
	// 작가등록
	public int authorWrite(ExhibitionVO vo);
	public void authorWriteOk(Map<String, Object> map);
	public ExhibitionVO authorSelect(String author);
	public String authorCheck(String author);
}
