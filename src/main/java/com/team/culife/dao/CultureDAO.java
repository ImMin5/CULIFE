package com.team.culife.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.team.culife.vo.CultureVO;

@Mapper
@Repository
public interface CultureDAO {
	//연극목록
	public List<CultureVO> playList(String mt20id);
	
	//뮤지컬목록
	public List<CultureVO> musicalList(String mt20id);
	
	//게시물 선택
	public CultureVO cultureSelect(int no);
}
